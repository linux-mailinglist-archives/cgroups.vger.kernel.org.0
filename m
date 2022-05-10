Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC9521EC4
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbiEJPfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbiEJPfB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 11:35:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF285E3C
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w3so13452607qkb.3
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yG/TJhB6zlP07vbHCoo0HduI7PCeWdcxAz4SbIPm6g=;
        b=hYXYP5PLEeo7CWqbg91X9DjtuKyxX3nuIcfj1DY2YZFuCI5Tv7eKMNmOdMMJBXnitY
         InB3K9/dKqFuwniT0XOjIT8ag03Bi2rdY0zELe1bydaRxxCmhT5XBDYhHcRATBD0gTW9
         82aWLEwfg8Rw3dU355CL5bO+YfQfs0siYNI5qgEYs3DiW5le4KD1r+E/pLdI+7Ysl3NX
         0REqoFrifGI+iD/68c+EE7P0/2RWWWJzWXsGiUSDNvbEyYx99U1dh6t/ArTtwqqdkTKl
         nLctnuV1D650TjZnkMxYRIpcGyxQF52r3Op/D0hEAL6Mwq+g+TIr02XEcBr+6zgtYOd6
         InYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yG/TJhB6zlP07vbHCoo0HduI7PCeWdcxAz4SbIPm6g=;
        b=yHRPW5/nBEoypiMjrfWSMDuODRBwyNaGW2Pcg/9/sgoQUjroNdy/w7i9Q1aZob5uF7
         1SuHZOTSxuPaYsTRg68ZH7fFH3MKwSVSClLhkPLbsLqLbpHcuRIGN3tFrl7rOgnJPwuP
         khu/LbmmOj7oYOFencD+tPltWy6l74dN8jC3jSp8uhYwjG+r1izHON7vd8YOBMJ5nK31
         HkT05Vb2rW5RcVJ50c6v4Q8rU2lUNMN3/8bxyCFwieePDLDhE+q+0tsv8kew8I4/sPbm
         CCiPQ5MFxtCPyAX2ppwmyOoe/7gU2Jw37bGZHgl1vdqYgUUTC1d+c/9L5jjal8xqFwW4
         foVQ==
X-Gm-Message-State: AOAM533O7aTVxUI2CkRKO3y0bKQR2A3DzmTdAJcOLTCp/KhXOHnJJLtB
        /cA2roWBGAZthGLEUVhP9NN9QA==
X-Google-Smtp-Source: ABdhPJyucBzn1eWtc39b2AFRaNrcSbuHwWk1zc2HHoamdwqK54Qc28s2rG3nKGAsvZFUY7B0kFb9UQ==
X-Received: by 2002:a37:a887:0:b0:69f:ba47:1212 with SMTP id r129-20020a37a887000000b0069fba471212mr16022649qke.206.1652196594096;
        Tue, 10 May 2022 08:29:54 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id r189-20020a37a8c6000000b0069c72b41b59sm8688118qke.2.2022.05.10.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:29:53 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 5/6] mm: zswap: add basic meminfo and vmstat coverage
Date:   Tue, 10 May 2022 11:28:46 -0400
Message-Id: <20220510152847.230957-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220510152847.230957-1-hannes@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently it requires poking at debugfs to figure out the size and
population of the zswap cache on a host. There are no counters for
reads and writes against the cache. As a result, it's difficult to
understand zswap behavior on production systems.

Print zswap memory consumption and how many pages are zswapped out in
/proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/filesystems/proc.rst |  6 ++++++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/swap.h               |  5 +++++
 include/linux/vm_event_item.h      |  4 ++++
 mm/vmstat.c                        |  4 ++++
 mm/zswap.c                         | 13 ++++++-------
 6 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 736ed384750c..8b5a94cfa722 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -964,6 +964,8 @@ Example output. You may not have all of these fields.
     Mlocked:               0 kB
     SwapTotal:             0 kB
     SwapFree:              0 kB
+    Zswap:              1904 kB
+    Zswapped:           7792 kB
     Dirty:                12 kB
     Writeback:             0 kB
     AnonPages:       4654780 kB
@@ -1055,6 +1057,10 @@ SwapTotal
 SwapFree
               Memory which has been evicted from RAM, and is temporarily
               on the disk
+Zswap
+              Memory consumed by the zswap backend (compressed size)
+Zswapped
+              Amount of anonymous memory stored in zswap (original size)
 Dirty
               Memory which is waiting to get written back to the disk
 Writeback
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..6e89f0e2fd20 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	show_val_kb(m, "SwapTotal:      ", i.totalswap);
 	show_val_kb(m, "SwapFree:       ", i.freeswap);
+#ifdef CONFIG_ZSWAP
+	seq_printf(m,  "Zswap:          %8lu kB\n",
+		   (unsigned long)(zswap_pool_total_size >> 10));
+	seq_printf(m,  "Zswapped:       %8lu kB\n",
+		   (unsigned long)atomic_read(&zswap_stored_pages) <<
+		   (PAGE_SHIFT - 10));
+#endif
 	show_val_kb(m, "Dirty:          ",
 		    global_node_page_state(NR_FILE_DIRTY));
 	show_val_kb(m, "Writeback:      ",
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b82c196d8867..07074afa79a7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -632,6 +632,11 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 }
 #endif
 
+#ifdef CONFIG_ZSWAP
+extern u64 zswap_pool_total_size;
+extern atomic_t zswap_stored_pages;
+#endif
+
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 extern void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
 static inline  void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 5e80138ce624..1ce8fadb2b1c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -132,6 +132,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_KSM
 		COW_KSM,
 #endif
+#ifdef CONFIG_ZSWAP
+		ZSWPIN,
+		ZSWPOUT,
+#endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4a2aa2fa88db..da7e389cf33c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1392,6 +1392,10 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_KSM
 	"cow_ksm",
 #endif
+#ifdef CONFIG_ZSWAP
+	"zswpin",
+	"zswpout",
+#endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 2c5db4cbedea..e3c16a70f533 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -42,9 +42,9 @@
 * statistics
 **********************************/
 /* Total bytes used by the compressed storage */
-static u64 zswap_pool_total_size;
+u64 zswap_pool_total_size;
 /* The number of compressed pages currently stored in zswap */
-static atomic_t zswap_stored_pages = ATOMIC_INIT(0);
+atomic_t zswap_stored_pages = ATOMIC_INIT(0);
 /* The number of same-value filled pages currently stored in zswap */
 static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
 
@@ -1243,6 +1243,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
 	zswap_update_total_size();
+	count_vm_event(ZSWPOUT);
 
 	return 0;
 
@@ -1285,11 +1286,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		zswap_fill_page(dst, entry->value);
 		kunmap_atomic(dst);
 		ret = 0;
-		goto freeentry;
+		goto stats;
 	}
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-
 		tmp = kmalloc(entry->length, GFP_ATOMIC);
 		if (!tmp) {
 			ret = -ENOMEM;
@@ -1304,10 +1304,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-
 		memcpy(tmp, src, entry->length);
 		src = tmp;
-
 		zpool_unmap_handle(entry->pool->zpool, entry->handle);
 	}
 
@@ -1326,7 +1324,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		kfree(tmp);
 
 	BUG_ON(ret);
-
+stats:
+	count_vm_event(ZSWPIN);
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
-- 
2.35.3

