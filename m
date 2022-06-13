Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4429E549BDC
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiFMSlh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343779AbiFMSlR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 14:41:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898DCE27AA;
        Mon, 13 Jun 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655133918; x=1686669918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JW5UhPtRio+kyHQHU3wSuyJ4WK2TuQSRGooTeTBrTds=;
  b=e8MN8zX/BGgmSmE4mHUDI3ZCRVpWxgtIETXpYERpAQ/Jl/gc/WIHh/69
   QnmHjH/d4txcbQruy0Q7b1T5JSZk2iKY7vd3oqyA0kgB9lf5uuQdIHvmm
   ArffxEDtxjKUmD3ou9LaSaKhmrY0lrp7PNCPh9sZTzo182IRrDc3POrpD
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 08:25:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 08:25:17 -0700
Received: from [10.216.33.77] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 08:25:13 -0700
Message-ID: <9a93cf2d-0efe-5a46-dcd5-7dcd8f173188@quicinc.com>
Date:   Mon, 13 Jun 2022 20:55:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Use after free in cgroup_migrate_execute
Content-Language: en-US
To:     <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <brauner@kernel.org>, <hannes@cmpxchg.org>,
        shisiyuan <shisiyuan19870131@gmail.com>
References: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
 <Yh+RGIJ0f3nrqIiN@slm.duckdns.org>
 <8d21e655-4ce9-c7b3-2010-e484161bdbe9@quicinc.com>
 <20220516203417.GY1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220516203417.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+shisiyuan <shisiyuan19870131@gmail.com>

Hi Tejun/Paul,


Following patch is trying to fix the problem, which i reported earlier 
in this thread.

https://lore.kernel.org/lkml/1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com/#t


So, here is the issue.

Userspace want to migrate one group task from one CSS to another CSS.

Two process(P1, P2) which belongs to same process group but having
different cset C1 and C2 respectively. But here, finally P1, P2 need
to get migrated to C2 css.

1.

For P1,
cgroup_migrate_add_src<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_writ

It takes reference of src cset(c1) and add itself to mgctx 
preloaded_src_cset list.
list_add_tail(&src_cset->mg_preload_node, &mgctx->preloaded_src_csets);

2.For P2, Since P2 is already there in C2 and finally it has to go to C2 
css only. It takes reference of src_cset(C2) and add itself to 
           mgctx->preloaded_src_csets);

cgroup_migrate_add_src<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_writ

3. Now in a scenario while iterating through list preloaded_src_csets in 
cgroup_migrate_prepare_dst(),

We got dst_cset(C2) for a given src_cset (C1) for process P1 and since 
they are not equal. And here comes the main action, P1 will observe 
dst_cset->mg_preload_node (C2) as non empty and it is due 
src_cset->mg_preload_node(P2/C2) added itself to mgctx->preloaded_src_csets
both are same address and same cset P1 will mistakenly drop reference
to dst_cset and makes the dest cset(C2) reference out of order. In next 
iteration for p2, both src and destination cset are same so, it drop 
their references respectively.

4. Now, there comes a window there is no RCU lock and below path runs 
put reference on the task P2 and that eventually put reference on 
css(C2) and it get freed up as it reference broken due to extra mistaken
put_css_set in step 3.

rcuop/1-28    [005] 308947.813116: bprint: 
put_css_set_locked: cset:refzero:put_css_set_locked: 
0xffffff87f3e92800x: ref 0, Callers: 
(put_css_set<-__put_task_struct<-delayed_put_task_struct<-rcu_do_batch<-nocb_cb_wait<-rcu_nocb_cb_kthread<-kthread)

5. As the migration was going on, Now we hit two warnings b2b and a 
later BUG_ON which is shared in initial mail of this thread.

Let me know, if i am unable to explain any of the steps clearly.



-Mukesh


