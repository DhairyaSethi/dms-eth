const DeadManSwitch = artifacts.require('DeadManSwitch');

module.exports = (deployer) => {
    const beneficiary = '0xbCA60929ab61162A6169897083DaE3F9ABd0a314';
    deployer.deploy(DeadManSwitch, beneficiary);
}