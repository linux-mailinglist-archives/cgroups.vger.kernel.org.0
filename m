Return-Path: <cgroups+bounces-12556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C972ACD3FE3
	for <lists+cgroups@lfdr.de>; Sun, 21 Dec 2025 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE3C300C5E7
	for <lists+cgroups@lfdr.de>; Sun, 21 Dec 2025 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83C2F83B7;
	Sun, 21 Dec 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LdnxOv0R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503022D12F3
	for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318879; cv=none; b=kPHjjqMAMoU0W1dQCxL7YPxtXscgwbQ7d87suVj28vhcIvSuUThHOd+Z+TUp70q6PkGjIt4npKX0dsSr6NfTQpBYcb4d0Bd3r5oAH4MK1oWP9ALtSwTOQKXYN+gkZb437VKVMKJ4X9bgM+hvEaEkNpPRa71Kgh7GHUD79PIBPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318879; c=relaxed/simple;
	bh=LYDfTSibOB1avS3PUEI0o+L15I/Ok+QT8hDdTTqDFDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMe3RTy8gDEB34gVYlDxXFRLnbxORTwx/IKs+rtvquJItjrgC2Te/Lp1QADnO1NLXQMHx3xmumYgKVq8/LjjfBoqlZIm5pE4bIHw2CHeeYItx2DK5aBwvzoe+74TamdoOIKAP0VwVbmwh3os2tioypHIVq19obLJCTommi/lVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LdnxOv0R; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so1061026d6.2
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766318876; x=1766923676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImyYpBYHczXKmZOJ0nv2yp1b5vTgB4LNV5Y2WhaumNQ=;
        b=LdnxOv0Rdx+pBkPZl/2D5V4KWsj0HGTqmpUfCjhp88dBKpdxE6JOP0aY6gN0XFS/aK
         o3MiVpHLPjlpKX7IFCVyCyTRerxKj/o7JcY9CiMk+kUD3JHHgUMyGMLbJMVpR0pIX0qc
         RYzoMxr73HYBnyX7xhyhNuPxY38D9eZXJX1/nXwPlkFzRuscxetn212pBQHS3wJ0shnC
         WrQ2kdIKExVZaYXP21FtZIC5T2nb4uBv/ZSWC/sm+Jw2dfhADu1gjLTQDNmVvIcBnu2A
         tnYrv7MyuCKdJXAlOfGYk4HrfHaklcczgVo7yFl166eZl65NrUvBpY15QBVCbE6kZSw8
         5XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766318876; x=1766923676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImyYpBYHczXKmZOJ0nv2yp1b5vTgB4LNV5Y2WhaumNQ=;
        b=oeQHzFcSlfZeRCg6LaNnYZBpPtmUJCMCI1DLlIF8js0OJGshG/NsK+37XbeRDKF2XD
         wQxlWu3Rsoe3DQBJKCkfwhB8gydABUamhUSxWzdmKVxTQS42OuI4aQPr9nP4QPws4GcJ
         kQM/M3O4v1TA2jdPeLOjXjDXvZPFsxVDHFvtxSmx76XERcj3HG8OSK/f1BQ2kgbyQgNx
         M/FROwI+wUeHZGaWpI35nF7xngkYYsSjCJagRbV8Xrj6Okg6FVVeP1ZiuQxVkfr4self
         RFcjCu5/BHEiDMRsDZHhEeVobBWSkpXVSz4eXx0R8wDx/3S63TxuW+drof5maHABf18V
         8f9w==
X-Forwarded-Encrypted: i=1; AJvYcCWNR26QUXBD8B0N0I/N+mxWV8B2ijrIngF4ERD+eH5jMajMKVRMZ0e+Izndk6bjSZEnKEa2wwSn@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmUYSLPGsFGPFpx9je5+8awhcU5qW3iSO29Ve4l/hRGyudwF8
	/oIvGf+AtMUOcQ9psheTarDh5s+ypngIDLUG3hSWwRaj0Ut6WJgaWlYKSCImfUu3VN8=
X-Gm-Gg: AY/fxX7dj7zo2HQcUdSlCmdIap1FV8Q/MqbGv2lR7jYh0NJnvjyPoR9IbBZeUqXgbT9
	TJyR8BK01FAdxgbbSlnYUyE9mgsDEJEe37/Adti2gtuVp3fAstUjgkJo1NUjaeIa1zd3aQJk2FI
	/uscqKw5obn3EnwPgWai6tBXVmRCmHb0Z44cJ6j30M/pp7fGGCqLpDB8enJaVRaJChNgTTE6mqo
	By4JII7bWKcev2piMWIoCDrU7paBzLOGxSPNfirSO9Le14z48OQyIPfax747pQZwaTatYus+suI
	6e9oZvpfu3q/eagKIFY+2V4tbG4uVrlfvs1LQZ68JzBon1Jz6Id/v0/QEP8hEM1TPyTz8NehsQs
	ZljpP44IboldlMtUR5aYl3GU7OocsSoVxe/3m8ydFbY5JArNhXS5VuVqeD1U6CqC6qbx8/b7d5J
	kGvTKGpNy8zst1LRXF9tX9/C7OGxzkqdFls1YDSR0W5lcp5z6XxNfuFv8T8+zwTV96RD43WA==