On 5/17/2022 2:04 AM, Paul E. McKenney wrote:
> On Mon, May 16, 2022 at 08:24:44PM +0530, Mukesh Ojha wrote:
>> +@paulmc
>>
>> It would be difficult to reproduce this with clean kernel.
>>
>> However, i have put trace_printk on the cset object and found that task
>> reference is dropped from rcu_do_batch() as below and later trying to get
>> same cset reference resulted in the warning and later BUG_ON().
>>
>> rcuop/0-16    [002]   255.430731: bprint:
>> put_css_set_locked:cset:refzero:put_css_set_locked:cset:0xffffff80274eb800:
>>
>> Callers (cgroup_free<-delayed_put_task_struct<-rcu_do_batch<-nocb_cb_wait<-rcu_nocb_cb_kthread<-kthread<-ret_from_fork)
>>
>> PERFD-SERVER-1387  [002]   255.432631: bprint: get_css_set: get_css_set:
>> 0xffffff80274eb800: Callers:(cgroup_migrate_execute<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_write)
>>
>> PERFD-SERVER-1387  [002]   255.456360: bprint: get_css_set: get_css_set:
>> 0xffffff80274eb800: Callers:(cgroup_migrate_execute<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_write)
> 
> If you can make this happen on small systems, you might try building with
> CONFIG_RCU_STRICT_GRACE_PERIOD=y, which will make RCU grace periods finish
> more quickly, possibly increasing the probability of hitting this problem.
> 
> 							Thanx, Paul
> 
>> Thanks,
>> -Mukesh
>>
>> On 3/2/2022 9:15 PM, Tejun Heo wrote:
>>> On Wed, Mar 02, 2022 at 08:42:32PM +0530, Mukesh Ojha wrote:
>>>> Hi ,
>>>>
>>>> We are facing one issue like below in cgroup .
>>>> Not able to find which race could lead to this.
>>>> Any idea, would be helpful.
>>>>
>>>> [136233.086904][ T1457] ------------[ cut here ]------------
>>>> *[136233.086912][ T1457] refcount_t: addition on 0; use-after-free.*
>>>> [136233.086943][ T1457] WARNING: CPU: 4 PID: 1457 at lib/refcount.c:25
>>>> cgroup_migrate_execute+0x188/0x528
>>>> [136233.087527][ T1457] CPU: 4 PID: 1457 Comm: PERFD-SERVER Tainted: G
>>>> S      WC O      5.10.66 #1
>>>> [136233.087532][ T1457] pstate: 62400085 (nZCv daIf +PAN -UAO +TCO BTYPE=--)
>>>> [136233.087536][ T1457] pc : cgroup_migrate_execute+0x188/0x528
>>>> [136233.087539][ T1457] lr : cgroup_migrate_execute+0x188/0x528
>>>> [136233.087541][ T1457] sp : ffffffc01ff23a60
>>>> [136233.087543][ T1457] x29: ffffffc01ff23a60 x28: 00000000c0000000
>>>> [136233.087547][ T1457] x27: ffffffffffffeaa8 x26: ffffff88cbc55668
>>>> [136233.087551][ T1457] x25: ffffff878424d458 x24: ffffff891fdd5e00
>>>> [136233.087557][ T1457] x23: ffffff88cbc55600 x22: ffffff8784d673d8
>>>> [136233.087565][ T1457] x21: ffffff88cbc55758 x20: ffffffc01ff23b20
>>>> [136233.087572][ T1457] x19: ffffffc01ff23b00 x18: ffffffc019475068
>>>> [136233.087580][ T1457] x17: 0000000000000000 x16: 0000000000162ba8
>>>> [136233.087587][ T1457] x15: 0000000000000004 x14: 000000000000407f
>>>> [136233.087594][ T1457] x13: ffffff8ae5d48be8 x12: 00000000ffffffff
>>>> [136233.087602][ T1457] x11: ffffff8785a79f98 x10: 0000000000000002
>>>> [136233.087609][ T1457] x9 : 759287265d79e000 x8 : 759287265d79e000
>>>> [136233.087616][ T1457] x7 : 206e6f206e6f6974 x6 : ffffffd7616121b4
>>>> [136233.087623][ T1457] x5 : ffffffffffffffff x4 : 0000000000000000
>>>> [136233.087629][ T1457] x3 : ffffffd7635ce996 x2 : 0000000000000000
>>>> [136233.087633][ T1457] x1 : ffffffd7635ce996 x0 : 000000000000002a
>>>> [136233.087636][ T1457] Call trace:
>>>> [136233.087640][ T1457]  cgroup_migrate_execute+0x188/0x528
>>>> [136233.087643][ T1457]  cgroup_migrate+0xb4/0xe4
>>>> [136233.087646][ T1457]  cgroup_attach_task+0x128/0x20c
>>>> [136233.087650][ T1457]  __cgroup1_procs_write+0x1d8/0x290
>>>> [136233.087653][ T1457]  cgroup1_procs_write+0x18/0x28
>>>> [136233.087656][ T1457]  cgroup_file_write+0xa4/0x544
>>>> [136233.087661][ T1457]  kernfs_fop_write_iter+0x1b0/0x2f8
>>>> [136233.087665][ T1457]  vfs_write+0x300/0x37c
>>>> [136233.087668][ T1457]  ksys_write+0x84/0x12c
>>>> [136233.087672][ T1457]  __arm64_sys_write+0x20/0x30
>>>> [136233.087676][ T1457]  el0_svc_common+0xdc/0x294
>>>> [136233.087681][ T1457]  el0_svc+0x38/0x9c
>>>> [136233.087684][ T1457]  el0_sync_handler+0x8c/0xf0
>>>> [136233.087688][ T1457]  el0_sync+0x1b4/0x1c0
>>>> [136233.087690][ T1457] ---[ end trace 9e592742965258ba ]---
>>>> [136233.087693][ T1457] ------------[ cut here ]------------
>>>> *[136233.087695][ T1457] refcount_t: saturated; leaking memory.*
>>>
>>> Looks like the target css_set ref underglowed but you have five taint flags
>>> set and this isn't even the first warning message. Any chance you can
>>> reproduce this in a cleaner environment?
>>>
>>> Thanks.
>>>
