Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573707A6970
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjISRO7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjISRO6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 13:14:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8A11A;
        Tue, 19 Sep 2023 10:14:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690b8859c46so1508244b3a.3;
        Tue, 19 Sep 2023 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695143690; x=1695748490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZLeb4KXoBpe/+0JVGwklZQFLVSlOWzYpckySccYFaM=;
        b=iqE+Vwmy2pgn7creeJ0hsgYx8iupqeQJyYapUCSSeAPG1W8bX0cfvuMvW3IctgXuOk
         UG8vV2FWaRRNMijHJRF3/GDxUOwNn29OLlzj26I4nR9mV7D6gBSIyAPJjIkQ9HsMBSE/
         0MFsWqW+6nD++h6YG3ziSM/u6Yt/xV9AtR0gyFzZaxPpKdhdSARUvFA23WYztyr8OaUZ
         tf2Lpd383HPY7wTe41GX5qnuqnNLIeMiJIiK5CBMjPQVWNhw5dhy3z7yCsoDLuyd9vYQ
         yMvlOrgfaNgXzfgi/FHRpxYHXCfMS+iPGY6sPkOy7iUZkoAdsW1QdM7V0tylGDMq1xAV
         lgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143690; x=1695748490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZLeb4KXoBpe/+0JVGwklZQFLVSlOWzYpckySccYFaM=;
        b=pdMXQ1esnMWVfuO7R4GX33nAcAN8uor/WFG6Md0fguaOMRNwgQPgxS5rN4nTuuLCwE
         R5C8jfuzP9x3i8QWUMbQp4THVmd8RenfyYzcV25Wi0BJEnDlooifZvrr9uOZab19bEMc
         Eq5xZHeI2pYG44l7ycg/CzoGRjmBjtVb8zQm7WjL+6DZlISfd6J5OMCQMZ9twJswQ05t
         pa4iFpS3exUu3pYncxHzPncjBxlwo53e3qN/oMzB84OyPvpRLi5Lzx53oSIuZ0ijSCD+
         Hc1JJC0cyREvM+4SoUpnFXRYgJrjBaxiNkLaTvStE9+C2S5rv0+Yj1tOnBxSGCKB2GMp
         2W6w==
X-Gm-Message-State: AOJu0YzcytjKeHmkMnLp1N+Onhk/VgZ8eHHQftsliFLEoE+Qfl98u4rW
        Sm0x8KnYasNUegZGzDBNRJs=
X-Google-Smtp-Source: AGHT+IGj4n5KOZE1ZcGkXAPrdrXcf4IqzOydB+G7fdWAli3loJHS/GIl+xUUTvsosEtx4gzvUUeWUQ==
X-Received: by 2002:a17:902:cec2:b0:1bf:66c3:d4d4 with SMTP id d2-20020a170902cec200b001bf66c3d4d4mr64681plg.16.1695143689658;
        Tue, 19 Sep 2023 10:14:49 -0700 (PDT)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001bdd68b3f52sm10301343plg.302.2023.09.19.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:14:49 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 2/2] zswap: shrinks zswap pool based on memory pressure
Date:   Tue, 19 Sep 2023 10:14:47 -0700
Message-Id: <20230919171447.2712746-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919171447.2712746-1-nphamcs@gmail.com>
References: <20230919171447.2712746-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, we only shrink the zswap pool when the user-defined limit is
hit. This means that if we set the limit too high, cold data that are
unlikely to be used again will reside in the pool, wasting precious
memory. It is hard to predict how much zswap space will be needed ahead
of time, as this depends on the workload (specifically, on factors such
as memory access patterns and compressibility of the memory pages).

This patch implements a memcg- and NUMA-aware shrinker for zswap, that
is initiated when there is memory pressure. The shrinker does not
have any parameter that must be tuned by the user, and can be opted in
or out on a per-memcg basis.

Furthermore, to make it more robust for many workloads and prevent
overshrinking (i.e evicting warm pages that might be refaulted into
memory), we build in the following heuristics:

* Estimate the number of warm pages residing in zswap, and attempt to
  protect this region of the zswap LRU.
* Scale the number of freeable objects by an estimate of the memory
  saving factor. The better zswap compresses the data, the fewer pages
  we will evict to swap (as we will otherwise incur IO for relatively
  small memory saving).
* During reclaim, if the shrinker encounters a page that is also being
  brought into memory, the shrinker will cautiously terminate its
  shrinking action, as this is a sign that it is touching the warmer
  region of the zswap LRU.

