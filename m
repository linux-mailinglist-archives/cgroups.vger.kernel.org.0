Return-Path: <cgroups+bounces-2764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D89E8BAB91
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23804283858
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE515219B;
	Fri,  3 May 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qMole+1Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RaV1Bx9g"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9F1AACA;
	Fri,  3 May 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735732; cv=none; b=uFCM4shkRWG/Zhgi72QM763ei4bBWB2DayLZ+xLHsIAmTfl3/zb/19Rwa2sVTEhkrzXQQxjzy6qEmxqoi2jfdOFS89O93d3svFZSCg7NDNdAq876Cgk0vw7rkqwKODJpXQNY/7z5v+55/GHHqDiWob2zZGlqG1Ah/GWA7aFV+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735732; c=relaxed/simple;
	bh=88WW0kURqdBjfVybYXftiM2YM7XJ7njj5pm4ndP4vaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isK1LKmlfaA/wm5E0EJBqcUiSZrSjTwG33I6cEeTDnFz50QiY7Yl4HT7v+CAQjoloNw6K1kemm+nkPQ9IngWVKCR4Jh51xppu+2WTRG5Li+2gtU56gJJ10j1Cn43RIqqIz9+SX0109SB7pTQU7EkVO+lpjSVkAhHm/rvvkJBsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qMole+1Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RaV1Bx9g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A64F20254;
	Fri,  3 May 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714735728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9yMKpP+WtXCZbyBz2t9/3WxqhYBErFHeUW75pJnqQ8=;
	b=qMole+1Zdn0F1+ZqrG6EUVw5BjK9JmJ/rWM42iSp1qhhaRFnfLatmTJKZ1QVF47iRkZhbj
	lX6qTmtqvXkGpFyKOoKQI6S/5vcHacEXGRixfkQ8bCecLcnP+y/1/rJzFaiJ5Ga1o8zEPF
	UQ9G5e87Ncq26CecfQEajUTpHUOGkGk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714735727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9yMKpP+WtXCZbyBz2t9/3WxqhYBErFHeUW75pJnqQ8=;
	b=RaV1Bx9gMOPXbKF3N6rOhGhw1fHnczyZ1plP5vjk2ZRWIo3sZd1ItSM26Xqg+gUDWJ/MZr
	9UTCuRye3t7jnBKyDQfP7+5+9XB5XWKuVEl0LdoxBOenusm/k3yU8QdQfb38G9DN7TQWpM
	JYlOVIsMT/Wp0RETs6GHPHQV1Iprnas=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 510AD139CB;
	Fri,  3 May 2024 11:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LDnLEG/KNGapWQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 03 May 2024 11:28:47 +0000
Date: Fri, 3 May 2024 13:28:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access
 stock->nr_pages
