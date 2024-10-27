extends Control

@onready var score = $Score
@onready var liveLabel = $LivesLeft

func set_score_label(newScore):
	score.text = "SCORE: " + str(newScore)

func set_lives_label(lives):
	liveLabel.text = "x" + str(lives)