On a benchmark that we have run:

(without the shrinker)
real -- mean: 153.27s, median: 153.199s
sys -- mean: 541.652s, median: 541.903s
user -- mean: 4384.9673999999995s, median: 4385.471s

(with the shrinker)
real -- mean: 151.4956s, median: 151.456s
sys -- mean: 461.14639999999997s, median: 465.656s
user -- mean: 4384.7118s, median: 4384.675s

We observed a 14-15% reduction in kernel CPU time, which translated to
over 1% reduction in real time.

On another benchmark, where there was a lot more cold memory residing in
zswap, we observed even more pronounced gains:

(without the shrinker)
real -- mean: 157.52519999999998s, median: 157.281s
sys -- mean: 769.3082s, median: 780.545s
user -- mean: 4378.1622s, median: 4378.286s

(with the shrinker)
real -- mean: 152.9608s, median: 152.845s
sys -- mean: 517.4446s, median: 506.749s
user -- mean: 4387.694s, median: 4387.935s

Here, we saw around 32-35% reduction in kernel CPU time, which
translated to 2.8% reduction in real time. These results confirm our
hypothesis that the shrinker is more helpful the more cold memory we
have.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst |  12 ++
 include/linux/memcontrol.h             |   1 +
 include/linux/mmzone.h                 |  14 ++
 mm/memcontrol.c                        |  33 +++++
 mm/swap_state.c                        |  31 ++++-
 mm/zswap.c                             | 180 ++++++++++++++++++++++++-
 6 files changed, 263 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 45b98390e938..ae8597a67804 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,18 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+When there is a sizable amount of cold memory residing in the zswap pool, it
+can be advantageous to proactively write these cold pages to swap and reclaim
+the memory for other use cases. By default, the zswap shrinker is disabled.
+User can enable it by first switching on the global knob:
+
+  echo Y > /sys/module/zswap/par meters/shrinker_enabled
+
+When the kernel is compiled with CONFIG_MEMCG_KMEM, user needs to further turn
+it on for each cgroup that the shrinker should target:
+
+  echo 1 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.shrinker.enabled
+
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
 pages are rejected.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 05d34b328d9d..f005ea667863 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -219,6 +219,7 @@ struct mem_cgroup {
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	unsigned long zswap_max;
+	atomic_t zswap_shrinker_enabled;
 #endif
 
 	unsigned long soft_limit;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..81f4c5ea3e16 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -637,6 +637,20 @@ struct lruvec {
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
+#ifdef CONFIG_ZSWAP
+	/*
+	 * Number of pages in zswap that should be protected from the shrinker.
+	 * This number is an estimate of the following counts:
+	 *
+	 * a) Recent page faults.
+	 * b) Recent insertion to the zswap LRU. This includes new zswap stores,
+	 *    as well as recent zswap LRU rotations.
+	 *
+	 * These pages are likely to be warm, and might incur IO if the are written
+	 * to swap.
+	 */
+	unsigned long nr_zswap_protected;
+#endif
 };
 
 /* Isolate unmapped pages */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9f84b3f7b469..1a2c97cf396f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5352,6 +5352,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
+	/* Disable the shrinker by default */
+	atomic_set(&memcg->zswap_shrinker_enabled, 0);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -7877,6 +7879,31 @@ static ssize_t zswap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int zswap_shrinker_enabled_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", atomic_read(&memcg->zswap_shrinker_enabled));
+	return 0;
+}
+
+static ssize_t zswap_shrinker_enabled_write(struct kernfs_open_file *of,
+			       char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int zswap_shrinker_enabled;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 0, &zswap_shrinker_enabled);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (zswap_shrinker_enabled < 0 || zswap_shrinker_enabled > 1)
+		return -ERANGE;
+
+	atomic_set(&memcg->zswap_shrinker_enabled, zswap_shrinker_enabled);
+	return nbytes;
+}
+
 static struct cftype zswap_files[] = {
 	{
 		.name = "zswap.current",
@@ -7889,6 +7916,12 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_max_show,
 		.write = zswap_max_write,
 	},
+	{
+		.name = "zswap.shrinker.enabled",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = zswap_shrinker_enabled_show,
+		.write = zswap_shrinker_enabled_write,
+	},
 	{ }	/* terminate */
 };
 #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1c826737aacb..788e36a06c34 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -618,6 +618,22 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	return pages;
 }
 
