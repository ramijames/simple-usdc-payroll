// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import the ERC20 interface
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IPayroll {
    // Define a struct to represent an employee
    struct Employee {
        address employeeAddress;
        uint256 salary;
        uint256 lastPayDay;
    }

    // Mapping to store employees
    function employees(address) external view returns (Employee memory);

    // USDC token contract address
    function usdcTokenAddress() external view returns (address);

    // Owner address
    function owner() external view returns (address);

    // ERC20 interface instance
    function usdcToken() external view returns (IERC20);

    // Function to add an employee
    function addEmployee(address employeeAddress, uint256 salary) external;

    // Function to remove an employee
    function removeEmployee(address employeeAddress) external;

    // Function to update an employee's salary
    function updateEmployeeSalary(address employeeAddress, uint256 newSalary) external;

    // Function to calculate and disburse salary to an employee
    function payday(address employeeAddress) external;

    // Function to retrieve contract USDC balance
    function getContractUSDCBalance() external view returns (uint256);
}