X-Google-Smtp-Source: AGHT+IFGNtL1aIwg3HtHmwchYyREfgUlw6VeYgEwe39zkib/ur8gNePpkMwSQGbagQRqT8PUrwoLJw==
X-Received: by 2002:a05:622a:1b29:b0:4ed:8264:91ba with SMTP id d75a77b69052e-4f4abd86bcamr105538801cf.58.1766318876084;
        Sun, 21 Dec 2025 04:07:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973ee011sm610870285a.38.2025.12.21.04.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 04:07:55 -0800 (PST)
Date: Sun, 21 Dec 2025 07:07:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: respect mems_effective in demote_folio_list()
Message-ID: <aUfi9gn5HS4u4ShU@gourry-fedora-PF4VCD3F>
References: <20251220061022.2726028-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220061022.2726028-1-bingjiao@google.com>


I think this patch can be done without as many changes as proposed here.

> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> +void mem_cgroup_node_allowed(struct mem_cgroup *memcg, nodemask_t *nodes);

> -static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +static inline void mem_cgroup_node_allowed(struct mem_cgroup *memcg,

> -int next_demotion_node(int node);
> +int next_demotion_node(int node, nodemask_t *mask);

> -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +void cpuset_node_allowed(struct cgroup *cgroup, nodemask_t *nodes)

These are some fairly major contract changes, and the names don't make
much sense as a result.

Would be better to just make something like

/* Filter the given nmask based on cpuset.mems.allowed */
mem_cgroup_filter_mems_allowed(memg, nmask);

(or some other, better name)

separate of the existing interfaces, and operate on one scratch-mask if
possible.

> +static int get_demotion_targets(nodemask_t *targets, struct pglist_data *pgdat,
> +				struct mem_cgroup *memcg)
> +{
> +	nodemask_t allowed_mask;
> +	nodemask_t preferred_mask;
> +	int preferred_node;
> +
> +	if (!pgdat)
> +		return NUMA_NO_NODE;
> +
> +	preferred_node = next_demotion_node(pgdat->node_id, &preferred_mask);
> +	if (preferred_node == NUMA_NO_NODE)
> +		return NUMA_NO_NODE;
> +
> +	node_get_allowed_targets(pgdat, &allowed_mask);
> +	mem_cgroup_node_allowed(memcg, &allowed_mask);
> +	if (nodes_empty(allowed_mask))
> +		return NUMA_NO_NODE;
> +
> +	if (targets)
> +		nodes_copy(*targets, allowed_mask);
> +
> +	do {
> +		if (node_isset(preferred_node, allowed_mask))
> +			return preferred_node;
> +
> +		nodes_and(preferred_mask, preferred_mask, allowed_mask);
> +		if (!nodes_empty(preferred_mask))
> +			return node_random(&preferred_mask);
> +
> +		/*
> +		 * Hop to the next tier of preferred nodes. Even if
> +		 * preferred_node is not set in allowed_mask, still can use it
> +		 * to query the nest-best demotion nodes.
> +		 */
> +		preferred_node = next_demotion_node(preferred_node,
> +						    &preferred_mask);
> +	} while (preferred_node != NUMA_NO_NODE);
> +

What you're implementing here is effectively a new feature - allowing
demotion to jump nodes rather than just target the next demotion node.

This is nice, but it should be a separate patch proposal (I think Andrew
said something as much already) - not as part of a fix.

> +	/*
> +	 * Should not reach here, as a non-empty allowed_mask ensures
> +	 * there must have a target node for demotion.

Does it? What if preferred_node is online when calling
next_demotion_node(), but then is offline when
node_get_allowed_targets() is called?


> +	 * Otherwise, it suggests something wrong in node_demotion[]->preferred,
> +	 * where the same-tier nodes have different preferred targets.
> +	 * E.g., if node 0 identifies both nodes 2 and 3 as preferred targets,
> +	 * but nodes 2 and 3 themselves have different preferred nodes.
> +	 */
> +	WARN_ON_ONCE(1);
> +	return node_random(&allowed_mask);

Just returning a random allowed node seems like an objectively poor
result and we should just not demote if we reach this condition. It
likesly means hotplug was happening and node states changed.

> @@ -1041,10 +1090,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	if (list_empty(demote_folios))
>  		return 0;
> 
> +	target_nid = get_demotion_targets(&allowed_mask, pgdat, memcg);
>  	if (target_nid == NUMA_NO_NODE)
>  		return 0;
> -
> -	node_get_allowed_targets(pgdat, &allowed_mask);

in the immediate fixup patch, it seems more expedient to just add the
function i described above

/* Filter the given nmask based on cpuset.mems.allowed */
mem_cgroup_filter_mems_allowed(memg, nmask);

and then add that immediate after the node_get_allowed_targets() call.

Then come back around afterwards to add the tier/node-skip functionality
from above in a separate feature patch.

~Gregory

---

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..1971a8d9475b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1046,6 +1046,11 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 
        node_get_allowed_targets(pgdat, &allowed_mask);
 
+       /* Filter based on mems_allowed, fail if the result is empty */
+       mem_cgroup_filter_nodemask(memcg, &allowed_mask);
+       if (nodes_empty(allowed_mask))
+               return 0;
+
        /* Demotion ignores all cpuset and mempolicy settings */
        migrate_pages(demote_folios, alloc_demote_folio, NULL,
                      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,



