Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED16C3693DA
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhDWNlf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 09:41:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDWNlf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 09:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619185258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uEWNl3Gsy2z9EBPPam61E5IfI9Ruj/+cOWGg3wc1i0=;
        b=vN3Q+DIYQ3GKcJfcBwnq5YmzJ0MaLifaF94UzluKfObSaLpcnTFwRtAUodup1f3EQF6VA8
        VbzNUdXfoR1cnkhhVkE730U/+D/3mXrL5BJy5vszAW6t+XSzrfSqNUxCM1uWPA9wsz3USP
        pEne3n3cMeaj+TrK81DtU0BG7gjQurA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05B9AADD7;
        Fri, 23 Apr 2021 13:40:58 +0000 (UTC)
Date:   Fri, 23 Apr 2021 15:40:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v3 08/16] memcg: enable accounting of ipc resources
Message-ID: <YILOab0/h83egjUw@dhcp22.suse.cz>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <4ed65beb-bda3-1c93-fadf-296b760a32b2@virtuozzo.com>
 <YIK6ttdnfjOo6XCN@localhost.localdomain>
 <dd9b1767-55e0-6754-3ac5-7e01de12f16e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9b1767-55e0-6754-3ac5-7e01de12f16e@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 23-04-21 15:32:01, Vasily Averin wrote:
> On 4/23/21 3:16 PM, Alexey Dobriyan wrote:
> > On Thu, Apr 22, 2021 at 01:37:02PM +0300, Vasily Averin wrote:
> >> When user creates IPC objects it forces kernel to allocate memory for
> >> these long-living objects.
> >>
> >> It makes sense to account them to restrict the host's memory consumption
> >> from inside the memcg-limited container.
> >>
> >> This patch enables accounting for IPC shared memory segments, messages
> >> semaphores and semaphore's undo lists.
> > 
> >> --- a/ipc/msg.c
> >> +++ b/ipc/msg.c
> >> @@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
> >>  	key_t key = params->key;
> >>  	int msgflg = params->flg;
> >>  
> >> -	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
> >> +	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
> > 
> > Why this requires vmalloc? struct msg_queue is not big at all.
> > 
> >> --- a/ipc/shm.c
> >> +++ b/ipc/shm.c
> >> @@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> >>  			ns->shm_tot + numpages > ns->shm_ctlall)
> >>  		return -ENOSPC;
> >>  
> >> -	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
> >> +	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
> > 
> > Same question.
> > Kmem caches can be GFP_ACCOUNT by default.
> 
> It is side effect: previously all these objects was allocated via ipc_alloc/ipc_alloc_rcu
> function called kvmalloc inside.
> 
> Should I replace it to kmalloc right in this patch?

I would say those are two independent things. I would agree that
kvmalloc is bogus here. The allocation would try SLAB allocator first
but if it fails (as kvmalloc doesn't try really hard) then it would
fragment memory without a good reason which looks like a bug to me.

-- 
Michal Hocko
SUSE Labs
