@lineGraph = (data) ->
  # convert the data that was given as a string into an array
  data = JSON.parse data

  # clear out the container
  $('#line-graph').html '<svg></svg>'

  # m = margin. w = width. h = height
  m = [10, 50, 35, 35]
  w = $('#line-graph').width() - m[1] - m[3]
  h = 300 - m[0] - m[2]

  # x and y are functions that turn data into x and y coords
  x = d3.time.scale().range [0, w - 10]
  y = d3.scale.linear().range [h, 0]

  # set delay
  delay = 700

  # define a color scale
  color = d3.scale.category10()

  svg = d3.select '#line-graph svg'
      .attr width: w + m[1] + m[3], height: h + m[0] + m[2]
    .append 'g'
      .attr transform: "translate(#{m[3]},#{m[0]})"

  # empty variables
  stocks = symbols = null

  # A line generator, for the dark stroke.
  line = d3.svg.line() # .interpolate 'basis'
      .x( (d) ->
        # console.log data
        x d.date
      )
      .y( (d) -> y d.price )

  parse = d3.time.format('%Y-%m-%d').parse

  # Nest stock values by symbol.
  symbols = d3.nest()
      .key( (d) -> d.symbol )
      .entries stocks = data

  # Parse dates and numbers. We assume values are sorted by date.
  # Also compute the maximum price per symbol, needed for the y-domain.
  symbols.forEach( (s) ->
    s.values.forEach( (d) ->
      d.date = parse d.date
      d.price = +d.price
    )
    s.maxPrice = d3.max( s.values, (d) -> d.price )
    s.sumPrice = d3.sum( s.values, (d) -> d.price )
  )

  # Sort by maximum price, descending.
  symbols.sort( (a, b) -> b.maxPrice - a.maxPrice )

  g = svg.selectAll 'g'
      .data symbols
    .enter().append 'g'
      .attr class: 'symbol'

  lines = ( ->
    # symbols is just an array hashes

    # get the max from all the symbols
    ultMax = d3.max symbols, (d) -> d.maxPrice

    # Compute the minimum and maximum date across symbols.
    x.domain [
      d3.min(symbols, (d) -> d.values[0].date ),
      d3.max(symbols, (d) -> d.values[d.values.length - 1].date )
    ]

    y.domain [0, ultMax]

    xAxis = d3.svg.axis().scale(x).orient 'bottom'
    yAxis = d3.svg.axis().scale(y).orient 'left'
    svg.append 'g'
        .attr class: 'x axis', transform: "translate(0,#{h + 4})"
        .call xAxis
    svg.append 'g'
        .attr class: 'y axis', transform: 'translate(0, 4)'
        .call yAxis

    # position every symbol's group
    g = svg.selectAll('.symbol').attr transform: (d) -> 'translate(0,4)'

    g.each( (d) ->
      e = d3.select(@)

      e.append('path').attr class: 'line'

      e.append 'circle'
          .attr r: 5
          .style fill: (d) -> color d.key

      e.append 'text'
          .attr x: 10, dy: '0.32em'
          .text d.key
    )

    draw = (k) ->
      g.each( (d) ->
        e = d3.select(@)

        e.select 'path'
            .attr 'd', (d) -> line d.values.slice 0, k + 1

        e.selectAll 'circle, text'
            .data( (d) -> [d.values[k], d.values[k]] )
            .attr transform: (d) -> "translate(#{x(d.date)},#{y(d.price)})"
      )

    k = 1
    n = symbols[0].values.length
    d3.timer ->
      draw k
      draw n - 1 if (k += 1) >= n - 1
    , delay
  )
  lines()
