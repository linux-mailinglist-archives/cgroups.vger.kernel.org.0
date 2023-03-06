Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065926ABE46
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 12:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCFLfn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 06:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCFLfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 06:35:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF4274B1;
        Mon,  6 Mar 2023 03:35:00 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3269uEEV005416;
        Mon, 6 Mar 2023 11:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=leFaT3cb8bThGwjLRkIEXHI/Vi4K6qUs4y39dx0vdsg=;
 b=sLZuYzTqzlw55UvVG86XlbBLL0VSiI3sh8HpAC+uD7dg9vsONyNfa1QYpOSk5NcZgFfC
 kSOppwe+GszKswjLfiXbUUgmsUQua+UrcyK/WW77kRy6m3XoQaY8SSZaq8UhOgGK/LEP
 DX9Utf/zgln9BdY7shGfRvwq9cn4YHjdq/oTzNexSNAwOfUFNC5mIg4iGrDVEhNO4Zn8
 gWFsjfkn6qleepfyktEJgcV5eLkk0QN+HeW3dCI3lMcrt0FMqcvI0ayV56uLI/yuzmxh
 ymvnuZA4f8osPTjrNAzjO4QHY0WlEY3Gdff1kIsfrC2714VHdIBkopiZAHFiYH8HGgaY XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n41998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:33:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326BJUH8005890;
        Mon, 6 Mar 2023 11:33:45 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n4198h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:33:45 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3269Qvil005002;
        Mon, 6 Mar 2023 11:33:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3p41844vd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:33:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326BXhOO39256766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 11:33:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC2575805A;
        Mon,  6 Mar 2023 11:33:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 207365805F;
        Mon,  6 Mar 2023 11:33:32 +0000 (GMT)
Received: from [9.43.116.51] (unknown [9.43.116.51])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 11:33:31 +0000 (GMT)
Message-ID: <0f19b215-5841-bea4-20a5-beda39d8dad7@linux.vnet.ibm.com>
Date:   Mon, 6 Mar 2023 17:03:30 +0530
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
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-9-vincent.guittot@linaro.org>
 <4982b608-f8c7-531c-3322-c055643a5b2d@linux.vnet.ibm.com>
 <CAKfTPtAEbzrxKOGXYRxp0qMM-TPj1q8BdcaVpK7ObZfe8QWn4g@mail.gmail.com>
 <913b0491-cef6-87ac-bf7e-d6d6c8fc380a@linux.vnet.ibm.com>
 <CAKfTPtA5wqBb1hAQa=qd6CicJbHsRi+q=s2tT0n6XspGOEA2Xg@mail.gmail.com>
 <7dd8fa7e-3cbc-6d3f-5748-74ffdeb056a7@linux.vnet.ibm.com>
 <2226e488-390d-ed64-832e-ca8e6a3a1731@linux.vnet.ibm.com>
 <ZAIg5de3EkHtHqLM@vingu-book>
 <48b8f849-fa81-d968-8fb6-b25c5fe94edb@linux.vnet.ibm.com>
 <CAKfTPtA9=03eeXemrVDFHCviqS4NOBLedkbcG_FwGd2SfAd+wQ@mail.gmail.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <CAKfTPtA9=03eeXemrVDFHCviqS4NOBLedkbcG_FwGd2SfAd+wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1hP54QIj_Q4OA57HzafhJ5QfREwjLm3x
