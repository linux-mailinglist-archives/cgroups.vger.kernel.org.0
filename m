Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCF3DEFCD
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhHCOPw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhHCOPw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 10:15:52 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C7C06175F
        for <cgroups@vger.kernel.org>; Tue,  3 Aug 2021 07:15:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 184so19979429qkh.1
        for <cgroups@vger.kernel.org>; Tue, 03 Aug 2021 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CGoeGrlFI9+sWcEgQCmH+4Ac0VkTcA2bJ22N5ENTdDg=;
        b=YmkBhg7ZSy7zgRJs7+RhL2ezlEmxraLZ3H2cJIYpUtE5/DhGGXsw2HieBlgdMN6bq1
         h/bjAxt/o7MfkLY3uZFogmdlJU+K6JOaAxZTrufTGGuve3u8FdGoSL+SO88OdUNTiugX
         vr69LKfFslTGNh1JT+km+Nk6dxeOdrjCifl0RIxQAuCCfjxOCIlwM/1oLnAEl9/CSaxj
         E2ladtVMDDGUY5n04jsimXPRC/LuYM5yA2dNEQ8xfZfDmZcZYupXzyU1BmvVGFCHf1Ys
         N+/rXzScbRO8X31ZPN4Ho4fJWw9OIZylMuVBiYpyouhTKZ93m1To3Hh5Cm4GqaEHOh6Y
         lc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGoeGrlFI9+sWcEgQCmH+4Ac0VkTcA2bJ22N5ENTdDg=;
        b=n6ziLbS7boogdkZUn0Ow5M9Wh6CoogKqxYUXDc9D7PVAGqRfmAAPpa6FvI5IpJer9Q
         VYLzjVxHsOWGS49UfXqEO0uo94PR40FPuhaEw0ndsvNQ7+2uuXHRkib06Y2qtCS5rMdP
         /yMYwbdTZZC2D54WKqoe0gQ9b/sECHaknTtFkpHRE7ErNpp06w77gQ91msBT7qhoww3G
         cCIzfOCrZcsRFNK7lpR/YTIJjtZL0QZthzwzMpFYulBPgWORjxHFkArCzJ3iQUetbfcz
         j8QL11jliEbv0z23l0FpJVyn4HzfeAJAKEoDbHZ3pxdN7E8XXmj1V/nSEtG+00rhMA04
         4lXA==
X-Gm-Message-State: AOAM532OjzZjdmiyFV8+TwBsqM5Ph3e+lBgOgRfibMq0yzd+/zCTnOmI
        uSVVhF2uJDqBSQGUI6UmQfbHvg==
X-Google-Smtp-Source: ABdhPJzPp08cKt2Oi+NdOsTC+m7W0qzcKhjVfmuOxdm6waljOoR6RYCG9IzK3VHVfWTXN+mJjH+ywQ==
X-Received: by 2002:ae9:e515:: with SMTP id w21mr20559520qkf.169.1628000139086;
        Tue, 03 Aug 2021 07:15:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7bfe])
        by smtp.gmail.com with ESMTPSA id 143sm7935158qkf.3.2021.08.03.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 07:15:38 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:15:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Miaohe Lin <linmiaohe@huawei.com>,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQlPiLY0ieRb704V@cmpxchg.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 30, 2021 at 08:50:02AM +0200, Michal Hocko wrote:
