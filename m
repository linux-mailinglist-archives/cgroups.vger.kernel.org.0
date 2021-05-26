Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F51391CDB
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhEZQUX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhEZQUW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB3C061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so620786pjt.1
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIlUJpv9owS7BaT6w3H8IfsbCFIbYiBLvFZ1cZUl/0o=;
        b=X0LAMmzw6u54bigaJR6dXXV+agl+onQ2Ryn0UVnDG3V4uD9cc5ZhY+xAsdJ9GBJ6OH
         KazZ6hBx3+KliIenVHQEDxMf7Z0tYRVp22rTakurBKfKakKvr4KpyEvtbBUmtdz1w5Gt
         9PYMBiVEwi2JP2ZWM8zImBkjyiXKD2sOkWnU2GgX+5zbTjhSF5T+JMqEjDNRfte6qmGy
         Tepyc7JG0aqw7rfpQmUkEGXP6B+xKXnrDc9LhUW7mryfJBFhWz9M/8tcE5exbqjDnGl6
         P0H1OT+o17AlSL0U3IZX03gnRvxt6nH8z3p5ggnuR+IEcO0fv+RoeAgfB944DhrHTqoT
         n4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIlUJpv9owS7BaT6w3H8IfsbCFIbYiBLvFZ1cZUl/0o=;
        b=QTyFXPEdRtXz3JJz+Rm+J98KNIlZpQbEsE/syv3t6l0wvFGDihy4bAAKZXH7eEkZCs
         /RPvZ14Gd9jN+Z13aQJkX/CtwcRzFaCmTbKaJvvvnXLVYHDFQiYODiZYlwBwO6a8i6le
         ArRpmKMBK2H3kITu9/mqhPi4/vcEVOcU1NgMtss9yVAHxYIOGJZ1my2LeDTVgjUzAJpf
         t/UA2E1TKOM6yovE/BUUfxrmlynssU6NXhigY7LnDY58JalrXMM5iYPlZB74Z4yRwEFc
         rej3GRuYHknrQlTUUiBoWKcZVJbsSf6qvCk+vwKeW1yF5GvVK+T0hHn+VYbbjdLIFyx/
         XrxA==
X-Gm-Message-State: AOAM533GcBNcuoEWGa5Kxkp2GPV8/Gj3e/S319F82/RVEnfov6nFR2cA
        JUzAVwguMqt+seSqg9gYYeU=
X-Google-Smtp-Source: ABdhPJzWxAppqQXzD2naz1vLN8vJYlncsyLR4jySXkGQvmIpBysAhmedotOnuTzJ9NPT32pe2S3tbg==
X-Received: by 2002:a17:902:265:b029:fa:9420:d2fd with SMTP id 92-20020a1709020265b02900fa9420d2fdmr14985015plc.39.1622045929697;
        Wed, 26 May 2021 09:18:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:49 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: [RFC 5/7] mm: introduce memory allocation speed throttle
Date:   Thu, 27 May 2021 00:18:02 +0800
Message-Id: <c2488d1e324f6b2a2cbfd32dd6f6f2423096fef8.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

In the memory charge handling, check if the allocated memory
exceed the limitation in each slice period, then throttle
the executing for a while to lower the memory allocation speed
in memory cgroup to avoid triggering the direct reclaim frequently.

Signed-off-by: Jiang Biao <benbjiang@gmail.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h |   1 +
 mm/memcontrol.c            | 103 +++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 230acdc635b5..b20820f7fdbf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -238,6 +238,7 @@ struct mem_spd_ctl {
 	unsigned long prev_thl_jifs;
 	unsigned long prev_chg;
 	int has_lmt;
+	atomic_t updating;
 };
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05bf4ba0da15..a1e33a9e6594 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1445,7 +1445,7 @@ static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 	memcg->msc.mem_spd_lmt = lmt;
 	memcg->msc.slice_lmt = lmt * MST_SLICE / HZ;
 
