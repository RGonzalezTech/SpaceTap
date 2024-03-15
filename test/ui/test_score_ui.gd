extends GutTest

var score_ui : ScoreUI
var score_label : Label

func before_each():
    score_label = Label.new()
    score_label.text = "TEMP"
    score_ui = ScoreUI.new()
    score_ui.add_child(score_label)
    score_ui.label = score_label
    add_child_autofree(score_ui)

func test_set_score_updates_label():
    assert_eq(score_label.text, "TEMP")
    score_ui.set_score(1234)
    assert_eq(score_label.text, "1,234")

func test_adds_comma_to_score():
    score_ui.set_score(1234567)
    assert_eq(score_label.text, "1,234,567")

func test_does_not_add_comma_to_score_under_1000():
    score_ui.set_score(999)
    assert_eq(score_label.text, "999")