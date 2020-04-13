Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8A1A6F03
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgDMWVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 18:21:23 -0400
Received: from mx0b-001e9b01.pphosted.com ([148.163.159.123]:47994 "EHLO
        mx0a-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389509AbgDMWVW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 18:21:22 -0400
X-Greylist: delayed 1380 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 18:21:19 EDT
Received: from pps.filterd (m0088348.ppops.net [127.0.0.1])
        by mx0b-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DLwFVE016040
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp09042018;
 bh=q9xbrEtUFvdD+yjJZ2AFSDagxPmBYQWtTPe7OPBiRKE=;
 b=IHltbH3zB2ocnvsP4UJNirThHBgrhGPue/h6WDGLnNjv1W+HcTFhT16vvgCIvmeC3ibg
 ZzZwXXzDLIpUYpvoiGHDOQIVX/i69nxgMs2//adl/ThzgXaD2kulyypywAO53sEkQeEl
 6Nf4eZgGPWd6TL1RKL6yh0OZduSjtJOGZjoZmRak3aDTSZUC2ZZR0rXOHcmWQAmvXiZX
 OKDYK5/sfy43ognA+zz1BoG3sksx1kjGmsUtmzR6PQk1FsozE1wZxbPD4dJfGMapv5lP
 MKTxLPqbksmujrJjIuXL0rbN9MvIUvPOFQZrQ9ixQrwrImmvE/a7bbExf+bYQ2Z30K2e CA== 
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
        by mx0b-001e9b01.pphosted.com with ESMTP id 30b8rghu4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:18 -0400
Received: by mail-ua1-f71.google.com with SMTP id 8so4717883uak.19
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9xbrEtUFvdD+yjJZ2AFSDagxPmBYQWtTPe7OPBiRKE=;
        b=KVR+sANu5hQxc4ZhyNpskoe4UhhF9xUoJ8NNACnnzE3ocoqzZjKju2MRdK2HRtZvL+
         N/8thcktbt4udU/0V6iU8gpT/xyDsheWebPSS8FNZYY412N0ulciGc6Hq2Qca7kGEJBj
         LyvmSWquIj6aaqtO+PdHJE5AWmMtVvU27GKas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9xbrEtUFvdD+yjJZ2AFSDagxPmBYQWtTPe7OPBiRKE=;
        b=UAQ9OjqhpN2pDSlqXb93EvuIEQrzAefv5g9w73zf6r4hpQV0JY5zgmOTihKCJWmuAG
         TMDZ8v6aFwKlcxDeCYbOtC0v5aFNEcaIodvzy9bkVp/Mt1sTK7XBNKF421Y1asSgoFjI
         n5LfSgH4NZnUurXpon0KJ7AHtFX8wqml7ZS7YTwXAdpWYuM0hpalP5joopz+AhCdZqB1
         ZN1BRtGhrA9DlVffAdWDK2GJFlgB8sPTGA17Mej1K6hqcy+TgedS9qa9JNKD7VGVJivT
         4Vobyx4QvDE4pGNIr7Za8HevLHnFw0iXjEEReTxjWaDXfiPkB2likZSYQZjL1QT2kCus
         a51A==
X-Gm-Message-State: AGi0PuYbGoCjVaOT3NoQNHeh2Q1cpH8NAmgLTZDycSxBPjIccy/3SdsK
        gaxq3Ku5nXHaSE1JHrDgc4LbjbVKaKlFJjt859Sbssh66+0gkP2zu3XPyg4U4PI0nnTYk4uCsen
        rx/B1gT8yutH7XStRhA==
X-Received: by 2002:a67:fad8:: with SMTP id g24mr14100498vsq.162.1586815097486;
        Mon, 13 Apr 2020 14:58:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLSllP7rTpkID/s9wUgG/RyXGSFr2nLzVypoD5HoINgx0EhexeQbxFV6Z0LY7Chg6NphJMVQw==
X-Received: by 2002:a67:fad8:: with SMTP id g24mr14100466vsq.162.1586815097140;
        Mon, 13 Apr 2020 14:58:17 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id 20sm2988529uaj.13.2020.04.13.14.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:58:16 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH 2/2] memcg, vmpressure: expose vmpressure controls
Date:   Mon, 13 Apr 2020 17:57:50 -0400
Message-Id: <20200413215750.7239-3-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130160
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

