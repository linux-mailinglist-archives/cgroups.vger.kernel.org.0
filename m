Return-Path: <cgroups+bounces-15802-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEtoDjNdAmosrgEAu9opvQ
	(envelope-from <cgroups+bounces-15802-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 00:50:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA1517160
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A36301AB89
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F682ED843;
	Mon, 11 May 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MsUw8y4N"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53E2C15A9
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539807; cv=none; b=i/YpAz6X6qdb5duZh2OZJgJlwizTZb7isUE/Hf1RfYOJGhcXKNfbsiWZSIeVaNJ4wDJjmYPkmYgdz7+ekEkkrrvGhBuGaK4Wl9CKkHMRuzrb1BIa1TYTwz88amXuClNno8bpWRsNVjiP6PwfJanRCIo0NxBIHnmypHGsWgSSvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539807; c=relaxed/simple;
	bh=iGvgaTLLs5OPISFAxddsJpSpxApeKH6hKSrrYQQ0LQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN214bhJlBm0qIi57opRASajynSpugCaWZU2wfVqU7EjtrT6U12ZKZdvdKgIC9a5GxLiu2SDtIeQnmKN2MntFpUeQaZpfqUk7o71w4R6UVLVykNWEj9f/oESGVdcJ1lJUbO9Yffxlj6Sjnfbdeu4avr1EnGwju9vM5piTKZ7xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MsUw8y4N; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 May 2026 15:49:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778539793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl7dNXWt7F9OqtH4+S7o9Rj18+0i9R6DqaVswvCUV9U=;
	b=MsUw8y4Nh1M1V2Emwy6pVbFE8hAHwOjgMp9bBEB+MhCxCaMAQFux5M9IU57jk5e9iWq++Z
	2wnAAnRmfW+Cfb7edlB/gWnQjwi1f4HtwGB6mlw9efep6OkJJE1f0RKSrR2NkFpBSqPqR/
	Wpop3HAstO13WDxuHAO51TqHpPo/Cvw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: memcontrol: propagate NMI slab stats to memcg
 vmstats
Message-ID: <agJYrraKk_wbHe07@linux.dev>
References: <20260511202136.330358-1-alex@ghiti.fr>
 <20260511202136.330358-2-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511202136.330358-2-alex@ghiti.fr>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 99FA1517160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15802-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ghiti.fr:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:20:36PM +0200, Alexandre Ghiti wrote:
> flush_nmi_stats() drains per-node NMI slab atomics into the per-node
> lruvec_stats, but does not propagate them to the memcg-level vmstats.
> 
> This is inconsistent with account_slab_nmi_safe() which updates both,

I think the above sentence needs clarification. Something like "For non nmi
case, account_slab_nmi_safe() calls mod_memcg_lruvec_state() which updates both
per-node lruvec_stats and memcg-level vmstats, so flush_nmi_stats() needs to
flush to per-node lruvec_stats as well as memcg-level vmstats but at the moment
the memcg-level vmstats flushing is missing. Fix that".

> so fix this by propagating the NMI slab stats to the memcg-level vmstats.
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/memcontrol.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..d81a76654b2c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4341,16 +4341,22 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
>  
>  			lstats->state[index] += slab;
> +			memcg->vmstats->state[index] += slab;
>  			if (plstats)
>  				plstats->state_pending[index] += slab;
> +			if (parent)
> +				parent->vmstats->state_pending[index] += slab;

Nit: please keep all three code lines additions together.

>  		}
>  		if (atomic_read(&pn->slab_unreclaimable)) {
>  			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
>  			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
>  
>  			lstats->state[index] += slab;
> +			memcg->vmstats->state[index] += slab;
>  			if (plstats)
>  				plstats->state_pending[index] += slab;
> +			if (parent)
> +				parent->vmstats->state_pending[index] += slab;

Same here.

>  		}
>  	}
>  }

With the commit message fixed and nits addressed, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

and thanks for catching this issue.


