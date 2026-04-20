Return-Path: <cgroups+bounces-15372-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBNHFwQ75mlutgEAu9opvQ
	(envelope-from <cgroups+bounces-15372-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 16:41:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC77C42D52B
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB141314BA38
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57B40627C;
	Mon, 20 Apr 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRCXTIJB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7C3C4557;
	Mon, 20 Apr 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691624; cv=none; b=K3l1jKWbILQU+i8hTSHv89xBcPY/Sx/bc7Ta2l7nVth/JNr/BSySpI6syJY+n7UO+PnIB3AUIOl1CFSSwO/oOdAdpMb4rfmbXDQE2reHZrbKs+oCjDe+t/pD/jdFHh2D6hbXBKbEFG5r9yWtjM8U1lHt0gxXH8o9OoMIONJ/EUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691624; c=relaxed/simple;
	bh=hz57hE/p0A28oIY9p/zSUK6pTcs0E6TaovPB9ItLdg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnSOa8dmP7Rw7a+9T0gMdBFDSeujuNA2stDt8tU1oJk/m73Vw2Q4v4mf9C8w7X6oaV+MO4rx9hyokzvEHQW4Se9eU+q39lH2zBuaVReFpjyLMu42nqWZsjZ43EShKDnjolOkUd+/ATvDFVbT6sezyjN66EMyZy7ELBvcyAFCTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRCXTIJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA26C2BCC4;
	Mon, 20 Apr 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691624;
	bh=hz57hE/p0A28oIY9p/zSUK6pTcs0E6TaovPB9ItLdg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRCXTIJBMV/iwlBOUURK4R8Iz3FnZzIge2i9H/2F8G0BDVaqUh9Tby6tKozLqgibg
	 DAVbkfR4egpBKfg8fPxrqO7AXR1AMtkzHErOEzXyXrggUjZLeuMIIjKnAl5SMz9RpY
	 lRiNQBVOJfvKDm5hwj2y6QJS4DgJIiIE2Ie3LsrwACkdQqFRmS+Ax8JQS491srTmQw
	 y84ulFh0tNewUU+OXXgYiQb20u6qsA1hmKkjGnRVNMVScsRBMnFqzSZrIqbgwq9pmR
	 Kx5qnM0flvE7bgJCKzRJTjigyn6ba6sKzf85XvSNVG47G7zI5wpoVbluj596BZcL94
	 ZLG5SO2lo+Khg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jialin Wang <wjl.linux@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.6] blk-iocost: fix busy_level reset when no IOs complete
Date: Mon, 20 Apr 2026 09:18:52 -0400
Message-ID: <20260420132314.1023554-138-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,kernel.dk,toxicpanda.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15372-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: BC77C42D52B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jialin Wang <wjl.linux@gmail.com>

[ Upstream commit f91ffe89b2016d280995a9c28d73288b02d83615 ]

When a disk is saturated, it is common for no IOs to complete within a
timer period. Currently, in this case, rq_wait_pct and missed_ppm are
calculated as 0, the iocost incorrectly interprets this as meeting QoS
targets and resets busy_level to 0.

This reset prevents busy_level from reaching the threshold (4) needed
to reduce vrate. On certain cloud storage, such as Azure Premium SSD,
we observed that iocost may fail to reduce vrate for tens of seconds
during saturation, failing to mitigate noisy neighbor issues.

Fix this by tracking the number of IO completions (nr_done) in a period.
If nr_done is 0 and there are lagging IOs, the saturation status is
unknown, so we keep busy_level unchanged.

