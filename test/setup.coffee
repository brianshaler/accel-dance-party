path = require 'path'
_ = require 'lodash'

fixtures = path.join __dirname, './fixtures'

getRecordedData = (filename) ->
  recorded = require "./fixtures/#{filename}"
  times = _.pluck recorded, 'time'
  recordedStartTime = _.min times
  recordedEndTime = _.max times
  {
    items: recorded
    between: (start, end) ->
      _.filter recorded, (item) ->
        item.time >= start and item.time <= end
    start: recordedStartTime
    end: recordedEndTime
    duration: recordedEndTime - recordedStartTime
  }


beforeEach ->
  @fixtures = fixtures
  @bpm60 = getRecordedData 'bpm60.json'
  @bpm100 = getRecordedData 'bpm100.json'
  @bpm120 = getRecordedData 'bpm120.json'
  @bpm166 = getRecordedData 'bpm166.json'
  
