Return-Path: <cgroups+bounces-16261-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aACxDtCmFGrJPAcAu9opvQ
	(envelope-from <cgroups+bounces-16261-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:45:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8655CE15C
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8AA23019BA8
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352CE267AF2;
	Mon, 25 May 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqr1IGYU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602438F642
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738314; cv=none; b=tPhPXnC3Lk8lQoWuK6+jEYvs/9rYVgVjwl/GjJ1tyXWWfpTx10+YGl3KZwUDqkM7c39vGiBJpnBFisN0PrII3ey0uY3SGaOq+YHW99xq+qIGYQXJnH4fKv7413FjgH+1tQ1L0cY7YNvpN/zBagc/GCiVzkUprLnrIlJMcmRPjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738314; c=relaxed/simple;
	bh=xv6T5BEkwMeGjBCVISmV8hw0Z/AiiI0bphExI4eQRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9h96djlheV8uuTE24uYFVJbKiw0e+gF+9RSxbPOKNXKzm/+NI2tzQJ4vT2vZ+BNvXHZyxoS9zo4+/qaoNrG2ansjOwTMb3c19vmkJLLQprtZtZYAjkjFJBY4amAiW1vX9eQXCU2QbEOIHepmG0Z0+siKQ+sogz4+l2hmS3lXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqr1IGYU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e61da76fd9so1602890a34.0
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738310; x=1780343110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zykbN+jGNP67mLi0kvuPWW1N+NMv5CejXUxzHJ+T28=;
        b=Fqr1IGYU8mFur9sBE2KoNDc+I/HrcC6jdcYNIU/Weiv835iK4rHEk/T3F6boqfsXeQ
         Q46ErWgF0/9dN5wOe9zaLmg+nrFEW3iFdWpvcbybDbASul1I0T7hxXmVNzk7j2RpFgEY
         9FFNAZPdXLd40xIu9YklmOUqQcwV2NpKkqwVc0nmP3rx+pOTnwTGiD+UJOMBB4jo0U8a
         +3DlYBsIe+u7vDHqNTOoSO5kwTPNglWBEtvQ38aOmcVy6GIq+NTDgNoRhG/dKB6oaIfF
         kqq7+7NUgo0YVZmJqf7lZdtz0kMwQz3/TBidMS0NX9sXkaGJCWZsBa5PxlRZryHFGBpW
         +S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738310; x=1780343110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zykbN+jGNP67mLi0kvuPWW1N+NMv5CejXUxzHJ+T28=;
        b=J4JUr7T/RrC1erF5+cyRT8yfSut/DZ/yBeUyjX33f22dQLWmYzkjfErII1KbZYYYTE
         iKAcM0/bGwXhm2kSOXdHkq+ISxU55iAPrtiYbC5krBi8Ecmxa0MfBJfbcCDhWyOImBjn
         9dwRKWigj04KntSErVTxnnvywO3HuJ7dSdSdiayRRS1Yx84db0g/BUlu3iWF4PmNjNcE
         plCj5d/Hd27E2SlTfdYpQt0atw/Qi2dnUfncVu21Ns8YL5z/QN3WYpzGAl8vXDGVeowP
         ZmhMoAnQCKNcxiA7Xwc5IYS5mzdCtH7Jz8B4nrRI9Ounis2+Un2sSQlSGNhbgNxznAHd
         iAKw==
X-Forwarded-Encrypted: i=1; AFNElJ8z0Shvxk37qifXeql8S1dAhLeVJm9Q/sLr6H0D7lFuyzIv2eF860bwgU0FnOzQOUm2M8wRkcFe@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRNOnUp+6RP/HHQEHMhondVW2pEzAKP+R0Qhn8d9sCl9m+ukm
	89+6fzE4KhEz/o8E9zQe/kvclxlj5CwEKzsHeSiKSVBPwWMhqBFk2xZ2
X-Gm-Gg: Acq92OFx02ciBrlje5h5+kiPp+AZv2F0t7UjtGtUXbU7LC02hLwuOQy26KGOwyJi+T1
	xflaUshhEs955c4iWXkccZmMkk/jVyJHnbvCXNgo89iyKN/jh+SgR69gE2rPUG+aE4i14r+wp56
	57NzsH1vu7YHTdo9FKwYaUyC8vrw6A1V8TA4b80hqR3WPyc/8vB39KSWZ0vs5CNyDsNpRtMoqGW
	M9uOs06CPJCQmtvUfR40xh3/iT6Kph3t3lM3svZnRdAOORbTZMDN06ZCSiQloB1k8uvpbA9VQYY
	U+jh7KQ8E6lX9fynq1/jjC78NxcvzvZJa+Er61yXaTlBNuPbPDc33x34my0/dG6aVdCTfyG8xpE
	wRGI/C3JuEYJow/b2PXRO+nFnw8w221a9U5dtN/1hssYS2z+d2e2sE1UXhQ2prt5NyUaeo09/E9
	1uJ2OiWCqxzqmJTUGNtVg5xXRExlbkaL3Ga2uI8tRpFuoDXkp6mbDHqYm22mIvY4EM
X-Received: by 2002:a05:6820:1992:b0:67e:eb4:238f with SMTP id 006d021491bc7-69d7eb9b166mr9236509eaf.18.1779738310511;
        Mon, 25 May 2026 12:45:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83700d55sm5369544eaf.4.2026.05.25.12.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:45:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/7 v3] mm/page_counter: introduce per-page_counter stock
