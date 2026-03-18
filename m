Return-Path: <cgroups+bounces-14902-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIQsAjEpu2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14902-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:37:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09362C38AD
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFFC3254C30
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBFA3B7B97;
	Wed, 18 Mar 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0vPObbJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB33B4E96
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873035; cv=none; b=mpHMxBI84qiDSmX8e53hO1QGXmLXebgLbovA/aI3n1Qq3qtBgQfi6YUlfcDpRF6doP7l0TaIswtcItYXkSJYI9fO5GqzsAF7DSYOjS0WgyFHfLgGZn75v/6QhI76zB4DOCrsoRPgBn6ZJBB5BDBEy6EWxiZYDI3kSLLhNvB9X1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873035; c=relaxed/simple;
	bh=n7a0L+B0nLe/LJ6vA1HhYBkALb1Bi7BahRo6lrt+U3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwaSk4LRaYTMebVhOCufDjK0sNFRFYMigmq4ZE3OWDBu1smnm/0Ck2BKLgB5I7L7b3KldwojxJ/zAsEUhNBELHGuLSRTo8kioKoTgYjBCV0S7D9XttZzV6PNBACWKdaa3+UWJXepAOPpvlMnwosa98OQZlgGdSz18uLd8irxcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0vPObbJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-417c34b0509so74003fac.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873031; x=1774477831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+iH5HFisohJxPO0eUw7yFv6IR/DWyPxYEiRGFSd7Iw=;
        b=e0vPObbJJAu7MNQKYeuccyQ/4d/ATbp44fvYBVd8VDH80V/QwGN4hWXdWguLY64dkU
         00makkSoMAQq4oPrK2YUAbDWJNba2nHOn70NzNSwaHTgyoQqhvMFS+yAvsvze5bc4lKv
         a0o5QDw/sF7beWKN8dhPlM+R5zpPYcm+ctrfuh90oA0YcHoWzC2IKtfdcq3RUK5xBof5
         zoRbd9RrkAi3OvyVQhofcrwu4LKamUBUjedgUVbmQYkCFyGbS5zPGulSmzqp2Z5qmzvx
         Hswh6benNhfQUSj1+xbBsO7TNsXYkRBgh81J+mqGkzhWh5SbGz7+d2gqBB1P7jIwFsBo
         sgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873031; x=1774477831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+iH5HFisohJxPO0eUw7yFv6IR/DWyPxYEiRGFSd7Iw=;
        b=oT/AI4h6rQo/63urU40HNc0NntDoHKLGwlmeHo5Pb+HmV3pJfMyjYP8llRAtLUweI5
         3wdC6dBu9ZEw8XQtHNNpC5IcLHrzZCg9s2xTYFcOA/GvlqUDTUF82LrnKeXP9KvrimYg
         r06uJ9Y7+Vfe0LlkKV/8kfi5ku/Xw5S1o9OV7NEEXUxA+DkeqyPDSOKQArtwsNFtx09D
         poz16wI1X/+e+A6RvyWAQRgFNjS3ixThy1ghBKrPvR/ykIbdqtUQpTdLvSyNjU3X7/xK
         UBI57fGteIoC/DXsUg+ZRg44Dkxm/RN06956G0kFa5rgIWcDNAU6S4V9kPVMvGhMfcEh
         Xx8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbTrsIt6HxPJ7/BO3/WWsF22iOlgEPIDSwhmz1D9VbQLlBxiv7AJePGluzW/noy95rweWjXMbp@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJR3ZtRK1J3C2xWIM2Vapc+I3db/VcUy9pTPV9MYeu54Z0mRZ
	RMwzD5iHft0lmQvbZfUiHxAiLHdc4HJG/eViZbSSNYW3pWYyvQN435+O
