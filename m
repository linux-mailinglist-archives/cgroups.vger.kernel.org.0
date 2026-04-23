Return-Path: <cgroups+bounces-15474-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIqMHsCD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15474-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:40:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F9457540
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60DA305DEF6
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06311346784;
	Thu, 23 Apr 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNuGMkjB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFA345CAE
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976495; cv=none; b=dlcYazta3G5863YDRDV4wAK2w9gtMNRHGARvuDAtra98Hq3UC7Qf55732B4bZQUbJ4iTUoL0mpcudYwy7iU+MbEInMHaW+ctUJkcqjh0c2iKaoWqNXEHWpR0nnVmAZxWmB29zCpCg5WNHVp+8LbYIgxSF5l47WsnRd/jp9bZAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976495; c=relaxed/simple;
	bh=RGcDFyHKvXsYqrb2hd4XjqR9VB7xFPHAEoJogUHFeqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpQgJUlV9oYWq1h3UsSsCiMWyMx5DmVKY01lYYGNvChQeTgZM1dnRGsCcdHpNxhtWYL+6hqsizHt847YBDMr79Cj57YxwMkwR5FpH3UduvPzFLe25BakHH0ZlJRNI5EGPHQtlqUNCSE2ni1Beaef8x33TW9l0SC5gWlTyzYVIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNuGMkjB; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-409de4132b5so4575357fac.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976493; x=1777581293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8h4sSDHY9wW/Z7IHaPKSopnSuqP+potJrVY6PtuZz8=;
        b=MNuGMkjBj6sMG6XngWzc1ISA2oO7PEJvSioDExUbIwDfygxRjrqkfHLswP/xNygNHr
         clyYzYAVfSqtQINgPSpP8+XJD98PQFallfZgYdHqqgI1Qq3O8w34XodhijpwLbftsD2L
         nFGtVAdVcgiEqBGUDHZdVmEQa1bBaRywNxqFSUoqgi0JoVMICc3v8iz84Tndt0x2X5xM
         VkrT7eJO6hlORhUM6JJqglgKyCb6yvDQqELtcuAcrjelTqKuLEMVNtgXU+t6NlEB9gPP
         lGUJmZv5mljmjx4UK+/Lp8zRaTFY0cc8NvOKnzgWMlBHiyP2pc+jyqLZbMVi5vOsBqYk
         XRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976493; x=1777581293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8h4sSDHY9wW/Z7IHaPKSopnSuqP+potJrVY6PtuZz8=;
        b=E+MndGW7XcnHPMX5+PhfHe+D+WiLoRQ9HOSro/FCtjCYAE36ntqh7Hq7OMZQsQk5M+
         4VwE4qD1bLxWXSZJX8pcoFFaGX9uO67lThbY4N7I29xf5cUzH1V9eGwgSgwuuFjJOVlf
         3BK6CVU4vZZfC2dPqGMSkHszCpXX5FuV7uCTUaycg2RzAknqXf4gNqVYTyzLmEQx+XmL
         zEYouYCentOpZRk1WllTzxrcUoScmh/QVBaB2evf2SQ7qA2cNgD2dQ2aFeWzyWcOZ8W+
         AmlgU3LBiD8GoV5TAq97WgntQIpauZiQJ0t0PRRGWL210nV2THn1cZZRutEE6EoSxXAC
         8szg==
X-Forwarded-Encrypted: i=1; AFNElJ+90j8AB6Zor7OWDTWi67RfInVhRn4m8/lVpJKFKnF1wmmV9O/UgpbY2uWgxdtuYB472xQ5PaMD@vger.kernel.org
X-Gm-Message-State: AOJu0YyberzhAkjCFGlnCtLH2w0Dnkp0639JAmdYhVnzKI1qMxt35b+r
	NxbNa8guwccMETczLyleirbxKrqxxMC3DFT4phJdydIjkdRBTlRr+JdS
