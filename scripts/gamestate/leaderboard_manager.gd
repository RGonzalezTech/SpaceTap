class_name LeaderboardManagerCode
extends BaseSerializable

## The active leaderboard is a pre-sorted array of leaderboard entries
## sorted by score in descending order.
var leaderboard : Array[LeaderboardEntry] = []

func _ready():
	super()
	self.load_save()

func write_save() -> void:
	if(self.leaderboard.size() == 0):
		print("[LeaderboardManager] No data to save.")
		return
	
	var data_array : Array[Dictionary] = []
	for entry in self.leaderboard:
		# Convert each entry into a dictionary and append it to the data array.
		data_array.push_back(entry.values())
	pass
	self.push_data(data_array)

func load_save() -> void:
	var data = self.pull_data()
	if(data == null):
		print("[LeaderboardManager] No data to load.")
		return

	# Clear the leaderboard before loading the new data.
	self.leaderboard.clear()
	# This should be an array of dictionaries.
	for i in data:
		var new_entry : LeaderboardEntry = LeaderboardEntry.parse_from(i)
		self.leaderboard.append(new_entry)

## A Leaderboard Entry is a Data Storage Object
## that holds the name and score of a player.
class LeaderboardEntry extends BaseSerializable.BaseDTO:
	var entry_label: String
	var score: int
	var timestamp: float

	func _init(inputLabel: String, inputScore: int, inputTimestamp: float):
		self.entry_label = inputLabel
		self.score = inputScore
		self.timestamp = inputTimestamp
	
	static func parse_from(dictionary: Dictionary) -> BaseSerializable.BaseDTO:
		# Assert that the dictionary has the required properties.
		BaseSerializable.BaseDTO.validate_properties(dictionary, [
			"entry_label",
			"score",
			"timestamp"
		])

		return LeaderboardEntry.new(
			dictionary["entry_label"],
			dictionary["score"],
			dictionary["timestamp"]
		);

	func values() -> Dictionary:
		return {
			"entry_label": self.entry_label,
			"score": self.score,
			"timestamp": self.timestamp,
		}
