Return-Path: <cgroups+bounces-12574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68293CD4C76
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5282D300529D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBF214A8B;
	Mon, 22 Dec 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzcukW13"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B186347
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384179; cv=none; b=rbZiyDCMxQiFc/zmz7iXnkBdlajyFdzLxyOfZ2exRGgLSSzOET1nK8lte3OSIM2MKcW2Nc5GFzX2JzILMuK9c1kfi/r4+eDI7qzgbKD4U3nhBHHftGFS3ZyOzYVDP6J+lEqpybPZgKTZkMdb5ZQAOd3lRo3xhTelYp6PNOVKAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384179; c=relaxed/simple;
	bh=qJppBJsOhFIxTOsK1hS7LDo+QmNejh8ZeARb+OCK24c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As53/0cDcwWqwWaoxGyUrwyjEKe5AxzQIIcXA0GhMG6S7I2/vdaFvEcK3dW5xdvesKQNGn0LhucITBlW/FKr+xoHuwnTpdN3YXilYLHv6ZTkmSh/NWA2wAGfkGXPfu9wXWfz4pI1fZHN6rqaS/rrIJP84Kc5GX8L8RFg0pTxCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzcukW13; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so419765ad.1
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 22:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766384177; x=1766988977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKlYwDKHeLnktmF0WJtLvL/mlQQWgFKsDt5lGymxEgs=;
        b=uzcukW13mDPkoHELudtX0Gsn7hTL6pL6Bj7DEOLZk7Cqz/raQ0+n1zA1TgjBB4Hus1
         I2CunPoUritJ/5tcnezRmZ5EedK8eWLGXRsbRdHtH/C0rC5Yv5nf8/YqgeO4/SCJPhex
         SE1/lxyDsBXmgmRFBzzc4RVkLXWkGXQHZU4ddQU/PbTLKA/gAKT4Gl2LJGIlN1MrfJiA
         DNSb+yL/U+C/b0ZelLgiZsBDih1iaiPVFKyBzTvulMMTQ/tnfkTrX+H+8UR7k4QqYiQM
         MXRfA1ZZB/1spOKpWhUAjviv8gxab/i3q7rpZ9bHn84eDQIlwc0n8J308U6iySa9nLDl
         9sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766384177; x=1766988977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKlYwDKHeLnktmF0WJtLvL/mlQQWgFKsDt5lGymxEgs=;
        b=PsggMJxHwYz1lB7zQbi3jDEXqbXmk0+WUrwgyV9wAYs0HThOrQ9IHC3/w45sNrzJnV
         jkWo+bo+XQCmQl0eLM36U2YHnhd05gN/5jU6O/Cya44yzcBSRxVO2YuBDdqJ+SNI2sfs
         hliIvJavUDoNafRgHhaYhYjwExZGBaN/rIMd9YUcA8iw1fHd3pXTDmUehdWG+oFmTdNr
         nNz4tliRuGEM9wGGK7bknM/0cmkzVuYK7MeLIjlo+Eo0+AHFpU/F7wNKfAULS7Z+wIt5
         l6vtW9SRYdZzWA2Ge3hePHrRsDSKwdKyJbIwEGdsHRT6mkWpCj9xF5I3Vw1wc8ipo+2D
         lgAw==
X-Forwarded-Encrypted: i=1; AJvYcCXuVbzjT95oGzciBwoGCiQWdaxNappHz+RRLcTLolpm7SBO4D10kTQlUbKFYKFU8sZKB/ZFst8h@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3wp3S2cz1gU9Tq6/R+/KL3/Lkn9t+OLIagRY4RFWfQTRTvPg
	8zBsoSPcm5EOqPMZqkVLTDleOAX8ZG0dVQSlYg9W9HaE6ehTpPeoS41HlOduLpGhEg==
