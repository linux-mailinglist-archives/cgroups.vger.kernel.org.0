Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78B4148C8
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhIVM3K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 08:29:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhIVM3K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 08:29:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 08965222D7;
        Wed, 22 Sep 2021 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632313659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/z02w7rLfmBHNF8KLwwXEGzPwIC43Djhysq0IuTK5Is=;
        b=ax42HLox5SmOmLZ8qIV0ZkvavTFlvO1VriPiBQewcr/iTGZp4avRjUo8f/OwEbMw0eFZnb
        THUEDwjbkkIDk1DW2DGWf28qzOf6ApS1S5sUcwaT46misuUn8EtUtodklLr/1/jvybnYaR
        aYdJEe7+LdBMTH6Nhssv2ZWuyfFE0NI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88ECDA3B81;
        Wed, 22 Sep 2021 12:27:38 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:27:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
Message-ID: <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 17-09-21 11:06:49, Vasily Averin wrote:
> Huge vmalloc allocation on heavy loaded node can lead to a global
> memory shortage. A task called vmalloc can have the worst badness
> and be chosen by OOM-killer, however received fatal signal and
> oom victim mark does not interrupt allocation cycle. Vmalloc will
> continue allocating pages over and over again, exacerbating the crisis
> and consuming the memory freed up by another killed tasks.
> 
> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> effective and avoid host panic.
> 
> Unfortunately it is not 100% safe. Previous attempt to break vmalloc
> cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
> the current task is killed"") due to some vmalloc callers did not handled
> failures properly. Found issues was resolved, however, there may
> be other similar places.
> 
> Such failures may be acceptable for emergencies, such as OOM. On the other
> hand, we would like to detect them earlier. However they are quite rare,
> and will be hidden by OOM messages, so I'm afraid they wikk have quite
> small chance of being noticed and reported.
> 
> To improve the detection of such places this patch also interrupts the vmalloc
> allocation cycle for all fatal signals. The checks are hidden under DEBUG_VM
> config option to do not break unaware production kernels.

I really dislike this. We shouldn't have a sementically different
behavior for a debugging kernel.

Is there any technical reason to not do fatal_signal_pending bailout
unconditionally? OOM victim based check will make it less likely and
therefore any potential bugs are just hidden more. So I think we should
really go with fatal_signal_pending check here.

> Vmalloc uses new alloc_pages_bulk subsystem, so newly added checks can
> affect other users of this subsystem.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/page_alloc.c | 5 +++++
>  mm/vmalloc.c    | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..133d52e507ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5288,6 +5288,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  			continue;
>  		}
>  
> +		if (tsk_is_oom_victim(current) ||
> +		    (IS_ENABLED(CONFIG_DEBUG_VM) &&
> +		     fatal_signal_pending(current)))
> +			break;

This allocator interface is used in some real hot paths. It is also
meant to be fail fast interface (e.g. it only allocates from pcp
allocator) so it shouldn't bring any additional risk to memory depletion
under heavy memory pressure.

In other words I do not see any reason to bail out in this code path.

-- 
Michal Hocko
SUSE Labs
