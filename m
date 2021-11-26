Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F845E819
	for <lists+cgroups@lfdr.de>; Fri, 26 Nov 2021 07:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhKZG46 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Nov 2021 01:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358952AbhKZGy6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Nov 2021 01:54:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2DC06174A;
        Thu, 25 Nov 2021 22:50:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so34553221eda.12;
        Thu, 25 Nov 2021 22:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVuV06/cptT1Gv9Nh1FCyXLQ2/5cgjt2/gcb2z+eqVY=;
        b=NvnXTWQqpYcTMVuD/hsfAtDmpuu+159ataecL65048pQEZJcW1YIc7s5YEaFfEZGAW
         /SUci0G1FbsjMC+hkIVIWnWr/UPWSnRjfi3vQ0f07Cn8F0EeO26cWcoegxBTy/waVH07
         C29dFdUQ4y2VtroOGkyY5QXddXMHOoygQHbZUS8z7zWOqe9JSHmlNDn6ccUYlT7aE7DV
         vqlvFmbMawXR/u4MfEcmX3vC6zYORDG/15A/keH8mUPrRGYZrGL/ofp3RIYLXypI8sKb
         aVNnenQOgPIyfeH8eN/8ZFRgHNZgUTk7I3g1VjFL5n0EZRZliRY5uJ2t1uxW3KY3L2he
         52JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVuV06/cptT1Gv9Nh1FCyXLQ2/5cgjt2/gcb2z+eqVY=;
        b=UE77qE1n00s/n3tGgTRh4ZBM9f0sg/9u+C8ezNK2eAHkvF1scnPz3xvcCc9AcFu2wO
         hsFPKpzkPgICuieFDpcpO/EY4CauFEK4b3FqMnU2SMHNQr1H8Bu5EemE21MqGSPQiCpb
         wQ1Pf5CFUxpKX7f5Yw00u4mCwVRNDr7l8N2/mHjFri/UM/PP95cITlyuk21ybOaoCJD3
         QICwWgy55IARZn6FGevlMiKm7+YC1vtERaaxlN0dJmd+SNW5X1QZ/w9mFYXQrmNjWINY
         YsL5T1eY4/AvhEwWlInXtmVANFptqBf2Ky8cA/YnhAuMVjPK1uJCzQwxt0/ZI49xrT9S
         ivmg==
X-Gm-Message-State: AOAM5333U7gSWaQI9AvDUFKYo0hjIxxEyvY2GUYv08yL4/cdCrr3sQyW
        Vv8f/sUaU2XzPjeaEFjv7qy/98RMid/FRSWdFF8=
X-Google-Smtp-Source: ABdhPJx8X9vyVj6yDpfeRKFVlX9L8cA2ZOAn2GLHThn+GMMqesR17BemqeE/O4inXNH4tiAq2g4YGiyfL2Y6jfftL7A=
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr37820887ejc.234.1637909455616;
 Thu, 25 Nov 2021 22:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20211124151915.GA6163@haolee.io> <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org> <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz> <20211125123133.GA7758@haolee.io> <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
In-Reply-To: <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Fri, 26 Nov 2021 14:50:44 +0800
Message-ID: <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 25, 2021 at 10:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 25-11-21 12:31:33, Hao Lee wrote:
> > On Thu, Nov 25, 2021 at 11:01:02AM +0100, Michal Hocko wrote:
> > > On Thu 25-11-21 08:02:38, Hao Lee wrote:
> > > > On Thu, Nov 25, 2021 at 03:30:44AM +0000, Matthew Wilcox wrote:
> > > > > On Thu, Nov 25, 2021 at 11:24:02AM +0800, Hao Lee wrote:
> > > > > > On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > We do batch currently so no single task should be
> > > > > > > able to monopolize the cpu for too long. Why this is not sufficient?
> > > > > >
> > > > > > uncharge and unref indeed take advantage of the batch process, but
> > > > > > del_from_lru needs more time to complete. Several tasks will contend
> > > > > > spinlock in the loop if nr is very large.
> > > > >
> > > > > Is SWAP_CLUSTER_MAX too large?  Or does your architecture's spinlock
> > > > > implementation need to be fixed?
> > > > >
> > > >
> > > > My testing server is x86_64 with 5.16-rc2. The spinlock should be normal.
> > > >
> > > > I think lock_batch is not the point. lock_batch only break spinning time
> > > > into small parts, but it doesn't reduce spinning time. The thing may get
> > > > worse if lock_batch is very small.
> > > >
> > > > Here is an example about two tasks contending spinlock. Let's assume each
> > > > task need a total of 4 seconds in critical section to complete its work.
> > > >
> > > > Example1:
> > > >
> > > > lock_batch = x
> > > >
> > > > task A      taskB
> > > > hold 4s     wait 4s
> > > >             hold 4s
> > > >
> > > > total waiting time is 4s.
> > >
> > > 4s holding time is _way_ too long and something that this path should
> > > never really reach. We are talking about SWAP_CLUSTER_MAX worth of LRU
> > > pages. Sure there might be a bunch of pages freed that are not on LRU
> > > but those are only added to a list. So again what is the actual problem?
> > >
> >
> > The measurement unit in my example may not be rigorous and may confuse you.
> > What I mean is the batch processing can only gives each task fairness to
> > compete for this spinlock, but it can't reduce the wasted cpu cycles during
> > spinning waiting, no matter what the batch size is.
>
> Correct. But isn't that a nature of pretty much any spinlock based
> contention? There is not really much to be done except for removing the
> lock.

