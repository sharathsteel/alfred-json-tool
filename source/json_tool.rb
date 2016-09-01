require 'json'

class JsonTool
	attr_accessor :json

	def initialize(json)
		@json = json
	end

	def valid?
		!!(JSON.parse(json) rescue false)
	end

	def pretty_print
		JSON.pretty_generate(JSON.parse(json))
	end

	def compact_json
		JSON.parse(json).to_json
	end
end

class AlfredOutput

	def generate
		content = `pbpaste`
		json = JsonTool.new(content)
		line_items = []

		unless json.valid?
			line_items << {
				type: "default",
				title: "json is invalid!",
				arg: json
			}
		else
			line_items << {
				type: "default",
				title: "Pretty print json",
				subtitle: "Hit ENTER to copy pretty printed json to clipboard",
				arg: json.pretty_print
			}

			line_items << {
				type: "default",
				title: "Compact json",
				subtitle: "Hit ENTER to copy compact json to clipboard",
				arg: json.compact_json
			}			
		end
		puts ({items: line_items}.to_json)
	end
end

AlfredOutput.new.generate
