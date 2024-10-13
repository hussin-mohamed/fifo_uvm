# fifo UVM project
#Overview
This project involves verifying a First-In, First-Out (FIFO) memory design using the Universal Verification Methodology (UVM) and SystemVerilog. The verification environment ensures that the FIFO operates correctly by simulating various scenarios, including normal operations and corner cases such as underflow and overflow conditions.

The goal of this project is to develop a comprehensive UVM testbench that validates the FIFO’s functionality, achieving 100% code and functional coverage, and addressing potential design bugs identified during the verification process.

# Features
UVM-Based Testbench: A complete UVM verification environment, including components like drivers, monitors, and scoreboards.

Assertions: Used to monitor key FIFO states such as full, empty, almost full, and almost empty. Additional assertions ensure proper flag handling and detect overflow/underflow issues.

Functional Coverage: Ensures all operational scenarios, including corner cases, are covered.

Sequence Generation: Randomized sequences to thoroughly test the FIFO's functionality, including read and write operations.

Design Under Test (DUT): The FIFO module, which is a fundamental memory structure used in many digital systems.

# How to Run the Simulation
Set Up the Environment: Ensure you have the necessary simulation tools installed, such as QuestaSim.

run the do file uploaded in the transcript

Analyze the Results: Review the coverage reports, assertion results, and log files generated during simulation to ensure the FIFO behaves as expected.

# Key Components
FIFO Interface: Provides a virtual interface to connect the UVM components to the FIFO module and facilitate data exchange.

FIFO Agent: Contains a driver to send sequences to the FIFO and a monitor to observe its behavior, checking it against expected outputs.

FIFO Scoreboard: Compares the actual FIFO outputs with the expected values, flagging any mismatches.

FIFO Coverage: Functional coverage ensures that all important FIFO scenarios, including edge cases like overflow and underflow, are thoroughly tested.

# Features Tested
Write Operations: Writing data to the FIFO under different conditions, including normal and full states.

Read Operations: Reading data from the FIFO, ensuring data is dequeued correctly.

Write Acknowledgment: Verifying that the FIFO provides proper acknowledgment after a write operation is completed.

Full Flag: Testing that the FIFO asserts the full signal when it reaches maximum capacity.

Almost Full Flag: Ensuring that the almost full signal is generated when the FIFO is nearing full capacity.

Empty Flag: Verifying the empty signal when no data is available for reading from the FIFO.

Almost Empty Flag: Checking the almost empty signal when the FIFO has minimal data.

Underflow and Overflow: Verifying that the FIFO handles these error conditions properly, including flag generation.

Boundary Conditions: Testing almost full and almost empty states, ensuring correct flag behavior.

Error Handling: Ensuring that the FIFO gracefully handles invalid operations like reading from an empty FIFO or writing to a full FIFO.

# uvm_testbench
![image](https://github.com/user-attachments/assets/7e94e21e-6c75-467a-bf3f-fe50fe86171f)

