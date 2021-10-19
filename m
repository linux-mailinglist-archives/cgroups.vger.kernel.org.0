Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1674433A94
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhJSPge (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJSPgd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 11:36:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25731C061749
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 08:34:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x123-20020a626381000000b0044da6d19df6so166508pfb.3
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b4zuBMQ6rB3BJhMbiTI+bHBlQbKmGojFin0ETDqCqgs=;
        b=rFMa8vwet/lkvToH0oW1p+K5cFqa7WZrolQyzwr5vqQX//r/Z65baLysr7T2GaQULv
         8oJpbjYqV+ZCU+f10JFaYReHzKzhhZMU97gcW/GVrw0J8EMgaRITnTZ+aDP3YD2jzivp
         bFdR3kTffPL94z08NhW7pOPcUf/BaP2+SVGmhUUMzQa4d8rtdoIHuxUUl7t4Y/MM6bND
         EOPoxl6N3Yn+nPGBCM68QnnxI1FaOgkfjOS21e7UQtf8kEOiEpa1fC3pm11DahghiWu2
         EYOjMMffkS3e9gi+9DLre4UUmxC4X9vAJLvcmd/cX2GLBvCG7XLopZw5lF7JHX72a0il
         3NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b4zuBMQ6rB3BJhMbiTI+bHBlQbKmGojFin0ETDqCqgs=;
        b=eQW7zC+SrJjBOcSxwRLBL0EE0UjuR86VXIfT0H9WQbBFkRopc8OyWKSH6mUlGtSoVG
         GUOsNba3SmCoRFfc2104Y3o1a6fMa8XiF4M5wIVwJIJ5Na4VuUNpYsPYlZeIW/439SFK
         cKY6TwiqE5m79Xv+E6fUdSzN2QArTIClROieyiHDUku5RRekCr+N8PZTUx5MLVUc07O7
         9Wa5O2UusDSoUWsnVOHyI3dXFlq8ERg6+U94ZRKxPO53R3DNQyI8YTm2mVkAkdnRuLeZ
         2iA9XQrwE7BV9xtdVpgQrnu4PlNUIkLaRNMwFSM7Y4Ms0+JeYuiCIZJnvY3vGUoz/LP5
         U13g==
X-Gm-Message-State: AOAM531D7giJNim0KCzYzjKaWRXsH0M++m+Mccw6bDKRRAT9pGRWhQaP
        nlCjjg+QZebQEpYJ8JWJub0D+IqimhBvJQ==
X-Google-Smtp-Source: ABdhPJzz98WCn/tuXSCa52LIqDLVgmNtS4YTmeUTfl/rTTpuMN7stUpDc5QRcbsmesVGqSTReq6GbDy03xs1LQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6d48:cae4:d5cb:a596])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1c06:: with SMTP id
 oc6mr660557pjb.204.1634657660555; Tue, 19 Oct 2021 08:34:20 -0700 (PDT)
Date:   Tue, 19 Oct 2021 08:34:08 -0700
Message-Id: <20211019153408.2916808-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3] memcg, kmem: further deprecate kmem.limit_in_bytes
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The deprecation process of kmem.limit_in_bytes started with the commit
0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
explains in detail the motivation behind the deprecation. To summarize,
it is the unexpected behavior on hitting the kmem limit. This patch
moves the deprecation process to the next stage by disallowing to set
the kmem limit. In future we might just remove the kmem.limit_in_bytes
file completely.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v2:
- Updated the documentation

Changes since v1:
- Replaced EINVAL with ENOTSUPP on setting kmem limits.
- V1 was posted last year at [0].

[0] https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/

 .../admin-guide/cgroup-v1/memory.rst          | 11 ++----
 mm/memcontrol.c                               | 35 +++----------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5fb69d..faac50149a22 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -87,10 +87,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
-                                     This knob is deprecated and shouldn't be
-                                     used. It is planned that this be removed in
-                                     the foreseeable future.
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
@@ -518,11 +516,6 @@ will be charged as a new owner of it.
   charged file caches. Some out-of-use page caches may keep charged until
   memory pressure happens. If you want to avoid that, force_empty will be useful.
 
-  Also, note that when memory.kmem.limit_in_bytes is set the charges due to
-  kernel pages will still be seen. This is not considered a failure and the
-  write will still return success. In this case, it is expected that
-  memory.kmem.usage_in_bytes == memory.usage_in_bytes.
-
 5.2 stat file
 -------------
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f1d9c028897..49a76049a885 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2999,7 +2999,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 				   unsigned int nr_pages)
 {
-	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	int ret;
 
@@ -3009,21 +3008,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
-	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
-
-		/*
-		 * Enforce __GFP_NOFAIL allocation because callers are not
-		 * prepared to see failures and likely do not have any failure
-		 * handling code.
-		 */
-		if (gfp & __GFP_NOFAIL) {
-			page_counter_charge(&memcg->kmem, nr_pages);
-			goto out;
-		}
-		cancel_charge(memcg, nr_pages);
-		ret = -ENOMEM;
-	}
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_charge(&memcg->kmem, nr_pages);
 out:
 	css_put(&memcg->css);
 
@@ -3715,17 +3701,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-static int memcg_update_kmem_max(struct mem_cgroup *memcg,
-				 unsigned long max)
-{
-	int ret;
-
-	mutex_lock(&memcg_max_mutex);
-	ret = page_counter_set_max(&memcg->kmem, max);
-	mutex_unlock(&memcg_max_mutex);
-	return ret;
-}
-
 static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
 	int ret;
@@ -3791,10 +3766,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
-			ret = memcg_update_kmem_max(memcg, nr_pages);
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -ENOTSUPP;
 			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
-- 
2.33.0.1079.g6e70778dc9-goog

