Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129216C4B81
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCVNTX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCVNTJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 09:19:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC1127497;
        Wed, 22 Mar 2023 06:19:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6F5A4B3;
        Wed, 22 Mar 2023 06:19:43 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D3E3F6C4;
        Wed, 22 Mar 2023 06:18:56 -0700 (PDT)
Message-ID: <c77bc281-b6e1-1653-6bed-0249f85b7e94@arm.com>
Date:   Wed, 22 Mar 2023 14:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
 <7a3b31bf-4f6a-6525-9c6a-2bae44d7b0af@redhat.com>
 <ZBH9E7lCEXcFDBG4@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZBH9E7lCEXcFDBG4@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/03/2023 18:14, Juri Lelli wrote:
> On 15/03/23 11:46, Waiman Long wrote:
>>
>> On 3/15/23 08:18, Juri Lelli wrote:

[...]

>>> @@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>   		ret = security_task_setscheduler(task);
>>>   		if (ret)
>>>   			goto out_unlock;
>>> +
>>> +		if (dl_task(task)) {
>>> +			cs->nr_deadline_tasks++;
>>> +			cpuset_attach_old_cs->nr_deadline_tasks--;
>>> +		}
>>>   	}
>>
>> Any one of the tasks in the cpuset can cause the test to fail and abort the
>> attachment. I would suggest that you keep a deadline task transfer count in
>> the loop and then update cs and cpouset_attach_old_cs only after all the
>> tasks have been iterated successfully.
> 
> Right, Dietmar I think commented pointing out something along these
> lines. Think though we already have this problem with current
> task_can_attach -> dl_cpu_busy which reserves bandwidth for each tasks
> in the destination cs. Will need to look into that. Do you know which
> sort of operation would move multiple tasks at once?

Moving the process instead of the individual tasks makes
cpuset_can_attach() have to deal with multiple tasks.

# ps2 | grep DLN
 1614  1615 140      0   - DLN thread0-0
 1614  1616 140      0   - DLN thread0-1
 1614  1617 140      0   - DLN thread0-2

# echo 1614 > /sys/fs/cgroup/cpuset/cs2/cgroup.procs