+#ifdef CONFIG_ZSWAP
+/*
+ * Refault is an indication that warmer pages are not resident in memory.
+ * Increase the size of zswap's protected area.
+ */
+static void inc_nr_protected(struct page *page)
+{
+	struct lruvec *lruvec = folio_lruvec(page_folio(page));
+	unsigned long flags;
+
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+	lruvec->nr_zswap_protected++;
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+}
+#endif
+
 /**
  * swap_cluster_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
@@ -686,7 +702,12 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
+	page = read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
+#ifdef CONFIG_ZSWAP
+	if (page)
+		inc_nr_protected(page);
+#endif
+	return page;
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -853,8 +874,12 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     NULL);
+	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address, NULL);
+#ifdef CONFIG_ZSWAP
+	if (page)
+		inc_nr_protected(page);
+#endif
+	return page;
 }
 
 /**
diff --git a/mm/zswap.c b/mm/zswap.c
index 1a469e5d5197..79cb18eeb8bf 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -145,6 +145,26 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
+/*
+ * Global flag to enable/disable memory pressure-based shrinker for all memcgs.
+ * If CONFIG_MEMCG_KMEM is on, we can further selectively disable
+ * the shrinker for each memcg.
+ */
+static bool zswap_shrinker_enabled;
+module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
+#ifdef CONFIG_MEMCG_KMEM
+static bool is_shrinker_enabled(struct mem_cgroup *memcg)
+{
+	return zswap_shrinker_enabled &&
+		atomic_read(&memcg->zswap_shrinker_enabled);
+}
+#else
+static bool is_shrinker_enabled(struct mem_cgroup *memcg)
+{
+	return zswap_shrinker_enabled;
+}
+#endif
+
 /*********************************
 * data structures
 **********************************/
@@ -174,6 +194,8 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 	struct list_lru list_lru;
 	struct mem_cgroup *next_shrink;
+	struct shrinker *shrinker;
+	atomic_t nr_stored;
 };
 
 /*
@@ -273,17 +295,26 @@ static bool zswap_can_accept(void)
 			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
 }
 
+static u64 get_zswap_pool_size(struct zswap_pool *pool)
+{
+	u64 pool_size = 0;
+	int i;
+
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+		pool_size += zpool_get_total_size(pool->zpools[i]);
+
+	return pool_size;
+}
+
 static void zswap_update_total_size(void)
 {
 	struct zswap_pool *pool;
 	u64 total = 0;
-	int i;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-			total += zpool_get_total_size(pool->zpools[i]);
+		total += get_zswap_pool_size(pool);
 
 	rcu_read_unlock();
 
@@ -318,8 +349,23 @@ static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
 	struct mem_cgroup *memcg = entry->objcg ?
 		get_mem_cgroup_from_objcg(entry->objcg) : NULL;
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry->nid));
 	bool added = __list_lru_add(list_lru, &entry->lru, entry->nid, memcg);
+	unsigned long flags, lru_size;
+
+	if (added) {
+		lru_size = list_lru_count_one(list_lru, entry->nid, memcg);
+		spin_lock_irqsave(&lruvec->lru_lock, flags);
+		lruvec->nr_zswap_protected++;
 
+		/*
+		 * Decay to avoid overflow and adapt to changing workloads.
+		 * This is based on LRU reclaim cost decaying heuristics.
+		 */
+		if (lruvec->nr_zswap_protected > lru_size / 4)
+			lruvec->nr_zswap_protected /= 2;
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+	}
 	mem_cgroup_put(memcg);
 	return added;
 }
@@ -420,6 +466,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
+		atomic_dec(&entry->pool->nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -461,6 +508,98 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
 	return entry;
 }
 
