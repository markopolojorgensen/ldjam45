extends Control

func healthy():
	$healthy.play()
	$healthy.show()

func unhealthy():
	$healthy.stop()
	$healthy.hide()
