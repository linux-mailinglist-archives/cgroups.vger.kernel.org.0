Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7A3DFCAD
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhHDIUU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 04:20:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbhHDIUU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 04:20:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 23284221B6;
        Wed,  4 Aug 2021 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628065207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lcx+B/N18widrHuZLHZiL32C9ltYEwiglNQ7MtBx6bI=;
        b=Jz6JUhuuz7lMa83tROXofHjvK6VlFINTkD2AvYV+6HVr2SktLKcDdH9zAp57oWhD4+RA2r
        qR60UBMt4MzPJR003RRtd0H8VxT2G6GjZ9BqRYKtBsMnBXtKwQJ3NehFCWNcdZdfm7mA5b
        1ttlxk0tghKuGH5ti/JmAyyHrRHfx/k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 30FC6A3B95;
        Wed,  4 Aug 2021 08:20:06 +0000 (UTC)
Date:   Wed, 4 Aug 2021 10:20:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Miaohe Lin <linmiaohe@huawei.com>,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQpNtfjl0rHH8Mgf@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <YQlPiLY0ieRb704V@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQlPiLY0ieRb704V@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-08-21 10:15:36, Johannes Weiner wrote:
[...]
> git history shows we tried to remove it once:
> 
> commit 8521fc50d433507a7cdc96bec280f9e5888a54cc
> Author: Michal Hocko <mhocko@suse.cz>
> Date:   Tue Jul 26 16:08:29 2011 -0700
> 
>     memcg: get rid of percpu_charge_mutex lock
> 
> but it turned out that the lock did in fact protect a data structure:
> the stock itself. Specifically stock->cached:
> 
> commit 9f50fad65b87a8776ae989ca059ad6c17925dfc3
> Author: Michal Hocko <mhocko@suse.cz>
> Date:   Tue Aug 9 11:56:26 2011 +0200
> 
>     Revert "memcg: get rid of percpu_charge_mutex lock"
> 
>     This reverts commit 8521fc50d433507a7cdc96bec280f9e5888a54cc.
> 
>     The patch incorrectly assumes that using atomic FLUSHING_CACHED_CHARGE
>     bit operations is sufficient but that is not true.  Johannes Weiner has
>     reported a crash during parallel memory cgroup removal:
> 
>       BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>       IP: [<ffffffff81083b70>] css_is_ancestor+0x20/0x70
>       Oops: 0000 [#1] PREEMPT SMP
>       Pid: 19677, comm: rmdir Tainted: G        W   3.0.0-mm1-00188-gf38d32b #35 ECS MCP61M-M3/MCP61M-M3
>       RIP: 0010:[<ffffffff81083b70>]  css_is_ancestor+0x20/0x70
>       RSP: 0018:ffff880077b09c88  EFLAGS: 00010202
>       Process rmdir (pid: 19677, threadinfo ffff880077b08000, task ffff8800781bb310)
>       Call Trace:
>        [<ffffffff810feba3>] mem_cgroup_same_or_subtree+0x33/0x40
>        [<ffffffff810feccf>] drain_all_stock+0x11f/0x170
>        [<ffffffff81103211>] mem_cgroup_force_empty+0x231/0x6d0
>        [<ffffffff811036c4>] mem_cgroup_pre_destroy+0x14/0x20
>        [<ffffffff81080559>] cgroup_rmdir+0xb9/0x500
>        [<ffffffff81114d26>] vfs_rmdir+0x86/0xe0
>        [<ffffffff81114e7b>] do_rmdir+0xfb/0x110
>        [<ffffffff81114ea6>] sys_rmdir+0x16/0x20
>        [<ffffffff8154d76b>] system_call_fastpath+0x16/0x1b
> 
>     We are crashing because we try to dereference cached memcg when we are
>     checking whether we should wait for draining on the cache.  The cache is
>     already cleaned up, though.
> 
>     There is also a theoretical chance that the cached memcg gets freed
>     between we test for the FLUSHING_CACHED_CHARGE and dereference it in
>     mem_cgroup_same_or_subtree:
> 
>             CPU0                    CPU1                         CPU2
>       mem=stock->cached
>       stock->cached=NULL
>                                   clear_bit
>                                                             test_and_set_bit
>       test_bit()                    ...
>       <preempted>             mem_cgroup_destroy
>       use after free
> 
>     The percpu_charge_mutex protected from this race because sync draining
>     is exclusive.
> 
>     It is safer to revert now and come up with a more parallel
>     implementation later.
> 
> I didn't remember this one at all!

Me neither. Thanks for looking that up!

> However, when you look at the codebase from back then, there was no
> rcu-protection for memcg lifetime, and drain_stock() didn't double
> check stock->cached inside the work. Hence the crash during a race.
> 
> The drain code is different now: drain_local_stock() disables IRQs
> which holds up rcu, and then calls drain_stock() and drain_obj_stock()
> which both check stock->cached one more time before the deref.
> 
> With workqueue managing concurrency, and rcu ensuring memcg lifetime
> during the drain, this lock indeed seems unnecessary now.
> 
> Unless I'm missing something, it should just be removed instead.

I do not think you are missing anything. We can drop the lock and
simplify the code. The above information would be great to have in the
changelog.

Thanks!
-- 
Michal Hocko
SUSE Labs