X-Gm-Gg: ATEYQzyadAuoRY406qElgIERXr/+3SOtbFGzuDfH/ffsxAiR42UgJuIem8d0lyar6Br
	0qiVqzI2Qk8NraSKgtPXBRAXgHkBpGJ3xbVQXtDHnST9B8k7hGzjDBN/30tjGWLD1TdEG2aD3w2
	hFjy7obpNoaXAVwtuaba0LE0guWqrahu/vT4/DURY3sUnODOaVgI9qtzky6Wkyb1fL1+b+eVS7c
	RzfSMMyMlmIL9lCQFC9Y+Bg/ookV/YtxMrQRvePtlxRFH3FnpUG7LZviyfZ6Umcel32LJgOE2tW
	qHD7lpP6GhOcYJfvUbv62+ZGVGLm3Taf/yR6jZKLlOPZ9wXwVGHc3BsKS8F4bF/Frh2fwH2aEpu
	Hj6uyMc/TfxTxrVhUajtzOnZ52jlLpm84h6ivWuKtG/9JXeZN91YrTgQJ6moVJ/Ga5DcyhmU81l
	IRyW0+WopWfyFSjU5tZ9AlLykVZLZOUkQ+BcMEKpMRrtpp2w==
X-Received: by 2002:a05:6871:286:b0:3e8:98e4:56d with SMTP id 586e51a60fabf-41bd421a979mr3698110fac.41.1773873031027;
        Wed, 18 Mar 2026 15:30:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2c3111dsm3703574fac.12.2026.03.18.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:30 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com
Subject: [PATCH v4 21/21] vswap: batch contiguous vswap free calls
Date: Wed, 18 Mar 2026 15:29:52 -0700
Message-ID: <20260318222953.441758-22-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14902-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.873];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A09362C38AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In vswap_free(), we release and reacquire the cluster lock for every
single entry, even for non-disk-swap backends where the lock drop is
unnecessary. Batch consecutive free operations to avoid this overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |   6 ++
 mm/memcontrol.c            |   2 +-
 mm/vswap.c                 | 215 +++++++++++++++++++++++++------------
 3 files changed, 151 insertions(+), 72 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564f..0f7f5489e1675 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -827,6 +827,7 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 	return memcg->id.id;
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
+void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
@@ -1289,6 +1290,11 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return NULL;
 }
 
+static inline void mem_cgroup_id_put_many(struct mem_cgroup *memcg,
+					  unsigned int n)
+{
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4525c21754e7f..c6d307b8127a8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3597,7 +3597,7 @@ void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
 	refcount_add(n, &memcg->id.ref);
 }
 
-static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
+void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	if (refcount_sub_and_test(n, &memcg->id.ref)) {
 		mem_cgroup_id_remove(memcg);
diff --git a/mm/vswap.c b/mm/vswap.c
index 96f4615f29a95..f3634449f5427 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -482,18 +482,18 @@ static void vswap_cluster_free(struct vswap_cluster *cluster)
 	kvfree_rcu(cluster, rcu);
 }
 
-static inline void release_vswap_slot(struct vswap_cluster *cluster,
-		unsigned long index)
+static inline void release_vswap_slot_nr(struct vswap_cluster *cluster,
+		unsigned long index, int nr)
 {
 	unsigned long slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(index);
 
 	VM_WARN_ON(!spin_is_locked(&cluster->lock));
-	cluster->count--;
+	cluster->count -= nr;
 
-	bitmap_clear(cluster->bitmap, slot_index, 1);
+	bitmap_clear(cluster->bitmap, slot_index, nr);
 
 	/* we only free uncached empty clusters */
-	if (refcount_dec_and_test(&cluster->refcnt))
+	if (refcount_sub_and_test(nr, &cluster->refcnt))
 		vswap_cluster_free(cluster);
 	else if (cluster->full && cluster_is_alloc_candidate(cluster)) {
 		cluster->full = false;
@@ -506,7 +506,7 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
 		}
 	}
 
