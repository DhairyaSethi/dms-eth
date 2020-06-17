const DeadManSwitch = artifacts.require('DeadManSwitch');

module.exports = (deployer) => {
    deployer.deploy(DeadManSwitch);
}