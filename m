Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5185F1195
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiI3S02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiI3S00 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 14:26:26 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84714792EC
        for <cgroups@vger.kernel.org>; Fri, 30 Sep 2022 11:26:24 -0700 (PDT)
Date:   Fri, 30 Sep 2022 11:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664562382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bozQYQ1ItXY9G43M8jtCYuxizhROlKE4s9wubZ56+HI=;
        b=H0/2RA6SRRc9Ov2ipdLFhQzKpskdAcFqVeHK/w0k4kMBSIWDjWIjS4H6iezwdKQNZhPrJP
        Z4V5fJulEcg9gMXtU5v6Se/9LrwVmrWmztvXtwBi45Tw9kGx0yn42NOLYVhvr8t4EVEoDe
        x+/JTiACIIk6+RkL8sTZrui+9hC9FNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexander Fedorov <halcien@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
References: <1664546131660.1777662787.1655319815@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664546131660.1777662787.1655319815@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 02:06:48PM +0000, Alexander Fedorov wrote:
> Hi,
> 
> reposting this to the mainline list as requested and with updated patch.
> 
> I've encountered a race on kernel version 5.10.131-rt72 when running
> LTP cgroup_fj_stress_memory* tests and need help with understanding
> synchronization in mm/memcontrol.c, it seems really not-trivial...
> Have also checked patches in the latest mainline kernel but do not see
> anything similar to the problem.  Realtime patch also does not seem to
> be the culprit: it just changed preemption to migration disabling and
> irq_disable to local_lock.
> 
> It goes as follows:
> 
> 1) First CPU:
>    css_killed_work_fn() -> mem_cgroup_css_offline() ->
> drain_all_stock() -> obj_stock_flush_required()
>         if (stock->cached_objcg) {
> 
> This check sees a non-NULL pointer for *another* CPU's `memcg_stock`
> instance.
> 
> 2) Second CPU:
>   css_free_rwork_fn() -> __mem_cgroup_free() -> free_percpu() ->
> obj_cgroup_uncharge() -> drain_obj_stock()
> It frees `cached_objcg` pointer in its own `memcg_stock` instance:
>         struct obj_cgroup *old = stock->cached_objcg;
>         < ... >
>         obj_cgroup_put(old);
>         stock->cached_objcg = NULL;
> 
> 3) First CPU continues after the 'if' check and re-reads the pointer
> again, now it is NULL and dereferencing it leads to kernel panic:
> static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>                                      struct mem_cgroup *root_memcg)
> {
> < ... >
>         if (stock->cached_objcg) {
>                 memcg = obj_cgroup_memcg(stock->cached_objcg);

Great catch!

I'm not sure about switching to rcu primitives though. In all other cases
stock->cached_objcg is accessed only from a local cpu, so using rcu_*
function is an overkill.

How's something about this? (completely untested)

Also, please add
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")

Thank you!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..93e9637108f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3245,10 +3245,18 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
                                     struct mem_cgroup *root_memcg)
 {
+       struct obj_cgroup *objcg;
        struct mem_cgroup *memcg;

-       if (stock->cached_objcg) {
-               memcg = obj_cgroup_memcg(stock->cached_objcg);
+       /*
+        * stock->cached_objcg can be changed asynchronously, so read
+        * it using READ_ONCE(). The objcg can't go away though because
+        * obj_stock_flush_required() is called from within a rcu read
+        * section.
+        */
+       objcg = READ_ONCE(stock->cached_objcg);
+       if (objcg) {
+               memcg = obj_cgroup_memcg(objcg);
                if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
                        return true;
        }

Thank you!