-	atomic_dec(&vswap_used);
+	atomic_sub(nr, &vswap_used);
 }
 
 /*
@@ -528,23 +528,33 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 }
 
 /*
- * Caller needs to handle races with other operations themselves.
+ * release_backing - release the backend storage for a given range of virtual
+ * swap slots.
+ *
+ * Entered with the cluster locked, but might drop the lock in between.
+ * This is because several operations, such as releasing physical swap slots
+ * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
+ * deadlocks.
  *
- * Specifically, this function is safe to be called in contexts where the swap
- * entry has been added to the swap cache and the associated folio is locked.
- * We cannot race with other accessors, and the swap entry is guaranteed to be
- * valid the whole time (since swap cache implies one refcount).
+ * This is safe, because:
  *
- * We cannot assume that the backends will be of the same type,
- * contiguous, etc. We might have a large folio coalesced from subpages with
- * mixed backend, which is only rectified when it is reclaimed.
+ * 1. Callers ensure no concurrent modification of the swap entry's internal
+ *    state can occur. This is guaranteed by one of the following:
+ *    - For vswap_free_nr() callers: the swap entry's refcnt (swap count and
+ *      swapcache pin) is down to 0.
+ *    - For vswap_store_folio(), swap_zeromap_folio_set(), and zswap_entry_store()
+ *      callers: the folio is locked and in the swap cache.
+ *
+ * 2. The swap entry still holds a refcnt to the cluster, keeping the cluster
+ *    itself valid.
+ *
+ * We will exit the function with the cluster re-locked.
  */
- static void release_backing(swp_entry_t entry, int nr)
+static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
-	unsigned long phys_swap_released = 0;
 	unsigned int phys_swap_type = 0;
 	bool need_flushing_phys_swap = false;
 	swp_slot_t flush_slot;
@@ -552,9 +562,8 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 
 	VM_WARN_ON(!entry.val);
 
-	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
 		/*
@@ -574,7 +583,6 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
-			phys_swap_released++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -590,56 +598,49 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 
 		if (need_flushing_phys_swap) {
 			spin_unlock(&cluster->lock);
-			cluster = NULL;
 			swap_slot_free_nr(flush_slot, flush_nr);
+			mem_cgroup_uncharge_swap(entry, flush_nr);
+			spin_lock(&cluster->lock);
 			need_flushing_phys_swap = false;
 		}
 	}
-	if (cluster)
-		spin_unlock(&cluster->lock);
-	rcu_read_unlock();
 
 	/* Flush any remaining physical swap range */
 	if (phys_swap_start) {
 		flush_slot = swp_slot(phys_swap_type, phys_swap_start);
 		flush_nr = phys_swap_end - phys_swap_start;
+		spin_unlock(&cluster->lock);
 		swap_slot_free_nr(flush_slot, flush_nr);
+		mem_cgroup_uncharge_swap(entry, flush_nr);
+		spin_lock(&cluster->lock);
 	}
+}
 
-	if (phys_swap_released)
-		mem_cgroup_uncharge_swap(entry, phys_swap_released);
- }
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+		swp_entry_t entry, unsigned int nr_ents);
 
 /*
- * Entered with the cluster locked, but might unlock the cluster.
- * This is because several operations, such as releasing physical swap slots
- * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
- * deadlocks.
- *
- * This is safe, because:
- *
- * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
- *    down to 0, so no one can change its internal state
- *
- * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
- *    the cluster itself valid.
- *
- * We will exit the function with the cluster re-locked.
+ * Entered with the cluster locked. We will exit the function with the cluster
+ * still locked.
  */
-static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
-	swp_entry_t entry)
+static void vswap_free_nr(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	/* Clear shadow if present */
-	if (xa_is_value(desc->shadow))
-		desc->shadow = NULL;
-	spin_unlock(&cluster->lock);
+	struct swp_desc *desc;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		/* Clear shadow if present */
+		if (xa_is_value(desc->shadow))
+			desc->shadow = NULL;
+	}
 
-	release_backing(entry, 1);
-	mem_cgroup_clear_swap(entry, 1);
+	release_backing(cluster, entry, nr);
+	__vswap_swap_cgroup_clear(cluster, entry, nr);
 