> On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
> > On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> > > Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> > > narrow the scope of percpu_charge_mutex by moving it here.
> > > 
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > >  mm/memcontrol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 6580c2381a3e..a03e24e57cd9 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
> > >  #define FLUSHING_CACHED_CHARGE	0
> > >  };
> > >  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> > > -static DEFINE_MUTEX(percpu_charge_mutex);
> > >  
> > >  #ifdef CONFIG_MEMCG_KMEM
> > >  static void drain_obj_stock(struct obj_stock *stock);
> > > @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> > >   */
> > >  static void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  {
> > > +	static DEFINE_MUTEX(percpu_charge_mutex);
> > >  	int cpu, curcpu;
> > 
> > It's considered a good practice to protect data instead of code paths. After
> > the proposed change it becomes obvious that the opposite is done here: the mutex
> > is used to prevent a simultaneous execution of the code of the drain_all_stock()
> > function.
> 
> The purpose of the lock was indeed to orchestrate callers more than any
> data structure consistency.

It doesn't seem like we need the lock at all.

The comment says it's so we don't spawn more workers when flushing is
already underway. But a work cannot be queued more than once - if it
were just about that, we'd needlessly duplicate the
test_and_set_bit(WORK_STRUCT_PENDING_BIT) in queue_work_on().

git history shows we tried to remove it once:

commit 8521fc50d433507a7cdc96bec280f9e5888a54cc
Author: Michal Hocko <mhocko@suse.cz>
Date:   Tue Jul 26 16:08:29 2011 -0700

    memcg: get rid of percpu_charge_mutex lock

but it turned out that the lock did in fact protect a data structure:
the stock itself. Specifically stock->cached:

commit 9f50fad65b87a8776ae989ca059ad6c17925dfc3
Author: Michal Hocko <mhocko@suse.cz>
Date:   Tue Aug 9 11:56:26 2011 +0200

    Revert "memcg: get rid of percpu_charge_mutex lock"

    This reverts commit 8521fc50d433507a7cdc96bec280f9e5888a54cc.

    The patch incorrectly assumes that using atomic FLUSHING_CACHED_CHARGE
    bit operations is sufficient but that is not true.  Johannes Weiner has
    reported a crash during parallel memory cgroup removal:

      BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
      IP: [<ffffffff81083b70>] css_is_ancestor+0x20/0x70
      Oops: 0000 [#1] PREEMPT SMP
      Pid: 19677, comm: rmdir Tainted: G        W   3.0.0-mm1-00188-gf38d32b #35 ECS MCP61M-M3/MCP61M-M3
      RIP: 0010:[<ffffffff81083b70>]  css_is_ancestor+0x20/0x70
      RSP: 0018:ffff880077b09c88  EFLAGS: 00010202
      Process rmdir (pid: 19677, threadinfo ffff880077b08000, task ffff8800781bb310)
      Call Trace:
       [<ffffffff810feba3>] mem_cgroup_same_or_subtree+0x33/0x40
       [<ffffffff810feccf>] drain_all_stock+0x11f/0x170
       [<ffffffff81103211>] mem_cgroup_force_empty+0x231/0x6d0
       [<ffffffff811036c4>] mem_cgroup_pre_destroy+0x14/0x20
       [<ffffffff81080559>] cgroup_rmdir+0xb9/0x500
       [<ffffffff81114d26>] vfs_rmdir+0x86/0xe0
       [<ffffffff81114e7b>] do_rmdir+0xfb/0x110
       [<ffffffff81114ea6>] sys_rmdir+0x16/0x20
       [<ffffffff8154d76b>] system_call_fastpath+0x16/0x1b

    We are crashing because we try to dereference cached memcg when we are
    checking whether we should wait for draining on the cache.  The cache is
    already cleaned up, though.

    There is also a theoretical chance that the cached memcg gets freed
    between we test for the FLUSHING_CACHED_CHARGE and dereference it in
    mem_cgroup_same_or_subtree:

            CPU0                    CPU1                         CPU2
      mem=stock->cached
      stock->cached=NULL
                                  clear_bit
                                                            test_and_set_bit
      test_bit()                    ...
      <preempted>             mem_cgroup_destroy
      use after free

    The percpu_charge_mutex protected from this race because sync draining
    is exclusive.

    It is safer to revert now and come up with a more parallel
    implementation later.

I didn't remember this one at all!

However, when you look at the codebase from back then, there was no
rcu-protection for memcg lifetime, and drain_stock() didn't double
check stock->cached inside the work. Hence the crash during a race.

The drain code is different now: drain_local_stock() disables IRQs
which holds up rcu, and then calls drain_stock() and drain_obj_stock()
which both check stock->cached one more time before the deref.

With workqueue managing concurrency, and rcu ensuring memcg lifetime
during the drain, this lock indeed seems unnecessary now.

Unless I'm missing something, it should just be removed instead.