Yes...

> Batching helps to amortize the spinning for the actual useful work
> so that the spinning is not predominant. Trylocking to reduce that
> spinning can be helpful only if you _know_ that other useful work could
> be done and that you do not dalay the locked work way to much. This is a
> tricky balance to make.

Exactly, thanks for explanation.

>
> > No matter what the
> > lock_batch is set, the following perf report won't change much. Many cpu
> > cycles are wasted on spinning. Other tasks running on the same cores will be
> > delayed, which is unacceptable for our latency-critical jobs.
>
> Could you share more about requirements for those? Why is unmapping in
> any of their hot paths which really require low latencies? Because as
> long as unmapping requires a shared resource - like lru lock - then you
> have a bottle necks.

We deploy best-effort (BE) jobs (e.g. bigdata, machine learning) and
latency-critical (LC) jobs (e.g. map navigation, payments services) on the
same servers to improve resource utilization. The running time of BE jobs are
very short, but its memory consumption is large, and these jobs will run
periodically. The LC jobs are long-run services and are sensitive to delays
because jitters may cause customer churn.

If a batch of BE jobs are finished simultaneously, lots of memory are freed,
and spinlock contentions happen. BE jobs don't care about these contentions,
but contentions cause them to spend more time in kernel mode, and thus, LC
jobs running on the same cpu cores will be delayed and jitters occur. (The
kernel preemption is disabled on our servers, and we try not to separate
LC/BE using cpuset in order to achieve "complete mixture deployment"). Then
LC services people will complain about the poor service stability. This
scenario has occurred several times, so we want to find a way to avoid it.

>
> > I'm trying to
> > find if it's possible to reduce the delay and the contention , after all,
> > 59.50% is too high. This is why I post the thoughtless `cond_resched()`
> > approach.
>
> What is the base for that 59.5%? Also how representative this is for
> your sensitive workload?

Unfortunately, we haven't found an accurate relationship between the
acceptable jitters and the perf percentage. A reference datum is indeed
essential, and we will try to setup it. Thanks for your tips.

>
> > Here is the perf report when executing ./usemem -j 4096 -n 20 10g -s 5
> >
> > +   59.50%  usemem           [kernel.vmlinux]               [k] native_queued_spin_lock_slowpath
> > +    4.36%  usemem           [kernel.vmlinux]               [k] check_preemption_disabled
> > +    4.31%  usemem           [kernel.vmlinux]               [k] free_pcppages_bulk
> > +    3.11%  usemem           [kernel.vmlinux]               [k] release_pages
> > +    2.12%  usemem           [kernel.vmlinux]               [k] __mod_memcg_lruvec_state
> > +    2.02%  usemem           [kernel.vmlinux]               [k] __list_del_entry_valid
> > +    1.98%  usemem           [kernel.vmlinux]               [k] __mod_node_page_state
> > +    1.67%  usemem           [kernel.vmlinux]               [k] unmap_page_range
> > +    1.51%  usemem           [kernel.vmlinux]               [k] __mod_zone_page_state
> --
> Michal Hocko
> SUSE Labs