-	/* erase forward mapping and release the virtual slot for reallocation */
-	spin_lock(&cluster->lock);
-	release_vswap_slot(cluster, entry.val);
+	/* erase forward mapping and release the virtual slots for reallocation */
+	release_vswap_slot_nr(cluster, entry.val, nr);
 }
 
 /**
@@ -818,18 +819,32 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	bool ret = false;
-	int i;
+	swp_entry_t free_start;
+	int i, free_nr = 0;
 
+	free_start.val = 0;
 	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
+		/* flush pending free batch at cluster boundary */
+		if (free_nr && !VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		desc = vswap_iter(&cluster, entry.val);
 		VM_WARN_ON(!desc);
 		ret |= (desc->swap_count == 1 && desc->in_swapcache);
 		desc->swap_count--;
-		if (!desc->swap_count && !desc->in_swapcache)
-			vswap_free(cluster, desc, entry);
+		if (!desc->swap_count && !desc->in_swapcache) {
+			if (!free_nr++)
+				free_start = entry;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -952,19 +967,33 @@ void swapcache_clear(swp_entry_t entry, int nr)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
-	int i;
+	swp_entry_t free_start;
+	int i, free_nr = 0;
 
 	if (!nr)
 		return;
 
+	free_start.val = 0;
 	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
+		/* flush pending free batch at cluster boundary */
+		if (free_nr && !VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		desc = vswap_iter(&cluster, entry.val);
 		desc->in_swapcache = false;
-		if (!desc->swap_count)
-			vswap_free(cluster, desc, entry);
+		if (!desc->swap_count) {
+			if (!free_nr++)
+				free_start = entry;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -1105,11 +1134,13 @@ void vswap_store_folio(swp_entry_t entry, struct folio *folio)
 	VM_BUG_ON(!folio_test_locked(folio));
 	VM_BUG_ON(folio->swap.val != entry.val);
 
-	release_backing(entry, nr);
-
 	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		desc->type = VSWAP_FOLIO;
 		desc->swap_cache = folio;
@@ -1134,11 +1165,13 @@ void swap_zeromap_folio_set(struct folio *folio)
 	VM_BUG_ON(!folio_test_locked(folio));
 	VM_BUG_ON(!entry.val);
 
-	release_backing(entry, nr);
-
 	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		desc->type = VSWAP_ZERO;
 	}
@@ -1773,11 +1806,10 @@ void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 
-	release_backing(swpentry, 1);
-
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
 	VM_WARN_ON(!desc);
+	release_backing(cluster, swpentry, 1);
 	desc->zswap_entry = entry;
 	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
@@ -1824,17 +1856,22 @@ bool zswap_empty(swp_entry_t swpentry)
 #endif /* CONFIG_ZSWAP */
 
 #ifdef CONFIG_MEMCG
-static unsigned short vswap_cgroup_record(swp_entry_t entry,
-				unsigned short memcgid, unsigned int nr_ents)
+/*
+ * __vswap_cgroup_record - record mem_cgroup for a set of swap entries
+ *
+ * Entered with the cluster locked. We will exit the function with the cluster
+ * still locked.
+ */
+static unsigned short __vswap_cgroup_record(struct vswap_cluster *cluster,
+				swp_entry_t entry, unsigned short memcgid,
+				unsigned int nr_ents)
 {
-	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned short oldid, iter = 0;
 	int i;
 
-	rcu_read_lock();
 	for (i = 0; i < nr_ents; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		oldid = desc->memcgid;
 		desc->memcgid = memcgid;
@@ -1842,6 +1879,37 @@ static unsigned short vswap_cgroup_record(swp_entry_t entry,
 			iter = oldid;
 		VM_WARN_ON(iter != oldid);
 	}
+
+	return oldid;
+}
+
+/*
+ * Clear swap cgroup for a range of swap entries.
+ * Entered with the cluster locked. Caller must be under rcu_read_lock().
+ */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents)
+{
+	unsigned short id;
+	struct mem_cgroup *memcg;
+
+	id = __vswap_cgroup_record(cluster, entry, 0, nr_ents);
+	memcg = mem_cgroup_from_id(id);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_ents);
+}
+
+static unsigned short vswap_cgroup_record(swp_entry_t entry,
+				unsigned short memcgid, unsigned int nr_ents)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned short oldid;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	oldid = __vswap_cgroup_record(cluster, entry, memcgid, nr_ents);
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
@@ -1909,6 +1977,11 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t entry)
 	rcu_read_unlock();
 	return ret;
 }
+#else /* !CONFIG_MEMCG */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 int vswap_init(void)
-- 
2.52.0


