Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159227628EB
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 04:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGZC41 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGZC40 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 22:56:26 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6831728
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 19:56:25 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:56:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690340181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8HcyBJhNbmAFYQ4vhr/4v6PwhJI/M2KUGD3rBet++I=;
        b=CWY0VoBdxv90fE2Kx4slvk7SKhNU64RiS4zo/67lqAHvkomMISjpuadrAKmiZtx3178RPo
        yfNQlTWX6efUd8GwjE2kygFoh9/mTxSUiV5Wph+uzlk+0wfwPoF0KJq+FVvK2fSuFHgH1v
        ppQqROFo3fA+qYCo3RRaBLzBqJjPyxU=
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
Message-ID: <ZMCLTQgVT68jwbVh@P9FQF9L96D>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
 <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 24, 2023 at 11:47:02AM +0800, Abel Wu wrote:
> Hi Roman, thanks for taking time to have a look!
> 
> On 7/22/23 8:20 AM, Roman Gushchin wrote:
> > On Tue, Jul 11, 2023 at 08:41:43PM +0800, Abel Wu wrote:
> > > Now there are two indicators of socket memory pressure sit inside
> > > struct mem_cgroup, socket_pressure and tcpmem_pressure.
> > 
> > Hi Abel!
> > 
> > > When in legacy mode aka. cgroupv1, the socket memory is charged
> > > into a separate counter memcg->tcpmem rather than ->memory, so
> > > the reclaim pressure of the memcg has nothing to do with socket's
> > > pressure at all.
> > 
> > But we still might set memcg->socket_pressure and propagate the pressure,
> > right?
> 
> Yes, but the pressure comes from memcg->socket_pressure does not mean
> pressure in socket memory in cgroupv1, which might lead to premature
> reclamation or throttling on socket memory allocation. As the following
> example shows:
> 
> 			->memory	->tcpmem
> 	limit		10G		10G
> 	usage		9G		4G
> 	pressure	true		false

Yes, now it makes sense to me. Thank you for the explanation.

Then I'd organize the patchset in the following way:
1) cgroup v1-only fix to not throttle tcpmem based on the vmpressure
2) a formal code refactoring

> 
> the memcg's memory limits are both set to 10G, and the ->memory part
> is suffering from reclaim pressure while ->tcpmem still has much room
> for use. I have no idea why should treat the ->tcpmem as under pressure
> in this scenario, am I missed something?
> 
> > If you're changing this, you need to provide a bit more data on why it's
> > a good idea. I'm not saying the current status is perfect, but I think we need
> > a bit more justification for this change.
> > 
> > > While for default mode, the ->tcpmem is simply
> > > not used.
> > > 
> > > So {socket,tcpmem}_pressure are only used in default/legacy mode
> > > respectively. This patch fixes the pieces of code that make mixed
> > > use of both.
> > > 
> > > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > > ---
> > >   include/linux/memcontrol.h | 4 ++--
> > >   mm/vmpressure.c            | 8 ++++++++
> > >   2 files changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 5818af8eca5a..5860c7f316b9 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1727,8 +1727,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
> > >   void mem_cgroup_sk_free(struct sock *sk);
> > >   static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> > >   {
> > > -	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
> > > -		return true;
> > > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > +		return !!memcg->tcpmem_pressure;
> > 
> > So here you can have something like
> >     if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> >          do {
> >              if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
> >                    return true;
> >          } while ((memcg = parent_mem_cgroup(memcg)));
> >     } else {
> > 	return !!READ_ONCE(memcg->socket_pressure);
> >     }
> 
> Yes, this looks better.
> 
> > 
> > And, please, add a bold comment here or nearby the socket_pressure definition
> > that it has a different semantics in the legacy and default modes.
> 
> Agreed.
> 
> > 
> > Overall I think it's a good idea to clean these things up and thank you
> > for working on this. But I wonder if we can make the next step and leave only
> > one mechanism for both cgroup v1 and v2 instead of having this weird setup
> > where memcg->socket_pressure is set differently from different paths on cgroup
> > v1 and v2.
> 
> There is some difficulty in unifying the mechanism for both cgroup
> designs. Throttling socket memory allocation when memcg is under
> pressure only makes sense when socket memory and other usages are
> sharing the same limit, which is not true for cgroupv1. Thoughts?

I see... Generally speaking cgroup v1 is considered frozen, so we can leave it
as it is, except when it creates an unnecessary complexity in the code.

I'm curious, was your work driven by some real-world problem or a desire to clean
up the code? Both are valid reasons of course.

Thanks!
