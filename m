Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284E945538C
	for <lists+cgroups@lfdr.de>; Thu, 18 Nov 2021 04:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhKRD6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Nov 2021 22:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhKRD6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Nov 2021 22:58:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A9C061570
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 19:55:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v138so13927295ybb.8
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7t2KOfThi8hwqtjS9xYJIJMpMs4r7+aUCTbqpqaQgB8=;
        b=VegwIcpX4FTIU4RKip0IPMIg6bX57jiY+9C8sQOQlBEqaM0YS6p0Xj1UBjhlrmsTws
         nFsgLGqhsql/oJaUZmT23eSUFDPYJKFEBLYMdg1sCfGd73WqCBwrljXGCjUDAyycs1Ui
         KiKS2L8yF5rQ4s0DOtrMCJQyrko1gAm1Be0794OMriv4R96ZDyOQwF3Ki6qUVRKGz/zl
         0KsMERtV0Zk2+MG1lLyY2S/d2TIpwYf99h/8vuodrpwrJIDdDDY2rSzEXyJSryp2zD9Q
         JpMxhMN6GcLXDPQBFy86gmFjQ8pVlEXwfZzR0LT2a7bhXaOceJg0a2A/fBAKxn+o6p8k
         5Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7t2KOfThi8hwqtjS9xYJIJMpMs4r7+aUCTbqpqaQgB8=;
        b=FRAQQsIu5obn5RuPGTISw6N8Q74V7lXgTPJ9z6EHs620AQ6hGgbv+bAc9bbqIBBCHC
         3gIpJyWwyy9wajMWWZrCEh14MpkzAUbsRU44ztD39TSLl7lrgEXQdQCJUeS746skTfEo
         Jm2SvMTtwnnLV7O+WQ5eDKHKkRhodkY0zZ6E9/yKPBNXpHE5wjm6mpMp7nwJe4XYr48g
         hSCwNXzXHh5eGOR7tDQsVFM3dpCHkgGUsOrorSDKi03oyWnslIjDofaCqAtWxYV9FEtc
         hAMyya3BTbJ8Ckc12wSENE25+2w4hFXv4Zo0E3CcVJ6YPz7CC6d8f7Mb0o80DaozcJUJ
         nxvg==
X-Gm-Message-State: AOAM532rNYwveTHo7XycEGhuqA8c3RFIi8ZDK/PFtetkxpjvwXvewuVs
        nj740b2dY75jwH0ioPBn+3S03dH14ZK6WhZFP7vcMw==
X-Google-Smtp-Source: ABdhPJwDXNp4NAcyRT6V4FmOdCoZyUxOTi38EahqeDeNePoS+k/y6vFUW7lDd3FRU4FzdGYUTLVpGb8mv+7nIthpxFM=
X-Received: by 2002:a05:6902:1149:: with SMTP id p9mr4795700ybu.404.1637207715886;
 Wed, 17 Nov 2021 19:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20211117201825.429650-1-almasrymina@google.com> <86d3ba7a-3706-d66c-cbf7-d2c39ad2cd4c@oracle.com>
In-Reply-To: <86d3ba7a-3706-d66c-cbf7-d2c39ad2cd4c@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 18 Nov 2021 11:54:37 +0800
Message-ID: <CAMZfGtXgYPVOsGUE8OOzkx8K14BjHoMS1hLvxXX77+5cSycrPw@mail.gmail.com>
Subject: Re: [PATCH v7] hugetlb: Add hugetlb.*.numa_stat file
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, Nov 18, 2021 at 8:13 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/17/21 12:18, Mina Almasry wrote:
> ...
> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> ...
> > @@ -288,11 +317,21 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> >                                          struct hugetlb_cgroup *h_cg,
> >                                          struct page *page, bool rsvd)
> >  {
> > +     unsigned long *usage;
> > +
>
> I assume the use of a pointer is just to make the following WRITE_ONCE
> look better?  I prefer the suggestion by Muchun:
>
> unsigned long usage = h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
>
> usage += nr_pages;
> WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx], usage);
>
> I had to think for just a second 'why are we using/passing a pointer?'.
> Not insisting we use Muchun's suggestion, it just caused me to think
> a little more than necessary.

At least I have the same question here. For me I think it's
unnecessary to use a pointer.

>
> In any case, I would move the variable usage inside the
> 'if (!rsvd)' block.
>
> >       if (hugetlb_cgroup_disabled() || !h_cg)
> >               return;
> >
> >       __set_hugetlb_cgroup(page, h_cg, rsvd);
> > -     return;
> > +     if (!rsvd) {
> > +             usage = &h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
> > +             /*
> > +              * This write is not atomic due to fetching *usage and writing
> > +              * to it, but that's fine because we call this with
> > +              * hugetlb_lock held anyway.
> > +              */
> > +             WRITE_ONCE(*usage, *usage + nr_pages);
> > +     }
> >  }
> >
> >  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > @@ -316,6 +355,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> >                                          struct page *page, bool rsvd)
> >  {
> >       struct hugetlb_cgroup *h_cg;
> > +     unsigned long *usage;
>
> Same here.
>
> Otherwise, looks good to me.
> --
> Mike Kravetz
