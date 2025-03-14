Return-Path: <cgroups+bounces-7075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD2A612BD
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C66462FF1
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706DB1FFC6F;
	Fri, 14 Mar 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LUCy1sFG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5xrte5QE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LUCy1sFG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5xrte5QE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0771FF7DC
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959213; cv=none; b=FaXhm8fU8XC6D00A2y5ABWks/QCPaHaTWWL52F6z884CvI3+0feNNQ15Y1cjt1Ml76FyOFTg9LodGaiGMNA/R4LkE63P1sEZv5OAGtixOWhF2+GEuPjgD3z5Rb7wSQoNG/ObHNkHvrR1wwpBBe+62VuGQrCvl6Ybo0mhvpNUYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959213; c=relaxed/simple;
	bh=Myw2aqfCb1wnnBIcHSup58dk2AoIQ7oNNYL7ps4wA+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii9WhkeChs1oKF3C928ZRdq0xf4xMr00DBwZQA0Edj5hWCmoJzJdF678lmlLsnSfKncHWMT5dD8OLkmSvcTvAbXkJoXuLpNkRcpS3kYWsDgHADwmhIw6kitwkyiyK9tFOkpoO0jtKkrXiH7O8dsPm5EkgssIqcY8IGt8XhZCPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LUCy1sFG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5xrte5QE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LUCy1sFG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5xrte5QE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5524A1F394;
	Fri, 14 Mar 2025 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741959209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WUzyeDy3uNNnz/1XAJKue/PI1Pk+9JL+BtFXHj2L2c=;
	b=LUCy1sFGRLyFxulnt3TGgq9+7KOC0zTFuedXr7RaDo0P1seMFvHd3OTDZklTGnS1xg/qv1
	OqsI2cicZh+xmHy6nuTnEmfVfFHBPW0qknKNEuEg92pRFTuIcaucQlSSsW2UzRs84T+pl/
	IJSa2eqGx2OUnlho8bXPY9kiH8iO5hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741959209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WUzyeDy3uNNnz/1XAJKue/PI1Pk+9JL+BtFXHj2L2c=;
	b=5xrte5QE6Y7oYgIDJpFARrhH/LtJ9aHTXSTAK38SA8RneUt4xuNNSCasrxvO6SULVshCsW
	SqkLTpADxf3n7+CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LUCy1sFG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5xrte5QE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741959209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WUzyeDy3uNNnz/1XAJKue/PI1Pk+9JL+BtFXHj2L2c=;
	b=LUCy1sFGRLyFxulnt3TGgq9+7KOC0zTFuedXr7RaDo0P1seMFvHd3OTDZklTGnS1xg/qv1
	OqsI2cicZh+xmHy6nuTnEmfVfFHBPW0qknKNEuEg92pRFTuIcaucQlSSsW2UzRs84T+pl/
	IJSa2eqGx2OUnlho8bXPY9kiH8iO5hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741959209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WUzyeDy3uNNnz/1XAJKue/PI1Pk+9JL+BtFXHj2L2c=;
	b=5xrte5QE6Y7oYgIDJpFARrhH/LtJ9aHTXSTAK38SA8RneUt4xuNNSCasrxvO6SULVshCsW
	SqkLTpADxf3n7+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A688132DD;
	Fri, 14 Mar 2025 13:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtfxDSkw1GfKIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 13:33:29 +0000
Message-ID: <6bd606f4-cfe9-4afb-b538-26feb56f9268@suse.cz>
Date: Fri, 14 Mar 2025 14:33:28 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] memcg: stock code cleanups
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5524A1F394
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 07:15, Shakeel Butt wrote:
> This is a cleanup series (first 7 patches) is trying to simplify the
> memcg stock code, particularly it tries to remove unnecessary
> dependencies. The last 3 patches are a prototype to make per-cpu memcg
> stock work without disabling irqs.
> 
> My plan is to send out the first 7 cleanup patches separately for the
> next release window and iterate more on the last 3 patches plus add
> functionality for multiple memcgs.
> 
> This series is based on next-20250313 plus two following patches:
> 
> Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> 
>  to simply the memcg stock code

Hi, 

I've been looking at this area too, and noticed a different opportunity for
cleanup+perf improvement yesterday. I rebased it on top of patch 7 as it
would make sense to do it before changing the locking - it reduces the
number of places where the local_trylock is taken. If it's ok to you, please
incorporate to your series.

Thanks,
Vlastimil

----8<----
From 8dda8e4225ee91b48a73759f727a28d448c634b5 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 13 Mar 2025 20:08:32 +0100
Subject: [PATCH] memcg: combine slab obj stock charging and accounting

When handing slab objects, we use obj_cgroup_[un]charge() for
(un)charging and mod_objcg_state() to account NR_SLAB_[UN]RECLAIMABLE_B.
All these operations use the percpu stock for performance. However with
the calls being separate, the stock_lock is taken twice in each case.

