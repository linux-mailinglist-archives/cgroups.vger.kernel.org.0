Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA54575B99C
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGTVd4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTVdz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 17:33:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBC2713
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 14:33:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99357737980so205358866b.2
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689888832; x=1690493632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+zX1bzsNkI0w4pR3H5aVCG6OfBqU8naraYStIVWSF8=;
        b=gTnuC4fXAxfL5c6Up6plbcrQtf7FKHa3JMqHzp4fQaIZs9BAU7DSP9RBRD8kfaprby
         7PM/C/nMYLbnYTEn2on3Gp8g2rXccV4oqyTTptnSQKmYl2RgvUKAhSZc1pdnaXm79pN/
         n0XfmbV4Kuc4fBaA1Syuq/uaRlj2UEM+ywUYy2DSo0FVUPVD3G0GeD48yMcH0pDYXHv1
         VUlX2xxNvRi4TJNe6LUvJtUU5Ay8w+K86np4gJYgx+M8kHBm6ToKixbj0Iq8R+dBW7/r
         /ItHmvbE56th06WI6rUnaFogKID7C25DD2kjdr0yxz1JrKxdtm792yTnLMMZTDQ3jv7+
         0tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888832; x=1690493632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+zX1bzsNkI0w4pR3H5aVCG6OfBqU8naraYStIVWSF8=;
        b=dAlz7H+uLyOk4E8/pW7i8q2PJkfvFxjagn/sCcWELloEIbKGcVwqjgCp3w3vwCLEdz
         XNcQN6DmcPlBXgIqmQd9ZMwg0Or+h45/F9vcN7Fn29J6oOs7ILsZlNQ5+TMpRLvHlLb9
         JWd8xgoo6+AHtASHMqe/gBJK75Fh0Qs70zp5XQ7IJ+epCm9+IwydbFmlhyfJRQAV554E
         afeWj+B8clji5bKXVCrfabjpfcn1m4fryLJ3/LWjpZw0F5vx3HtWJ3BnuvGBWaoWt75d
         MhF9p6SLkbdOvYArGaLkLIZmkz/cz+eEjQJRY5iPbj3j2aBQ023hWcIC4iPwO4CIAgm8
         36Vg==
X-Gm-Message-State: ABy/qLZ6YL9IZi3zq/n9mNv1ZKyb1XP9mP5ajbAqMdyrgWKB8BN4jKSA
        qODDWvQ4hFmSNOR5CFEuUfJsDMPrPVeZXN7yjGWYtA==
X-Google-Smtp-Source: APBJJlHClqjXEv232QGItn5yfuuiWOqyC8aEClANG7DWCGb/UZTeybGhmJoLhBKgxCs8lAv98ukjUkIhwEHMUSAyobY=
X-Received: by 2002:a17:906:74d6:b0:993:e695:b589 with SMTP id
 z22-20020a17090674d600b00993e695b589mr19488ejl.20.1689888831528; Thu, 20 Jul
 2023 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com> <20230720153515.GA1003248@cmpxchg.org>
In-Reply-To: <20230720153515.GA1003248@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 14:33:15 -0700
Message-ID: <CAJD7tkb7MKR=b09etEb4jPSMRKj=w1B2PSf3_vWyuWHh+iyppg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 8:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jul 20, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> > This patch series implements the proposal in LSF/MM/BPF 2023 conference
> > for reducing offline/zombie memcgs by memory recharging [1]. The main
> > difference is that this series focuses on recharging and does not
> > include eviction of any memory charged to offline memcgs.
> >
> > Two methods of recharging are proposed:
> >
> > (a) Recharging of mapped folios.
> >
> > When a memcg is offlined, queue an asynchronous worker that will walk
> > the lruvec of the offline memcg and try to recharge any mapped folios t=
o
> > the memcg of one of the processes mapping the folio. The main assumptio=
n
> > is that a process mapping the folio is the "rightful" owner of the
> > memory.
> >
> > Currently, this is only supported for evictable folios, as the
> > unevictable lru is imaginary and we cannot iterate the folios on it. A
> > separate proposal [2] was made to revive the unevictable lru, which
> > would allow recharging of unevictable folios.
> >
> > (b) Deferred recharging of folios.
> >
> > For folios that are unmapped, or mapped but we fail to recharge them
> > with (a), we rely on deferred recharging. Simply put, any time a folio
> > is accessed or dirtied by a userspace process, and that folio is charge=
d
> > to an offline memcg, we will try to recharge it to the memcg of the
> > process accessing the folio. Again, we assume this process should be th=
e
> > "rightful" owner of the memory. This is also done asynchronously to avo=
id
> > slowing down the data access path.
>
> I'm super skeptical of this proposal.

I expected this :)

>
> Recharging *might* be the most desirable semantics from a user pov,
> but only if it applies consistently to the whole memory footprint.
> There is no mention of slab allocations such as inodes, dentries,
> network buffers etc. which can be a significant part of a cgroup's
> footprint. These are currently reparented. I don't think doing one
> thing with half of the memory, and a totally different thing with the
> other half upon cgroup deletion is going to be acceptable semantics.

I think, as you say, recharging has the most desirable semantics
because the charge is maintained where it *should* be (with who is
actually using it). We simply cannot do that for kernel memory,
because we have no way of attributing it to a user. On the other hand,
we *can* attribute user memory to a user. Consistency is great, but
our inability to do (arguably) the right thing for one type of memory,
doesn't mean we shouldn't do it when we can. I would also argue that
user memory (anon/file pages) would commonly be the larger portion of
memory on a machine compared to kernel memory (e.g. slab).

