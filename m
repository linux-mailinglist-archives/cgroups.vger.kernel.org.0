Return-Path: <cgroups+bounces-8158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9CDAB52D8
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1AF9A1575
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4526A1A9;
	Tue, 13 May 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChNCLmYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXZC/sjq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChNCLmYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXZC/sjq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFF26A0BE
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131754; cv=none; b=kAbIX3qRbGfPqK0t8Pu/0usyjvT9Vwwj/iNP/jQhYUBqYKhumuoNGCYMQFeZuBQEFpwRXJo9Os3OD967AocEfe/PWRVvjMbH1/MZYBgWIC4HAXe40t53ZGZ41IAl3vHx/hE3U5gidPu1btx4ntktKKtMCJt7AlLS50DpLUja3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131754; c=relaxed/simple;
	bh=c1WvkTFbMurOFNrcRbpPyC6+g7FLrn9s6jR5zWXVdA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKPK3Mwf8oEFV36rji8tU5Ix2pfK1b0xW1g7N3PktEIAF5VjRdtrHOpNSZG2rsTXUYy2pEMv4IgPz8909g5xVnSyL0zGYFciz0EBpGX/I/oUnJaTOf78P4d7WvghDYt5lgVvjQwW0B+xKWguha/DVDYs2POeCB/r7TUqhEPJmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChNCLmYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXZC/sjq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChNCLmYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXZC/sjq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E8AE211D2;
	Tue, 13 May 2025 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747131749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZHYTr94L6UiUBzTPPsFJdqRFgV3hVQF43r7tnRnVM=;
	b=ChNCLmYISGXYX57UNr2nhroIDOi+2pNZhFuO5IVV8uaTn8ZrMF83DJG6bCLUwVuQveMrw2
	mOodNvkGB3R2zdSdYGaub2D9F+fyF9Xgt1dXY6FBZ+jS7rgTprqwfUvr/cqWRZRtLJfhO7
	OmrdBjya7s8VCJWuNqx0qWU3RzyMC/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747131749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZHYTr94L6UiUBzTPPsFJdqRFgV3hVQF43r7tnRnVM=;
	b=GXZC/sjqv9BstPD8ulzua7sBguJNvVGKA4T/kHsmUupPwVlRSxCvhFjXmKJKPO8yv79fti
	u1OEC5HxJytRfEAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ChNCLmYI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="GXZC/sjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747131749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZHYTr94L6UiUBzTPPsFJdqRFgV3hVQF43r7tnRnVM=;
	b=ChNCLmYISGXYX57UNr2nhroIDOi+2pNZhFuO5IVV8uaTn8ZrMF83DJG6bCLUwVuQveMrw2
	mOodNvkGB3R2zdSdYGaub2D9F+fyF9Xgt1dXY6FBZ+jS7rgTprqwfUvr/cqWRZRtLJfhO7
	OmrdBjya7s8VCJWuNqx0qWU3RzyMC/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747131749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZHYTr94L6UiUBzTPPsFJdqRFgV3hVQF43r7tnRnVM=;
	b=GXZC/sjqv9BstPD8ulzua7sBguJNvVGKA4T/kHsmUupPwVlRSxCvhFjXmKJKPO8yv79fti
	u1OEC5HxJytRfEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251D6137E8;
	Tue, 13 May 2025 10:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EG0CGUdI2hdGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 10:22:29 +0000
Message-ID: <fbcc9892-838c-4156-8ece-94793c00a1c6@suse.cz>
Date: Tue, 13 May 2025 12:22:28 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
 <20250513031316.2147548-2-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E8AE211D2
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/13/25 05:13, Shakeel Butt wrote:
> The function memcg_rstat_updated() is used to track the memcg stats
> updates for optimizing the flushes. At the moment, it is not re-entrant
> safe and the callers disabled irqs before calling. However to achieve
> the goal of updating memcg stats without irqs, memcg_rstat_updated()
> needs to be re-entrant safe against irqs.
> 
> This patch makes memcg_rstat_updated() re-entrant safe against irqs.
> However it is using atomic_* ops which on x86, adds lock prefix to the
> instructions. Since this is per-cpu data, the this_cpu_* ops are
> preferred. However the percpu pointer is stored in struct mem_cgroup and
> doing the upward traversal through struct mem_cgroup may cause two cache
> misses as compared to traversing through struct memcg_vmstats_percpu
> pointer.
> 
> NOTE: explore if there is atomic_* ops alternative without lock prefix.

local_t might be what you want here
https://docs.kernel.org/core-api/local_ops.html

Or maybe just add __percpu to parent like this?

struct memcg_vmstats_percpu {
...
        struct memcg_vmstats_percpu __percpu *parent;
...
}

Yes, it means on each cpu's struct memcg_vmstats_percpu instance there will
be actually the same value stored (the percpu offset) instead of the
cpu-specific parent pointer, which might seem wasteful. But AFAIK this_cpu_*
is optimized enough thanks to the segment register usage, that it doesn't
matter? It shouldn't cause any extra cache miss you worry about, IIUC?

With that I think you could refactor that code to use e.g.
this_cpu_add_return() and this_cpu_xchg() on the stats_updates and obtain
the parent "pointer" in a way that's also compatible with these operations.

That is unless we want also nmi safety, then we're back to the issue of the
previous series...

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6cfa3550f300..2c4c095bf26c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -503,7 +503,7 @@ static inline int memcg_events_index(enum vm_event_item idx)
>  
>  struct memcg_vmstats_percpu {
>  	/* Stats updates since the last flush */
> -	unsigned int			stats_updates;
> +	atomic_t			stats_updates;
>  
>  	/* Cached pointers for fast iteration in memcg_rstat_updated() */
>  	struct memcg_vmstats_percpu	*parent;
> @@ -590,12 +590,15 @@ static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
>  	struct memcg_vmstats_percpu *statc;
> -	int cpu = smp_processor_id();
> -	unsigned int stats_updates;
> +	int cpu;
> +	int stats_updates;
>  
>  	if (!val)
>  		return;
>  
> +	/* Don't assume callers have preemption disabled. */
> +	cpu = get_cpu();
> +
>  	cgroup_rstat_updated(memcg->css.cgroup, cpu);
>  	statc = this_cpu_ptr(memcg->vmstats_percpu);
>  	for (; statc; statc = statc->parent) {
> @@ -607,14 +610,16 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  		if (memcg_vmstats_needs_flush(statc->vmstats))
>  			break;
>  
> -		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
> -		WRITE_ONCE(statc->stats_updates, stats_updates);
> +		stats_updates = atomic_add_return(abs(val), &statc->stats_updates);
>  		if (stats_updates < MEMCG_CHARGE_BATCH)
>  			continue;
>  
> -		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
> -		WRITE_ONCE(statc->stats_updates, 0);
> +		stats_updates = atomic_xchg(&statc->stats_updates, 0);
> +		if (stats_updates)
> +			atomic64_add(stats_updates,
> +				     &statc->vmstats->stats_updates);
>  	}
> +	put_cpu();
>  }
>  
>  static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
> @@ -4155,7 +4160,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  		mem_cgroup_stat_aggregate(&ac);
>  
>  	}
> -	WRITE_ONCE(statc->stats_updates, 0);
> +	atomic_set(&statc->stats_updates, 0);
>  	/* We are in a per-cpu loop here, only do the atomic write once */
>  	if (atomic64_read(&memcg->vmstats->stats_updates))
>  		atomic64_set(&memcg->vmstats->stats_updates, 0);


