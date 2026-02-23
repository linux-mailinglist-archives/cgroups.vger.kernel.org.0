Return-Path: <cgroups+bounces-14175-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJxeNvzWnGkJLAQAu9opvQ
	(envelope-from <cgroups+bounces-14175-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:38:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45A17E718
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A754303289B
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4337B40E;
	Mon, 23 Feb 2026 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi4MdkUt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197937B409
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886324; cv=none; b=FauK8Rk4p/vvOXZn33oGGfQjFO4uxr6LNUXR8Vjd0lO4Y/TR6NhvG5h3vJ3vAxJ7dRa4J/2LTY7SKCG/k1lx6gvU9U2SKgrgVZyziRpLT8OSstBO4f85wkUR0HtxGzLBoQxbGP+yq/xRgl5mU6QG5jgjIf2lAPeAVG49/JkNtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886324; c=relaxed/simple;
	bh=9p9b4wTyiH+3zXgCgFpIzE03VpYZIw3CjMarPDWWvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSdkhBAqiPr2lGHiIR4+HDP4FRVp+9CQHiHZGdfGLzdMRtY9Y7m/d0VGE6a7H07bVXiiYOmPgQMe9iU4ML7TrIYOPLyZPGwe4hG+9QSz4XioRmEvkp4vV1hKrrdrhaZc4vpQFdN52hEGq432KY/kleEFi0osnuPwrL77I2m3Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi4MdkUt; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c68f0e47so2859256a34.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886322; x=1772491122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkAGKD7Y1lByzW5ZH+EADePeSZfMfZz07pF+iYnM/14=;
        b=gi4MdkUtt9Pm8O1CBJHqMgsvjsqqcI0gwUPvdkRLNb07cnt9bNODnR3+Qpwsb2BzeV
         Kxse5ZrgtOge7/+RCYvJs3L4FDMzh0RJfmVyjxn+TlYJrNywDclLQD/0tAH1u6KrPb80
         u+d6ZWmrbLI4qIRTn9KagOdUVM31fQt+u52CMtHHqlz9TXdAb6RyJoMCGhtD0T0BEl6F
         nrHMvvaflooGfry45x+4A/s9WsR/V78RARdOEW8wqvtA6FmKeEc6xhyYaQ2PqDg2py3n
         0fjP7An3It4Yn2IRhk98jh+l/xXO6/LlgeM6nM2XW99h4qEPyTVj8bhxbV2j9iu8kQrC
         qBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886322; x=1772491122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkAGKD7Y1lByzW5ZH+EADePeSZfMfZz07pF+iYnM/14=;
        b=v0+28z6nrQLpQnh4WQMmVEicaNazn0AagUI4d+S2AQ0djKquRkuwvPFzhl11J3Gic/
         DqnE03/ybFYQ4ix65QHKC5pyhA/B30btPAwpIaIjmwL2sw9OxHC0dRMb1phFaTQ0cN6h
         qgXNU/F4exk7JdpzO4Urt1hCOqyEYKaCKaeIq3XlXCq/xVfgkpe/RcrQpyb321N8Gzqa
         /1TzrvVnYVHPsmkT4bMfPBkQcrmS1I7EARjXHEkXt2xjwy+UxL8+gxydHaXS0Lcmc2Ch
         aU1rfYQ/w/vdvgfgYYGQj8ODcqDfjRpcvg3vKFK8bKPwkYG9X0KikS6rMX83KB6IYwE1
         9yQg==
X-Forwarded-Encrypted: i=1; AJvYcCWH8TRxiJRO2iUhCKw6lXiGCtnjgSUW8h7zBFawi+YfXihMoGbWAjsyKAsdfq1pUNjuf8iCxkUf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xHDu/y2rF2xyEqJMjBsDZMQa0nhrCe/iOzP2DKB8CxVbDKeP
	suzeyWBCf40HaQQhiSZXzwLfvYezdhVleEy2y+wVeYl7ZRKb2MJEBPiQ
X-Gm-Gg: AZuq6aKut84QOk4i8j7VxR8NY1SONJ8q+3P4VgH+NM8d4UMCiuAo1FrTfU1zxsw53Z7
	Ni1a+pO7cM32dkEYUW2t2O0JyfkDsOEPZwefQzpFwg+kwUGZidqQxLL8FmqtHcphmwJIee7d5E/
	iPXB2Vwuo1HXYvkFaKYtQlEIV/OqvMtFqRjHiEVZD5y54q1Lkl82rGMPmleIDy5OvRch/4qLi1M
	xF0mtDBSekWtOy72wbDxFDfYT0cY+zGfYvwGOAPUuHxzEbehpOeUHOlcdSfbn64TF1ZyxV7HOPn
	+FhN2LUxPdKbGaephJ2RCo5qJomj2s9e5zIZq/946ovWmwWYJcT3NoW6veq2JAFtVSXVqvKovaT
	kBOROxqgGQDoujbhie4ImcHwMcubrH4ix0ieQmtycYIKkw7LRgQNmtuVzfct+b9fOPiiMrYmj8z
	X6xTP/xufodRDqxY4YR3FpSA==
X-Received: by 2002:a05:6830:4709:b0:78a:5183:8f6a with SMTP id 46e09a7af769-7d52bf6f7ccmr8378736a34.28.1771886321962;
        Mon, 23 Feb 2026 14:38:41 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386c6sm8952995a34.13.2026.02.23.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:41 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 5/6] mm/memcontrol, page_counter: Make memory.low tier-aware
