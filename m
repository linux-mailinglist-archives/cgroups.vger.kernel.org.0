Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF578CCC5
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjH2TOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjH2TON (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 15:14:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E07E0
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 12:14:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c353a395cso616942566b.2
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693336448; x=1693941248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHgoXIRtSQrABCtZsUCGV3h62Vu637qEZw7XsfTCwms=;
        b=GWcr3CleTxMrMuRrQVOuGU9/9NcTqSLK6r2I/gv7fubRKQFKgvleCcfe1TcrLuhyjf
         Hh78t7A4Ff4d7owBrR406gUOZchXe7ygw6Frf24OKl59VWIIAMZYwQxiXjnDgw5oYH42
         RJeAYTxB2fDKWN1lX4AuX8ngn7xe3jE28DVs3q7iSjjnd3K9SIoDOvfdNskmJA+D7HZB
         QJ1/KRZsiRFNS2FLLTrIQeKl81YTfhMw6b6eLKwZorCjGm2IzPEWo2RxG6r0ZUnl3ixZ
         NHlRvUuIMfGK/ei3tx7Y6YQ1yQcIrKG66mGYBrT7p06ykotaKskFEALwmtCsC6eZzxSt
         Cc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693336448; x=1693941248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHgoXIRtSQrABCtZsUCGV3h62Vu637qEZw7XsfTCwms=;
        b=Qn0PZ+0E2+iEMd/VnXdG6cq81k10BO2kgARAOF9JqJFdmUzYfRAqToUJa9SVk+/GG/
         NzvG/r6Ht7gfklV9VuwknHA+ZVXhPiYgxQwbAoBuBR9nZuG51lznxe/eZuX3qkyl4OFS
         IkZlRmPntrRucGl9Q3vWiwAjgLE4pDyMoQi2Ty9o2RmyPQTRrnaH/rBmKAt7UowNkUSc
         B6ui9q0hBh1bgdjmSVFxxo3NNzF8drTL6DPxrXBm++UuhtLf5hnCLO+Ah6OufXWpUEV3
         vNGo84Qcjl0BNr9jj303j6sfQq/6grvr4L5wAYft9utmETyNI6be07ztRZ16aH/HScZy
         gWyw==
X-Gm-Message-State: AOJu0YxyiA92RxJ9raS7J7zpYx5EYtfNw5VBMtQz7exr4evmsgWdNCUw
        5PsQTH/mkVyzIzJ0xcrtxfBs8sXkv226m4afyac22A==
X-Google-Smtp-Source: AGHT+IF4/6s1D+KsIlmkZe48htUa9FgXMWRh9rjFF3eGngFd05g9b+pNFiGXRNiiINLy8JUbIXDoXjWOGX7H6SdNjxk=
X-Received: by 2002:a17:906:3193:b0:9a2:256a:65cd with SMTP id
 19-20020a170906319300b009a2256a65cdmr11655730ejy.4.1693336448130; Tue, 29 Aug
 2023 12:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com> <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <ZO48h7c9qwQxEPPA@slm.duckdns.org>
In-Reply-To: <ZO48h7c9qwQxEPPA@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 29 Aug 2023 12:13:31 -0700
Message-ID: <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
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

On Tue, Aug 29, 2023 at 11:44=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 25, 2023 at 09:05:46AM +0200, Michal Hocko wrote:
> > > > I think that's how it was always meant to be when it was designed. =
The
> > > > global rstat lock has always existed and was always available to
> > > > userspace readers. The memory controller took a different path at s=
ome
> > > > point with unified flushing, but that was mainly because of high
> > > > concurrency from in-kernel flushers, not because userspace readers
> > > > caused a problem. Outside of memcg, the core cgroup code has always
> > > > exercised this global lock when reading cpu.stat since rstat's
> > > > introduction. I assume there hasn't been any problems since it's st=
ill
> > > > there.
> >
> > I suspect nobody has just considered a malfunctioning or adversary
> > workloads so far.
> >
> > > > I was hoping Tejun would confirm/deny this.
> >
> > Yes, that would be interesting to hear.
>
> So, the assumptions in the original design were:
>
> * Writers are high freq but readers are lower freq and can block.
>
> * The global lock is mutex.
>
> * Back-to-back reads won't have too much to do because it only has to flu=
sh
>   what's been accumulated since the last flush which took place just befo=
re.
>
> It's likely that the userspace side is gonna be just fine if we restore t=
he
> global lock to be a mutex and let them be. Most of the problems are cause=
d
> by trying to allow flushing from non-sleepable and kernel contexts.

So basically restore the flush without disabling preemption, and if a
userspace reader gets preempted while holding the mutex it's probably
okay because we won't have high concurrency among userspace readers?

I think Shakeel was worried that this may cause a priority inversion
where a low priority task is preempted while holding the mutex, and
prevents high priority tasks from acquiring it to read the stats and
take actions (e.g. userspace OOMs).

> Would it
> make sense to distinguish what can and can't wait and make the latter gro=
up
> always use cached value? e.g. even in kernel, during oom kill, waiting
> doesn't really matter and it can just wait to obtain the up-to-date numbe=
rs.

The problem with waiting for in-kernel flushers is that high
concurrency leads to terrible serialization. Running a stress test
with 100s of reclaimers where everyone waits shows ~ 3x slowdowns.

This patch series is indeed trying to formalize a distinction between
waiters who can wait and those who can't on the memcg side:

- Unified flushers always flush the entire tree and only flush if no
one else is flushing (no waiting), otherwise they use cached data and
hope the concurrent flushing helps. This is what we currently do for
most memcg contexts. This patch series opts userspace reads out of it.

- Non-unified flushers only flush the subtree they care about and they
wait if there are other flushers. This is what we currently do for
some zswap accounting code. This patch series opts userspace readers
into this.

The problem Michal is raising is that dropping the lock can lead to an
unbounded number of waiters and longer worst case latency. Especially
that this is directly influenced by userspace. Reintroducing the mutex
and removing the lock dropping code fixes that problem, but then if
the mutex holder gets preempted, we face another problem.

Personally I think there is a good chance there won't be userspace
latency problems due to the lock as usually there isn't high
concurrency among userspace readers, and we can deal with that problem
if/when it happens. So far no problem is happening for cpu.stat which
has the same potential problem.
