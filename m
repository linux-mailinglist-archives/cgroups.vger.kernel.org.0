Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0C391CDC
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhEZQU1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhEZQU0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D6C061756
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso638003pjq.3
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQ040QfcPG4lHUi4S0IEUYk2U7PBxtj8LmdZLbyNSis=;
        b=DTr76h8fO+Od5pZx0kuxRvXY9JknFBdGEDQqcSpfO88BQBthVVuifFlteZt2EpcI3s
         vNmfenAlhMAEmAADaBDQp3v6L4SqONcJnxl19ESUK5+D/wQ3FilO3hpJtccIICkPlPfU
         gWHvYCAeSrIMHcS78AbQfawpcUEIeg10EEpDJ0SDYhl0O5h1HXDdKpoPvmyAOZF1tqqR
         Lw5UlNG0YUqNvgodO2nyl1JCTiIvxk6VzVZUy1+0qKVz1aEThq/PUMwpWacqY0y678WF
         dVoIJ0tjKlSLZkdFNNEx0iXTAp4ohaPscDuPjKI5Rk4mFXnCwACKPA7cKjI8dpeR9rf2
         O1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQ040QfcPG4lHUi4S0IEUYk2U7PBxtj8LmdZLbyNSis=;
        b=Zb37Us74ovkpq/KBs3EXRYfQiprFBNTWY9HRbX1CnSfP9XhqcHTy93XRAvgmQeT0nE
         k1Umar3HTeJ1qsYt7K67f81w1It0yeo9BL26V38+08HMI57NOUHRsjPq+wN8S1BOw/W2
         HKk92K1Hrpugf7TpqRD4Fc+x94gFlCTUxHkt5pqhVEiY0nUG/vk2nbAXPHbrbBrDYMan
         WqwSiLUR9lW/M34RZChO/4Q/ZCo5PAGNIu3w3PJEjyDdXihynM11dpyRBDSXYEfTjAmv
         bokz5u9mW8HcM8JXuZKqxPzVUyJ1r3JejBKRgjcYApXLkknfa1rWZACppnS57OM0RtsC
         B6SQ==
X-Gm-Message-State: AOAM530/plaXJujLgPIS2sl2b23qVW0CD9HG4nQAJYZWeGj95FA9sQv9
        jLWvIcSFh1QhVxsaZcEOoyo=
X-Google-Smtp-Source: ABdhPJzOf71UQgW6t/4MKeeESSLfiMRj9uD9QA9yaRfYYpU7mMwurAWWQznJ2hMubxmXwa+HHCkk5Q==
X-Received: by 2002:a17:902:bc88:b029:ee:7ef1:e770 with SMTP id bb8-20020a170902bc88b02900ee7ef1e770mr36724857plb.19.1622045933576;
        Wed, 26 May 2021 09:18:53 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:53 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: [RFC 6/7] mm: record the numbers of memory allocation throttle
Date:   Thu, 27 May 2021 00:18:03 +0800
Message-Id: <46a38b81ebd7b43b6603249aea1d2361634b6c27.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Record the number of times we trigger the memory allocation
throttle.

Signed-off-by: Jiang Biao <benbjiang@gmail.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b20820f7fdbf..59e6cb78a07a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -239,6 +239,7 @@ struct mem_spd_ctl {
 	unsigned long prev_chg;
 	int has_lmt;
 	atomic_t updating;
+	atomic_long_t nr_throttled;
 };
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a1e33a9e6594..ca39974403a3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1401,11 +1401,19 @@ static void mem_cgroup_mst_msc_reset(struct mem_cgroup *memcg)
 		return;
 
 	msc = &memcg->msc;
-	msc->has_lmt = 0;
-	msc->mem_spd_lmt = 0;
-	msc->slice_lmt = 0;
-	msc->prev_chg = 0;
-	msc->prev_thl_jifs = 0;
+	while (msc->prev_thl_jifs ||
+	    msc->prev_chg ||
+	    msc->slice_lmt ||
+	    msc->mem_spd_lmt ||
+	    msc->has_lmt ||
+	    atomic_long_read(&msc->nr_throttled)) {
+		atomic_long_set(&msc->nr_throttled, 0);
+		msc->has_lmt = 0;
+		msc->mem_spd_lmt = 0;
+		msc->slice_lmt = 0;
+		msc->prev_chg = 0;
+		msc->prev_thl_jifs = 0;
+	}
 }
 
 static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
@@ -1552,6 +1560,8 @@ static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
 	if (!ret)
 		return;
 
+	atomic_long_inc(&msc->nr_throttled);
+
 	/*
 	 * Throttle the allocation for amount of jiffies according to
 	 * the fraction between the actual memory usage and allowed
@@ -1586,11 +1596,22 @@ static void mem_cgroup_mst_show_mem_spd_max(struct mem_cgroup *memcg,
 	seq_printf(m, "mst_mem_spd_max %lu\n",
 		   mem_cgroup_mst_get_mem_spd_max(memcg));
 }
+
+static void mem_cgroup_mst_show_nr_throttled(struct mem_cgroup *memcg,
+					     struct seq_file *m)
+{
+	seq_printf(m, "mst_nr_throttled %lu\n",
+		   atomic_long_read(&memcg->msc.nr_throttled));
+}
 #else /* CONFIG_MEM_SPEED_THROTTLE */
 static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
 {
 }
 
+static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
+{
+}
+
 static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
 {
 }
@@ -1678,6 +1699,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 #ifdef CONFIG_MEM_SPEED_THROTTLE
 	seq_buf_printf(&s, "mst_mem_spd_max %lu\n",
 		mem_cgroup_mst_get_mem_spd_max(memcg));
+	seq_buf_printf(&s, "mst_nr_throttled %lu\n",
+		atomic_long_read(&memcg->msc.nr_throttled));
 #endif
 
 	/* The above should easily fit into one page */
@@ -4131,6 +4154,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 #endif
 
 	mem_cgroup_mst_show_mem_spd_max(memcg, m);
+	mem_cgroup_mst_show_nr_throttled(memcg, m);
 
 	return 0;
 }
-- 
2.28.0