Date: Mon, 23 Feb 2026 14:38:28 -0800
Message-ID: <20260223223830.586018-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14175-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC45A17E718
X-Rspamd-Action: no action

On machines serving multiple workloads whose memory is isolated via
the memory cgroup controller, it is currently impossible to enforce a
fair distribution of toptier memory among the worloads, as the only
enforcable limits have to do with total memory footprint, but not where
that memory resides.

This makes ensuring a consistent and baseline performance difficult, as
each workload's performance is heavily impacted by workload-external
factors such as which other workloads are co-located in the same host,
and the order at which different workloads are started.

Extend the existing memory.low protection to be tier-aware in the
charging, enforcement, and protection calculation to provide
best-effort attempts at protecting a fair proportion of toptier memory.

Updates to protection and charging are performed in the same path as
the standard memcontrol equivalents. Enforcing tier-aware memcg limits
however, are gated behind the sysctl tier_aware_memcg. This is so that
runtime-enabling of tier aware limits can account for memory already
present in the system.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h   | 15 +++++++++++----
 include/linux/page_counter.h |  7 ++++---
 kernel/cgroup/dmem.c         |  2 +-
 mm/memcontrol.c              | 14 ++++++++++++--
 mm/page_counter.c            | 35 ++++++++++++++++++++++++++++++++++-
 mm/vmscan.c                  | 13 +++++++++----
 6 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 900a36112b62..a998a1e3b8b0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -606,7 +606,9 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 }
 
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-				     struct mem_cgroup *memcg);
+				     struct mem_cgroup *memcg, bool toptier);
+
+unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg);
 
 void update_memcg_toptier_capacity(void);
 
@@ -623,11 +625,15 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 }
 
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
-					struct mem_cgroup *memcg)
+					struct mem_cgroup *memcg, bool toptier)
 {
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
+	if (toptier)
+		return READ_ONCE(memcg->memory.etoptier_low) >=
+				 mem_cgroup_toptier_usage(memcg);
+
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
@@ -1114,7 +1120,8 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 }
 
 static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-						   struct mem_cgroup *memcg)
+						   struct mem_cgroup *memcg,
+						   bool toptier)
 {
 }
 
@@ -1128,7 +1135,7 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 	return true;
 }
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
-					struct mem_cgroup *memcg)
+					struct mem_cgroup *memcg, bool toptier)
 {
 	return false;
 }
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index ada5f1dd75d4..6635ee7b9575 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -120,15 +120,16 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
-				       bool recursive_protection);
+				       bool recursive_protection, bool toptier);
 void page_counter_update_toptier_capacity(struct page_counter *counter,
 					  const nodemask_t *allowed);
 unsigned long page_counter_toptier_high(struct page_counter *counter);
 unsigned long page_counter_toptier_low(struct page_counter *counter);
 #else
 static inline void page_counter_calculate_protection(struct page_counter *root,
-						     struct page_counter *counter,
-						     bool recursive_protection) {}
+						struct page_counter *counter,
+						bool recursive_protection,
+						bool toptier) {}
 #endif
 
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ea6afffa985..536d43c42de8 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -277,7 +277,7 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
 			continue;
 
 		page_counter_calculate_protection(
-			climit, &found_pool->cnt, true);
+			climit, &found_pool->cnt, true, false);
 
 		if (found_pool == test_pool)
 			break;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 07464f02c529..8aa7ae361a73 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4806,12 +4806,13 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
+ * @toptier: whether the caller is in a toptier node
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
  */
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-				     struct mem_cgroup *memcg)
+				     struct mem_cgroup *memcg, bool toptier)
 {
 	bool recursive_protection =
 		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
@@ -4822,7 +4823,16 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
+	page_counter_calculate_protection(&root->memory, &memcg->memory,
+					  recursive_protection, toptier);
+}
+
+unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled() || !memcg)
+		return 0;
+
+	return atomic_long_read(&memcg->memory.toptier_usage);
 }
 
 void update_memcg_toptier_capacity(void)
