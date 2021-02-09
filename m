Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1305315405
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhBIQgT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhBIQfQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:35:16 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F8C06174A
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c1so13409350qtc.1
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JImndmsZruI2C1aa1dopR18V9eBQ9GGWEux2+ACDfI=;
        b=zDNEXxbDs4BT85EflJmoufFx4I5xxFllQ8Pu6Om4yeZNczwyuUR71y5Ese3WBHbQAN
         JGDIQ+8JXJ+/gz1T/xGjEC2ycD3U7cGXFJHWj8EJezl+GXHroTMRR2d/fhK4+OWamyCV
         klnnxTxmgT6ypK507QMgM3HI41XKtbLebwyvIndcLIL0vbbABe9ZTCH2TIe5NZHIKryU
         nqNlZ32oSwBaFlw+3EaUb4UM2kXpg1YQSypqdRU95p0v3xzEiFBtSi7JaQ3ZEMm0Savp
         g92b3nVb2Ts1JqYGL52+aJHEDzAngukVDo6u32xquh6oESb8SYgOSVTluadUV0yQGowj
         +Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JImndmsZruI2C1aa1dopR18V9eBQ9GGWEux2+ACDfI=;
        b=mbpI16bJKakiwFMXd1pJs4iY2XH0yRU4EyOtIWo13mUMKdgKXGUV8ivdWHGSYeFbTq
         lQgikm7uWRJPQ6RM6CWEGr7jHDYRdsBkqHgdnmmIhqmA+i+uCL4nxJ2YUK/WGwd/TcpV
         cHGq4c/lAvs/SKXDaxY0nv7qwgW10SdYlj5CMQgrioJlmRd7YTHOdYRh+Bs7qS8nRRW8
         /Ajln/npH9/ve5Tg73VhDxLPnZhx0oYJqRkNZczZJHmsxFteqsoK/N5NUfnApAcePcRk
         NI54qPrLd1cw1ASqr/wVZc+EFXKiA3ZG8c9BMDNkMrxrahV5LQpfU4aI1t9rgsFt1d7K
         3Qxw==
X-Gm-Message-State: AOAM5314aaq3znAxKit4bV+eCmNfDuvcpWRU0KaT21k9jpEH+pRCxdNA
        uOUo+/hJ/Dznt01J2QytaCS+Hg==
X-Google-Smtp-Source: ABdhPJxnu6s2du40QBvnDM7qfMfMuI/8Fa9MumIziYktgoG8SrGe+yL07Fj8EcfgFC4K3sKRV+2qrA==
X-Received: by 2002:a05:622a:1c9:: with SMTP id t9mr20683927qtw.244.1612888417423;
        Tue, 09 Feb 2021 08:33:37 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h11sm18338466qkj.135.2021.02.09.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:36 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 8/8] kselftests: cgroup: update kmem test for new vmstat implementation
Date:   Tue,  9 Feb 2021 11:33:04 -0500
Message-Id: <20210209163304.77088-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With memcg having switched to rstat, memory.stat output is precise.
Update the cgroup selftest to reflect the expectations and error
tolerances of the new implementation.

Also add newly tracked types of memory to the memory.stat side of the
equation, since they're included in memory.current and could throw
false positives.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 0941aa16157e..22b31ebb3513 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -19,12 +19,12 @@
 
 
 /*
- * Memory cgroup charging and vmstat data aggregation is performed using
- * percpu batches 32 pages big (look at MEMCG_CHARGE_BATCH). So the maximum
- * discrepancy between charge and vmstat entries is number of cpus multiplied
- * by 32 pages multiplied by 2.
+ * Memory cgroup charging is performed using percpu batches 32 pages
+ * big (look at MEMCG_CHARGE_BATCH), whereas memory.stat is exact. So
+ * the maximum discrepancy between charge and vmstat entries is number
+ * of cpus multiplied by 32 pages.
  */
-#define MAX_VMSTAT_ERROR (4096 * 32 * 2 * get_nprocs())
+#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
 
 
 static int alloc_dcache(const char *cgroup, void *arg)
@@ -162,7 +162,7 @@ static int cg_run_in_subcgroups(const char *parent,
  */
 static int test_kmem_memcg_deletion(const char *root)
 {
-	long current, slab, anon, file, kernel_stack, sum;
+	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
 	int ret = KSFT_FAIL;
 	char *parent;
 
@@ -184,11 +184,14 @@ static int test_kmem_memcg_deletion(const char *root)
 	anon = cg_read_key_long(parent, "memory.stat", "anon ");
 	file = cg_read_key_long(parent, "memory.stat", "file ");
 	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
+	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
+	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
+	sock = cg_read_key_long(parent, "memory.stat", "sock ");
 	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
-	    kernel_stack < 0)
+	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
 		goto cleanup;
 
-	sum = slab + anon + file + kernel_stack;
+	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
 	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
@@ -198,6 +201,9 @@ static int test_kmem_memcg_deletion(const char *root)
 		printf("anon = %ld\n", anon);
 		printf("file = %ld\n", file);
 		printf("kernel_stack = %ld\n", kernel_stack);
+		printf("pagetables = %ld\n", pagetables);
+		printf("percpu = %ld\n", percpu);
+		printf("sock = %ld\n", sock);
 	}
 
 cleanup:
-- 
2.30.0

