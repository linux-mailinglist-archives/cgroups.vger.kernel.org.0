Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF768425172
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhJGKtx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 06:49:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbhJGKtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 06:49:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E67F225E5;
        Thu,  7 Oct 2021 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633603677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcWJYTrnWNl9H+OH2VlIp+D8YPfOLYhVh6/tuPxFG6E=;
        b=XLa1+jaF+yRNiuxXt1smb033r6qPpmsLlMjdHa2HtGvwNEuK5fBVKAPThwB7m1bk/Vi7dT
        BZszrjex1rujp9HJ6R4DaGydGClIQPMBl2Dv4sFPEbaM6g9lRavt9Cywa9zVGxqqlQogRE
        vEL107lCkhZivdYEgi/rxv64AAdFOmU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDCE8A3B85;
        Thu,  7 Oct 2021 10:47:56 +0000 (UTC)
Date:   Thu, 7 Oct 2021 12:47:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v2] vmalloc: back off when the current task is
 OOM-killed
Message-ID: <YV7QWYO0MwHzXya7@dhcp22.suse.cz>
References: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
 <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 05-10-21 16:52:40, Vasily Averin wrote:
> Huge vmalloc allocation on heavy loaded node can lead to a global
> memory shortage. Task called vmalloc can have worst badness and
> be selected by OOM-killer, however taken fatal signal does not
> interrupt allocation cycle. Vmalloc repeat page allocaions
> again and again, exacerbating the crisis and consuming the memory
> freed up by another killed tasks.
> 
> After a successful completion of the allocation procedure, a fatal
> signal will be processed and task will be destroyed finally.
> However it may not release the consumed memory, since the allocated
> object may have a lifetime unrelated to the completed task.
> In the worst case, this can lead to the host will panic
> due to "Out of memory and no killable processes..."
> 
> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> effective and avoid host panic. It does not check oom condition directly,
> however, and breaks page allocation cycle when fatal signal was received.

This will allow also interrupting a user space requist which happens to
trigger a large vmalloc, hence the reason for going for
fatal_signal_pending rather than oom specific condition.

> This may trigger some hidden problems, when caller does not handle
> vmalloc failures, or when rollaback after failed vmalloc calls own
> vmallocs inside. However all of these scenarios are incorrect:
> vmalloc does not guarantee successful allocation, it has never been called
> with __GFP_NOFAIL and threfore either should not be used for any rollbacks
> or should handle such errors correctly and not lead to critical
> failures.

__GFP_NOFAIL semantic is explicitly not supported for vmalloc.

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I would keep it sitting in the linux-next for some time to sort out
potential fallouts and have them fixed before this one gets merged.

Thanks!
> ---
> v2: tsk_is_oom_victim() check replaced by fatal_signal_pending(current),
>     removed check inside __alloc_pages_bulk(),
>     according to feedback from mhocko@.
>     Updated patch description.
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..71706f5447f0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2860,6 +2860,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		struct page *page;
>  		int i;
>  
> +		if (fatal_signal_pending(current))
> +			break;
> +
>  		page = alloc_pages_node(nid, gfp, order);
>  		if (unlikely(!page))
>  			break;
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
