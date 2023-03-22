Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96626C4CE7
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCVOFz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCVOFu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 10:05:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26B17559D1;
        Wed, 22 Mar 2023 07:05:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C57894B3;
        Wed, 22 Mar 2023 07:06:24 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170F93F71E;
        Wed, 22 Mar 2023 07:05:36 -0700 (PDT)
Message-ID: <848c4fb3-d3c4-a7f0-9df8-9b25c537f42c@arm.com>
Date:   Wed, 22 Mar 2023 15:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
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
 <2739c3ec-1e97-fc4d-8001-50283c94f4ff@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <2739c3ec-1e97-fc4d-8001-50283c94f4ff@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/03/2023 19:01, Waiman Long wrote:
> 
> On 3/15/23 13:14, Juri Lelli wrote:
>> On 15/03/23 11:46, Waiman Long wrote:
>>> On 3/15/23 08:18, Juri Lelli wrote:

[...]

>>>> @@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct
>>>> cgroup_taskset *tset)
>>>>            ret = security_task_setscheduler(task);
>>>>            if (ret)
>>>>                goto out_unlock;
>>>> +
>>>> +        if (dl_task(task)) {
>>>> +            cs->nr_deadline_tasks++;
>>>> +            cpuset_attach_old_cs->nr_deadline_tasks--;
>>>> +        }
>>>>        }
>>> Any one of the tasks in the cpuset can cause the test to fail and
>>> abort the
>>> attachment. I would suggest that you keep a deadline task transfer
>>> count in
>>> the loop and then update cs and cpouset_attach_old_cs only after all the
>>> tasks have been iterated successfully.
>> Right, Dietmar I think commented pointing out something along these
>> lines. Think though we already have this problem with current
>> task_can_attach -> dl_cpu_busy which reserves bandwidth for each tasks
>> in the destination cs. Will need to look into that. Do you know which
>> sort of operation would move multiple tasks at once?
> 
> Actually, what I said previously may not be enough. There can be
> multiple controllers attached to a cgroup. If any of thier can_attach()
> calls fails, the whole transaction is aborted and cancel_attach() will
> be called. My new suggestion is to add a new deadline task transfer
> count into the cpuset structure and store the information there
> temporarily. If cpuset_attach() is called, it means all the can_attach
> calls succeed. You can then update the dl task count accordingly and
> clear the temporary transfer count.
> 
> I guess you may have to do something similar with dl_cpu_busy().

I gave it a shot:

https://lkml.kernel.org/r/20230322135959.1998790-1-dietmar.eggemann@arm.com
