Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D97B9EC3
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJEOMB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjJEOKA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:10:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8CA5CD
        for <cgroups@vger.kernel.org>; Thu,  5 Oct 2023 02:31:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b9a494cc59so133449166b.3
        for <cgroups@vger.kernel.org>; Thu, 05 Oct 2023 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696498302; x=1697103102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMC25rA2+eSQ38+uqF7hDw2RgHtjVxvyqr0ZVM2w5zc=;
        b=urCzwFMJe05cCSlW73XRWfvdiutHWjaBFjQ/viZdyJ0fz1EIC1V142C2hCarmHoNUP
         3L3YyLmlE6OkB3pQA2sjmkrp2+0kiPpoQd8YUL6q/S9XKvDZ2zFuAqUxyvQQXAiuotgZ
         Id3IIuSW6A9NLSZnj0tS0X0u2YLyn6MRgWbBCu7UKyCnCrxhf6AIM+RP9QDi8xtqHwX6
         Q/R08SxqkajKRTohyAxo5f1B2eHWJG5pjpcdmdcLRw2accLK3unelff8GO+3dcDvYcAl
         x5Uz6U5aT/S9uaDMB1JjMcjK3qn2Pd/g2CLhNeK7XndamPZpe8e9I/yNC8+fv9emDZwK
         sScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498302; x=1697103102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMC25rA2+eSQ38+uqF7hDw2RgHtjVxvyqr0ZVM2w5zc=;
        b=TlnFTWmv6VNAmPYygQVmga18y661pRvMxgrhY3sIPJoW5oxllUDs82mFd4x+6Yibn+
         Ttsn8OBuA2CqPREEPxM3idviDuAMPHtT+CI+fJWFORzcO411ATH/gd6PXb+F57wYMXT0
         u5O3mYAtSK9ZXom9QQZYsKlttkhrzI/3CedGV8JGxz8rAwTxSGbVkOsB+folMJdtddQf
         Drxi0l5Kc/PTxoTJEJ1eYhBsm+ma2gDVMhgAtR/ClGa4BUGfSzPHrKbO5KF7px6U8zBM
         RRmhIj/9sOdVEg6eWfnv7eujQL6Ga8JBaVFLjQdZb20rXqQQlv3xjThL4dtvgeKMM0bp
         WFOQ==
X-Gm-Message-State: AOJu0YyHHwpFCW+k1G81cQbanuci7JhMC4GjVR5NNEQdetqcGbBX6J+J
        9Wwc+I5YJNVKtctqxckpj+7p7CBLvxQFNHgMUvepWw==
X-Google-Smtp-Source: AGHT+IFfvio8FkYu9A9VOWWLqGaexnYgvqW5wAR828Pr5q8lKiX9PTomSKqU1PWWRDMboEdpS7d26vLr+P42Oq0I+08=
X-Received: by 2002:a17:906:196:b0:9ae:72b8:4a84 with SMTP id
 22-20020a170906019600b009ae72b84a84mr4025671ejb.41.1696498301953; Thu, 05 Oct
 2023 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com> <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
 <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
 <20231004183619.GB39112@cmpxchg.org> <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
In-Reply-To: <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 5 Oct 2023 02:31:03 -0700
Message-ID: <CAJD7tkbaTRu838U=e_A+89PY1t4K+t_G1qkYq84BSDO7wAEtEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 5, 2023 at 2:06=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Wed, Oct 04, 2023 at 02:36:19PM -0400, Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > Yes, it's because of node resolution which event counters generally
> > don't have. Some of the refault events influence node-local reclaim
> > decisions, see mm/vmscan.c::snapshot_refaults().
> >
> > There are a few other event counters in the stat array that people
> > thought would be useful to have split out in
> > /sys/devices/system/node/nodeN/vmstat to understand numa behavior
> > better.
> >
> > It's a bit messy.
> >
> > Some events would be useful to move to 'stats' for the numa awareness,
> > such as the allocator stats and reclaim activity.
> >
> > Some events would be useful to move to 'stats' for the numa awareness,
> > but don't have the zone resolution required by them, such as
> > kswapd/kcompactd wakeups.
>
> Thanks for the enlightenment.
>
> > Some events aren't numa specific, such as oom kills, drop_pagecache.
>
> These are oddballs indeed. As with the normalization patchset these are
> counted as PAGE_SIZE^W 1 error but they should rather be an infinite
> error (to warrant a flush).
>
> So my feedback to this series is:
> - patch 1/2 -- creating two classes of units is consequence of unclarity
>   between state and events (as in event=3D=CE=94state/=CE=94t) and resolu=
tion
>   (global vs per-node), so the better approach would be to tidy this up,

I am not really sure what you mean here. I understand that this series
fixes the unit normalization for state but leaves events out of it.
Looking at the event items tracked by memcg in memcg_vm_event_stat it
looks to me that most of them correspond roughly to a page's worth of
updates (all but the THP_* events). We don't track things like
OOM_KILL and DROP_PAGECACHE per memcg as far as I can tell.

Do you mean that we should add something similar to
memcg_page_state_unit() for events as well to get all of them right?
If yes, I think that should be easy to add, it would only special case
THP_* events.

Alternatively, I can add a comment above the call to
memcg_rstat_updated() in __count_memcg_events() explaining why we
don't normalize the event count for now.

> - patch 2/2 -- it could use the single unit class that exists,
>   it'll bound the error of printed numbers afterall (and can be changed
>   later depending on how it affects internal consumers).

This will mean that WORKINGSET_* state will become more stale. We will
need 4096 as many updates as today to get a flush. These are used by
internal flushers (reclaim), and are exposed to userspace. I am not
sure we want to do that.

>
> My 0.02=E2=82=AC,
> Michal
