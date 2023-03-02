Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4266A8097
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 12:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCBLBB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 06:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCBLA7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 06:00:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DC38E85;
        Thu,  2 Mar 2023 03:00:53 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229Dsxw000535;
        Thu, 2 Mar 2023 10:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TzrXmP+2U6IcHdZs5ijAwKmBqDh8epY+JpxwabaVz8g=;
 b=eLmwr3dC8+CuqFPkVAB+JctkS6szkE4FwPXZnfNzJfMIYKSLSd34/8Bof1HUfc6LO/9D
 GLnQFUeAajuHxVQq+phtDPlNjusIWheoHlE6PCM9z7YEEPRdr0vsQD0pFUyU85TFoOfD
 cR4oXr19MFwWW8Uefe3YpEiP8D1MJOyXqmlAK8wT/vz0tH5xeDPXqQCx6XWpr1cX1aAw
 eGAyhV7THfasQgt6bTBu5espCGlhdzEjaVuqFt8+kOP5hGz1XlKDRtQf9Ej/KDNsq+yJ
 DnM2eR1zheW5J/BFRAxILU1NrSAdDROtzFDtYM1/PkP0PUl1W9czDxpCddUW/eFCcqAH Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2ryv2nr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 10:59:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 322Axur7022962;
        Thu, 2 Mar 2023 10:59:56 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2ryv2nqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 10:59:56 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3228uUaW020089;
        Thu, 2 Mar 2023 10:59:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3nybe24es8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 10:59:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 322AxsrU3932784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 10:59:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D78358058;
        Thu,  2 Mar 2023 10:59:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE39058057;
        Thu,  2 Mar 2023 10:59:42 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 10:59:42 +0000 (GMT)
Message-ID: <913b0491-cef6-87ac-bf7e-d6d6c8fc380a@linux.vnet.ibm.com>
Date:   Thu, 2 Mar 2023 16:29:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v12 8/8] sched/fair: Add latency list
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-9-vincent.guittot@linaro.org>
 <4982b608-f8c7-531c-3322-c055643a5b2d@linux.vnet.ibm.com>
 <CAKfTPtAEbzrxKOGXYRxp0qMM-TPj1q8BdcaVpK7ObZfe8QWn4g@mail.gmail.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <CAKfTPtAEbzrxKOGXYRxp0qMM-TPj1q8BdcaVpK7ObZfe8QWn4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NWp7DmpGbnikrFJYoEDQ3RBqy-MCfLPc