The issue is consistently reproducible on Azure Standard_D8as_v5 (Dasv5)
VMs with 512GB Premium SSD (P20) using the script below. It was not
observed on GCP n2d VMs (with 100G pd-ssd and 1.5T local-ssd), and no
regressions were found with this patch. In this script, cgA performs
large IOs with iodepth=128, while cgB performs small IOs with iodepth=1
rate_iops=100 rw=randrw. With iocost enabled, we expect it to throttle
cgA, the submission latency (slat) of cgA should be significantly higher,
cgB can reach 200 IOPS and the completion latency (clat) should below.

  BLK_DEVID="8:0"
  MODEL="rbps=173471131 rseqiops=3566 rrandiops=3566 wbps=173333269 wseqiops=3566 wrandiops=3566"
  QOS="rpct=90 rlat=3500 wpct=90 wlat=3500 min=80 max=10000"

  echo "$BLK_DEVID ctrl=user model=linear $MODEL" > /sys/fs/cgroup/io.cost.model
  echo "$BLK_DEVID enable=1 ctrl=user $QOS" > /sys/fs/cgroup/io.cost.qos

  CG_A="/sys/fs/cgroup/cgA"
  CG_B="/sys/fs/cgroup/cgB"

  FILE_A="/path/to/sda/A.fio.testfile"
  FILE_B="/path/to/sda/B.fio.testfile"
  RESULT_DIR="./iocost_results_$(date +%Y%m%d_%H%M%S)"

  mkdir -p "$CG_A" "$CG_B" "$RESULT_DIR"

  get_result() {
    local file=$1
    local label=$2

    local results=$(jq -r '
    .jobs[0].mixed |
    ( .iops | tonumber | round ) as $iops |
    ( .bw_bytes / 1024 / 1024 ) as $bps |
    ( .slat_ns.mean / 1000000 ) as $slat |
    ( .clat_ns.mean / 1000000 ) as $avg |
    ( .clat_ns.max / 1000000 ) as $max |
    ( .clat_ns.percentile["90.000000"] / 1000000 ) as $p90 |
    ( .clat_ns.percentile["99.000000"] / 1000000 ) as $p99 |
    ( .clat_ns.percentile["99.900000"] / 1000000 ) as $p999 |
    ( .clat_ns.percentile["99.990000"] / 1000000 ) as $p9999 |
    "\($iops)|\($bps)|\($slat)|\($avg)|\($max)|\($p90)|\($p99)|\($p999)|\($p9999)"
    ' "$file")

    IFS='|' read -r iops bps slat avg max p90 p99 p999 p9999 <<<"$results"
    printf "%-8s %-6s %-7.2f %-8.2f %-8.2f %-8.2f %-8.2f %-8.2f %-8.2f %-8.2f\n" \
           "$label" "$iops" "$bps" "$slat" "$avg" "$max" "$p90" "$p99" "$p999" "$p9999"
  }

  run_fio() {
    local cg_path=$1
    local filename=$2
    local name=$3
    local bs=$4
    local qd=$5
    local out=$6
    shift 6
    local extra=$@

    (
      pid=$(sh -c 'echo $PPID')
      echo $pid >"${cg_path}/cgroup.procs"
      fio --name="$name" --filename="$filename" --direct=1 --rw=randrw --rwmixread=50 \
          --ioengine=libaio --bs="$bs" --iodepth="$qd" --size=4G --runtime=10 \
          --time_based --group_reporting --unified_rw_reporting=mixed \
          --output-format=json --output="$out" $extra >/dev/null 2>&1
    ) &
  }

  echo "Starting Test ..."

  for bs_b in "4k" "32k" "256k"; do
    echo "Running iteration: BS=$bs_b"
    out_a="${RESULT_DIR}/cgA_1m.json"
    out_b="${RESULT_DIR}/cgB_${bs_b}.json"

    # cgA: Heavy background (BS 1MB, QD 128)
    run_fio "$CG_A" "$FILE_A" "cgA" "1m" 128 "$out_a"
    # cgB: Latency sensitive (Variable BS, QD 1, Read/Write IOPS limit 100)
    run_fio "$CG_B" "$FILE_B" "cgB" "$bs_b" 1 "$out_b" "--rate_iops=100"

    wait
    SUMMARY_DATA+="$(get_result "$out_a" "cgA-1m")"$'\n'
    SUMMARY_DATA+="$(get_result "$out_b" "cgB-$bs_b")"$'\n\n'
  done

  echo -e "\nFinal Results Summary:\n"

  printf "%-8s %-6s %-7s %-8s %-8s %-8s %-8s %-8s %-8s %-8s\n" \
          "" "" "" "slat" "clat" "clat" "clat" "clat" "clat" "clat"
  printf "%-8s %-6s %-7s %-8s %-8s %-8s %-8s %-8s %-8s %-8s\n\n" \
          "CGROUP" "IOPS" "MB/s" "avg(ms)" "avg(ms)" "max(ms)" "P90(ms)" "P99" "P99.9" "P99.99"
  echo "$SUMMARY_DATA"

  echo "Results saved in $RESULT_DIR"

Before:
                          slat     clat     clat     clat     clat     clat     clat
  CGROUP   IOPS   MB/s    avg(ms)  avg(ms)  max(ms)  P90(ms)  P99      P99.9    P99.99

  cgA-1m   166    166.37  3.44     748.95   1298.29  977.27   1233.13  1300.23  1300.23
  cgB-4k   5      0.02    0.02     181.74   761.32   742.39   759.17   759.17   759.17

  cgA-1m   167    166.51  1.98     748.68   1549.41  809.50   1451.23  1551.89  1551.89
  cgB-32k  6      0.18    0.02     169.98   761.76   742.39   759.17   759.17   759.17

  cgA-1m   166    165.55  2.89     750.89   1540.37  851.44   1451.23  1535.12  1535.12
  cgB-256k 5      1.30    0.02     191.35   759.51   750.78   759.17   759.17   759.17

After:
                          slat     clat     clat     clat     clat     clat     clat
  CGROUP   IOPS   MB/s    avg(ms)  avg(ms)  max(ms)  P90(ms)  P99      P99.9    P99.99

  cgA-1m   162    162.48  6.14     749.69   850.02   826.28   834.67   843.06   851.44
  cgB-4k   199    0.78    0.01     1.95     42.12    2.57     7.50     34.87    42.21

  cgA-1m   146    146.20  6.83     833.04   908.68   893.39   901.78   910.16   910.16
  cgB-32k  200    6.25    0.01     2.32     31.40    3.06     7.50     16.58    31.33

  cgA-1m   110    110.46  9.04     1082.67  1197.91  1182.79  1199.57  1199.57  1199.57
  cgB-256k 200    49.98   0.02     3.69     22.20    4.88     9.11     20.05    22.15

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://patch.msgid.link/20260331100509.182882-1-wjl.linux@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for a comprehensive analysis. Let
me compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem:** `blk-iocost` (block layer IO cost controller)
- **Action verb:** "fix"
- **Summary:** Fix incorrect busy_level reset when no IO completions
  occur within a timer period
- Record: [blk-iocost] [fix] [busy_level incorrectly reset to 0 when no
  IOs complete, preventing vrate reduction during saturation]

### Step 1.2: Tags
- **Signed-off-by:** Jialin Wang <wjl.linux@gmail.com> (author)
- **Acked-by:** Tejun Heo <tj@kernel.org> (blk-iocost creator and
  maintainer)
- **Link:**
  https://patch.msgid.link/20260331100509.182882-1-wjl.linux@gmail.com
- **Signed-off-by:** Jens Axboe <axboe@kernel.dk> (block layer
  maintainer)
- No Fixes: tag (expected for AUTOSEL candidates)
- No Cc: stable (expected for AUTOSEL candidates)
- Record: Acked by the subsystem maintainer (Tejun Heo) and merged by
  the block layer maintainer (Jens Axboe). Strong quality signals.

### Step 1.3: Commit Body Analysis
- **Bug description:** When a disk is saturated, no IOs may complete
  within a timer period. When this happens, rq_wait_pct=0 and
  missed_ppm=0, which iocost incorrectly interprets as "meeting QoS
  targets."
- **Symptom:** busy_level gets reset to 0, preventing it from reaching
  threshold (4) needed to reduce vrate. On certain cloud storage (Azure
  Premium SSD), iocost can fail to reduce vrate for tens of seconds
  during saturation, breaking cgroup IO isolation.
- **Failure mode:** Noisy neighbor problem - heavy IO from one cgroup is
  not properly throttled, causing high latency for latency-sensitive
  workloads in other cgroups.
- **Testing:** Detailed benchmark script provided with before/after
  results showing dramatic improvement (cgB: 5 IOPS -> 200 IOPS; clat:
  181ms -> 1.95ms).
- Record: Clear real-world bug with concrete impact on cloud
  environments. Reproducible with specific test setup.

### Step 1.4: Hidden Bug Fix Detection
This is explicitly labeled as "fix" - no hidden nature. The commit
message clearly explains the bug mechanism and the fix approach.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed:** 1 (`block/blk-iocost.c`)
- **Lines added/removed:** ~15 lines of actual code (plus comments)
- **Functions modified:** `ioc_lat_stat()` (signature + 1 line),
  `ioc_timer_fn()` (variable + call site + new branch)
- **Scope:** Single-file, surgical fix
- Record: Minimal change in a single file affecting two functions in the
  same subsystem.

### Step 2.2: Code Flow Change
**Hunk 1 - `ioc_lat_stat()` signature:**
- Before: `ioc_lat_stat(ioc, missed_ppm_ar, rq_wait_pct_p)` - 2 output
  params
- After: `ioc_lat_stat(ioc, missed_ppm_ar, rq_wait_pct_p, nr_done)` - 3
  output params
- Adds computation: `*nr_done = nr_met[READ] + nr_met[WRITE] +
  nr_missed[READ] + nr_missed[WRITE]`

**Hunk 2 - `ioc_timer_fn()` variable:**
- Adds `u32 nr_done` variable and passes `&nr_done` to `ioc_lat_stat()`.

**Hunk 3 - busy_level decision logic:**
- Before: Directly checks `rq_wait_pct > RQ_WAIT_BUSY_PCT ||
  missed_ppm...`
- After: First checks `if (!nr_done && nr_lagging)` - if no completions
  and lagging IOs exist, skip all busy_level changes (keep unchanged).
  Otherwise, proceed with existing logic.

### Step 2.3: Bug Mechanism
This is a **logic/correctness fix**. When no IOs complete during a timer
period:
1. `nr_met` and `nr_missed` are both 0 → `missed_ppm = 0`
2. `rq_wait_ns = 0` → `rq_wait_pct = 0`
3. All metrics being 0 falls into the "UNBUSY" branch (second condition)
4. If `nr_shortages = 0`: `busy_level` is reset to 0 (the bug)
5. This prevents `busy_level` from ever reaching 4, which is required to
   trigger vrate reduction

The fix adds a guard: when `nr_done == 0 && nr_lagging > 0`, the
saturation status is truly unknown, so busy_level is preserved
unchanged.

### Step 2.4: Fix Quality
- Obviously correct: if we have zero completions, we have zero data to
  make QoS decisions
- Minimal/surgical: only adds a new guard condition before the existing
  logic
- Regression risk: Very low. The new code path only triggers when
  `nr_done == 0 && nr_lagging > 0`, and it preserves the previous state
  rather than making any change.
- The existing logic is completely unchanged in all other cases.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The buggy busy_level decision logic was introduced by:
- `7caa47151ab2e6` (Tejun Heo, 2019-08-28): Original blk-iocost
  implementation (v5.4)
- `81ca627a933063` (Tejun Heo, 2019-10-14): "iocost: don't let vrate run
  wild while there's no saturation signal" - This commit restructured
  the busy_level logic and added the `else { ioc->busy_level = 0; }`
  branch for "Nobody is being throttled." This is the commit that
  introduced the specific behavior this fix addresses. Present since
  v5.8.

### Step 3.2: Fixes Tag
No explicit Fixes: tag. However, the buggy behavior was introduced by
81ca627a933063, which is present in v5.8+ (including all currently
active stable trees: v5.10, v5.15, v6.1, v6.6, v6.12).

### Step 3.3: File History
Recent blk-iocost changes are mostly unrelated (hrtimer_setup, min_t
cleanup, treewide conversions). No conflicting changes. The busy_level
decision logic has been stable since 81ca627a933063 with only one minor
change (065655c862fedf removed `nr_surpluses` check).

### Step 3.4: Author
Jialin Wang is not the regular blk-iocost maintainer, but the fix was
acked by Tejun Heo (creator and maintainer of blk-iocost) and merged by
Jens Axboe (block layer maintainer).

### Step 3.5: Dependencies
No dependencies. The patch is self-contained and the code it modifies is
identical across all stable trees (v5.10 through current mainline,
verified by comparing `ioc_lat_stat()` and `ioc_timer_fn()` busy_level
logic).

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1-4.5
Lore.kernel.org was blocked by bot protection. Web search found limited
direct results. However, the commit has strong signals:
- **Acked-by: Tejun Heo** - the creator and primary maintainer of blk-
  iocost
- **Merged by: Jens Axboe** - the block layer maintainer
- The commit was merged via the standard block tree path

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions Modified
- `ioc_lat_stat()`: Collects per-CPU IO latency statistics
- `ioc_timer_fn()`: The main timer callback that evaluates QoS and
  adjusts vrate

### Step 5.2: Callers
- `ioc_lat_stat()` is called only from `ioc_timer_fn()` (single call
  site)
- `ioc_timer_fn()` is the periodic timer callback for the IO cost
  controller, runs once per period

### Step 5.3: Impact Surface
The `ioc_timer_fn()` timer runs periodically for every block device with
iocost enabled. The busy_level directly controls vrate adjustment, which
governs IO throttling for cgroups. This is the core feedback loop of the
entire iocost controller.

### Step 5.4: Call Chain
`timer_list callback` → `ioc_timer_fn()` → evaluates QoS → adjusts
`busy_level` → calls `ioc_adjust_base_vrate()` → adjusts
`vtime_base_rate`. This path is always active when iocost is enabled.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Code Existence in Stable Trees
Verified the exact busy_level decision logic is **byte-for-byte
identical** in:
- v5.10 (line 2272-2310)
- v5.15 (line 2348-2390)
- v6.1 (line 2354-2396)
- v6.6 (line 2381-2420)
- v7.0 mainline (line 2399-2435)

The `ioc_lat_stat()` function is also identical across all these
versions.

### Step 6.2: Backport Complications
The patch should apply **cleanly** to all active stable trees. The code
context is identical. In v5.10, `ioc_adjust_base_vrate()` is inline
rather than a separate function, but the busy_level decision logic
(where the patch applies) is identical.

### Step 6.3: No Related Fixes Already in Stable
No prior fix for this specific issue was found in stable trees.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem
- **Subsystem:** Block layer - IO cost controller (blk-iocost)
- **Criticality:** IMPORTANT - affects all users of cgroup v2 IO
  control, widely used in cloud environments (systemd, container
  orchestrators, cloud VMs)

### Step 7.2: Activity
The subsystem is mature with occasional fixes. The busy_level logic
hasn't changed since 2020, indicating this is a long-standing bug.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
- All users of cgroup v2 IO cost control during disk saturation
- Particularly cloud users on virtualized block devices (Azure, etc.)
- Container environments using IO throttling (Kubernetes, Docker with
  cgroup v2)

### Step 8.2: Trigger Conditions
- Disk saturated with large IOs (e.g., 1MB writes at high queue depth)
- Timer period passes with zero IO completions
- **Common trigger:** Any scenario where IO completion time exceeds the
  timer period (~10ms-100ms typically)
- Reproducible consistently on certain cloud storage types

### Step 8.3: Severity
- **Failure mode:** IO isolation failure - a noisy neighbor cgroup
  cannot be properly throttled during saturation
- **Impact:** Latency-sensitive workloads experience 100x+ higher
  latency than expected (181ms vs 1.95ms in the benchmark)
- **Severity:** HIGH - not a crash, but a significant functional failure
  of the IO controller that defeats its core purpose

### Step 8.4: Risk-Benefit
- **Benefit:** HIGH - Fixes IO isolation during saturation, critical for
  cloud multi-tenant environments
- **Risk:** VERY LOW - ~15 lines, only adds a "preserve state" guard
  condition, all existing paths unchanged
- **Ratio:** Strongly favorable for backporting

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real, reproducible bug with concrete user impact
- Affects IO isolation in cloud/container environments (high-value use
  case)
- Small, surgical fix (~15 lines actual code in 1 file)
- Obviously correct (no completions = no data = preserve state)
- Acked by subsystem creator (Tejun Heo)
- Merged by block maintainer (Jens Axboe)
- Detailed testing with before/after benchmarks showing 40x improvement
- Code is identical across all stable trees - clean apply expected
- Bug present since v5.8 (81ca627a933063), affects v5.10+ stable trees
- No regression found in testing (including GCP which worked before)

**AGAINST backporting:**
- No explicit Cc: stable or Fixes: tag (expected for AUTOSEL)
- Not a crash/panic - it's a performance/isolation failure
- The commit message is long (includes test script), but the actual diff
  is small

### Step 9.2: Stable Rules Checklist
1. **Obviously correct?** YES - if zero IOs completed, QoS metrics are
   meaningless
2. **Fixes real bug?** YES - IO throttling fails during saturation,
   breaking cgroup isolation
3. **Important issue?** YES - significant performance isolation failure
   in cloud environments
4. **Small and contained?** YES - ~15 lines in 1 file
5. **No new features?** CORRECT - only fixes existing logic
6. **Can apply to stable?** YES - code is identical across all stable
   trees

### Step 9.3: Exception Categories
Not an exception category - this is a standard important bug fix.

---

## Verification

- [Phase 1] Parsed tags: Acked-by Tejun Heo (blk-iocost maintainer),
  Signed-off-by Jens Axboe (block maintainer)
- [Phase 2] Diff analysis: ~15 lines added in `ioc_lat_stat()` and
  `ioc_timer_fn()`, adds nr_done tracking and guard condition
- [Phase 3] git blame: buggy code introduced in 81ca627a933063 (v5.8,
  "iocost: don't let vrate run wild"), verified present in all stable
  trees
- [Phase 3] git show 81ca627a933063: confirmed it added the `else {
  busy_level = 0 }` branch that causes the bug
- [Phase 3] git merge-base: confirmed 81ca627a933063 is in v5.8+,
  present in v5.10, v5.15, v6.1, v6.6
- [Phase 3] git log --oneline -20: no conflicting or prerequisite
  changes found
- [Phase 4] b4 dig: could not find commit (not yet in tree);
  lore.kernel.org blocked by bot protection
- [Phase 5] Grep for callers: `ioc_lat_stat()` called only from
  `ioc_timer_fn()`, single call site
- [Phase 5] Grep for busy_level: 20 references in file, all consistent
  with this fix
- [Phase 6] Compared ioc_lat_stat() across v5.10, v5.15, v6.1, v6.6,
  v7.0: byte-for-byte identical
- [Phase 6] Compared busy_level decision logic across v5.10, v5.15,
  v6.1, v6.6, v7.0: structurally identical
- [Phase 6] No prior fix for this issue found in any stable tree
- [Phase 8] Failure mode: IO isolation failure, 40x latency increase for
  latency-sensitive workloads, severity HIGH
- UNVERIFIED: Mailing list discussion (lore blocked), but commit has
  strong trust signals (Acked-by maintainer, merged via standard path)

The fix is small, surgical, obviously correct, acked by the subsystem
maintainer, fixes a real-world IO isolation failure affecting cloud
environments, and applies cleanly to all active stable trees. The risk
is very low (adds only a "preserve state" guard) while the benefit is
high (restores IO throttling during disk saturation).

**YES**

 block/blk-iocost.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c31..0cca88a366dc9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1596,7 +1596,8 @@ static enum hrtimer_restart iocg_waitq_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p)
