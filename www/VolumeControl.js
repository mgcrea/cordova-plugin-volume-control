var exec = require('cordova/exec');

function defaults(object, source) {
  if(!object) object = {};
  for(var prop in source) {
    if(typeof object[prop] === 'undefined') {
      object[prop] = source[prop];
    }
  }
  return object;
}

exports.toggleMute = function( success, error) {
  exec(success, error, 'VolumeControl', 'toggleMute', []);
};

exports.isMuted = function(success, error) {
  exec(success, error, 'VolumeControl', 'isMuted', []);
};

exports.setVolume = function(volume, success, error) {
  if(volume > 1) {
    volume /= 100;
  }
  exec(success, error, 'VolumeControl', 'setVolume', [volume * 1]);
};

exports.getCategory = function(success, error) {
  exec(success, error, 'VolumeControl', 'getCategory', []);
};
