Return-Path: <cgroups+bounces-16180-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LHZCgdID2ptIgYAu9opvQ
	(envelope-from <cgroups+bounces-16180-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:59:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D48185AAB14
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52B9A30805A4
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E693C4155;
	Thu, 21 May 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtJKinXs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010C384CED
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384520; cv=none; b=KYVkuzkjThf8ZKCU727ZQ/kJbLpPPld59zf8FJ6piwLC6Pk+OH5w4aKUnwC44Uh7Vgfeqq/2L1ZODQ5yzfQ5EVz8w9VXoYQ0Hi0fpfPpllOYRjIDw/vY11sSl+pVm3q1Y9sJHjacA/P+yci5hsBujarB7KSn+i8REvpJ2qbohpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384520; c=relaxed/simple;
	bh=/Y4JOjqiWrH99jRT/1kQW4MKozhFjKKnxjBVmamwLAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bibUBB1VWUL2sCquImDw/+weAjIwHoCw8fcqsNG3C4MxKJUvWCBSTDcmar+yxnlu9pST9epfMhxrCN3i5IXscRigla54HYi9O6W8vXdWVVw/fsx4+/jDFFUzIsFJWUVwkOv0Z8DfvDO6srGshW00N6CbM9GSHjbSbGqJmAfT1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtJKinXs; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 May 2026 10:28:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779384516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMh0FfyEhpzP/o6+/cG0EuYR7BrwDmTdRcZFskTN7I0=;
	b=gtJKinXsA+PvoLRM/qYCELyTzZ8blaZkWqvMW4qMo4oYOD2Y0aCv/YPNS9HYL2paKJgsak
	UCJngQ0G3V1bmIDRcrnrS9n2pZzZd/MUkrgqnDwcIL9sCdEZXgRDTF0RiTkwZnvG+ZxdjK
	TFDeQo9NvtXo5wql6LmmFsA8m73X9Sk=
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
Subject: Re: [PATCH 4/8] mm: memcontrol: track MEMCG_KMEM per NUMA node
Message-ID: <ag9AY2SrcsE1B3Ti@linux.dev>
References: <20260511202136.330358-1-alex@ghiti.fr>
 <20260511202136.330358-5-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511202136.330358-5-alex@ghiti.fr>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16180-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: D48185AAB14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 10:20:39PM +0200, Alexandre Ghiti wrote:
> This patch gets rid of MEMCG_KMEM and wires all the "generic" functions
> by introducing per-node obj_cgroup objects.
> 
> Note that it does not convert the kmem users to proper per-memcg-per-node
> accounting now, this is done in upcoming patches.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  include/linux/memcontrol.h | 23 ++++++++++----
>  include/linux/mmzone.h     |  1 +
>  mm/memcontrol.c            | 64 ++++++++++++++++++++++++--------------
>  mm/vmstat.c                |  1 +
>  4 files changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 568ab08f42af..17cf823160e4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -35,7 +35,6 @@ enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
> -	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
>  	MEMCG_ZSWAP_INCOMP,
> @@ -126,9 +125,10 @@ struct mem_cgroup_per_node {
>  	struct list_head objcg_list;
>  
>  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
> -	/* slab stats for nmi context */
> +	/* slab and kmem stats for nmi context */
>  	atomic_t		slab_reclaimable;
>  	atomic_t		slab_unreclaimable;
> +	atomic_t		kmem;
>  #endif
>  };
>  
> @@ -190,6 +190,7 @@ struct obj_cgroup {
>  		struct rcu_head rcu;
>  	};
>  	bool is_root;
> +	int nid;
>  };
>  
>  /*
> @@ -254,10 +255,6 @@ struct mem_cgroup {
>  	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
>  	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
>  
> -#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
> -	/* MEMCG_KMEM for nmi context */
> -	atomic_t		kmem_stat;
> -#endif
>  	/*
>  	 * Hint of reclaim pressure for socket memroy management. Note
>  	 * that this indicator should NOT be used in legacy cgroup mode
> @@ -776,6 +773,20 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  		percpu_ref_put(&objcg->refcnt);
>  }
>  
> +static inline struct obj_cgroup *obj_cgroup_get_nid(struct obj_cgroup *objcg,
> +						    int nid)
> +{
> +	struct obj_cgroup *nid_objcg;
> +	struct mem_cgroup *memcg;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	nid_objcg = rcu_dereference(memcg->nodeinfo[nid]->objcg);
> +	rcu_read_unlock();
> +
> +	return nid_objcg;

What is guarating the life of nid_objcg?


