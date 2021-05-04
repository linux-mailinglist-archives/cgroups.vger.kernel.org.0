Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90037297B
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhEDLVy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEDLVy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 07:21:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3BC06174A;
        Tue,  4 May 2021 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iBL4wdk0hhtcp9IJCKPORLOWrfs/6Ue7vXO+EKvQ+U4=; b=jRYVtQEvL1LjLX9sOdEIZ3Pg5v
        lQcWFUeGo26VBne1KPVPxMpUkCVBr0WUHqsfLlJmFYMs3cl3ShoRT/WNl8xN/RREl4d897cswWTcL
        YuPKl90SPVXTjl6i6HXCbCQ8KaOTAXWe0+Nl8HjnDk72i2T/n8LvaoAKERArZl++X46h0fNZpM+Nk
        nGdy7fNsNc1fQwOK+mJmbJHEKqyDP+DpxSXLCPwDk/bACv7Q8zuGyNa5dN0IwzsZvF5dK2QSwbCHw
        CfgE6uM5zjMF34lbAbUv9ET/hjVtatihzy0uPoSEqCEyWi3tDW4p2uO/mNuFXFOvKbiGhOB2c5rii
        mqlIUmXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldt6c-00G3x1-5J; Tue, 04 May 2021 11:20:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CED230022A;
        Tue,  4 May 2021 13:20:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C46A12027BB34; Tue,  4 May 2021 13:20:44 +0200 (CEST)
Date:   Tue, 4 May 2021 13:20:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] psi: fix psi state corruption when schedule() races with
 cgroup move
Message-ID: <YJEuDJS0e9qF6CGn@hirez.programming.kicks-ass.net>
References: <20210503174917.38579-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503174917.38579-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 03, 2021 at 01:49:17PM -0400, Johannes Weiner wrote:
> 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
> introduced a race condition that corrupts internal psi state. This
> manifests as kernel warnings, sometimes followed by bogusly high IO
> pressure:
> 
>   psi: task underflow! cpu=1 t=2 tasks=[0 0 0 0] clear=c set=0
>   (schedule() decreasing RUNNING and ONCPU, both of which are 0)
> 
>   psi: incosistent task state! task=2412744:systemd cpu=17 psi_flags=e clear=3 set=0
>   (cgroup_move_task() clearing MEMSTALL and IOWAIT, but task is MEMSTALL | RUNNING | ONCPU)
> 
> What the offending commit does is batch the two psi callbacks in
> schedule() to reduce the number of cgroup tree updates. When prev is
> deactivated and removed from the runqueue, nothing is done in psi at
> first; when the task switch completes, TSK_RUNNING and TSK_IOWAIT are
> updated along with TSK_ONCPU.
> 
> However, the deactivation and the task switch inside schedule() aren't
> atomic: pick_next_task() may drop the rq lock for load balancing. When
> this happens, cgroup_move_task() can run after the task has been
> physically dequeued, but the psi updates are still pending. Since it
> looks at the task's scheduler state, it doesn't move everything to the
> new cgroup that the task switch that follows is about to clear from
> it. cgroup_move_task() will leak the TSK_RUNNING count in the old
> cgroup, and psi_sched_switch() will underflow it in the new cgroup.
> 
> A similar thing can happen for iowait. TSK_IOWAIT is usually set when
> a p->in_iowait task is dequeued, but again this update is deferred to
> the switch. cgroup_move_task() can see an unqueued p->in_iowait task
> and move a non-existent TSK_IOWAIT. This results in the inconsistent
> task state warning, as well as a counter underflow that will result in
> permanent IO ghost pressure being reported.
> 
> Fix this bug by making cgroup_move_task() use task->psi_flags instead
> of looking at the potentially mismatching scheduler state.
> 
> [ We used the scheduler state historically in order to not rely on
>   task->psi_flags for anything but debugging. But that ship has sailed
>   anyway, and this is simpler and more robust.
> 
>   We previously already batched TSK_ONCPU clearing with the
>   TSK_RUNNING update inside the deactivation call from schedule(). But
>   that ordering was safe and didn't result in TSK_ONCPU corruption:
>   unlike most places in the scheduler, cgroup_move_task() only checked
>   task_current() and handled TSK_ONCPU if the task was still queued. ]
> 
> Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks! queued for sched/urgent.
