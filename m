Return-Path: <cgroups+bounces-15623-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA46DzwR+mmfIwMAu9opvQ
	(envelope-from <cgroups+bounces-15623-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:48:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD9B4D08D7
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A25530ECC4B
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28848B36F;
	Tue,  5 May 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlC65Cwo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A548C8BF
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995582; cv=none; b=BlGH8oUliXgbfM0odongmTdtcxPdctNZYb4RuzusZ/4OtjoDAYksqkxfkJ/mNQn1mzQlJjesqNb1w8bl4TksrFH2SJw7SZDDrtTb9tcWJ7ofCakfR/FwpysMe1e6SUCtICyF8MqQ+mrLPAQaIt4bS8qdtTlFRuklZzbZWg1Pv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995582; c=relaxed/simple;
	bh=nuwPt9BJ3dOev//4FyfmlK8GTh52ag0jyqr4xA5CFhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPEKsvCrTh8Ay9hjV3P+p/mONrPLYL8/whI17SWU5oHqgJFaUwRVZ8MA0lQzGLpk+SqIkI9YrygOa99iy7Kr12RmDyExY0JFsf1pGA4kyH8WBvT+N16sNYCkexDJhUCaPxWSyGsOwTjFCWkd81ohW7FopnD8Tuh7nu3a9boYTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlC65Cwo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-42fdab683b7so2832233fac.3
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995577; x=1778600377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8xr9BYmE4b/TQwSNMWFVd8hglVthqa+7+t9F87dFjA=;
        b=DlC65CwoPSS+tcq8NE3T70XnY0hxzlCPllCCnP2yxVGyAOY6Cg1Vo6Sc7FOnzdPEpO
         E2xWgj/Up6f9kLzMfO0J7it3pSrtVtxAR9XXRyH+no9TXxOyAmwMAAYcc/TFctlI2HTt
         X5x7kExes0q8hPiWHyPtuP8BqsHp7T7uthX9xK0akfoEMKAgTJop1TOLcClm7SuNCw/D
         6rByGGZ0uEC0sx2zmAxFVgiQ80dhS3e6yflVAcAsgYCeBfsDJArtfxGlAmRLaDeX0lyl
         StZI3xYbK3tlr59+NEBu9ZPJnhHr/F2aeLSxNpdf4bdxOqms0VQYHDjEmqaDoVvdk6Dz
         HN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995577; x=1778600377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8xr9BYmE4b/TQwSNMWFVd8hglVthqa+7+t9F87dFjA=;
        b=LBL5ZbGGJgeMrJoVLypSEy7IJU6S3iSvSO43l5VN1yklZlCpyIuVEgfZv7pLLDkc1l
         o2/S8tncKwP5CJygr6QCQ3TOcmoQz3hnKxcqQvCbgjTjMw58kIaICulGaQ6rr9Vyb9hp
         2oUSy0HDkFJhsut8uFyOMaC1NN+J4RFpjmEUZ/Ug8s9VQ+hzgkWjN6NXq72ASQH72JgR
         KsaSHERxKXsXBdle+IsLWOEMMrdhFkjYTSHURUYlWYsJghW8lylQ+VJ1HBFDRotb+3Ka
         nBwFyRGq2qxWiULKW+mU9GqqLvJq+8s33+0pUvH6XcyxuBe1r2yDzfZmFdl0ZsHwIKds
         A41g==
X-Forwarded-Encrypted: i=1; AFNElJ+NsMQ47ZvRQUBmuCSlxVdh+bKZCeYodIUKgQn7V1DA4n2C56sKuoFy30fX2e7X7edsP/xjxd4a@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSQPszqqw4PZ+rKervETPlBqR1oHcCpldzWPkOgNNd8PihyVD
	hc5dr2NIPC2EjLOybZyNlUKuqxsQ1wiiCAFGcpRqOjCu6UeXmXsqmAcY
X-Gm-Gg: AeBDieunwPM4+oKePvXUyfFCL2ERSN6ko5bG67wF4/Hu0PRTPXKK1QEkoY1Yek0J6FZ
	IdQo+630P5DP7A7vAIQigoAPSG9zBlHaBEjA8Wc+r8dtZN00qw0OVDD9vi10u4DjSdBfcLPuF2a
	41O0tvKPiXJ0fNhr4u+F5iPRpj0zYguUXU9BozFNtr9ikfWxPwjA7hs4kzaCgmY2uu16eXYYzZ0
	8rU5FniQixjgL5uMGVYUdguxi3LGzE5Jnk/aUy1mYqGN0d37RsCfjD2zpulRVqZLeqMfzNTJVzG
	M4KHWOAiJPR/2BAmoDDg30Jg7TSZjGOZ20sFTI/VQeow1gVMYfjnwjU4NKqZgfMBOdj7jK+fGrl
	VDDtdD6qecH0UL3Ddun5BcRdQ4ndypKp+MvWQUrGJJwiAkgy81+2PtvHaRTNbQMWCZsBcOFL/WH
	HOX2EZDxPAgsf6V9s5tBJgzI2LdAl68oRJJUItXB0MjkzWZKQPJXQkiSw=
X-Received: by 2002:a05:6820:198e:b0:68b:bc93:1de with SMTP id 006d021491bc7-69697c61364mr7146225eaf.35.1777995576685;
        Tue, 05 May 2026 08:39:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548c56fcsm14484142fac.4.2026.05.05.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:35 -0700 (PDT)
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
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 18/22] memcg: swap: only charge physical swap slots
Date: Tue,  5 May 2026 08:38:47 -0700
Message-ID: <20260505153854.1612033-19-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DD9B4D08D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15623-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Now that zswap and the zero-filled swap page optimization no longer
takes up any physical swap space, we should not charge towards the swap
usage and limits of the memcg in these cases. We will only record the
memcg id on virtual swap slot allocation, and defer physical swap
charging (i.e towards memory.swap.current) until the virtual swap slot
is backed by an actual physical swap slot (on zswap store failure
fallback or zswap writeback).

