// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ServiceManagerBase} from "eigenlayer-middleware/ServiceManagerBase.sol";
import {IHolderVerificationTaskManager} from "./interfaces/IHolderVerificationTaskManager.sol";

contract HolderVerificationServiceManager is ServiceManagerBase {
    IHolderVerificationTaskManager public immutable holderVerificationTaskManager;

    /// @notice when applied to a function, ensures that the function is only callable by the `registryCoordinator`.
    modifier onlyTaskManager() {
        require(msg.sender == address(holderVerificationTaskManager), "onlyTaskManger: not from task manager");
        _;
    }

    constructor(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        IHolderVerificationTaskManager _holderVerificationTaskManager
    )
        ServiceManagerBase(
            _avsDirectory,
            IPaymentCoordinator(address(0)), // inc-sq doesn't need to deal with payments
            _registryCoordinator,
            _stakeRegistry
        )
    {
        holderVerificationTaskManager = _holderVerificationTaskManager;
    }

    /// @notice Called in the event of challenge resolution, in order to forward a call to the Slasher, which 'freezes' the `operator`.
    /// @dev The Slasher contract is under active development and its interface expected to change.
    ///      We recommend writing slashing logic without integrating with the Slasher at this point in time.
    function freezeOperator(address operatorAddr) external onlyTaskManager {
        // slasher.freezeOperator(operatorAddr);
    }
}
