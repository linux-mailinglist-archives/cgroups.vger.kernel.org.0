Return-Path: <cgroups+bounces-16247-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFLXKLo/FGoXLQcAu9opvQ
	(envelope-from <cgroups+bounces-16247-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:25:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C25CA712
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34544303CA7D
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2612381B17;
	Mon, 25 May 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWGYa4Qq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629B37FF79
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711800; cv=none; b=aqttsGalUmzwGHYK5D86qQfab1+5wWF6HbMCpIeKlBQYfWOa0V3vvsVrNHnnC9e4u/uVb9hDQ0YOWIM8Z7ZIchZshKSyt0rzzhGgj0XPKSmWfDaqvA62eo6L+XEAWfVtVgFprEbEfjt4UIy4q+qAFgGaAMDRkYkOlg+1QBfxeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711800; c=relaxed/simple;
	bh=1nz785EW5WPZmz23ZJhsomLMKvkUt7QhwQgs4eSChpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dc1JNa2QNuWABNeLs/Iv9zKwYqCC6rIh3VQs7iayuKwHbOMnSkHBghNE8IMNIUMy9M4H/y+iJcmHLHD+hvruXaZAHARueKM+PJD/+wlhHC+gyI2zJWc+oSLrSwP+3LTeNIyhdZVHuRWt3Un1ENLs1u5CI3AbFn+5MWIC0hg4xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWGYa4Qq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso6283334a91.2
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779711798; x=1780316598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCgp1DVd9xo2joxajci3qyEuXkTq0+UzE9J3t6+D+hI=;
        b=DWGYa4QqPMKTHKM7jC6LsmpdmZ0cR3G3tkI8BExYpr0L0bOgjirrXZFmuunnSeABzg
         pzp9FVNt4ng5wmTsevx4ZtfbOAdMt3WW3nnQ4CyrfGRUw2+0Yto/Uq7fscVT38eIh5jV
         mr5e4TMLovFBhzYmdBVn7rkDO5EGzLxhaTlj9TFRMtsXmG/Kc1fSV9K170oxX2ts14sh
         ZvBAb+M2nbiugHgYM1SHPeaF4db/OBX/lwAR0+6vEy595aT+q5aSgdlqY1TJokhD2RYK
         vMW4QkOrktpfGmljomo1n+c19229mS2l22qeG3/l3mboDGP3YH6Oms81ezTf2P+VR9lg
         BZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711798; x=1780316598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCgp1DVd9xo2joxajci3qyEuXkTq0+UzE9J3t6+D+hI=;
        b=bj4K5ZeS+/VTO6qY5JVhMwqd6jR7Y4fgQ07pHE+XMGqlUf3uAXphYFjVrO5lHFk4vt
         M1uvjLVghw9WYhY/GsV3NAOAVnJgO92bqPR5bJvD4PEFmR/3PxPKtljU1pGx5dbLBJth
         fwCNKcdryXcU6tfIfwfLhQnrkgo3r8C8jEBetELa6cuKZuBxt3cjEVuhijVALxu5Ym0s
         R2cpKvcp5Ws1XZWDXuExePQXHA29yGFA+/C7BWkpqUC4g480/BaREX76w9d9t3yurhdB
         Xh4uwI8dCTFtpDo1Pt8CFDrauINnxU/dxwcadop045xMrTZ4xheqAGjZR9uV44fCI6PI
         1hKA==
X-Gm-Message-State: AOJu0YxWwZ5cZFtoTwgBckTNTDeDKFPO2ohE/h6jUmGadrykqK2mPBRN
	Dqyos3CCnTgp/biLiRI0oc/xie9xcJjb4G454FcuilPGMSPByF7ysMEtOGg8wA==
X-Gm-Gg: Acq92OHRqrUrN751ynGefauqxL2mXllewr9Lg4KTchg+lbx8MDgnKMToRktQRvRkYSl
	irzLREaN1GaV4GPArh571ebh+a+V0wurqiKFRdrhnqRZ6hk7jg7pJtSwhool+nm+PnnBVrIaTAY
	MtQ6GQGJjJoDPtqpASw9QFvdqFWX8jD1Yrh6OCAVtfglXMi7rudDHyc02mNt7wcso3YpMFCNxZ8
	QrYCED/w8BsHAa4I4wks1wIYimgN5XySO2eY1OO+5jYcSXrNj9PSBku+WhPKEAcKF9Mex+Jl9EF
	QvpyCBaddowJKqF64cu0O9Igr0AfQv+W9uYlQpuEGCIH/vtxsHoa5JAFL3Yo7WPti5rUmpIc03h
	JYGK+p6pSofjPdwcN2ncSO50eFcBk/QBuHCNTPOnJqHgeZdN3voRI3q1xh1DBVfSWcEkc4OB06z
	og4EJ3FV8CZqiBoliuo42odtAVvuTDKypDjuOfm2W+GQDyX3eLjSw=
X-Received: by 2002:a17:90a:d885:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-36a6782a785mr13015019a91.20.1779711798253;
        Mon, 25 May 2026 05:23:18 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm8999131a91.15.2026.05.25.05.23.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 05:23:17 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH v2 3/4] mm/zswap: Add per-memcg stat for proactive writeback
Date: Mon, 25 May 2026 20:22:41 +0800
Message-Id: <20260525122242.36127-4-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260525122242.36127-1-jiahao.kernel@gmail.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16247-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: EF6C25CA712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

