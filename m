Return-Path: <cgroups+bounces-14176-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OkjDEGrXnGn+LgQAu9opvQ
	(envelope-from <cgroups+bounces-14176-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:40:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1D17E789
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 738FD3144561
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D337BE67;
	Mon, 23 Feb 2026 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJwHVpTS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B637BE6E
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886330; cv=none; b=Z/eWkecofeInKktniByxB9q2HqUVr1lIf8A3zjJ0JT5hWqkb+/fHEL75zRkk4LuApZ+lu/nHw+poirYqBBjYtUCKa4q8Ufv6Ppdwbzhp/gwYoHOjyx1gamH1SBeF21QraYhRUCdBDp6gwEoZHQwEvofwInCXjUbt7qXB7FFCuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886330; c=relaxed/simple;
	bh=sBvHCRLOSKHT83gdccnLmheOXBIOB5m3ZeZY9+qfNQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psDzlWK5tg1W7V46yRGxvuZqvZzx9IqTN9KIBmHVtEES8edtWYaFjobL8MAj7PF/3R9231BdPVnxjGqdHmd6Q7TwN17tbfEYbsuDXGxsNXu/H3Clvcy2aybaNbWhZc2q75wPAWQ2pLmueEyvieC4PUF6sKD7k9JEIH9X4HhKdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJwHVpTS; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c4b494fcso2784965a34.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886323; x=1772491123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/pi4GMyqfUzxedG8y+xzMj5Pky+ci5h56Uzs52BODo=;
        b=MJwHVpTSrjWbYibbWrJ0R73PEr0g9TRcUEdz7li+J4GMN5D6xVnlFthNRBVtg7SuQ0
         mwP5xmsaVwTlAJozaLGVhPo+uC+nlB3tlRrMi0YFTQkP0ErFhKwAQj59WYxJz03QsS2V
         bPU300jPsoJdEhMBklIEPs6xcK7YA4fr4seeRv45Bm5jtK4KA2TnamjTg440ItepjBPI
         j1/usqUOeMorV8qDDDTZ0HuvkZAj2rlHUQEkcHkCh+0BUfEoSSHvOFITQPaILHSoAREn
         PYAnIl2yViMCvKmDVPJuXN3DJM9DcC3Cdt0GLCxyYsvzvxz+xBNpDW73poU/oergbY+e
         RyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886323; x=1772491123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/pi4GMyqfUzxedG8y+xzMj5Pky+ci5h56Uzs52BODo=;
        b=brripid9+yFFLupVG8nxCQSJlmCYAivQeV6ngyMkackSAXQJadYUxaxdKkbOxTnjL9
         EchuBV0Z1ZQyezGow+0D2MADrKwjhkoTCuvdzcXBRncIrrLUeb+lwYVQHC4QJlyEEz33
         OLI2d1xzbrwO9pvLLt10vsRpOjtVTzBMkX9tg+8KJnRn1cVslySpvZejaDvYIcnI7v6u
         1oKFdrSQ8WEdFz/e2SRQN0UoSS37l9LHPhGZEqCp6wtPv8tVhH6uG1RTk4vwnG+qpp8O
         CAUYBzJ2miAa3kqdqawBSYrF9KFFz7yTC/TT66FUUAtABaE7yS2e26/FGNiSIf5VGCu4
         J4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCX1xeqrXfOZhzGQoGGfWgyL8NqqVOItXhAr9LhRIbdalpkZ39FHP6giJS85s1YI5kNgoYQnHw@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY8QEtQbGr5E4uI1wL+Rg3UclH483LFaeSGgvyugRFiMxPlTc
	Wth4+DTzT/ZYwEhKkJA2XRvZGw2oTZjmpFjUsyBVgEVitT0lAPOvELBV
X-Gm-Gg: AZuq6aImHZ1I+gc+SutbheqZwHFDKlE+9mBWId4SPnJ+fE17zC9k1qq89zuiRhadKQ7
	XSwE76l8UNVJ9KR1p6CwvZourhjVXYpVP9B3Tw1mrqY/JkBdMhqXGRk0xaolsab6Icz6idc1nTQ
	bfTubbqLjLrQJOtcrT1iwhssO6k+oFlt4G46iHrkG+pWKxDUhUL8+LtV5r1Ynuu15+4iaqDgBzu
	i0Bnh1m1U3zH1F6K34icul9YBc+NPI7e5IT2bLCb+M/B5B8yk8HmOtzuPT9vIADoEUVtBKT5F3E
	55bfqU4c+sWAgSPlNalJJDgsYTx3vyV9eMrdbMg3STv+Drbr66lBNiopya0KADxHos2ptF2wsQv
	8B6qeEuSx8O/vyyVHA9E2xn8/PJk6ZUzWpIiCS/GDqnauK8n0CM+OR38YX939JNykKsKv1/ErdV
	A+soaNurhf/fTfZmTmibOOJpsuvNz8LgEl
X-Received: by 2002:a05:6830:6610:b0:7d1:9da9:c6e with SMTP id 46e09a7af769-7d52bf6bb20mr5168975a34.25.1771886323539;
        Mon, 23 Feb 2026 14:38:43 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52ce63069sm8952812a34.0.2026.02.23.14.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:42 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
Date: Mon, 23 Feb 2026 14:38:29 -0800
Message-ID: <20260223223830.586018-7-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14176-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90C1D17E789
X-Rspamd-Action: no action

On machines serving multiple workloads whose memory is isolated via the
memory cgroup controller, it is currently impossible to enforce a fair
distribution of toptier memory among the workloads, as the only
enforcable limits have to do with total memory footprint, but not where
that memory resides.

This makes ensuring a consistent and baseline performance difficult, as
each workload's performance is heavily impacted by workload-external
factors wuch as which other workloads are co-located in the same host,
and the order at which different workloads are started.

Extend the existing memory.high protection to be tier-aware in the
charging and enforcement to limit toptier-hogging for workloads.

Also, add a new nodemask parameter to try_to_free_mem_cgroup_pages,
which can be used to selectively reclaim from memory at the
memcg-tier interection of a cgroup.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/swap.h |  3 +-
 mm/memcontrol-v1.c   |  6 ++--
 mm/memcontrol.c      | 85 +++++++++++++++++++++++++++++++++++++-------
 mm/vmscan.c          | 11 +++---
 4 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0effe3cc50f5..c6037ac7bf6e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -368,7 +368,8 @@ extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
 						  unsigned int reclaim_options,
-						  int *swappiness);
+						  int *swappiness,
+						  nodemask_t *allowed);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 0b39ba608109..29630c7f3567 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1497,7 +1497,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
+				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
+				NULL, NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -1529,7 +1530,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP, NULL))
+						  MEMCG_RECLAIM_MAY_SWAP,
+						  NULL, NULL))
 			nr_retries--;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8aa7ae361a73..ebd4a1b73c51 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2184,18 +2184,30 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 
 	do {
 		unsigned long pflags;
-
-		if (page_counter_read(&memcg->memory) <=
-		    READ_ONCE(memcg->memory.high))
+		nodemask_t toptier_nodes, *reclaim_nodes;
+		bool mem_high_ok, toptier_high_ok;
+
+		mt_get_toptier_nodemask(&toptier_nodes, NULL);
+		mem_high_ok = page_counter_read(&memcg->memory) <=
+			      READ_ONCE(memcg->memory.high);
+		toptier_high_ok = !(tier_aware_memcg_limits &&
+				    mem_cgroup_toptier_usage(memcg) >
+				    page_counter_toptier_high(&memcg->memory));
+		if (mem_high_ok && toptier_high_ok)
 			continue;
 
+		if (mem_high_ok && !toptier_high_ok)
+			reclaim_nodes = &toptier_nodes;
+		else
+			reclaim_nodes = NULL;
+
 		memcg_memory_event(memcg, MEMCG_HIGH);
 
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
 							MEMCG_RECLAIM_MAY_SWAP,
-							NULL);
+							NULL, reclaim_nodes);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2296,6 +2308,24 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 	return max_overage;
 }
 
