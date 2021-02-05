Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389ED31150A
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhBEWWx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:22:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:49286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhBEO0M (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 09:26:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612541047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TuCw125E70gQA5pcVuLFq5da8zSoBoZGjiwm7DafF+E=;
        b=pgEZdng5KQRSoP5J4Sq44/H4tL4C8kHWXtH/bHop8m7RvjYpX6iLAWxTdU4CdjusWgwxFQ
        mFO7TK3ReZ3+zfOYkHlygAQkIuWaeQ5KchDns8ZUHLfo8QtDCk8gXMskKt1ZNsz3biIAj5
        3PjuS5sox0GzmG3AucSvi4atHq+xNlk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA792AC9B;
        Fri,  5 Feb 2021 16:04:07 +0000 (UTC)
Date:   Fri, 5 Feb 2021 17:04:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup oom
 task
Message-ID: <YB1sd96CeJqNmzYn@dhcp22.suse.cz>
References: <20210205062310.74268-1-songmuchun@bytedance.com>
 <YB0Ay+epP/hnFmDS@dhcp22.suse.cz>
 <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
 <YB0cO7R1WtJgAxI2@dhcp22.suse.cz>
 <CAMZfGtXXjXKoxbOSB9h6JvgZKEGBh2sCf34usJXcBXxGjU6k0w@mail.gmail.com>
 <YB04B1gMdE/B3G9c@dhcp22.suse.cz>
 <CAMZfGtVBPdWUG6MuGcFt7A_Xr1zCJj-gnE0pKyhyJAy6bSSgnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVBPdWUG6MuGcFt7A_Xr1zCJj-gnE0pKyhyJAy6bSSgnw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 23:30:36, Muchun Song wrote:
> On Fri, Feb 5, 2021 at 8:20 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 05-02-21 19:04:19, Muchun Song wrote:
> > > On Fri, Feb 5, 2021 at 6:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 05-02-21 17:55:10, Muchun Song wrote:
> > > > > On Fri, Feb 5, 2021 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Fri 05-02-21 14:23:10, Muchun Song wrote:
> > > > > > > We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> > > > > > > when page uncharged, but for the slab pages, we do not do this when page
> > > > > > > uncharged.
> > > > > >
> > > > > > How does the patch deal with this?
> > > > >
> > > > > When we uncharge a slab page via __memcg_kmem_uncharge,
> > > > > actually, this path forgets to do this for us compared to
> > > > > uncharge_batch(). Right?
> > > >
> > > > Yes this was more more or less clear (still would have been nicer to be
> > > > explicit). But you still haven't replied to my question I believe. I
> > > > assume you rely on refill_stock doing draining but how does this address
> > > > the problem? Is it sufficient to do wakeups in the batched way?
> > >
> > > Sorry, the subject title may not be suitable. IIUC, memcg_oom_recover
> > > aims to wake up the OOM task when we uncharge the page.
> >
> > Yes, your understanding is correct. This is a way to pro-actively wake
> > up oom victims when the memcg oom handling is outsourced to the
> > userspace. Please note that I haven't objected to the problem statement.
> >
> > I was questioning the fix for the problem.
> >
> > > I see uncharge_batch always do this. I am confused why
> > > __memcg_kmem_uncharge does not.
> >
> > Very likely an omission. I haven't checked closely but I suspect this
> > has been introduced by the recent kmem accounting changes.
> >
> > Why didn't you simply do the same thing and call memcg_oom_recover
> > unconditionally and instead depend on the draining? I suspect this was
> > because you wanted to recover also when draining which is not necessary
> > as pointed out in other email.
> 
> Thanks for your explanations. You are right. It is my fault to depend
> on the draining. I should call memcg_oom_recover directly in the
> __memcg_kmem_uncharge. Right?

Yes.

> > [...]
> > > > > > Does this lead to any code generation improvements? I would expect
> > > > > > compiler to be clever enough to inline static functions if that pays
> > > > > > off. If yes make this a patch on its own.
> > > > >
> > > > > I have disassembled the code, I see memcg_oom_recover is not
> > > > > inline. Maybe because memcg_oom_recover has a lot of callers.
> > > > > Just guess.
> > > > >
> > > > > (gdb) disassemble uncharge_batch
> > > > >  [...]
> > > > >  0xffffffff81341c73 <+227>: callq  0xffffffff8133c420 <page_counter_uncharge>
> > > > >  0xffffffff81341c78 <+232>: jmpq   0xffffffff81341bc0 <uncharge_batch+48>
> > > > >  0xffffffff81341c7d <+237>: callq  0xffffffff8133e2c0 <memcg_oom_recover>
> > > >
> > > > So does it really help to do the inlining?
> > >
> > > I just think memcg_oom_recover is very small, inline maybe
> > > a good choice. Maybe I am wrong.
> >
> > In general I am not overly keen on changes without a proper
> > justification. In this particular case I would understand that a
> > function call that will almost never do anything but the test (because
> > oom_disabled is a rarely used) is just waste of cycles in some hot
> > paths (e.g. kmem uncharge). Maybe this even has some visible performance
> > benefit. If this is really the case then would it make sense to guard
> > this test by the existing cgroup_subsys_on_dfl(memory_cgrp_subsys)?
> 
> Agree. I think it can improve performance when this
> function is inline. Guarding the test should be also
> an improvement on cgroup v2.

I would be surprised if this was measurable but you can give it a try. A
static key would be a reasonable argument for inlining on its own.
-- 
Michal Hocko
SUSE Labs
