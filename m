Return-Path: <cgroups+bounces-5878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E09F00CF
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26734163C05
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363E629;
	Fri, 13 Dec 2024 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLU7cSnH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED15747F
	for <cgroups@vger.kernel.org>; Fri, 13 Dec 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049952; cv=none; b=eRnzPI6TxbAbyxsxW8SXACydDhI4VjpK1+kMOqxRi/FQzcWuGGZ+5edYp4kdi+kSy6tNGZlbQHzmTCCQqoJaJsCypFv2fU9Vg07t2//JhMxr1yIr0If636SRzfNMFLqBRUQN0dtOrjg4EO1OYFjHHxgYMZQgTkuJ6yy0ni+c1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049952; c=relaxed/simple;
	bh=BfVTrwEqJVsAzuYSQNr/nFw3NLP4gp9VxIZBVAEU5Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1yzdn3LDar5Cgpazv37NmuQTSZH+iQjaUTAnZMLD8wzUPl96+oRfXvT08nnz2KhFVD/vQUGWQOFQl/oPxC6zfSpYDobAyOLXw40ba4pHWwE37e6r2TTh0UrEpQKYLJ8m8hOYUoYSy/NP59wDxsHxhgl0ofChV3H3vBLP1vTOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLU7cSnH; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Dec 2024 00:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734049936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDknTbX0Ls82zv0uHrNtgXqzSCQIM2ghtBvYdeKv+Ws=;
	b=lLU7cSnHl5hgYCbx0CoAIPaOKjm+s5hEdfw7h7d+6hVK6j9BxfsJjHyh4fT+jSKdtqz9Ky
	JxNXRsAum8+QyuhJSzw1mIKgOhgqq7N6IPh7bAsgyhXcBDT0H5Dsmajsk+OoauC7Vqnqb9
	o3NePYZKtuvcu52Pcoa/rER4oFcj3n8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z1uAi0syiPY7h6wt@google.com>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212183012.GB1026@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 01:30:12PM -0500, Johannes Weiner wrote:
> On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> > On Thu, Dec 12, 2024 at 8:58 AM Rik van Riel <riel@surriel.com> wrote:
> > >
> > > A task already in exit can get stuck trying to allocate pages, if its
> > > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > > zswap writeback is enabled, and the remaining memory in the cgroup is
> > > not compressible.
> > >
> > > This seems like an unlikely confluence of events, but it can happen
> > > quite easily if a cgroup is OOM killed due to exceeding its memory.max
> > > limit, and all the tasks in the cgroup are trying to exit simultaneously.
> > >
> > > When this happens, it can sometimes take hours for tasks to exit,
> > > as they are all trying to squeeze things into zswap to bring the group's
> > > memory consumption below memory.max.
> > >
> > > Allowing these exiting programs to push some memory from their own
> > > cgroup into swap allows them to quickly bring the cgroup's memory
> > > consumption below memory.max, and exit in seconds rather than hours.
> > >
> > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > 
> > Thanks for sending a v2.
> > 
> > I still think maybe this needs to be fixed on the memcg side, at least
> > by not making exiting tasks try really hard to reclaim memory to the
> > point where this becomes a problem. IIUC there could be other reasons
> > why reclaim may take too long, but maybe not as pathological as this
> > case to be fair. I will let the memcg maintainers chime in for this.
> > 
> > If there's a fundamental reason why this cannot be fixed on the memcg
> > side, I don't object to this change.
> > 
> > Nhat, any objections on your end? I think your fleet workloads were
> > the first users of this interface. Does this break their expectations?
> 
> Yes, I don't think we can do this, unfortunately :( There can be a
> variety of reasons for why a user might want to prohibit disk swap for
> a certain cgroup, and we can't assume it's okay to make exceptions.
> 
> There might also not *be* any disk swap to overflow into after Nhat's
> virtual swap patches. Presumably zram would still have the issue too.
> 
> So I'm also inclined to think this needs a reclaim/memcg-side fix. We
> have a somewhat tumultous history of policy in that space:
> 
> commit 7775face207922ea62a4e96b9cd45abfdc7b9840
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Tue Mar 5 15:46:47 2019 -0800
> 
>     memcg: killed threads should not invoke memcg OOM killer
> 
> allowed dying tasks to simply force all charges and move on. This
> turned out to be too aggressive; there were instances of exiting,
> uncontained memcg tasks causing global OOMs. This lead to that:
> 
> commit a4ebf1b6ca1e011289677239a2a361fde4a88076
> Author: Vasily Averin <vasily.averin@linux.dev>
> Date:   Fri Nov 5 13:38:09 2021 -0700
> 
>     memcg: prohibit unconditional exceeding the limit of dying tasks
> 
> which reverted the bypass rather thoroughly. Now NO dying tasks, *not
> even OOM victims*, can force charges. I am not sure this is correct,
> either:
> 
> If we return -ENOMEM to an OOM victim in a fault, the fault handler
> will re-trigger OOM, which will find the existing OOM victim and do
> nothing, then restart the fault. This is a memory deadlock. The page
> allocator gives OOM victims access to reserves for that reason.
> 
> Actually, it looks even worse. For some reason we're not triggering
> OOM from dying tasks:
> 
>         ret = task_is_dying() || out_of_memory(&oc);
> 
> Even though dying tasks are in no way privileged or allowed to exit
> expediently. Why shouldn't they trigger the OOM killer like anybody
> else trying to allocate memory?
> 
> As it stands, it seems we have dying tasks getting trapped in an
> endless fault->reclaim cycle; with no access to the OOM killer and no
> access to reserves. Presumably this is what's going on here?
> 
> I think we want something like this:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 53db98d2c4a1..be6b6e72bde5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1596,11 +1596,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (mem_cgroup_margin(memcg) >= (1 << order))
>  		goto unlock;
>  
> -	/*
> -	 * A few threads which were not waiting at mutex_lock_killable() can
> -	 * fail to bail out. Therefore, check again after holding oom_lock.
> -	 */
> -	ret = task_is_dying() || out_of_memory(&oc);
> +	ret = out_of_memory(&oc);

I like the idea, but at first glance it might reintroduce the problem
fixed by 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer").

