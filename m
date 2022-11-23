Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D267636C4B
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 22:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiKWVVP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 16:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiKWVVN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 16:21:13 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEEE63BBB
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 13:21:10 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id 124so5418626vsv.4
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KgB35nu4bsdO3BRjzB71vDc5gogI51cR7qkBlnNkHoA=;
        b=RgUxytdJdEgfB4d1z2o+FdTqXryjzLvZ4nGRF+rSNbtAiNkj/xWRZCXnEjox3Qnzus
         ibYwfYLUb6vo6Ch7w2FllZzJR4GyBdOl1wo6nDO89NSiIiWNPsb+9CUw9zNf01MWuTnJ
         RdDrEnA2Jgkjv+Mfg/0Rnkttl2WaHuZQOqnJh5Dm5AaMts8LSC04yTsJiR/RqXB+TsdE
         x88zNb+4QJUQ0Rz6veIlgutL2dMskRBO8Ej/+jwwlOOpd781ex+ifKun2SDUVWfsZADZ
         s2tmYle4/MZIRDRw+fMyC1IAOXboaFxxgm7WPPnqKBTrGl9qzn5XX+EbX5Oi5AaUCwwn
         Hu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgB35nu4bsdO3BRjzB71vDc5gogI51cR7qkBlnNkHoA=;
        b=cTSs942058YeJAOcfz1o8IA5yb/c95Qrr3lX+a+m21+oEWFqKsQhD+GmIiglstiH/N
         PXO8V6xwB2em78UIeYhjLB0MNfWxaL43qJKZ84Ftt/BruW62YdE5oTRa5zU/Kb22UA3o
         4EyLiJiT3iPGoehyRTKoI2/CL+jxahbeV0m4WiUGxr01UdzfZmXgUeVoKZ/PTD4551bH
         Vlh7wGb2rI/HW79xryr3/HrEC5f9uB1m4W6LZD3AIKVN1SAFKLHO+7+wHukdm22P1Wtu
         AIuXduZh6mrCFOtGjWiN3Ma27hQCLbdOOEB+a+O2LppukiA/WtW8V82jWuDDLkwXCrEn
         mXdQ==
X-Gm-Message-State: ANoB5plGg1TrzckWRt691QX/7skJaDgtkmiI2nGb5Bnr6ybGe3qRBKJA
        mfQlbrYVz9TX4heZStDU79ZOM8X7wK1TF8tRl4zOoQ==
X-Google-Smtp-Source: AA0mqf5nJbKLwqUfgbB8Ks1bdjrEYSDmO0sDuhFW6BF+7pCo0+VGmgHsGG8k4brKVY0HHevVEiOHWlRIKncwD0B7hh0=
X-Received: by 2002:a05:6102:54a5:b0:3b0:7462:a88c with SMTP id
 bk37-20020a05610254a500b003b07462a88cmr1981396vsb.49.1669238469273; Wed, 23
 Nov 2022 13:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com> <Y35fw2JSAeAddONg@cmpxchg.org>
In-Reply-To: <Y35fw2JSAeAddONg@cmpxchg.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 23 Nov 2022 13:20:57 -0800
Message-ID: <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Mina,
>
> On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > reclaim""), the proactive reclaim interface memory.reclaim does both
> > reclaim and demotion. This is likely fine for us for latency critical
> > jobs where we would want to disable proactive reclaim entirely, and is
> > also fine for latency tolerant jobs where we would like to both
> > proactively reclaim and demote.
> >
> > However, for some latency tiers in the middle we would like to demote but
> > not reclaim. This is because reclaim and demotion incur different latency
> > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > by the userspace at a higher latency, but reclaimed memory would need to
> > incur a pagefault.
> >
> > To address this, I propose having reclaim-only and demotion-only
> > mechanisms in the kernel. There are a couple possible
> > interfaces to carry this out I considered:
> >
> > 1. Disable demotion in the memory.reclaim interface and add a new
> >    demotion interface (memory.demote).
> > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> >    behavior in the kernel like so:
> >       - demote=0 would disable demotion from this call.
> >       - demote=1 would allow the kernel to demote if it desires.
> >       - demote=2 would only demote if possible but not attempt any
> >         other form of reclaim.
>
> Unfortunately, our proactive reclaim stack currently relies on
> memory.reclaim doing both. It may not stay like that, but I'm a bit
> wary of changing user-visible semantics post-facto.
>
> In patch 2, you're adding a node interface to memory.demote. Can you
> add this to memory.reclaim instead? This would allow you to control
> demotion and reclaim independently as you please: if you call it on a
> node with demotion targets, it will demote; if you call it on a node
> without one, it'll reclaim. And current users will remain unaffected.

Hello Johannes, thanks for taking a look!

I can certainly add the "nodes=" arg to memory.reclaim and you're
right, that would help in bridging the gap. However, if I understand
the underlying code correctly, with only the nodes= arg the kernel
will indeed attempt demotion first, but the kernel will also merrily
fall back to reclaiming if it can't demote the full amount. I had
hoped to have the flexibility to protect latency sensitive jobs from
reclaim entirely while attempting to do demotion.

There are probably ways to get around that in the userspace. I presume
the userspace can check if there is available memory on the node's
demotion targets, and if so, the kernel should demote-only. But I feel
that wouldn't be reliable as the demotion logic may change across
kernel versions. The userspace may think the kernel would demote but
instead demotion failed due to whatever heuristic introduced into the
new kernel version.

The above is just one angle of the issue. Another angle (which Yosry
would care most about I think) is that at Google we call
memory.reclaim mainly when memory.current is too close to memory.max
and we expect the memory usage of the cgroup to drop as a result of a
success memory.reclaim call. I suspect once we take in commit
3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
we would run into that regression, but I defer to Yosry here, he may
have a solution for that in mind already.

For these reasons, what do you think about adding both the "nodes="
and "demote=" args from my patch series to memory.reclaim? With these
args the default memory.reclaim behavior would suit meta as-is (no
change) but we would be able to configure it to address our use cases
as well.

As always, thanks for taking the time to review!
