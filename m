Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4D4EF87E
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbiDAQ6Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349560AbiDAQ6L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 12:58:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F8118615
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 09:56:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d3so2364473ilr.10
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AocYHkt1MbaGb+EzbKia8sCXii4deKplOa2PaIkASDE=;
        b=YDqVBVNEE8HcVFjurxrYb5hOycjVTxK7fOeL/e4ZGq8suMwkA1++G6q7Opq8eNnXmv
         alhVqf6Q7sfMLjETKtpr386gqUSGhJX2C6o2VvqlJ8p7HtB5bwcIcNB0XRLlv6htt1PB
         6hec/drOZlO2WnMOaNRiPlu1yfFknBkU60wZ93cfloTZc/pNROVqNWR8vRewZz+ln2Yz
         GlgZw6Iv28fbArfWaavfo1YtdgqBkQ2LbR1nzQx/nUEoG9vwDenS8VHv7x3IpHv6BiGC
         VOvSWmSoJUdtRtes52igqYpgxtIqlBQo6hHyvFe36ewT2/HlDIhhe/hMWBPT6zWryEwJ
         /Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AocYHkt1MbaGb+EzbKia8sCXii4deKplOa2PaIkASDE=;
        b=K8Ig9bVihGk3QtNrb5UzMXG7rp5YMtBN9crqAAjLvTiRg5WyyRmBr/QErcbmdg13lq
         Vu8aqyYexyBoEA8ZnQmavYLrdfjUJelw9J1tLo4uSyywDHO2yVUQ0IFErq9dOhjmtqXX
         zrktwgnsPYUP2V390KkHLp3ZMNdexWYbUWC3r+dY2HyvGQ63I8tIKLxzEkYTGTHZ7rPu
         C+8X70ckZmsyqQ3K/KbcE0PiNkjYY9Itc7RAxVyZNFtTJaro/cslZyd7eMAH9m5uargs
         jEKytU7qQV2rQBu8VISxx4iuUG5p6E6ZuMZvHd2bOHCaHPi59XvS/bKH6j192deDhmZR
         3HEg==
X-Gm-Message-State: AOAM530svP3YbJvhJdymsmOk62x3UFRK72xw0A/aiXev8GSnVXRhNlUE
        UNZrl6fBwqxil25hmKG4B3WCMd5Ej9qpJLFZdopxsQ==
X-Google-Smtp-Source: ABdhPJzSqAvEGZ84kfSPUS4u/aBoCuEYziFNCF1E0HAsnpfVQ8pj/c5nHIXH+rK38nN3J+0RORQPCdedCZH1BwcUCGw=
X-Received: by 2002:a05:6e02:1b8f:b0:2ca:9c6:434a with SMTP id
 h15-20020a056e021b8f00b002ca09c6434amr342958ili.303.1648832180377; Fri, 01
 Apr 2022 09:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
In-Reply-To: <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 1 Apr 2022 09:56:08 -0700
Message-ID: <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> >
> > Use case: Proactive Reclaim
> > ---------------------------
> >
> > A userspace proactive reclaimer can continuously probe the memcg to
> > reclaim a small amount of memory. This gives more accurate and
> > up-to-date workingset estimation as the LRUs are continuously
> > sorted and can potentially provide more deterministic memory
> > overcommit behavior. The memory overcommit controller can provide
> > more proactive response to the changing behavior of the running
> > applications instead of being reactive.
> >
> > A userspace reclaimer's purpose in this case is not a complete replacement
> > for kswapd or direct reclaim, it is to proactively identify memory savings
> > opportunities and reclaim some amount of cold pages set by the policy
> > to free up the memory for more demanding jobs or scheduling new jobs.
> >
> > A user space proactive reclaimer is used in Google data centers.
> > Additionally, Meta's TMO paper recently referenced a very similar
> > interface used for user space proactive reclaim:
> > https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> >
> > Benefits of a user space reclaimer:
> > -----------------------------------
> >
> > 1) More flexible on who should be charged for the cpu of the memory
> > reclaim. For proactive reclaim, it makes more sense to be centralized.
> >
> > 2) More flexible on dedicating the resources (like cpu). The memory
> > overcommit controller can balance the cost between the cpu usage and
> > the memory reclaimed.
> >
> > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > under memory pressure better reclaim candidates are selected. This also
> > gives more accurate and uptodate notion of working set for an
> > application.
> >
> > Why memory.high is not enough?
> > ------------------------------
> >
> > - memory.high can be used to trigger reclaim in a memcg and can
> >   potentially be used for proactive reclaim.
> >   However there is a big downside in using memory.high. It can potentially
> >   introduce high reclaim stalls in the target application as the
> >   allocations from the processes or the threads of the application can hit
> >   the temporary memory.high limit.
> >
> > - Userspace proactive reclaimers usually use feedback loops to decide
> >   how much memory to proactively reclaim from a workload. The metrics
> >   used for this are usually either refaults or PSI, and these metrics
> >   will become messy if the application gets throttled by hitting the
> >   high limit.
> >
> > - memory.high is a stateful interface, if the userspace proactive
> >   reclaimer crashes for any reason while triggering reclaim it can leave
> >   the application in a bad state.
> >
> > - If a workload is rapidly expanding, setting memory.high to proactively
> >   reclaim memory can result in actually reclaiming more memory than
> >   intended.
> >
> > The benefits of such interface and shortcomings of existing interface
> > were further discussed in this RFC thread:
> > https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> >
> > Interface:
> > ----------
> >
> > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > trigger reclaim in the target memory cgroup.
> >
> >
> > Possible Extensions:
> > --------------------
> >
> > - This interface can be extended with an additional parameter or flags
> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >   file, anon, ..).
> >
> > - The interface can also be extended with a node mask to reclaim from
> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >   tiering systens.
> >
> > - A similar per-node interface can also be added to support proactive
> >   reclaim and reclaim-based demotion in systems without memcg.
> >
> > For now, let's keep things simple by adding the basic functionality.
>
> Yes, I am for the simplicity and this really looks like a bare minumum
> interface. But it is not really clear who do you want to add flags on
> top of it?
>
> I am not really sure we really need a node aware interface for memcg.
> The global reclaim interface will likely need a different node because
> we do not want to make this CONFIG_MEMCG constrained.

A nodemask argument for memory.reclaim can be useful for memory
tiering between NUMA nodes with different performance.  Similar to
proactive reclaim, it can allow a userspace daemon to drive
memcg-based proactive demotion via the reclaim-based demotion
mechanism in the kernel.

> > [yosryahmed@google.com: refreshed to current master, updated commit
> > message based on recent discussions and use cases]
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> All that being said. I haven't been a great fan for explicit reclaim
> triggered from the userspace but I do recognize that limitations of the
> existing interfaces is just too restrictive.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
