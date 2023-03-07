Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189F6ADC6E
	for <lists+cgroups@lfdr.de>; Tue,  7 Mar 2023 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCGKwp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Mar 2023 05:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCGKwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Mar 2023 05:52:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C7265BA;
        Tue,  7 Mar 2023 02:52:41 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Ah99I014111;
        Tue, 7 Mar 2023 10:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D4DJjWkX7TZXqga+0eQcxhOR7UHc24y1fbspulQdBFA=;
 b=CjqnM6CrnMBkzCKmgBnd5+Vttv+qEA3lZxKl+A1zWzQueWedVOVIIPFX4q9vMPMtmNSX
 /lmg6zBx3SuEsaj/C0ROFedkQ2RyzCK+WfoXdXjuzrVq7XvHOd6nDvXx6H94aCp2jIcv
 HaWrfeBs+99u8kpXk9+IL9ULPnNfdXUH/zXUSqiMcM5hK/8yx448jR1P2VAANlNZuiHh
 p+IwYXiZUDmk82y5MNO7+cENgIazA+rrsr2UCRR8jy8rgFVxL204uf7dmXTKfPojrPGm
 rxQNie9N0g+UcPkagEmlwC15V8xPGkSkiejQekPvbN9R70udkMD0shbf9PgSskbgrc/R og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p500easv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:51:53 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327AjpIB027923;
        Tue, 7 Mar 2023 10:51:52 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p500easuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:51:52 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3279xLi7023891;
        Tue, 7 Mar 2023 10:51:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p4187f908-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:51:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327Apmap6226658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 10:51:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B34058053;
        Tue,  7 Mar 2023 10:51:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4CB5805D;
        Tue,  7 Mar 2023 10:50:27 +0000 (GMT)
Received: from [9.43.35.84] (unknown [9.43.35.84])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 10:50:27 +0000 (GMT)
Message-ID: <69e18715-f868-132b-8898-0787a60e6840@linux.vnet.ibm.com>
Date:   Tue, 7 Mar 2023 16:20:25 +0530
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
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
References: <913b0491-cef6-87ac-bf7e-d6d6c8fc380a@linux.vnet.ibm.com>
 <CAKfTPtA5wqBb1hAQa=qd6CicJbHsRi+q=s2tT0n6XspGOEA2Xg@mail.gmail.com>
 <7dd8fa7e-3cbc-6d3f-5748-74ffdeb056a7@linux.vnet.ibm.com>
 <2226e488-390d-ed64-832e-ca8e6a3a1731@linux.vnet.ibm.com>
 <ZAIg5de3EkHtHqLM@vingu-book>
 <48b8f849-fa81-d968-8fb6-b25c5fe94edb@linux.vnet.ibm.com>
 <CAKfTPtA9=03eeXemrVDFHCviqS4NOBLedkbcG_FwGd2SfAd+wQ@mail.gmail.com>
 <0f19b215-5841-bea4-20a5-beda39d8dad7@linux.vnet.ibm.com>
 <ZAX/OOm4IP41NcHY@vingu-book>
 <ed4a5323-44e8-590e-1050-4b7b948c5688@linux.vnet.ibm.com>
 <ZAcPzgCJliKwAArU@vingu-book>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZAcPzgCJliKwAArU@vingu-book>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O-xQQXgcWE5V4JCy_FzUjhUcR27hrMIy