diff --git a/mm/page_counter.c b/mm/page_counter.c
index cf21c72bfd4e..79d46a1c4c0c 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -410,12 +410,39 @@ static unsigned long effective_protection(unsigned long usage,
 	return ep;
 }
 
+static void calculate_protection_toptier(struct page_counter *counter,
+					 bool recursive_protection)
+{
+	struct page_counter *parent = counter->parent;
+	unsigned long toptier_low;
+	unsigned long toptier_usage, parent_toptier_usage;
+	unsigned long toptier_protected, old_toptier_protected;
+	long delta;
+
+	toptier_low = page_counter_toptier_low(counter);
+	toptier_usage = atomic_long_read(&counter->toptier_usage);
+	parent_toptier_usage = atomic_long_read(&parent->toptier_usage);
+
+	/* Propagate toptier low usage to parent for sibling distribution */
+	toptier_protected = min(toptier_usage, toptier_low);
+	old_toptier_protected = atomic_long_xchg(&counter->toptier_low_usage,
+						 toptier_protected);
+	delta = toptier_protected - old_toptier_protected;
+	atomic_long_add(delta, &parent->children_toptier_low_usage);
+
+	WRITE_ONCE(counter->etoptier_low,
+		   effective_protection(toptier_usage, parent_toptier_usage,
+		   toptier_low, READ_ONCE(parent->etoptier_low),
+		   atomic_long_read(&parent->children_toptier_low_usage),
+		   recursive_protection));
+}
 
 /**
  * page_counter_calculate_protection - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @counter: the page_counter the counter to update
  * @recursive_protection: Whether to use memory_recursiveprot behavior.
+ * @toptier: Whether to calculate toptier-proportional protection
  *
  * Calculates elow/emin thresholds for given page_counter.
  *
@@ -424,7 +451,7 @@ static unsigned long effective_protection(unsigned long usage,
  */
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
-				       bool recursive_protection)
+				       bool recursive_protection, bool toptier)
 {
 	unsigned long usage, parent_usage;
 	struct page_counter *parent = counter->parent;
@@ -446,6 +473,9 @@ void page_counter_calculate_protection(struct page_counter *root,
 	if (parent == root) {
 		counter->emin = READ_ONCE(counter->min);
 		counter->elow = READ_ONCE(counter->low);
+		if (toptier)
+			WRITE_ONCE(counter->etoptier_low,
+				   page_counter_toptier_low(counter));
 		return;
 	}
 
@@ -462,6 +492,9 @@ void page_counter_calculate_protection(struct page_counter *root,
 			READ_ONCE(parent->elow),
 			atomic_long_read(&parent->children_low_usage),
 			recursive_protection));
+
+	if (toptier)
+		calculate_protection_toptier(counter, recursive_protection);
 }
 
 void page_counter_update_toptier_capacity(struct page_counter *counter,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a87ac7be43c..5b4cb030a477 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4144,6 +4144,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
 	bool reclaimable = !min_ttl;
+	bool toptier = node_is_toptier(pgdat->node_id);
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
@@ -4153,7 +4154,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		mem_cgroup_calculate_protection(NULL, memcg);
+		mem_cgroup_calculate_protection(NULL, memcg, toptier);
 
 		if (!reclaimable)
 			reclaimable = lruvec_is_reclaimable(lruvec, sc, min_ttl);
@@ -4905,12 +4906,14 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	unsigned long reclaimed = sc->nr_reclaimed;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	bool toptier = tier_aware_memcg_limits &&
+		       node_is_toptier(pgdat->node_id);
 
 	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
-	if (mem_cgroup_below_low(NULL, memcg)) {
+	if (mem_cgroup_below_low(NULL, memcg, toptier)) {
 		/* see the comment on MEMCG_NR_GENS */
 		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
 			return MEMCG_LRU_TAIL;
@@ -5960,6 +5963,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	};
 	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
 	struct mem_cgroup *memcg;
+	bool toptier = node_is_toptier(pgdat->node_id);
 
 	/*
 	 * In most cases, direct reclaimers can do partial walks
@@ -5987,7 +5991,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		cond_resched();
 
-		mem_cgroup_calculate_protection(target_memcg, memcg);
+		mem_cgroup_calculate_protection(target_memcg, memcg, toptier);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
@@ -5995,7 +5999,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
+		} else if (mem_cgroup_below_low(target_memcg, memcg,
+					tier_aware_memcg_limits && toptier)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
-- 
2.47.3