vmpressure code used hardcoded empirically selected values
to control levels and parameters for reclaiming pages which
might be not acceptable for all memory profiles.

The controls exposed vmpressure controls with legacy defaults:
- memory.pressure_window (512 or SWAP_CLUSTER_MAX * 16)
- memory.pressure_level_critical_prio (3)
- memory.pressure_level_medium (60)
- memory.pressure_level_critical (95)

Signed-off-by: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
---
 include/linux/vmpressure.h |  35 ++++++++++++
 mm/memcontrol.c            | 113 +++++++++++++++++++++++++++++++++++++
 mm/vmpressure.c            | 101 ++++++++++++++-------------------
 3 files changed, 189 insertions(+), 60 deletions(-)

diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
index 6d28bc433c1c..9ad0282f9ad9 100644
--- a/include/linux/vmpressure.h
+++ b/include/linux/vmpressure.h
@@ -25,6 +25,41 @@ struct vmpressure {
 	struct mutex events_lock;
 
 	struct work_struct work;
+
+	/*
+	 * The window size is the number of scanned pages before
+	 * we try to analyze scanned/reclaimed ratio. So the window is used as a
+	 * rate-limit tunable for the "low" level notification, and also for
+	 * averaging the ratio for medium/critical levels. Using small window
+	 * sizes can cause lot of false positives, but too big window size will
+	 * delay the notifications.
+	 */
+	unsigned long window;
+
+	/*
+	 * When there are too little pages left to scan, vmpressure() may miss
+	 * the critical pressure as number of pages will be less than
+	 * "window size".
+	 * However, in that case the vmscan priority will raise fast as the
+	 * reclaimer will try to scan LRUs more deeply.
+	 *
+	 * The vmscan logic considers these special priorities:
+	 *
+	 * prio == DEF_PRIORITY (12): reclaimer starts with that value
+	 * prio <= DEF_PRIORITY - 2 : kswapd becomes somewhat overwhelmed
+	 * prio == 0                : close to OOM, kernel scans every page in
+	 *                          : an lru
+	 */
+	unsigned long level_critical_prio;
+
+	/*
+	 * These thresholds are used when we account memory pressure through
+	 * scanned/reclaimed ratio. The current values were chosen empirically.
+	 * In essence, they are percents: the higher the value, the more number
+	 * unsuccessful reclaims there were.
+	 */
+	unsigned long level_medium;
+	unsigned long level_critical;
 };
 
 struct mem_cgroup;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5beea03dd58a..f8a956bf6e81 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -251,6 +251,13 @@ struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 	return &memcg->vmpressure;
 }
 
+struct vmpressure *vmpressure_from_css(struct cgroup_subsys_state *css)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return memcg_to_vmpressure(memcg);
+}
+
 struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 {
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
@@ -3905,6 +3912,92 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+
+static u64 mem_cgroup_pressure_window_read(struct cgroup_subsys_state *css,
+					struct cftype *cft)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	return vmpr->window;
+}
+
+static int mem_cgroup_pressure_window_write(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	if (val < SWAP_CLUSTER_MAX)
+		return -EINVAL;
+
+	vmpr->window = val;
+
+	return 0;
+}
+
+static u64 mem_cgroup_pressure_level_critical_prio_read(
+			struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	return vmpr->level_critical_prio;
+}
+
+static int mem_cgroup_pressure_level_critical_prio_write(
+		struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	if (val > DEF_PRIORITY)
+		return -EINVAL;
+
+	vmpr->level_critical_prio = val;
+
+	return 0;
+}
+
+
+static u64 mem_cgroup_pressure_level_medium_read(
+		struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	return vmpr->level_medium;
+}
+
+static int mem_cgroup_pressure_level_medium_write(
+		struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	if (val > 100)
+		return -EINVAL;
+
+	vmpr->level_medium = val;
+
+	return 0;
+}
+
+static u64 mem_cgroup_pressure_level_critical_read(
+			struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	return vmpr->level_critical;
+}
+
+static int mem_cgroup_pressure_level_critical_write(
+		struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct vmpressure *vmpr = vmpressure_from_css(css);
+
+	if (val > 100)
+		return -EINVAL;
+
+	vmpr->level_critical = val;
+
+	return 0;
+}
+
 static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 {
 	struct mem_cgroup_threshold_ary *t;
@@ -4777,6 +4870,26 @@ static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "pressure_level",
 	},
