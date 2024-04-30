var expect = require('chai').expect;
var sinon = require('sinon');

var moduleLoader = require('./common/moduleLoader.js');
var mockFactory = require('./common/mockFactory.js');
var json = require('./common/jsonComparer.js');

var js = '../../../apiproxy/resources/jsc/JS-AdjustExpiryValues.js';

describe('feature: Expiry and refresh expiry time adjustment', function() {

	it('externalExpiresIn should be multiplied by 1000 (42000) and refreshExpiresIn should be externalExpiresIn times 100 (4200000)', function(done) {
		var mock = mockFactory.getMock();
		
		mock.contextGetVariableMethod.withArgs('externalExpiresIn').returns(42);
		// mock.contextGetVariableMethod.withArgs('refreshExpiresIn').returns(4242);

		moduleLoader.load(js, function(err) {
			expect(err).to.be.undefined;

			expect(mock.contextSetVariableMethod.calledWith('externalExpiresIn','42000')).to.be.true;
			expect(mock.contextSetVariableMethod.calledWith('refreshExpiresIn', '4200000')).to.be.true;

			done();
			
		});
	});

});