X-Proofpoint-GUID: ZOHmm2Ts0jd0xWpiVqgoSW6zSlJjw3O3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/5/23 6:33 PM, Vincent Guittot wrote:
> On Sat, 4 Mar 2023 at 16:13, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>>
>>
>> On 3/3/23 10:01 PM, Vincent Guittot wrote:
>>> Le jeudi 02 mars 2023 à 23:37:52 (+0530), Shrikanth Hegde a écrit :
>>>> On 3/2/23 8:30 PM, Shrikanth Hegde wrote:
>>>>> On 3/2/23 6:47 PM, Vincent Guittot wrote:
>>>>>> On Thu, 2 Mar 2023 at 12:00, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>>>>>>> On 3/2/23 1:20 PM, Vincent Guittot wrote:
>>>>>>>> On Wed, 1 Mar 2023 at 19:48, shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:
>>>>>>>>> On 2/24/23 3:04 PM, Vincent Guittot wrote:
>>> [...]
>>>
>>>>>>>>> Ran the schbench and hackbench with this patch series. Here comparison is
>>>>>>>>> between 6.2 stable tree, 6.2 + Patch and 6.2 + patch + above re-arrange of
>>>>>>>>> latency_node. Ran two cgroups, in one cgroup running stress-ng at 50%(group1)
>>>>>>>>> and other is running these benchmarks (group2). Set the latency nice
>>>>>>>>> of group2 to -20. These are run on Power system with 12 cores with SMT=8.
>>>>>>>>> Total of 96 CPU.
>>>>>>>>>
>>>>>>>>> schbench gets lower latency compared to stabletree. Whereas hackbench seems
>>>>>>>>> to regress under this case. Maybe i am doing something wrong. I will re-run
>>>>>>>>> and attach the numbers to series.
>>>>>>>>> Please suggest if any variation in the test i need to try.
>>>>>>>> hackbench takes advanatge of a latency nice 19 as it mainly wants to
>>>>>>>> run longer slice to move forward rather than preempting others all the
>>>>>>>> time
>>>>>>> hackbench still seems to regress in different latency nice values compared to
>>>>>>> baseline of 6.2 in this case. up to 50% in some cases.
>>>>>>>
>>>>>>> 12 core powerpc system  with SMT=8 i.e 96 CPU
>>>>>>> running 2 CPU cgroups. No quota assigned.
>>>>>>> 1st cgroup is running stress-ng with 48 threads. Consuming 50% of CPU.
>>>>>>> latency is not changed for this cgroup.
>>>>>>> 2nd cgroup is running hackbench. This cgroup is assigned the different latency
>>>>>>> nice values of 0, -20 and 19.
>>>>>> According to your other emails, you are using the cgroup interface and
>>>>>> not the task's one. Do I get it right ?
>>>>> right. I create cgroup, attach bash command with echo $$,
>>>>> assign the latency nice to cgroup, and run hackbench from that bash prompt.
>>>>>
>>>>>> I haven't run test such tests in a cgroup but at least the test with
>>>>>> latency_nice == 0 should not make any noticeable difference. Does this
>>>>>> include the re-arrange patch that you have proposed previously ?
>>>>> No. This is only with V12 of the series.
>>>>>
>>>>>> Also, the tests that you did on v6, gave better result.
>>>>>> https://lore.kernel.org/lkml/34112324-de67-55eb-92bc-181a98c4311c@linux.vnet.ibm.com/
>>>>>>
>>>>>> Are you running same tests or you changed something in the mean time ?
>>>>> Test machine got changed.
>>>>> now i re-read my earlier mail. I see it was slightly different.
>>>>> I had created only one cgroup and stress-ng was run
>>>>> without any cgroup. Let me try that scenario and get the numbers.
>>>> Tried the same method of testing i had done on V7 of the series. on this
>>>> machine hackbench still regress's both on V12 as well as V7 of the series.
>>>>
>>>> Created one cpu cgroup called cgroup1. created two bash prompts.
>>>> assigned "bash $$" to cgroup1 and on other bash prompt running,
>>>> stress-ng --cpu=96 -l 50. Ran hackbench from cgroup1 prompt.
>>>> assigned latency values to the cgroup1.
>>> I have tried to reproduce your results on some of my systems but I can't see
>>> the impacts that you are reporting below.
>>> The fact that your other platform was not impacted as well could imply that
>>> it's specific to this platform.
>>> In particular, the lat nice=0 case should not show any real impact as it
>>> should be similar to a nop. At least that what I can see in the tests on my
>>> platforms and Prateek on his.
>>>
>>> Nevertheless, could you try to run your tests with the changes below ?
>>> These are the only places which could have an impact even with lat nice = 0
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 8137bca80572..979571a98b28 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4991,8 +4991,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>         if (delta < offset)
>>>                 return;
>>>
>>> -       if ((delta > ideal_runtime) ||
>>> -           (delta > get_latency_max()))
>>> +       if (delta > ideal_runtime)
>>>                 resched_curr(rq_of(cfs_rq));
>>>  }
>>>
>>> @@ -7574,9 +7573,10 @@ static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *
>>>          * Otherwise, use the latency weight to evaluate how much scheduling
>>>          * delay is acceptable by se.
>>>          */
>>> -       if ((latency_offset < 0) || (curr->latency_offset < 0))
>>> +       if ((latency_offset < 0) || (curr->latency_offset < 0)) {
>>>                 latency_offset -= curr->latency_offset;
>>> -       latency_offset = min_t(long, latency_offset, get_latency_max());
>>> +               latency_offset = min_t(long, latency_offset, get_latency_max());
>>> +       }
>>>
>>>         return latency_offset;
>>>  }
>>> @@ -7635,7 +7635,6 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>>>          * for low priority task. Make sure that long sleeping task will get a
>>>          * chance to preempt current.
>>>          */
>>> -       gran = min_t(s64, gran, get_latency_max());
>>>
>>>         if (vdiff > gran)
>>>                 return 1;
>>>
>> Above patch helps. thank you.
> Great. At least we have narrow the problem to one f the 3 changes.
>
>> Numbers are comparable to 6.2 and there is slight improvement. Much better than V12 numbers.
>>
>> type       groups |   v6.2      |v6.2 + V12| v6.2 + V12  | v6.2 + V12
>>                   |             |lat nice=0| lat nice=-20| lat nice=+19
>>
>> Process       10  |     0.33    |   0.37   |   0.38     |   0.37
>> Process       20  |     0.61    |   0.67   |   0.68     |   0.67
>> Process       30  |     0.85    |   0.95   |   0.95     |   0.96
>> Process       40  |     1.10    |   1.20   |   1.20     |   1.21
>> Process       50  |     1.34    |   1.47   |   1.44     |   1.45
>> Process       60  |     1.57    |   1.70   |   1.71     |   1.70
>> thread        10  |     0.36    |   0.40   |   0.39     |   0.39
>> thread        20  |     0.65    |   0.72   |   0.71     |   0.71
>> Process(Pipe) 10  |     0.18    |   0.31   |   0.31     |   0.33
>> Process(Pipe) 20  |     0.32    |   0.51   |   0.50     |   0.50
>> Process(Pipe) 30  |     0.43    |   0.65   |   0.67     |   0.67
>> Process(Pipe) 40  |     0.57    |   0.82   |   0.83     |   0.83
>> Process(Pipe) 50  |     0.67    |   1.00   |   0.97     |   0.98
>> Process(Pipe) 60  |     0.81    |   1.13   |   1.11     |   1.12
>> thread(Pipe)  10  |     0.19    |   0.33   |   0.33     |   0.33
>> thread(Pipe)  20  |     0.34    |   0.53   |   0.51     |   0.52
>>
>>
>>
>> type       groups |   v6.2      |v6.2+ V12+ | v6.2 + V12+| v6.2 + V12
>>                   |             |above patch|above patch | above patch
>>                   |             |lat nice=0 |lat nice=-20| lat nice=+19
>>
>> Process       10  |     0.36    |   0.33    |   0.34     |   0.34
>> Process       20  |     0.62    |   0.60    |   0.61     |   0.61
>> Process       30  |     0.87    |   0.84    |   0.85     |   0.84
>> Process       40  |     1.13    |   1.09    |   1.10     |   1.09
>> Process       50  |     1.38    |   1.33    |   1.33     |   1.34
>> Process       60  |     1.64    |   1.56    |   1.58     |   1.56
>> thread        10  |     0.35    |   0.35    |   0.35     |   0.35
>> thread        20  |     0.64    |   0.63    |   0.63     |   0.63
>> Process(Pipe) 10  |     0.20    |   0.18    |   0.18     |   0.18
>> Process(Pipe) 20  |     0.32    |   0.31    |   0.31     |   0.32
>> Process(Pipe) 30  |     0.44    |   0.43    |   0.43     |   0.43
>> Process(Pipe) 40  |     0.56    |   0.57    |   0.56     |   0.55
>> Process(Pipe) 50  |     0.70    |   0.67    |   0.67     |   0.67
>> Process(Pipe) 60  |     0.83    |   0.79    |   0.81     |   0.80
>> thread(Pipe)  10  |     0.21    |   0.19    |   0.19     |   0.19
>> thread(Pipe)  20  |     0.35    |   0.33    |   0.34     |   0.33
>>
>>
>> Do you want me to try any other experiment on this further?
> Yes, would be good to know which of the 3 changes in the patch create
> the regression
>
> I suspect the 1st change to be the root cause of your problem but It
> would be good if you can confirm my assumption with some tests
>
> Thanks