X-Gm-Gg: AY/fxX5pn4UH8/T4tQxGHIv6RYmTdwvRB32PGtD/k6v3unUSD4ait0dDRgC/odZouUf
	MIWmHVZTEzPktgCyAKaqP91VXVfmCEK/OzwH14kyqZwybSvDx4BWdLAGBrfHUQ/IB44jUHmREbE
	9QtkEh/nB0G/JqlWNwy7dAL3Oo61NYrzE1SU6R0HNAYy9F9fRV0vKmN03nPLPkSuvN+8yQowNEY
	/kZZBHvcMndi73OJuOFvK/mzhJ3CkcZZ2Pu6qN0Mrqf87vY8ejYQz73zI4WjKdq8XnKr2BT04pw
	N3Wu5+9T/5iEMcKtzqDZmuX0yhGMp/cQ+K86Y74eq++tez93aGArzaOWDbs9LVvt2S+9ZawdvqB
	xqnZkqGQ8Dh/6qCKMHlWvvgo0+DJAfYKIc6CPM+OvNYqwHMCU5VnTgycNaSOHHUF6pocRIzW2qS
	dRjZ/Ej52Q96KdGl2Ttw4xBqAyh+MIj82ADEC6rDf0Tb04Trq8BSdt
X-Google-Smtp-Source: AGHT+IHOweUx0BGgzRR3Uc5xIVtiHnSb9Bezh6rOocQ9AsReM27o8TisrBOm2xsLcgOS2vYsn/Ffgg==
X-Received: by 2002:a17:902:ef47:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2a3142e92d0mr2719085ad.21.1766384176711;
        Sun, 21 Dec 2025 22:16:16 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f258sm9029528b3a.47.2025.12.21.22.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 22:16:16 -0800 (PST)
Date: Mon, 22 Dec 2025 06:16:10 +0000
From: Bing Jiao <bingjiao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, gourry@gourry.net, Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
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
Message-ID: <aUjiKmlLEitn2oHU@google.com>
References: <20251220061022.2726028-1-bingjiao@google.com>
 <20251220112044.ee858d2160f819e181598ce1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220112044.ee858d2160f819e181598ce1@linux-foundation.org>

On Sat, Dec 20, 2025 at 11:20:44AM -0800, Andrew Morton wrote:
> On Sat, 20 Dec 2025 06:10:21 +0000 Bing Jiao <bingjiao@google.com> wrote:
>
> > Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> > introduces the cpuset.mems_effective check and applies it to
> > can_demote().
>
> So we'll want
>
> 	Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
>
> in the changelog.
>
> > However, it does not apply this check in
> > demote_folio_list(), which leads to situations where pages are demoted
> > to nodes that are explicitly excluded from the task's cpuset.mems.
> >
> > To address the issue that demotion targets do not respect
> > cpuset.mem_effective in demote_folio_list(), implement a new function
> > get_demotion_targets(), which returns a preferred demotion target
> > and all allowed (fallback) nodes against mems_effective,
> > and update demote_folio_list() and can_demote() accordingly to
> > use get_demotion_targets().
>
> 7d709f49babc fist appeared in 6.16, so we must decide whether to
> backport this fix into -stable kernels, via a Cc:
> <stable@vger.kernel.org>.
>
> To make this decision it's best to have a clear understanding of the
> userspace visible impact of the bug.  Putting pages into improper nodes
> is undesirable, but how much does it affect real-world workloads?
> Please include in the changelog some words about this to help others
> understand why we should backport the fix.
>
> > Furthermore, update some supporting functions:
> >   - Add a parameter for next_demotion_node() to return a copy of
> >     node_demotion[]->preferred, allowing get_demotion_targets()
> >     to select the next-best node for demotion.
> >   - Change the parameters for cpuset_node_allowed() and
> >     mem_cgroup_node_allowed() from nid to nodemask * to allow
> >     for direct logic-and operations with mems_effective.
>
> If we do decide to backport the fix into earlier kernels then it's best
> to keep the patch as small and as simple as possible.  So non-bugfix
> changes such as these are best made via a second followup patch which
> can be merged via the normal -rc staging process.
>
Hi Andrew, thank you for the review and suggestions.

I hvae sent a patch v2 for the backport. However, I forgot to add
the CC:stable line. I will fix it in v3.

Best,
Bing