Note that on cgroup v1, memsw is still charged regardless of backend,
so release_backing() uncharges memsw for the entire freed range.

Also convert the memcg swap charge/uncharge/clear APIs to take
struct mem_cgroup * directly, eliminating IDR lookups on the hot paths:

  mem_cgroup_try_charge_swap(memcg, nr)
  mem_cgroup_uncharge_swap(memcg, nr)
  mem_cgroup_clear_swap(memcg, entry, nr)

In vswap_alloc_swap_slot(), the folio's memcg is compared against the
recorded swap memcg id; on match (the common case), zero IDR lookups.
In vswap_free(), the memcg is resolved once and threaded through
release_backing() and __vswap_swap_cgroup_clear(), reducing 2 IDR
lookups to 1. In memcg1_swapin(), one IDR lookup now feeds both
mem_cgroup_uncharge_swap() and mem_cgroup_clear_swap() (was 2).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h  |   5 +
 include/linux/swap.h        |  58 +++++----
 include/linux/swap_cgroup.h |   6 -
 mm/memcontrol-v1.c          |  15 ++-
 mm/memcontrol.c             | 136 ++++++++++-----------
 mm/vswap.c                  | 235 ++++++++++++++++++++++--------------
 6 files changed, 269 insertions(+), 186 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564..c1d63d03c9a6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -827,6 +827,7 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 	return memcg->id.id;
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
+void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
@@ -1289,6 +1290,10 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return NULL;
 }
 
+static inline void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
+{
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4d152fa811f2..ad5f59c807c6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -674,49 +674,65 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 #endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
-static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-		swp_entry_t entry)
+unsigned short __mem_cgroup_get_swap_memcgid(struct folio *folio);
+static inline unsigned short mem_cgroup_get_swap_memcgid(struct folio *folio)
 {
-	if (mem_cgroup_disabled())
-		return 0;
-	return __mem_cgroup_try_charge_swap(folio, entry);
+	if (!mem_cgroup_disabled())
+		return __mem_cgroup_get_swap_memcgid(folio);
+	return 0;
+}
+
+void __mem_cgroup_clear_swap(struct mem_cgroup *memcg, swp_entry_t entry,
+			     unsigned int nr_pages);
+static inline void mem_cgroup_clear_swap(struct mem_cgroup *memcg,
+		swp_entry_t entry, unsigned int nr_pages)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_clear_swap(memcg, entry, nr_pages);
 }
 
-extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
-static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
+int __mem_cgroup_try_charge_swap(struct mem_cgroup *memcg,
+				 unsigned int nr_pages);
+static inline int mem_cgroup_try_charge_swap(struct mem_cgroup *memcg,
+		unsigned int nr_pages)
 {
 	if (mem_cgroup_disabled())
-		return;
-	__mem_cgroup_uncharge_swap(entry, nr_pages);
+		return 0;
+	return __mem_cgroup_try_charge_swap(memcg, nr_pages);
 }
 
-extern void __mem_cgroup_uncharge_swap_by_id(unsigned short id,
-					     unsigned int nr_pages);
-static inline void mem_cgroup_uncharge_swap_by_id(unsigned short id,
-						  unsigned int nr_pages)
+extern void __mem_cgroup_uncharge_swap(struct mem_cgroup *memcg,
+				       unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_swap(struct mem_cgroup *memcg,
+					    unsigned int nr_pages)
 {
 	if (mem_cgroup_disabled())
 		return;
-	__mem_cgroup_uncharge_swap_by_id(id, nr_pages);
+	__mem_cgroup_uncharge_swap(memcg, nr_pages);
 }
 
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
-static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-					     swp_entry_t entry)
+static inline unsigned short mem_cgroup_get_swap_memcgid(struct folio *folio)
 {
 	return 0;
 }
 
-static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
-					    unsigned int nr_pages)
+static inline void mem_cgroup_clear_swap(struct mem_cgroup *memcg,
+					 swp_entry_t entry,
+					 unsigned int nr_pages)
 {
 }
 
-static inline void mem_cgroup_uncharge_swap_by_id(unsigned short id,
-						  unsigned int nr_pages)
+static inline int mem_cgroup_try_charge_swap(struct mem_cgroup *memcg,
+					     unsigned int nr_pages)
+{
+	return 0;
+}
+
+static inline void mem_cgroup_uncharge_swap(struct mem_cgroup *memcg,
+					    unsigned int nr_pages)
 {
 }
 
diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index 8e83856f801a..9f5b1dd9a2cf 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -6,7 +6,6 @@
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
-extern void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent);
 extern void __swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent);
 extern unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents);
 extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
@@ -14,11 +13,6 @@ extern int vswap_cgroup_batch(swp_entry_t entry, int max_nr);
 
 #else
 