X-Proofpoint-GUID: 7EygAWlbffchrTVq4Dh37l8q_U4iBWqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 3/7/23 3:49 PM, Vincent Guittot wrote:
> Le mardi 07 mars 2023 à 00:34:49 (+0530), Shrikanth Hegde a écrit :
>>> Le lundi 06 mars 2023 à 17:03:30 (+0530), Shrikanth Hegde a écrit :
>>>> On 3/5/23 6:33 PM, Vincent Guittot wrote:
>>>>> On Sat, 4 Mar 2023 at 16:13, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>>>>>> On 3/3/23 10:01 PM, Vincent Guittot wrote:
>>>>>>> Le jeudi 02 mars 2023 à 23:37:52 (+0530), Shrikanth Hegde a écrit :
>>>>>>>> On 3/2/23 8:30 PM, Shrikanth Hegde wrote:
>>>>>>>>> On 3/2/23 6:47 PM, Vincent Guittot wrote:
>>>>>>>>>> On Thu, 2 Mar 2023 at 12:00, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>>>>>>>>>>> On 3/2/23 1:20 PM, Vincent Guittot wrote:
>>>>>>>>>>>> On Wed, 1 Mar 2023 at 19:48, shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:
>>>>>>>>>>>>> On 2/24/23 3:04 PM, Vincent Guittot wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>>>>>>>> Ran the schbench and hackbench with this patch series. Here comparison is
>>>>>>>>>>>>> between 6.2 stable tree, 6.2 + Patch and 6.2 + patch + above re-arrange of
>>>>>>>>>>>>> latency_node. Ran two cgroups, in one cgroup running stress-ng at 50%(group1)
>>>>>>>>>>>>> and other is running these benchmarks (group2). Set the latency nice
>>>>>>>>>>>>> of group2 to -20. These are run on Power system with 12 cores with SMT=8.
>>>>>>>>>>>>> Total of 96 CPU.
>>>>>>>>>>>>>
>>>>>>>>>>>>> schbench gets lower latency compared to stabletree. Whereas hackbench seems
>>>>>>>>>>>>> to regress under this case. Maybe i am doing something wrong. I will re-run
>>>>>>>>>>>>> and attach the numbers to series.
>>>>>>>>>>>>> Please suggest if any variation in the test i need to try.
>>>>>>>>>>>> hackbench takes advanatge of a latency nice 19 as it mainly wants to
>>>>>>>>>>>> run longer slice to move forward rather than preempting others all the
>>>>>>>>>>>> time
>>>>>>>>>>> hackbench still seems to regress in different latency nice values compared to
>>>>>>>>>>> baseline of 6.2 in this case. up to 50% in some cases.
>>>>>>>>>>>
>>>>>>>>>>> 12 core powerpc system  with SMT=8 i.e 96 CPU
>>>>>>>>>>> running 2 CPU cgroups. No quota assigned.
>>>>>>>>>>> 1st cgroup is running stress-ng with 48 threads. Consuming 50% of CPU.
>>>>>>>>>>> latency is not changed for this cgroup.
>>>>>>>>>>> 2nd cgroup is running hackbench. This cgroup is assigned the different latency
>>>>>>>>>>> nice values of 0, -20 and 19.
>>>>>>>>>> According to your other emails, you are using the cgroup interface and
>>>>>>>>>> not the task's one. Do I get it right ?
>>>>>>>>> right. I create cgroup, attach bash command with echo $$,
>>>>>>>>> assign the latency nice to cgroup, and run hackbench from that bash prompt.
>>>>>>>>>
>>>>>>>>>> I haven't run test such tests in a cgroup but at least the test with
>>>>>>>>>> latency_nice == 0 should not make any noticeable difference. Does this
>>>>>>>>>> include the re-arrange patch that you have proposed previously ?
>> Ran the test on a different system altogether. I don't see similar regression there. 
>> In fact latency nice is helping in reducing the latency as expected.
>> It is much bigger system with 60 cores. i.e total of 480 cpu.
>>
>> Tested in the same way. created two cgroups. one is running the micro benchmarks
>> and other is running stress-ng at different utilization point.
>> This data is at 50% utilization point. Similar observations w.r.t latency
>> is seen at 0%, 25%, 75% and 100% utilization as well. 
>>
> Thanks for testing on a different system which seems to get results aligned with what
> Prateek and I have seen on our system.
>
>
>> ==========
>> schbench
>> ==========
>> 	       6.2	      6.2 + V12 + LN=0
>> Groups: 1
>> 50.0th:                 14.0             12.5
>> 75.0th:                 16.5             14.0
>> 90.0th:                 18.5             15.5
>> 95.0th:                 20.5             17.0
>> 99.0th:                 27.5             21.0
>> 99.5th:                 36.0             23.5
>> Groups: 2
>> 50.0th:                 14.0             16.0
>> 75.0th:                 17.0             18.0
>> 90.0th:                 20.0             21.0
>> 95.0th:                 23.0             23.0
>> 99.0th:                 71.0             34.0
>> 99.5th:               1170.0             96.0
>> 99.9th:               5088.0           3212.0
>> Groups: 4
>> 50.0th:                 20.5             19.5
>> 75.0th:                 24.5             22.5
>> 90.0th:                 31.0             26.0
>> 95.0th:                260.5             28.0
>> 99.0th:               3644.0             35.0
>> 99.5th:               5152.0             44.5
>> 99.9th:               8076.0            168.5
>> Groups: 8
>> 50.0th:                 26.0             25.5
>> 75.0th:                 32.5             31.5
>> 90.0th:                 41.5             36.5
>> 95.0th:                794.0             39.5
>> 99.0th:               5992.0             66.0
>> 99.5th:               7208.0            159.0
>> 99.9th:               9392.0           1604.0
>> Groups: 16
>> 50.0th:                 37.5             34.0
>> 75.0th:                 49.5             44.5
>> 90.0th:                 70.0             53.5
>> 95.0th:               1284.0             58.5
>> 99.0th:               5600.0            102.5
>> 99.5th:               7216.0            368.5
>> 99.9th:               9328.0           5192.0
>> Groups: 32
>> 50.0th:                 59.0             54.5
>> 75.0th:                 83.0             74.5
>> 90.0th:                118.5             91.0
>> 95.0th:               1921.0            100.5
>> 99.0th:               6672.0            317.0
>> 99.5th:               8252.0           2264.0
>> 99.9th:              10448.0           8388.0
>>
>>
>> ===========
>> hackbench
>> ==========
>>
>> type                 Groups      6.2      | 6.2 + V12 + LN=0
>> Process               10         0.19     |  0.19
>> Process               20         0.34     |  0.34
>> Process               30         0.45     |  0.44
>> Process               40         0.58     |  0.57
>> Process               50         0.70     |  0.69
>> Process               60         0.82     |  0.80
>> thread                10         0.20     |  0.20
>> thread                20         0.36     |  0.36
>> Process(Pipe)         10         0.24     |  0.21
>> Process(Pipe)         20         0.46     |  0.40
>> Process(Pipe)         30         0.65     |  0.58
>> Process(Pipe)         40         0.90     |  0.68
>> Process(Pipe)         50         1.04     |  0.83
>> Process(Pipe)         60         1.16     |  0.86
>> thread(Pipe)          10         0.19     |  0.18
>> thread(Pipe)          20         0.46     |  0.37
>>
>>
> [...]
>
>>>>>>
>>>>>> Do you want me to try any other experiment on this further?
>>>>> Yes, would be good to know which of the 3 changes in the patch create
>>>>> the regression
>>>>>
>>>>> I suspect the 1st change to be the root cause of your problem but It
>>>>> would be good if you can confirm my assumption with some tests
>>>>>
>>>>> Thanks
>>>> Applied each change individually. 3rd change seems to cause the regression.
>>>> Kept only the 3rd change and numbers are same as stable 6.2 for latency nice
>>>> value of 0.
>>> Ok, it's the patch 1 that aims to prevent some unfairness with low weight
>>> waking task. And your platform probably falls in the last part of the commit:
>>>
>>> " Strictly speaking, we should use cfs->min_vruntime instead of
>>> curr->vruntime but it doesn't worth the additional overhead and complexity
>>> as the vruntime of current should be close to min_vruntime if not equal."
>>>
>>> Could you try the patch below on top of v12 ?
>>>
>>> ---
>>>  kernel/sched/fair.c | 21 +++++++++++----------
>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e2aeb4511686..77b03a280912 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5049,7 +5049,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>  }
>>>
>>>  static int
>>> -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
>>> +wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se, struct cfs_rq *cfs_rq);
>>>
>>>  /*
>>>   * Pick the next process, keeping these things in mind, in this order:
>>> @@ -5088,16 +5088,16 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>  				second = curr;
>>>  		}
>>>
>>> -		if (second && wakeup_preempt_entity(second, left) < 1)
>>> +		if (second && wakeup_preempt_entity(second, left, cfs_rq) < 1)
>>>  			se = second;
>>>  	}
>>>
>>> -	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
>>> +	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left, cfs_rq) < 1) {
>>>  		/*
>>>  		 * Someone really wants this to run. If it's not unfair, run it.
>>>  		 */
>>>  		se = cfs_rq->next;
>>> -	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
>>> +	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left, cfs_rq) < 1) {
>>>  		/*
>>>  		 * Prefer last buddy, try to return the CPU to a preempted task.
>>>  		 */
>>> @@ -5107,7 +5107,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>  	/* Check for latency sensitive entity waiting for running */
>>>  	latency = __pick_first_latency(cfs_rq);
>>>  	if (latency && (latency != se) &&
>>> -	    wakeup_preempt_entity(latency, se) < 1)
>>> +	    wakeup_preempt_entity(latency, se, cfs_rq) < 1)
>>>  		se = latency;
>>>
>>>  	return se;
>>> @@ -7808,7 +7808,7 @@ static unsigned long wakeup_gran(struct sched_entity *se)
>>>   *
>>>   */
>>>  static int
>>> -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>>> +wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se, struct cfs_rq *cfs_rq)
>>>  {
>>>  	s64 gran, vdiff = curr->vruntime - se->vruntime;
>>>  	s64 offset = wakeup_latency_gran(curr, se);
>>> @@ -7818,6 +7818,8 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>>>
>>>  	gran = offset + wakeup_gran(se);
>>>
>>> +	if (vdiff > gran)
>>> +		return 1;
>>>  	/*
>>>  	 * At wake up, the vruntime of a task is capped to not be older than
>>>  	 * a sched_latency period compared to min_vruntime. This prevents long
>>> @@ -7827,9 +7829,8 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>>>  	 * for low priority task. Make sure that long sleeping task will get a
>>>  	 * chance to preempt current.
>>>  	 */
>>> -	gran = min_t(s64, gran, get_latency_max());
>>> -
>>> -	if (vdiff > gran)
>>> +	vdiff = cfs_rq->min_vruntime - se->vruntime;
>>> +	if (vdiff > get_latency_max())
>>>  		return 1;
>>>
>>>  	return 0;
>>> @@ -7933,7 +7934,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>>>  		return;
>>>
>>>  	update_curr(cfs_rq_of(se));
>>> -	if (wakeup_preempt_entity(se, pse) == 1) {
>>> +	if (wakeup_preempt_entity(se, pse, cfs_rq_of(se)) == 1) {
>>>  		/*
>>>  		 * Bias pick_next to pick the sched entity that is
>>>  		 * triggering this preemption.
>>> --
>>> 2.34.1
>> Tried above patch on top of V12. Numbers are worse than V12. We maybe running into
>> a corner case on this system.
> Yes it can be a corner case.
>
> Nevertheless, the patch above has a problem and does an unsigned comparison instead of a signed
> one. I have forced the signed comparison in the patch below to be applied on top  of
> previous one:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b03a280912..22a497f92dbb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7830,7 +7830,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se, struct
>          * chance to preempt current.
>          */
>         vdiff = cfs_rq->min_vruntime - se->vruntime;
> -       if (vdiff > get_latency_max())
> +       if (vdiff > (s64)get_latency_max())
>                 return 1;
>
>         return 0;

Tested the above patch on top of previous patch + V12. 
Numbers are still worse than V12. Same as V12+previous patch.


>
>
>> Type                Groups       6.2     | 6.2+V12                                 
>>                                                                                    
>>  Process              10        0.33     |  0.44                                   
>>  Process              20        0.61     |  0.90                                   
>>  Process              30        0.87     |  1.29                                   
>>  Process              40        1.10     |  1.69                                   
>>  Process              50        1.34     |  2.08                                   
>>  Process              60        1.58     |  2.39                                   
>>  thread               10        0.36     |  0.53                                   
>>  thread               20        0.64     |  0.94                                   
>>  Process(Pipe)        10        0.18     |  0.46                                   
>>  Process(Pipe)        20        0.32     |  0.75                                   
>>  Process(Pipe)        30        0.42     |  1.01                                   
>>  Process(Pipe)        40        0.56     |  1.15                                   
>>  Process(Pipe)        50        0.68     |  1.38                                   
>>  Process(Pipe)        60        0.80     |  1.56  
>>  
>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index cdcd991bbcf1..c89c201dd164 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7827,7 +7827,6 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>>>>          * for low priority task. Make sure that long sleeping task will get a
>>>>          * chance to preempt current.
>>>>          */
>>>> -       gran = min_t(s64, gran, get_latency_max());
>>>>
>>>>         if (vdiff > gran)
>>>>                 return 1;
>>>>
>>>>
>>>>
> [...]
>
>>

