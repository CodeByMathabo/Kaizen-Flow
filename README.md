# Kaizen Flow

A automated system recovery for distributed networks of the South African Department of Home Affairs(DHA).

---

### The Problem: DHA "The System is Offline"

At the South African Department of Home Affairs (DHA), citizens are frequently turned away due to "offline" systems. The reality is rarely a permanently destroyed server; it is often a localized connection timeout, a network drop from load-shedding, or an unoptimized server load. Currently, when a service hangs, it stays down until an IT technician manually resets it, causing hours of downtime.

---

### The Solution: Kaizen Flow

Kaizen Flow is a localized, DevOps proof-of-concept demonstrating how to replace manual IT intervention with automated system recovery using modern infrastructure-as-code practices.

Instead of writing complex applications, this project relies entirely on structured containerization and localized Bash scripting to monitor and auto-heal a simulated network.

---

### The Architecture

The project spins up a private Docker network containing two lightweight Ubuntu nodes:

1. **Central System:** A simulated central database running an Nginx web server.
2. **Local Branch:** A remote node running a continuous monitoring Bash script.

**The Automation:** If the Central System becomes offline, the Local Branch detects the failed ping instantly. It then reaches through the mounted Docker socket to execute a recovery sequence, rebooting the central server without human intervention.

---

### How to run:

**Prerequisites:**

- Docker and Docker Compose installed.
- A Linux environment (or WSL on Windows).

**1. Clone the repository**

```bash
git clone [https://github.com/yourusername/kaizen-flow.git](https://github.com/yourusername/kaizen-flow.git)
cd kaizen-flow
```

**2. Launch the Infrastructure**

```bash
docker compose up -d --build
```

**3. View the Dashboard**
Once the containers are running, open your web browser and navigate to:
`http://localhost:8080` to view the simulated DHA Central System gateway.

> **What is this page?** This simple webpage acts as the visual proof of the infrastructure. It simulates the internal dashboard that a South African Home Affairs branch worker would see when the central database is up and running. It allows us to physically see that the system is healthy before we intentionally "break" it in the next step to test the automation.

**4. Test the Auto-Recovery**
Open two terminal windows to watch the automation in real-time.

_In Terminal 1 (The Monitoring Agent):_

```bash
docker exec -it kaizen-flow-local-branch bash /monitor.sh
```

_In Terminal 2 (Simulating the Outage):_

```bash
docker stop kaizen-flow-central-system
```

_Watch Terminal 1 as the script detects the outage, triggers the alarm, and automatically reboots the central system._

---

### Visual Proof of the system working:

Below is a real-time demonstration of the Kaizen Flow system detecting a Department of Home Affairs central system failure and autonomously executing the recovery sequence.

<video src="Kaizen-Flow.mp4" controls="controls" style="max-width: 100%;">
</video>