+/*********************************
+* shrinker functions
+**********************************/
+static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
+				       spinlock_t *lock, void *arg);
+
+static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
+		struct shrink_control *sc)
+{
+	struct zswap_pool *pool = shrinker->private_data;
+	unsigned long shrink_ret, nr_zswap_protected, flags,
+		lru_size = list_lru_shrink_count(&pool->list_lru, sc);
+	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
+	bool encountered_page_in_swapcache = false;
+
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+	nr_zswap_protected = lruvec->nr_zswap_protected;
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+
+	/*
+	 * Abort if the shrinker is disabled or if we are shrinking into the
+	 * protected region.
+	 */
+	if (!is_shrinker_enabled(sc->memcg) ||
+			nr_zswap_protected >= lru_size - sc->nr_to_scan) {
+		sc->nr_scanned = 0;
+		return SHRINK_STOP;
+	}
+
+	shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
+		&encountered_page_in_swapcache);
+
+	if (encountered_page_in_swapcache)
+		return SHRINK_STOP;
+
+	return shrink_ret ? shrink_ret : SHRINK_STOP;
+}
+
+static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
+		struct shrink_control *sc)
+{
+	struct zswap_pool *pool = shrinker->private_data;
+	struct mem_cgroup *memcg = sc->memcg;
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
+	unsigned long nr_backing, nr_stored, nr_freeable, flags;
+
+#ifdef CONFIG_MEMCG_KMEM
+	cgroup_rstat_flush(memcg->css.cgroup);
+	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+#else
+	/* use pool stats instead of memcg stats */
+	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
+	nr_stored = atomic_read(&pool->nr_stored);
+#endif
+
+	if (!is_shrinker_enabled(memcg) || !nr_stored)
+		return 0;
+
+	nr_freeable = list_lru_shrink_count(&pool->list_lru, sc);
+	/*
+	 * Subtract the lru size by an estimate of the number of pages
+	 * that should be protected.
+	 */
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+	nr_freeable = nr_freeable > lruvec->nr_zswap_protected ?
+		nr_freeable - lruvec->nr_zswap_protected : 0;
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+
+	/*
+	 * Scale the number of freeable pages by the memory saving factor.
+	 * This ensures that the better zswap compresses memory, the fewer
+	 * pages we will evict to swap (as it will otherwise incur IO for
+	 * relatively small memory saving).
+	 */
+	return mult_frac(nr_freeable, nr_backing, nr_stored);
+}
+
+static void zswap_alloc_shrinker(struct zswap_pool *pool)
+{
+	pool->shrinker =
+		shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE, "mm-zswap");
+	if (!pool->shrinker)
+		return;
+
+	pool->shrinker->private_data = pool;
+	pool->shrinker->scan_objects = zswap_shrinker_scan;
+	pool->shrinker->count_objects = zswap_shrinker_count;
+	pool->shrinker->batch = 0;
+	pool->shrinker->seeks = DEFAULT_SEEKS;
+}
+
 /*********************************
 * per-cpu code
 **********************************/
@@ -656,11 +795,14 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 				       spinlock_t *lock, void *arg)
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	bool *encountered_page_in_swapcache = (bool *)arg;
 	struct mem_cgroup *memcg;
 	struct zswap_tree *tree;
+	struct lruvec *lruvec;
 	pgoff_t swpoffset;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
+	unsigned long flags;
 
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
@@ -696,8 +838,24 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		/* we cannot use zswap_lru_add here, because it increments node's lru count */
 		list_lru_putback(&entry->pool->list_lru, item, entry->nid, memcg);
 		spin_unlock(lock);
-		mem_cgroup_put(memcg);
 		ret = LRU_RETRY;
+
+		/*
+		 * Encountering a page already in swap cache is a sign that we are shrinking
+		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
+		 * shrinker context).
+		 */
+		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
+			ret = LRU_SKIP;
+			*encountered_page_in_swapcache = true;
+		}
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry->nid));
+		spin_lock_irqsave(&lruvec->lru_lock, flags);
+		/* Increment the protection area to account for the LRU rotation. */
+		lruvec->nr_zswap_protected++;
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+
+		mem_cgroup_put(memcg);
 		goto put_unlock;
 	}
 
@@ -828,6 +986,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 				       &pool->node);
 	if (ret)
 		goto error;
+
+	zswap_alloc_shrinker(pool);
+	if (!pool->shrinker)
+		goto error;
+
 	pr_debug("using %s compressor\n", pool->tfm_name);
 
 	/* being the current pool takes 1 ref; this func expects the
@@ -836,12 +999,17 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
-	list_lru_init_memcg(&pool->list_lru, NULL);
+	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
+		goto lru_fail;
+	shrinker_register(pool->shrinker);
 
 	zswap_pool_debug("created", pool);
 
 	return pool;
 
+lru_fail:
+	list_lru_destroy(&pool->list_lru);
+	shrinker_free(pool->shrinker);
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
@@ -899,6 +1067,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	zswap_pool_debug("destroying", pool);
 
+	shrinker_free(pool->shrinker);
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 	list_lru_destroy(&pool->list_lru);
@@ -1431,6 +1600,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&pool->list_lru, entry);
+		atomic_inc(&pool->nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.34.1
