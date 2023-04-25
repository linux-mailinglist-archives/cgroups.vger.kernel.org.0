Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A96EE11F
	for <lists+cgroups@lfdr.de>; Tue, 25 Apr 2023 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjDYLhf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Apr 2023 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDYLhe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Apr 2023 07:37:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDD40F6
        for <cgroups@vger.kernel.org>; Tue, 25 Apr 2023 04:37:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so9744690a12.3
        for <cgroups@vger.kernel.org>; Tue, 25 Apr 2023 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682422651; x=1685014651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsngWKOv6aKbFUh03eXnVj16rHV0v3GvuIuES1vw7XQ=;
        b=sW7PePOlREhSSKOqwGhCAUa77Mfx2c0oO5NMs11uS6k4rpmQJiEZ+KnZAm+9x5JaWZ
         1pSVRErSatbvbV/KIHwODNwd4hoXQYP5XagVp9VVMamtMHynOgzq7Emtzvq5Ihq7l+cl
         2PYeEe9XuELLvkdd6eOYPwDg+Vq87Kno3Yq/heJacEBz3XMX1izHs47JdCGizKtfY7Fb
         tDfzeahJeIXAXFVGyNWmUL1vyTDbbG3iXv+iUSxi6aEdzikXWbDoM1VgQ2qPIC2QYGLD
         MLhv3M/4d707lxq4XD4KeTvYo/ZeOLhvJLLLMz77q8BWWOfaIeLGlQp6PT63pRu4n8Se
         8guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682422651; x=1685014651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsngWKOv6aKbFUh03eXnVj16rHV0v3GvuIuES1vw7XQ=;
        b=EYTqIScsGSH0fF9zCEFFwOzXFfdNmoaseoEe7XDP8YEpk7nU2J5KlFti6sK4WP3kfk
         qLHao4KU3zKgfKCrX9PiQAJuKvYVoSJw2jy/E1EVg5bNinDoYsee1r14xNsgyBPPf3gv
         6rTF+gBiUjxLBSNCPYRvfm+fj6MK3UoqIxvCDkE8ua4tsxVGMtwMN/z9Cm0H0S4wivX+
         RgUM2JAJ5AlSCG8/tG+9nrusDa0g6ssAMbQnbuWta9m3pHnSylUYd6szDjiGgghrzJgn
         umYFy5+L0r+KP3UKRyJugfLFBOOMXzxysFVmvBmghneCg+DC7+bHlKKedKpTY+6AyvhP
         5EKA==
X-Gm-Message-State: AAQBX9c6eNssf47RuyT6R9UF2ZYJW/izc24pFZNMMZalMrrx8Jw/tsGE
        Yeag4v/kIHjbfysX+xl2Mx12XZxk7obJcqV4YDXzcQ==
X-Google-Smtp-Source: AKy350Yg6SEFmKprABhEVr3p6HW18rpf5k+kUwjC6AJx8MMPu2bxEyZ4OcBslXi7LzdGYWirELU+zO7i56GB/ow95lE=
X-Received: by 2002:aa7:d744:0:b0:506:c2b2:72fc with SMTP id
 a4-20020aa7d744000000b00506c2b272fcmr12884048eds.7.1682422650405; Tue, 25 Apr
 2023 04:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
In-Reply-To: <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Apr 2023 04:36:53 -0700
Message-ID: <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

 +David Rientjes +Greg Thelen +Matthew Wilcox

On Tue, Apr 11, 2023 at 4:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Apr 11, 2023 at 4:36=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > When a memcg is removed by userspace it gets offlined by the kernel.
> > Offline memcgs are hidden from user space, but they still live in the
> > kernel until their reference count drops to 0. New allocations cannot
> > be charged to offline memcgs, but existing allocations charged to
> > offline memcgs remain charged, and hold a reference to the memcg.
> >
> > As such, an offline memcg can remain in the kernel indefinitely,
> > becoming a zombie memcg. The accumulation of a large number of zombie
> > memcgs lead to increased system overhead (mainly percpu data in struct
> > mem_cgroup). It also causes some kernel operations that scale with the
> > number of memcgs to become less efficient (e.g. reclaim).
> >
> > There are currently out-of-tree solutions which attempt to
> > periodically clean up zombie memcgs by reclaiming from them. However
> > that is not effective for non-reclaimable memory, which it would be
> > better to reparent or recharge to an online cgroup. There are also
> > proposed changes that would benefit from recharging for shared
> > resources like pinned pages, or DMA buffer pages.
>
> I am very interested in attending this discussion, it's something that
> I have been actively looking into -- specifically recharging pages of
> offlined memcgs.
>
> >
> > Suggested attendees:
> > Yosry Ahmed <yosryahmed@google.com>
> > Yu Zhao <yuzhao@google.com>
> > T.J. Mercier <tjmercier@google.com>
> > Tejun Heo <tj@kernel.org>
> > Shakeel Butt <shakeelb@google.com>
> > Muchun Song <muchun.song@linux.dev>
> > Johannes Weiner <hannes@cmpxchg.org>
> > Roman Gushchin <roman.gushchin@linux.dev>
> > Alistair Popple <apopple@nvidia.com>
> > Jason Gunthorpe <jgg@nvidia.com>
> > Kalesh Singh <kaleshsingh@google.com>

