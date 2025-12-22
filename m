Return-Path: <cgroups+bounces-12575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8ECD4CC5
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3303008E84
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD4327204;
	Mon, 22 Dec 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSw93O+x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86025322537
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384900; cv=none; b=SixajZSIrXcZAKWrm2XF4QvyfV+gQxjqVvKQe3M///Uml9HACGjNtfOFNPARXPjILqizZYv8tnOmkytklJ9v7bWcxojO45bMewkK/CfqJYa5j8A3axBa+8iVEe7TMRF4deEQ4bQN9jVdbn5L/eM4NUOBtPIBrlZtWXhCViwVkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384900; c=relaxed/simple;
	bh=cHKSEt6w87KvG06y5BsL51BdjywIv52WtqaL1tHcno0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez3FPP2/hxfPNyte9gi4mc1gLkgGXUjXgu7i+u9De2DzpXsjAzHbVChrHsFhdiguPreYEv4y8faFNunYNoDgC+lBzPHmxHGPvhdUOfHoHyFbMu4mmNZf+64s5D7F3M3t6LHZgAIefMv2ohcu7cGARYMwTFDOirkUtQV0XmNcBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSw93O+x; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a1462573caso463465ad.0
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 22:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766384898; x=1766989698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6EKpn0ruXbR1ixKSQLE2aTtzbC9UbYbxiiPAEQF07BY=;
        b=nSw93O+xgJ1RUUjvQSWNqRe2fYmQxd+HK4NVOfQw/vfzUOUh6o/D8j1oy2H9Gw+6YJ
         x54mmypOqfuTAg1NDzle2iXmb6JhGOJkpzu+1XkaljsWKxqhigUW/lAKVo4eLUeYBi93
         ibbDttqZaEJzkD2tJ/oVaaiFFKO1WH5epbmgh6jejfbq2e/IjU1T8iwzpFhDKrH1TRFm
         sqktugbqqlRPFZkcoSEdydsu3Ta0ex8njuXnM1m+RNVl/fIWmoNBQpNNIvpYZNCCtNgn
         ZC1Fr3ByzRMy+Ysir2l/SHgB1x7oWrYjI01N+Xa5b9PDajmZdsbVxvVX26T1rqbwNB9r
         wPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766384898; x=1766989698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EKpn0ruXbR1ixKSQLE2aTtzbC9UbYbxiiPAEQF07BY=;
        b=gVf+nESqrNsLEbn5821PwInNSRDfRvf0NPaCYUfzHMa+hxs6bCBtELhH9oW7QLtCPW
         se0/8aZYGW7V1oUqE3OF6YR830KWXnGrLFkicx5vK8gat7kBJt7vqWRzorkESyhnFb45
         qTi03xfahdMxQr9dT2y6nb4PdUtmMaapv5PdylfKyoyYV8601HhKG/50cf5topF1QMrp
         OeV0RrFIyo9ugrlvKFI2+eczdqCccxBwz931J+HxJNHv+0uW3HsGPt5rpPlxR58Qdjjf
         GkDONzvv2zGbFmZ9yecujodA3rhaL4qBU476JRzZVTvDCtQ7Sxc/u5w2HIzmkkyxVDt5
         +/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVl5MdEj9y9W0wxVL1IAsjWnOUhlQf6xxlmUjJuhqtxVvl5mIa6iY3eIfd8PEmoQyP/P98Rz3fb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zBs4LgMa90rCU+6YjL0VJjweRlfn618CfL6oexn6KnfyaT6P
	ZrqatrPD1owd/ETMgUnD0zCV/vNquYURnTKv2IPw7QRRqk4xe1RNGIW69gmw9rBuUQ==
X-Gm-Gg: AY/fxX53fVSR6CPsOSimZLFo6h0kMqM/wi1mnA2GAueCIbJzwW5hMkjQHe51E7Huv8W
	hXiCWgWeIy+G4h8OXwyZJg/DTWXV3M52PAei3iA6a0B0o2jHzo53NnARMGaXahd5FAlpRmahtrp
	UvFLHc/5hFft9rwb51I3mEn4SH4zc1Gdq0F5czqpMNQc6IMmi9AGRg+VizC2mSmv+cvltNNZtWX
	dz3ODl3Tflmul09lnfB+M/UIkort98t+PZb9NSw706S5T/IcrdZpamCaWHOTHEIF/13kMAELifB
	TaPXWlUdTMVQJJVzO54hXbeyCgNiQQtFYrkmbLENJ6bDliuv9xrppaJ3ZelbqhZntKjo66oBuoc
	wq1R7ZiV6vNd/1chrWmPkHNOf53drB/1Rb2+6cGo1ScJ6ihxggJTgY4zVW4+c3miF4YlsXoY41M
	ZbJ7iFFOGKIdVbaPyE5fvzSqHGvhW3zFKXvyqvc4rH9ywaIG5NZb/L
X-Google-Smtp-Source: AGHT+IFzv/vr/XRa0szzJkljXT5iZKXsyKh/D3x+u69v9tdyxLoWzWyh+4/PEsydGYsKr59SAc9kkQ==
X-Received: by 2002:a17:903:144f:b0:2a0:867c:60e2 with SMTP id d9443c01a7336-2a3142c9dd6mr3031535ad.19.1766384897424;
        Sun, 21 Dec 2025 22:28:17 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d428sm85337225ad.73.2025.12.21.22.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 22:28:16 -0800 (PST)
Date: Mon, 22 Dec 2025 06:28:11 +0000
From: Bing Jiao <bingjiao@google.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <aUjk-yVw8ddRgZyN@google.com>
References: <20251220061022.2726028-1-bingjiao@google.com>
 <aUfi9gn5HS4u4ShU@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUfi9gn5HS4u4ShU@gourry-fedora-PF4VCD3F>

