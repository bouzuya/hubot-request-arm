# hubot-request-arm

A Hubot arm that send HTTP request.

## Installation

    $ npm install --save hubot-arm hubot-request-arm

## Usage

```javascript
module.exports = function(robot) {
  // attach hubot-arm to robot
  require('hubot-arm')(robot)

  robot.respond(/bouzuya/i, function(msg) {
    // use hubot-request-arm
    msg.robot.arm('request')({
      method: 'GET',
      url: 'http://bouzuya.net/',
      format: 'html'
    }).then(function(res) {
      msg.send(res.$('title'));
    });
  });
};
```

## Development

### Run test

    $ npm test

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/hubot-request-arm
[travis-badge]: https://travis-ci.org/bouzuya/hubot-request-arm.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-request-arm
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-request-arm.png
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