Currently, zswap writeback can be triggered by either the pool limit
being hit or by the proactive writeback mechanism. However, the
existing 'zswpwb' metric in memory.stat and /proc/vmstat counts all
written back pages, making it difficult to distinguish between pages
written back due to the pool limit and those written back proactively.

Add a new statistic 'zswpwb_proactive' to memory.stat and /proc/vmstat.
This counter tracks the number of pages written back due to proactive
writeback. This allows users to better monitor and tune the proactive
writeback mechanism.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 +++
 include/linux/vm_event_item.h           |  1 +
 mm/memcontrol.c                         |  1 +
 mm/vmstat.c                             |  1 +
 mm/zswap.c                              | 41 ++++++++++++++++++-------
 5 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6564abf0dec5..7d65aef83f7b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1748,6 +1748,10 @@ The following nested keys are defined.
 	  zswpwb
 		Number of pages written from zswap to swap.
 
+	  zswpwb_proactive
+		Number of pages written from zswap to swap by proactive
+		writeback. This is a subset of zswpwb.
+
 	  zswap_incomp
 		Number of incompressible pages currently stored in zswap
 		without compression. These pages could not be compressed to
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 03fe95f5a020..7a5bee0a20b6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -138,6 +138,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		ZSWPIN,
 		ZSWPOUT,
 		ZSWPWB,
+		ZSWPWB_PROACTIVE,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 409c41359dc8..67de71b2a659 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -571,6 +571,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 	ZSWPIN,
 	ZSWPOUT,
 	ZSWPWB,
+	ZSWPWB_PROACTIVE,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..66fd06d1bb01 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1452,6 +1452,7 @@ const char * const vmstat_text[] = {
 	[I(ZSWPIN)]				= "zswpin",
 	[I(ZSWPOUT)]				= "zswpout",
 	[I(ZSWPWB)]				= "zswpwb",
+	[I(ZSWPWB_PROACTIVE)]			= "zswpwb_proactive",
 #endif
 #ifdef CONFIG_X86
 	[I(DIRECT_MAP_LEVEL2_SPLIT)]		= "direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 947507b9a185..78190631e2c4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -160,6 +160,11 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 };
 
+struct zswap_shrink_walk_arg {
+	bool proactive;
+	bool encountered_page_in_swapcache;
+};
+
 /* Global LRU lists shared by all zswap pools. */
 static struct list_lru zswap_list_lru;
 
@@ -1042,7 +1047,8 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
  * freed.
  */
 static int zswap_writeback_entry(struct zswap_entry *entry,
-				 swp_entry_t swpentry)
+				 swp_entry_t swpentry,
+				 bool proactive)
 {
 	struct xarray *tree;
 	pgoff_t offset = swp_offset(swpentry);
@@ -1102,6 +1108,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPWB, 1);
 
+	if (proactive) {
+		count_vm_event(ZSWPWB_PROACTIVE);
+		if (entry->objcg)
+			count_objcg_events(entry->objcg, ZSWPWB_PROACTIVE, 1);
+	}
+
 	zswap_entry_free(entry);
 
 	/* folio is up to date */
@@ -1151,7 +1163,8 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 				       void *arg)
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
-	bool *encountered_page_in_swapcache = (bool *)arg;
+	struct zswap_shrink_walk_arg *walk_arg = arg;
+	bool proactive_wb = walk_arg && walk_arg->proactive;
 	swp_entry_t swpentry;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
@@ -1206,7 +1219,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 */
 	spin_unlock(&l->lock);
 
-	writeback_result = zswap_writeback_entry(entry, swpentry);
+	writeback_result = zswap_writeback_entry(entry, swpentry, proactive_wb);
 
 	if (writeback_result) {
 		zswap_reject_reclaim_fail++;
@@ -1217,9 +1230,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
 		 * shrinker context).
 		 */
-		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
+		if (writeback_result == -EEXIST && walk_arg) {
 			ret = LRU_STOP;
-			*encountered_page_in_swapcache = true;
+			walk_arg->encountered_page_in_swapcache = true;
 		}
 	} else {
 		zswap_written_back_pages++;
@@ -1231,8 +1244,11 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
+	struct zswap_shrink_walk_arg walk_arg = {
+		.proactive = false,
+		.encountered_page_in_swapcache = false,
+	};
 	unsigned long shrink_ret;
-	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
 			!mem_cgroup_zswap_writeback_enabled(sc->memcg)) {
@@ -1241,9 +1257,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	}
 
 	shrink_ret = list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_memcg_cb,
-		&encountered_page_in_swapcache);
+		&walk_arg);
 
-	if (encountered_page_in_swapcache)
+	if (walk_arg.encountered_page_in_swapcache)
 		return SHRINK_STOP;
 
 	return shrink_ret ? shrink_ret : SHRINK_STOP;
@@ -1714,7 +1730,10 @@ static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
 		return -ENOENT;
 
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
-		bool encountered_page_in_swapcache = false;
+		struct zswap_shrink_walk_arg walk_arg = {
+			.proactive = true,
+			.encountered_page_in_swapcache = false,
+		};
 		unsigned long nr_to_scan, nr_scanned = 0;
 
 		/*
@@ -1748,12 +1767,12 @@ static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
 
 			nr_written += list_lru_walk_one(&zswap_list_lru, nid, memcg,
 							&shrink_memcg_cb,
-							&encountered_page_in_swapcache,
+							&walk_arg,
 							&nr_to_walk);
 
 			if (nr_written >= nr_to_write)
 				return nr_written;
-			if (encountered_page_in_swapcache)
+			if (walk_arg.encountered_page_in_swapcache)
 				break;
 
 			cond_resched();
-- 
2.34.1