X-Proofpoint-ORIG-GUID: j4h-e77cflEwfYNSEnxM4hMz8zpkSUfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 3/2/23 1:20 PM, Vincent Guittot wrote:
> On Wed, 1 Mar 2023 at 19:48, shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:
>>
>> On 2/24/23 3:04 PM, Vincent Guittot wrote:
>>> Add a rb tree for latency sensitive entities so we can schedule the most
>>> sensitive one first even when it failed to preempt current at wakeup or
>>> when it got quickly preempted by another entity of higher priority.
>>>
>>> In order to keep fairness, the latency is used once at wakeup to get a
>>> minimum slice and not during the following scheduling slice to prevent
>>> long running entity to got more running time than allocated to his nice
>>> priority.
>>>
>>> The rb tree enables to cover the last corner case where latency
>>> sensitive entity can't got schedule quickly after the wakeup.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> ---
>>>  include/linux/sched.h |   1 +
>>>  kernel/sched/core.c   |   1 +
>>>  kernel/sched/fair.c   | 109 ++++++++++++++++++++++++++++++++++++++++--
>>>  kernel/sched/sched.h  |   1 +
>>>  4 files changed, 109 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index 38decae3e156..41bb92be5ecc 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -548,6 +548,7 @@ struct sched_entity {
>>>       /* For load-balancing: */
>>>       struct load_weight              load;
>>>       struct rb_node                  run_node;
>>> +     struct rb_node                  latency_node;
>> Ran pahole to see if the frequently accessed fields change across cachelines.
>> There is no change in cachelines of task_struct, whereas sched_entity differs
>> due to latency_node.  Maybe the latency_node could be placed after
>> runnable_weight as there is space available in that cacheline.
> I will run some test on my system to confimr your results but we can
> move latency_node field if it helps cache hit stats
>
>>
>> 6.2
>> #pahole sched_entity
>> struct sched_entity {
>>         struct load_weight         load;                 /*     0    16 */
>>
>>         /* XXX last struct has 4 bytes of padding */
>>
>>         struct rb_node             run_node;             /*    16    24 */
>>         struct list_head           group_node;           /*    40    16 */
>>         unsigned int               on_rq;                /*    56     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         u64                        exec_start;           /*    64     8 */
>>         u64                        sum_exec_runtime;     /*    72     8 */
>>         u64                        vruntime;             /*    80     8 */
>>         u64                        prev_sum_exec_runtime; /*    88     8 */
>>         u64                        nr_migrations;        /*    96     8 */
>>         int                        depth;                /*   104     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         struct sched_entity *      parent;               /*   112     8 */
>>         struct cfs_rq *            cfs_rq;               /*   120     8 */
>>         /* --- cacheline 1 boundary (128 bytes) --- */
>>         struct cfs_rq *            my_q;                 /*   128     8 */
>>         long unsigned int          runnable_weight;      /*   136     8 */
>>
>>         /* XXX 112 bytes hole, try to pack */
>>
>>         /* --- cacheline 2 boundary (256 bytes) --- */
>>         struct sched_avg           avg;                  /*   256   128 */
>>
>>
>> 6.2 + V12 patch
>> #pahole sched_entity
>> struct sched_entity {
>>         struct load_weight         load;                 /*     0    16 */
>>
>>         /* XXX last struct has 4 bytes of padding */
>>
>>         struct rb_node             run_node;             /*    16    24 */
>>         struct rb_node             latency_node;         /*    40    24 */
>>         struct list_head           group_node;           /*    64    16 */
>>         unsigned int               on_rq;                /*    80     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         u64                        exec_start;           /*    88     8 */
>>         u64                        sum_exec_runtime;     /*    96     8 */
>>         u64                        vruntime;             /*   104     8 */
>>         u64                        prev_sum_exec_runtime; /*   112     8 */
>>         u64                        nr_migrations;        /*   120     8 */
>>         /* --- cacheline 1 boundary (128 bytes) --- */
>>         int                        depth;                /*   128     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         struct sched_entity *      parent;               /*   136     8 */
>>         struct cfs_rq *            cfs_rq;               /*   144     8 */
>>         struct cfs_rq *            my_q;                 /*   152     8 */
>>
>>
>> 6.2 + V12 patch + Re-shuffle of latency_node
>> #pahole sched_entity
>> struct sched_entity {
>>         struct load_weight         load;                 /*     0    16 */
>>
>>         /* XXX last struct has 4 bytes of padding */
>>
>>         struct rb_node             run_node;             /*    16    24 */
>>         struct list_head           group_node;           /*    40    16 */
>>         unsigned int               on_rq;                /*    56     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         u64                        exec_start;           /*    64     8 */
>>         u64                        sum_exec_runtime;     /*    72     8 */
>>         u64                        vruntime;             /*    80     8 */
>>         u64                        prev_sum_exec_runtime; /*    88     8 */
>>         u64                        nr_migrations;        /*    96     8 */
>>         int                        depth;                /*   104     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         struct sched_entity *      parent;               /*   112     8 */
>>         struct cfs_rq *            cfs_rq;               /*   120     8 */
>>         /* --- cacheline 1 boundary (128 bytes) --- */
>>         struct cfs_rq *            my_q;                 /*   128     8 */
>>         long unsigned int          runnable_weight;      /*   136     8 */
>>         struct rb_node             latency_node;         /*   144    24 */
>>         long int                   latency_offset;       /*   168     8 */
>>
>>         /* XXX 80 bytes hole, try to pack */
>>
>>         /* --- cacheline 2 boundary (256 bytes) --- */
>>
>>
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index a2b52cf5e1bb..1e93aaaeead2 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -548,7 +548,6 @@ struct sched_entity {
>>         /* For load-balancing: */
>>         struct load_weight              load;
>>         struct rb_node                  run_node;
>> -       struct rb_node                  latency_node;
>>         struct list_head                group_node;
>>         unsigned int                    on_rq;
>>
>> @@ -569,6 +568,7 @@ struct sched_entity {
>>         /* cached value of my_q->h_nr_running */
>>         unsigned long                   runnable_weight;
>>  #endif
>> +       struct rb_node                  latency_node;
>>         /* preemption offset in ns */
>>         long                            latency_offset;
>>
>>
>> Ran the schbench and hackbench with this patch series. Here comparison is
>> between 6.2 stable tree, 6.2 + Patch and 6.2 + patch + above re-arrange of
>> latency_node. Ran two cgroups, in one cgroup running stress-ng at 50%(group1)
>> and other is running these benchmarks (group2). Set the latency nice
>> of group2 to -20. These are run on Power system with 12 cores with SMT=8.
>> Total of 96 CPU.
>>
>> schbench gets lower latency compared to stabletree. Whereas hackbench seems
>> to regress under this case. Maybe i am doing something wrong. I will re-run
>> and attach the numbers to series.
>> Please suggest if any variation in the test i need to try.
> hackbench takes advanatge of a latency nice 19 as it mainly wants to
> run longer slice to move forward rather than preempting others all the
> time

hackbench still seems to regress in different latency nice values compared to
baseline of 6.2 in this case. up to 50% in some cases.

12 core powerpc system  with SMT=8 i.e 96 CPU
running 2 CPU cgroups. No quota assigned.
1st cgroup is running stress-ng with 48 threads. Consuming 50% of CPU.
latency is not changed for this cgroup.
2nd cgroup is running hackbench. This cgroup is assigned the different latency
nice values of 0, -20 and 19. 

Numbers are average of 10 runs in each case. Time is in seconds

type	   groups |   v6.2     |  v6.2 + V12   | v6.2 + V12  | v6.2 + V12
		  |	       | lat nice=0    | lat nice=-20| lat nice=+19
		  |	       |	       |             |
Process       10  |   0.36     |     0.41      |    0.43     |    0.42
Process	      20  |   0.62     |     0.76      |    0.75     |    0.75
Process       30  |   0.87     |     1.05      |    1.04     |    1.06
Process       40  |   1.13     |     1.34      |    1.33     |    1.33
Process       50  |   1.38     |     1.62      |    1.66     |    1.63
Process       60  |   1.64     |     1.91      |    1.97     |    1.90
thread        10  |   0.35     |     0.41      |    0.44     |    0.42
thread        20  |   0.64     |     0.78      |    0.77     |    0.79
Process(Pipe) 10  |   0.20     |     0.34      |    0.33     |    0.34
Process(Pipe) 20  |   0.32     |     0.52      |    0.53     |    0.52
Process(Pipe) 30  |   0.44     |     0.70      |    0.70     |    0.69
Process(Pipe) 40  |   0.56     |     0.88      |    0.89     |    0.88
Process(Pipe) 50  |   0.70     |     1.08      |    1.08     |    1.07
Process(Pipe) 60  |   0.83     |     1.27      |    1.27     |    1.26
thread(Pipe)  10  |   0.21     |     0.35      |    0.34     |    0.36
thread(Pipe)  10  |   0.35     |     0.55      |    0.58     |    0.55



>> Re-arrange seems to help the patch series by avoiding an cacheline miss.
>>
>> =========================
>> schbench
>> =========================
>>                  6.2   |  6.2 + V12     |     6.2 + V12 + re-arrange
>> 1 Thread
>>   50.0th:        9.00  |    9.00        |        9.50
>>   75.0th:       10.50  |   10.00        |        9.50
>>   90.0th:       11.00  |   11.00        |       10.50
>>   95.0th:       11.00  |   11.00        |       11.00
>>   99.0th:       11.50  |   11.50        |       11.50
>>   99.5th:       12.50  |   12.00        |       12.00
>>   99.9th:       14.50  |   13.50        |       12.00
>> 2 Threads
>>   50.0th:        9.50  |    9.50        |        8.50
>>   75.0th:       11.00  |   10.50        |        9.50
>>   90.0th:       13.50  |   11.50        |       10.50
>>   95.0th:       14.00  |   12.00        |       11.00
>>   99.0th:       15.50  |   13.50        |       12.00
>>   99.5th:       16.00  |   14.00        |       12.00
>>   99.9th:       17.00  |   16.00        |       16.50
>> 4 Threads
>>   50.0th:       11.50  |   11.50        |       10.50
>>   75.0th:       13.50  |   12.50        |       12.50
>>   90.0th:       15.50  |   14.50        |       14.00
>>   95.0th:       16.50  |   15.50        |       14.50
>>   99.0th:       20.00  |   17.50        |       16.50
>>   99.5th:       20.50  |   18.50        |       17.00
>>   99.9th:       22.50  |   21.00        |       19.00
>> 8 Threads
>>   50.0th:       14.00  |   14.00        |       14.00
>>   75.0th:       16.00  |   16.00        |       16.00
>>   90.0th:       18.00  |   18.00        |       17.50
>>   95.0th:       18.50  |   18.50        |       18.50
>>   99.0th:       20.00  |   20.00        |       20.00
>>   99.5th:       20.50  |   21.50        |       21.00
>>   99.9th:       22.50  |   23.50        |       23.00
>> 16 Threads
>>   50.0th:       19.00  |   18.50        |       19.00
>>   75.0th:       23.00  |   22.50        |       23.00
>>   90.0th:       25.00  |   25.50        |       25.00
>>   95.0th:       26.50  |   26.50        |       26.00
>>   99.0th:       28.50  |   29.00        |       28.50
>>   99.5th:       31.00  |   30.00        |       30.00
>>   99.9th:     5626.00  | 4761.50        |       32.50
>> 32 Threads
>>   50.0th:       27.00  |   27.50        |       29.00
>>   75.0th:       35.50  |   36.50        |       38.50
>>   90.0th:       42.00  |   44.00        |       50.50
>>   95.0th:      447.50  | 2959.00        |     8544.00
>>   99.0th:     7372.00  | 17032.00       |    19136.00
>>   99.5th:    15360.00  | 19808.00       |    20704.00
>>   99.9th:    20640.00  | 30048.00       |    30048.00
>>
>> ====================
>> hackbench
>> ====================
>>                         6.2     |  6.2 + V12        |     6.2+ V12 +re-arrange
>>
>> Process 10 Time:        0.35    |       0.42        |           0.41
>> Process 20 Time:        0.61    |       0.76        |           0.76
>> Process 30 Time:        0.87    |       1.06        |           1.05
>> thread 10 Time:         0.35    |       0.43        |           0.42
>> thread 20 Time:         0.66    |       0.79        |           0.78
>> Process(Pipe) 10 Time:  0.21    |       0.33        |           0.32
>> Process(Pipe) 20 Time:  0.34    |       0.52        |           0.52
>> Process(Pipe) 30 Time:  0.46    |       0.72        |           0.71
>> thread(Pipe) 10 Time:   0.21    |       0.34        |           0.34
>> thread(Pipe) 20 Time:   0.36    |       0.56        |           0.56
>>
>>
>>>       struct list_head                group_node;
>>>       unsigned int                    on_rq;
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 093cc1af73dc..752fd364216c 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4434,6 +4434,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>>       p->se.nr_migrations             = 0;
>>>       p->se.vruntime                  = 0;
>>>       INIT_LIST_HEAD(&p->se.group_node);
>>> +     RB_CLEAR_NODE(&p->se.latency_node);
>>>
>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>>       p->se.cfs_rq                    = NULL;
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 125a6ff53378..e2aeb4511686 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -680,7 +680,85 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>>>
>>>       return __node_2_se(last);
>>>  }
>>> +#endif
>>>
>>> +/**************************************************************
>>> + * Scheduling class tree data structure manipulation methods:
>>> + * for latency
>>> + */
>>> +
>>> +static inline bool latency_before(struct sched_entity *a,
>>> +                             struct sched_entity *b)
>>> +{
>>> +     return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
>>> +}
>>> +
>>> +#define __latency_node_2_se(node) \
>>> +     rb_entry((node), struct sched_entity, latency_node)
>>> +
>>> +static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
>>> +{
>>> +     return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
>>> +}
>>> +
>>> +/*
>>> + * Enqueue an entity into the latency rb-tree:
>>> + */
>>> +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>> +{
>>> +
>>> +     /* Only latency sensitive entity can be added to the list */
>>> +     if (se->latency_offset >= 0)
>>> +             return;
>>> +
>>> +     if (!RB_EMPTY_NODE(&se->latency_node))
>>> +             return;
>>> +
>>> +     /*
>>> +      * The entity is always added the latency list at wakeup.
>>> +      * Then, a not waking up entity that is put back in the list after an
>>> +      * execution time less than sysctl_sched_min_granularity, means that
>>> +      * the entity has been preempted by a higher sched class or an entity
>>> +      * with higher latency constraint. In thi case, the entity is also put
>>> +      * back in the latency list so it gets a chance to run 1st during the
>>> +      * next slice.
>>> +      */
>>> +     if (!(flags & ENQUEUE_WAKEUP)) {
>>> +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
>>> +
>>> +             if (delta_exec >= sysctl_sched_min_granularity)
>>> +                     return;
>>> +     }
>>> +
>>> +     rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
>>> +}
>>> +
>>> +/*
>>> + * Dequeue an entity from the latency rb-tree and return true if it was really
>>> + * part of the rb-tree:
>>> + */
>>> +static bool __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>> +{
>>> +     if (!RB_EMPTY_NODE(&se->latency_node)) {
>>> +             rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
>>> +             RB_CLEAR_NODE(&se->latency_node);
>>> +             return true;
>>> +     }
>>> +
>>> +     return false;
>>> +}
>>> +
>>> +static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
>>> +{
>>> +     struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
>>> +
>>> +     if (!left)
>>> +             return NULL;
>>> +
>>> +     return __latency_node_2_se(left);
>>> +}
>>> +
>>> +#ifdef CONFIG_SCHED_DEBUG
>>>  /**************************************************************
>>>   * Scheduling class statistics methods:
>>>   */
>>> @@ -4758,8 +4836,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>       check_schedstat_required();
>>>       update_stats_enqueue_fair(cfs_rq, se, flags);
>>>       check_spread(cfs_rq, se);
>>> -     if (!curr)
>>> +     if (!curr) {
>>>               __enqueue_entity(cfs_rq, se);
>>> +             __enqueue_latency(cfs_rq, se, flags);
>>> +     }
>>>       se->on_rq = 1;
>>>
>>>       if (cfs_rq->nr_running == 1) {
>>> @@ -4845,8 +4925,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>
>>>       clear_buddies(cfs_rq, se);
>>>
>>> -     if (se != cfs_rq->curr)
>>> +     if (se != cfs_rq->curr) {
>>>               __dequeue_entity(cfs_rq, se);
>>> +             __dequeue_latency(cfs_rq, se);
>>> +     }
>>>       se->on_rq = 0;
>>>       account_entity_dequeue(cfs_rq, se);
>>>
>>> @@ -4941,6 +5023,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>                */
>>>               update_stats_wait_end_fair(cfs_rq, se);
>>>               __dequeue_entity(cfs_rq, se);
>>> +             __dequeue_latency(cfs_rq, se);
>>>               update_load_avg(cfs_rq, se, UPDATE_TG);
>>>       }
>>>
>>> @@ -4979,7 +5062,7 @@ static struct sched_entity *
>>>  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>  {
>>>       struct sched_entity *left = __pick_first_entity(cfs_rq);
>>> -     struct sched_entity *se;
>>> +     struct sched_entity *latency, *se;
>>>
>>>       /*
>>>        * If curr is set we have to see if its left of the leftmost entity
>>> @@ -5021,6 +5104,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>               se = cfs_rq->last;
>>>       }
>>>
>>> +     /* Check for latency sensitive entity waiting for running */
>>> +     latency = __pick_first_latency(cfs_rq);
>>> +     if (latency && (latency != se) &&
>>> +         wakeup_preempt_entity(latency, se) < 1)
>>> +             se = latency;
>>> +
>>>       return se;
>>>  }
>>>
>>> @@ -5044,6 +5133,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
>>>               update_stats_wait_start_fair(cfs_rq, prev);
>>>               /* Put 'current' back into the tree. */
>>>               __enqueue_entity(cfs_rq, prev);
>>> +             __enqueue_latency(cfs_rq, prev, 0);
>>>               /* in !on_rq case, update occurred at dequeue */
>>>               update_load_avg(cfs_rq, prev, 0);
>>>       }
>>> @@ -12222,6 +12312,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>>>  void init_cfs_rq(struct cfs_rq *cfs_rq)
>>>  {
>>>       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
>>> +     cfs_rq->latency_timeline = RB_ROOT_CACHED;
>>>       u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
>>>  #ifdef CONFIG_SMP
>>>       raw_spin_lock_init(&cfs_rq->removed.lock);
>>> @@ -12378,6 +12469,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>>>       se->my_q = cfs_rq;
>>>
>>>       se->latency_offset = calc_latency_offset(tg->latency_prio);
>>> +     RB_CLEAR_NODE(&se->latency_node);
>>>
>>>       /* guarantee group entities always have weight */
>>>       update_load_set(&se->load, NICE_0_LOAD);
>>> @@ -12529,8 +12621,19 @@ int sched_group_set_latency(struct task_group *tg, int prio)
>>>
>>>       for_each_possible_cpu(i) {
>>>               struct sched_entity *se = tg->se[i];
>>> +             struct rq *rq = cpu_rq(i);
>>> +             struct rq_flags rf;
>>> +             bool queued;
>>> +
>>> +             rq_lock_irqsave(rq, &rf);
>>>
>>> +             queued = __dequeue_latency(se->cfs_rq, se);
>>>               WRITE_ONCE(se->latency_offset, latency_offset);
>>> +             if (queued)
>>> +                     __enqueue_latency(se->cfs_rq, se, ENQUEUE_WAKEUP);
>>> +
>>> +
>>> +             rq_unlock_irqrestore(rq, &rf);
>>>       }
>>>
>>>       mutex_unlock(&shares_mutex);
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 9a2e71231083..21dd309e98a9 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -570,6 +570,7 @@ struct cfs_rq {
>>>  #endif
>>>
>>>       struct rb_root_cached   tasks_timeline;
>>> +     struct rb_root_cached   latency_timeline;
>>>
>>>       /*
>>>        * 'curr' points to currently running entity on this cfs_rq.

