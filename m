Return-Path: <cgroups+bounces-7068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A2A60F62
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD481776CE
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAE1FCFF1;
	Fri, 14 Mar 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZixxNQVp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/3WGbyQ+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZixxNQVp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/3WGbyQ+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DE1F03F1
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949678; cv=none; b=DXM4tpkW7ZQF+eg2DSe/bimB4ZU5tGRw/YYwcAjRmu927cLk5ukoSUYZrK7gk4z0ug2iiGUweuB7xzONm9Wdah0GTcDz0ubtVjoU9C8vtYpuuT/b8WjLMgrxrtV77gUBURVkFw6MllQqPF9zkOysbRufJ+43Kfvz3G9StYLsXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949678; c=relaxed/simple;
	bh=vyy3Hkd+4sD/3EaFvivpYUpmWvIEgO9w6uQ/ZlZKbGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsH7Zbyf8GY8YM2f07LqhfWAZHFZTfA2+8hdsVxm/PyqLFJW2cDqoRrm7HPrQsMkWRCVpKKJ5qV3A9lElhwMqFkSn4mMurLHMReCio7nQMYrs3Rp98Od1ErlvXEhFbjMfPluZ/zteI2LSLAxH65cJaghgWSYAWgmVbTG3RIwmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZixxNQVp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/3WGbyQ+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZixxNQVp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/3WGbyQ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 574201F388;
	Fri, 14 Mar 2025 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741949674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVEcF79uzA4C2CoSVuP2r2XYz5yM9noYVSeby4OOVTE=;
	b=ZixxNQVpA4v5+w2Grz2zLpxIlSmrVWM/Ej2xQbBtoSz0/cjXCRDnxMGkdlBHLmtnv7OXYp
	Ewv5kTPecoMJMJ26wb9aPigFwryBlEa6KeK8bAKmM/QUciAdeM3gKw6n4Btq8o3U3qaogz
	JG9zYi45KwyRbFzf9kNrwmLytNsiQEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741949674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVEcF79uzA4C2CoSVuP2r2XYz5yM9noYVSeby4OOVTE=;
	b=/3WGbyQ+ZCNmcYtR/C6DLXI+Rs5re7stMb9n56ODer7gjt+ynLqCFaVe2tuYt/tdcXW8Dj
	/gpkYM/JVZX0x9Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741949674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVEcF79uzA4C2CoSVuP2r2XYz5yM9noYVSeby4OOVTE=;
	b=ZixxNQVpA4v5+w2Grz2zLpxIlSmrVWM/Ej2xQbBtoSz0/cjXCRDnxMGkdlBHLmtnv7OXYp
	Ewv5kTPecoMJMJ26wb9aPigFwryBlEa6KeK8bAKmM/QUciAdeM3gKw6n4Btq8o3U3qaogz
	JG9zYi45KwyRbFzf9kNrwmLytNsiQEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741949674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVEcF79uzA4C2CoSVuP2r2XYz5yM9noYVSeby4OOVTE=;
	b=/3WGbyQ+ZCNmcYtR/C6DLXI+Rs5re7stMb9n56ODer7gjt+ynLqCFaVe2tuYt/tdcXW8Dj
	/gpkYM/JVZX0x9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D213132DD;
	Fri, 14 Mar 2025 10:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dCx8DuoK1Gd9bgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:54:34 +0000
Message-ID: <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>
Date: Fri, 14 Mar 2025 11:54:34 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
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
 <20250314061511.1308152-11-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-11-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 07:15, Shakeel Butt wrote:
> Let's switch all memcg_stock locks acquire and release places to not
> disable and enable irqs. There are two still functions (i.e.
> mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
> update the stats on non-RT kernels. For now add a simple wrapper for
> that functionality.

BTW, which part of __mod_objcg_mlstate() really needs disabled irqs and not
just preemption? I see it does rcu_read_lock() anyway, which disables
preemption. Then in __mod_memcg_lruvec_state() we do some __this_cpu_add()
updates. I think these also are fine with just disabled preemption as they
are atomic vs irqs (but don't need LOCK prefix to be atomic vs other cpus
updates).

Is it just memcg_rstat_updated() which does READ_ONCE/WRITE_ONCE? Could we
perhaps just change it to operations where disabled preemption is enough?

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 83 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ba5d004049d3..fa28efa298f4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1796,22 +1796,17 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   *
>   * returns true if successful, false otherwise.
>   */
> -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> -			  gfp_t gfp_mask)
> +static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
>  	unsigned int stock_pages;
> -	unsigned long flags;
>  	bool ret = false;
>  
>  	if (nr_pages > MEMCG_CHARGE_BATCH)
>  		return ret;
>  
> -	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> -		if (!gfpflags_allow_spinning(gfp_mask))
> +	if (!localtry_trylock(&memcg_stock.stock_lock))
>  			return ret;
> -		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
> -	}
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	stock_pages = READ_ONCE(stock->nr_pages);
> @@ -1820,7 +1815,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
>  		ret = true;
>  	}
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  
>  	return ret;
>  }
> @@ -1855,7 +1850,6 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  static void drain_local_stock(struct work_struct *dummy)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
>  
>  	lockdep_assert_once(in_task());
>  
> @@ -1864,14 +1858,14 @@ static void drain_local_stock(struct work_struct *dummy)
>  	 * drain_stock races is that we always operate on local CPU stock
>  	 * here with IRQ disabled
>  	 */
> -	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	localtry_lock(&memcg_stock.stock_lock);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	drain_obj_stock(stock);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  }
>  
>  /* Should never be called with root_mem_cgroup. */
> @@ -1879,9 +1873,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
>  	unsigned int stock_pages;
> -	unsigned long flags;
>  
> -	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +	if (!localtry_trylock(&memcg_stock.stock_lock)) {
>  		/*
>  		 * In case of unlikely failure to lock percpu stock_lock
>  		 * uncharge memcg directly.
> @@ -1902,7 +1895,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (stock_pages > MEMCG_CHARGE_BATCH)
>  		drain_stock(stock);
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  }
>  
>  /*
> @@ -1953,17 +1946,12 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
>  
>  	lockdep_assert_once(in_task());
>  
>  	stock = &per_cpu(memcg_stock, cpu);
>  
> -	/* drain_obj_stock requires stock_lock */
> -	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
>  	drain_obj_stock(stock);
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> -
>  	drain_stock(stock);
>  
>  	return 0;
> @@ -2254,7 +2242,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	unsigned long pflags;
>  
>  retry:
> -	if (consume_stock(memcg, nr_pages, gfp_mask))
> +	if (consume_stock(memcg, nr_pages))
>  		return 0;
>  
>  	if (!gfpflags_allow_spinning(gfp_mask))
> @@ -2757,6 +2745,28 @@ static void replace_stock_objcg(struct memcg_stock_pcp *stock,
>  	WRITE_ONCE(stock->cached_objcg, objcg);
>  }
>  
> +static unsigned long rt_lock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +	migrate_disable();
> +	return 0;
> +#else
> +	unsigned long flags = 0;
> +
> +	local_irq_save(flags);
> +	return flags;
> +#endif
> +}
> +
> +static void rt_unlock(unsigned long flags)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +	migrate_enable();
> +#else
> +	local_irq_restore(flags);
> +#endif
> +}
> +
>  static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr)
>  {
> @@ -2764,7 +2774,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	unsigned long flags;
>  	int *bytes;
>  
> -	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +	if (!localtry_trylock(&memcg_stock.stock_lock)) {
> +		/* Do we need mix_rt_[un]lock here too. */
>  		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
>  		return;
>  	}
> @@ -2783,6 +2794,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		/* Flush the existing cached vmstat data */
>  		struct pglist_data *oldpg = stock->cached_pgdat;
>  
> +		flags = rt_lock();
> +
>  		if (stock->nr_slab_reclaimable_b) {
>  			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
>  					  stock->nr_slab_reclaimable_b);
> @@ -2793,6 +2806,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  					  stock->nr_slab_unreclaimable_b);
>  			stock->nr_slab_unreclaimable_b = 0;
>  		}
> +
> +		rt_unlock(flags);
>  		stock->cached_pgdat = pgdat;
>  	}
>  
> @@ -2814,19 +2829,21 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  			nr = 0;
>  		}
>  	}
> -	if (nr)
> +	if (nr) {
> +		flags = rt_lock();
>  		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
> +		rt_unlock(flags);
> +	}
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
>  	bool ret = false;
>  
> -	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags))
> +	if (!localtry_trylock(&memcg_stock.stock_lock))
>  		return ret;
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> @@ -2835,7 +2852,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  		ret = true;
>  	}
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  
>  	return ret;
>  }
> @@ -2843,10 +2860,16 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
>  	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
> +	unsigned long flags;
> +	bool locked = stock->nr_bytes || stock->nr_slab_reclaimable_b ||
> +		stock->nr_slab_unreclaimable_b;
>  
>  	if (!old)
>  		return;
>  
> +	if (locked)
> +		flags = rt_lock();
> +
>  	if (stock->nr_bytes) {
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> @@ -2897,6 +2920,9 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->cached_pgdat = NULL;
>  	}
>  
> +	if (locked)
> +		rt_unlock(flags);
> +
>  	WRITE_ONCE(stock->cached_objcg, NULL);
>  	obj_cgroup_put(old);
>  }
> @@ -2920,10 +2946,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  			     bool allow_uncharge)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
>  	unsigned int nr_pages = 0;
>  
> -	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +	if (!localtry_trylock(&memcg_stock.stock_lock)) {
>  		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
>  		return;
>  	}
> @@ -2940,7 +2965,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  		stock->nr_bytes &= (PAGE_SIZE - 1);
>  	}
>  
> -	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	localtry_unlock(&memcg_stock.stock_lock);
>  
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);


