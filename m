Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADE64ACA7
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 01:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiLMAym (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 19:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLMAyl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 19:54:41 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E164D0
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 16:54:40 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id b189so13141394vsc.10
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 16:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zi3ZzyKkgNoOmYVx10LPKw87VjddBy1CfolqOqRLdM=;
        b=gFj+NaTDEjrbdtpaBG2ekgela1K6vSk06PHME5bYkhlxpLN/TpofHvr+G1qhD6fdVo
         Q48yRVBKQyN3eTdjzONydNVQa/y9AMl8JsKpVBkWTEyxMVVH2l6/8bSXPQ6nMfoaYFrl
         JRa4ASQiKWaHIwAQxgrXNfrmnFtSqfN1Sg9AK5KhNM17J+lNd+IYqFQuV3tWZo7rCc9o
         AJmYC89CvqJsT3AJLyzxhL2kGwNaMjt2y3z93qBrZHXDVhH4Ojb8xWbj0wCmyH9h/KeW
         gs666d/CSjHK5LGAClY2hOgbWj3C7TMMX/h5d42YVIa2rVdiTV/geNGtmz5XyIkb2zEP
         RKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zi3ZzyKkgNoOmYVx10LPKw87VjddBy1CfolqOqRLdM=;
        b=0m/5xR+mlHn6MLuzQbZCt4YUESF1Pc9ihjgmIxUxp8nrDtr9vjt5HsZdV8Az9LF/vN
         YDQM25oj5CJJuKV+Jrlb3qAbP7NxidwmBTD6Kw/Zu7nqom0VM10EUSdUrLt989yoFlfz
         m5D8nqXqlfic+5ToTUupOp9mwQ2UtpXW9MCTn0DWfx7qTG+c1uRR9c4kqs7QRW+NAaOy
         i5QppLxvfNPt4H2smJjkZYGxBDvT/tNRcODJHN8VyhN9dLpiAj/HDfWJpb44V1h6CN9F
         SR6Pmdr2Rat1eqbYw1UWdA2kPddQ3ePecY+MUmu+W3JO+HlbTQ90EIeKWG5sHlm9BatI
         eYEQ==
X-Gm-Message-State: ANoB5pl0IGp56yjvVXmfGeA6u1R4a1GEIqt9V7XcA+QPZXPFD4uOFWuU
        1YYb7X1kztHkssFMgFGWe4yApUSgJNjTAuFbs/96cA==
X-Google-Smtp-Source: AA0mqf6fSWCQhulCrdDkL8XnvtjamHkOLhd97/tIupBdsydu1hBCEL6D2iS02/S1te7+YgPoaA4C/YBzGlMcxrKoGe0=
X-Received: by 2002:a67:d09a:0:b0:3b5:1527:d7bf with SMTP id
 s26-20020a67d09a000000b003b51527d7bfmr143813vsi.72.1670892879134; Mon, 12 Dec
 2022 16:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20221202223533.1785418-1-almasrymina@google.com> <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
In-Reply-To: <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 12 Dec 2022 16:54:27 -0800
Message-ID: <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, Dec 12, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 02-12-22 14:35:31, Mina Almasry wrote:
> > The nodes= arg instructs the kernel to only scan the given nodes for
> > proactive reclaim. For example use cases, consider a 2 tier memory system:
> >
> > nodes 0,1 -> top tier
> > nodes 2,3 -> second tier
> >
> > $ echo "1m nodes=0" > memory.reclaim
> >
> > This instructs the kernel to attempt to reclaim 1m memory from node 0.
> > Since node 0 is a top tier node, demotion will be attempted first. This
> > is useful to direct proactive reclaim to specific nodes that are under
> > pressure.
> >
> > $ echo "1m nodes=2,3" > memory.reclaim
> >
> > This instructs the kernel to attempt to reclaim 1m memory in the second tier,
> > since this tier of memory has no demotion targets the memory will be
> > reclaimed.
> >
> > $ echo "1m nodes=0,1" > memory.reclaim
> >
> > Instructs the kernel to reclaim memory from the top tier nodes, which can
> > be desirable according to the userspace policy if there is pressure on
> > the top tiers. Since these nodes have demotion targets, the kernel will
> > attempt demotion first.
> >
> > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > reclaim""), the proactive reclaim interface memory.reclaim does both
> > reclaim and demotion. Reclaim and demotion incur different latency costs
> > to the jobs in the cgroup. Demoted memory would still be addressable
> > by the userspace at a higher latency, but reclaimed memory would need to
> > incur a pagefault.
> >
> > The 'nodes' arg is useful to allow the userspace to control demotion
> > and reclaim independently according to its policy: if the memory.reclaim
> > is called on a node with demotion targets, it will attempt demotion first;
> > if it is called on a node without demotion targets, it will only attempt
> > reclaim.
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> After discussion in [1] I have realized that I haven't really thought
> through all the consequences of this patch and therefore I am retracting
> my ack here. I am not nacking the patch at this statge but I also think
> this shouldn't be merged now and we should really consider all the
> consequences.
>
> Let me summarize my main concerns here as well. The proposed
> implementation doesn't apply the provided nodemask to the whole reclaim
> process. This means that demotion can happen outside of the mask so the
> the user request cannot really control demotion targets and that limits
> the interface should there be any need for a finer grained control in
> the future (see an example in [2]).
> Another problem is that this can limit future reclaim extensions because
> of existing assumptions of the interface [3] - specify only top-tier
> node to force the aging without actually reclaiming any charges and
> (ab)use the interface only for aging on multi-tier system. A change to
> the reclaim to not demote in some cases could break this usecase.
>

