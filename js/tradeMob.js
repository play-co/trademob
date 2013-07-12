var TradeMob = Class(function () {
	this.track = function (name, data) {
		logger.log("{tradeMob} track: ", name, data);
		NATIVE && NATIVE.plugins && NATIVE.plugins.sendEvent &&
			NATIVE.plugins.sendEvent("TradeMobPlugin", "track",
				JSON.stringify({ eventName: name, params: data }));
	};
});

exports = new TradeMob();
