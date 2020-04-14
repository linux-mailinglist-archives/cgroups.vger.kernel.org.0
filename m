Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7441A891C
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503774AbgDNSUX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:20:23 -0400
Received: from mx0a-001e9b01.pphosted.com ([148.163.157.123]:64812 "EHLO
        mx0a-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503749AbgDNSUU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:20:20 -0400
Received: from pps.filterd (m0088346.ppops.net [127.0.0.1])
        by mx0a-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EIApiJ028282
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp09042018;
 bh=Dv3UvEwpCi4jESuyvPDt9RT/r6mt0Dc/0n/8JWDuNrs=;
 b=Uw0Y/0j83B5knnbL1l7+CCj6/NVinyWEZNA/tUA5TMdM83ra1WhmzrLJv0bnEdzysvbf
 Ius962lpgM5fLSMmasrsdp+6bz5Ez6fLIzRocdtw3GKJ7FKaURqT7sgysrW3OdTRxTCJ
 nICrrwFkplQqhTM3x49IVh8dE3VmZny0LwmBlx9a5hBoDu2shM+TLIQ93igXx6GOZbuE
 lshqYSKgTQyyksIZg2oz6+nGCQjs8j2A0nLueWnwgIlbbM5s9maXmABHCcly/WNhf8OQ
 Xnw5Z68jq6Cxut6su3G2dIcQCmd1uZVXB76aO5X0UPKKYa7ZV2GALXdS3ihew2QSTOlw iQ== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mx0a-001e9b01.pphosted.com with ESMTP id 30cg881qxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:20:19 -0400
Received: by mail-qt1-f200.google.com with SMTP id h1so5919479qtu.13
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dv3UvEwpCi4jESuyvPDt9RT/r6mt0Dc/0n/8JWDuNrs=;
        b=ril3ON2SzMtyXGNZJKkXN6Ll4OM3JXfsnopRqLdtceWY8rKpRzQ5S6FmqUWL+2t4zM
         GUuPPpC8uIYV6rSB4TcvsT9K3J2KMlVcJiB8Xv4fxxL0LhvcLiHSjWOScE+ngczo/RvA
         3VaLh/gL4/TM7yRbkQxrzhwvBUNU753hKRXI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dv3UvEwpCi4jESuyvPDt9RT/r6mt0Dc/0n/8JWDuNrs=;
        b=eUAM/BB8SXw4WFzX+1qUCDUJu70UbirGof9DYa2OGsdtf5tO7M7m4HecYAPSVGYPix
         ywUhywQ4FXQm6RnDHrvHhF0WrK66UjSXhyQB2az56xbFg2tc2cBEq385ylj4nL7S0Wk5
         Ah6BQmHaoHu/QMoSml08vnObKPLP4jOPxIDc8IJKSSToWIMFQJD+Lu/B4NB5M4ZNBPk+
         i100p6FPjFd+FxViKOgrfdhxPvop6OKWetQxNCPzIht41q2YdE+KKJItwhtnZKbj+D52
         3d8c8lwy39VBBNEncUoBpSp/gOE0B2hQ+USQB9Qjy1yFmE6+sWEARyoJB4OBR2fsvP84
         B8rw==
X-Gm-Message-State: AGi0PuZLx3ijBnp3VhmSByGSiPUgE1zmI/cyx9c2jVX1tN2f9KU56Jl2
        R3SD29kjBCJaMiBJ/mZ81Dk/CNDxmUwtEZZUKsuaQ+69R49JXYvSHORZ7EgCPQ+AdtU7X28OBsQ
        GV1HfKL4FPPnDQ2xavg==
X-Received: by 2002:a1f:2ac4:: with SMTP id q187mr15948544vkq.6.1586884735552;
        Tue, 14 Apr 2020 10:18:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIhQFYlMEsm/N6tBDk7onUoEuloezK0Pgk8ZGs+E35cMrkTCeSwSD3g47QMfvaYNzJ95ZuaWg==
X-Received: by 2002:a1f:2ac4:: with SMTP id q187mr15948517vkq.6.1586884735176;
        Tue, 14 Apr 2020 10:18:55 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id z79sm4252684vkd.35.2020.04.14.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:18:54 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH v1 2/2] memcg, vmpressure: expose vmpressure controls
Date:   Tue, 14 Apr 2020 13:18:40 -0400
Message-Id: <20200414171840.22053-3-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
References: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_08:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140131
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

vmpressure code used hardcoded empirically selected values
to control levels and parameters for reclaiming pages which
might be not acceptable for all memory profiles.

This change exposed vmpressure controls with legacy defaults:
- memory.pressure_window (512 or SWAP_CLUSTER_MAX * 16)
- memory.pressure_level_critical_prio (3)
- memory.pressure_level_medium (60)
- memory.pressure_level_critical (95)

Depending from your device memory profile and running software
these parameters could be tweaked, e.g. for 8 GB Magic Leap One
device reasonable changes will be:
- memory.pressure_window = 1024
- memory.pressure_level_medium = 75
- memory.pressure_level_critical = 85

In case if your hardware uses 12 or 16 GB RAM the numbers should
be tuned respectively.

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

