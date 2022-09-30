Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CDD5F0D0A
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiI3OGz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiI3OGx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 10:06:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70B16F86A
        for <cgroups@vger.kernel.org>; Fri, 30 Sep 2022 07:06:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q14so310167lfo.11
        for <cgroups@vger.kernel.org>; Fri, 30 Sep 2022 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:user-agent:date:subject:cc
         :to:from:message-id:from:to:cc:subject:date;
        bh=Eu1UCcsFNrtGDpP0teOX35SousjnhGHT123vvgcKo/k=;
        b=JQHL799ma39mxOGPE+gyXK+ZE69/Sgnv6GL9hyUmyU/NRAySECqAPsYLbdp+YJWo78
         oKpJ5jAWZ8QzBeVm0jto83to21gR84tMwmSCDr7v5J56xkHakG6Mo4QwOPbbx4Ntm/Rn
         7duiyJxmoUkZeToHp0Yt//TWHvf+YWoWz/Qntgh0rBP1CMmfqHL8so3IOPL1Ov9YN8gJ
         PgeuTxU/R+ge84LDxb7a9cy/oes8BDQiwVSssGTBzsI41gCjIcNg79GoVBX7XGiBE3d6
         BAtqACLyIXMLlplZb98X3gYtYmr7J6taw3Gqj7mW/+uMhwn4rQdq/WJSO1+KY0Meyrna
         Ar9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:content-transfer-encoding:user-agent:date:subject:cc
         :to:from:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Eu1UCcsFNrtGDpP0teOX35SousjnhGHT123vvgcKo/k=;
        b=XVMRVWG9Ife2GuaLTrDXVMacMm/olMA2m6kG9/dYweS4mGYnpbJf78fUoJhU4wAStd
         d5M6/AOx/+ada4wIuo2oirBfm1P+hKuWQ4QXsnIt5+zk1CTxWKZMF3pKXpQ/p8NBN1LJ
         GVST++NcXCz/yVOIsd3KtV0VH5DYpoQ7YgYDbm9us0Tqs9CPDvYe7UmG7UodkV737l1s
         mYYaLC3V+p2FW2fanms3/v1E34i11XWPOKSiMrxke/bVPLe77NcUHBvRbPvbo/Bp7R4W
         gFogvsshkRTzNQNdu+0PIAAzuCpZk8eS/PJ05rOEpR1TtssLwl5rZ0pOFBxHdU+RV/XQ
         jQnA==
X-Gm-Message-State: ACrzQf2oSvRUzBguvHWxWzzjvceEOuckM0eS+ucuBlrhgrLPE034rwLW
        ypuUgtBmyMDt3d0rLpHzbOjfdqcddSNi4Q==
X-Google-Smtp-Source: AMsMyM6ykR7ZkfWDyHGjEmY1ifu/GDSNGUVy18APhaVnAQou5uBqZI5xZMk2TENtz9tUeJ00YoJsRQ==
X-Received: by 2002:a05:6512:ea9:b0:499:d6f9:5af6 with SMTP id bi41-20020a0565120ea900b00499d6f95af6mr3751053lfb.119.1664546809729;
        Fri, 30 Sep 2022 07:06:49 -0700 (PDT)
Received: from noip.localdomain ([2a02:2168:a11:244b::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512229100b0049b58c51773sm299850lfu.193.2022.09.30.07.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:06:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1664546131660.1777662787.1655319815@gmail.com>
From:   Alexander Fedorov <halcien@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Date:   Fri, 30 Sep 2022 14:06:48 +0000
X-Mailer: Vivaldi Mail
User-Agent: Vivaldi Mail/1.1.2753.51
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

reposting this to the mainline list as requested and with updated patch.

I've encountered a race on kernel version 5.10.131-rt72 when running
LTP cgroup_fj_stress_memory* tests and need help with understanding
synchronization in mm/memcontrol.c, it seems really not-trivial...
Have also checked patches in the latest mainline kernel but do not see
anything similar to the problem.  Realtime patch also does not seem to
be the culprit: it just changed preemption to migration disabling and
irq_disable to local_lock.

It goes as follows:

1) First CPU:
    css_killed_work_fn() -> mem_cgroup_css_offline() ->
drain_all_stock() -> obj_stock_flush_required()
         if (stock->cached_objcg) {

This check sees a non-NULL pointer for *another* CPU's `memcg_stock` 
instance.

2) Second CPU:
   css_free_rwork_fn() -> __mem_cgroup_free() -> free_percpu() ->
obj_cgroup_uncharge() -> drain_obj_stock()
It frees `cached_objcg` pointer in its own `memcg_stock` instance:
         struct obj_cgroup *old = stock->cached_objcg;
         < ... >
         obj_cgroup_put(old);
         stock->cached_objcg = NULL;

3) First CPU continues after the 'if' check and re-reads the pointer
again, now it is NULL and dereferencing it leads to kernel panic:
static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
                                      struct mem_cgroup *root_memcg)
{
< ... >
         if (stock->cached_objcg) {
                 memcg = obj_cgroup_memcg(stock->cached_objcg);

Since it seems that `cached_objcg` field is protected by RCU, I've also
tried the patch below (against 5.10.131-rt72) and confirmed that it seems
to fix the problem (at least the same LTP tests finish successfully) but
am not sure if that's the right fix.  The patch does not apply cleanly to
mainline kernel but I can try rebasing it if needed.


     mm/memcg: fix race in obj_stock_flush_required() vs drain_obj_stock()
     
     When obj_stock_flush_required() is called from drain_all_stock() it
     reads the `memcg_stock->cached_objcg` field twice for another CPU's
     per-cpu variable, leading to TOCTTOU race: another CPU can
     simultaneously enter drain_obj_stock() and clear its own instance of
     `memcg_stock->cached_objcg`.
     
     To fix it mark `cached_objcg` as RCU protected field and use
     rcu_*() accessors everywhere.

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
  
@@ -3148,7 +3148,7 @@ static bool consume_obj_stock(struct obj_cgroup 
*objcg, unsigned int nr_bytes)
  	local_lock_irqsave(&memcg_stock.lock, flags);
  
  	stock = this_cpu_ptr(&memcg_stock);
-	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
+	if (objcg == rcu_access_pointer(stock->cached_objcg) && stock->nr_bytes 
>= nr_bytes) {
  		stock->nr_bytes -= nr_bytes;
  		ret = true;
  	}
@@ -3160,7 +3160,8 @@ static bool consume_obj_stock(struct obj_cgroup 
*objcg, unsigned int nr_bytes)
  
  static void drain_obj_stock(struct memcg_stock_pcp *stock)
  {
-	struct obj_cgroup *old = stock->cached_objcg;
+	struct obj_cgroup *old = rcu_replace_pointer(stock->cached_objcg, NULL,
+						lockdep_is_held(&stock->lock));
  
  	if (!old)
  		return;
@@ -3198,16 +3199,16 @@ static void drain_obj_stock(struct memcg_stock_pcp 
*stock)
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
@@ -3223,11 +3224,11 @@ static void refill_obj_stock(struct obj_cgroup 
*objcg, unsigned int nr_bytes)
  	local_lock_irqsave(&memcg_stock.lock, flags);
  
  	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->cached_objcg != objcg) { /* reset if necessary */
+	if (rcu_access_pointer(stock->cached_objcg) != objcg) { /* reset if 
necessary */
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
  
