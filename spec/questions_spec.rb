require "libraryh3lp/Questions"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Questions do
  it "should be able to show answers" do
    questions = make_resource Questions
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/answer")
      .to_return(:status => 200, :body => '{"answer": "This is the answer."}')
    json, code = questions.showAnswer(1)
    expect(code).to eq(200)
    expect(json).to eq({'answer'=>'This is the answer.'})
  end

  it "should be able to save answers" do
    questions = make_resource Questions
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/answer")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = questions.saveAnswer(1, 'This is a new answer.')
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to reset likes for a given question" do
    questions = make_resource Questions
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/likes")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = questions.resetLikes(1)
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to reset dislikes for a given question" do
    questions = make_resource Questions
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/dislikes")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = questions.resetDislikes(1)
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to reset views for a given question" do
    questions = make_resource Questions
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/views")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = questions.resetViews(1)
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to add a topic to a given question" do
    questions = make_resource Questions
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/ask/questions/1/topics")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = questions.addTopic(1, 'some topic')
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

end
