Return-Path: <cgroups+bounces-16674-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOl9GrbvImrPfQEAu9opvQ
	(envelope-from <cgroups+bounces-16674-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0659C649749
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z6OrchWC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16674-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16674-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2B02308F604
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4974C6EF4;
	Fri,  5 Jun 2026 15:36:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EF3B6366
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673779; cv=none; b=kdZ3ptSo22ESgFi5odseCTJ+UusUqGUyZsOCyqQw+2G9Fuz4iXYekZGdWPjeHAJxEoHE+BiOPDbCULy89qSTObzqg7IoEJYZZkUytOs0JLEukKaXItD/aW1OGRLNgetBeZ/55KIibqdeMeIUHrRXl7DLmDiaM0clJF52PAudGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673779; c=relaxed/simple;
	bh=AlnunryOiTLhLF6/0+wT6IlypoE163q0qespXBG7MNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMap9LclSW8pFaaB0kMAQw1gazkRnT8WllN3osNk1is+ATu0FJXaSvs+qu2FsOWgX/gGacCv21xXMMSXnARnZKbAktPRCmXQdyEuIm7ElulHuLgwbhsnc4AkjT1gAw8WEZtgWOKXmwtykhg/Nl5LWvkQYZyrzszO+H7AWS0EZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6OrchWC; arc=none smtp.client-ip=209.85.161.48
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d8f70cb0cso1427446eaf.0
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673772; x=1781278572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDYBxVf6/SnI4wuLSeXSHzzLh62y/xO5UdAB8iPGGOc=;
        b=Z6OrchWCG+nUnXECqeCzx2tNEDY2e26Ji8n6N2Cd6cilFZLfqm/+vOcOBUgYWz+u3w
         VRe7lyILe/8YpAEJvOYAs3GoYFWTawNUejjQVoIFjM1YnhGPbtEFksUkhyDdtJJFO983
         jyVyM+Vhpz/Ycb6OAfkRtbjE4npJsoAheGyVkPbNTUNe1TbI34X9eTBqs/kj8RoYEjhW
         X/ygXvp77lTV7a+c4yiIN4+EuAlf+3NNByjCJfN3H0JOyapnkPthMxkvlUnwqt2IHeGn
         z9m5xHPginnGnJ/j0Sg3vxUJTd9WQvdXPgfLi5SZI45oaTAC2kUmDAbaCuQpzpxx1ceA
         8JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673772; x=1781278572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDYBxVf6/SnI4wuLSeXSHzzLh62y/xO5UdAB8iPGGOc=;
        b=jjbUmX4rVrJvQ/YJaAEJv4cdknSoJmPqaYL6BqOav72vV+VMUL0+r0BW6oolWpjqjS
         QxoWv3q0aqVVbNp1STUnh3Yc9US2TRvrsKq+/VDaenRfFTmqlCB0cuSDvshzaMWt+fgg
         A6XWfV32XaJIeFLS1YExfGpi+ZMhcic+Phr09n5jOG1ZZYyUTzY6/I/6im1uVCtNZEQQ
         W7GmQe6zjXx3tjWdbcwGDkxKKOrfB2hcALBijYGTKqcuA5KD/XKeBLVEqcNX3lsyOo9V
         6RbLErGfgKL9LKlQjc2tarRNp7s4MHFLdaM5ogRUQBp8EmkQlYBzL58yPZYfWH/QKrPL
         kEng==
X-Forwarded-Encrypted: i=1; AFNElJ+morxlwUMMqdLmT6UzZoH03LYk646duEollyfrJQS1lIDa6XpP+a6KJ8V9BaFH/mPMljhkHQWF@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjitdhQAKW80N1rMl5GQx3T05f56zzEamYSwCoFvMuFWUFcxi
	/hXQFUO7cAPTn0FWsu0Cu41RbZAHsi1cILGhoRZaBhvGyoMPLsyOkR6Z
X-Gm-Gg: Acq92OE1IWDv9xqFUpNmvxL6NLL3b5Ymo6mZ3jV1tvnw0/AUOEXiZDGXKHt0pMi+MAM
	W/JWH5gPz7HPPJuZrt4dUyYxSnAo46VUhofFyjIbmwzgwl/W7HJeScDzGTAClnivZ2osM1oe2Dk
	JmYjev4FnhRxDYn3AfUnxPWWHoQYC3v+TRI6VkA51mfRVhzQ9h27LjyMPdymqs3WZe0i2cj5jJJ
	YqKBFejJL6toLsKpJhpttHrb26zZbEMFgbDSTW5qsaFfgNoIe35cqHdLED3C05be8LXgeNpxFB7
	4N+/nYPZbFbXUTeM0MapBIQKKuTMmM5S3MNmmN382HWaH5LZo+kTkLtj0lbx7Cq0I4LgTwZ5Fas
	R6J13NfR7mCRB/zC/myXcjuBgh20Nb/f9EHCnBZnJHqwdGP7ZlYQUg9w9gfn+w6J4TPOO2qhiBK
	raEh426V1VbZGb8dw3iBQrXZpuR1+R0zi/gsxvyFjNdRAY5pFU/sNZd/RBoa3K+Nzc
X-Received: by 2002:a05:6820:2d0b:b0:69e:71c8:193f with SMTP id 006d021491bc7-69e71c81e2dmr1257008eaf.8.1780673772254;
        Fri, 05 Jun 2026 08:36:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8500f0esm7271409fac.18.2026.06.05.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/6 v3] mm/memcontrol: remove unused memcg_stock code
