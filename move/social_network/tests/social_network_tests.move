
#[test_only]
module social_network::social_network_tests;

use sui::test_scenario as ts;

use social_network::social_network::{Forum, Topic, Post, Self as sn};

const USER: address = @0x123;

#[test]
public fun setup() {
    let mut scenario = ts::begin(USER);
    {
        sn::init_for_test(scenario.ctx());
    };

    let mut topic_id: ID = @0x0.to_id();
    let mut post_id: ID = @0x0.to_id();
    scenario.next_tx(USER);
    {
        let mut forum = scenario.take_shared<Forum>();

        topic_id = forum.create_topic(b"New Topic".to_string(), scenario.ctx());

        ts::return_shared(forum);
    };

    scenario.next_tx(USER);
    {
        let mut forum = scenario.take_shared<Forum>();

        post_id = forum.create_post(topic_id, b"First post".to_string(), scenario.ctx());

        ts::return_shared(forum);
    };

    scenario.next_tx(USER);
    {
        let mut forum = scenario.take_shared<Forum>();

        forum.create_comment(topic_id, post_id, b"First comment".to_string(), scenario.ctx());

        ts::return_shared(forum);
    };

    scenario.end();
}