+static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p,
+			 u32 *nr_done)
 {
 	u32 nr_met[2] = { };
 	u32 nr_missed[2] = { };
@@ -1633,6 +1634,8 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
 
 	*rq_wait_pct_p = div64_u64(rq_wait_ns * 100,
 				   ioc->period_us * NSEC_PER_USEC);
+
+	*nr_done = nr_met[READ] + nr_met[WRITE] + nr_missed[READ] + nr_missed[WRITE];
 }
 
 /* was iocg idle this period? */
@@ -2250,12 +2253,12 @@ static void ioc_timer_fn(struct timer_list *timer)
 	u64 usage_us_sum = 0;
 	u32 ppm_rthr;
 	u32 ppm_wthr;
-	u32 missed_ppm[2], rq_wait_pct;
+	u32 missed_ppm[2], rq_wait_pct, nr_done;
 	u64 period_vtime;
 	int prev_busy_level;
 
 	/* how were the latencies during the period? */
-	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
+	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct, &nr_done);
 
 	/* take care of active iocgs */
 	spin_lock_irq(&ioc->lock);
@@ -2397,9 +2400,17 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * and should increase vtime rate.
 	 */
 	prev_busy_level = ioc->busy_level;
-	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
-	    missed_ppm[READ] > ppm_rthr ||
-	    missed_ppm[WRITE] > ppm_wthr) {
+	if (!nr_done && nr_lagging) {
+		/*
+		 * When there are lagging IOs but no completions, we don't
+		 * know if the IO latency will meet the QoS targets. The
+		 * disk might be saturated or not. We should not reset
+		 * busy_level to 0 (which would prevent vrate from scaling
+		 * up or down), but rather to keep it unchanged.
+		 */
+	} else if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
+		   missed_ppm[READ] > ppm_rthr ||
+		   missed_ppm[WRITE] > ppm_wthr) {
 		/* clearly missing QoS targets, slow down vrate */
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
-- 
2.53.0


