Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F45F1C31
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJAMis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Oct 2022 08:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJAMis (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Oct 2022 08:38:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE0C5BEE
        for <cgroups@vger.kernel.org>; Sat,  1 Oct 2022 05:38:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j16so10620464lfg.1
        for <cgroups@vger.kernel.org>; Sat, 01 Oct 2022 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=B3MMnLV5KzQSBoCIoVn465sXrjYLB6L1MBWhvVFk+Wo=;
        b=iTppsY5fg3g/uw+5/L4JVR/cOGxBqqmX6QFi/dlcjF4Gj/uCqY6Fw87YT2wQ5L4yC4
         4wswXeBu3WYaaXdu7BUHd3izGnicy6GvHqIo3ZJZDJdxko7kG2cnLcWs2wcQSsDP+6xG
         k+/ucgrdMwxpa3sl0Ut3iS/Wasft+r6tW32ROxsSGZz6JwoE6XPQ9zkpFSi7T3Fk0DFS
         mBkR5u6UjERYtCo1Coin33UzSslT0C0m1bfxNEZT+1TVa//OA07wMZuHB7o5IS3B6vNV
         pN3PnGGpuObZhC3W1seXHh3SYaQmLrSUKb3izDeF5ga9W7F+k/fYQ/qHINs94Jv/zdXg
         BBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=B3MMnLV5KzQSBoCIoVn465sXrjYLB6L1MBWhvVFk+Wo=;
        b=hpaJeiKnfsOF5HmXxXBiVdBF3wev1FDBljkVVRdeCQrOQ4h5BplaG9RF6H4/T/ESqL
         otqtaaklirbXkx+Q2Dvyny+VV2pB+VKhVyEkp3YzKAH2TowDQymPIATIrDNZzjkPVjpX
         /rPN3tWWhAb6tYKvWSzBSfs6RaVzzt8jEadWiu52s5VFrkdcx4nH4wfnGJqOsEMyDGL8
         HWPGMXpdlPAYDS+AKR1seppWlKAW88srV6VQUCVX4pIZRmvm61f1oRUl+fg6djlQXQFG
         NaNfTlcTkOivdnvjjYh+7iWlg4sabOsvE41JhdnXQWt08YbGqXbu7BQSxr1yO1ODuCX8
         PODA==
X-Gm-Message-State: ACrzQf20xqu45UyXXf4ZiWHhY/7PnbfWRlqfgPh8+It/I0udOxv0Qstg
        5a4I2M+80ouq5M7s06yKAzY=
X-Google-Smtp-Source: AMsMyM5SlQ6HMYbCBD3iKsdFCda7LA49aSJrDxTgEh66h7PLt9fF0FC6c+cgy39dtbAY0tBtf6r1kA==
X-Received: by 2002:a05:6512:b01:b0:4a1:baae:327d with SMTP id w1-20020a0565120b0100b004a1baae327dmr4571907lfu.668.1664627925261;
        Sat, 01 Oct 2022 05:38:45 -0700 (PDT)
Received: from ?IPV6:2a02:2168:a11:244b::1? ([2a02:2168:a11:244b::1])
        by smtp.gmail.com with ESMTPSA id bi9-20020a0565120e8900b00497aa190523sm750952lfb.248.2022.10.01.05.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 05:38:44 -0700 (PDT)
Message-ID: <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
Date:   Sat, 1 Oct 2022 15:38:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
From:   Alexander Fedorov <halcien@gmail.com>
In-Reply-To: <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 30.09.2022 21:26, Roman Gushchin wrote:
> On Fri, Sep 30, 2022 at 02:06:48PM +0000, Alexander Fedorov wrote:
>> 1) First CPU:
>>    css_killed_work_fn() -> mem_cgroup_css_offline() ->
>> drain_all_stock() -> obj_stock_flush_required()
>>         if (stock->cached_objcg) {
>>
>> This check sees a non-NULL pointer for *another* CPU's `memcg_stock`
>> instance.
>>
>> 2) Second CPU:
>>   css_free_rwork_fn() -> __mem_cgroup_free() -> free_percpu() ->
>> obj_cgroup_uncharge() -> drain_obj_stock()
>> It frees `cached_objcg` pointer in its own `memcg_stock` instance:
>>         struct obj_cgroup *old = stock->cached_objcg;
>>         < ... >
>>         obj_cgroup_put(old);
>>         stock->cached_objcg = NULL;
>>
>> 3) First CPU continues after the 'if' check and re-reads the pointer
>> again, now it is NULL and dereferencing it leads to kernel panic:
>> static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>>                                      struct mem_cgroup *root_memcg)
>> {
>> < ... >
>>         if (stock->cached_objcg) {
>>                 memcg = obj_cgroup_memcg(stock->cached_objcg);
> 
> Great catch!
> 
> I'm not sure about switching to rcu primitives though. In all other cases
> stock->cached_objcg is accessed only from a local cpu, so using rcu_*
> function is an overkill.
> 
> How's something about this? (completely untested)

Tested READ_ONCE() patch and it works.  But are rcu primitives an overkill?
For me they are documenting how actually complex is synchronization here.
For example, only after converting to rcu I noticed this (5.10.131-rt72):

static void drain_obj_stock(struct memcg_stock_pcp *stock)
{
	struct obj_cgroup *old = stock->cached_objcg;
< ... >
	obj_cgroup_put(old);
	stock->cached_objcg = NULL;
}

On kernel with enabled preemption this function can be preempted between
obj_cgroup_put() -> kfree_rcu() call and `cached_objcg` assignment, and
since scheduling marks the end of grace period then another task running
drain_all_stock() could access freed memory.

Since `cached_objcg` was not marked as synchronized variable this problem
could not be seen just by reading drain_obj_stock(), but after adding rcu
markings it is easier to notice (and fix with rcu_replace_pointer()).

Checked in mainline, this use-after-free was fixed when fixing another
problem:
5675114623872300aa9fcd72aef2b8b7f421fe12
"mm/memcg: protect memcg_stock with a local_lock_t"

> Also, please add
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")

Done, and reposted original patch because my email client malformed it
(+ comment about use-after-free)...


    mm/memcg: fix race in obj_stock_flush_required() vs drain_obj_stock()
    
    When obj_stock_flush_required() is called from drain_all_stock() it
    reads the `memcg_stock->cached_objcg` field twice for another CPU's
    per-cpu variable, leading to TOCTTOU race: another CPU can
    simultaneously enter drain_obj_stock() and clear its own instance of
    `memcg_stock->cached_objcg`.
    
    Another problem is in drain_obj_stock() which sets `cached_objcg` to
    NULL after freeing which might lead to use-after-free.
    
    To fix it mark `cached_objcg` as RCU protected field and use rcu_*()
    accessors everywhere.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Alexander Fedorov <halcien@gmail.com>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1152f8747..2ab205f529 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2215,7 +2215,7 @@ struct memcg_stock_pcp {
 	unsigned int nr_pages;
 
 #ifdef CONFIG_MEMCG_KMEM
-	struct obj_cgroup *cached_objcg;
+	struct obj_cgroup __rcu *cached_objcg;
 	unsigned int nr_bytes;
 #endif
 
@@ -3148,7 +3148,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
+	if (objcg == rcu_access_pointer(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
@@ -3160,7 +3160,8 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 
 static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
-	struct obj_cgroup *old = stock->cached_objcg;
+	struct obj_cgroup *old = rcu_replace_pointer(stock->cached_objcg, NULL,
+						lockdep_is_held(&stock->lock));
 
 	if (!old)
 		return;
@@ -3198,16 +3199,16 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 	}
 
 	obj_cgroup_put(old);
-	stock->cached_objcg = NULL;
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *cached_objcg = rcu_dereference(stock->cached_objcg);
 
-	if (stock->cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->cached_objcg);
+	if (cached_objcg) {
+		memcg = obj_cgroup_memcg(cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3223,11 +3224,11 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->cached_objcg != objcg) { /* reset if necessary */
+	if (rcu_access_pointer(stock->cached_objcg) != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
-		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
+		rcu_assign_pointer(stock->cached_objcg, objcg);
 	}
 	stock->nr_bytes += nr_bytes;
 
@@ -7162,6 +7163,7 @@ static int __init mem_cgroup_init(void)
 
 		stock = per_cpu_ptr(&memcg_stock, cpu);
 		INIT_WORK(&stock->work, drain_local_stock);
+		RCU_INIT_POINTER(stock->cached_objcg, NULL);
 		local_lock_init(&stock->lock);
 	}
 
