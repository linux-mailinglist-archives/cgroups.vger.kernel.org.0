Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C96F4AD6
	for <lists+cgroups@lfdr.de>; Tue,  2 May 2023 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjEBUDm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 May 2023 16:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEBUDl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 May 2023 16:03:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5C19BE
        for <cgroups@vger.kernel.org>; Tue,  2 May 2023 13:03:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so4718932a12.1
        for <cgroups@vger.kernel.org>; Tue, 02 May 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683057813; x=1685649813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCmu6qJCqnK26c1deDSnWNiRLvDncJpAwXbw3DsD1H0=;
        b=pqf6ltCtonpo0hWTk+tyOCHgD+RYIJ12oHdI6QmZrUfT7NPEmyLill6sm5+6dPj+Tz
         pqZDLLbb3Hq2kaw+lNE0EODy7A/PhqcNFg5TRSGVsIQKpOHuvDLL9zlCAniV5QQrfG+H
         ijq43v/41RQjWHS1B8oNjicdUFX7hVq66Tu/gG5S4u70V+whOoZ+ai5i2neqELYsirkl
         3t6puujOyclixrlAFHpG7c4/GkOeYvE75+Ks/UDL+AeXmLmNNH0EyKfCe90bsVo6U7vH
         HEYUPzSchNLylhLhBbd14E0uFWwAcTEUSdZpI6w4W9qDzWucrjNMYlt2+xDRbjibRIa9
         JYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683057813; x=1685649813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCmu6qJCqnK26c1deDSnWNiRLvDncJpAwXbw3DsD1H0=;
        b=OvhfYx9dauj/cr5oUwYAY9DMZMATa2b33bYMX45JtTlm3IO0Zf6mgefDMZLhGHPksy
         OQznhiMPXc05tJM7xXqQomIk+w5djMJccdjZKJ9Yb65RIyRFfjiyOVXJwkhAd3WB49zH
         dORHqPynU1y80MPbzmMKT4+uDJ/pYX7+AqNju1ps8B3yCMwX9WiKIZv2kST+LSoRCiX8
         bEtIWD1iD9su/dIhCpVqnDTYX4LxdXRy36d6pKn7daKgStk2kZmP1+R4QKtR9ir0XUEe
         kVB2o1/8/uZDo+b05NFvCzyLm62MlnSkZB+5lRk8GM02JFinCrvgjA9K+5G07EIWWwZC
         YfJw==
X-Gm-Message-State: AC+VfDxEwuayWxrm8BVs3YKhcyunvtab6BpetstwOc6DFWDQkunGfhTm
        vtnF5nM9X3o7CJ++btiS/UIDYcEu2y/YEKZr1CzowQ==
X-Google-Smtp-Source: ACHHUZ6NcKVWsYc7b9eUbj3dSDAEnYw8H3QngzDTlOIRnhvBdio/EO0cCLs8XDByFfm99Wvr+XLrLBjChZ1KIGjDrwI=
X-Received: by 2002:a05:6402:183:b0:50a:11ce:4d24 with SMTP id
 r3-20020a056402018300b0050a11ce4d24mr8939822edv.15.1683057813316; Tue, 02 May
 2023 13:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
 <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com> <ZE/q+ZFWLEa6C6rq@P9FQF9L96D>
In-Reply-To: <ZE/q+ZFWLEa6C6rq@P9FQF9L96D>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 2 May 2023 13:02:56 -0700
Message-ID: <CAJD7tkbT+J_LZUUtq2JxQ5LEO4iigL0zoGf-KBQc6Wj3hffmFw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 1, 2023 at 9:38=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> On Tue, Apr 25, 2023 at 04:36:53AM -0700, Yosry Ahmed wrote:
> >  +David Rientjes +Greg Thelen +Matthew Wilcox
>
> Hi Yosry!
>
> Sorry for being late to the party, I was offline for a week.
>
> >
> > On Tue, Apr 11, 2023 at 4:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Apr 11, 2023 at 4:36=E2=80=AFPM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > >
> > > > When a memcg is removed by userspace it gets offlined by the kernel=
.
> > > > Offline memcgs are hidden from user space, but they still live in t=
he
> > > > kernel until their reference count drops to 0. New allocations cann=
ot
> > > > be charged to offline memcgs, but existing allocations charged to
> > > > offline memcgs remain charged, and hold a reference to the memcg.
> > > >
> > > > As such, an offline memcg can remain in the kernel indefinitely,
> > > > becoming a zombie memcg. The accumulation of a large number of zomb=
ie
> > > > memcgs lead to increased system overhead (mainly percpu data in str=
uct
> > > > mem_cgroup). It also causes some kernel operations that scale with =
the
> > > > number of memcgs to become less efficient (e.g. reclaim).
>
> The problem is even more fundamental:
> 1) offline memcgs are (almost) fully functional memcgs from the kernel's =
point
>    of view,
> 2) if memcg A allocates some memory, goes offline and now memcg B is usin=
g this
>    memory, the memory is effectively shared between memcgs A and B,
> 3) sharing memory was never really supported by memcgs.
>
> If memory is shared between memcgs, most memcg functionality is broken as=
ide
> from a case when memcgs are working in a very predictable and coordinated=
 way.
