Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFB78CD30
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbjH2Tyt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbjH2Tys (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 15:54:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA31B1
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 12:54:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c1f6f3884so604648466b.0
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693338883; x=1693943683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS8wm+PwrYrwUTMQlW3v50ZjmTvczTiXAPTMj19pd5g=;
        b=0Uj4hiyD8KE3hrsyulPL5asvgMgaBKSy+BAWnDGCD8ytOd5fBvOdwATwF85XlL8dNs
         fH/+4gkniOJqPmRr0CUBzdlypSfNmDRij6iLAcsUVRrlvsyml0jnC2XGfJtnoWmWjqK/
         m50yWyf3+e+rmP+2U1U3Mg1JnzmfYHXZ9P5xfaJIucZy9cIVvSGzqOXBLLzY1bMJQDtX
         StYPw5goE+OIOBrMh1nx0/r2YvCoonxJ+iN54ZlxfvY9hX7WMNQKqTCsenogvEgBRQgD
         uhNPwC9phlN7ldkjG0MP3GfGYYQLIYz1Ecjk8v4K4xLPFhzW/WB5+byL0YOsz26EFXAt
         1emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338883; x=1693943683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qS8wm+PwrYrwUTMQlW3v50ZjmTvczTiXAPTMj19pd5g=;
        b=NhVeyG8AVYsf9E7s1FUHzPMzK6twmqA52BQOD/isCsy6qSwV57J8+2rBvMoawovNAT
         q6kN5YhopD0z5FdegpT2Y5/02k/quFPw5IujopQytJTEfPae4FaiNc1jREXxUP9w9u13
         85eorog6UxGa57fnbTEvB70QqaTZEb2B6LolWmQO7y7AnnA6Ry/Inw+1fG+ZoQygCSVL
         h8W7ye3cMUXOYjXIveUGSd2yMAPEgoxjOSk4R15Glig2BCKWdS2Sw2n6SGve28omYrmk
         qROgXBXsLLvnFqjgNK/Xw2Y/8NDXai2c5icpgLNxKTOKEATCLCM6zTlC3q+MBnyNU2cb
         HHsw==
X-Gm-Message-State: AOJu0YyDwLwxm5M5elenyyURVe0aQPzVE1jkPU9sKpc7meY7qWflpTwG
        r+2XWrkqiDL14qxkV2nwzCaJtx3pngi9EjtRF54AwA==
X-Google-Smtp-Source: AGHT+IF/bP33r8nxFhzGbH4f/UdtvUsaJrgxsfN1xW8nQcu8YVg54w9L7NvNVW9v728gatKoPL+n/BstGTkCFkrHU34=
X-Received: by 2002:a17:906:5393:b0:9a1:cbe4:d033 with SMTP id
 g19-20020a170906539300b009a1cbe4d033mr20710ejo.53.1693338883252; Tue, 29 Aug
 2023 12:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZOR6eyYfJYlxdMet@dhcp22.suse.cz> <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <ZO48h7c9qwQxEPPA@slm.duckdns.org>
 <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com> <ZO5IuULSCXMe9_pN@slm.duckdns.org>
In-Reply-To: <ZO5IuULSCXMe9_pN@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 29 Aug 2023 12:54:06 -0700
Message-ID: <CAJD7tkYtnhemCLBqFqOVurfWEaCjKtyEM745JYRxFS0r5cpZwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 29, 2023 at 12:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 29, 2023 at 12:13:31PM -0700, Yosry Ahmed wrote:
> ...
> > > So, the assumptions in the original design were:
> > >
> > > * Writers are high freq but readers are lower freq and can block.
> > >
> > > * The global lock is mutex.
> > >
> > > * Back-to-back reads won't have too much to do because it only has to=
 flush
> > >   what's been accumulated since the last flush which took place just =
before.
> > >
> > > It's likely that the userspace side is gonna be just fine if we resto=
re the
> > > global lock to be a mutex and let them be. Most of the problems are c=
aused
> > > by trying to allow flushing from non-sleepable and kernel contexts.
> >
> > So basically restore the flush without disabling preemption, and if a
> > userspace reader gets preempted while holding the mutex it's probably
> > okay because we won't have high concurrency among userspace readers?
> >
> > I think Shakeel was worried that this may cause a priority inversion
> > where a low priority task is preempted while holding the mutex, and
> > prevents high priority tasks from acquiring it to read the stats and
> > take actions (e.g. userspace OOMs).
>
> We'll have to see but I'm not sure this is going to be a huge problem. Th=
e
> most common way that priority inversions are resolved is through work
> conservation - ie. the system just runs out of other things to do, so
> whatever is blocking the system gets to run and unblocks it. It only real=
ly
> becomes a problem when work conservation breaks down on CPU side which
> happens if the one holding the resource is 1. blocked on IOs (usually
> through memory allocation but can be anything) 2. throttled by cpu.max.
>
> #1 is not a factor here. #2 is but that is a factor for everything in the
> kernel and should really be solved from cpu.max side. So, I think in
> practice, this should be fine, or at least not worse than anything else.

If that's not a concern I can just append a patch that changes the
spinlock to a mutex to this series. Shakeel, wdyt?

>
> > > Would it
> > > make sense to distinguish what can and can't wait and make the latter=
 group
> > > always use cached value? e.g. even in kernel, during oom kill, waitin=
g
> > > doesn't really matter and it can just wait to obtain the up-to-date n=
umbers.
> >
> > The problem with waiting for in-kernel flushers is that high
> > concurrency leads to terrible serialization. Running a stress test
> > with 100s of reclaimers where everyone waits shows ~ 3x slowdowns.
> >
> > This patch series is indeed trying to formalize a distinction between
> > waiters who can wait and those who can't on the memcg side:
> >
> > - Unified flushers always flush the entire tree and only flush if no
> > one else is flushing (no waiting), otherwise they use cached data and
> > hope the concurrent flushing helps. This is what we currently do for
> > most memcg contexts. This patch series opts userspace reads out of it.
> >
> > - Non-unified flushers only flush the subtree they care about and they
> > wait if there are other flushers. This is what we currently do for
> > some zswap accounting code. This patch series opts userspace readers
> > into this.
> >
> > The problem Michal is raising is that dropping the lock can lead to an
> > unbounded number of waiters and longer worst case latency. Especially
> > that this is directly influenced by userspace. Reintroducing the mutex
> > and removing the lock dropping code fixes that problem, but then if
> > the mutex holder gets preempted, we face another problem.
> >
> > Personally I think there is a good chance there won't be userspace
> > latency problems due to the lock as usually there isn't high
> > concurrency among userspace readers, and we can deal with that problem
> > if/when it happens. So far no problem is happening for cpu.stat which
> > has the same potential problem.
>
> Maybe leave the global lock as-is and gate the userland flushers with a
> mutex so that there's only ever one contenting on the rstat lock from
> userland side?

Waiman suggested this as well. We can do that for sure, although I
think we should wait until we are sure it's needed.

One question. If whoever is holding that mutex is either flushing with
the spinlock held or spinning (i.e not sleepable or preemptable),
wouldn't this be equivalent to just changing the spinlock with a mutex
and disable preemption while holding it?
