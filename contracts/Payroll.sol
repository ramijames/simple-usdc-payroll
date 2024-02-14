// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// Import the ERC20 interface
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Payroll {
    // Define a struct to represent an employee
    struct Employee {
        address employeeAddress;
        uint256 salary;
        uint256 lastPayDay;
    }

    // Mapping to store employees
    mapping(address => Employee) public employees;

    // USDC token contract address
    address public usdcTokenAddress;

    // Owner address
    address public owner;

    // ERC20 interface instance
    IERC20 private usdcToken;

    // Modifier to restrict access to the owner only
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Constructor to set the owner and USDC token address
    constructor(address _usdcTokenAddress) {
        owner = msg.sender;
        usdcTokenAddress = _usdcTokenAddress;
        usdcToken = IERC20(usdcTokenAddress);
    }

    // Function to add an employee
    function addEmployee(address employeeAddress, uint256 salary) public onlyOwner {
        require(employeeAddress != address(0), "Invalid employee address");
        require(salary > 0, "Salary must be greater than zero");
        require(employees[employeeAddress].employeeAddress == address(0), "Employee already exists");

        employees[employeeAddress] = Employee(employeeAddress, salary, block.timestamp);
    }

    // Function to remove an employee
    function removeEmployee(address employeeAddress) public onlyOwner {
        require(employees[employeeAddress].employeeAddress != address(0), "Employee does not exist");

        delete employees[employeeAddress];
    }

    // Function to update an employee's salary
    function updateEmployeeSalary(address employeeAddress, uint256 newSalary) public onlyOwner {
        require(employees[employeeAddress].employeeAddress != address(0), "Employee does not exist");
        require(newSalary > 0, "Salary must be greater than zero");

        employees[employeeAddress].salary = newSalary;
    }

    // Function to calculate and disburse salary to an employee
    function payday(address employeeAddress) public onlyOwner {
        Employee storage employee = employees[employeeAddress];
        require(employee.employeeAddress != address(0), "Employee does not exist");

        uint256 daysSinceLastPay = (block.timestamp - employee.lastPayDay) / 1 days;
        uint256 payment = daysSinceLastPay * employee.salary;
        require(usdcToken.balanceOf(address(this)) >= payment, "Insufficient contract USDC balance");

        // Transfer USDC tokens to the employee
        usdcToken.transfer(employeeAddress, payment);
        employee.lastPayDay = block.timestamp;
    }

    // Function to retrieve contract USDC balance
    function getContractUSDCBalance() public view onlyOwner returns (uint256) {
        return usdcToken.balanceOf(address(this));
    }
}
