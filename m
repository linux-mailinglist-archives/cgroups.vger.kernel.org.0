Return-Path: <cgroups+bounces-7469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D1A8570F
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93099A49C4
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2856429344B;
	Fri, 11 Apr 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9B5PZCW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FfMuOjZq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FYJ9zMTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XeuVFsF/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9C1FBCB1
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361743; cv=none; b=oOX52m54HZCgDymq1VzpntA3No3m3Ud+MJRkIDtMeE2oCuIbKvkCWj/Wy4QkURiGPjurfFBFmpuBCVVJnKml5TclIIU8c2tSvtQcGXOUqKm+IdUGg9fA0pKwmLHp+1i9wlGWE5sETV5uSz8bUsooqLcNLHcSNxtiJIRoTNk/ZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361743; c=relaxed/simple;
	bh=2poye6+6Vutphe9me56NWy9liA6pThOpOwOGfw7sTBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHgplYSFr3Cn4n8BdKiWoR1Uc+FGMF8zBy0gt17R+RSq/RD1HyIWP3QtekDrXrP7wCLFRtgNgAHM7FSYs5PuV/ymHnDrW6mfnRy3vAveIXuFFg2G5jox4tTvt9vFL0TOTwSC7LbhlhoMyC+tGzPfKuDeqLkqKULCjLk+mqWVMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9B5PZCW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FfMuOjZq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FYJ9zMTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XeuVFsF/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3A672111F;
	Fri, 11 Apr 2025 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744361740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvyC1oEfaoFU1OlMVjxBeeOBg2Vuu9BudnrP3LNhms=;
	b=u9B5PZCWO519DSz+mCtR8iPH+cLgFlRHYddri+uInF81uhKn1KQ4alBuBdS5+roUs+ioAk
	eQ5bkdiqJwRIHSRWcm4Z+AUBZ/Qo2c8bdVdWev5Wodh5RFpnnHI10oM16WlVa5JrJ1gFPp
	BPZc8JxAxi7PkeBQzhVH1baZyghQER8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744361740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvyC1oEfaoFU1OlMVjxBeeOBg2Vuu9BudnrP3LNhms=;
	b=FfMuOjZqWG4uNRMCYImmKUfJdmnrZayb1Q5wgDCsUeyruudU7EjDcLIChCyeISiHPQyj0F
	e0SzUqowGq8dgoCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FYJ9zMTf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="XeuVFsF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744361739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvyC1oEfaoFU1OlMVjxBeeOBg2Vuu9BudnrP3LNhms=;
	b=FYJ9zMTf9vdanwD4bv25RtyYYchRm7BW/RtpXUEp9vYg0+I6RvpkDc4u1a4qHoxUcGFayk
	qXWrzjrwaRLZ2aSA5UMTTyLLGnqSILd0grE1iOQ0Muw/U942pDXFE//8aWon4GGvNsDztp
	cn9uFlcsMydEFvE517B6eariW/2xb4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744361739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvyC1oEfaoFU1OlMVjxBeeOBg2Vuu9BudnrP3LNhms=;
	b=XeuVFsF/SjSyMZdseF5pAZyTVPZfrODQp7EUOyZT7xk8MEwfsWIpKvA3eBp7b8jVa2HJcQ
	OPE5kBQ4ojtZ+ABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A40BE136A4;
	Fri, 11 Apr 2025 08:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sg24JwvZ+GfiHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Apr 2025 08:55:39 +0000
Message-ID: <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
Date: Fri, 11 Apr 2025 10:55:31 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Waiman Long <llong@redhat.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250410210623.1016767-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3A672111F
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/10/25 23:06, Shakeel Butt wrote:
> The function memcg_hotplug_cpu_dead works on the stock of a remote dead
> CPU and drain_obj_stock works on the given stock instead of local stock,
> so there is no need to take local stock_lock anymore.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f23a4d0ad239..2178a051bd09 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1789,7 +1789,7 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
>  };
>  static DEFINE_MUTEX(percpu_charge_mutex);
>  
> -static void drain_obj_stock(struct memcg_stock_pcp *stock);
> +static void __drain_obj_stock(struct memcg_stock_pcp *stock);
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg);
>  
> @@ -1873,7 +1873,7 @@ static void drain_local_stock(struct work_struct *dummy)
>  	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	drain_obj_stock(stock);
> +	__drain_obj_stock(stock);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>  
> @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  
>  	stock = &per_cpu(memcg_stock, cpu);
>  
> -	/* drain_obj_stock requires stock_lock */
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> -	drain_obj_stock(stock);
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_irq_save(flag);

I think for RT this is not great? At least in theory, probably it's not
actually used together with cpu hotplug? As it relies on memcg_stats_lock()
I think no irq save/enable is necessary there. local_lock_irqsave wasn't
actually a irq disable on RT. I don't know if there's a handy wrapper for this.

> +	/* stock of a remote dead cpu, no need for stock_lock. */
> +	__drain_obj_stock(stock);
> +	local_irq_restore(flag);
>  
>  	drain_stock(stock);
>  
> @@ -2837,7 +2837,11 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	return ret;
>  }
>  
> -static void drain_obj_stock(struct memcg_stock_pcp *stock)
> +/*
> + * Works on the given stock. The callers are responsible for the proper locking
> + * for the local or remote stocks.
> + */
> +static void __drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
>  	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
>  
> @@ -2925,7 +2929,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> -		drain_obj_stock(stock);
> +		__drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
>  		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;


