# ⚙️ Control System Modeling and PID Design (MATLAB)

## 📌 Overview
This project focuses on modeling and control of a traction-drive motor system used to position a linear slide accurately.  
The system is based on an armature-controlled DC motor with a capstan roller and was analyzed using MATLAB.

---

## 🎯 Key Tasks

### 🔹 Mathematical Modeling
- Derived system differential equations for:
  - Electrical subsystem  
  - Mechanical subsystem  
  - Linear motion dynamics  
- Modeled system input (motor voltage) and outputs (speed, position, displacement)  

---

### 🔹 State-Space Representation
- Defined system states and outputs  
- Derived symbolic state-space model  
- Computed numerical matrices (A, B, C, D)  

---

### 🔹 System Analysis
- Obtained transfer functions for:
  - Angular speed  
  - Angular position  
  - Linear displacement  
- Generated step responses for all outputs  

---

### 🔹 Control Design
- Designed proportional controller with different gains  
- Analyzed step and ramp responses  
- Identified underdamped behavior for high gain values  

---

### 🔹 PID Controller Design
- Designed PID controller using Ziegler–Nichols method  
- Compared with manually tuned PID controller  
- Evaluated:
  - Settling time  
  - Overshoot  
  - Disturbance response  

---

## 🛠️ Tools
- MATLAB

---

## 📊 Results
- Successfully modeled a traction-drive motor system :contentReference[oaicite:1]{index=1}  
- Derived accurate state-space representation  
- Observed no steady-state error in speed, but unbounded response in position outputs :contentReference[oaicite:2]{index=2}  
- Achieved faster response with Ziegler–Nichols PID  
- Achieved lower overshoot with manually tuned PID  


---

## 👨‍💻 Authors
- Ahmed Belal  
- Ahmed Sherif  
- Marina Amgad  