-static inline
-void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent)
-{
-}
-
 static inline
 void __swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent)
 {
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 7b010e165e1b..2abee9b4b2a4 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -674,12 +674,25 @@ void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
 	 * page to memory here, and uncharge swap when the slot is freed.
 	 */
 	if (do_memsw_account()) {
+		unsigned short id = lookup_swap_cgroup_id(entry);
+		struct mem_cgroup *memcg;
+
+		rcu_read_lock();
+		memcg = id ? mem_cgroup_from_id(id) : NULL;
+		rcu_read_unlock();
+
 		/*
 		 * The swap entry might not get freed for a long time,
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
+		mem_cgroup_uncharge_swap(memcg, nr_pages);
+
+		/*
+		 * Clear the cgroup association now to prevent double memsw
+		 * uncharging when the backends are released later.
+		 */
+		mem_cgroup_clear_swap(memcg, entry, nr_pages);
 	}
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ff24bd53bd7..1ff2b1002598 100644
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
@@ -5173,20 +5173,17 @@ int __init mem_cgroup_init(void)
 
 #ifdef CONFIG_SWAP
 /**
- * __mem_cgroup_try_charge_swap - try charging swap space for a folio
- * @folio: folio being added to swap
- * @entry: swap entry to charge
- *
- * Try to charge @folio's memcg for the swap space at @entry.
+ * __mem_cgroup_get_swap_memcgid - get the pinned memcg ID for swap accounting.
+ * @folio: folio being swapped out.
  *
- * Returns 0 on success, -ENOMEM on failure.
+ * Return: the memcg ID with references pinned, or 0 if not applicable.
  */
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
+unsigned short __mem_cgroup_get_swap_memcgid(struct folio *folio)
 {
 	unsigned int nr_pages = folio_nr_pages(folio);
-	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 
+	/* Recording will be done by memcg1_swapout(). */
 	if (do_memsw_account())
 		return 0;
 
@@ -5196,98 +5193,99 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	if (!memcg)
 		return 0;
 
-	if (!entry.val) {
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
-	}
-
 	memcg = mem_cgroup_id_get_online(memcg);
+	if (nr_pages > 1)
+		mem_cgroup_id_get_many(memcg, nr_pages - 1);
+	return mem_cgroup_id(memcg);
+}
+
+/**
+ * __mem_cgroup_clear_swap - clear cgroup information of the swap entries.
+ * @memcg: the mem_cgroup recorded for @entry (may be NULL).
+ * @entry: the first swap entry in the range.
+ * @nr_pages: the number of pages in the range.
+ *
+ * The caller must guarantee that @memcg is still alive; normally this is
+ * because the swap_cgroup id reference taken at swapout time is still held.
+ * The reference is dropped here.
+ */
+void __mem_cgroup_clear_swap(struct mem_cgroup *memcg, swp_entry_t entry,
+			     unsigned int nr_pages)
+{
+	swap_cgroup_clear(entry, nr_pages);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_pages);
+}
+
+/**
+ * __mem_cgroup_try_charge_swap - try charging swap space for a folio
+ * @memcg: the mem_cgroup to charge (may be NULL)
+ * @nr_pages: number of swap pages to charge
+ *
+ * Try to charge @memcg for @nr_pages of swapfile slots.
+ *
+ * Returns 0 on success, -ENOMEM on failure.
+ */
+int __mem_cgroup_try_charge_swap(struct mem_cgroup *memcg,
+				 unsigned int nr_pages)
+{
+	struct page_counter *counter;
+
+	if (do_memsw_account())
+		return 0;
+	if (!memcg)
+		return 0;
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
 
-	/* Get references for the tail pages, too */
-	if (nr_pages > 1)
-		mem_cgroup_id_get_many(memcg, nr_pages - 1);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
-
-	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
-
 	return 0;
 }
 
 /**
  * __mem_cgroup_uncharge_swap - uncharge swap space
- * @entry: swap entry to uncharge
- * @nr_pages: the amount of swap space to uncharge
- */
-void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
-{
-	struct mem_cgroup *memcg;
-	unsigned short id;
-
-	id = swap_cgroup_clear(entry, nr_pages);
-	rcu_read_lock();
-	memcg = mem_cgroup_from_id(id);
-	if (memcg) {
-		if (!mem_cgroup_is_root(memcg)) {
-			if (do_memsw_account())
-				page_counter_uncharge(&memcg->memsw, nr_pages);
-			else
-				page_counter_uncharge(&memcg->swap, nr_pages);
-		}
-		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_id_put_many(memcg, nr_pages);
-	}
-	rcu_read_unlock();
-}
-
-/**
- * __mem_cgroup_uncharge_swap_by_id - uncharge swap space using memcg id directly
- * @id: mem_cgroup id to uncharge
+ * @memcg: the mem_cgroup to uncharge (may be NULL)
  * @nr_pages: the amount of swap space to uncharge
  *
- * Same as __mem_cgroup_uncharge_swap() but takes the memcg id directly,
- * skipping the lookup_swap_cgroup_id() call. Use when the caller already
- * knows the memcg id (e.g. from swp_desc->memcgid).
+ * Callers must guarantee @memcg is still alive (swap_cgroup id ref is
+ * normally what pins it).
  */