+static u64 toptier_find_max_overage(struct mem_cgroup *memcg)
+{
+	u64 overage, max_overage = 0;
+
+	if (!tier_aware_memcg_limits)
+		return 0;
+
+	do {
+		unsigned long usage = mem_cgroup_toptier_usage(memcg);
+		unsigned long high = page_counter_toptier_high(&memcg->memory);
+
+		overage = calculate_overage(usage, high);
+		max_overage = max(overage, max_overage);
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		  !mem_cgroup_is_root(memcg));
+
+	return max_overage;
+}
 static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 {
 	u64 overage, max_overage = 0;
@@ -2401,6 +2431,14 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
 						swap_find_max_overage(memcg));
 
+	/*
+	 * Don't double-penalize for toptier high overage if system-wide
+	 * memory.high has already been breached.
+	 */
+	if (!penalty_jiffies)
+		penalty_jiffies += calculate_high_delay(memcg, nr_pages,
+					toptier_find_max_overage(memcg));
+
 	/*
 	 * Clamp the max delay per usermode return so as to still keep the
 	 * application moving forwards and also permit diagnostics, albeit
@@ -2503,7 +2541,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options, NULL);
+						    gfp_mask, reclaim_options,
+						    NULL, NULL);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -2592,23 +2631,26 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		bool mem_high, swap_high;
+		bool mem_high, swap_high, toptier_high = false;
 
 		mem_high = page_counter_read(&memcg->memory) >
 			READ_ONCE(memcg->memory.high);
 		swap_high = page_counter_read(&memcg->swap) >
 			READ_ONCE(memcg->swap.high);
+		toptier_high = tier_aware_memcg_limits &&
+			       (mem_cgroup_toptier_usage(memcg) >
+				page_counter_toptier_high(&memcg->memory));
 
 		/* Don't bother a random interrupted task */
 		if (!in_task()) {
-			if (mem_high) {
+			if (mem_high || toptier_high) {
 				schedule_work(&memcg->high_work);
 				break;
 			}
 			continue;
 		}
 
-		if (mem_high || swap_high) {
+		if (mem_high || swap_high || toptier_high) {
 			/*
 			 * The allocating tasks in this cgroup will need to do
 			 * reclaim or be throttled to prevent further growth
@@ -4476,7 +4518,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	bool drained = false;
-	unsigned long high;
+	unsigned long high, toptier_high;
 	int err;
 
 	buf = strstrip(buf);
@@ -4485,15 +4527,22 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_high(&memcg->memory, high);
+	toptier_high = page_counter_toptier_high(&memcg->memory);
 
 	if (of->file->f_flags & O_NONBLOCK)
 		goto out;
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long toptier_pages = mem_cgroup_toptier_usage(memcg);
 		unsigned long reclaimed;
+		unsigned long to_free;
+		nodemask_t toptier_nodes, *reclaim_nodes;
+		bool mem_high_ok = nr_pages <= high;
+		bool toptier_high_ok = !(tier_aware_memcg_limits &&
+					 toptier_pages > toptier_high);
 
-		if (nr_pages <= high)
+		if (mem_high_ok && toptier_high_ok)
 			break;
 
 		if (signal_pending(current))
@@ -4505,8 +4554,17 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			continue;
 		}
 
-		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
+		mt_get_toptier_nodemask(&toptier_nodes, NULL);
+		if (mem_high_ok && !toptier_high_ok) {
+			reclaim_nodes = &toptier_nodes;
+			to_free = toptier_pages - toptier_high;
+		} else {
+			reclaim_nodes = NULL;
+			to_free = nr_pages - high;
+		}
+		reclaimed = try_to_free_mem_cgroup_pages(memcg, to_free,
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL, reclaim_nodes);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -4558,7 +4616,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL, NULL))
 				nr_reclaims--;
 			continue;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b4cb030a477..94498734b4f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6652,7 +6652,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
 					   unsigned int reclaim_options,
-					   int *swappiness)
+					   int *swappiness, nodemask_t *allowed)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6668,6 +6668,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.nodemask = allowed,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6693,7 +6694,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
 					   unsigned int reclaim_options,
-					   int *swappiness)
+					   int *swappiness, nodemask_t *allowed)
 {
 	return 0;
 }
@@ -7806,9 +7807,9 @@ int user_proactive_reclaim(char *buf,
 			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
 					  MEMCG_RECLAIM_PROACTIVE;
 			reclaimed = try_to_free_mem_cgroup_pages(memcg,
-						 batch_size, gfp_mask,
-						 reclaim_options,
-						 swappiness == -1 ? NULL : &swappiness);
+					batch_size, gfp_mask, reclaim_options,
+					swappiness == -1 ? NULL : &swappiness,
+					NULL);
 		} else {
 			struct scan_control sc = {
 				.gfp_mask = current_gfp_context(gfp_mask),
-- 
2.47.3