Date: Mon, 25 May 2026 12:45:04 -0700
Message-ID: <20260525194506.3414995-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-2-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16261-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.789];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:email]
X-Rspamd-Queue-Id: 8C8655CE15C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 12:04:48 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> In order to avoid expensive hierarchy walks on every memcg charge and
> limit check, memcontrol uses per-cpu stocks (memcg_stock_pcp) to cache
> pre-charged pages and introduce a fast path to try_charge_memcg.
> 
> However, there are a few quirks with the current implementation that
> could be improved upon.
> 
> First, each memcg_stock_pcp can only cache the charges of 7 memcgs
> (defined as NR_MEMCG_STOCK), which means that once a CPU starts handling
> the charging of more than 7 memcgs, it randomly selects a victim memcg
> to evict and drain from the cpu, which can cause unnecessarily increased
> latencies and thrashing as memcgs continually evict each others' stock.
> 
> Second, stock is tightly coupled with memcg, which means that all page
> counters in a memcg share the same resource. This may simplify some of
> the charging logic, but it prevents new page counters from being added
> and using a separate stock.
> 
> We can address these concerns by pushing the concept of stock down to
> the page_counter level, which addresses the random eviction problem by
> getting rid of the 7 slot limit, and makes enabling separate stock
> caches for other page_counters simpler.
> 
> Introduce a generic per-cpu stock directly in struct page_counter.
> Stock can optionally be enabled per-page_counter, limiting the overhead
> increase for page_counters who do not benefit greatly from caching
> charges.
> 
> This patch introduces the page_counter_stock struct and its
> enable/disable/free functions, but does not use these yet.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/linux/page_counter.h | 13 ++++++++
>  mm/page_counter.c            | 64 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index d649b6bbbc871..c7e3ab3356d20 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -5,8 +5,15 @@
>  #include <linux/atomic.h>
>  #include <linux/cache.h>
>  #include <linux/limits.h>
> +#include <linux/local_lock.h>
> +#include <linux/percpu.h>
>  #include <asm/page.h>
>  
> +struct page_counter_stock {
> +	local_trylock_t lock;
> +	unsigned long nr_pages;
> +};
> +
>  struct page_counter {
>  	/*
>  	 * Make sure 'usage' does not share cacheline with any other field in
> @@ -41,6 +48,8 @@ struct page_counter {
>  	unsigned long high;
>  	unsigned long max;
>  	struct page_counter *parent;
> +	struct page_counter_stock __percpu *stock;
> +	unsigned int batch;
>  } ____cacheline_internodealigned_in_smp;
>  
>  #if BITS_PER_LONG == 32
> @@ -99,6 +108,10 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
>  	counter->watermark = usage;
>  }
>  
> +int page_counter_enable_stock(struct page_counter *counter, unsigned int batch);
> +void page_counter_disable_stock(struct page_counter *counter);
> +void page_counter_free_stock(struct page_counter *counter);
> +
>  #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
>  void page_counter_calculate_protection(struct page_counter *root,
>  				       struct page_counter *counter,
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 661e0f2a5127a..a1a871a9d5c49 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -8,6 +8,7 @@
>  #include <linux/page_counter.h>
>  #include <linux/atomic.h>
>  #include <linux/kernel.h>
> +#include <linux/percpu.h>
>  #include <linux/string.h>
>  #include <linux/sched.h>
>  #include <linux/bug.h>
> @@ -289,6 +290,69 @@ int page_counter_memparse(const char *buf, const char *max,
>  	return 0;
>  }
>  
> +int page_counter_enable_stock(struct page_counter *counter, unsigned int batch)
> +{
> +	struct page_counter_stock __percpu *stock;
> +	int cpu;
> +
> +	stock = alloc_percpu(struct page_counter_stock);
> +	if (!stock)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct page_counter_stock *s = per_cpu_ptr(stock, cpu);
> +
> +		local_trylock_init(&s->lock);
> +	}
> +	counter->stock = stock;
> +	counter->batch = batch;
> +
> +	return 0;
> +}
> +
> +static void page_counter_drain_stock_nolock(struct page_counter *counter)
> +{
> +	unsigned long stock_to_drain = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct page_counter_stock *stock;
> +
> +		stock = per_cpu_ptr(counter->stock, cpu);
> +		stock_to_drain += stock->nr_pages;
> +		stock->nr_pages = 0;
> +	}
> +
> +	if (stock_to_drain)
> +		page_counter_uncharge(counter, stock_to_drain);
> +}
> +
> +void page_counter_disable_stock(struct page_counter *counter)
> +{
> +	if (!counter->stock)
> +		return;
> +
> +	/* This prevents future charges from trying to deposit pages */
> +	WRITE_ONCE(counter->batch, 0);
> +
> +	/*
> +	 * Charges can still be in-flight at this time. Instead of locking here,
> +	 * do the majority of the drains here without locking to free up pages
> +	 * now. Any remaining stock will be drained in page_counter_free_stock.
> +	 */
> +	page_counter_drain_stock_nolock(counter);

Sashiko raised a concern here.
Allowing racy charges is OK, but the problem is that writing stock->nr_pages = 0
with no lock here can race with the reading of that value, and lead to
double-uncharging when racing with concurrent charges.

I think that this can be fixed by not draining in disable_stock and
reordering the callsite:

Before:
drain_all_stock(memcg);
page_counter_disable_stock(&memcg->memory);

After:
page_counter_disable_stock(&memcg->memory);
drain_all_stock(memcg);

This way, the WRITE_ONCE(counter->batch, 0); should prevent any
future charges from trying to land, before we drain stock.

Despite not allowing any more racy charges, we still need to keep the drain
in free_stock since drain_all_stock() uses a mutex_trylock and can fail;
if that happens we need to still drain the stock at a later time, when we
can guarantee that there will be no more contention.

Thanks, Sashiko! I'll keep my eyes posted on the rest of the series as it
goes through the review pipeline. 
Joshua

> +}
> +
> +void page_counter_free_stock(struct page_counter *counter)
> +{
> +	if (!counter->stock)
> +		return;
> +
> +	page_counter_drain_stock_nolock(counter);
> +	free_percpu(counter->stock);
> +	counter->stock = NULL;
> +}
> +