X-Gm-Gg: AeBDietINUmLwhtcSMtN4jbNxlDprRu1hxbKb+/8ePWyaew2PbwX81ogLo3v5IDviOc
	vYsJObAzIzGPicAncLo21ueWp28gFQLEll/4y7VfVhdwzoe0dbxQt138h9Q+OMwMj2MebsAI+D6
	oTmmlgy/ZHCUSyG3QNxSRkAWMFWlyFZp/0Kely2k7aV4iy5f1Ln1ZxOajzXqeexr6mNmkFVyG4u
	sA8ynZsUw6xkIwJBN5asXdnkT4I8FkqGNFUsL8cs7sFwyMyCcSxUT+VlVZ5y5xuf02e6sw+QjGv
	+C4ZDrOdMHFb9Fk2n4B/UbKxU7qsN1TsXlie3RgxuUDi1F4AmSUhwSAn1geh2sNSk2Bdr382vWC
	nCjwulmXia4iz+kog6roQe83Drq0+t3jr8csanoNuKTBd/HsHbJObMRIi9766c188gggtSyU+wC
	uQ9ZLUir6qrsE6vIRrDTWNnc7goTSjuvUg
X-Received: by 2002:a05:6870:89aa:b0:42f:c146:da68 with SMTP id 586e51a60fabf-42fc146e30amr6196515fac.16.1776976492846;
        Thu, 23 Apr 2026 13:34:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fbe8a0bcbsm6038078fac.2.2026.04.23.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:52 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 4/9 v2] mm/memcontrol: charge/uncharge toptier memory to mem_cgroup
Date: Thu, 23 Apr 2026 13:34:38 -0700
Message-ID: <20260423203445.2914963-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15474-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D08F9457540
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Memory cgroup limits currently offer a way to isolate memory as a
resource, but treats the cost/value of all memory to be equal,
regardless of whether it is present in a toptier node or not.

To better capture the asymmetric utility of toptier memory from
"lowtier" memory, account toptier memory usage in parallel to existing
memory accounting mechanisms. To do this, introduce a new page_counter
"toptier" to mem_cgroup.

From a simplified perspective, we can achieve this by checking the
physical location of folios when the memory page_counter is updated, and
decide whether to also account to toptier. Add a new "toptier" parameter
to try_charge_memcg(), which callers must determine.

However, as of this RFC, this simplified model only works on LRU folios
(callers of try_charge_memcg() from charge_memcg()). The other two
sites, obj_cgroup_charge_pages() and mem_cgroup_sk_charge(), will be
addressed in future patches that transition enum memcg_stat_item to
a per-lruvec counter (enum memcg_stat_item).

Enforcement mechanisms are not present at this point. Failing the
toptier limit check leads to nothing, but the charges are accumulated.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 63 ++++++++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index be45641e890e4..0cdb6cd1955dc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -206,6 +206,7 @@ struct mem_cgroup {
 
 	/* Accounted resources */
 	struct page_counter memory;		/* Both v1 & v2 */
+	struct page_counter toptier;		/* v2 only */
 
 	union {
 		struct page_counter swap;	/* v2 only */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f7bedb55dbb1..d891cf77cf6d6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -53,6 +53,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmpressure.h>
 #include <linux/memremap.h>
+#include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpu.h>
@@ -2096,6 +2097,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
 	for_each_mem_cgroup(memcg) {
 		page_counter_drain_cpu(&memcg->memory, cpu);
+		page_counter_drain_cpu(&memcg->toptier, cpu);
 		page_counter_drain_cpu(&memcg->memsw, cpu);
 	}
 
@@ -2370,7 +2372,7 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 }
 
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
-			    unsigned int nr_pages)
+			    unsigned int nr_pages, bool toptier)
 {
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
@@ -2382,9 +2384,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	bool toptier_charged;
 
 retry:
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	toptier_charged = false;
 
 	if (do_memsw_account() &&
 	    !page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
@@ -2393,11 +2397,18 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto reclaim;
 	}
 
+	if (toptier &&
+	    page_counter_try_charge(&memcg->toptier, nr_pages, &counter))
+		toptier_charged = true;
+
 	if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
 		goto done_restock;
 
+	if (toptier_charged)
+		page_counter_uncharge(&memcg->toptier, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
+
 	mem_over_limit = mem_cgroup_from_counter(counter, memory);
 
 reclaim:
@@ -2490,6 +2501,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * being freed very soon.  Allow memory usage go over the limit
 	 * temporarily by force charging it.
 	 */
+	if (toptier)
+		page_counter_charge(&memcg->toptier, nr_pages);
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
@@ -2559,7 +2572,7 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	return try_charge_memcg(memcg, gfp_mask, nr_pages);
+	return try_charge_memcg(memcg, gfp_mask, nr_pages, false);
 }
 
 static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
@@ -2859,7 +2872,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	ret = try_charge_memcg(memcg, gfp, nr_pages);
+	ret = try_charge_memcg(memcg, gfp, nr_pages, false);
 	if (ret)
 		goto out;
 
@@ -2888,6 +2901,11 @@ static void page_set_objcg(struct page *page, const struct obj_cgroup *objcg)
 	page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
 }
 