-	/* Sync with mst_has_lmt_init*/
+	/* Sync with mst_has_lmt_init and mem_cgroup_mst_overlmt_tree */
 	synchronize_rcu();
 
 	if (lmt) {
@@ -1458,23 +1458,109 @@ static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 
 /*
  * Update the memory speed throttle slice window.
- * Return 0 when we still in the previous slice window
- * Return 1 when we start a new slice window
+ * Return the prev charged page number before next slice
+ * refresh the total charge so that the overspeed exam logic
+ * can check if the quota is exceeded.
  */
 static int mem_cgroup_update_mst_slice(struct mem_cgroup *memcg)
 {
 	unsigned long total_charge;
 	struct mem_spd_ctl *msc = &memcg->msc;
+	unsigned long prev_chg = msc->prev_chg;
 
 	if (msc->prev_thl_jifs &&
 	    time_before(jiffies, (msc->prev_thl_jifs + MST_SLICE)))
-		return 0;
+		goto exit;
+
+	/* Bail out if other's updating */
+	if (atomic_cmpxchg(&msc->updating, 0, 1) != 0)
+		goto exit;
 
 	total_charge = atomic_long_read(&memcg->memory.total_chg);
 	msc->prev_chg = total_charge;
 	msc->prev_thl_jifs = jiffies;
+	atomic_set(&msc->updating, 0);
 
-	return 1;
+exit:
+	return prev_chg;
+}
+
+/*
+ * Check if the memory allocate speed is exceed the limits.
+ * Return 0 when it is within the limits.
+ * Return the value of actual time frame should be used for the
+ * allocation when it exceeds the limits.
+ */
+static int mem_cgroup_mst_overspd(struct mem_cgroup *memcg)
+{
+	struct mem_spd_ctl *msc = &memcg->msc;
+	unsigned long total_charge;
+	unsigned long usage, prev_chg;
+
+	prev_chg = mem_cgroup_update_mst_slice(memcg);
+
+	total_charge = atomic_long_read(&memcg->memory.total_chg);
+	usage = total_charge <= prev_chg ?
+		      0 : total_charge - prev_chg;
+
+	if (usage < msc->slice_lmt)
+		return 0;
+	else
+		return (usage * MST_SLICE) / msc->slice_lmt;
+}
+
+static int mem_cgroup_mst_overspd_tree(struct mem_cgroup *memcg)
+{
+	struct cgroup_subsys_state *css = &memcg->css;
+	struct mem_cgroup *iter = memcg;
+	int no_lmt = 1;
+	int ret = 0;
+
+	rcu_read_lock();
+	while (!mem_cgroup_is_root(iter)) {
+		if (iter->msc.mem_spd_lmt) {
+			no_lmt = 0;
+			ret = mem_cgroup_mst_overspd(iter);
+			if (ret) {
+				rcu_read_unlock();
+				return ret;
+			}
+		}
+		css = css->parent;
+		iter = mem_cgroup_from_css(css);
+	}
+
+	/* Mst has been disabled */
+	if (no_lmt)
+		mem_cgroup_mst_msc_reset(memcg);
+
+	rcu_read_unlock();
+	return ret;
+}
+
+static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
+{
+	struct mem_spd_ctl *msc = &memcg->msc;
+	long timeout;
+	int ret = 0;
+
+	if (!memcg->msc.has_lmt || in_interrupt() || in_atomic() ||
+		irqs_disabled() || oops_in_progress)
+		return;
+
+	ret = mem_cgroup_mst_overspd_tree(memcg);
+	if (!ret)
+		return;
+
+	/*
+	 * Throttle the allocation for amount of jiffies according to
+	 * the fraction between the actual memory usage and allowed
+	 * allocation speed
+	 */
+	timeout = ret - (jiffies - msc->prev_thl_jifs);
+
+	if (timeout > 0)
+		schedule_timeout_interruptible(timeout);
 }
 
 static unsigned long mem_cgroup_mst_get_mem_spd_max(struct mem_cgroup *memcg)
@@ -1501,6 +1587,10 @@ static void mem_cgroup_mst_show_mem_spd_max(struct mem_cgroup *memcg,
 		   mem_cgroup_mst_get_mem_spd_max(memcg));
 }
 #else /* CONFIG_MEM_SPEED_THROTTLE */
+static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
+{
+}
+
 static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
 {
 }
@@ -2778,6 +2868,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 
 done_restock:
+	/* Try to throttle allocation speed if needed */
+	mem_cgroup_mst_spd_throttle(memcg);
+
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
-- 
2.28.0

