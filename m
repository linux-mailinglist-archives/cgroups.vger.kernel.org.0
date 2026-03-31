Return-Path: <cgroups+bounces-15128-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BjsL8Gdy2loJgYAu9opvQ
	(envelope-from <cgroups+bounces-15128-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 12:11:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF1367A63
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADD4F3046431
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7AF3D88F2;
	Tue, 31 Mar 2026 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReWgzyiC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4933A6B93
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951525; cv=none; b=CpcHfZoUvj2rEDAumNmwFrB1narycpyjVO1iQ64sAcpibEb2am0TykMeKMk6oWNHPls7u41f1jGy+yAZMQOkSXvPL7L2rWxVu9NBQszbQ8n+dXTTWwGIJf8qAaPxVgTR2ImNNNa72zcVq/3SooGL/DiBSIP/F0rojPjUTIw+dOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951525; c=relaxed/simple;
	bh=brmGGIuWRtCDRtEnvbIzJrncb+vmaxIfIoZnwKQffBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUjh3rZmBe5D/aBqxKZ4HBm0FoVZ30SkWnETdnsUI2fhjwcbwmjaFK69NbqFbYnP2DE0LbxEfuDjkYxu06ySHn11XPW8cAY735hEEMsr8Is0Q2Oi4p0DIE4eFRHbCeF2jqwlZsap1+/WbQvptG93Aww0wpE8uh40TexOl58Cimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReWgzyiC; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so140301b3a.0
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951522; x=1775556322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8stTflUqBWilNXQtRU2bQyAp9yk4sf72e3JD82g2ns=;
        b=ReWgzyiCg0/p0tqK64NLn9gHegbDMLu+ZIy2e+U6BQ9V5ZhhPEaKPHTzwS2d6hApT0
         Ad81WTByXgCp4S1wl6xoolgqjBbmGL6qJs3HIVmF0ImAQ3CEKjYfbUgxq3lqV97WEfef
         R/ub2xvw8gHSDC8r+yw2fcwpC2BGOjxBTMzZM43QuDvBeP14pMYD6WgGVu3r2D61L+wl
         qZpAOdpgI5zwpsLpScYC8EOd5lhI6trmL6AHieAKpYEh7D/z42ZSGoycXBs9XWoCSFPK
         0mnK/SedUfsIGg2CeRuVZyBLsDlfrqpBjYCHIHSz/2chxmTxeldNfYY0/unlwQcZKbKY
         htJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951522; x=1775556322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8stTflUqBWilNXQtRU2bQyAp9yk4sf72e3JD82g2ns=;
        b=b/wavL3lRBe8DcRCw82Z6MdHiNhl7+ZGhg9OGE8RWFueNztU4kjT6ZUOxiyJeJDFEH
         yW3brrGmu1HrTj1/XHcoO4KqpYzCDRNgecWYM8jvdWptsmJL7csXKZJAQ6OH45TX3yS9
         Np6tYXp6TOBZoXtwFIcxmYsrYdwQCMyG21fyMGYmJdXKmn89A3lg8+7lqN/ulhEwvwsL
         GIf7mjArdeJPQDoFGSBW8G4AnCXBXMGYOnUkwvQNNSgqweOBUh2O/1X+bH9OK7AI9oL9
         wfn0wuLURs+uXZN/2U1Xk7dEFwGLFHUL9r0KgUWNoUrh/1I60n5MSvtfzImKfc0OgQa3
         TAeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBoPE+mdXRP0H955nnVCEZSEJnLHphWjfVPnUlKmYQ6nfUkjrBq1uRxkWoRdyPf+zjRidNobP8@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsO4WwsZSb9RBveISQDKb+SayK5my8f8hcGImTYyMtc12Q7tL
	6TlS2VAHNSQUE9PX9cOT17jcthMyMo6oIaEcfuCa8FThuaGwq8UieCNz
X-Gm-Gg: ATEYQzxCqeUj2kC76V5e3nQMyK7cfURK0mLGpdaW78wEo8DTjuLyD6LD8C4qFFtAbTT
	JCgcYprYaLWVC5JU5JmyBjuFrR1kZ34LneNEadFMSMq7xarptI9OB1GIVChV77L85IhUsq3n/lD
	mltBVweUO4Nf+czl7xNreHXuBv2TEAESGFiJX0u9Jg0HxEvg0b/0CVxR3swsyTCcmP5E9WE8YuZ
	vRfbLmR8Dmf3VnHNGdnM3Oa8MLTedgKLyWoLWcnEeq3Zs1NOHF/J1b9z1ri5wLj/q90T7hTa+m2
	qdTenFDX3Sz/tC0nBHa3S8o6eZaXEbNUvT1PnMk/cDwmnLjoR8WhuGtyhZx3Wwvh2Ikr0FBQ/M/
	mRXb7X8aJtcc6r0NZa5De1+MA30NfyyAuJetrlGtl5ZHa5QB/rdF4lsgLKn2x95REb1P6hEUNzt
	pLkZzkEFtUE9Mpwy/aX+BOmswgCLVioV4sgA==
X-Received: by 2002:a05:6a00:438a:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82c95e7c457mr14501172b3a.24.1774951521532;
        Tue, 31 Mar 2026 03:05:21 -0700 (PDT)
Received: from archwsl.localdomain ([116.232.56.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm9758914b3a.50.2026.03.31.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:05:21 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: [PATCH v3] blk-iocost: fix busy_level reset when no IOs complete
Date: Tue, 31 Mar 2026 10:05:09 +0000
Message-ID: <20260331100509.182882-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329154112.526679-1-wjl.linux@gmail.com>
References: <20260329154112.526679-1-wjl.linux@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15128-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89BF1367A63
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
---
Changes in v3:
- Handle only the !nr_done && nr_lagging case and leave the other cases
  as they are.
Changes in v2:
- Handle more edge cases to prevent potential regressions.

v2: https://lore.kernel.org/all/20260329154112.526679-1-wjl.linux@gmail.com/
v1: https://lore.kernel.org/all/20260318163351.394528-1-wjl.linux@gmail.com/


 block/blk-iocost.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..0cca88a366dc 100644
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