+static bool should_charge_toptier(struct folio *folio)
+{
+	return mem_cgroup_tiered_limits() && node_is_toptier(folio_nid(folio));
+}
+
 /**
  * __memcg_kmem_charge_page: charge a kmem page to the current memory cgroup
  * @page: page to charge
@@ -3760,6 +3778,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->toptier);
 	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
@@ -3866,6 +3885,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
+		page_counter_init(&memcg->toptier, &parent->toptier, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
 		memcg->memory.track_failcnt = !memcg_on_dfl;
@@ -3877,6 +3897,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		init_memcg_stats();
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL, true);
+		page_counter_init(&memcg->toptier, NULL, true);
 		page_counter_init(&memcg->swap, NULL, false);
 #ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL, false);
@@ -3936,6 +3957,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	/* failure is nonfatal, charges fall back to direct hierarchy */
 	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	page_counter_enable_stock(&memcg->toptier, MEMCG_CHARGE_BATCH);
 	if (do_memsw_account())
 		page_counter_enable_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
 
@@ -4013,6 +4035,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 	page_counter_disable_stock(&memcg->memory);
+	page_counter_disable_stock(&memcg->toptier);
 	page_counter_disable_stock(&memcg->memsw);
 
 	mem_cgroup_private_id_put(memcg, 1);
@@ -4825,7 +4848,8 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	objcg = get_obj_cgroup_from_memcg(memcg);
 	/* Do not account at the root objcg level. */
 	if (!obj_cgroup_is_root(objcg))
-		ret = try_charge_memcg(memcg, gfp, folio_nr_pages(folio));
+		ret = try_charge_memcg(memcg, gfp, folio_nr_pages(folio),
+				       should_charge_toptier(folio));
 	if (ret) {
 		obj_cgroup_put(objcg);
 		return ret;
@@ -4922,6 +4946,7 @@ struct uncharge_gather {
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
+	unsigned long nr_toptier;
 	int nid;
 };
 
@@ -4942,6 +4967,8 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 			mod_memcg_state(memcg, MEMCG_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(memcg, -ug->nr_kmem);
 		}
+		if (ug->nr_toptier)
+			page_counter_uncharge(&memcg->toptier, ug->nr_toptier);
 		memcg1_oom_recover(memcg);
 	}
 
@@ -4987,8 +5014,11 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 		ug->nr_kmem += nr_pages;
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!obj_cgroup_is_root(objcg))
+		if (!obj_cgroup_is_root(objcg)) {
 			ug->nr_memory += nr_pages;
+			if (should_charge_toptier(folio))
+				ug->nr_toptier += nr_pages;
+		}
 		ug->pgpgout++;
 
 		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
@@ -5063,6 +5093,10 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
+
+		/* old folio's toptier usage will be uncharged on free */
+		if (should_charge_toptier(new))
+			page_counter_charge(&memcg->toptier, nr_pages);
 	}
 
 	obj_cgroup_get(objcg);
@@ -5105,6 +5139,23 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (!objcg)
 		return;
 
+	if (!obj_cgroup_is_root(objcg)) {
+		struct mem_cgroup *memcg;
+		unsigned long nr_pages = folio_nr_pages(old);
+		bool old_toptier, new_toptier;
+
+		rcu_read_lock();
+		memcg = obj_cgroup_memcg(objcg);
+		old_toptier = should_charge_toptier(old);
+		new_toptier = should_charge_toptier(new);
+
+		if (old_toptier && !new_toptier)
+			page_counter_uncharge(&memcg->toptier, nr_pages);
+		else if (!old_toptier && new_toptier)
+			page_counter_charge(&memcg->toptier, nr_pages);
+		rcu_read_unlock();
+	}
+
 	/* Transfer the charge and the objcg ref */
 	commit_charge(new, objcg);
 
@@ -5180,7 +5231,7 @@ bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);
 
-	if (try_charge_memcg(memcg, gfp_mask, nr_pages) == 0) {
+	if (try_charge_memcg(memcg, gfp_mask, nr_pages, false) == 0) {
 		mod_memcg_state(memcg, MEMCG_SOCK, nr_pages);
 		return true;
 	}
-- 
2.52.0