On Sun, Dec 21, 2025 at 07:07:18AM -0500, Gregory Price wrote:
>
> I think this patch can be done without as many changes as proposed here.
>
> > -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> > +void mem_cgroup_node_allowed(struct mem_cgroup *memcg, nodemask_t *nodes);
>
> > -static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> > +static inline void mem_cgroup_node_allowed(struct mem_cgroup *memcg,
>
> > -int next_demotion_node(int node);
> > +int next_demotion_node(int node, nodemask_t *mask);
>
> > -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > +void cpuset_node_allowed(struct cgroup *cgroup, nodemask_t *nodes)
>
> These are some fairly major contract changes, and the names don't make
> much sense as a result.
>
> Would be better to just make something like
>
> /* Filter the given nmask based on cpuset.mems.allowed */
> mem_cgroup_filter_mems_allowed(memg, nmask);
>
> (or some other, better name)
>
> separate of the existing interfaces, and operate on one scratch-mask if
> possible.
>

Hi Gregory, thank you for the review and suggestions.

I have divided these changes into 2 patches based on your suggestions.
Since mem_cgroup_node_allowed() and cpuset_node_allowed() are dangling,
they are removed in v2 2/2.

> > +static int get_demotion_targets(nodemask_t *targets, struct pglist_data *pgdat,
> > +				struct mem_cgroup *memcg)
> > +{
> > +	nodemask_t allowed_mask;
> > +	nodemask_t preferred_mask;
> > +	int preferred_node;
> > +
> > +	if (!pgdat)
> > +		return NUMA_NO_NODE;
> > +
> > +	preferred_node = next_demotion_node(pgdat->node_id, &preferred_mask);
> > +	if (preferred_node == NUMA_NO_NODE)
> > +		return NUMA_NO_NODE;
> > +
> > +	node_get_allowed_targets(pgdat, &allowed_mask);
> > +	mem_cgroup_node_allowed(memcg, &allowed_mask);
> > +	if (nodes_empty(allowed_mask))
> > +		return NUMA_NO_NODE;
> > +
> > +	if (targets)
> > +		nodes_copy(*targets, allowed_mask);
> > +
> > +	do {
> > +		if (node_isset(preferred_node, allowed_mask))
> > +			return preferred_node;
> > +
> > +		nodes_and(preferred_mask, preferred_mask, allowed_mask);
> > +		if (!nodes_empty(preferred_mask))
> > +			return node_random(&preferred_mask);
> > +
> > +		/*
> > +		 * Hop to the next tier of preferred nodes. Even if
> > +		 * preferred_node is not set in allowed_mask, still can use it
> > +		 * to query the nest-best demotion nodes.
> > +		 */
> > +		preferred_node = next_demotion_node(preferred_node,
> > +						    &preferred_mask);
> > +	} while (preferred_node != NUMA_NO_NODE);
> > +
>
> What you're implementing here is effectively a new feature - allowing
> demotion to jump nodes rather than just target the next demotion node.
>
> This is nice, but it should be a separate patch proposal (I think Andrew
> said something as much already) - not as part of a fix.
>

Thanks for the suggestion.

I sent a v2 patch series for fixes and backport. This function (jump
node) will be sent in another thread for distinguishing between fixes
and features.

> > +	/*
> > +	 * Should not reach here, as a non-empty allowed_mask ensures
> > +	 * there must have a target node for demotion.
>
> Does it? What if preferred_node is online when calling
> next_demotion_node(), but then is offline when
> node_get_allowed_targets() is called?
>
>
> > +	 * Otherwise, it suggests something wrong in node_demotion[]->preferred,
> > +	 * where the same-tier nodes have different preferred targets.
> > +	 * E.g., if node 0 identifies both nodes 2 and 3 as preferred targets,
> > +	 * but nodes 2 and 3 themselves have different preferred nodes.
> > +	 */
> > +	WARN_ON_ONCE(1);
> > +	return node_random(&allowed_mask);
>
> Just returning a random allowed node seems like an objectively poor
> result and we should just not demote if we reach this condition. It
> likesly means hotplug was happening and node states changed.
>
> > @@ -1041,10 +1090,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
> >  	if (list_empty(demote_folios))
> >  		return 0;
> >
> > +	target_nid = get_demotion_targets(&allowed_mask, pgdat, memcg);
> >  	if (target_nid == NUMA_NO_NODE)
> >  		return 0;
> > -
> > -	node_get_allowed_targets(pgdat, &allowed_mask);
>
> in the immediate fixup patch, it seems more expedient to just add the
> function i described above
>
> /* Filter the given nmask based on cpuset.mems.allowed */
> mem_cgroup_filter_mems_allowed(memg, nmask);
>
> and then add that immediate after the node_get_allowed_targets() call.
>
> Then come back around afterwards to add the tier/node-skip functionality
> from above in a separate feature patch.
>
> ~Gregory
>

Thanks for the hit. I had never considered hot-swapping before.

> ---
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae5ba..1971a8d9475b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1046,6 +1046,11 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>
>         node_get_allowed_targets(pgdat, &allowed_mask);
>
> +       /* Filter based on mems_allowed, fail if the result is empty */
> +       mem_cgroup_filter_nodemask(memcg, &allowed_mask);
> +       if (nodes_empty(allowed_mask))
> +               return 0;
> +
>         /* Demotion ignores all cpuset and mempolicy settings */
>         migrate_pages(demote_folios, alloc_demote_folio, NULL,
>                       (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>
>

Thanks for the code. My v2 1/2 is based on your suggestion with
some changes.

Best,
Bing

