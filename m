Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93C7642E3
	for <lists+cgroups@lfdr.de>; Thu, 27 Jul 2023 02:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjG0ATO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjG0ATN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 20:19:13 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823D11BCB
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 17:19:10 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:19:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690417148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jizH7v8h0ocLCeBVRJsVfm8/gDMdAlThvwyLIayxfSI=;
        b=lHp8Ez0cvZftnjDrB+shn/YNJVCu9ie28cUDW6kKAWN9CYushKaLWWLFDlFpQOd9vnCkaO
        r4qTSQbFbOUgr2R2v2e9qVbliFGWAF6WcfaWgPuxoQboQjxu39lTx2LJSJKTdhv8YbLd4U
        7V/b6hzWXibp+IHendqnuPPJOMGZtJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the
 indicators of sockmem pressure
Message-ID: <ZMG39B6B41yLAu9r@P9FQF9L96D>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
 <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
 <ZMCLTQgVT68jwbVh@P9FQF9L96D>
 <29de901f-ae4c-a900-a553-17ec4f096f0e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29de901f-ae4c-a900-a553-17ec4f096f0e@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 26, 2023 at 04:44:24PM +0800, Abel Wu wrote:
> On 7/26/23 10:56 AM, Roman Gushchin wrote:
> > On Mon, Jul 24, 2023 at 11:47:02AM +0800, Abel Wu wrote:
> > > Hi Roman, thanks for taking time to have a look!
> > > > 
> > > > > When in legacy mode aka. cgroupv1, the socket memory is charged
> > > > > into a separate counter memcg->tcpmem rather than ->memory, so
> > > > > the reclaim pressure of the memcg has nothing to do with socket's
> > > > > pressure at all.
> > > > 
> > > > But we still might set memcg->socket_pressure and propagate the pressure,
> > > > right?
> > > 
> > > Yes, but the pressure comes from memcg->socket_pressure does not mean
> > > pressure in socket memory in cgroupv1, which might lead to premature
> > > reclamation or throttling on socket memory allocation. As the following
> > > example shows:
> > > 
> > > 			->memory	->tcpmem
> > > 	limit		10G		10G
> > > 	usage		9G		4G
> > > 	pressure	true		false
> > 
> > Yes, now it makes sense to me. Thank you for the explanation.
> 
> Cheers!
> 
> > 
> > Then I'd organize the patchset in the following way:
> > 1) cgroup v1-only fix to not throttle tcpmem based on the vmpressure
> > 2) a formal code refactoring
> 
> OK, I will take a try to re-organize in next version.

Thank you!
> 
> > > > 
> > > > Overall I think it's a good idea to clean these things up and thank you
> > > > for working on this. But I wonder if we can make the next step and leave only
> > > > one mechanism for both cgroup v1 and v2 instead of having this weird setup
> > > > where memcg->socket_pressure is set differently from different paths on cgroup
> > > > v1 and v2.
> > > 
> > > There is some difficulty in unifying the mechanism for both cgroup
> > > designs. Throttling socket memory allocation when memcg is under
> > > pressure only makes sense when socket memory and other usages are
> > > sharing the same limit, which is not true for cgroupv1. Thoughts?
> > 
> > I see... Generally speaking cgroup v1 is considered frozen, so we can leave it
> > as it is, except when it creates an unnecessary complexity in the code.
> 
> Are you suggesting that the 2nd patch can be ignored and keep
> ->tcpmem_pressure as it is? Or keep the 2nd patch and add some
> explanation around as you suggested in last reply?

I suggest to split a code refactoring (which is not expected to bring any
functional changes) and an actual change of the behavior on cgroup v1.
Re the refactoring: I see a lot of value in adding comments and make the
code more readable, I don't see that much value in merging two variables.
But if it comes organically with the code simplification - nice.

> 
> > 
> > I'm curious, was your work driven by some real-world problem or a desire to clean
> > up the code? Both are valid reasons of course.
> 
> We (a cloud service provider) are migrating users to cgroupv2,
> but encountered some problems among which the socket memory
> really puts us in a difficult situation. There is no specific
> threshold for socket memory in cgroupv2 and relies largely on
> workloads doing traffic control themselves.
> 
> Say one workload behaves fine in cgroupv1 with 10G of ->memory
> and 1G of ->tcpmem, but will suck (or even be OOMed) in cgroupv2
> with 11G of ->memory due to burst memory usage on socket.
> 
> It's rational for the workloads to build some traffic control
> to better utilize the resources they bought, but from kernel's
> point of view it's also reasonable to suppress the allocation
> of socket memory once there is a shortage of free memory, given
> that performance degradation is better than failure.

Yeah, I can see it. But Idk if it's too workload-specific to have
a single-policy-fits-all-cases approach.
E.g. some workloads might prefer to have a portion of pagecache
being reclaimed.
What do you think?

> 
> Currently the mechanism of net-memcg's pressure doesn't work as
> we expected, please check the discussion in [1]. Besides this,
> we are also working on mitigating the priority inversion issue
> introduced by the net protocols' global shared thresholds [2],
> which has something to do with the net-memcg's pressure. This
> patchset and maybe some other are byproducts of the above work.
> 
> [1] https://lore.kernel.org/netdev/20230602081135.75424-1-wuyun.abel@bytedance.com/
> [2] https://lore.kernel.org/netdev/20230609082712.34889-1-wuyun.abel@bytedance.com/

Thanks for the clarification!