> But generally all counters and stats become racy (whoever allocated it fi=
rst,
> pays the full price, other get it for free), and memory limits and protec=
tions
> are based on the same counters.
>
> Depending on % memory shared, the rate at which memcg are created and des=
troyed,
> memory pressure and other workload-depending factors the problem can be
> significant or not.
>
> One way to tackle this problem is to stop using memcgs as wrappers for
> individual processes or workloads and use them more as performance classe=
s.
> This means more statically and with less memory sharing.
> However I admit it's the opposite direction to where all went for the
> last decade or so.
>
> > > >
> > > > There are currently out-of-tree solutions which attempt to
> > > > periodically clean up zombie memcgs by reclaiming from them. Howeve=
r
> > > > that is not effective for non-reclaimable memory, which it would be
> > > > better to reparent or recharge to an online cgroup. There are also
> > > > proposed changes that would benefit from recharging for shared
> > > > resources like pinned pages, or DMA buffer pages.
> > >
> > > I am very interested in attending this discussion, it's something tha=
t
> > > I have been actively looking into -- specifically recharging pages of
> > > offlined memcgs.
> > >
> > > >
> > > > Suggested attendees:
> > > > Yosry Ahmed <yosryahmed@google.com>
> > > > Yu Zhao <yuzhao@google.com>
> > > > T.J. Mercier <tjmercier@google.com>
> > > > Tejun Heo <tj@kernel.org>
> > > > Shakeel Butt <shakeelb@google.com>
> > > > Muchun Song <muchun.song@linux.dev>
> > > > Johannes Weiner <hannes@cmpxchg.org>
> > > > Roman Gushchin <roman.gushchin@linux.dev>
> > > > Alistair Popple <apopple@nvidia.com>
> > > > Jason Gunthorpe <jgg@nvidia.com>
> > > > Kalesh Singh <kaleshsingh@google.com>
> >
> > I was hoping I would bring a more complete idea to this thread, but
> > here is what I have so far.
> >
> > The idea is to recharge the memory charged to memcgs when they are
> > offlined. I like to think of the options we have to deal with memory
> > charged to offline memcgs as a toolkit. This toolkit includes:
> >
> > (a) Evict memory.
> >
> > This is the simplest option, just evict the memory.
> >
> > For file-backed pages, this writes them back to their backing files,
> > uncharging and freeing the page. The next access will read the page
> > again and the faulting process=E2=80=99s memcg will be charged.
> >
> > For swap-backed pages (anon/shmem), this swaps them out. Swapping out
> > a page charged to an offline memcg uncharges the page and charges the
> > swap to its parent. The next access will swap in the page and the
> > parent will be charged. This is effectively deferred recharging to the
> > parent.
> >
> > Pros:
> > - Simple.
> >
> > Cons:
> > - Behavior is different for file-backed vs. swap-backed pages, for
> > swap-backed pages, the memory is recharged to the parent (aka
> > reparented), not charged to the "rightful" user.
> > - Next access will incur higher latency, especially if the pages are ac=
tive.
>
> Generally I think it's a good solution iff there is not much of memory sh=
aring
> with other memcgs. But in practice there is a high chance that some very =
hot
> pages (e.g. shlib pages shared by pretty much everyone) will get evicted.

One other thing that I recently noticed. If a memcg has some pages
swapped out, or if userspace deliberately tries to free memory from a
memcg before removing it, then the memcg is offlined, then the swapped
pages will hold the memcg hostage until the next fault recharges or
reparents them.

If the pages are truly cold, this can take a while (or never happen).

