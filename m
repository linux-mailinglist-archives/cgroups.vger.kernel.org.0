Return-Path: <cgroups+bounces-2763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039AD8BAB8E
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D161C21CA3
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8960152501;
	Fri,  3 May 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rx8vmp8Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rx8vmp8Z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A3152197;
	Fri,  3 May 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735666; cv=none; b=EAVIg5Rukm0oebCHxDapvtugk3xhzCxI9syRD/9tPgxlqw8rRN1rgCBfmBowvPZY3VTv1MB62r0FJr6dVV7bNZIzJ+fqB6epWCNrIJilYlxF88frmNX2AtmOClMLNCTrwdsYzmy7cS4dtPPtjq6jnnbWYGkTmm1IdpvTgLKHaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735666; c=relaxed/simple;
	bh=sZMYPxJX/4mfiHqJ/Yi9H75a1iIpwoT/ry5Fbko4snQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVccwHL04nlIBzLRozQzZN7CFAfjb9kuz+kJ+UY4K6DSR4dADFOaxRP4C48BDBaGpivdh0Y54bwD1z3JQcZX1awPRVncnrOVz8OOVaJLSHV6ZR4PWi7tSi2hjS3pVqJh1IdrrjBjkHK5r00ja6slC2Z2o+HY5EzB1esokjwUwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rx8vmp8Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rx8vmp8Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B99F23387A;
	Fri,  3 May 2024 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714735662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpjzV5DWrRABNO+vO47pjlZXBhvnc1hWU3ZO34EKqg=;
	b=Rx8vmp8Zigf3yHzGm1pm9Kmc0A6srYlVYDeWNYIw+gz2cyITTJE9exIDiHErn8Hc6h3ZVf
	TBVOYBBkck1vthjzNSpb170SUsJQUYxiZRJVelC8VbtQtYBiLottbMnvOM2tj5CB5cNnXn
	BJYpuaOQUzp7OBFNN2QiCivdXHFBgRE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Rx8vmp8Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714735662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpjzV5DWrRABNO+vO47pjlZXBhvnc1hWU3ZO34EKqg=;
	b=Rx8vmp8Zigf3yHzGm1pm9Kmc0A6srYlVYDeWNYIw+gz2cyITTJE9exIDiHErn8Hc6h3ZVf
	TBVOYBBkck1vthjzNSpb170SUsJQUYxiZRJVelC8VbtQtYBiLottbMnvOM2tj5CB5cNnXn
	BJYpuaOQUzp7OBFNN2QiCivdXHFBgRE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F2AF139CB;
	Fri,  3 May 2024 11:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G6nZIy7KNGZgWQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 03 May 2024 11:27:42 +0000
Date: Fri, 3 May 2024 13:27:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, leit@meta.com,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
Message-ID: <ZjTKLVjxuUJwwFPg@tiehlicka>
References: <20240424125940.2410718-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424125940.2410718-1-leitao@debian.org>
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B99F23387A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

On Wed 24-04-24 05:59:39, Breno Leitao wrote:
> A data-race issue in memcg rstat occurs when two distinct code paths
> access the same 4-byte region concurrently. KCSAN detection triggers the
> following BUG as a result.
> 
> 	BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rstat_flush
> 
> 	write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
> 	mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
> 	cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminator 7))
> 	cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/rstat.c:278)
> 	mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
> 	memory_numa_stat_show (mm/memcontrol.c:6911)
> <snip>
> 
> 	read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
> 	__count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
> 	count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./include/linux/memcontrol.h:1120)
> 	handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
> <snip>
> 
> 	value changed: 0x00000029 -> 0x00000000
> 
> The race occurs because two code paths access the same "stats_updates"
> location. Although "stats_updates" is a per-CPU variable, it is remotely
> accessed by another CPU at
> cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> the data race mentioned.
> 
> Considering that memcg_rstat_updated() is in the hot code path, adding
> a lock to protect it may not be desirable, especially since this
> variable pertains solely to statistics.
> 
> Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
> can prevent KCSAN splats and potential partial reads/writes.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Michal Hocko <mhocko@suse.com>

It is worth mentioning that the race is harmless.

Thanks!

> ---
>  mm/memcontrol.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fabce2b50c69..3c99457b36a1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -715,6 +715,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
>  	struct memcg_vmstats_percpu *statc;
>  	int cpu = smp_processor_id();
> +	unsigned int stats_updates;
>  
>  	if (!val)
>  		return;
> @@ -722,8 +723,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	cgroup_rstat_updated(memcg->css.cgroup, cpu);
>  	statc = this_cpu_ptr(memcg->vmstats_percpu);
>  	for (; statc; statc = statc->parent) {
> -		statc->stats_updates += abs(val);
> -		if (statc->stats_updates < MEMCG_CHARGE_BATCH)
> +		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
> +		WRITE_ONCE(statc->stats_updates, stats_updates);
> +		if (stats_updates < MEMCG_CHARGE_BATCH)
>  			continue;
>  
>  		/*
> @@ -731,9 +733,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  		 * redundant. Avoid the overhead of the atomic update.
>  		 */
>  		if (!memcg_vmstats_needs_flush(statc->vmstats))
> -			atomic64_add(statc->stats_updates,
> +			atomic64_add(stats_updates,
>  				     &statc->vmstats->stats_updates);
> -		statc->stats_updates = 0;
> +		WRITE_ONCE(statc->stats_updates, 0);
>  	}
>  }
>  
> @@ -5845,7 +5847,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  			}
>  		}
>  	}
> -	statc->stats_updates = 0;
> +	WRITE_ONCE(statc->stats_updates, 0);
>  	/* We are in a per-cpu loop here, only do the atomic write once */
>  	if (atomic64_read(&memcg->vmstats->stats_updates))
>  		atomic64_set(&memcg->vmstats->stats_updates, 0);
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs

