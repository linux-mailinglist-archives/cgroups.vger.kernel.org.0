Return-Path: <cgroups+bounces-5874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7919EFE5C
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D7C188D7C5
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA81D9A79;
	Thu, 12 Dec 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hhhrsyp1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28CA19995A
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039338; cv=none; b=CpV7c8HOIv2nHTj74m4ZCITOfi88zqF5nrIRf1e0OFHlL2Kb9A3zmUQznI6RlSCzJnK3oNDwRc00VrthbqjWykl29tQHo82wnGua6gwIPboyXGzpA2JXXK7SGJIvua0ktqRf1oEG16c9NZvb+O2DtTdTkw9PQtSiaw30wg7JylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039338; c=relaxed/simple;
	bh=hzCiwrHqJ21y8kwUGY8vexTsLsKijmMYrnTSg0AQTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAU8qx+iIveDEw7dPO19epz3Slai3+aI+q5MDN8RyWkKEdM9Ums539o/iw4eaG0cGi5qEnxVPoeyDramcbY0Pf0ZHm6ELZ0fBypRPYL9oc8WOuwbwoU7DtixnkfNPVxEDl+dfkvXmgY3Skq2H6eM45IBervCzcVUn0tsUOEqWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hhhrsyp1; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 12 Dec 2024 13:35:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734039332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9LCAsrG2v3sr11vxtTgPaYAQ3cbRB7r/yjBqH3E80c=;
	b=Hhhrsyp1EVV0VY+VzT9YVcEva2u9oBERN0zCU87WwGAMHnBk0CPrBSw31IHWdSLofPO6h+
	EDzXg4V/9M20/KmJxWSVw9pJxHxU3s+m0esGx3CBJbNZn+PRM3sNShj4z4BAvrOwV0jBJ0
	Lh4LTjgodia5R0d+aF8f/Z2uYb5jW9w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>, 
	Balbir Singh <balbirs@nvidia.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <pr5llphyxbbvv3fgn63crohd7y3vsxdif2emst2ac2p3qvkeg6@ny7d43mgmp3k>
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

Very good points.

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

This is a very good point and actually out_of_memory() will mark the
dying process as oom victim and put it in the oom reaper's list which
should help further in such situation.

> 
> As it stands, it seems we have dying tasks getting trapped in an
> endless fault->reclaim cycle; with no access to the OOM killer and no
> access to reserves. Presumably this is what's going on here?
> 
> I think we want something like this:

The following patch looks good to me. Let's test this out (hopefully Rik
will be able to find a live impacted machine) and move forward with this
fix.

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
>  
>  unlock:
>  	mutex_unlock(&oom_lock);
> @@ -2198,6 +2194,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (unlikely(current->flags & PF_MEMALLOC))
>  		goto force;
>  
> +	if (unlikely(tsk_is_oom_victim(current)))
> +		goto force;
> +
>  	if (unlikely(task_in_memcg_oom(current)))
>  		goto nomem;
>  