Date: Fri,  5 Jun 2026 08:36:02 -0700
Message-ID: <20260605153603.234296-7-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16674-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0659C649749

Now that all memcg_stock logic has been moved to page_counter_stock, we
can remove all code related to handling memcg_stock. Note that obj_stock
is untouched and is still needed. FLUSHING_CACHED_CHARGE is preserved
so that it can be used by obj_stock as well.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 186 ------------------------------------------------
 1 file changed, 186 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d0da2f842e2d4..3e3f8fbd19a48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1998,25 +1998,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 	pr_cont(" are going to be killed due to memory.oom.group set\n");
 }
 
-/*
- * The value of NR_MEMCG_STOCK is selected to keep the cached memcgs and their
- * nr_pages in a single cacheline. This may change in future.
- */
-#define NR_MEMCG_STOCK 7
 #define FLUSHING_CACHED_CHARGE	0
-struct memcg_stock_pcp {
-	local_trylock_t lock;
-	uint8_t nr_pages[NR_MEMCG_STOCK];
-	struct mem_cgroup *cached[NR_MEMCG_STOCK];
-
-	struct work_struct work;
-	unsigned long flags;
-	uint8_t drain_idx;
-};
-
-static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.lock = INIT_LOCAL_TRYLOCK(lock),
-};
 
 /*
  * NR_OBJ_STOCK is sized so the entire hot path of obj_stock_pcp
@@ -2065,47 +2047,6 @@ static void drain_obj_stock(struct obj_stock_pcp *stock);
 static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
-/**
- * consume_stock: Try to consume stocked charge on this cpu.
- * @memcg: memcg to consume from.
- * @nr_pages: how many pages to charge.
- *
- * Consume the cached charge if enough nr_pages are present otherwise return
- * failure. Also return failure for charge request larger than
- * MEMCG_CHARGE_BATCH or if the local lock is already taken.
- *
- * returns true if successful, false otherwise.
- */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	struct memcg_stock_pcp *stock;
-	uint8_t stock_pages;
-	bool ret = false;
-	int i;
-
-	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock(&memcg_stock.lock))
-		return ret;
-
-	stock = this_cpu_ptr(&memcg_stock);
-
-	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
-		if (memcg != READ_ONCE(stock->cached[i]))
-			continue;
-
-		stock_pages = READ_ONCE(stock->nr_pages[i]);
-		if (stock_pages >= nr_pages) {
-			WRITE_ONCE(stock->nr_pages[i], stock_pages - nr_pages);
-			ret = true;
-		}
-		break;
-	}
-
-	local_unlock(&memcg_stock.lock);
-
-	return ret;
-}
-
 static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	page_counter_uncharge(&memcg->memory, nr_pages);
