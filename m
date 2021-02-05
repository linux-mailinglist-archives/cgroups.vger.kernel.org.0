Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D977310FFA
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBEQus (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 11:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhBEQso (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:48:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C5C061A27
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id k193so7854312qke.6
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOIw4B/+XCkxqjVq4ULIq5aMnPErv/ZIiEkm9Qo0mIY=;
        b=idJT7y3SE1/7kfbEc9LO0zxd5v0/lc3uRviS/yKpvk1qGeWsTpJc+f5tyW0Ojr2CaC
         DOb2xjm355MkcBLUlQKt1LNt2Id4DsxDmXUgxkqZ9JGJJMyh456qCekFMvTRZyGz/2l+
         OzT3PIYYyHKW0lBosOj2ryMkSu7+e7+qyS43BfMCOSnIwGtLcziwXyfikExd7JNpyH1/
         l+/KVjav/lOTYOb/Dr+TKFz8wjZcRUl5SuY5AWvq+oABg4czWSmzQlnNMNMfbEUn9S2m
         bYErICkXlUGO+LrrVUP24yY9ckXylg3VyLAeAmX4ChtGlqTGJ9aGdxAHHD5zhRzfw7nW
         ZybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOIw4B/+XCkxqjVq4ULIq5aMnPErv/ZIiEkm9Qo0mIY=;
        b=FrtIvBFUYsMw8Tfbjtzkd2x9Wlzr6psGp+VwxrI4BU1Jcr+L1bX7MWUV7EPmqmFzGL
         NuYLYu9huQKghQoPfMGQkGqXVZVPwsfjYcsrA97KeClgj/+46oY30dXdASDukEZZob99
         7fqhpPGauUVVR567MwwAoikI5ZEBhBt/Ft/A/6RIb4gAVUOEz0cJ3KqbR703rMo3l9Oq
         3bhXezcM2a1buAsi3w822/a1sPoSKJAF8M6vRNn8SIW3GhUgmLSejydViatdGbQcNYa8
         Vm2LbyXE+U/93Ck0jQl4tKB5ct9TD9NhenpglnkeyBkz74dRCRsGEpDC6/Bc5SK/+e7j
         SwYA==
X-Gm-Message-State: AOAM5302d2Sn7ZioGRYGawnIVlxoPfqhuaQsJ0olEwkO3l84SgNtvO9v
        hxsIXyRb1B0arxK6XiP8kgqH6A==
X-Google-Smtp-Source: ABdhPJx1bFPwDEi8o9N0+OS7xWzsabm8/MDTIqsnLwpTyz37OxupQJ3kC6GDspFubixnbNJLuuy+Xg==
X-Received: by 2002:a05:620a:901:: with SMTP id v1mr5351386qkv.331.1612549717227;
        Fri, 05 Feb 2021 10:28:37 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j188sm9863366qke.67.2021.02.05.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:36 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 8/8] kselftests: cgroup: update kmem test for new vmstat implementation
Date:   Fri,  5 Feb 2021 13:28:06 -0500
Message-Id: <20210205182806.17220-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
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

