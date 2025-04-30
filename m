Return-Path: <cgroups+bounces-7950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F845AA4A4D
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC67B1185
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A2248F53;
	Wed, 30 Apr 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l54wFE/F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5BKmIgpf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l54wFE/F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5BKmIgpf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF4221F35
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746013371; cv=none; b=I+uEeAVRM4H47Z+LSWUaT+GvOI1Bx4ESed//KO4XLSng00PPFU3CCb051aCuxNdHZpw5Zo93VnFXd7rYYzGObtsMTrs6Su9oEojURbcDmEnxKxwZ5wAhxU2grZK0NTiJcWdfAmfvFyPJeytjjZ3MpD/IkNYbbAGsWVQiatuE57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746013371; c=relaxed/simple;
	bh=w1HsfbiZ81GXZWTYVUQqkmtNBU8SZdyaw75xVYEcFPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLJVlP3qAuBOc7oh37RINTeDF1T6fLYyMBPwzrowFA3A/71NUo4B6hF1rkUr8mO8N1mx8GjhJsHoupo3My8Gf2hunxboUECayb4q1UbSUbOrzu6+w4a4eQLxbJ5O4vZaVt+Vp/nVUnPksJiTEIFIY11tbyDsY+GMzOsvLcbwcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l54wFE/F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5BKmIgpf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l54wFE/F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5BKmIgpf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C17BD21200;
	Wed, 30 Apr 2025 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746013367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMdUf+G8z9UwnFqiI+Ohf1SNPY5q3W5xNuNqMGtKlLI=;
	b=l54wFE/Fyyayk3OovslwsQ4asa1Pi4AgvAffXiZwgZOzttH/oxC6jk5LjGchupx3kPFXu3
	1Dv6JpgyR2B2/d3tYnXBDgrPzVao0HiIpRChPS1nNLDwz7u75B57Bq7GzxtbiXk3IvA2IN
	4HcJjTvXQVTQ/ds84rUN4C3XKP9jh3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746013367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMdUf+G8z9UwnFqiI+Ohf1SNPY5q3W5xNuNqMGtKlLI=;
	b=5BKmIgpfXflKaDnFG8V+ORenoH4P1/jhNQAt+HptR/T4clMTesTivFo7cDDi58rCuVgla/
	DwZdggVsGeegzCDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="l54wFE/F";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5BKmIgpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746013367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMdUf+G8z9UwnFqiI+Ohf1SNPY5q3W5xNuNqMGtKlLI=;
	b=l54wFE/Fyyayk3OovslwsQ4asa1Pi4AgvAffXiZwgZOzttH/oxC6jk5LjGchupx3kPFXu3
	1Dv6JpgyR2B2/d3tYnXBDgrPzVao0HiIpRChPS1nNLDwz7u75B57Bq7GzxtbiXk3IvA2IN
	4HcJjTvXQVTQ/ds84rUN4C3XKP9jh3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746013367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMdUf+G8z9UwnFqiI+Ohf1SNPY5q3W5xNuNqMGtKlLI=;
	b=5BKmIgpfXflKaDnFG8V+ORenoH4P1/jhNQAt+HptR/T4clMTesTivFo7cDDi58rCuVgla/
	DwZdggVsGeegzCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A858F139E7;
	Wed, 30 Apr 2025 11:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K3zJKLcMEmhsUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 11:42:47 +0000
Message-ID: <a9977cb2-3dce-4be1-81a3-23e760082922@suse.cz>
Date: Wed, 30 Apr 2025 13:42:47 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] memcg: separate local_trylock for memcg and obj
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-3-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250429230428.1935619-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C17BD21200
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/30/25 01:04, Shakeel Butt wrote:
> The per-cpu stock_lock protects cached memcg and cached objcg and their
> respective fields. However there is no dependency between these fields
> and it is better to have fine grained separate locks for cached memcg
> and cached objcg. This decoupling of locks allows us to make the memcg
> charge cache and objcg charge cache to be nmi safe independently.
> 
> At the moment, memcg charge cache is already nmi safe and this
> decoupling will allow to make memcg charge cache work without disabling
> irqs.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 52 +++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)

> @@ -1883,19 +1885,22 @@ static void drain_local_stock(struct work_struct *dummy)
>  	struct memcg_stock_pcp *stock;
>  	unsigned long flags;
>  
> -	/*
> -	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
> -	 * drain_stock races is that we always operate on local CPU stock
> -	 * here with IRQ disabled
> -	 */
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (WARN_ONCE(!in_task(), "drain in non-task context"))
> +		return;
>  
> +	preempt_disable();
>  	stock = this_cpu_ptr(&memcg_stock);
> +
> +	local_lock_irqsave(&memcg_stock.obj_lock, flags);
>  	drain_obj_stock(stock);
> +	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
> +
> +	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
>  	drain_stock_fully(stock);
> -	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> +	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
>  
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> +	preempt_enable();

This usage of preempt_disable() looks rather weird and makes RT unhappy as
the local lock is a mutex, so it gives you this:

BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48

I know the next patch removes it again but for bisectability purposes it
should be avoided. Instead of preempt_disable() we can extend the local lock
scope here?

>  }
>  
>  static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> @@ -1918,10 +1923,10 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
>  
>  	if (nr_pages > MEMCG_CHARGE_BATCH ||
> -	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags)) {
>  		/*
>  		 * In case of larger than batch refill or unlikely failure to
> -		 * lock the percpu stock_lock, uncharge memcg directly.
> +		 * lock the percpu memcg_lock, uncharge memcg directly.
>  		 */
>  		memcg_uncharge(memcg, nr_pages);
>  		return;
> @@ -1953,7 +1958,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		WRITE_ONCE(stock->nr_pages[i], nr_pages);
>  	}
>  
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
>  }
>  
>  static bool is_drain_needed(struct memcg_stock_pcp *stock,
> @@ -2028,11 +2033,12 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  
>  	stock = &per_cpu(memcg_stock, cpu);
>  
> -	/* drain_obj_stock requires stock_lock */
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	/* drain_obj_stock requires obj_lock */
> +	local_lock_irqsave(&memcg_stock.obj_lock, flags);
>  	drain_obj_stock(stock);
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
>  
> +	/* no need for the local lock */
>  	drain_stock_fully(stock);
>  
>  	return 0;
> @@ -2885,7 +2891,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	unsigned long flags;
>  	bool ret = false;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	local_lock_irqsave(&memcg_stock.obj_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
> @@ -2896,7 +2902,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
>  	}
>  
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
>  
>  	return ret;
>  }
> @@ -2985,7 +2991,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	unsigned long flags;
>  	unsigned int nr_pages = 0;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	local_lock_irqsave(&memcg_stock.obj_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> @@ -3007,7 +3013,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  		stock->nr_bytes &= (PAGE_SIZE - 1);
>  	}
>  
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
>  
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);


