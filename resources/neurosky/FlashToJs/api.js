var GLOBALS = {
    jsReady:false,
    flashReady:false
};

var MindWave = {
    mSignal:-1,
    mAttentionLevel:-1,
    mMeditationLevel:-1,
    mBlinkStrength:-1,
    setSignalValue:function(iconValue) {
	this.mSignal = iconValue;
	//this.log("setSignal("+this.mSignal+")");
    },
    setAttentionLevel:function(thinkingLevel) {
	this.mAttentionLevel = thinkingLevel;
	//this.log("setAttentionLevel("+this.mAttentionLevel+")");
    },
    setMeditationLevel:function(relaxationLevel) {
	this.mMeditationLevel = relaxationLevel;
	//this.log("setMeditationLevel("+this.mMeditationLevel+")");
    },
    setBlinkStrength:function(blinkStrength) {
	this.mBlinkStrength = blinkStrength;
	//this.log("setBlinkStrength("+this.mBlinkStrength+")");
    },
    displayIcon:function() {
	return this.mSignal >= 0 && this.mSignal <= 200;
    },
    getAttentionLevel:function() {
	var t = this.mAttentionLevel;
	if (t) return t;
	return 0;
    },
    getMeditationLevel:function() {
	var r = this.mMeditationLevel;
	if (r) return r;
	return 0;
    },
    getBlinkStrength:function() {
	var b = this.mBlinkStrength;
	if (b) return b;
	return 0;
    },
    log:function(message) {
	console.log(message);
    }
};

function trace(text) {
    console.log(text);
}

function isReady() {
    return GLOBALS.jsReady;
}

$(document).ready(function() {
    GLOBALS.jsReady = true;
});

// var MindWave = (function () {
//     return {
// 	setSignalValue:function(iconValue) {
// 	},
// 	displayIcon: function() {
// 	    return Math.random() > 0.1;
// 	},
// 	getAttentionLevel: function() {
// 	    return Math.floor(Math.random()*101);
// 	},
// 	getMeditationLevel: function() {
// 	    return Math.floor(Math.random()*101);
// 	},
// 	setBlinkStrength: function() {
// 	},
// 	getBlinkStrength: function() {
// 	    return Math.floor(Math.random()*2);
// 	}
//     };
// }());

