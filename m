Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8FD436846
	for <lists+cgroups@lfdr.de>; Thu, 21 Oct 2021 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJUQtt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Oct 2021 12:49:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55740 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJUQts (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Oct 2021 12:49:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E86202199D;
        Thu, 21 Oct 2021 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634834851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++iA8+uhip7K2PBGESkJUKSkd2b03fx9ioYV7M+4ADc=;
        b=hW3ymvnHy/zIjqEGz83CLNjmBv0TkMYAecEBj9ZicauP81r1HFWZ1zXmQBDdateXmP6kUp
        mtbGbyRFsaIHg764GPo8VMrUN+e05/45ZU7+3dDBD60xJXN36r8xEaTA6nM84CnyhJB6Tt
        gEEGzt8067R6EwrCFARVP0xMDJPvyPQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1AF66A3B84;
        Thu, 21 Oct 2021 16:47:31 +0000 (UTC)
Date:   Thu, 21 Oct 2021 18:47:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 3/3] memcg: handle memcg oom failures
Message-ID: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
 <YXATW7KsUZzbbGHy@dhcp22.suse.cz>
 <d3b32c72-6375-f755-7599-ab804719e1f6@virtuozzo.com>
 <YXFPSvGFV539OcEk@dhcp22.suse.cz>
 <b618ac5c-e982-c4af-ecf3-564b8de52c8c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b618ac5c-e982-c4af-ecf3-564b8de52c8c@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-10-21 18:05:28, Vasily Averin wrote:
> On 21.10.2021 14:49, Michal Hocko wrote:
> > I do understand that handling a very specific case sounds easier but it
> > would be better to have a robust fix even if that requires some more
> > head scratching. So far we have collected several reasons why the it is
> > bad to trigger oom killer from the #PF path. There is no single argument
> > to keep it so it sounds like a viable path to pursue. Maybe there are
> > some very well hidden reasons but those should be documented and this is
> > a great opportunity to do either of the step.
> > 
> > Moreover if it turns out that there is a regression then this can be
> > easily reverted and a different, maybe memcg specific, solution can be
> > implemented.
> 
> Now I'm agree,
> however I still have a few open questions.
> 
> 1) VM_FAULT_OOM may be triggered w/o execution of out_of_memory()
> for exampel it can be caused by incorrect vm fault operations, 
> (a) which can return this error without calling allocator at all.

I would argue this to be a bug. How can that particular code tell
whether the system is OOM and the oom killer is the a reasonable measure
to take?

> (b) or which can provide incorrect gfp flags and allocator can fail without execution of out_of_memory.

I am not sure I can see any sensible scenario where pagefault oom killer
would be an appropriate fix for that.

> (c) This may happen on stable/LTS kernels when successful allocation was failed by hit into limit of legacy memcg-kmem contoller.
> We'll drop it in upstream kernels, however how to handle it in old kenrels?

Triggering the global oom killer for legacy kmem charge failure is
clearly wrong. Removing oom killer from #PF would fix that problem.

> We can make sure that out_of_memory or alocator was called by set of some per-task flags.

I am not sure I see how that would be useful other than reporting a
dubious VM_FAULT_OOM usage. I am also not sure how that would be
implemented as allocator can be called several times not to mention that
the allocation itself could have been done from a different context -
e.g. WQ.

> Can pagefault_out_of_memory() send itself a SIGKILL in all these cases?

In principle it can as sending signal is not prohibited. I would argue
it should not though because it is just wrong thing to do in all those
cases.

> If not -- task will be looped. 

Yes, but it will be killable from userspace. So this is not an
unrecoverable situation.
> It is much better than execution of global OOM, however it would be even better to avoid it somehow.

How?

> You said: "We cannot really kill the task if we could we would have done it by the oom killer already".
> However what to do if we even not tried to use oom-killer? (see (b) and (c)) 
> or if we did not used the allocator at all (see (a))

See above

> 2) in your patch we just exit from pagefault_out_of_memory(). and restart new #PF.
> We can call schedule_timeout() and wait some time before a new #PF restart.
> Additionally we can increase this delay in each new cycle. 
> It helps to save CPU time for other tasks.
> What do you think about?

I do not have a strong opinion on this. A short sleep makes sense. I am
not sure a more complex implementation is really needed.
-- 
Michal Hocko
SUSE Labs
