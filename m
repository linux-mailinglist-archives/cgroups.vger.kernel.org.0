Return-Path: <cgroups+bounces-15092-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GoVCy1IyWl9xAUAu9opvQ
	(envelope-from <cgroups+bounces-15092-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:41:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D691D352A96
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8749130104B3
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F637F749;
	Sun, 29 Mar 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxEDUx9V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6D3603C9
	for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798884; cv=none; b=hy+I/OPC6c8Shh5Rnu+Kri2Cke+4O9SPBtHnFOMdtN7RjMNwMuXbAVa0vcm5cQf4ZKv54/We6DTA8RwYCz8QgYd1YgsRnWI8XT2Hoz9MQjzjPRloqZylJCi5S5AqiUI0tOI9xJPgA32sIygpKYpcSqKWZxFAi5X7PyaLIUOFnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798884; c=relaxed/simple;
	bh=0UxYwmWrWT4FOWXddN0QIWyeclk0j70twaLLE+szpko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSzQAxOakg5cuTmfbjdYem/txNFi9rgzoCsjPkpX5ke8xAcHD6Ve5HL8C1W7YYSX/Woe4sP4I9w7vtscqK+NExQtAJs4RqjijXiek99Ts/v6GdGMkrhn0X6eI8GkoMKuVSPdNgBapkPJobnPzbyU5LMpcKDABsPpzKlYAo4oCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxEDUx9V; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1604642a12.0
        for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774798881; x=1775403681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cn2DYOVpo8bOTJ2a/G22aIN/JEjANtXiC08Q2WS+2PA=;
        b=cxEDUx9V+kfwEh6ULc5CrdZBBKpsAQ1wo9uG5hXSJgb0h7aln75QK5L/ZRxKTzqNiu
         STegWL3HGRgV43Oz2KVQxIUlM1WKUM7bebWHV9NqU2gzBYLjj08q7nwsbojPtkzp4vo2
         wFJ0amYIF7QnfsJbxly3sVWF/FN9uuiWDT79TQK60KmsDB/ELfE5+rSNXJEASRUPE9z1
         jlsN8+KpuH8J1bgEsaOSijBFun7JzeKhHDI0c4//Z9yWwJNYpqArIPdSnEnv7GOcWNd4
         o15oNhEB21tfBVgS4G0wqwNWDdE7mK0wWaPt7/CjpCAIOcCPKtJ9Ellr1TukbZxfkZ/h
         0k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774798881; x=1775403681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn2DYOVpo8bOTJ2a/G22aIN/JEjANtXiC08Q2WS+2PA=;
        b=X6duLWicfUz0Sl9D0RmF3qXbD9joLkTztTC3fbCjj1CgpP6Ri5bJ1qyO2IfJtW33x3
         rrC9yhHeYekvqpc7n089UOTidDvID1v2DovIJdkPl30laKbO+RM0g5SQwLnAwZEWWhIt
         u6MN+9aQ+7QSS0tB024FbV+6ctE7tikBPoLBctFJJ18COAhTd/D1C1RKPdGYgGnaafEJ
         Y179ibVvEkA9lque9d1GWuCR7Wj0dRgkURtcGRb0cA4VA7OZKs6u8VT6+btRCelkUw5C
         WYai2F1LCPMJjBlzO+haVz+KQQd1UkdpPqVeaxIUcw7Wc2QC0c7bvWPTH7WpavNJCv8w
         FnCQ==
X-Gm-Message-State: AOJu0YzejZpPalW+nm2pB1HQGNlgv7VAsspAEX/nrbX5nMsOPkRZhJ1m
	Kn6MnekGE2dbvgTmEpc7EInZWFJZLskmjwV3iNDr8iCpHQ030OMhgIkx
X-Gm-Gg: ATEYQzyBPNbs6thAG3YZeAQAHrbJbCKbj1Z+oUl6JzVaDxmsDa8N9IK3BVCPZ5mNdkY
	Z5oKW9nLHBzSTsQpJ9EOjMNhmD9X1jMH4KciE3SOM1o1B5zQ1wSW+ifxhFEwR23BVRLn3yTtpkF
	HiC5tFM8Sgz4FYas7N1W0wH1EGE1GtKRdL8PXOoovt+fO4l0UhkDlo5RHSiz0lpWVgpYqky498b
	ZXCIUyoA8duJZhxcVr7j4X3ythP2GxbKebE87BPDNO0/a6fBFMcz3OlJevO6m5cKtOWbxgoi0W4
	uE1AsdnnCr2PMZ0bsVQfiL8BFyP1Iovdd1sWtNlhZAsnaS7x7MQoKvebCFGK5JIk/DFI1PPr34P
	7Gqf3XAYWOu4SeqcddNAmKaaJvDzIJ0Hp8Es2oNldjx/ZJfgJVFpoVf+OguXXavqABh2cgrJlYh
	ljkLVNAvNQEY3GrCndIiUbQpVu2Pj3ReaEGA==
X-Received: by 2002:a05:6300:210c:b0:39b:d9f1:6cff with SMTP id adf61e73a8af0-39c87b6af38mr9436144637.47.1774798880807;
        Sun, 29 Mar 2026 08:41:20 -0700 (PDT)
Received: from archwsl.localdomain ([116.232.56.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916cce42sm4111879a12.9.2026.03.29.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 08:41:20 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wjl.linux@gmail.com
Subject: [PATCH v2] blk-iocost: fix busy_level reset when no IOs complete
Date: Sun, 29 Mar 2026 15:41:12 +0000
Message-ID: <20260329154112.526679-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-15092-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D691D352A96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a disk is saturated, it is common for no IOs to complete within a
timer period. Currently, in this case, rq_wait_pct and missed_ppm are
calculated as 0, the iocost incorrectly interprets this as meeting QoS
targets and resets busy_level to 0.

This reset prevents busy_level from reaching the threshold (4) needed
to reduce vrate. On certain cloud storage, such as Azure Premium SSD,
we observed that iocost may fail to reduce vrate for tens of seconds
during saturation, failing to mitigate noisy neighbor issues.

Fix this by tracking the number of IO completions (nr_done) in a period.
If nr_done is 0, we adjust the logic:

* If there are lagging IOs, the saturation status is unknown, so we try
  to keep busy_level unchanged. To avoid drastic vrate oscillations, we
  clamp it between -4 and 4.
* If there are shortages but no lagging IOs, the vrate might be too low
  to issue any IOs. We should allow vrate to increase but not decrease.
* Otherwise, reset busy_level to 0.

Note that when nr_done is 0 and nr_lagging is 0, the adjustment logic
is nearly identical to the "QoS targets are being met with >25% margin"
state, which minimizes the risk of regressions.

The issue is consistently reproducible on Azure Standard_D8as_v5 (Dasv5)
VMs with 512GB Premium SSD (P20) using the script below. It was not
observed on GCP n2d VMs (100G pd-ssd and 1.5T local-ssd), and no
regressions were found with this patch. In this script, cgA saturates
the device. The iocost is expected to throttle it so that cgB's
completion latency remains low.

  BLK_DEVID="8:0"
  MODEL="rbps=173471131 rseqiops=3566 rrandiops=3566 wbps=173333269 wseqiops=3566 wrandiops=3566"
  QOS="rpct=90.00 rlat=3500 wpct=90 wlat=3500 min=80 max=10000"

  echo "$BLK_DEVID ctrl=user model=linear $MODEL" > /sys/fs/cgroup/io.cost.model
  echo "$BLK_DEVID enable=1 ctrl=user $QOS" > /sys/fs/cgroup/io.cost.qos

  CG_A="/sys/fs/cgroup/cgA"
  CG_B="/sys/fs/cgroup/cgB"

  FILE_A="/data0/A.fio.testfile"
  FILE_B="/data0/B.fio.testfile"
  RESULT_DIR="./iocost_results_$(date +%Y%m%d_%H%M%S)"

  mkdir -p "$CG_A" "$CG_B" "$RESULT_DIR"

  get_result() {
    local file=$1
    local label=$2

    local results=$(jq -r '
    .jobs[0].mixed |
    ( .iops | tonumber | round ) as $iops |
    ( .bw_bytes / 1024 / 1024 ) as $bps |
    ( .clat_ns.mean / 1000000 ) as $avg |
    ( .clat_ns.max / 1000000 ) as $max |
    ( .clat_ns.percentile["90.000000"] / 1000000 ) as $p90 |
    ( .clat_ns.percentile["99.000000"] / 1000000 ) as $p99 |
    ( .clat_ns.percentile["99.900000"] / 1000000 ) as $p999 |
    ( .clat_ns.percentile["99.990000"] / 1000000 ) as $p9999 |
    "\($iops)|\($bps)|\($avg)|\($max)|\($p90)|\($p99)|\($p999)|\($p9999)"
    ' "$file")

    IFS='|' read -r iops bps avg max p90 p99 p999 p9999 <<<"$results"
    printf "%-8s %-6s %-7.2f %-8.2f %-8.2f %-8.2f %-8.2f %-8.2f %-8.2f\n" \
           "$label" "$iops" "$bps" "$avg" "$max" "$p90" "$p99" "$p999" "$p9999"
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

  # Final Output
  echo -e "\nFinal Results Summary:\n"

  printf "%-8s %-6s %-7s %-8s %-8s %-8s %-8s %-8s %-8s\n\n" \
         "CGROUP" "IOPS" "MB/s" "Avg(ms)" "Max(ms)" "P90(ms)" "P99" "P99.9" "P99.99"
  echo "$SUMMARY_DATA"

  echo "Results saved in $RESULT_DIR"

Before:
  CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99

  cgA-1m   167    167.02  748.65   1641.43  960.50   1551.89  1635.78  1635.78
  cgB-4k   5      0.02    190.57   806.84   742.39   809.50   809.50   809.50

  cgA-1m   166    166.36  751.38   1744.31  994.05   1451.23  1736.44  1736.44
  cgB-32k  4      0.14    225.71   1057.25  759.17   1061.16  1061.16  1061.16

  cgA-1m   166    165.91  751.48   1610.94  1010.83  1417.67  1602.22  1619.00
  cgB-256k 5      1.26    198.50   1046.30  742.39   1044.38  1044.38  1044.38

After:
  CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99

  cgA-1m   159    158.59  769.06   828.52   809.50   817.89   826.28   826.28
  cgB-4k   200    0.78    2.01     26.11    2.87     6.26     12.39    26.08

  cgA-1m   147    146.84  832.05   985.80   943.72   960.50   985.66   985.66
  cgB-32k  200    6.25    2.82     71.05    3.42     15.40    50.07    70.78

  cgA-1m   114    114.47  1044.98  1294.48  1199.57  1283.46  1300.23  1300.23
  cgB-256k 200    50.00   4.01     34.49    5.08     15.66    30.54    34.34

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
v2:
- Handle more edge cases to prevent potential regressions.

v1: https://lore.kernel.org/all/20260318163351.394528-1-wjl.linux@gmail.com/

 block/blk-iocost.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..5184c6e25a0c 100644
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
@@ -2397,9 +2400,29 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * and should increase vtime rate.
 	 */
 	prev_busy_level = ioc->busy_level;
-	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
-	    missed_ppm[READ] > ppm_rthr ||
-	    missed_ppm[WRITE] > ppm_wthr) {
+	if (!nr_done) {
+		if (nr_lagging)
+			/*
+			 * When there are lagging IOs but no completions, we
+			 * don't know if the IO latency will meet the QoS
+			 * targets. The disk might be saturated or not. We
+			 * should not reset busy_level to 0 (which would
+			 * prevent vrate from scaling up or down), but rather
+			 * try to keep it unchanged. To avoid drastic vrate
+			 * oscillations, we clamp it between -4 and 4.
+			 */
+			ioc->busy_level = clamp(ioc->busy_level, -4, 4);
+		else if (nr_shortages)
+			/*
+			 * The vrate might be too low to issue any IOs. We
+			 * should allow vrate to increase but not decrease.
+			 */
+			ioc->busy_level = min(ioc->busy_level, 0);
+		else
+			ioc->busy_level = 0;
+	} else if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
+		   missed_ppm[READ] > ppm_rthr ||
+		   missed_ppm[WRITE] > ppm_wthr) {
 		/* clearly missing QoS targets, slow down vrate */
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
-- 
2.53.0