>
> It appears this also brings back the reliability issue that caused us
> to deprecate charge moving. The recharge path has trylocks, LRU
> isolation attempts, GFP_ATOMIC allocations. These introduce a variable
> error rate into the relocation process,

Recharging is naturally best effort, because it's non-disruptive.
After a memcg dies, the kernel continuously tries to move the charges
away from it on every chance it gets. If it fails one time that's
fine, there will be other chances. Compared to the status quo, it is
definitely better than just leaving all the memory behind with the
zombie memcg. I would argue that over time (and accesses), most/all
memory should eventually get recharged. If not, something is not
working correctly, or a wrong assumption is being made.

> which causes pages that should
> belong to the same domain to be scattered around all over the place.

I strongly disagree with this point. Ideally, yes, memory charged to a
memcg would belong to the same domain. In practice, due to the first
touch charging semantics, this is far from the truth. For anonymous
memory, sure, they all belong to the same domain (mostly), the process
they belong to. But most of anonymous memory will go away when the
process dies anyway, the problem is mostly with shared resources (e.g.
file, tmpfs, ..). With file/tmpfs memory, the charging behavior is
random. The first memcg that touches a page gets charged for it.
Consequently, the file/tmpfs memory charged to a memcg would be a
mixture of pages from different files in different mounts, definitely
not a single domain. Perhaps with some workloads, where each memcg is
accessing different files, most memory charged to a memcg will belong
to the same domain, but in this case, recharging wouldn't move it away
anyway.

> It also means that zombie pinning still exists, but it's now even more
> influenced by timing and race conditions, and so less predictable.

It still exists, but it is improved. The kernel tries to move charges
away from zombies on every chance it gets instead of doing nothing
about it. It is less predictable, can't argue about this, but it can't
get worse, only better.

>
> There are two issues being conflated here:
>
> a) the problem of zombie cgroups, and
>
> b) who controls resources that outlive the control domain.
>
> For a), reparenting is still the most reasonable proposal. It's
> reliable for one, but it also fixes the problem fully within the
> established, user-facing semantics: resources that belong to a cgroup
> also hierarchically belong to all ancestral groups; if those resources
> outlive the last-level control domain, they continue to belong to the
> parents. This is how it works today, and this is how it continues to
> work with reparenting. The only difference is that those resources no
> longer pin a dead cgroup anymore, but instead are physically linked to
> the next online ancestor. Since dead cgroups have no effective control
> parameters anymore, this is semantically equivalent - it's just a more
> memory efficient implementation of the same exact thing.

I agree that reparenting is more deterministic and reliable, but there
are two major flaws off the top of my head:

(1) If a memcg touches a page one time and gets charged for it, the
charge is stuck in its hierarchy forever. It can get reparented, but
it will never be charged to whoever is actually using it again, unless
it is reclaimed and refaulted (in some cases).

Consider this hierarchy:
    root
  /       \
A        B
            \
            C

Consider a case where memcg C touches a library file once, and gets
charged for some memory, and then dies. The memory gets reparente to
memcg B. Meanwhile, memcg A is continuously using the memory that
memcg B is charged for. memcg B would be indefinitely taxed by memcg
A. The only way out is if memcg B hit its limit, and the pages get
reclaimed, and then refaulted and recharged to memcg A. In some cases
(e.g. tmpfs), even then the memory would still get charged to memcg B.
There is no way to get rid of the charge until the resource itself is
freed.

This problem exists today, even without reparenting, with the
difference being that the charge will remain with C instead of B.
Recharging offers a better alternative where the charge will be
correctly moved to A, the "rightful" owner.

(2) In the above scenario, when memcg B dies, the memory will be
reparented to the root. That's even worse. Now memcg A is using memory
that is not accounted for anywhere, essentially an accounting leak.
From an admin perspective, the memory charged to root is system
overhead, it is lost capacity. For long-living systems, as memcgs are
created and destroyed for different workloads, memory will keep
accumulating at the root. The machine will keep leaking capacity over
time, and accounting becomes less and less accurate as more memory
becomes charged to the root.

>
> b) is a discussion totally separate from this.

I would argue that the zombie problem is (at least partially) an
artifact of the shared/sticky resources problem. If all resources are
used by one memcg and do not outlive it, we wouldn't have zombies.

> We can argue what we
> want this behavior to be, but I'd argue strongly that whatever we do
> here should apply to all resources managed by the controller equally.

User memory and kernel memory are very different in nature. Ideally
yeah, we want to treat all resources equally. But user memory is
naturally more attributable to users and easier to account correctly
than kernel memory.

>
> It could also be argued that if you don't want to lose control over a
> set of resources, then maybe don't delete their control domain while
> they are still alive and in use.

This is easier said than done :) As I mentioned earlier, the charging
semantics are inherently indeterministic for shared resources (e.g.
file/tmpfs). The user cannot control or monitor which resources belong
to which control domain. Each memcg in the system could be charged for
one page from each file in a shared library for all that matters :)

> For example, when restarting a
> workload, and the new instance is expected to have largely the same
> workingset, consider reusing the cgroup instead of making a new one.

In a large fleet with many different jobs getting rescheduled and
restarted on different machines, it's really hard in practice to do
so. We can keep the same cgroup if the same workload is being
restarted on the same machine, sure, but most of the time there's a
new workload arriving or so. We can't reuse containers in this case.

>
> For the zombie problem, I think we should merge Muchun's patches
> ASAP. They've been proposed several times, they have Roman's reviews
> and acks, and they do not change user-facing semantics. There is no
> good reason not to merge them.

There are some, which I pointed out above.

All in all, I understand where you are coming from. Your concerns are
valid. Recharging is not a perfect approach, but it is arguably the
best we can do at this point. Being indeterministic sucks, but our
charging semantics are inherently indeterministic anyway.