Message-ID: <ZjTKareAb6Q3VGAF@tiehlicka>
References: <20240501095420.679208-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501095420.679208-1-leitao@debian.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Wed 01-05-24 02:54:20, Breno Leitao wrote:
> A memcg pointer in the per-cpu stock can be accessed by drain_all_stock()
> and consume_stock() in parallel, causing a potential race.
> 
> KCSAN shows this data-race clearly in the splat below:
> 
> 	BUG: KCSAN: data-race in drain_all_stock.part.0 / try_charge_memcg
> 
> 	write to 0xffff88903f8b0788 of 4 bytes by task 35901 on cpu 2:
> 	try_charge_memcg (mm/memcontrol.c:2323 mm/memcontrol.c:2746)
> 	__mem_cgroup_charge (mm/memcontrol.c:7287 mm/memcontrol.c:7301)
> 	do_anonymous_page (mm/memory.c:1054 mm/memory.c:4375 mm/memory.c:4433)
> 	__handle_mm_fault (mm/memory.c:3878 mm/memory.c:5300 mm/memory.c:5441)
> 	handle_mm_fault (mm/memory.c:5606)
> 	do_user_addr_fault (arch/x86/mm/fault.c:1363)
> 	exc_page_fault (./arch/x86/include/asm/irqflags.h:37
> 		        ./arch/x86/include/asm/irqflags.h:72
> 			arch/x86/mm/fault.c:1513
> 			arch/x86/mm/fault.c:1563)
> 	asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> 
> 	read to 0xffff88903f8b0788 of 4 bytes by task 287 on cpu 27:
> 	drain_all_stock.part.0 (mm/memcontrol.c:2433)
> 	mem_cgroup_css_offline (mm/memcontrol.c:5398 mm/memcontrol.c:5687)
> 	css_killed_work_fn (kernel/cgroup/cgroup.c:5521 kernel/cgroup/cgroup.c:5794)
> 	process_one_work (kernel/workqueue.c:3254)
> 	worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
> 	kthread (kernel/kthread.c:388)
> 	ret_from_fork (arch/x86/kernel/process.c:147)
> 	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> 
> 	value changed: 0x00000014 -> 0x00000013
> 
> This happens because drain_all_stock() is reading stock->nr_pages, while
> consume_stock() might be updating the same address, causing a potential
> data-race.
> 
> Make the shared addresses bulletproof regarding to reads and writes,
> similarly to what stock->cached_objcg and stock->cached.
> Annotate all accesses to stock->nr_pages with READ_ONCE()/WRITE_ONCE().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Michal Hocko <mhocko@suse.com>

It is worth mentioning that the race is harmless.

> ---
>  mm/memcontrol.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fabce2b50c69..d3befe3b62fa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2310,6 +2310,7 @@ static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
>  static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
> +	unsigned int stock_pages;
>  	unsigned long flags;
>  	bool ret = false;
>  
> @@ -2319,8 +2320,9 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	if (memcg == READ_ONCE(stock->cached) && stock->nr_pages >= nr_pages) {
> -		stock->nr_pages -= nr_pages;
> +	stock_pages = READ_ONCE(stock->nr_pages);
> +	if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
> +		WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
>  		ret = true;
>  	}
>  
> @@ -2334,16 +2336,18 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_stock(struct memcg_stock_pcp *stock)
>  {
> +	unsigned int stock_pages = READ_ONCE(stock->nr_pages);
>  	struct mem_cgroup *old = READ_ONCE(stock->cached);
>  
>  	if (!old)
>  		return;
>  
> -	if (stock->nr_pages) {
> -		page_counter_uncharge(&old->memory, stock->nr_pages);
> +	if (stock_pages) {
> +		page_counter_uncharge(&old->memory, stock_pages);
>  		if (do_memsw_account())
> -			page_counter_uncharge(&old->memsw, stock->nr_pages);
> -		stock->nr_pages = 0;
> +			page_counter_uncharge(&old->memsw, stock_pages);
> +
> +		WRITE_ONCE(stock->nr_pages, 0);
>  	}
>  
>  	css_put(&old->css);
> @@ -2380,6 +2384,7 @@ static void drain_local_stock(struct work_struct *dummy)
>  static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
> +	unsigned int stock_pages;
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
> @@ -2387,9 +2392,10 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		css_get(&memcg->css);
>  		WRITE_ONCE(stock->cached, memcg);
>  	}
> -	stock->nr_pages += nr_pages;
> +	stock_pages = READ_ONCE(stock->nr_pages) + nr_pages;
> +	WRITE_ONCE(stock->nr_pages, stock_pages);
>  
> -	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
> +	if (stock_pages > MEMCG_CHARGE_BATCH)
>  		drain_stock(stock);
>  }
>  
> @@ -2428,7 +2434,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  
>  		rcu_read_lock();
>  		memcg = READ_ONCE(stock->cached);
> -		if (memcg && stock->nr_pages &&
> +		if (memcg && READ_ONCE(stock->nr_pages) &&
>  		    mem_cgroup_is_descendant(memcg, root_memcg))
>  			flush = true;
>  		else if (obj_stock_flush_required(stock, root_memcg))
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