+	{
+		.name = "pressure_window",
+		.read_u64 = mem_cgroup_pressure_window_read,
+		.write_u64 = mem_cgroup_pressure_window_write,
+	},
+	{
+		.name = "pressure_level_critical_prio",
+		.read_u64 = mem_cgroup_pressure_level_critical_prio_read,
+		.write_u64 = mem_cgroup_pressure_level_critical_prio_write,
+	},
+	{
+		.name = "pressure_level_medium",
+		.read_u64 = mem_cgroup_pressure_level_medium_read,
+		.write_u64 = mem_cgroup_pressure_level_medium_write,
+	},
+	{
+		.name = "pressure_level_critical",
+		.read_u64 = mem_cgroup_pressure_level_critical_read,
+		.write_u64 = mem_cgroup_pressure_level_critical_write,
+	},
 #ifdef CONFIG_NUMA
 	{
 		.name = "numa_stat",
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index d69019fc3789..6fc680dec971 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -21,52 +21,6 @@
 #include <linux/printk.h>
 #include <linux/vmpressure.h>
 
-/*
- * The window size (vmpressure_win) is the number of scanned pages before
- * we try to analyze scanned/reclaimed ratio. So the window is used as a
- * rate-limit tunable for the "low" level notification, and also for
- * averaging the ratio for medium/critical levels. Using small window
- * sizes can cause lot of false positives, but too big window size will
- * delay the notifications.
- *
- * As the vmscan reclaimer logic works with chunks which are multiple of
- * SWAP_CLUSTER_MAX, it makes sense to use it for the window size as well.
- *
- * TODO: Make the window size depend on machine size, as we do for vmstat
- * thresholds. Currently we set it to 512 pages (2MB for 4KB pages).
- */
-static const unsigned long vmpressure_win = SWAP_CLUSTER_MAX * 16;
-
-/*
- * These thresholds are used when we account memory pressure through
- * scanned/reclaimed ratio. The current values were chosen empirically. In
- * essence, they are percents: the higher the value, the more number
- * unsuccessful reclaims there were.
- */
-static const unsigned int vmpressure_level_med = 60;
-static const unsigned int vmpressure_level_critical = 95;
-
-/*
- * When there are too little pages left to scan, vmpressure() may miss the
- * critical pressure as number of pages will be less than "window size".
- * However, in that case the vmscan priority will raise fast as the
- * reclaimer will try to scan LRUs more deeply.
- *
- * The vmscan logic considers these special priorities:
- *
- * prio == DEF_PRIORITY (12): reclaimer starts with that value
- * prio <= DEF_PRIORITY - 2 : kswapd becomes somewhat overwhelmed
- * prio == 0                : close to OOM, kernel scans every page in an lru
- *
- * Any value in this range is acceptable for this tunable (i.e. from 12 to
- * 0). Current value for the vmpressure_level_critical_prio is chosen
- * empirically, but the number, in essence, means that we consider
- * critical level when scanning depth is ~10% of the lru size (vmscan
- * scans 'lru_size >> prio' pages, so it is actually 12.5%, or one
- * eights).
- */
-static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
-
 static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 {
 	return container_of(work, struct vmpressure, work);
@@ -109,17 +63,18 @@ static const char * const vmpressure_str_modes[] = {
 	[VMPRESSURE_LOCAL] = "local",
 };
 
-static enum vmpressure_levels vmpressure_level(unsigned long pressure)
+static enum vmpressure_levels vmpressure_level(struct vmpressure *vmpr,
+						unsigned long pressure)
 {
-	if (pressure >= vmpressure_level_critical)
+	if (pressure >= vmpr->level_critical)
 		return VMPRESSURE_CRITICAL;
-	else if (pressure >= vmpressure_level_med)
+	else if (pressure >= vmpr->level_medium)
 		return VMPRESSURE_MEDIUM;
 	return VMPRESSURE_LOW;
 }
 
-static enum vmpressure_levels vmpressure_calc_level(unsigned long scanned,
-						    unsigned long reclaimed)
+static enum vmpressure_levels vmpressure_calc_level(struct vmpressure *vmpr,
+			unsigned long scanned, unsigned long reclaimed)
 {
 	unsigned long scale = scanned + reclaimed;
 	unsigned long pressure = 0;
@@ -145,7 +100,7 @@ static enum vmpressure_levels vmpressure_calc_level(unsigned long scanned,
 	pr_debug("%s: %3lu  (s: %lu  r: %lu)\n", __func__, pressure,
 		 scanned, reclaimed);
 
-	return vmpressure_level(pressure);
+	return vmpressure_level(vmpr, pressure);
 }
 
 struct vmpressure_event {
@@ -207,7 +162,7 @@ static void vmpressure_work_fn(struct work_struct *work)
 	vmpr->tree_reclaimed = 0;
 	spin_unlock(&vmpr->sr_lock);
 
-	level = vmpressure_calc_level(scanned, reclaimed);
+	level = vmpressure_calc_level(vmpr, scanned, reclaimed);
 
 	do {
 		if (vmpressure_event(vmpr, level, ancestor, signalled))
@@ -273,7 +228,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		vmpr->tree_reclaimed += reclaimed;
 		spin_unlock(&vmpr->sr_lock);
 
-		if (scanned < vmpressure_win)
+		if (scanned < vmpr->window)
 			return;
 		schedule_work(&vmpr->work);
 	} else {
@@ -286,14 +241,14 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		spin_lock(&vmpr->sr_lock);
 		scanned = vmpr->scanned += scanned;
 		reclaimed = vmpr->reclaimed += reclaimed;
-		if (scanned < vmpressure_win) {
+		if (scanned < vmpr->window) {
 			spin_unlock(&vmpr->sr_lock);
 			return;
 		}
 		vmpr->scanned = vmpr->reclaimed = 0;
 		spin_unlock(&vmpr->sr_lock);
 
-		level = vmpressure_calc_level(scanned, reclaimed);
+		level = vmpressure_calc_level(vmpr, scanned, reclaimed);
 
 		if (level > VMPRESSURE_LOW) {
 			/*
@@ -322,21 +277,23 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
  */
 void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio)
 {
+	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
+
 	/*
 	 * We only use prio for accounting critical level. For more info
-	 * see comment for vmpressure_level_critical_prio variable above.
+	 * see comment for vmpressure level_critical_prio variable above.
 	 */
-	if (prio > vmpressure_level_critical_prio)
+	if (prio > vmpr->level_critical_prio)
 		return;
 
 	/*
 	 * OK, the prio is below the threshold, updating vmpressure
 	 * information before shrinker dives into long shrinking of long
-	 * range vmscan. Passing scanned = vmpressure_win, reclaimed = 0
+	 * range vmscan. Passing scanned = vmpr->window, reclaimed = 0
 	 * to the vmpressure() basically means that we signal 'critical'
 	 * level.
 	 */
-	vmpressure(gfp, memcg, true, vmpressure_win, 0);
+	vmpressure(gfp, memcg, true, vmpr->window, 0);
 }
 
 #define MAX_VMPRESSURE_ARGS_LEN	(strlen("critical") + strlen("hierarchy") + 2)
@@ -450,6 +407,30 @@ void vmpressure_init(struct vmpressure *vmpr)
 	mutex_init(&vmpr->events_lock);
 	INIT_LIST_HEAD(&vmpr->events);
 	INIT_WORK(&vmpr->work, vmpressure_work_fn);
+
+	/*
+	 * As the vmscan reclaimer logic works with chunks which are multiple
+	 * of SWAP_CLUSTER_MAX, it makes sense to use it for the window size
+	 * as well.
+	 *
+	 * TODO: Make the window size depend on machine size, as we do for
+	 * vmstat thresholds. Now we set it to 512 pages (2MB for 4KB pages).
+	 */
+	vmpr->window = SWAP_CLUSTER_MAX * 16;
+
+	/*
+	 * Any value in this range is acceptable for this tunable (i.e. from
+	 * 12 to 0). Current value for the vmpressure level_critical_prio is
+	 * chosen empirically, but the number, in essence, means that we
+	 * consider critical level when scanning depth is ~10% of the lru size
+	 * (vmscan scans 'lru_size >> prio' pages, so it is actually 12.5%,
+	 * or one eights).
+	 */
+	vmpr->level_critical_prio = ilog2(100 / 10);
+
+	/* The current values were legacy and chosen empirically. */
+	vmpr->level_medium = 60;
+	vmpr->level_critical = 95;
 }
 
 /**
-- 
2.17.1