Separate from recharging, one thing we can do is have a kthread loop
over swap_cgroup and reparent swap entries charged to offline memcgs
to unpin them. Ideally, we will mark those entries such that they get
recharged upon the next fault instead of just keeping them at the
parent.

Just thinking out loud here.

>
> >
> > (b) Direct recharge to the parent
> >
> > This can be done for any page and should be simple as the pages are
> > already hierarchically charged to the parent.
> >
> > Pros:
> > - Simple.
> >
> > Cons:
> > - If a different memcg is using the memory, it will keep taxing the
> > parent indefinitely. Same not the "rightful" user argument.
>
> It worked for slabs and other kmem objects to reduce the severity of the =
memcg
> zombie clogging. Muchun posted patches for lru pages. I believe it's a de=
cent
> way to solve the zombie problem, but it doesn't solve any issues with the=
 memory
> sharing.
>
> >
> > (c) Direct recharge to the mapper
> >
> > This can be done for any mapped page by walking the rmap and
> > identifying the memcg of the process(es) mapping the page.
> >
> > Pros:
> > - Memory is recharged to the =E2=80=9Crightful=E2=80=9D user.
> >
> > Cons:
> > - More complicated, the =E2=80=9Crightful=E2=80=9D user=E2=80=99s memcg=
 might run into an OOM
> > situation =E2=80=93 which in this case will be unpredictable and hard t=
o
> > correlate with an allocation.
> >
> > (d) Deferred recharging
> >
> > This is a mixture of (b) & (c) above. It is a two-step process. We
> > first recharge the memory to the parent, which should be simple and
> > reliable. Then, we mark the pages so that the next time they are
> > accessed or mapped we recharge them to the "rightful" user.
> >
> > For mapped pages, we can use the numa balancing approach of protecting
> > the mapping (while the vma is still accessible), and then in the fault
> > path recharge the page. This is better than eviction because the fault
> > on the next access is minor, and better than direct recharging to the
> > mapping in the sense that the charge is correlated with an
> > allocation/mapping. Of course, it is more complicated, we have to
> > handle different protection interactions (e.g. what if the page is
> > already protected?). Another disadvantage is that the recharging
> > happens in the context of a page fault, rather than asynchronously in
> > the case of directly recharging to the mapper. Page faults are more
> > latency sensitive, although this shouldn't be a common path.
> >
> > For unmapped pages, I am struggling to find a way that is simple
> > enough to recharge the memory on the next access. My first intuition
> > was to add a hook to folio_mark_accessed(), but I was quickly told
> > that this is not invoked in all access paths to unmapped pages (e.g.
> > writes through fds). We can also add a hook to folio_mark_dirty() to
> > add more coverage, but it seems like this path is fragile, and it
> > would be ideal if there is a shared well-defined common path (or
> > paths) for all accesses to unmapped pages. I would imagine if such a
> > path exists or can be forged it would probably be in the page cache
> > code somewhere.
>
> The problem is that we'd need to add hooks and checks into many hot paths=
,
> so the performance penalty will be likely severe.
> But of course hard to tell without actual patches.
> >
> > For both cases, if a new mapping is created, we can do recharging there=
.
> >
> > Pros:
> > - Memory is recharged to the =E2=80=9Crightful=E2=80=9D user, eventuall=
y.
> > - The charge is predictable and correlates to a user's access.
> > - Less overhead on next access than eviction.
> >
> > Cons:
> > - The memory will remain charged to the parent until the next access
> > happens, if it ever happens.
> > - Worse overhead on next access than directly recharging to the mapper.
> >
> > With this (incompletely defined) toolkit, a recharging algorithm can
> > look like this (as a rough example):
> >
> > - If the page is file-backed:
> >   - Unmapped? evict (a).
> >   - Mapped? recharge to the mapper -- direct (c) or deferred (d).
> > - If the page is swap-backed:
> >   - Unmapped? deferred recharge to the next accessor (d).
> >   - Mapped? recharge to the mapper -- direct (c) or deferred (d).
> >
> > There are, of course, open questions:
> > 1) How do we do deferred recharging for unmapped pages? Is deferred
> > recharging even a reliable option to begin with? What if the pages are
> > never accessed again?
>
> I believe the real question is how to handle memory shared between memcgs=
.
> Dealing with offline memcgs is just a specific case of this problem.
> >
> > Again, I was hoping to come up with a more concrete proposal, but as
> > LSF/MM/BPF is approaching, I wanted to share my thoughts on the
> > mailing list looking for any feedback.
>
> Thank you for bringing it in!
