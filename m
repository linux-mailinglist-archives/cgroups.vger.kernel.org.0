Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB3511F63
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbiD0QF4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiD0QEr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 12:04:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E93A0C70
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id p4so900431qtq.12
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBgzXdZ466rlUwUQs0EI6DMIFSVYYfxcwIa0A3d1nko=;
        b=fhTowtKO2j1gIyehsLjMg/Ft2943puC7KRcfEZIVbM5qcRk82f1+ST9TguF/qrnxuX
         a9bXww4C8aR196N7uarXdk5H0jokAohUVeAKI/HORyHGmZ//sbuDt6+a4Qwp1azl2rUE
         JIbm07to9H1IyQkS8DuWRRfE++12PUX7Sghe34t7kNHf57BKJBB1N2CWsKgZ9C2CMBZ7
         e422CKVuaMPKW92Hel8KMu/yHBGk762q8V3UB3iN2J1MjkSaZaEcKTsvc7W5hDRyVK07
         WHsfe42LQ8R/fNSho0yYxEdItM0KgOI//PeSkQ2WQ4B8zqqSFuNG6r4uzD/9r/CZiWcC
         0SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBgzXdZ466rlUwUQs0EI6DMIFSVYYfxcwIa0A3d1nko=;
        b=4mPujnN6CkkUP9cVx9i/6JjiWEV6FyaBXkMIqE9xPiioXVmIbUp1UzJzmgrfZ/VAIo
         HPRaFE4PmftkeV0IAsc1+lOXtsObrJMEXmjc9pHZFCWfVr1GmqCBL1qrJXsh5EFKNfCu
         J07ftc3936m+NT6O47YkZ2TqO7vLj8x8vUuDK1GKkiZ1sFyHBfJn0X+0knHagKOtsPLL
         t9F291ZM+tAMARWcMFEVJX9G+WzY8X7KBYNznPiw56Ud6MlB3CKgNRwZChKAWWdHJC4x
         ImeBlnO4I1fNw9VsIjlsmMzhEfz4QoK+q3MYwpayltPri3vwY6NkjvbVHWMuX/xI22Et
         OgJw==
X-Gm-Message-State: AOAM530Qs8wxB62cl5N6VMLzhvGmzAZPmNnePDEiu9pIc7UOO7kqux08
        CsfXyK39Fq4FnBZcdIkt5fIrEA==
X-Google-Smtp-Source: ABdhPJxXvzVjG81fUfBnZdK0tLhIy90Z/zLg6n1UAWZwTJ3z7Kz21ZTF6uUj9GZ0GVWofbPhgz5MPQ==
X-Received: by 2002:a05:622a:342:b0:2f3:5c21:1bed with SMTP id r2-20020a05622a034200b002f35c211bedmr17432648qtw.123.1651075263679;
        Wed, 27 Apr 2022 09:01:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm7837059qkm.111.2022.04.27.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:01:03 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Date:   Wed, 27 Apr 2022 12:00:15 -0400
Message-Id: <20220427160016.144237-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427160016.144237-1-hannes@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/proc/meminfo.c             |  7 +++++++
 include/linux/swap.h          |  5 +++++
 include/linux/vm_event_item.h |  4 ++++
 mm/vmstat.c                   |  4 ++++
 mm/zswap.c                    | 13 ++++++-------
 5 files changed, 26 insertions(+), 7 deletions(-)

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