@@ -2113,51 +2054,6 @@ static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
 
-/*
- * Returns stocks cached in percpu and reset cached information.
- */
-static void drain_stock(struct memcg_stock_pcp *stock, int i)
-{
-	struct mem_cgroup *old = READ_ONCE(stock->cached[i]);
-	uint8_t stock_pages;
-
-	if (!old)
-		return;
-
-	stock_pages = READ_ONCE(stock->nr_pages[i]);
-	if (stock_pages) {
-		memcg_uncharge(old, stock_pages);
-		WRITE_ONCE(stock->nr_pages[i], 0);
-	}
-
-	css_put(&old->css);
-	WRITE_ONCE(stock->cached[i], NULL);
-}
-
-static void drain_stock_fully(struct memcg_stock_pcp *stock)
-{
-	int i;
-
-	for (i = 0; i < NR_MEMCG_STOCK; ++i)
-		drain_stock(stock, i);
-}
-
-static void drain_local_memcg_stock(struct work_struct *dummy)
-{
-	struct memcg_stock_pcp *stock;
-
-	if (WARN_ONCE(!in_task(), "drain in non-task context"))
-		return;
-
-	local_lock(&memcg_stock.lock);
-
-	stock = this_cpu_ptr(&memcg_stock);
-	drain_stock_fully(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
-
-	local_unlock(&memcg_stock.lock);
-}
-
 static void drain_local_obj_stock(struct work_struct *dummy)
 {
 	struct obj_stock_pcp *stock;
@@ -2174,88 +2070,6 @@ static void drain_local_obj_stock(struct work_struct *dummy)
 	local_unlock(&obj_stock.lock);
 }
 
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *cached;
-	uint8_t stock_pages;
-	bool success = false;
-	int empty_slot = -1;
-	int i;
-
-	/*
-	 * For now limit MEMCG_CHARGE_BATCH to 127 and less. In future if we
-	 * decide to increase it more than 127 then we will need more careful
-	 * handling of nr_pages[] in struct memcg_stock_pcp.
-	 */
-	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S8_MAX);
-
-	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
-
-	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock(&memcg_stock.lock)) {
-		/*
-		 * In case of larger than batch refill or unlikely failure to
-		 * lock the percpu memcg_stock.lock, uncharge memcg directly.
-		 */
-		memcg_uncharge(memcg, nr_pages);
-		return;
-	}
-
-	stock = this_cpu_ptr(&memcg_stock);
-	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
-		cached = READ_ONCE(stock->cached[i]);
-		if (!cached && empty_slot == -1)
-			empty_slot = i;
-		if (memcg == READ_ONCE(stock->cached[i])) {
-			stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
-			WRITE_ONCE(stock->nr_pages[i], stock_pages);
-			if (stock_pages > MEMCG_CHARGE_BATCH)
-				drain_stock(stock, i);
-			success = true;
-			break;
-		}
-	}
-
-	if (!success) {
-		i = empty_slot;
-		if (i == -1) {
-			i = stock->drain_idx++;
-			if (stock->drain_idx == NR_MEMCG_STOCK)
-				stock->drain_idx = 0;
-			drain_stock(stock, i);
-		}
-		css_get(&memcg->css);
-		WRITE_ONCE(stock->cached[i], memcg);
-		WRITE_ONCE(stock->nr_pages[i], nr_pages);
-	}
-
-	local_unlock(&memcg_stock.lock);
-}
-
-static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
-				  struct mem_cgroup *root_memcg)
-{
-	struct mem_cgroup *memcg;
-	bool flush = false;
-	int i;
-
-	rcu_read_lock();
-	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
-		memcg = READ_ONCE(stock->cached[i]);
-		if (!memcg)
-			continue;
-
-		if (READ_ONCE(stock->nr_pages[i]) &&
-		    mem_cgroup_is_descendant(memcg, root_memcg)) {
-			flush = true;
-			break;
-		}
-	}
-	rcu_read_unlock();
-	return flush;
-}
-
 static void schedule_drain_work(int cpu, struct work_struct *work)
 {
 	/*
-- 
2.53.0-Meta


