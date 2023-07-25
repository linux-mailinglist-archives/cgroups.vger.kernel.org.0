Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809C976222D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGYTZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 15:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGYTZA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 15:25:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375EE1FF2
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 12:24:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb41682472so9036632e87.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690313096; x=1690917896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1uMPkgHteWQUIoqBLGXNOkNPWdTfMsi2o8RVrftxNk=;
        b=ooRahWUd9qepvopG3J9bw8egrolyIsO84D5Vc0l1eY7rKbHLsh4YLsQhAkHszACG43
         wiDdZqDCfuuZG0/qiNUsKynyxGflky1uwaaXpJIgWCWwyX50Bx2lq2hxpkz0LEfD9cD7
         08HWy/WST4OLNYWEfwBafRDQQdKtdlRQ4NyE9pxSSW2B8prEMlyI6Lq7Vk7jgjQVPxpT
         1yfFkkxhTK0RvKM7EfpXF6sG/rTkke8+HFRi1yyIM18vj2TKd8NhpBhNxcwxAm8Fntfv
         itmeTnNvDP1worfpkzjL3V/Vi4p3Q4MC+X0pnrXtub5xWx6V9wHU4GMu/+yCT0tixuYA
         hlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690313096; x=1690917896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1uMPkgHteWQUIoqBLGXNOkNPWdTfMsi2o8RVrftxNk=;
        b=jxSzWzeD7Ox/8nhTjS1jf8ZIng4ayFFkMbL4Ikqs3O93e6QNfHqGdpmowavk3jGzyt
         0VdEzbNCeSyWGpf+k6mkAH3W0G4Mh8hzav83wHYgfjA5d7rWBI6vHG1NTiQPxJil+AvH
         ihPgmRmCX4+Pp1IS/xXCBHQPaZ/r2A9O51XLSCxiYwpPOUOeIhYSl24lewgTAUAonNj9
         niPtOdEeH8kcjmWy5G6Ip3r0JhqLYd4cGDbiYRMaAX4hsKZ2de5tkwqSjojF3TGzEuMl
         zqPu7vbUylksxShh4SHdqW09mM6Yqj5XH+DeuEYLKcVGJbkWmC1L3x+7Awnw2TfDIUS7
         bW8w==
X-Gm-Message-State: ABy/qLamj4FW1UjPB2KHrj0giWEE37LS7jOA4TtWBBBME176+CIYP74+
        h5fPGk94CbSIA/Xb+EUTCZ5D9Dn2DkC6IBVnNlYYPg==
X-Google-Smtp-Source: APBJJlFvefXqddr8rAGU+RRiXk66fGsLhtcXxGGBMxnXLz4XrlnM39V3t/SdrcPAseVScTEeLDKfBX1La9gMI4E3YBQ=
X-Received: by 2002:a05:6512:baa:b0:4fb:b11:c9a2 with SMTP id
 b42-20020a0565120baa00b004fb0b11c9a2mr11022614lfv.34.1690313096153; Tue, 25
 Jul 2023 12:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230719174613.3062124-1-yosryahmed@google.com> <20230725140435.GB1146582@cmpxchg.org>
In-Reply-To: <20230725140435.GB1146582@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Jul 2023 12:24:19 -0700
Message-ID: <CAJD7tkaYHvaX6SL=A6TsCQHT+rOTp-WhOiQ1XSN+ywOVN=-QBQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

Hey Johannes,

On Tue, Jul 25, 2023 at 7:04=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jul 19, 2023 at 05:46:13PM +0000, Yosry Ahmed wrote:
> > Currently, memcg uses rstat to maintain hierarchical stats. The rstat
> > framework keeps track of which cgroups have updates on which cpus.
> >
> > For non-hierarchical stats, as memcg moved to rstat, they are no longer
> > readily available as counters. Instead, the percpu counters for a given
> > stat need to be summed to get the non-hierarchical stat value. This
> > causes a performance regression when reading non-hierarchical stats on
> > kernels where memcg moved to using rstat. This is especially visible
> > when reading memory.stat on cgroup v1. There are also some code paths
> > internal to the kernel that read such non-hierarchical stats.
>
> It's actually not an rstat regression. It's always been this costly.
>
> Quick history:

Thanks for the context.

>
> We used to maintain *all* stats in per-cpu counters at the local
> level. memory.stat reads would have to iterate and aggregate the
> entire subtree every time. This was obviously very costly, so we added
> batched upward propagation during stat updates to simplify reads:
>
> commit 42a300353577ccc17ecc627b8570a89fa1678bec
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Tue May 14 15:47:12 2019 -0700
>
>     mm: memcontrol: fix recursive statistics correctness & scalabilty
>
> However, that caused a regression in the stat write path, as the
> upward propagation would bottleneck on the cachelines in the shared
> parents. The fix for *that* re-introduced the per-cpu loops in the
> local stat reads:
>
> commit 815744d75152078cde5391fc1e3c2d4424323fb6
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Thu Jun 13 15:55:46 2019 -0700
>
>     mm: memcontrol: don't batch updates of local VM stats and events
>
> So I wouldn't say it's a regression from rstat. Except for that short
> period between the two commits above, the read side for local stats
> was always expensive.

I was comparing from an 4.15 kernel, so I assumed the major change was
from rstat, but that was not accurate. Thanks for the history.

However, in that 4.15 kernel the local (non-hierarchical) stats were
readily available without iterating percpu counters. There is a
regression that was introduced somewhere.

Looking at the history you described, it seems like up until
815744d75152 we used to maintain "local" (aka non-hierarchical)
counters, so reading local stats was reading one counter, and starting
815744d75152 we started having to loop percpu counters for that.

So it is not a regression of rstat, but seemingly it is a regression
of 815744d75152. Is my understanding incorrect?

>
> rstat promises a shot at finally fixing it, with less risk to the
> write path.
>
> > It is inefficient to iterate and sum counters in all cpus when the rsta=
t
> > framework knows exactly when a percpu counter has an update. Instead,
> > maintain cpu-aggregated non-hierarchical counters for each stat. During
> > an rstat flush, keep those updated as well. When reading
> > non-hierarchical stats, we no longer need to iterate cpus, we just need
> > to read the maintainer counters, similar to hierarchical stats.
> >
> > A caveat is that we now a stats flush before reading
> > local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> > or memcg_events_local(), where we previously only needed a flush to
> > read hierarchical stats. Most contexts reading non-hierarchical stats
> > are already doing a flush, add a flush to the only missing context in
> > count_shadow_nodes().
> >
> > With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> > machine with 256 cpus on cgroup v1:
> >  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
> >  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
> >  real  0m0.125s
> >  user  0m0.005s
> >  sys   0m0.120s
> >
> > After:
> >  real  0m0.032s
> >  user  0m0.005s
> >  sys   0m0.027s
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks! I will reformulate the commit log after we agree on the history.

>
> But I want to be clear: this isn't a regression fix. It's a new
> performance optimization for the deprecated cgroup1 code. And it comes
> at the cost of higher memory footprint for both cgroup1 AND cgroup2.

I still think it is, but I can easily be wrong. I am hoping that the
memory footprint is not a problem. There are *roughly* 80 per-memcg
stats/events (MEMCG_NR_STAT + NR_MEMCG_EVENTS) and 55 per-lruvec stats
(NR_VM_NODE_STAT_ITEMS). For each stat there is an extra 8 bytes, so
on a two-node machine that's  8 * (80 + 55 * 2) ~=3D 1.5 KiB per memcg.

Given that struct mem_cgroup is already large, and can easily be 100s
of KiBs on a large machine with many cpus, I hope there won't be a
noticeable regression.

>
> If this causes a regression, we should revert it again. But let's try.

Of course. Fingers crossed.
