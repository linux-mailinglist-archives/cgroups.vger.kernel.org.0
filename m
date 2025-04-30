Return-Path: <cgroups+bounces-7947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0FAA47BB
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E319117CA38
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D1236421;
	Wed, 30 Apr 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dieam/H3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kbsTSOfI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S0odmGrE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FsXnafmM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBD19048A
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007039; cv=none; b=my0/rCtyhjOA88TnxiIIuWbwSQkNmfLCtFOW57izmClLWHPOnEFRz+UxBp/gXKBss2kmVmNWM0xTkUl35HarOelXE6QPcdWelpq3TRowUdziOVSxL8k8MnAg07+kUHjJ27bqTXwfAQdTl1+C+h1tLM8bt1kRMvlLdFJDxUDxEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007039; c=relaxed/simple;
	bh=2N/gZ2xEz4587NZSPxfEBAB/1ICXtlQSDrPwawJJivE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBwFlQZksV12GMbpF3sDS7fL7SOrzouK32K4SslMK+DR+JS2BK5I8waGx53PE5SRNcqKuzFk0UlSIJ710MPYTu6VQnmHQFrhMywcz73phwwvmmQXtzz2g34v24Td6KV5SlzLLF3uwz2Q0nm7KgIBMhoQPFozF/jQG5aS2UBId18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dieam/H3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kbsTSOfI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S0odmGrE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FsXnafmM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3C0C1F7BD;
	Wed, 30 Apr 2025 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHh1btTbSAA8CgjYdGISaW5MiMmd0VLCDwrfkvkSAU=;
	b=dieam/H3ocYHiQr07Lfty8bGaKeGdej3g3gXK4x56a5/WCu17ZxIdzdAgxcN2st1xKbAQL
	rQAkevx69JHnxdSLSzRC1NHgF/doKacmq5e4rPXtploYNjHuzIF/ZM2Mel+KgENpbCL7Ux
	E0lPJ5sCQMZKbrfD3Qy5hH7VzsP3t7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHh1btTbSAA8CgjYdGISaW5MiMmd0VLCDwrfkvkSAU=;
	b=kbsTSOfI1gx6O3dLXj96daBHGv1GOVwaqshDWb8bEKI/5zUqxwD/3jXPASE8FuoXQx9rrU
	bXADThEJUpXIhQDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHh1btTbSAA8CgjYdGISaW5MiMmd0VLCDwrfkvkSAU=;
	b=S0odmGrElF8esTIguluV7jCAIbKgwRJaPPcTdAB2R8Jlg1F9I/jFR8tj11LnvrPBqn5V4K
	McsCYKW/+a5XqgyVJXX979ZPOgs+eTXERcKd851mRYzqz7WMYpFJtM3GvksDaEi7SE1k+n
	l8QxvIV+Yb6r2Qu6AKFBOxuEQokcrtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHh1btTbSAA8CgjYdGISaW5MiMmd0VLCDwrfkvkSAU=;
	b=FsXnafmMc971EpWD+JvgNQbDsYWK+pu39zsiI8otOFBph3Y6o7zqYQ+tauYRw+ADQQ6I+w
	uvUKofsz++0l40Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9A14139E7;
	Wed, 30 Apr 2025 09:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D120NPnzEWh4LQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 09:57:13 +0000
Message-ID: <f3e0c710-0815-44ad-844c-0e8a079bf663@suse.cz>
Date: Wed, 30 Apr 2025 11:57:13 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Soheil Hassas Yeganeh
 <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,linux.dev:email,oom.group:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/16/25 20:02, Shakeel Butt wrote:
> Memory cgroup accounting is expensive and to reduce the cost, the kernel
> maintains per-cpu charge cache for a single memcg. So, if a charge
> request comes for a different memcg, the kernel will flush the old
> memcg's charge cache and then charge the newer memcg a fixed amount (64
> pages), subtracts the charge request amount and stores the remaining in
> the per-cpu charge cache for the newer memcg.
> 
> This mechanism is based on the assumption that the kernel, for locality,
> keep a process on a CPU for long period of time and most of the charge
> requests from that process will be served by that CPU's local charge
> cache.
> 
> However this assumption breaks down for incoming network traffic in a
> multi-tenant machine. We are in the process of running multiple
> workloads on a single machine and if such workloads are network heavy,
> we are seeing very high network memory accounting cost. We have observed
> multiple CPUs spending almost 100% of their time in net_rx_action and
> almost all of that time is spent in memcg accounting of the network
> traffic.
> 
> More precisely, net_rx_action is serving packets from multiple workloads
> and is observing/serving mix of packets of these workloads. The memcg
> switch of per-cpu cache is very expensive and we are observing a lot of
> memcg switches on the machine. Almost all the time is being spent on
> charging new memcg and flushing older memcg cache. So, definitely we
> need per-cpu cache that support multiple memcgs for this scenario.
> 
> This patch implements a simple (and dumb) multiple memcg percpu charge
> cache. Actually we started with more sophisticated LRU based approach but
> the dumb one was always better than the sophisticated one by 1% to 3%,
> so going with the simple approach.
> 
> Some of the design choices are:
> 
> 1. Fit all caches memcgs in a single cacheline.
> 2. The cache array can be mix of empty slots or memcg charged slots, so
>    the kernel has to traverse the full array.
> 3. The cache drain from the reclaim will drain all cached memcgs to keep
>    things simple.
> 
> To evaluate the impact of this optimization, on a 72 CPUs machine, we
> ran the following workload where each netperf client runs in a different
> cgroup. The next-20250415 kernel is used as base.
> 
>  $ netserver -6
>  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> number of clients | Without patch | With patch
>   6               | 42584.1 Mbps  | 48603.4 Mbps (14.13% improvement)
>   12              | 30617.1 Mbps  | 47919.7 Mbps (56.51% improvement)
>   18              | 25305.2 Mbps  | 45497.3 Mbps (79.79% improvement)
>   24              | 20104.1 Mbps  | 37907.7 Mbps (88.55% improvement)
>   30              | 14702.4 Mbps  | 30746.5 Mbps (109.12% improvement)
>   36              | 10801.5 Mbps  | 26476.3 Mbps (145.11% improvement)
> 
> The results show drastic improvement for network intensive workloads.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

See below

> ---
>  mm/memcontrol.c | 128 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 91 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ad326e871c1..0a02ba07561e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1769,10 +1769,11 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>  	pr_cont(" are going to be killed due to memory.oom.group set\n");
>  }
>  
> +#define NR_MEMCG_STOCK 7
>  struct memcg_stock_pcp {
>  	local_trylock_t stock_lock;
> -	struct mem_cgroup *cached; /* this never be root cgroup */
> -	unsigned int nr_pages;
> +	uint8_t nr_pages[NR_MEMCG_STOCK];
> +	struct mem_cgroup *cached[NR_MEMCG_STOCK];

I have noticed memcg_stock is a DEFINE_PER_CPU and not
DEFINE_PER_CPU_ALIGNED so I think that the intended cacheline usage isn't
guaranteed now.

Actually tried compiling and got in objdump -t vmlinux:

ffffffff83a26e60 l     O .data..percpu  0000000000000088 memcg_stock

AFAICS that's aligned to 32 bytes only (0x60 is 96) bytes, not 64.

changing to _ALIGNED gives me:

ffffffff83a2c5c0 l     O .data..percpu  0000000000000088 memcg_stock

0xc0 is 192 so multiple of 64, so seems to work as intended and indeed
necessary. So you should change it too while adding the comment.

>  	struct obj_cgroup *cached_objcg;
>  	struct pglist_data *cached_pgdat;

