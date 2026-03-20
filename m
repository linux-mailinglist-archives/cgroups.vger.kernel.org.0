Return-Path: <cgroups+bounces-14963-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM9DBWWhvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14963-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:35:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FE2E0140
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0630830BA481
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F013F8DF4;
	Fri, 20 Mar 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaTKsdHb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8303F23DC
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034894; cv=none; b=MU/8S6tUBcWhxAb0YiI6CnlyDrcBG6xW0Z2rmPefEcZhCSKuHJfi+33a7F5MCMdPFmnu2P5GvBMfBZTd7fkIyQKjIF8xQinwJsE64561EQ1TQgpAbb0K5EDtXeGT/g0EBRyRsqT1/EsF/+8E4OC0Vnf/FP8FVGRDVQeJX5JC4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034894; c=relaxed/simple;
	bh=oWlsx/GR6MFfgg4lg3d7Z5Pjk9ia0CfFJsRiaFfeNms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8oPaNBlYhUKyip/D4S26q69NcnyhWwQTpUrV1kTLiMTLxox9bXvv+qDVQXr0t5hX682+mqnWCXrQyFyThnbIP53vv7KuOnEN80gpxUQhNqNWNzdrPadE663yctEuFhpS3iu3gtUInwyXqTI8Mn5ZD60ngIVYigOHjmjDd4dCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaTKsdHb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d73d6976adso1662793a34.2
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034888; x=1774639688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRQf7iywx8TRv6dj+dUpDGMfIu8qRC23MBFf4aVP63g=;
        b=RaTKsdHbifGXZQ5j6K9sIBmMR6yLpru8iQv5osn2vIF+xObRZnhbspAp2XVsKxqKgZ
         Z+dJXmpB+rCadjol1VhG5PjBw/NXMGzCHmH+dr/wmbuOg07pUK3AGW0rQ+/lMoKMnVOn
         aVZsJO4MT1mxCQG+t8deP+TLKhZKtMtOUN+wwLvuSt9g/p2U8d7bhWgmsgEtuKsBI0k4
         Ueq39WDBv3rs4tPBFPe/2eGqLgxn0ia/BQe/gk4n/DWXxXVH99Qcd95+3j9lZTD0BurY
         gIpYIWtxd0gdX8W7MaN5Ek2ni4kbW7IPOdzEOCT4EWQCMFI4BcI47MP8Bla0jrEZiGme
         MWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034888; x=1774639688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRQf7iywx8TRv6dj+dUpDGMfIu8qRC23MBFf4aVP63g=;
        b=kV+Ew+BSWZpDJGy3krltNxmqZOjdTBLRQxKRktNeQDRxWPwMHBeTKho/CdRY8HjOAw
         95APreuZy63skgTodGvZvz+HoA/nikxWBvsi3OD0hQugxZ7wvJllQhQoABXCjDIHDshG
         T+Ss4tPB3H6cinZIpPgZfWRZJRdpn8Z0sPWX7QI1ED+l7agMQTLaYFzwrfQvoIuzgvF/
         26MSDIxN61nVbdT1JVYzIqh9Zq1KMjhM09ZCXQUFIDyoSePiFwkH19oIpvnhS2PYk4A9
         0S20qkvV+Mpz311OIlTcpMFt6lOnbUBjX1klc7LKg4URgpvFZelYF5huX6c9N7bQn97W
         1gpg==
X-Forwarded-Encrypted: i=1; AJvYcCUUzi4LTIRKsCEvpDsOzmt1LyTOKUaV9SxQOcKflYbxLH297PTAmOmQA9R4NLaZnW47jAXbwhqv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c1COoI6xz1hMblJ/hbwGY7mZlrqfbEyugP5j9dvkPBcRtAux
	KStjeL1Tez+6aywUuk4DkKvYDzIEBWw22Jaz0hr/NRGlOODfR0hckZ8J
