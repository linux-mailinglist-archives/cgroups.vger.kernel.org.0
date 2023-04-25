Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB426EE7D4
	for <lists+cgroups@lfdr.de>; Tue, 25 Apr 2023 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjDYSzH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Apr 2023 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjDYSyv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Apr 2023 14:54:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0909149D8
        for <cgroups@vger.kernel.org>; Tue, 25 Apr 2023 11:54:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so10988867a12.0
        for <cgroups@vger.kernel.org>; Tue, 25 Apr 2023 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682448838; x=1685040838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWVSQZ+0SzhYTj35AIqktL1T3erQBqIEznyQOxJFUF8=;
        b=cpBNalHy/F3AiuVvLY/LRZPtUf6B98St0z5R90iAuyRryxYnpzm2DpkqmUbG8mw4xX
         8geNDh5t1gL5S1EASloVvEyUcdUFqfWw4lsjk5EECiG9jusf+0ECM0njqOtOp7kd+YfX
         REqXAzY9/uabyFdd57SQ7/z70a/gUpxxdheY3AVgbrn5pFZKbsYLHI/Ahr4vKbChiVu7
         JIBisb8xwEGvnpkK/nQdfwPYiA4zg9N6wzOgXjF2+e10oYKOmhHukQXDTjTmk6dW862G
         V0BqDyUtnqPI9o31BL/0K8k4vgZjgZesOlo5yWaOW7YvfLN+/fgGko9m2MSK5iZvd1ve
         liEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448838; x=1685040838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWVSQZ+0SzhYTj35AIqktL1T3erQBqIEznyQOxJFUF8=;
        b=KFnS7L3r5VvZdITUcEKJjDGCuI14UgN0zpWW+8pajGUzVOPhAU8zSJMX/gI4HhCmZ/
         t01QuLBAbfCbRA0wdq2N8vQ/tWv9cUXHct23iqNPmHf0xt7mDBI0TdBHRL3xuw8/rAOz
         fzm4TroO2ez2Yfx1cibvlnDI+bjYJuv7nK2nJeV1lIUPRxwqK9iEkUUwgrbDcRv3CSPW
         eHS8R/apSPBRPpJevJl5A8siaBtK+6mw3hv9Plk89htuD3sZaYOw54zKEVgQk30aew7j
         7DGbrPNsd+QAgPPutFd52n0gP8/KVLbIRNezA3TBIsHm2B4TNhdxMTVKL1eBX84mXs81
         OcGw==
X-Gm-Message-State: AAQBX9e0jBdxE7pUfMyj4vIh+nwcNH2/AlyB5bLm6qP7ukSKR96zwMnw
        FbU91vbvwqTMDo9AMODMlA7Z5s5+k3Yoi8kgS6Miag==
X-Google-Smtp-Source: AKy350Z1qww47AFUaPBEGfnK2/230aRH/MUVTIXc38GkRqgDyZUj8915JYrxzn6zTU/52TUZdwAa0b/2BnuqP5f/uhI=
X-Received: by 2002:a05:6402:1355:b0:502:2a76:5781 with SMTP id
 y21-20020a056402135500b005022a765781mr15269266edw.5.1682448838046; Tue, 25
 Apr 2023 11:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
 <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com> <27e15be8-d0eb-ed32-a0ec-5ec9b59f1f27@redhat.com>
In-Reply-To: <27e15be8-d0eb-ed32-a0ec-5ec9b59f1f27@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Apr 2023 11:53:21 -0700
Message-ID: <CAJD7tkb1W0bP3AU9KepOYPx-AD-fMKSfUhj_Cmth63RS9umMsg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     Waiman Long <longman@redhat.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
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

On Tue, Apr 25, 2023 at 11:42=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
> On 4/25/23 07:36, Yosry Ahmed wrote:
> >   +David Rientjes +Greg Thelen +Matthew Wilcox
> >
> > On Tue, Apr 11, 2023 at 4:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >> On Tue, Apr 11, 2023 at 4:36=E2=80=AFPM T.J. Mercier <tjmercier@google=
.com> wrote:
> >>> When a memcg is removed by userspace it gets offlined by the kernel.
> >>> Offline memcgs are hidden from user space, but they still live in the
> >>> kernel until their reference count drops to 0. New allocations cannot
> >>> be charged to offline memcgs, but existing allocations charged to
> >>> offline memcgs remain charged, and hold a reference to the memcg.
> >>>
> >>> As such, an offline memcg can remain in the kernel indefinitely,
> >>> becoming a zombie memcg. The accumulation of a large number of zombie
> >>> memcgs lead to increased system overhead (mainly percpu data in struc=
t
> >>> mem_cgroup). It also causes some kernel operations that scale with th=
e
> >>> number of memcgs to become less efficient (e.g. reclaim).
> >>>
> >>> There are currently out-of-tree solutions which attempt to
> >>> periodically clean up zombie memcgs by reclaiming from them. However
> >>> that is not effective for non-reclaimable memory, which it would be
> >>> better to reparent or recharge to an online cgroup. There are also
> >>> proposed changes that would benefit from recharging for shared
> >>> resources like pinned pages, or DMA buffer pages.
> >> I am very interested in attending this discussion, it's something that
> >> I have been actively looking into -- specifically recharging pages of
> >> offlined memcgs.
> >>
> >>> Suggested attendees:
> >>> Yosry Ahmed <yosryahmed@google.com>
> >>> Yu Zhao <yuzhao@google.com>
> >>> T.J. Mercier <tjmercier@google.com>
> >>> Tejun Heo <tj@kernel.org>
> >>> Shakeel Butt <shakeelb@google.com>
> >>> Muchun Song <muchun.song@linux.dev>
> >>> Johannes Weiner <hannes@cmpxchg.org>
> >>> Roman Gushchin <roman.gushchin@linux.dev>
> >>> Alistair Popple <apopple@nvidia.com>
> >>> Jason Gunthorpe <jgg@nvidia.com>
> >>> Kalesh Singh <kaleshsingh@google.com>
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
> Muchun had actually posted patch to do this last year. See
>
> https://lore.kernel.org/all/20220621125658.64935-10-songmuchun@bytedance.=
com/T/#me9dbbce85e2f3c4e5f34b97dbbdb5f79d77ce147
>
> I am wondering if he is going to post an updated version of that or not.
> Anyway, I am looking forward to learn about the result of this
> discussion even thought I am not a conference invitee.

There are a couple of problems that were brought up back then, mainly
that memory will be reparented to the root memcg eventually,
practically escaping accounting. Shared resources may end up being
eventually unaccounted. Ideally, we can come up with a scheme where
the memory is charged to the real user, instead of just to the parent.

Consider the case where processes in memcg A and B are both using
memory that is charged to memcg A. If memcg A goes offline, and we
reparent the memory, memcg B keeps using the memory for free, taxing
A's parent, or the entire system if that's root.

Also, if there is a kernel bug and a page is being pinned
unnecessarily, those pages will never be reclaimed and will stick
around and eventually be reparented to the root memcg. If being
reparented to the root memcg is a legitimate action, you can't simply
tell apart if pages are sticking around just because they are being
used by someone or if there is a kernel bug.

>
> Thanks,
> Longman
>
>
