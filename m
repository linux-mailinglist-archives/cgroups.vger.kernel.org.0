Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1B5E7D36
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiIWOe7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiIWOel (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 10:34:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FCB7E2;
        Fri, 23 Sep 2022 07:34:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NDx8tV026081;
        Fri, 23 Sep 2022 14:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Amh2W25vG622JwDCDmZuOupC0Zg1Foj/eEoyphdMAS8=;
 b=ZDQ0t2RdHHOc4K74nEIKRrclnpRoQIPoDvtRY6RsiNluzgAwDRT97zKmuaj+brDB4iJk
 TSZK5woDXrUMYWdGcgy6RQMuicy4qzguj/E2SUyPWvSav1KYPNcgVtAZUu8JQGIrHiiM
 xijtdqdeFn4++LpPiTQzqiKJ3/FbjEwp7icbAtuYLGCmGpGhDdEYMLB5sLOPEth2dK3j
 MUboDEuKZgDDcx3w8l8rYSdjnvUB0F8XZZCsNCora26Kesu/KEiz0lYnZqpJGNJuB6vR
 QXEcVjD+qVYo9NtecmpjeGtlCDJBkm61wnc7x9NenNEp33cJY7kDqjbJhCZVfXAR4DRX 5g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js67nhxys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 14:33:58 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28NEKWlp018414;
        Fri, 23 Sep 2022 14:20:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3jsbsa1gh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 14:20:32 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28NEKW4p018408;
        Fri, 23 Sep 2022 14:20:32 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 28NEKWlj018407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 14:20:32 +0000
Received: from [10.216.63.150] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 07:20:23 -0700
Message-ID: <e6153b89-1f41-3fff-241b-a767e41a1e7e@quicinc.com>
Date:   Fri, 23 Sep 2022 19:50:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
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
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <YxeylMvgc/wKcJqk@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EClpNyz9Q2SNicq3qJPb5J2Yh_clS8D0
X-Proofpoint-GUID: EClpNyz9Q2SNicq3qJPb5J2Yh_clS8D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=572 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230094
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Peter,


On 9/7/2022 2:20 AM, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 04:40:03PM -0400, Waiman Long wrote:
> 
> I've not followed the earlier stuff due to being unreadable; just
> reacting to this..

We are able to reproduce this issue explained at this link

https://lore.kernel.org/lkml/88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com/


> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 838623b68031..5d9ea1553ec0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2794,9 +2794,9 @@ static int __set_cpus_allowed_ptr_locked(struct
>> task_struct *p,
>>                  if (cpumask_equal(&p->cpus_mask, new_mask))
>>                          goto out;
>>
>> -               if (WARN_ON_ONCE(p == current &&
>> -                                is_migration_disabled(p) &&
>> -                                !cpumask_test_cpu(task_cpu(p), new_mask)))
>> {
>> +               if (is_migration_disabled(p) &&
>> +                   !cpumask_test_cpu(task_cpu(p), new_mask)) {
>> +                       WARN_ON_ONCE(p == current);
>>                          ret = -EBUSY;
>>                          goto out;
>>                  }
>> @@ -2818,7 +2818,11 @@ static int __set_cpus_allowed_ptr_locked(struct
>> task_struct *p,
>>          if (flags & SCA_USER)
>>                  user_mask = clear_user_cpus_ptr(p);
>>
>> -       ret = affine_move_task(rq, p, rf, dest_cpu, flags);
>> +       if (!is_migration_disabled(p) || (flags & SCA_MIGRATE_ENABLE)) {
>> +               ret = affine_move_task(rq, p, rf, dest_cpu, flags);
>> +       } else {
>> +               task_rq_unlock(rq, p, rf);
>> +       }
> 
> This cannot be right. There might be previous set_cpus_allowed_ptr()
> callers that are blocked and waiting for the task to land on a valid
> CPU.
> 

Was thinking if just skipping as below will help here, well i am not sure .

But thinking what if we keep the task as it is on the same cpu and let's 
wait for migration to be enabled for the task to take care of it later.

------------------->O------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d90d37c..7717733 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2390,8 +2390,10 @@ static int migration_cpu_stop(void *data)
          * we're holding p->pi_lock.
          */
         if (task_rq(p) == rq) {
-               if (is_migration_disabled(p))
+               if (is_migration_disabled(p)) {
+                       complete = true;
                         goto out;
+               }

                 if (pending) {


-Mukesh
