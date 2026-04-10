Return-Path: <cgroups+bounces-15217-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCk4Igdo2Wn5pQgAu9opvQ
	(envelope-from <cgroups+bounces-15217-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:13:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D32053DCC62
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A028E3098E3B
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6C3A963C;
	Fri, 10 Apr 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktEoy/Jo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28C37CD56
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855282; cv=none; b=gyaZurVtlFfZANVIuTJmvoq/VMzXY3CBWrCdQ81NQtsRPHhSqwXruqAKNdqQw/Osw0fBRcl2XXKRE9//LTJJBnxo1K8iZcUFO6Y5VIFVI6pq6FHo/0ZoDM/Hha9b/jQIy86BG4BKYuFHp8iudA1w83vpmhplRvu5LiaL8RJLFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855282; c=relaxed/simple;
	bh=uHZSosdPaz/5klkEV1FY2gO/CN0MqSO80Sx627Bwhzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpQtmAYRVW2fr3GGFa95uvDfoCyKPcbtFTnsHGaL2SpPLMDnSXyTQu5RwNszbPkJ3bjP5oJ2fC4lkL/fIc/mlY2rwu9YfQRxT2N2ZeMnPctBg1vKEp7bXa8GUk9uNYT7lKq+00jojTr+qZ3t4ts067qCzdiOxogO49nQrx1IXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktEoy/Jo; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-68207984e66so1366714eaf.2
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855277; x=1776460077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esfCictnJyPc20j2EkkTX38W+qKv+nRwhZtLvjA9q1E=;
        b=ktEoy/JoxcModDbVQ1E7R0xZgF68ITdXuS5+HH4cx1Vq6XzHFDvddqAWjdNlyWbLpt
         1lbqm53Jgkr9hAyBnyi6QWpWvoZJf3rmRA0h+v4VnpS/g382fAFrcPcJdWNUad21hrCd
         zrsPiHDPR8srWv45oVRT4BjN7UfIZqMB3w35vtbTjaRP35TIx1lS404/KlfJxXmaDZ8E
         nST5ajUM34sDgC1KEiBdiIUup6zrh9pBx+fhb/aBKDUm8NyKVtieO0IuBlbQbVfuzF0X
         pHahyvPb5LlwulG74g10ca8kUuo1rNLwHRvHT8OdjYxjPg7iTTwPnEfROtEIsCS9PWtL
         wt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855277; x=1776460077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esfCictnJyPc20j2EkkTX38W+qKv+nRwhZtLvjA9q1E=;
        b=erXnfNzD3IuTDyB+10WwtK6YG7jvFMwZJXrp4IeO2vVHwOeTeE0FtulWoZDuAAlEMX
         LrUb3ecLlXn2sxriFsCzR19A2AP/1tK58fNLkr9F8aeUbd7GK8Wc/ayk4TZbYU6SjO+h
         FlP/5pPJCX0tqmoO431nx4hwnF6lzeyhaUczzhoL9c6WsmZwlNp+fAkLvh5NldTao36n
         n50YaDA96MfRHCj6f+6c5CG3eI5pHerwz3ZSwmiJmEyNXD8H7rmY1l+w5goqOvSyYsb9
         P8QKQqwrHqpuiXyaXCrRF2cwD+G+S72Q/9/WOfb04F3aLjuydWVwmrrTJdf+rPpo4Qkz
         MWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7CoUIsCLAReECLJg5K1JHKjV8APlqLy9fvCxHfm/5KWicOqutXnNF5zYloFCo59h1nIsaLLQS@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpRqu5hk+0tp3uoXuZyyeWT4JefvGdPBYdyoq33RHsVQm4hlJ
	Y3A3oeUVjQDakaQwq1CxaI0UOdZQBz1EIoxKJXevNIAZJK7lNreLI+le
X-Gm-Gg: AeBDieuzGNNtDoDo3oW58RVWuZQBoDavtzvomBYau7hJW9fKsjsuO6w5K2B7Fn3jUub
	L3TMHb6cZVo70h954013IXKAAHP2pzJ8UCoG0T0JOm9r/zVgRXCWdk+VAg4UMMqERLJRUn9I8t1
	ZWAz554JYNzZGvD1rIu3CZJ6O9cj4KkbY6ZtOcnUlTQb92gUQG/vivLhsCncERpFMjNsYyDUzRC
	TV5oayS15MQFZPLV9kbfhWULXFCDWz3cYnUjm6/OcXt+LrULlyJ80ICyT5ikV2IhiNHmq4+pND/
	baDAZTHogr/eEUDwlcXrgGUnRV/pZQQdNvtD/JdZVyEFzU61T7lPl1Y7gtCalQAb9XiI7EshmUz
	wiiwnCBzgTT9ISlnhTqH9Wpt4y+W1alGKteWOkt20s8tHxuN07p7gkRLr45ooP93l/ZX1e4Ijw8
	FdLnH4BMrCnJyHlayl19fB5753E3fUIyMr
X-Received: by 2002:a05:6820:1389:b0:67d:f88f:d853 with SMTP id 006d021491bc7-68be5c5dd0amr2359578eaf.6.1775855276856;
        Fri, 10 Apr 2026 14:07:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dcf9726fsm3229555fac.0.2026.04.10.14.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:56 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 8/8 RFC] mm/memcontrol: remove unused memcg_stock code
Date: Fri, 10 Apr 2026 14:07:02 -0700
Message-ID: <20260410210742.550489-9-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15217-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email,oom.group:url]
X-Rspamd-Queue-Id: D32053DCC62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all memcg_stock logic has been moved to page_counter_stock, we
can remove all code related to handling memcg_stock. Note that obj_stock
is untouched and is still needed. FLUSHING_CACHED_CHARGE is preserved
so that it can be used by obj_stock as well.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 183 ------------------------------------------------
 1 file changed, 183 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4be1638dde180..7de23ecd7cef6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1989,24 +1989,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
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
-};
-
-static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.lock = INIT_LOCAL_TRYLOCK(lock),
-};
 
 struct obj_stock_pcp {
 	local_trylock_t lock;
@@ -2030,47 +2013,6 @@ static void drain_obj_stock(struct obj_stock_pcp *stock);
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
@@ -2078,51 +2020,6 @@ static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
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
@@ -2139,86 +2036,6 @@ static void drain_local_obj_stock(struct work_struct *dummy)
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
-			i = get_random_u32_below(NR_MEMCG_STOCK);
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
2.52.0