By refactoring the code, we can turn mod_objcg_state() into
__account_obj_stock() which is called on a stock that's already locked
and validated. On the charging side we can call this function from
consume_obj_stock() when it succeeds, and refill_obj_stock() in the
fallback. We just expand parameters of these functions as necessary.
The uncharge side from __memcg_slab_free_hook() is just the call to
refill_obj_stock().

Other callers of obj_cgroup_[un]charge() (i.e. not slab) simply pass the
extra parameters as NULL/zeroes to skip the __account_obj_stock()
operation.

In __memcg_slab_post_alloc_hook() we now charge each object separately,
but that's not a problem as we did call mod_objcg_state() for each
object separately, and most allocations are non-bulk anyway. This
could be improved by batching all operations until slab_pgdat(slab)
changes.

Some preliminary benchmarking with a kfree(kmalloc()) loop of 10M
iterations with/without __GFP_ACCOUNT:

Before the patch:
kmalloc/kfree !memcg:    581390144 cycles
kmalloc/kfree memcg:     783689984 cycles

After the patch:
kmalloc/kfree memcg:     658723808 cycles

More than half of the overhead of __GFP_ACCOUNT relative to
non-accounted case seems eliminated.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 77 +++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dfe9c2eb7816..553eb1d7250a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2753,25 +2753,17 @@ static void replace_stock_objcg(struct memcg_stock_pcp *stock,
 	WRITE_ONCE(stock->cached_objcg, objcg);
 }
 
-static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr)
+static void __account_obj_stock(struct obj_cgroup *objcg,
+				struct memcg_stock_pcp *stock, int nr,
+				struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 	int *bytes;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
-	stock = this_cpu_ptr(&memcg_stock);
-
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
-	 * accumulating over a page of vmstat data or when pgdat or idx
-	 * changes.
+	 * accumulating over a page of vmstat data or when pgdat changes.
 	 */
-	if (READ_ONCE(stock->cached_objcg) != objcg) {
-		replace_stock_objcg(stock, objcg);
-		stock->cached_pgdat = pgdat;
-	} else if (stock->cached_pgdat != pgdat) {
+	if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
@@ -2808,11 +2800,10 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	}
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
-
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
-static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
+			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -2824,6 +2815,9 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
+
+		if (pgdat)
+			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -2908,7 +2902,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 }
 
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
-			     bool allow_uncharge)
+		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
+		enum node_stat_item idx)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -2923,6 +2918,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 	stock->nr_bytes += nr_bytes;
 
+	if (pgdat)
+		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
+
 	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
 		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		stock->nr_bytes &= (PAGE_SIZE - 1);
@@ -2934,12 +2932,13 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
-int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
+				     struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	unsigned int nr_pages, nr_bytes;
 	int ret;
 
-	if (consume_obj_stock(objcg, size))
+	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
 		return 0;
 
 	/*
@@ -2972,15 +2971,21 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 		nr_pages += 1;
 
 	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
-	if (!ret && nr_bytes)
-		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, false);
+	if (!ret && (nr_bytes || pgdat))
+		refill_obj_stock(objcg, nr_bytes ? PAGE_SIZE - nr_bytes : 0,
+					 false, size, pgdat, idx);
 
 	return ret;
 }
 
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+{
+	return obj_cgroup_charge_account(objcg, gfp, size, NULL, 0);
+}
+
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size, true);
+	refill_obj_stock(objcg, size, true, 0, NULL, 0);
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -3032,23 +3037,32 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 	}
 
-	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
-		return false;
-
 	for (i = 0; i < size; i++) {
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, false)) {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
 			continue;
 		}
 
+		/*
+		 * if we fail and size is 1, memcg_alloc_abort_single() will
+		 * just free the object, which is ok as we have not assigned
+		 * objcg to its obj_ext yet
+		 *
+		 * for larger sizes, kmem_cache_free_bulk() will uncharge
+		 * any objects that were already charged and obj_ext assigned
+		 *
+		 * TODO: we could batch this until slab_pgdat(slab) changes
+		 * between iterations, with a more complicated undo
+		 */
+		if (obj_cgroup_charge_account(objcg, flags, obj_full_size(s),
+					slab_pgdat(slab), cache_vmstat_idx(s)))
+			return false;
+
 		off = obj_to_index(s, slab, p[i]);
 		obj_cgroup_get(objcg);
 		slab_obj_exts(slab)[off].objcg = objcg;
-		mod_objcg_state(objcg, slab_pgdat(slab),
-				cache_vmstat_idx(s), obj_full_size(s));
 	}
 
 	return true;
@@ -3057,6 +3071,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts)
 {
+	size_t obj_size = obj_full_size(s);
+
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
@@ -3067,9 +3083,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			continue;
 
 		obj_exts[off].objcg = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
-				-obj_full_size(s));
+		refill_obj_stock(objcg, obj_size, true, -obj_size,
+				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
 	}
 }
-- 
2.48.1



