class TestConsumer
  include Hutch::Consumer
  consume "test.echo"

  def process(message)
    logger.info "Received Echo Test: #{message[:echo]}"
  end
end
