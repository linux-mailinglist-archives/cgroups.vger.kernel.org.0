Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20264B634
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLMNav (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 08:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiLMNau (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 08:30:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59DBE1
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 05:30:48 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r26so17679032edc.10
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkAga1fPXNCvgWWr0y17vOcwxqzOIKIhEW49YSLUBLs=;
        b=zXfkNNv5mXOMPEanvux+4bWlBQnFuzxE2MzUd22vOUfuSUzuyhRUOfDzB0ggA71T8F
         U4BoSvDNvouPUsFnxzBhZ9PkJKNOOi+r+fWw9vIFexrfG0KwcjqamyWJH78bxvSa+wEK
         sviWJZdff4IfSH7PcbdsfV9IggXAnSU97epnS/d0NovCmFSRag3LxiwLBWEbw0wia48V
         YbDPBVUWD+T8qS9AWX0q7GxruKFPjvBYZuFfVuhZJcW2vVgQJ/wUPa1YAkGfHLEO3TNv
         ut45RL2Pkoauar+k5MQKvHAfX+4LQXjfZ+Tr4d/sXdDmzrGpjYfmw5ayEfmXxR2ffeRd
         2uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkAga1fPXNCvgWWr0y17vOcwxqzOIKIhEW49YSLUBLs=;
        b=E6jJS+fM4TIJjaypT1tfcuqHyzcvgvrINvExAx5i7l42u0boMNsTrxw9fd/ZbjlbA+
         hUDbAxfhOmyR81OWTBhPGKgOmOh9QzOcACWRbmUyEFcKKiVL3n8FyvL9HRinss/jLJUY
         n+d7QW0xs9p1NUt2yUcDLs676e5k29T9N38TF5HA6Tw3rcJM4r9Mbn3aV0d5PQgpT2xb
         ZqEThZrsqbZnTQCL7j3o2am3QIYyQU6jEKdDPfMcq5W05GzJxsnH6EWLbUz6om51yszv
         eSTc9err2ztsau9PMA87xftAqtgseXzLDGgKChjJuw2hzRKKxc+x9fPiS5+GlI4MDovU
         U6Mg==
X-Gm-Message-State: ANoB5pl5l64ObWQo65EDevNQG1pnQFxkJVEsSV6zx1fA2j52qfl2tL/b
        7duWylHUg1MFPP6lh/L96+26Ww==
X-Google-Smtp-Source: AA0mqf55nZH+ZFdawcdqg2GbkWyleEiww6bqn+BU/p1ARK9riCKQWs9Ju9dLnhFZ+gdPQNXQCWCLww==
X-Received: by 2002:a05:6402:c08:b0:46d:83ea:44e8 with SMTP id co8-20020a0564020c0800b0046d83ea44e8mr18308556edb.21.1670938247443;
        Tue, 13 Dec 2022 05:30:47 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id d7-20020aa7ce07000000b0046951b43e84sm4945096edv.55.2022.12.13.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:30:47 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:30:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
Message-ID: <Y5h+gHBneexFQcR3@cmpxchg.org>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 13, 2022 at 02:30:57PM +0800, Huang, Ying wrote:
> Mina Almasry <almasrymina@google.com> writes:
> 
> > On Mon, Dec 12, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Fri 02-12-22 14:35:31, Mina Almasry wrote:
> >> > The nodes= arg instructs the kernel to only scan the given nodes for
> >> > proactive reclaim. For example use cases, consider a 2 tier memory system:
> >> >
> >> > nodes 0,1 -> top tier
> >> > nodes 2,3 -> second tier
> >> >
> >> > $ echo "1m nodes=0" > memory.reclaim
> >> >
> >> > This instructs the kernel to attempt to reclaim 1m memory from node 0.
> >> > Since node 0 is a top tier node, demotion will be attempted first. This
> >> > is useful to direct proactive reclaim to specific nodes that are under
> >> > pressure.
> >> >
> >> > $ echo "1m nodes=2,3" > memory.reclaim
> >> >
> >> > This instructs the kernel to attempt to reclaim 1m memory in the second tier,
> >> > since this tier of memory has no demotion targets the memory will be
> >> > reclaimed.
> >> >
> >> > $ echo "1m nodes=0,1" > memory.reclaim
> >> >
> >> > Instructs the kernel to reclaim memory from the top tier nodes, which can
> >> > be desirable according to the userspace policy if there is pressure on
> >> > the top tiers. Since these nodes have demotion targets, the kernel will
> >> > attempt demotion first.
> >> >
> >> > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> >> > reclaim""), the proactive reclaim interface memory.reclaim does both
> >> > reclaim and demotion. Reclaim and demotion incur different latency costs
> >> > to the jobs in the cgroup. Demoted memory would still be addressable
> >> > by the userspace at a higher latency, but reclaimed memory would need to
> >> > incur a pagefault.
> >> >
> >> > The 'nodes' arg is useful to allow the userspace to control demotion
> >> > and reclaim independently according to its policy: if the memory.reclaim
> >> > is called on a node with demotion targets, it will attempt demotion first;
> >> > if it is called on a node without demotion targets, it will only attempt
> >> > reclaim.
> >> >
> >> > Acked-by: Michal Hocko <mhocko@suse.com>
> >> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>
> >> After discussion in [1] I have realized that I haven't really thought
> >> through all the consequences of this patch and therefore I am retracting
> >> my ack here. I am not nacking the patch at this statge but I also think
> >> this shouldn't be merged now and we should really consider all the
> >> consequences.
> >>
> >> Let me summarize my main concerns here as well. The proposed
> >> implementation doesn't apply the provided nodemask to the whole reclaim
> >> process. This means that demotion can happen outside of the mask so the
> >> the user request cannot really control demotion targets and that limits
> >> the interface should there be any need for a finer grained control in
> >> the future (see an example in [2]).
> >> Another problem is that this can limit future reclaim extensions because
> >> of existing assumptions of the interface [3] - specify only top-tier
> >> node to force the aging without actually reclaiming any charges and
> >> (ab)use the interface only for aging on multi-tier system. A change to
> >> the reclaim to not demote in some cases could break this usecase.
> >>
> >
> > I think this is correct. My use case is to request from the kernel to
> > do demotion without reclaim in the cgroup, and the reason for that is
> > stated in the commit message:
> >
> > "Reclaim and demotion incur different latency costs to the jobs in the
> > cgroup. Demoted memory would still be addressable by the userspace at
> > a higher latency, but reclaimed memory would need to incur a
> > pagefault."
> >
> > For jobs of some latency tiers, we would like to trigger proactive
> > demotion (which incurs relatively low latency on the job), but not
> > trigger proactive reclaim (which incurs a pagefault). I initially had
> > proposed a separate interface for this, but Johannes directed me to
> > this interface instead in [1]. In the same email Johannes also tells
> > me that meta's reclaim stack relies on memory.reclaim triggering
> > demotion, so it seems that I'm not the first to take a dependency on
> > this. Additionally in [2] Johannes also says it would be great if in
> > the long term reclaim policy and demotion policy do not diverge.
> >
> > [1] https://lore.kernel.org/linux-mm/Y35fw2JSAeAddONg@cmpxchg.org/
> > [2] https://lore.kernel.org/linux-mm/Y36fIGFCFKiocAd6@cmpxchg.org/
> 
> After these discussion, I think the solution maybe use different
> interfaces for "proactive demote" and "proactive reclaim".  That is,
> reconsider "memory.demote".  In this way, we will always uncharge the
> cgroup for "memory.reclaim".  This avoid the possible confusion there.
> And, because demotion is considered aging, we don't need to disable
> demotion for "memory.reclaim", just don't count it.

Hm, so in summary:

1) memory.reclaim would demote and reclaim like today, but it would
   change to only count reclaimed pages against the goal.

2) memory.demote would only demote.

   a) What if the demotion targets are full? Would it reclaim or fail?

3) Would memory.reclaim and memory.demote still need nodemasks? Would
   they return -EINVAL if a) memory.reclaim gets passed only toptier
   nodes or b) memory.demote gets passed any lasttier nodes?