Applied each change individually. 3rd change seems to cause the regression.
Kept only the 3rd change and numbers are same as stable 6.2 for latency nice
value of 0.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cdcd991bbcf1..c89c201dd164 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7827,7 +7827,6 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
         * for low priority task. Make sure that long sleeping task will get a
         * chance to preempt current.
         */
-       gran = min_t(s64, gran, get_latency_max());

        if (vdiff > gran)
                return 1;



>>>> I will try to run with only task's set with latency_nice=0 as well.
>>>>
>>>> type    groups |   v6.2      |v6.2 + V12| v6.2 + V12  | v6.2 + V12
>>>>                |             |lat nice=0| lat nice=-20| lat nice=+19
>>>>
>>>> Process            10  |     0.33    |   0.37   |   0.38     |   0.37
>>>> Process       20  |  0.61    |   0.67   |   0.68     |   0.67
>>>> Process            30  |     0.85    |   0.95   |   0.95     |   0.96
>>>> Process            40  |     1.10    |   1.20   |   1.20     |   1.21
>>>> Process            50  |     1.34    |   1.47   |   1.44     |   1.45
>>>> Process            60  |     1.57    |   1.70   |   1.71     |   1.70
>>>> thread             10  |     0.36    |   0.40   |   0.39     |   0.39
>>>> thread             20  |     0.65    |   0.72   |   0.71     |   0.71
>>>> Process(Pipe) 10  |  0.18    |   0.31   |   0.31     |   0.33
>>>> Process(Pipe) 20  |  0.32    |   0.51   |   0.50     |   0.50
>>>> Process(Pipe) 30  |  0.43    |   0.65   |   0.67     |   0.67
>>>> Process(Pipe) 40  |  0.57    |   0.82   |   0.83     |   0.83
>>>> Process(Pipe) 50  |  0.67    |   1.00   |   0.97     |   0.98
>>>> Process(Pipe) 60  |  0.81    |   1.13   |   1.11     |   1.12
>>>> thread(Pipe)  10  |  0.19    |   0.33   |   0.33     |   0.33
>>>> thread(Pipe)  20  |  0.34    |   0.53   |   0.51     |   0.52
>>>>
>>>>
>>>>
>>>> type    groups |   v6.2      |v6.2 + V7 | v6.2 + V7  | v6.2 + V7
>>>>                |             |lat nice=0|lat nice=-20| lat nice=+19
>>>> Process            10  |     0.33    |   0.37   |   0.37     |   0.37
>>>> Process            20  |     0.61    |   0.67   |   0.67     |   0.67
>>>> Process            30  |     0.85    |   0.96   |   0.94     |   0.95
>>>> Process            40  |     1.10    |   1.20   |   1.20     |   1.20
>>>> Process            50  |     1.34    |   1.45   |   1.46     |   1.45
>>>> Process            60  |     1.57    |   1.71   |   1.68     |   1.72
>>>> thread             10  |     0.36    |   0.40   |   0.40     |   0.40
>>>> thread             20  |     0.65    |   0.71   |   0.71     |   0.71
>>>> Process(Pipe) 10  |  0.18    |   0.30   |   0.30     |   0.31
>>>> Process(Pipe) 20  |  0.32    |   0.50   |   0.50     |   0.50
>>>> Process(Pipe) 30  |  0.43    |   0.67   |   0.67     |   0.66
>>>> Process(Pipe) 40  |  0.57    |   0.86   |   0.84     |   0.84
>>>> Process(Pipe) 50  |  0.67    |   0.99   |   0.97     |   0.97
>>>> Process(Pipe) 60  |  0.81    |   1.10   |   1.13     |   1.13
>>>> thread(Pipe)  10  |  0.19    |   0.34   |   0.34     |   0.33
>>>> thread(Pipe)  20  |  0.34    |   0.55   |   0.53     |   0.54
>>>>
>>>>>>> Numbers are average of 10 runs in each case. Time is in seconds
>>>>>>>
>>>>>>> type       groups |   v6.2     |  v6.2 + V12   | v6.2 + V12  | v6.2 + V12
>>>>>>>                   |            | lat nice=0    | lat nice=-20| lat nice=+19
>>>>>>>                   |            |               |             |
>>>>>>> Process       10  |   0.36     |     0.41      |    0.43     |    0.42
>>>>>>> Process       20  |   0.62     |     0.76      |    0.75     |    0.75
>>>>>>> Process       30  |   0.87     |     1.05      |    1.04     |    1.06
>>>>>>> Process       40  |   1.13     |     1.34      |    1.33     |    1.33
>>>>>>> Process       50  |   1.38     |     1.62      |    1.66     |    1.63
>>>>>>> Process       60  |   1.64     |     1.91      |    1.97     |    1.90
>>>>>>> thread        10  |   0.35     |     0.41      |    0.44     |    0.42
>>>>>>> thread        20  |   0.64     |     0.78      |    0.77     |    0.79
>>>>>>> Process(Pipe) 10  |   0.20     |     0.34      |    0.33     |    0.34
>>>>>>> Process(Pipe) 20  |   0.32     |     0.52      |    0.53     |    0.52
>>>>>>> Process(Pipe) 30  |   0.44     |     0.70      |    0.70     |    0.69
>>>>>>> Process(Pipe) 40  |   0.56     |     0.88      |    0.89     |    0.88
>>>>>>> Process(Pipe) 50  |   0.70     |     1.08      |    1.08     |    1.07
>>>>>>> Process(Pipe) 60  |   0.83     |     1.27      |    1.27     |    1.26
>>>>>>> thread(Pipe)  10  |   0.21     |     0.35      |    0.34     |    0.36
>>>>>>> thread(Pipe)  10  |   0.35     |     0.55      |    0.58     |    0.55
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>> Re-arrange seems to help the patch series by avoiding an cacheline miss.
>>>>>>>>>
>>>>>>>>> =========================
>>>>>>>>> schbench
>>>>>>>>> =========================
>>>>>>>>>                  6.2   |  6.2 + V12     |     6.2 + V12 + re-arrange
>>>>>>>>> 1 Thread
>>>>>>>>>   50.0th:        9.00  |    9.00        |        9.50
>>>>>>>>>   75.0th:       10.50  |   10.00        |        9.50
>>>>>>>>>   90.0th:       11.00  |   11.00        |       10.50
>>>>>>>>>   95.0th:       11.00  |   11.00        |       11.00
>>>>>>>>>   99.0th:       11.50  |   11.50        |       11.50
>>>>>>>>>   99.5th:       12.50  |   12.00        |       12.00
>>>>>>>>>   99.9th:       14.50  |   13.50        |       12.00
>>>>>>>>> 2 Threads
>>>>>>>>>   50.0th:        9.50  |    9.50        |        8.50
>>>>>>>>>   75.0th:       11.00  |   10.50        |        9.50
>>>>>>>>>   90.0th:       13.50  |   11.50        |       10.50
>>>>>>>>>   95.0th:       14.00  |   12.00        |       11.00
>>>>>>>>>   99.0th:       15.50  |   13.50        |       12.00
>>>>>>>>>   99.5th:       16.00  |   14.00        |       12.00
>>>>>>>>>   99.9th:       17.00  |   16.00        |       16.50
>>>>>>>>> 4 Threads
>>>>>>>>>   50.0th:       11.50  |   11.50        |       10.50
>>>>>>>>>   75.0th:       13.50  |   12.50        |       12.50
>>>>>>>>>   90.0th:       15.50  |   14.50        |       14.00
>>>>>>>>>   95.0th:       16.50  |   15.50        |       14.50
>>>>>>>>>   99.0th:       20.00  |   17.50        |       16.50
>>>>>>>>>   99.5th:       20.50  |   18.50        |       17.00
>>>>>>>>>   99.9th:       22.50  |   21.00        |       19.00
>>>>>>>>> 8 Threads
>>>>>>>>>   50.0th:       14.00  |   14.00        |       14.00
>>>>>>>>>   75.0th:       16.00  |   16.00        |       16.00
>>>>>>>>>   90.0th:       18.00  |   18.00        |       17.50
>>>>>>>>>   95.0th:       18.50  |   18.50        |       18.50
>>>>>>>>>   99.0th:       20.00  |   20.00        |       20.00
>>>>>>>>>   99.5th:       20.50  |   21.50        |       21.00
>>>>>>>>>   99.9th:       22.50  |   23.50        |       23.00
>>>>>>>>> 16 Threads
>>>>>>>>>   50.0th:       19.00  |   18.50        |       19.00
>>>>>>>>>   75.0th:       23.00  |   22.50        |       23.00
>>>>>>>>>   90.0th:       25.00  |   25.50        |       25.00
>>>>>>>>>   95.0th:       26.50  |   26.50        |       26.00
>>>>>>>>>   99.0th:       28.50  |   29.00        |       28.50
>>>>>>>>>   99.5th:       31.00  |   30.00        |       30.00
>>>>>>>>>   99.9th:     5626.00  | 4761.50        |       32.50
>>>>>>>>> 32 Threads
>>>>>>>>>   50.0th:       27.00  |   27.50        |       29.00
>>>>>>>>>   75.0th:       35.50  |   36.50        |       38.50
>>>>>>>>>   90.0th:       42.00  |   44.00        |       50.50
>>>>>>>>>   95.0th:      447.50  | 2959.00        |     8544.00
>>>>>>>>>   99.0th:     7372.00  | 17032.00       |    19136.00
>>>>>>>>>   99.5th:    15360.00  | 19808.00       |    20704.00
>>>>>>>>>   99.9th:    20640.00  | 30048.00       |    30048.00
>>>>>>>>>
>>>>>>>>> ====================
>>>>>>>>> hackbench
>>>>>>>>> ====================
>>>>>>>>>                         6.2     |  6.2 + V12        |     6.2+ V12 +re-arrange
>>>>>>>>>
>>>>>>>>> Process 10 Time:        0.35    |       0.42        |           0.41
>>>>>>>>> Process 20 Time:        0.61    |       0.76        |           0.76
>>>>>>>>> Process 30 Time:        0.87    |       1.06        |           1.05
>>>>>>>>> thread 10 Time:         0.35    |       0.43        |           0.42
>>>>>>>>> thread 20 Time:         0.66    |       0.79        |           0.78
>>>>>>>>> Process(Pipe) 10 Time:  0.21    |       0.33        |           0.32
>>>>>>>>> Process(Pipe) 20 Time:  0.34    |       0.52        |           0.52
>>>>>>>>> Process(Pipe) 30 Time:  0.46    |       0.72        |           0.71
>>>>>>>>> thread(Pipe) 10 Time:   0.21    |       0.34        |           0.34
>>>>>>>>> thread(Pipe) 20 Time:   0.36    |       0.56        |           0.56
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>       struct list_head                group_node;
>>>>>>>>>>       unsigned int                    on_rq;
>>>>>>>>>>
>>>>>>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>>>>>>> index 093cc1af73dc..752fd364216c 100644
>>>>>>>>>> --- a/kernel/sched/core.c
>>>>>>>>>> +++ b/kernel/sched/core.c
>>>>>>>>>> @@ -4434,6 +4434,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>>>>>>>>>       p->se.nr_migrations             = 0;
>>>>>>>>>>       p->se.vruntime                  = 0;
>>>>>>>>>>       INIT_LIST_HEAD(&p->se.group_node);
>>>>>>>>>> +     RB_CLEAR_NODE(&p->se.latency_node);
>>>>>>>>>>
>>>>>>>>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>>>>>>>>>       p->se.cfs_rq                    = NULL;
>>>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>>>>>> index 125a6ff53378..e2aeb4511686 100644
>>>>>>>>>> --- a/kernel/sched/fair.c
>>>>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>>>>> @@ -680,7 +680,85 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>>>>>>>>>>
>>>>>>>>>>       return __node_2_se(last);
>>>>>>>>>>  }
>>>>>>>>>> +#endif
>>>>>>>>>>
>>>>>>>>>> +/**************************************************************
>>>>>>>>>> + * Scheduling class tree data structure manipulation methods:
>>>>>>>>>> + * for latency
>>>>>>>>>> + */
>>>>>>>>>> +
>>>>>>>>>> +static inline bool latency_before(struct sched_entity *a,
>>>>>>>>>> +                             struct sched_entity *b)
>>>>>>>>>> +{
>>>>>>>>>> +     return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +#define __latency_node_2_se(node) \
>>>>>>>>>> +     rb_entry((node), struct sched_entity, latency_node)
>>>>>>>>>> +
>>>>>>>>>> +static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
>>>>>>>>>> +{
>>>>>>>>>> +     return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +/*
>>>>>>>>>> + * Enqueue an entity into the latency rb-tree:
>>>>>>>>>> + */
>>>>>>>>>> +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>>>>>>>> +{
>>>>>>>>>> +
>>>>>>>>>> +     /* Only latency sensitive entity can be added to the list */
>>>>>>>>>> +     if (se->latency_offset >= 0)
>>>>>>>>>> +             return;
>>>>>>>>>> +
>>>>>>>>>> +     if (!RB_EMPTY_NODE(&se->latency_node))
>>>>>>>>>> +             return;
>>>>>>>>>> +
>>>>>>>>>> +     /*
>>>>>>>>>> +      * The entity is always added the latency list at wakeup.
>>>>>>>>>> +      * Then, a not waking up entity that is put back in the list after an
>>>>>>>>>> +      * execution time less than sysctl_sched_min_granularity, means that
>>>>>>>>>> +      * the entity has been preempted by a higher sched class or an entity
>>>>>>>>>> +      * with higher latency constraint. In thi case, the entity is also put
>>>>>>>>>> +      * back in the latency list so it gets a chance to run 1st during the
>>>>>>>>>> +      * next slice.
>>>>>>>>>> +      */
>>>>>>>>>> +     if (!(flags & ENQUEUE_WAKEUP)) {
>>>>>>>>>> +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
>>>>>>>>>> +
>>>>>>>>>> +             if (delta_exec >= sysctl_sched_min_granularity)
>>>>>>>>>> +                     return;
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +/*
>>>>>>>>>> + * Dequeue an entity from the latency rb-tree and return true if it was really
>>>>>>>>>> + * part of the rb-tree:
>>>>>>>>>> + */
>>>>>>>>>> +static bool __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>>>>>>> +{
>>>>>>>>>> +     if (!RB_EMPTY_NODE(&se->latency_node)) {
>>>>>>>>>> +             rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
>>>>>>>>>> +             RB_CLEAR_NODE(&se->latency_node);
>>>>>>>>>> +             return true;
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     return false;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
>>>>>>>>>> +{
>>>>>>>>>> +     struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
>>>>>>>>>> +
>>>>>>>>>> +     if (!left)
>>>>>>>>>> +             return NULL;
>>>>>>>>>> +
>>>>>>>>>> +     return __latency_node_2_se(left);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_SCHED_DEBUG
>>>>>>>>>>  /**************************************************************
>>>>>>>>>>   * Scheduling class statistics methods:
>>>>>>>>>>   */
>>>>>>>>>> @@ -4758,8 +4836,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>>>>>>>>       check_schedstat_required();
>>>>>>>>>>       update_stats_enqueue_fair(cfs_rq, se, flags);
>>>>>>>>>>       check_spread(cfs_rq, se);
>>>>>>>>>> -     if (!curr)
>>>>>>>>>> +     if (!curr) {
>>>>>>>>>>               __enqueue_entity(cfs_rq, se);
>>>>>>>>>> +             __enqueue_latency(cfs_rq, se, flags);
>>>>>>>>>> +     }
>>>>>>>>>>       se->on_rq = 1;
>>>>>>>>>>
>>>>>>>>>>       if (cfs_rq->nr_running == 1) {
>>>>>>>>>> @@ -4845,8 +4925,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>>>>>>>>
>>>>>>>>>>       clear_buddies(cfs_rq, se);
>>>>>>>>>>
>>>>>>>>>> -     if (se != cfs_rq->curr)
>>>>>>>>>> +     if (se != cfs_rq->curr) {
>>>>>>>>>>               __dequeue_entity(cfs_rq, se);
>>>>>>>>>> +             __dequeue_latency(cfs_rq, se);
>>>>>>>>>> +     }
>>>>>>>>>>       se->on_rq = 0;
>>>>>>>>>>       account_entity_dequeue(cfs_rq, se);
>>>>>>>>>>
>>>>>>>>>> @@ -4941,6 +5023,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>>>>>>>                */
>>>>>>>>>>               update_stats_wait_end_fair(cfs_rq, se);
>>>>>>>>>>               __dequeue_entity(cfs_rq, se);
>>>>>>>>>> +             __dequeue_latency(cfs_rq, se);
>>>>>>>>>>               update_load_avg(cfs_rq, se, UPDATE_TG);
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> @@ -4979,7 +5062,7 @@ static struct sched_entity *
>>>>>>>>>>  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>>>>>>>>  {
>>>>>>>>>>       struct sched_entity *left = __pick_first_entity(cfs_rq);
>>>>>>>>>> -     struct sched_entity *se;
>>>>>>>>>> +     struct sched_entity *latency, *se;
>>>>>>>>>>
>>>>>>>>>>       /*
>>>>>>>>>>        * If curr is set we have to see if its left of the leftmost entity
>>>>>>>>>> @@ -5021,6 +5104,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>>>>>>>>               se = cfs_rq->last;
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> +     /* Check for latency sensitive entity waiting for running */
>>>>>>>>>> +     latency = __pick_first_latency(cfs_rq);
>>>>>>>>>> +     if (latency && (latency != se) &&
>>>>>>>>>> +         wakeup_preempt_entity(latency, se) < 1)
>>>>>>>>>> +             se = latency;
>>>>>>>>>> +
>>>>>>>>>>       return se;
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> @@ -5044,6 +5133,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
>>>>>>>>>>               update_stats_wait_start_fair(cfs_rq, prev);
>>>>>>>>>>               /* Put 'current' back into the tree. */
>>>>>>>>>>               __enqueue_entity(cfs_rq, prev);
>>>>>>>>>> +             __enqueue_latency(cfs_rq, prev, 0);
>>>>>>>>>>               /* in !on_rq case, update occurred at dequeue */
>>>>>>>>>>               update_load_avg(cfs_rq, prev, 0);
>>>>>>>>>>       }
>>>>>>>>>> @@ -12222,6 +12312,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>>>>>>>>>>  void init_cfs_rq(struct cfs_rq *cfs_rq)
>>>>>>>>>>  {
>>>>>>>>>>       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
>>>>>>>>>> +     cfs_rq->latency_timeline = RB_ROOT_CACHED;
>>>>>>>>>>       u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
>>>>>>>>>>  #ifdef CONFIG_SMP
>>>>>>>>>>       raw_spin_lock_init(&cfs_rq->removed.lock);
>>>>>>>>>> @@ -12378,6 +12469,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>>>>>>>>>>       se->my_q = cfs_rq;
>>>>>>>>>>
>>>>>>>>>>       se->latency_offset = calc_latency_offset(tg->latency_prio);
>>>>>>>>>> +     RB_CLEAR_NODE(&se->latency_node);
>>>>>>>>>>
>>>>>>>>>>       /* guarantee group entities always have weight */
>>>>>>>>>>       update_load_set(&se->load, NICE_0_LOAD);
>>>>>>>>>> @@ -12529,8 +12621,19 @@ int sched_group_set_latency(struct task_group *tg, int prio)
>>>>>>>>>>
>>>>>>>>>>       for_each_possible_cpu(i) {
>>>>>>>>>>               struct sched_entity *se = tg->se[i];
>>>>>>>>>> +             struct rq *rq = cpu_rq(i);
>>>>>>>>>> +             struct rq_flags rf;
>>>>>>>>>> +             bool queued;
>>>>>>>>>> +
>>>>>>>>>> +             rq_lock_irqsave(rq, &rf);
>>>>>>>>>>
>>>>>>>>>> +             queued = __dequeue_latency(se->cfs_rq, se);
>>>>>>>>>>               WRITE_ONCE(se->latency_offset, latency_offset);
>>>>>>>>>> +             if (queued)
>>>>>>>>>> +                     __enqueue_latency(se->cfs_rq, se, ENQUEUE_WAKEUP);
>>>>>>>>>> +
>>>>>>>>>> +
>>>>>>>>>> +             rq_unlock_irqrestore(rq, &rf);
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>>       mutex_unlock(&shares_mutex);
>>>>>>>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>>>>>>>> index 9a2e71231083..21dd309e98a9 100644
>>>>>>>>>> --- a/kernel/sched/sched.h
>>>>>>>>>> +++ b/kernel/sched/sched.h
>>>>>>>>>> @@ -570,6 +570,7 @@ struct cfs_rq {
>>>>>>>>>>  #endif
>>>>>>>>>>
>>>>>>>>>>       struct rb_root_cached   tasks_timeline;
>>>>>>>>>> +     struct rb_root_cached   latency_timeline;
>>>>>>>>>>
>>>>>>>>>>       /*
>>>>>>>>>>        * 'curr' points to currently running entity on this cfs_rq.