-void __mem_cgroup_uncharge_swap_by_id(unsigned short id,
-				      unsigned int nr_pages)
+void __mem_cgroup_uncharge_swap(struct mem_cgroup *memcg,
+				unsigned int nr_pages)
 {
-	struct mem_cgroup *memcg;
+	if (!memcg)
+		return;
 
-	rcu_read_lock();
-	memcg = mem_cgroup_from_id(id);
-	if (memcg) {
-		if (!mem_cgroup_is_root(memcg)) {
-			if (do_memsw_account())
-				page_counter_uncharge(&memcg->memsw, nr_pages);
-			else
-				page_counter_uncharge(&memcg->swap, nr_pages);
-		}
-		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_id_put_many(memcg, nr_pages);
+	if (!mem_cgroup_is_root(memcg)) {
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		else
+			page_counter_uncharge(&memcg->swap, nr_pages);
 	}
-	rcu_read_unlock();
+	mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
 }
 
 static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages, nr_zswap_pages = 0;
+	long nr_swap_pages;
 
 	if (zswap_is_enabled() && (mem_cgroup_disabled() || do_memsw_account() ||
 				mem_cgroup_may_zswap(memcg))) {
-		nr_zswap_pages = PAGE_COUNTER_MAX;
+		/*
+		 * No need to check swap cgroup limits, since zswap is not charged
+		 * towards swap consumption.
+		 */
+		return PAGE_COUNTER_MAX;
 	}
 
-	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
+	nr_swap_pages = get_nr_swap_pages();
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
diff --git a/mm/vswap.c b/mm/vswap.c
index 195ba3520e54..3f86bbb3a5ea 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -14,6 +14,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include "internal.h"
+#include "memcontrol-v1.h"
 #include "swap.h"
 #include "swap_table.h"
 
@@ -297,7 +298,7 @@ static bool cluster_is_alloc_candidate(struct vswap_cluster *cluster)
 }
 
 static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster,
-		int start, struct folio *folio)
+		int start, struct folio *folio, unsigned short memcgid)
 {
 	int i, nr = 1 << cluster->order;
 	struct swp_desc *desc;
@@ -307,7 +308,7 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster,
 		desc->type = VSWAP_FOLIO;
 		desc->swap_cache = folio;
 #ifdef CONFIG_MEMCG
-		desc->memcgid = 0;
+		desc->memcgid = memcgid;
 #endif
 		desc->swap_count = 0;
 		desc->in_swapcache = true;
@@ -316,7 +317,7 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster,
 }
 
 static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster,
-		struct folio *folio)
+		struct folio *folio, unsigned short memcgid)
 {
 	int nr = 1 << cluster->order;
 	unsigned long i = cluster->id ? 0 : nr;
@@ -335,20 +336,31 @@ static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster,
 	bitmap_set(cluster->bitmap, i, nr);
 
 	refcount_add(nr, &cluster->refcnt);
-	__vswap_alloc_from_cluster(cluster, i, folio);
+	__vswap_alloc_from_cluster(cluster, i, folio, memcgid);
 	return i + (cluster->id << VSWAP_CLUSTER_SHIFT);
 }
 
-/* Allocate a contiguous range of virtual swap slots */
-static swp_entry_t vswap_alloc(struct folio *folio)
+/**
+ * folio_alloc_swap - allocate virtual swap space for a folio.
+ * @folio: the folio.
+ *
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+int folio_alloc_swap(struct folio *folio)
 {
 	struct xa_limit limit = vswap_cluster_map_limit;
 	struct vswap_cluster *local, *cluster;
+	struct mem_cgroup *memcg;
 	int order = folio_order(folio), nr = 1 << order;
+	unsigned short memcgid;
 	bool need_caching = true;
 	u32 cluster_id;
 	swp_entry_t entry;
 
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
+
+	memcgid = mem_cgroup_get_swap_memcgid(folio);
 	entry.val = 0;
 
 	/* first, let's try the locally cached cluster */
