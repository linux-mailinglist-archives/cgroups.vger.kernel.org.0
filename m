Return-Path: <cgroups+bounces-8185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB6AB67F3
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ED13AF887
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2B25D8F0;
	Wed, 14 May 2025 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TrmG4wc6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="21ZFuNDM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TrmG4wc6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="21ZFuNDM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2225C809
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216220; cv=none; b=EISqLzVJHVKjPswFtcmvy4DMk97mAlXA/4uszHDjIrguB2UZmRbeGOaYZFUu/7p1cDDKJSAANGkpQIcGpRd7e5szzJso4bfLw0ADUpJkotZODpKK8Z8tDf+p4GRCS3j6SHTA0lvpVnuKWZ+x87ZxKGN95pS+HwNoUPT/5krxfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216220; c=relaxed/simple;
	bh=VCuo3wqPiHvzECJEw/YJ76AUwqcSvIX3zwjYHe84X4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8pt4GLuT3pK/6DFX38604EJtnE/wqYei2PelmBZeGCKMIQBpNVBKQBluT8c5JP6EcbZq8oZlkGUk1j1ttnTPpZQSkta8G1MjM4sSvpxdphIk/eckNRIHY2DYNAM4i1Dz+KtgNJN0UEjhE8kYFCcboOWYdo60kdoDgVveQAfRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TrmG4wc6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=21ZFuNDM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TrmG4wc6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=21ZFuNDM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2245211EC;
	Wed, 14 May 2025 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747216216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xE4+dHqZC6ImaRc6KUtuJd+c5Z6FNFmwXh/MDWcHs=;
	b=TrmG4wc62xzMt53ssOXdXjGh39jIJ0daYnNdwkQkMlWhOGEbrUOtW0rysP2o3yzRQkGPAD
	irZN71xRQBF0Q8t1h/iHznKUPhDg9bgAoTuZcZGckZmhLP0vA14/QojPKtH0y6JM2pYFlK
	lFh2/uCYcukcyKNSRaTgj1EEO0vOcX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747216216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xE4+dHqZC6ImaRc6KUtuJd+c5Z6FNFmwXh/MDWcHs=;
	b=21ZFuNDMxz55Vzk3XadOKDM6/ka3RDzFDL0+v0pvQIN90an8mH5SnY6FF3625GJIjZcfK6
	3mfgW/VcXqgzw/Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TrmG4wc6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=21ZFuNDM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747216216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xE4+dHqZC6ImaRc6KUtuJd+c5Z6FNFmwXh/MDWcHs=;
	b=TrmG4wc62xzMt53ssOXdXjGh39jIJ0daYnNdwkQkMlWhOGEbrUOtW0rysP2o3yzRQkGPAD
	irZN71xRQBF0Q8t1h/iHznKUPhDg9bgAoTuZcZGckZmhLP0vA14/QojPKtH0y6JM2pYFlK
	lFh2/uCYcukcyKNSRaTgj1EEO0vOcX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747216216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xE4+dHqZC6ImaRc6KUtuJd+c5Z6FNFmwXh/MDWcHs=;
	b=21ZFuNDMxz55Vzk3XadOKDM6/ka3RDzFDL0+v0pvQIN90an8mH5SnY6FF3625GJIjZcfK6
	3mfgW/VcXqgzw/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8943813306;
	Wed, 14 May 2025 09:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /+sXIVhnJGiQMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 09:50:16 +0000
Message-ID: <cb50a1c8-1f94-4a49-b5b3-8d2008c9f272@suse.cz>
Date: Wed, 14 May 2025 11:50:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe against
 irqs
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250514050813.2526843-1-shakeel.butt@linux.dev>
 <20250514050813.2526843-2-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250514050813.2526843-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B2245211EC
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/14/25 07:08, Shakeel Butt wrote:
> The function memcg_rstat_updated() is used to track the memcg stats
> updates for optimizing the flushes. At the moment, it is not re-entrant
> safe and the callers disabled irqs before calling. However to achieve
> the goal of updating memcg stats without irqs, memcg_rstat_updated()
> needs to be re-entrant safe against irqs.
> 
> This patch makes memcg_rstat_updated() re-entrant safe using this_cpu_*
> ops. On archs with CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, this patch is
> also making memcg_rstat_updated() nmi safe.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
> -	struct memcg_vmstats_percpu *statc;
> -	int cpu = smp_processor_id();
> +	struct memcg_vmstats_percpu __percpu *statc_pcpu;
> +	int cpu;
>  	unsigned int stats_updates;
>  
>  	if (!val)
>  		return;
>  
> +	/* Don't assume callers have preemption disabled. */
> +	cpu = get_cpu();
> +
>  	css_rstat_updated(&memcg->css, cpu);
> -	statc = this_cpu_ptr(memcg->vmstats_percpu);
> -	for (; statc; statc = statc->parent) {
> +	statc_pcpu = memcg->vmstats_percpu;

Wonder if extracting the this_cpu_ptr() statc pointer would still make the
code a bit simpler when accessing parent_pcpu and vmstats later on.

> +	for (; statc_pcpu; statc_pcpu = this_cpu_ptr(statc_pcpu)->parent_pcpu) {
>  		/*
>  		 * If @memcg is already flushable then all its ancestors are
>  		 * flushable as well and also there is no need to increase
>  		 * stats_updates.
>  		 */
> -		if (memcg_vmstats_needs_flush(statc->vmstats))
> +		if (memcg_vmstats_needs_flush(this_cpu_ptr(statc_pcpu)->vmstats))
>  			break;
>  
> -		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
> -		WRITE_ONCE(statc->stats_updates, stats_updates);
> +		stats_updates = this_cpu_add_return(statc_pcpu->stats_updates,
> +						    abs(val));
>  		if (stats_updates < MEMCG_CHARGE_BATCH)
>  			continue;
>  
> -		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
> -		WRITE_ONCE(statc->stats_updates, 0);
> +		stats_updates = this_cpu_xchg(statc_pcpu->stats_updates, 0);
> +		if (stats_updates)

I think this is very likely to be true (given stats_updates >=
MEMCG_CHARGE_BATCH from above), only an irq can change it at this point? So
we could just do this unconditionally, and if we very rarely add a zero, it
doesn't matter?

> +			atomic64_add(stats_updates,
> +				&this_cpu_ptr(statc_pcpu)->vmstats->stats_updates);
>  	}
> +	put_cpu();
>  }
>  
>  static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
> @@ -3716,7 +3722,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>  
>  static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  {
> -	struct memcg_vmstats_percpu *statc, *pstatc;
> +	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
>  	struct mem_cgroup *memcg;
>  	int node, cpu;
>  	int __maybe_unused i;
> @@ -3747,9 +3753,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  
>  	for_each_possible_cpu(cpu) {
>  		if (parent)
> -			pstatc = per_cpu_ptr(parent->vmstats_percpu, cpu);
> +			pstatc_pcpu = parent->vmstats_percpu;
>  		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> -		statc->parent = parent ? pstatc : NULL;
> +		statc->parent_pcpu = parent ? pstatc_pcpu : NULL;
>  		statc->vmstats = memcg->vmstats;
>  	}
>  


