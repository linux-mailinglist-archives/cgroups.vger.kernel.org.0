Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA8391CDA
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhEZQUS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhEZQUR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFECC061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d16so1287152pfn.12
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aj0wDGrf3506OWqgGnOpLsSVIAl44mT2D54DwojMHLc=;
        b=IpoTU6bBMLNJIY/bJBfraSLZcBrMG0J8S0TSD8IAYkrQ5gUi0gAOi/qWF1AuG7PiED
         X9oir5M8gFV/WO1qgS4Tqu9M2uZHFnQYlZza9124S5ZW3c7jAl2OhFTE+dyJLSVJzq8Q
         AAQRKsjhgDvqRr/qhfMwqD+dz1ArA7BCnw1xBjrhAzrZrrWwe11+PhO8nqnQH3TI6RjF
         J1KzlSjqSyishnFJaI8BnG+KxKnBwLpbjSKfJGIkV7+mSl1MsHo8J3aXLZ2odyjhm/gA
         2yxKmDmD7msHP9+Zu4oDLgui9oTK0FdPQhKzwp1NPtt4CGTgibiD5Lsat5b7VQf5BLoZ
         mQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aj0wDGrf3506OWqgGnOpLsSVIAl44mT2D54DwojMHLc=;
        b=nDtBQiq1iBLcxKujaaIIz8+zIMUrhqayVuHOqNZjwpoHhhkek6rEN12g1YXqbpSSvg
         GlsmcN/uneaEhYPBSs6kvbU82n3PVd1AFyyO4+/upYQVVFmyapMWDVuIRajX/BxRrCVQ
         jcKjXhksBfsfeZ+ge41EMgrBW43u1k8c68k0tfPyW6lgBVW5pxzk9sDY37piOwJs3wxs
         VuKut6TWZ4fZ7NN3HZxG6kLDKOtX+WdW1GcxiHJyqyiztjLyT2rDNc1pLPWfkkthtzwW
         kst97uwIaIsVXDZREFfF7ZBwoxCnOo+mDKR7GTKLPmcMCPK7ftpzSkQ+RMlCXTTVNCuL
         4snA==
X-Gm-Message-State: AOAM530JnEp5I8nSf8bL8yxKF6nHQg4QVMcuf2a3GDHe8n70dbSo7GbE
        CvJ1HGlFXBcyYwox0mmoGc0=
X-Google-Smtp-Source: ABdhPJxlVaCl5O5obm7j8dnu6HBuGIbgV2RYMx6LJNhhFgyepBYcElNyl/j099GZMycmNiq21KtjtQ==
X-Received: by 2002:a63:f156:: with SMTP id o22mr25966853pgk.385.1622045925091;
        Wed, 26 May 2021 09:18:45 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:44 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 4/7] mm: introduce slice analysis into memory speed throttle mechanism
Date:   Thu, 27 May 2021 00:18:01 +0800
Message-Id: <5b82f959fb0ae1b0c5a830262c8a455a81da98ad.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

We separate the statistical period into 10 slices, count the memory
charge in each slice, and compare to the slice speed limit to determine
to turn on the throttle or not.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h |  4 ++++
 mm/memcontrol.c            | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 435515b1a709..230acdc635b5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -231,8 +231,12 @@ struct obj_cgroup {
 };
 
 #ifdef CONFIG_MEM_SPEED_THROTTLE
+#define MST_SLICE		(HZ/10)
 struct mem_spd_ctl {
 	unsigned long mem_spd_lmt;
+	unsigned long slice_lmt;
+	unsigned long prev_thl_jifs;
+	unsigned long prev_chg;
 	int has_lmt;
 };
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9d7a86f7f51c..05bf4ba0da15 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1403,6 +1403,9 @@ static void mem_cgroup_mst_msc_reset(struct mem_cgroup *memcg)
 	msc = &memcg->msc;
 	msc->has_lmt = 0;
 	msc->mem_spd_lmt = 0;
+	msc->slice_lmt = 0;
+	msc->prev_chg = 0;
+	msc->prev_thl_jifs = 0;
 }
 
 static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
@@ -1440,6 +1443,7 @@ static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 	lmt = val >> PAGE_SHIFT;
 
 	memcg->msc.mem_spd_lmt = lmt;
+	memcg->msc.slice_lmt = lmt * MST_SLICE / HZ;
 
 	/* Sync with mst_has_lmt_init*/
 	synchronize_rcu();
@@ -1452,6 +1456,27 @@ static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+/*
+ * Update the memory speed throttle slice window.
+ * Return 0 when we still in the previous slice window
+ * Return 1 when we start a new slice window
+ */
+static int mem_cgroup_update_mst_slice(struct mem_cgroup *memcg)
+{
+	unsigned long total_charge;
+	struct mem_spd_ctl *msc = &memcg->msc;
+
+	if (msc->prev_thl_jifs &&
+	    time_before(jiffies, (msc->prev_thl_jifs + MST_SLICE)))
+		return 0;
+
+	total_charge = atomic_long_read(&memcg->memory.total_chg);
+	msc->prev_chg = total_charge;
+	msc->prev_thl_jifs = jiffies;
+
+	return 1;
+}
+
 static unsigned long mem_cgroup_mst_get_mem_spd_max(struct mem_cgroup *memcg)
 {
 	struct page_counter *c = &memcg->memory;
-- 
2.28.0

