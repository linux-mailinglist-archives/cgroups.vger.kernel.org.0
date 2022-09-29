Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E235EF86E
	for <lists+cgroups@lfdr.de>; Thu, 29 Sep 2022 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiI2POB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Sep 2022 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiI2POA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Sep 2022 11:14:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E514C058;
        Thu, 29 Sep 2022 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664464437; x=1696000437;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=G/e61zul7HNCHKUCokTMpB1fZU2sjgcjzI//4g1OuSI=;
  b=MhBOhu/s26kyoF+RO9E69IypTi9SfYYgrUA3V19bNM6SmelBvdJKx2xy
   JGzCmolkzV6AWIQnaaZ0ay+bCBm7ZvQm5pCyABmFY6j7l8c3flJ+QOyM+
   BMCb2X1IfFMc/QMrt5DiXxyPJl1lg7wjXgask0ydyXy5cKUujvZEOB02Y
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Sep 2022 08:13:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:13:56 -0700
Received: from [10.216.55.35] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 08:13:47 -0700
Message-ID: <cdb597d4-6543-3e34-cbbd-6a776b0d6581@quicinc.com>
Date:   Thu, 29 Sep 2022 20:43:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Tejun Heo <tj@kernel.org>,
        Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        <cgroups@vger.kernel.org>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
 <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
 <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
 <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
 <02b8e7b3-941d-8bb9-cd0e-992738893ba3@redhat.com>
 <36a73401-7011-834a-7949-c65a2f66246c@redhat.com>
 <YxeylMvgc/wKcJqk@hirez.programming.kicks-ass.net>
 <e6153b89-1f41-3fff-241b-a767e41a1e7e@quicinc.com>
In-Reply-To: <e6153b89-1f41-3fff-241b-a767e41a1e7e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All,

On 9/23/2022 7:50 PM, Mukesh Ojha wrote:
> Hi Peter,
> 
> 
> On 9/7/2022 2:20 AM, Peter Zijlstra wrote:
>> On Tue, Sep 06, 2022 at 04:40:03PM -0400, Waiman Long wrote:
>>
>> I've not followed the earlier stuff due to being unreadable; just
>> reacting to this..
> 
> We are able to reproduce this issue explained at this link
> 
> https://lore.kernel.org/lkml/88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com/ 
> 
> 
> 
>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 838623b68031..5d9ea1553ec0 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -2794,9 +2794,9 @@ static int __set_cpus_allowed_ptr_locked(struct
>>> task_struct *p,
>>>                  if (cpumask_equal(&p->cpus_mask, new_mask))
>>>                          goto out;
>>>
>>> -               if (WARN_ON_ONCE(p == current &&
>>> -                                is_migration_disabled(p) &&
>>> -                                !cpumask_test_cpu(task_cpu(p), 
>>> new_mask)))
>>> {
>>> +               if (is_migration_disabled(p) &&
>>> +                   !cpumask_test_cpu(task_cpu(p), new_mask)) {
>>> +                       WARN_ON_ONCE(p == current);
>>>                          ret = -EBUSY;
>>>                          goto out;
>>>                  }
>>> @@ -2818,7 +2818,11 @@ static int __set_cpus_allowed_ptr_locked(struct
>>> task_struct *p,
>>>          if (flags & SCA_USER)
>>>                  user_mask = clear_user_cpus_ptr(p);
>>>
>>> -       ret = affine_move_task(rq, p, rf, dest_cpu, flags);
>>> +       if (!is_migration_disabled(p) || (flags & SCA_MIGRATE_ENABLE)) {
>>> +               ret = affine_move_task(rq, p, rf, dest_cpu, flags);
>>> +       } else {
>>> +               task_rq_unlock(rq, p, rf);
>>> +       }
>>
>> This cannot be right. There might be previous set_cpus_allowed_ptr()
>> callers that are blocked and waiting for the task to land on a valid
>> CPU.
>>
> 
> Was thinking if just skipping as below will help here, well i am not sure .
> 
> But thinking what if we keep the task as it is on the same cpu and let's 
> wait for migration to be enabled for the task to take care of it later.
> 
> ------------------->O------------------------------------------
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d90d37c..7717733 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2390,8 +2390,10 @@ static int migration_cpu_stop(void *data)
>           * we're holding p->pi_lock.
>           */
>          if (task_rq(p) == rq) {
> -               if (is_migration_disabled(p))
> +               if (is_migration_disabled(p)) {
> +                       complete = true;
>                          goto out;
> +               }
> 
>                  if (pending) {
> 

Any suggestion on this bug ?


-Mukesh
