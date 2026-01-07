
# 🧠 Understanding Slowly Changing Dimensions (SCD)

Slowly Changing Dimensions (SCDs) are methods used to manage changes in dimension attributes over time. They help businesses preserve historical data 🕰️ and ensure accurate reporting 📊. In data warehousing, tracking these changes is vital for analytics and compliance.

---

## 📚 Types of SCD

There are six commonly used SCD types:

### 🧊 Type 0: Retain Original Value

- 🔒 Values are static — no changes allowed.
- ✅ Great for data that should never change (e.g., product codes, account numbers).
- 👍 **Pros**: Simple to implement.
- 👎 **Cons**: No updates or history tracking.

---

### ✍️ Type 1: Overwrite the Existing Data

- ✨ New data overwrites old data directly.
- 🔄 No history retained.

**Pros**:
- ✅ Easy to implement.
- 💾 Saves storage.

**Cons**:
- ❌ No historical tracking.
- 📉 Can affect historical reporting accuracy.

🧾 **Example**: A customer changes their address — the new address replaces the old one.

---

### 🗂️ Type 2: Preserve Historical Data (Row Versioning)

- ➕ New rows are added for every change.
- 📅 Uses start/end dates or flags for version tracking.

**Pros**:
- ✅ Complete historical tracking.
- 🔍 Can query past versions.

**Cons**:
- ⚠️ Increased table size.
- 🧠 Requires careful version control.

🧾 **Example**: A customer changes their address — a new row is added with a new start date, and the old row is marked historical.

---

### 🧩 Type 3: Add New Attribute (Limited History)

- ➕ Adds columns to track previous versions.
- 🧠 Used when only a few changes need to be tracked.

**Pros**:
- ✅ Easy to implement.
- 💾 Requires less storage than Type 2.

**Cons**:
- ❌ Limited history tracking.
- 📊 Less flexible for long-term analysis.

🧾 **Example**: Current and previous addresses stored in separate columns.

---

### 🧾 Type 4: Historical Table

- 🔄 Keeps current data in one table and historical data in another.
- 🧹 Separates the present from the past.

**Pros**:
- ✅ Full historical tracking.
- 🚀 Better performance on current data.

**Cons**:
- 🧱 More complex architecture.
- 💾 Needs more storage.

🧾 **Example**: `Customer_Current` and `Customer_History` tables.

---

### 🧠 Type 6: Hybrid Approach

- 🧬 Combines Type 1, Type 2, and Type 3.
- 📊 Tracks full history, current state, and previous versions.

**Pros**:
- ✅ All-in-one solution.
- 📋 Supports deep reporting and auditing.

**Cons**:
- 🧠 Complex implementation.
- 💾 Higher storage cost.

🧾 **Example**: Address updates handled by adding new rows (Type 2), storing previous address (Type 3), and maintaining current address in place (Type 1).

---

## 🔍 Key Considerations for SCD Implementation

- 🧭 **Business Requirements**: Know what history you need to keep.
- 🗓️ **Versioning**: Track start dates, end dates, and current flags (esp. for Type 2).
- 🖥️ **Storage & Performance**: More history = bigger tables = slower queries.
- ⚙️ **ETL Process**:
  - Type 1 ➡️ updates rows.
  - Type 2 ➡️ detects changes & inserts new rows.

---

## ✅ Conclusion

Slowly Changing Dimensions (SCDs) are critical for long-term data accuracy, reporting, and auditing. Choose your type based on how much history you need to keep:

- 🧊 **Type 0**: No changes allowed.
- ✍️ **Type 1**: Simple overwrite.
- 🗂️ **Type 2**: Full historical record.
- 🧩 **Type 3**: Limited past view.
- 🧾 **Type 4**: Separate history table.
- 🧠 **Type 6**: Hybrid power.

🏆 With the right SCD strategy, you’ll ensure solid data warehousing and a foundation for reliable insights!

