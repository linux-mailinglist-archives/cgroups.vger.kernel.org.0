Return-Path: <cgroups+bounces-5914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703B9F34AF
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D751888133
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399B1494DC;
	Mon, 16 Dec 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQWQIoGN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E91494CF
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363558; cv=none; b=gjFGTpQI9gdKq3s/olwaduwRCy2vW0JL1+/6ad9kJ5WYPqh1/c3/WlGGA5JgvmBrF/Mr8Sxz1Tr7+143FsGcKzEDL4BYVjk+yQtAjY/Vx2uNzyrotyAGn5nv5mAe9MR5sOao+VVVi1SseozBbym0KcTwEpV0RRcQOO+bTlzJzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363558; c=relaxed/simple;
	bh=b6PN9Nh4fmOqeYnSlL9UJcIoOtZBnZueDxzv5gnseBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYw5EaeNBnXcX43x43Dv8K0kAoaE6en4+o/JWwkx42skV4e1d+TC6ECQ9TXbGm0XZyn+Aabc4vFVpVsI3409qHLj/2dh/tiSLG0T5O9z+0J5jjd0c3753+JCESue2ev3osCEvv1Pwc2pk6+Km9rQ2fLCVRLSKPNHT4do5v07oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQWQIoGN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa692211331so812805566b.1
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 07:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734363554; x=1734968354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k20My130rzARwyOvgTU0vCNVESW9H6oT+V38TS25XZ8=;
        b=bQWQIoGNjLx/aO9vdDuvNpIde07aJ2j8s+LqIm6EQYiChX7SPGm8Psn4aHh4RUSzxw
         BmHEupXH2GM3XyGq5JyFiujvnZj+YgIBxxCQblHHgjNzs9dQwrDrap5ILv67wFiPbCps
         v/HXxAkqilZUo5kBh7b5zWBCu+eJlW3hAwhjpqeI+S7bkInlpq6dcMurBayMihFaYzLO
         HnPypPZIF1Il1pU5SvgGLUJ/ka+Mw5O41e0vy8ToSIWjMFZFK/V4cu5cq0L9k2SYk+Py
         9dxj/PnV+DaSAxBgBt8H7lHh6pZ1511LugxFN+42uUI1ld0P/9/SQHXvxVL5CDOPMxvJ
         Cuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363554; x=1734968354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k20My130rzARwyOvgTU0vCNVESW9H6oT+V38TS25XZ8=;
        b=rsbmspgGFpK/Grp3INlL83HMmIsz9NJHKOWOYQ8l7s/bb5AqTZWf/ETY8vJgsfFgLN
         7OHpLjHpOzypnkKI0YjzvvBo+HwQJLHEUpn2Bl6QuKsGEKRUr7LB768eJfNdEevlyKpJ
         hf706sULxoXq7H6SdKG3Tm5q8mzUZmTpwM4Qg4mgUkU88y20LVOBb420Gt6IWnat0r/i
         oi3Hye14d47L41JGbxg/1a5dPnE6B/yYZYZYUF/RBCAH1BU0r9dhTyV/XFu1xt3Qx/L2
         aEfxClGfsYbEPhHKNw3BQSWNNZYcCNy55MRLb47vtOztXF9Z+ezaAop3OyXk3MfqO1E7
         IaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmIu69xRV3cz+ZAi8XSf7vKWnBhwwyJuXOPiVU+rfrRuhNPuDYLtNHcN36eM4P6yqCPW3ot3t/@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIVOJiJ7BaNql5CWn8NxPhNcU+dlYXaLxyJMKwc4flbhyr1UK
	jBE7kfNiU2fcDRs1AZX6JLG1qtEoFQxd6+T1awKq1qR69NS1pNYZceto3we0OOc=
X-Gm-Gg: ASbGncsku5ynhNdqAzbgfgGUAjc4er8wgnh3/bdrGUmu/RvhgNTnKKHZO4jtrHEEvP4
	xr+K1a+DY3bcqAVccXI5rXilACZnoQDmoNpsWXERPa3ZKGG493Q7EeXRkVIPaew+WSvEq1X0cGE
	Zvw3Cns8Cv69/KKu617BaTbH8xWB0PypnKKrAtTSc7okpDZ5QJU9aL+CggMnlpommV7gZf5wnMT
	EE1AIqr0LJKaxhzrA0saUOWEVI61tELN6ZNPBzbhs2VMszbhXCafs+sjGXR4Iy2154=
X-Google-Smtp-Source: AGHT+IFtdy6Z+Mdf9GGMuy0jIu5mLADOTup4p6tdMqMZcd7gLMcs48qXum9ADc9H8rCu/BNEGRvYfw==
X-Received: by 2002:a17:906:32d0:b0:aab:da38:1293 with SMTP id a640c23a62f3a-aabda381364mr40185266b.4.1734363553856;
        Mon, 16 Dec 2024 07:39:13 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359e50sm348643666b.126.2024.12.16.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:39:13 -0800 (PST)
Date: Mon, 16 Dec 2024 16:39:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z2BJoDsMeKi4LQGe@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212183012.GB1026@cmpxchg.org>

On Thu 12-12-24 13:30:12, Johannes Weiner wrote:
[...]
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

IIRC the reason going this route was a lack of per-memcg oom reserves.
Global oom victims are getting some slack because the amount of reserves
be bound. This is not the case for memcgs though.

> If we return -ENOMEM to an OOM victim in a fault, the fault handler
> will re-trigger OOM, which will find the existing OOM victim and do
> nothing, then restart the fault.

IIRC the task will handle the pending SIGKILL if the #PF fails. If the
charge happens from the exit path then we rely on ENOMEM returned from
gup as a signal to back off. Do we have any caller that keeps retrying
on ENOMEM?

> This is a memory deadlock. The page
> allocator gives OOM victims access to reserves for that reason.

> Actually, it looks even worse. For some reason we're not triggering
> OOM from dying tasks:
> 
>         ret = task_is_dying() || out_of_memory(&oc);
> 
> Even though dying tasks are in no way privileged or allowed to exit
> expediently. Why shouldn't they trigger the OOM killer like anybody
> else trying to allocate memory?

Good question! I suspect this early bail out is based on an assumption
that a dying task will free up the memory soon so oom killer is
unnecessary.

> As it stands, it seems we have dying tasks getting trapped in an
> endless fault->reclaim cycle; with no access to the OOM killer and no
> access to reserves. Presumably this is what's going on here?

As mentioned above this seems really surprising and it would indicate
that something in the exit path would keep retrying when getting ENOMEM
from gup or GFP_ACCOUNT allocation. GFP_NOFAIL requests are allowed to
over-consume.

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

I am not against this as it would allow to do an async oom_reaper memory
reclaim in the worst case. This could potentially reintroduce the "No
victim available" case described by 7775face2079 ("memcg: killed threads
should not invoke memcg OOM killer") but that seemed to be a very
specific and artificial usecase IIRC.

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

This is more problematic as it doesn't cap a potential runaway and
eventual global OOM which is not really great. In the past this could be
possible through vmalloc which didn't bail out early for killed tasks.
That risk has been mitigated by dd544141b9eb ("vmalloc: back off when
the current task is OOM-killed"). I would like to keep some sort of
protection from those runaways. Whether that is a limited "reserve" for
oom victims that would be per memcg or do no let them consume above the
hard limit at all. Fundamentally a limited reserves doesn't solve the
underlying problem, it just make it less likely so the latter would be
preferred by me TBH.

Before we do that it would be really good to understand the source of
those retries. Maybe I am missing something really obvious but those
shouldn't really happen. 

-- 
Michal Hocko
SUSE Labs

