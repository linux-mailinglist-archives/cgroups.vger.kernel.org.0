Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262724F1D0D
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 23:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiDDV34 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379473AbiDDRM1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 13:12:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91813D16
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 10:10:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so8663474plo.9
        for <cgroups@vger.kernel.org>; Mon, 04 Apr 2022 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/iyktzXudPCfsWubC5IGLZO/YpQQ0A/MFOUPzzm2b0=;
        b=mW/8Tu6ZltQOiQBFgHuiFl7Pk1NcBx+SPbJ3DvfPZWtRFVLA6QDIvkx5RmvEpQJSFS
         PMCkiVebbjN2ZHLZo4qC7OkKkwUevM+/pdELqWBhsiRlT1IqR5OJNEM7nBIEgeh0Baiq
         cI+wSLIwiNZ1HuCVps5Z/l0IHHZat2g6JPQLkBLWT3v3nr61u76MH12Mhcsrme4V+BCM
         cLAu8Ow+7epFHYar0KsG9PmFRJWXInORNEB39EAIQT8PLnj7XIAvCcBL9l5fVuE6qYzM
         4CEAvbJCOiTRoKgT7aBbbYoJTPGfu6murdWXn5/A/R4cmFPhtpH7ySDp3OV54nOmeGBM
         VHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/iyktzXudPCfsWubC5IGLZO/YpQQ0A/MFOUPzzm2b0=;
        b=PgQBC+D8hrYzmkXn35kbfuz8or9ZCsR0dv0oCVaXJ6TxvYl5RhwKibjQ6shXJPk8tu
         skZWHNnDzt3gG2CJaOvHU9KNKCCwLWjStgTMwT1uwpnW/iqWehgmNjSHbnIIB2X+KYly
         t8qrjR/GAVcYAxBT8oOxl7C/W1KbexhDZkzmV/Xs8oH5wrcM1ngbRSRoov4XBcv50ixp
         gB+aQgnLQmZd9sazl/OKFKoF1xRoJ9d4jiZQGOLfND6C+PAfRuxo4blvkrjMl6t+oPGB
         9iYfDohMA6Ex62F5oTcUIO+RGmdl9z7lluyioCwyZmnF4u5d+TsEW1dhasCCbIVPazRU
         4vuQ==
X-Gm-Message-State: AOAM532Cotc9W8PvHzid9sdBjgs+vbGp3njZl4pEZg/xe2I2sTAfKeuM
        ki/WvHh/ns+HySVOeW3FK+dHhcyi0IDp2R90RaXngA==
X-Google-Smtp-Source: ABdhPJyju8nI9e9dz95e2I+lLL7NMzf+BoB6I6s5E4QtUsBp3vMbpsM7h8MEDcsIwxS9dwtj6Byii7k0P8adQzRZTc0=
X-Received: by 2002:a17:903:2351:b0:156:a562:b3f8 with SMTP id
 c17-20020a170903235100b00156a562b3f8mr631655plh.81.1649092230248; Mon, 04 Apr
 2022 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
In-Reply-To: <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 4 Apr 2022 10:09:54 -0700
Message-ID: <CAJD7tkZrOYsT1bsFB2ge5_wGccGhpS99y+OkzQHhRVgZwexL4A@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
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

Mostly I (or someone at Google) will follow-up with patches to add
most of these features. We just wanted to get consensus on the bare
minimum interface first, and to avoid derailing this discussion with
whether or not we need each of those features and what the best way to
implement them is.

> I am not really sure we really need a node aware interface for memcg.
> The global reclaim interface will likely need a different node because
> we do not want to make this CONFIG_MEMCG constrained.
>

The main use case, as Wei mentioned, is memcg-based proactive demotion
via the reclaim-based demotion
mechanism in the kernel. We can still have a nodemask argument to the
global reclaim interface as well.


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