@@ -357,7 +369,7 @@ static swp_entry_t vswap_alloc(struct folio *folio)
 	cluster = this_cpu_read(percpu_vswap_cluster.clusters[order]);
 	if (cluster) {
 		spin_lock(&cluster->lock);
-		entry.val = vswap_alloc_from_cluster(cluster, folio);
+		entry.val = vswap_alloc_from_cluster(cluster, folio, memcgid);
 		need_caching = !entry.val;
 
 		if (!entry.val || !cluster_is_alloc_candidate(cluster)) {
@@ -384,7 +396,7 @@ static swp_entry_t vswap_alloc(struct folio *folio)
 			if (!spin_trylock(&cluster->lock))
 				continue;
 
-			entry.val = vswap_alloc_from_cluster(cluster, folio);
+			entry.val = vswap_alloc_from_cluster(cluster, folio, memcgid);
 			list_del_init(&cluster->list);
 			cluster->full = !entry.val || !cluster_is_alloc_candidate(cluster);
 			need_caching = !cluster->full;
@@ -424,7 +436,7 @@ static swp_entry_t vswap_alloc(struct folio *folio)
 				if (!cluster_id)
 					entry.val += nr;
 				__vswap_alloc_from_cluster(cluster,
-					(entry.val & VSWAP_CLUSTER_MASK), folio);
+					(entry.val & VSWAP_CLUSTER_MASK), folio, memcgid);
 				/* Mark the allocated range in the bitmap */
 				bitmap_set(cluster->bitmap, (entry.val & VSWAP_CLUSTER_MASK), nr);
 				need_caching = cluster_is_alloc_candidate(cluster);
@@ -476,10 +488,25 @@ static swp_entry_t vswap_alloc(struct folio *folio)
 	if (entry.val) {
 		VM_WARN_ON(entry.val + nr - 1 > MAX_VSWAP);
 		atomic_add(nr, &vswap_used);
-	} else {
-		atomic_add(nr, &vswap_alloc_reject);
+
+		folio_ref_add(folio, nr);
+		folio_set_swapcache(folio);
+		folio->swap = entry;
+
+		node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+		lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
+		return 0;
+	}
+
+	atomic_add(nr, &vswap_alloc_reject);
+	if (memcgid) {
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(memcgid);
+		rcu_read_unlock();
+		if (memcg)
+			mem_cgroup_id_put_many(memcg, nr);
 	}
-	return entry;
+	return -ENOMEM;
 }
 
 static void vswap_cluster_free_rcu(struct rcu_head *head)
@@ -570,15 +597,21 @@ static unsigned short swp_desc_memcgid(struct swp_desc *desc);
  *    but the only vswap function called under ci->lock is vswap_rmap_set(),
  *    which uses atomic ops and does not take cluster->lock. So there is no
  *    ABBA deadlock risk.
+ *
+ * 4. Callers must ensure the range belongs to a single memcg, so we can
+ *    read the memcg id once from the first descriptor and use it for all
+ *    uncharge calls.
  */
 static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
-		int nr)
+		int nr, struct mem_cgroup *memcg)
 {
 	struct swp_desc *desc;
 	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
 	unsigned int phys_swap_type = 0;
 	bool need_flushing_phys_swap = false;
 	swp_slot_t flush_slot;
+	unsigned short batch_memcgid = 0;
+	unsigned int nr_swapfile = 0;
 	int i;
 
 	VM_WARN_ON(!entry.val);
@@ -587,6 +620,9 @@ static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
 		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
+		if (!i && !memcg)
+			batch_memcgid = swp_desc_memcgid(desc);
+
 		/*
 		 * We batch contiguous physical swap slots for more efficient
 		 * freeing.
@@ -604,6 +640,7 @@ static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
+			nr_swapfile++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -629,8 +666,44 @@ static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
 		flush_nr = phys_swap_end - phys_swap_start;
 		swap_slot_free_nr(flush_slot, flush_nr);
 	}
+
+	/*
+	 * Release the swap-side cgroup accounting for the freed range.
+	 *
+	 * On cgroup v1 with memsw accounting, memcg1_swapout() carries over a
+	 * memsw charge for every swapped-out entry regardless of backing, so
+	 * every freed entry needs a matching uncharge here (count = nr).
+	 *
+	 * On cgroup v2, memcg->swap is only charged via
+	 * __mem_cgroup_try_charge_swap() when we allocate a swapfile slot.
+	 * Only descs that are currently VSWAP_SWAPFILE need uncharging
+	 * (count = nr_swapfile).
+	 *
+	 * mem_cgroup_uncharge_swap() routes to the right counter and
+	 * adjusts the MEMCG_SWAP stat by the same count.
+	 *
+	 * On v1, desc->memcgid is only non-zero between memcg1_swapout() and
+	 * memcg1_swapin(); all non-free release_backing() callers run outside
+	 * that window, so the uncharge is a no-op for them. Those callers
+	 * pass @memcg == NULL; we resolve it from the recorded id lazily,
+	 * only if an uncharge is actually needed.
+	 */
+	if (!do_memsw_account() && !nr_swapfile)
+		return;
+
+	if (!memcg && batch_memcgid)
+		memcg = mem_cgroup_from_id(batch_memcgid);
+
+	if (do_memsw_account())
+		mem_cgroup_uncharge_swap(memcg, nr);
+	else
+		mem_cgroup_uncharge_swap(memcg, nr_swapfile);
 }
 
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+		swp_entry_t entry, unsigned int nr_ents,
+		struct mem_cgroup *memcg);
+
 /*
  * Entered with the cluster locked. The cluster lock is held throughout.
  *
@@ -650,64 +723,23 @@ static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
 static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	swp_entry_t entry)
 {
-	unsigned short memcgid = swp_desc_memcgid(desc);
+	unsigned short id = swp_desc_memcgid(desc);
+	struct mem_cgroup *memcg;
 
-	release_backing(cluster, entry, 1);
+	/*
+	 * The swap_cgroup id reference taken at swapout time pins this
+	 * memcg until swap_cgroup_clear() runs below, so we can resolve
+	 * it once here and pass it down. Caller already holds rcu.
+	 */
+	memcg = id ? mem_cgroup_from_id(id) : NULL;
 
