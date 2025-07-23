document.addEventListener("DOMContentLoaded", () => {
  const generateBtn = document.getElementById("generateBins");
  const binsContainer = document.getElementById("binsContainer");
  const output = document.getElementById("output");
  const submitBtn = document.getElementById("submitBtn");
  const ballsRemainingDisplay = document.getElementById("ballsRemaining");

  let totalBalls = 20;
  let bins = [];
  let binCounts = Array(7).fill(0);

  generateBtn.addEventListener("click", () => {
    const A = parseFloat(document.getElementById("pointEstimate").value);
    if (!A || A <= 0) return alert("Please enter a positive number.");

    // Reset
    binsContainer.innerHTML = "";
    binCounts = Array(7).fill(0);
    totalBalls = 20;
    ballsRemainingDisplay.textContent = totalBalls;
    submitBtn.disabled = true;

    // Generate bin thresholds
    bins = [];
    for (let i = 0; i < 7; i++) {
      let lower = i * (A / 3.5);
      let upper = (i + 1) * (A / 3.5);
      bins.push({
        label: i === 6 ? `> $${Math.round(lower)}` : `$${Math.round(lower)} – $${Math.round(upper)}`,
        count: 0
      });
    }

    // Render bins
    bins.forEach((bin, idx) => {
      const div = document.createElement("div");
      div.className = "bin";
      div.style.marginBottom = "10px";
      
      div.innerHTML = `
        <strong>${bin.label}</strong><br/>
        <button data-idx="${idx}" class="removeBtn">−</button>
        <button data-idx="${idx}" class="addBtn">+</button>
        <br>
        <span id="count-${idx}">0</span> balls
      `;
      binsContainer.appendChild(div);
    });
  });

  // Event delegation
  binsContainer.addEventListener("click", (e) => {
    if (!e.target.dataset.idx) return;
    const idx = parseInt(e.target.dataset.idx);
    const isAdd = e.target.classList.contains("addBtn");
    const isRemove = e.target.classList.contains("removeBtn");

    if (isAdd && totalBalls > 0) {
      binCounts[idx]++;
      totalBalls--;
    } else if (isRemove && binCounts[idx] > 0) {
      binCounts[idx]--;
      totalBalls++;
    }

    // Update UI
    document.getElementById(`count-${idx}`).textContent = binCounts[idx];
    ballsRemainingDisplay.textContent = totalBalls;
    submitBtn.disabled = totalBalls !== 0;
  });

  submitBtn.addEventListener("click", () => {
    const result = {
      bins: bins.map((b, i) => ({ label: b.label, count: binCounts[i] }))
    };
    output.textContent = JSON.stringify(result, null, 2);
  });
});