X-Gm-Gg: ATEYQzy+Fv61+ljPTmFHKA1YGPXslNrwUVZRdCrs4aZ7KVvN+Mod4TTWkdu8z1v7zgi
	bTm3mUunKMHTaxqaxo96mV8/BtAJsQH/wQ+YLS64J/shIWCr5s0rvxXw+DW9D35D2WwsHoFKX0u
	6mJ/82IoKG4WS67Twrp2PEXsuUNinRroawzr3dcA3jkWEWZEkW8g8FDn49EMCvG+HA8ZiuB7cz+
	xivAuaZ9z+SjzGyHchZPoy3/eRQW+oQZeLaEKTAb3ht6S1B0i0EjscE+0LZt+pQqS796ZP9KSjQ
	R49LF2zXuqaiZjmKWFVHCcs/ViSzgrdKa5THWIgLxKQh8oiwAGXCACOyqstWHHdcgjxgNaZcZev
	c+kVoy5FxRXdiM/17HBypPOAfHdS5Qt64iBWGTZ6mSEvHt4osmphqXGaTRjpLFKf+5JLFWsTSQw
	egPa+UK0JcJFouLQUEiWljaoiSOeP1yHnLd2kBBotmP/FvVg==
X-Received: by 2002:a05:6830:730c:b0:7d7:fcdd:3f8c with SMTP id 46e09a7af769-7d7fcdd510fmr146495a34.34.1774034888110;
        Fri, 20 Mar 2026 12:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eabe90f6sm2860154a34.6.2026.03.20.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:28:07 -0700 (PDT)
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
Subject: [PATCH v5 21/21] vswap: batch contiguous vswap free calls
Date: Fri, 20 Mar 2026 12:27:35 -0700
Message-ID: <20260320192735.748051-22-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14963-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C79FE2E0140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In vswap_free(), we release and reacquire the cluster lock for every
single entry, even for non-disk-swap backends where the lock drop is
unnecessary. Batch consecutive free operations to avoid this overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |   6 ++
 mm/memcontrol.c            |   2 +-
 mm/vswap.c                 | 185 ++++++++++++++++++++++++-------------
 3 files changed, 126 insertions(+), 67 deletions(-)

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
index fa37165cb10d0..82092502130a6 100644
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
 
 	lockdep_assert_held(&cluster->lock);
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
  *
- * Specifically, this function is safe to be called in contexts where the swap
- * entry has been added to the swap cache and the associated folio is locked.
- * We cannot race with other accessors, and the swap entry is guaranteed to be
- * valid the whole time (since swap cache implies one refcount).
+ * Entered with the cluster locked, but might drop the lock in between.
+ * This is because several operations, such as releasing physical swap slots
+ * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
+ * deadlocks.
  *
- * We cannot assume that the backends will be of the same type,
- * contiguous, etc. We might have a large folio coalesced from subpages with
- * mixed backend, which is only rectified when it is reclaimed.
+ * This is safe, because:
+ *
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
-static void release_backing(swp_entry_t entry, int nr)
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
@@ -552,9 +562,8 @@ static void release_backing(swp_entry_t entry, int nr)
 
 	VM_WARN_ON(!entry.val);
 
-	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
 		/*
@@ -574,7 +583,6 @@ static void release_backing(swp_entry_t entry, int nr)
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
-			phys_swap_released++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -590,56 +598,49 @@ static void release_backing(swp_entry_t entry, int nr)
 
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
-
-	if (phys_swap_released)
-		mem_cgroup_uncharge_swap(entry, phys_swap_released);
 }
 
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+		swp_entry_t entry, unsigned int nr_ents);
+
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
 
-	release_backing(entry, 1);
-	mem_cgroup_clear_swap(entry, 1);
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		/* Clear shadow if present */
+		if (xa_is_value(desc->shadow))
+			desc->shadow = NULL;
+	}
 
-	/* erase forward mapping and release the virtual slot for reallocation */
-	spin_lock(&cluster->lock);
-	release_vswap_slot(cluster, entry.val);
+	release_backing(cluster, entry, nr);
+	__vswap_swap_cgroup_clear(cluster, entry, nr);
+
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
@@ -1772,11 +1805,10 @@ void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
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
@@ -1850,6 +1882,22 @@ static unsigned short __vswap_cgroup_record(struct vswap_cluster *cluster,
 	return oldid;
 }
 
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
 static unsigned short vswap_cgroup_record(swp_entry_t entry,
 				unsigned short memcgid, unsigned int nr_ents)
 {
@@ -1955,6 +2003,11 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t entry)
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