I think this is correct. My use case is to request from the kernel to
do demotion without reclaim in the cgroup, and the reason for that is
stated in the commit message:

"Reclaim and demotion incur different latency costs to the jobs in the
cgroup. Demoted memory would still be addressable by the userspace at
a higher latency, but reclaimed memory would need to incur a
pagefault."

For jobs of some latency tiers, we would like to trigger proactive
demotion (which incurs relatively low latency on the job), but not
trigger proactive reclaim (which incurs a pagefault). I initially had
proposed a separate interface for this, but Johannes directed me to
this interface instead in [1]. In the same email Johannes also tells
me that meta's reclaim stack relies on memory.reclaim triggering
demotion, so it seems that I'm not the first to take a dependency on
this. Additionally in [2] Johannes also says it would be great if in
the long term reclaim policy and demotion policy do not diverge.

[1] https://lore.kernel.org/linux-mm/Y35fw2JSAeAddONg@cmpxchg.org/
[2] https://lore.kernel.org/linux-mm/Y36fIGFCFKiocAd6@cmpxchg.org/

> My counter proposal would be to define the nodemask for memory.reclaim
> as a domain to constrain the charge reclaim. That means both aging and
> reclaim including demotion which is a part of aging. This will allow
> to control where to demote for balancing purposes (e.g. demote to node 2
> rather than 3) which is impossible with the proposed scheme.
>

My understanding is that with this interface in order to trigger
demotion I would want to list both the top tier nodes and the bottom
tier nodes on the nodemask, and since the bottom tier nodes are in the
nodemask the kernel will not just trigger demotion, but will also
trigger reclaim. This is very specifically not our use case and not
the goal of this patch.

I had also suggested adding a demotion= arg to memory.reclaim so the
userspace may customize this behavior, but Johannes rejected this in
[3] to adhere to the aging pipeline.

All in all I like Johannes's model in [3] describing the aging
pipeline and the relationship between demotion and reclaim. The nodes=
arg is just a hint to the kernel that the userspace is looking for
reclaim from a top tier node (which would be done by demotion
according to the aging pipeline) or a bottom tier node (which would be
done by reclaim according to the aging pipeline). I think this
interface is aligned with this model.

[3] https://lore.kernel.org/linux-mm/Y36XchdgTCsMP4jT@cmpxchg.org/

> [1] http://lkml.kernel.org/r/20221206023406.3182800-1-almasrymina@google.com
> [2] http://lkml.kernel.org/r/Y5bnRtJ6sojtjgVD@dhcp22.suse.cz
> [3] http://lkml.kernel.org/r/CAAPL-u8rgW-JACKUT5ChmGSJiTDABcDRjNzW_QxMjCTk9zO4sg@mail.gmail.com
> --
> Michal Hocko
> SUSE Labs
