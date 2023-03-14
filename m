Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06086B91E1
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCNLlz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCNLlx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 07:41:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2128F9BE11;
        Tue, 14 Mar 2023 04:41:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C7C4B3;
        Tue, 14 Mar 2023 04:42:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19EF23F67D;
        Tue, 14 Mar 2023 04:41:45 -0700 (PDT)
Message-ID: <f2eb03be-53dc-73db-ede9-99ecbb189782@arm.com>
Date:   Tue, 14 Mar 2023 12:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
References: <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
 <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
 <ZAmCzJQZl7j/m2oN@localhost.localdomain>
 <CA+khW7iAeTALH5b6upHXs1RotFBohVeZCcAp5H+r-=L05kqnww@mail.gmail.com>
 <20230311185150.stvtcbdkoofgn3wd@airbuntu>
 <ZA9RZ3VvGXKp+1L6@localhost.localdomain>
 <7070da53-a5a7-6965-5604-abee3cae9d46@arm.com>
In-Reply-To: <7070da53-a5a7-6965-5604-abee3cae9d46@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13/03/2023 18:10, Dietmar Eggemann wrote:
> On 13/03/2023 17:37, Juri Lelli wrote:
>> On 11/03/23 18:51, Qais Yousef wrote:
>>> On 03/09/23 14:23, Hao Luo wrote:
>>>> On Wed, Mar 8, 2023 at 10:55 PM Juri Lelli <juri.lelli@redhat.com> wrote:
>>>>>
>>>>> On 08/03/23 10:01, Hao Luo wrote:
>>>>>> On Wed, Mar 8, 2023 at 2:20 AM Juri Lelli <juri.lelli@redhat.com> wrote:
>>>>>>>
>>>>>>> On 01/03/23 17:03, Qais Yousef wrote:
>>>>>>>> On 03/01/23 15:26, Juri Lelli wrote:
> 
> [...]
> 
>>> Yeah I am working on 5.10 too (this will need to be backported to 5.10 and 5.15
>>> ultimately) and had the same crash because task is NULL.
>>>
>>> Fixed it this way which I think what you intended to do Juri? It moves the
>>> check for dl_task(task) inside cgroup_taskset_for_each() loop.
>>>
>>> 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> 	index 83a8943467fb..06d6bb68d86b 100644
>>> 	--- a/kernel/cgroup/cpuset.c
>>> 	+++ b/kernel/cgroup/cpuset.c
>>> 	@@ -2495,11 +2495,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>> 			ret = security_task_setscheduler(task);
>>> 			if (ret)
>>> 				goto out_unlock;
>>> 	-       }
>>> 	 
>>> 	-       if (dl_task(task)) {
>>> 	-               cs->deadline_tasks++;
>>> 	-               cpuset_attach_old_cs->deadline_tasks--;
>>> 	+               if (dl_task(task)) {
>>> 	+                       cs->deadline_tasks++;
>>> 	+                       cpuset_attach_old_cs->deadline_tasks--;
>>> 	+               }
>>> 		}
>>> 	 
>>> 		/*
>>
>> Duh, indeed.
>>
>>> Like Hao I don't have any deadline tasks in the system. With the fix above
>>> I don't notice the delay on suspend resume using your patches.
>>
>> OK, cool.
>>
>>> If you want any debug; please feel free to add them into your branch so I can
>>> run with that and give you the log.
>>
>> Will need to find time to run some tests with DEADLINE tasks, yeah.
>> Maybe Dietmar, since you reported as well the issue above with your
>> testing, you could help with testing DEADLINE?
> 
> Ah, now I see! It's the same issue I saw. And it's not specifically
> related to DL tasks. Any tasks which you move into a cpuset will trigger
> this.
> Yeah, can do some DL tests later on this fix.

This fix also works for my DL test.

root@juno:~# ps2 | grep DLN
   83    83 140      0   - DLN sugov:0
   84    84 140      0   - DLN sugov:1
 1601  1602 140      0   - DLN thread0-0
 1601  1603 140      0   - DLN thread0-1
 1601  1604 140      0   - DLN thread0-2
 1601  1605 140      0   - DLN thread0-3
 1601  1606 140      0   - DLN thread0-4
 1601  1607 140      0   - DLN thread0-5
 1601  1608 140      0   - DLN thread0-6
 1601  1609 140      0   - DLN thread0-7
 1601  1610 140      0   - DLN thread0-8
 1601  1611 140      0   - DLN thread0-9
 1601  1612 140      0   - DLN thread0-10
 1601  1613 140      0   - DLN thread0-11

cgroupv1

root@juno:# cd /sys/fs/cgroup/cpuset
root@juno:# mkdir cs1
root@juno:# echo 0 > cs1/cpuset.mems
root@juno:# echo 0,3-5 > cs1/cpuset.cpus

root@juno:# cgclassify -g cpuset:cs1 1602 1603 1604 $$

One remaining doubt: `cgclassify` will still move one task at a time so
cpuset_can_attach() has to deal with one task per call. But
cgroup_taskset_for_each() says that tset can contain multiple tasks. In
this case we would have to think about only changing cs->deadline_tasks
if all tasks can be moved.
Don't know which test would trigger a tset with multiple tasks in
cpuset_can_attach().
