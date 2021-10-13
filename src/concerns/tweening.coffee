###
Code related to tweening the position of the track
###
export default

	props:

		# How quickly the carousel slides to a stop. Increase to tween to as stop
		# quicker.
		tweenDampening:
			type: Number
			default: 0.12

	data: ->
		tweening: false # If there is a current RAF based tween running

	# Stop any animations that are in flight
	beforeDestroy: -> window.cancelAnimationFrame @rafId

	watch:

		# Start RAF based tweener
		tweening: ->
			if @tweening
			then @tweenToTarget()
			else window.cancelAnimationFrame @rafId

	methods:

		# Start tweening to target location if necessary and if not already
		# tweening
		startTweening: ->
			return if @tweening
			return if @currentX == @targetX
			@tweening = true

		# The watcher on this will kill active tweens
		stopTweening: -> @tweening = false

		# Tween the currentX to the targetX
		tweenToTarget: ->
			@currentX = @currentX + (@targetX - @currentX) * @tweenDampening
			if Math.abs(@targetX - @currentX) < 1 # Stops tweening
				@currentX = @targetX
				@tweening = false
			else @rafId = window.requestAnimationFrame @tweenToTarget