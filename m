Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC15AF63F
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 22:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIFUkP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIFUkN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 16:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FE79A59
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662496811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoDl8tkSYZjmN99yvp637ONt03t0JNDcmlNuO4E1yLY=;
        b=d3t7gED5Whg++DhojDYyRsc6HwT99iYwAC2PhWxuEyzUMOVugUa0Kcl4YSKVwfmiWfJvRk
        8S0G8SRFV+sQBL/X8g+tUmGtmdPePrmnSbW1M1t5MppfEbqSz/bHUdwX/8DLCeLgnRw4ab
        NyX+HCmI1alNL7FSzprGNxwBtb+6YnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-HVJi-dGPM3qW32kVJ8AuaA-1; Tue, 06 Sep 2022 16:40:05 -0400
X-MC-Unique: HVJi-dGPM3qW32kVJ8AuaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D3EC101A56C;
        Tue,  6 Sep 2022 20:40:04 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59ADF4010D42;
        Tue,  6 Sep 2022 20:40:03 +0000 (UTC)
Message-ID: <36a73401-7011-834a-7949-c65a2f66246c@redhat.com>
Date:   Tue, 6 Sep 2022 16:40:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, lixiong.liu@mediatek.com,
        wenju.xu@mediatek.com
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
 <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
 <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
 <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
 <02b8e7b3-941d-8bb9-cd0e-992738893ba3@redhat.com>
In-Reply-To: <02b8e7b3-941d-8bb9-cd0e-992738893ba3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/6/22 16:01, Waiman Long wrote:
> On 9/6/22 14:30, Tejun Heo wrote:
>> Hello,
>>
>> (cc'ing Waiman in case he has a better idea)
>>
>> On Mon, Sep 05, 2022 at 04:22:29PM +0800, Jing-Ting Wu wrote:
>>> https://lore.kernel.org/lkml/YvrWaml3F+x9Dk+T@slm.duckdns.org/ is for
>>> fix cgroup_threadgroup_rwsem <-> cpus_read_lock() deadlock.
>>> But this issue is cgroup_threadgroup_rwsem <-> cpuset_rwsem deadlock.
>> If I'm understanding what you're writing correctly, this isn't a 
>> deadlock.
>> The cpuset_hotplug_workfn simply isn't being woken up while holding
>> cpuset_rwsem and others are just waiting for that lock to be released.
>
> I believe it is probably a bug in the scheduler core code. 
> __set_cpus_allowed_ptr_locked() calls affine_move_task() to move to a 
> random cpu within the new set allowable CPUs. However, if migration is 
> disabled, it shouldn't call affine_move_task() at all. Instead, I 
> would suggest that if the current cpu is within the new allowable 
> cpus, it should just skip doing affine_move_task(). Otherwise, it 
> should fail __set_cpus_allowed_ptr_locked().

Maybe like

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 838623b68031..5d9ea1553ec0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2794,9 +2794,9 @@ static int __set_cpus_allowed_ptr_locked(struct 
task_struct *p,
                 if (cpumask_equal(&p->cpus_mask, new_mask))
                         goto out;

-               if (WARN_ON_ONCE(p == current &&
-                                is_migration_disabled(p) &&
-                                !cpumask_test_cpu(task_cpu(p), 
new_mask))) {
+               if (is_migration_disabled(p) &&
+                   !cpumask_test_cpu(task_cpu(p), new_mask)) {
+                       WARN_ON_ONCE(p == current);
                         ret = -EBUSY;
                         goto out;
                 }
@@ -2818,7 +2818,11 @@ static int __set_cpus_allowed_ptr_locked(struct 
task_struct *p,
         if (flags & SCA_USER)
                 user_mask = clear_user_cpus_ptr(p);

-       ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+       if (!is_migration_disabled(p) || (flags & SCA_MIGRATE_ENABLE)) {
+               ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+       } else {
+               task_rq_unlock(rq, p, rf);
+       }

         kfree(user_mask);

I haven't tested it myself, though.

Cheers,
Longman

