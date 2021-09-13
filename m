Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6F40872E
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhIMIlA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 04:41:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhIMIk7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 04:40:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FCA41FFAA;
        Mon, 13 Sep 2021 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631522383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNVmy9/9lqHYvf3OJkSwSJB1fHLiXXPQ7bI/XZDPCbw=;
        b=c1HHg8ePrZfYQ80ef9MjqdceMy0V9FYZoCaBtu/1B1AwAORvSyJTM3OD3cRRQ/4fEkyTCa
        jZFgwaxgR3QJbaOsKHHrUCUfsTd436BsaRQWHlzlEKLzx6jRp1r2259heXsZgH8pGqUCGn
        BmY5q6RQIUfMQuRWPsw/GSgUu4/+T2w=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B4E89A3B81;
        Mon, 13 Sep 2021 08:39:42 +0000 (UTC)
Date:   Mon, 13 Sep 2021 10:39:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
Message-ID: <YT8OTozT3FN9P2k7@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <8b98d44a-aeb2-5f5f-2545-ac2bd0c7049b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b98d44a-aeb2-5f5f-2545-ac2bd0c7049b@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 10:51:37, Vasily Averin wrote:
> On 9/10/21 3:39 PM, Vasily Averin wrote:
> > The kernel currently allows dying tasks to exceed the memcg limits.
> > The allocation is expected to be the last one and the occupied memory
> > will be freed soon.
> > This is not always true because it can be part of the huge vmalloc
> > allocation. Allowed once, they will repeat over and over again.
> 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 389b5766e74f..67195fcfbddf 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2622,15 +2625,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	if (gfp_mask & __GFP_ATOMIC)
> >  		goto force;
> >  
> > -	/*
> > -	 * Unlike in global OOM situations, memcg is not in a physical
> > -	 * memory shortage.  Allow dying and OOM-killed tasks to
> > -	 * bypass the last charges so that they can exit quickly and
> > -	 * free their memory.
> > -	 */
> > -	if (unlikely(should_force_charge()))
> > -		goto force;
> > -
> 
> Should we keep current behaviour for (current->flags & PF_EXITING) case perhaps?

Why?

> It is set inside do_exit only and (I hope) cannot trigger huge vmalloc allocations.

Allocations in this code path should be rare but it is not like they are
non-existent. This is rather hard to review area spread at many places
so if we are deciding to make the existing model simpler (no bypassing)
then I would rather have no exceptions unless they are reaaly necessary
and document them if they are.
-- 
Michal Hocko
SUSE Labs
