Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52144088CC
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhIMKLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 06:11:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbhIMKLn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 06:11:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 129D621C86;
        Mon, 13 Sep 2021 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631527827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AiRkX0WmNs9gJZTMmdh3igwoaOgGldencFjuU/XzQXk=;
        b=M61ke4OyiDAoRXUd/MfdBGLxA4SX0zHRwS1SjPCxfp063hQwZJ7OSV6psRSojdguit9QyG
        iHP4GtWWQ++oWv9UpWiB9r2qPGdaulPhnclxsoTsM5mu6uSwe/7KD/SQKy4eyi8aZO04SP
        yEC2qXYXa3JX5nS6ebbH9gUVva5zRAc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E09DA3B84;
        Mon, 13 Sep 2021 10:10:26 +0000 (UTC)
Date:   Mon, 13 Sep 2021 12:10:25 +0200
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
Message-ID: <YT8jkaA+bUB4aP2p@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <8b98d44a-aeb2-5f5f-2545-ac2bd0c7049b@virtuozzo.com>
 <YT8OTozT3FN9P2k7@dhcp22.suse.cz>
 <b4b1e66e-e6e6-84e9-46a1-060ed412dd56@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b1e66e-e6e6-84e9-46a1-060ed412dd56@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 12:37:56, Vasily Averin wrote:
> On 9/13/21 11:39 AM, Michal Hocko wrote:
> > On Mon 13-09-21 10:51:37, Vasily Averin wrote:
> >> On 9/10/21 3:39 PM, Vasily Averin wrote:
> >>> The kernel currently allows dying tasks to exceed the memcg limits.
> >>> The allocation is expected to be the last one and the occupied memory
> >>> will be freed soon.
> >>> This is not always true because it can be part of the huge vmalloc
> >>> allocation. Allowed once, they will repeat over and over again.
> >>
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index 389b5766e74f..67195fcfbddf 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -2622,15 +2625,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >>>  	if (gfp_mask & __GFP_ATOMIC)
> >>>  		goto force;
> >>>  
> >>> -	/*
> >>> -	 * Unlike in global OOM situations, memcg is not in a physical
> >>> -	 * memory shortage.  Allow dying and OOM-killed tasks to
> >>> -	 * bypass the last charges so that they can exit quickly and
> >>> -	 * free their memory.
> >>> -	 */
> >>> -	if (unlikely(should_force_charge()))
> >>> -		goto force;
> >>> -
> >>
> >> Should we keep current behaviour for (current->flags & PF_EXITING) case perhaps?
> > 
> > Why?
> 
> On this stage task really dies and mostly releases taken resources.
> It can allocate though, and this allocation can reach memcg limit due to the activity
> of parallel memcg threads.
> 
> Noting bad should happen if we reject this allocation,
> because the same thing can happen in non-memcg case too.
> However I doubt misuse is possible here and we have possibility to allow graceful shutdown here.
> 
> In other words: we are not obliged to allow such allocations, but we CAN do it because
> we hope that it is safe and cannot be misused.

This is a lot of hoping that has turned out to be a bad strategy in the
existing code.  So let's stop hoping and if we are shown that an
exit path really benefits from a special treatment then we can add it
with a good reasoning rathat than "we hope it's gonna be ok".
-- 
Michal Hocko
SUSE Labs