I was hoping I would bring a more complete idea to this thread, but
here is what I have so far.

The idea is to recharge the memory charged to memcgs when they are
offlined. I like to think of the options we have to deal with memory
charged to offline memcgs as a toolkit. This toolkit includes:

(a) Evict memory.

This is the simplest option, just evict the memory.

For file-backed pages, this writes them back to their backing files,
uncharging and freeing the page. The next access will read the page
again and the faulting process=E2=80=99s memcg will be charged.

For swap-backed pages (anon/shmem), this swaps them out. Swapping out
a page charged to an offline memcg uncharges the page and charges the
swap to its parent. The next access will swap in the page and the
parent will be charged. This is effectively deferred recharging to the
parent.

Pros:
- Simple.

Cons:
- Behavior is different for file-backed vs. swap-backed pages, for
swap-backed pages, the memory is recharged to the parent (aka
reparented), not charged to the "rightful" user.
- Next access will incur higher latency, especially if the pages are active=
.

(b) Direct recharge to the parent

This can be done for any page and should be simple as the pages are
already hierarchically charged to the parent.

Pros:
- Simple.

Cons:
- If a different memcg is using the memory, it will keep taxing the
parent indefinitely. Same not the "rightful" user argument.

(c) Direct recharge to the mapper

This can be done for any mapped page by walking the rmap and
identifying the memcg of the process(es) mapping the page.

Pros:
- Memory is recharged to the =E2=80=9Crightful=E2=80=9D user.

Cons:
- More complicated, the =E2=80=9Crightful=E2=80=9D user=E2=80=99s memcg mig=
ht run into an OOM
situation =E2=80=93 which in this case will be unpredictable and hard to
correlate with an allocation.

(d) Deferred recharging

This is a mixture of (b) & (c) above. It is a two-step process. We
first recharge the memory to the parent, which should be simple and
reliable. Then, we mark the pages so that the next time they are
accessed or mapped we recharge them to the "rightful" user.

For mapped pages, we can use the numa balancing approach of protecting
the mapping (while the vma is still accessible), and then in the fault
path recharge the page. This is better than eviction because the fault
on the next access is minor, and better than direct recharging to the
mapping in the sense that the charge is correlated with an
allocation/mapping. Of course, it is more complicated, we have to
handle different protection interactions (e.g. what if the page is
already protected?). Another disadvantage is that the recharging
happens in the context of a page fault, rather than asynchronously in
the case of directly recharging to the mapper. Page faults are more
latency sensitive, although this shouldn't be a common path.

For unmapped pages, I am struggling to find a way that is simple
enough to recharge the memory on the next access. My first intuition
was to add a hook to folio_mark_accessed(), but I was quickly told
that this is not invoked in all access paths to unmapped pages (e.g.
writes through fds). We can also add a hook to folio_mark_dirty() to
add more coverage, but it seems like this path is fragile, and it
would be ideal if there is a shared well-defined common path (or
paths) for all accesses to unmapped pages. I would imagine if such a
path exists or can be forged it would probably be in the page cache
code somewhere.

For both cases, if a new mapping is created, we can do recharging there.

Pros:
- Memory is recharged to the =E2=80=9Crightful=E2=80=9D user, eventually.
- The charge is predictable and correlates to a user's access.
- Less overhead on next access than eviction.

Cons:
- The memory will remain charged to the parent until the next access
happens, if it ever happens.
- Worse overhead on next access than directly recharging to the mapper.

With this (incompletely defined) toolkit, a recharging algorithm can
look like this (as a rough example):

- If the page is file-backed:
  - Unmapped? evict (a).
  - Mapped? recharge to the mapper -- direct (c) or deferred (d).
- If the page is swap-backed:
  - Unmapped? deferred recharge to the next accessor (d).
  - Mapped? recharge to the mapper -- direct (c) or deferred (d).

There are, of course, open questions:
1) How do we do deferred recharging for unmapped pages? Is deferred
recharging even a reliable option to begin with? What if the pages are
never accessed again?

2) How do we avoid hiding kernel bugs (e.g. extraneous references)
with recharging? Ideally, all recharged pages eventually end up
somewhere other than root, such that accumulation of recharged pages
at root signals a kernel bug.

3) What do we do about swapped pages charged to offline memcgs? Even
if we recharge all charged pages, preexisting swap entries will pin
the offline memcg. Do we walk all swap_cgroup entries and reparent the
swap entries?

Again, I was hoping to come up with a more concrete proposal, but as
LSF/MM/BPF is approaching, I wanted to share my thoughts on the
mailing list looking for any feedback.

Thanks!
