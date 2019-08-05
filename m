Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4581465
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHEImc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 04:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfHEImc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Aug 2019 04:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77027B60E;
        Mon,  5 Aug 2019 08:42:30 +0000 (UTC)
Date:   Mon, 5 Aug 2019 10:42:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Masoud Sharbiani <msharbiani@apple.com>,
        Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190805084228.GB7597@dhcp22.suse.cz>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
 <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
 <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
 <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 04-08-19 00:51:18, Tetsuo Handa wrote:
> Masoud, will you try this patch?
> 
> By the way, is /sys/fs/cgroup/memory/leaker/memory.usage_in_bytes remains non-zero
> despite /sys/fs/cgroup/memory/leaker/tasks became empty due to memcg OOM killer expected?
> Deleting big-data-file.bin after memcg OOM killer reduces some, but still remains
> non-zero.
> 
> ----------------------------------------
> >From 2f92c70f390f42185c6e2abb8dda98b1b7d02fa9 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 4 Aug 2019 00:41:30 +0900
> Subject: [PATCH] memcg, oom: don't require __GFP_FS when invoking memcg OOM killer
> 
> Masoud Sharbiani noticed that commit 29ef680ae7c21110 ("memcg, oom: move
> out_of_memory back to the charge path") broke memcg OOM called from
> __xfs_filemap_fault() path.

This is very well spotted! I really didn't think of GFP_NOFS although
xfs in the mix could give me some clue.

> It turned out that try_chage() is retrying
> forever without making forward progress because mem_cgroup_oom(GFP_NOFS)
> cannot invoke the OOM killer due to commit 3da88fb3bacfaa33 ("mm, oom:
> move GFP_NOFS check to out_of_memory"). Regarding memcg OOM, we need to
> bypass GFP_NOFS check in order to guarantee forward progress.

This deserves more information about the fix. Why is it OK to trigger
OOM for GFP_NOFS allocations? Doesn't this lead to pre-mature OOM killer
invocation?

You can argue that memcg charges have ignored GFP_NOFS without seeing a
lot of problems. But please document that in the changelog.

It is 3da88fb3bacfaa33 that has introduced this heuristic and I have to
confess I haven't realized the side effect on the memcg side because
OOM was triggered only from the GFP_KERNEL context. So I would point
to 3da88fb3bacfaa33 as introducing the regression albeit silent at the
time.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: Masoud Sharbiani <msharbiani@apple.com>
> Bisected-by: Masoud Sharbiani <msharbiani@apple.com>
> Fixes: 29ef680ae7c21110 ("memcg, oom: move out_of_memory back to the charge path")

I would say
Fixes: 3da88fb3bacfaa33 # necessary after 29ef680ae7c21110

Other than that I am not really sure about a better fix. Let's see
whether we see some pre-mature memcg OOM reports and think where to get
from there.

With updated changelog
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a..26804ab 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1068,9 +1068,10 @@ bool out_of_memory(struct oom_control *oc)
>  	 * The OOM killer does not compensate for IO-less reclaim.
>  	 * pagefault_out_of_memory lost its gfp context so we have to
>  	 * make sure exclude 0 mask - all other users should have at least
> -	 * ___GFP_DIRECT_RECLAIM to get here.
> +	 * ___GFP_DIRECT_RECLAIM to get here. But mem_cgroup_oom() has to
> +	 * invoke the OOM killer even if it is a GFP_NOFS allocation.
>  	 */
> -	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
> +	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
>  		return true;
>  
>  	/*
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
