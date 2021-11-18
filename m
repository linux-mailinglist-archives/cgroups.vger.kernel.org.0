Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018DC4553AF
	for <lists+cgroups@lfdr.de>; Thu, 18 Nov 2021 05:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhKRESx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Nov 2021 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbhKRES2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Nov 2021 23:18:28 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7EC0613B9
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 20:15:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f9so6220196ioo.11
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 20:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dv4FMpzTlhmMmFiifkPCQFCgRBuUEUnuMSwoqw5Fr4o=;
        b=omqr4cQnnPmevelwOr+q6Fi7C6sTodMQdwtDb3HvpoNVQa77lXcCb/dH3PXFqJMuTs
         jr9AZrmXT1DmrQpZU4wlwTOHAXpvP/+pqiII7JIq43ICkCV7JPTxAw3j+Z/q8hp7rDJg
         w3cIgOumYkd14BgMin0r0eU68m1UuKYP42up0V9aDnJjwcJcyxay/XqabvmNOCDo9Jvn
         s342YAKrSypETDBbiSWtwvxweyYi3WRFEaj6h+Eujf5DsY5upwrnews6eiY/rWJrfIUv
         t3NvRg+pUV+Uy4k/nVRNVeH+EofbNEYawSIqYhwWMGkq/f8wSWGrSmflOCGgvhv+sBmw
         Z0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dv4FMpzTlhmMmFiifkPCQFCgRBuUEUnuMSwoqw5Fr4o=;
        b=v7C333E552OyUDE9gnk5wxjdi4RA09PHOiwSXlUgI8s0gf71+8+Dl7GhevRq+FcYSd
         VbAVhJeuAum3Y0qdw0Vy0jpYDJnHq59yPQsZvCRBXcZbLZ5UFIwXXXN9AMu9L+BvRKhQ
         9TYr3mb1zmnd/qJdtGwB7bSQXlBYbBbXP26N8oFtOTMmFONWmmzH4l9XVdWo/PH8lBtK
         9xT3LQ4c/E3cGhbkGWpAfRP4W38CHr2zYtOWKUweymBtZR/a5XSH/f14ZuC3DzdFuVDp
         eojZox5f7lQ9arzSmdgCQRknvA/5uo7EjZJABqRK+W+aEjpsujuUjXGsV0wI2GYo3H9M
         XDRw==
X-Gm-Message-State: AOAM531GzNFY9zeAY6bx7LFBXt/NCsOT4ISbheo8TU3sZcB3F1FR90ec
        M83eb5qDKld6auQQN146t55mhd6pd0vEjEkFrAdprQ==
X-Google-Smtp-Source: ABdhPJxu6AkgtL/4msTfyEuWlVQQDgdP0qHDDtygnoDktA5q5rQTxfaknVLaSBngH7GgVixVcfpZ2bzBmVMCfOgK1Vk=
X-Received: by 2002:a05:6602:3c2:: with SMTP id g2mr15805739iov.65.1637208928333;
 Wed, 17 Nov 2021 20:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20211117201825.429650-1-almasrymina@google.com>
 <86d3ba7a-3706-d66c-cbf7-d2c39ad2cd4c@oracle.com> <CAMZfGtXgYPVOsGUE8OOzkx8K14BjHoMS1hLvxXX77+5cSycrPw@mail.gmail.com>
In-Reply-To: <CAMZfGtXgYPVOsGUE8OOzkx8K14BjHoMS1hLvxXX77+5cSycrPw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 17 Nov 2021 20:15:17 -0800
Message-ID: <CAHS8izMsQyTs=OKa-rD=MTZOHNbRXRP80jUUSt4+QOuvMSsHyQ@mail.gmail.com>
Subject: Re: [PATCH v7] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 17, 2021 at 7:55 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Nov 18, 2021 at 8:13 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 11/17/21 12:18, Mina Almasry wrote:
> > ...
> > > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > ...
> > > @@ -288,11 +317,21 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > >                                          struct hugetlb_cgroup *h_cg,
> > >                                          struct page *page, bool rsvd)
> > >  {
> > > +     unsigned long *usage;
> > > +
> >
> > I assume the use of a pointer is just to make the following WRITE_ONCE
> > look better?  I prefer the suggestion by Muchun:
> >
> > unsigned long usage = h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
> >
> > usage += nr_pages;
> > WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx], usage);
> >
> > I had to think for just a second 'why are we using/passing a pointer?'.
> > Not insisting we use Muchun's suggestion, it just caused me to think
> > a little more than necessary.
>
> At least I have the same question here. For me I think it's
> unnecessary to use a pointer.
>

Hmm to be honest I would have not thought it would be preferable to
duplicate a long string like
h_cg->nodeinfo[page_to_nid(page)]->usage[idx], and then for future
code changes to keep them in sync. I think Marco had the same thinking
and that was his initial suggestion, but I don't mind much either way.
I'll submit another iteration with the change :-)

> >
> > In any case, I would move the variable usage inside the
> > 'if (!rsvd)' block.
> >
> > >       if (hugetlb_cgroup_disabled() || !h_cg)
> > >               return;
> > >
> > >       __set_hugetlb_cgroup(page, h_cg, rsvd);
> > > -     return;
> > > +     if (!rsvd) {
> > > +             usage = &h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
> > > +             /*
> > > +              * This write is not atomic due to fetching *usage and writing
> > > +              * to it, but that's fine because we call this with
> > > +              * hugetlb_lock held anyway.
> > > +              */
> > > +             WRITE_ONCE(*usage, *usage + nr_pages);
> > > +     }
> > >  }
> > >
> > >  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > > @@ -316,6 +355,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> > >                                          struct page *page, bool rsvd)
> > >  {
> > >       struct hugetlb_cgroup *h_cg;
> > > +     unsigned long *usage;
> >
> > Same here.
> >
> > Otherwise, looks good to me.
> > --
> > Mike Kravetz