-	mem_cgroup_uncharge_swap_by_id(memcgid, 1);
+	release_backing(cluster, entry, 1, memcg);
+	__vswap_swap_cgroup_clear(cluster, entry, 1, memcg);
 
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(cluster, entry.val);
 }
 
-/**
- * folio_alloc_swap - allocate virtual swap space for a folio.
- * @folio: the folio.
- *
- * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
- */
-int folio_alloc_swap(struct folio *folio)
-{
-	struct vswap_cluster *cluster = NULL;
-	int i, nr = folio_nr_pages(folio);
-	struct swp_desc *desc;
-	swp_entry_t entry;
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
-
-	entry = vswap_alloc(folio);
-	if (!entry.val)
-		return -ENOMEM;
-
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This will be changed soon - we will only charge on
-	 * physical swap slots allocation.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		rcu_read_lock();
-		for (i = 0; i < nr; i++) {
-			desc = vswap_iter(&cluster, entry.val + i);
-			VM_WARN_ON(!desc);
-			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
-		}
-		spin_unlock(&cluster->lock);
-		rcu_read_unlock();
-		atomic_add(nr, &vswap_alloc_reject);
-		entry.val = 0;
-		return -ENOMEM;
-	}
-
-	folio_ref_add(folio, nr);
-	folio_set_swapcache(folio);
-	folio->swap = entry;
-
-	node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
-
-	return 0;
-}
 
 /**
  * vswap_alloc_swap_slot - allocate physical swap space for a folio that is
@@ -726,19 +758,32 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	swp_slot_t slot = { .val = 0 };
 	swp_entry_t entry = folio->swap;
 	struct swp_desc *desc;
+	struct mem_cgroup *memcg;
+	unsigned short memcgid;
 	bool fallback = false;
 
 	/*
 	 * Check if the first entry already has a physical swap slot. If so,
 	 * the entire range is contiguous (from a previous allocation).
 	 * Keep the cluster pointer around for reuse below.
+	 *
+	 * Also resolve the swap memcg while we are in the same RCU section:
+	 * the folio's memcg almost always matches the recorded swap memcg, so
+	 * compare ids first and only fall back to the IDR lookup on mismatch.
+	 * The swap memcg is pinned by the swap_cgroup id ref, so we can safely
+	 * use it outside RCU after this point.
 	 */
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, entry.val);
 	VM_WARN_ON(!desc);
 	if (desc->type == VSWAP_SWAPFILE)
 		slot = desc->slot;
+	memcgid = swp_desc_memcgid(desc);
 	spin_unlock(&cluster->lock);
+
+	memcg = folio_memcg(folio);
+	if (!memcg || mem_cgroup_id(memcg) != memcgid)
+		memcg = memcgid ? mem_cgroup_from_id(memcgid) : NULL;
 	rcu_read_unlock();
 
 	if (slot.val)
@@ -750,6 +795,15 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	if (!slot.val)
 		return (swp_slot_t){ .val = 0 };
 
+	if (mem_cgroup_try_charge_swap(memcg, nr)) {
+		/*
+		 * We have not updated the backing type of the virtual swap slot.
+		 * Simply free up the physical swap slots here!
+		 */
+		swap_slot_free_nr(slot, nr);
+		return (swp_slot_t){ .val = 0 };
+	}
+
 	vswap_rmap_set(__swap_slot_to_cluster(slot), slot, entry.val, nr);
 
 	spin_lock(&cluster->lock);
@@ -1181,7 +1235,7 @@ void vswap_store_folio(swp_entry_t entry, struct folio *folio)
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, entry.val);
 	VM_WARN_ON(!desc);
-	release_backing(cluster, entry, nr);
+	release_backing(cluster, entry, nr, NULL);
 
 	for (i = 0; i < nr; i++) {
 		desc = __vswap_iter(cluster, entry.val + i);
@@ -1232,7 +1286,7 @@ void vswap_prepare_writeout(swp_entry_t entry, struct folio *folio)
 	}
 
 	/* Release old backing and store the folio, lock already held */
-	release_backing(cluster, entry, nr);
+	release_backing(cluster, entry, nr, NULL);
 
 	for (i = 0; i < nr; i++) {
 		desc = __vswap_iter(cluster, entry.val + i);
@@ -1263,7 +1317,7 @@ void swap_zeromap_folio_set(struct folio *folio)
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, entry.val);
 	VM_WARN_ON(!desc);
-	release_backing(cluster, entry, nr);
+	release_backing(cluster, entry, nr, NULL);
 
 	for (i = 0; i < nr; i++) {
 		desc = __vswap_iter(cluster, entry.val + i);
@@ -1949,7 +2003,7 @@ void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
 	VM_WARN_ON(!desc);
-	release_backing(cluster, swpentry, 1);
+	release_backing(cluster, swpentry, 1, NULL);
 	desc->zswap_entry = entry;
 	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
@@ -2023,6 +2077,23 @@ static unsigned short __vswap_cgroup_record(struct vswap_cluster *cluster,
 	return oldid;
 }
 
+/*
+ * Clear swap cgroup for a range of swap entries.
+ * Entered with the cluster locked. Caller must be under rcu_read_lock().
+ *
+ * @memcg is the mem_cgroup recorded in the descriptors (may be NULL). The
+ * caller is expected to have resolved it once; the swap_cgroup id reference
+ * dropped here.
+ */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents,
+				      struct mem_cgroup *memcg)
+{
+	__vswap_cgroup_record(cluster, entry, 0, nr_ents);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_ents);
+}
+
 static unsigned short vswap_cgroup_record(swp_entry_t entry,
 				unsigned short memcgid, unsigned int nr_ents)
 {
@@ -2040,30 +2111,10 @@ static unsigned short vswap_cgroup_record(swp_entry_t entry,
 	return oldid;
 }
 
-/**
- * swap_cgroup_record - record mem_cgroup for a set of swap entries.
- * These entries must belong to one single folio, and that folio
- * must be being charged for swap space (swap out), and these
- * entries must not have been charged
- *
- * @folio: the folio that the swap entry belongs to
- * @memcgid: mem_cgroup ID to be recorded
- * @entry: the first swap entry to be recorded
- */
-void swap_cgroup_record(struct folio *folio, unsigned short memcgid,
-			swp_entry_t entry)
-{
-	unsigned short oldid =
-		vswap_cgroup_record(entry, memcgid, folio_nr_pages(folio));
-
-	VM_WARN_ON(oldid);
-}
-
 /**
  * __swap_cgroup_record - record mem_cgroup for a set of swap entries.
  *
- * Same as swap_cgroup_record, but assumes the swap cache (vswap cluster)
- * lock is already held.
+ * Assumes the swap cache (vswap cluster) lock is already held.
  *
  * @folio: the folio that the swap entry belongs to
  * @memcgid: mem_cgroup ID to be recorded
@@ -2170,6 +2221,12 @@ static unsigned short swp_desc_memcgid(struct swp_desc *desc)
 	return desc->memcgid;
 }
 #else /* !CONFIG_MEMCG */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents,
+				      struct mem_cgroup *memcg)
+{
+}
+
 static unsigned short swp_desc_memcgid(struct swp_desc *desc)
 {
 	return 0;
-- 
2.52.0


