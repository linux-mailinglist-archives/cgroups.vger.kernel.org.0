Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA26B77A9
	for <lists+cgroups@lfdr.de>; Mon, 13 Mar 2023 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCMMh5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Mar 2023 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMMh4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Mar 2023 08:37:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E7B1CAF8;
        Mon, 13 Mar 2023 05:37:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8904B3;
        Mon, 13 Mar 2023 05:38:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5453F64C;
        Mon, 13 Mar 2023 05:37:49 -0700 (PDT)
Message-ID: <e81ffc13-a89e-d43e-18d1-10d9e0161638@arm.com>
Date:   Mon, 13 Mar 2023 13:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZAhhGi55BkYkc3ss@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 08/03/2023 11:19, Juri Lelli wrote:
> On 01/03/23 17:03, Qais Yousef wrote:
>> On 03/01/23 15:26, Juri Lelli wrote:
>>> On 01/03/23 12:28, Qais Yousef wrote:
>>>> On 03/01/23 08:31, Juri Lelli wrote:
>>>
>>> ...
>>>
>>>>> Not ignoring you guys here, but it turns out I'm quite bogged down with
>>>>> other stuff at the moment. :/ So, apologies and I'll try to get to this
>>>>> asap. Thanks a lot for all your efforts and time reviewing so far!
>>>>
>>>> Np, I can feel you :-)
>>>
>>> Eh. :/
>>
>> I hope I did not offend. That was meant as no pressure, I understand.
> 
> No offence at all! I meant "we are all on the same boat it seems". :)
> 
>>> BTW, do you have a repro script of some sort handy I might play with?
>>
>> Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
>> the time around the call and trace_printk'ed the result.
>>
>> I was working on a android phone which just suspends to ram if you turn the
>> screen off and disconnect the usb.
> 
> Looks like I could come up with the following
> 
> https://github.com/jlelli/linux.git deadline/rework-cpusets
> https://github.com/jlelli/linux/tree/deadline/rework-cpusets
> 
> which I don't think it's at a point that I feel comfortable to propose
> as an RFC (not even sure if it actually makes sense), but it survived my
> very light testing.
> 
> Could you please take a look and, if it makes some sense in theory, give
> it a try on your end?

sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets

@@ -2474,6 +2494,11 @@ static int cpuset_can_attach(struct
cgroup_taskset *tset)
                        goto out_unlock;
        }

+       if (dl_task(task)) {
+               cs->deadline_tasks++;
+               cpuset_attach_old_cs->deadline_tasks--;
+       }
+

This one looks odd. task is NULL here ?

If you move a DL task from one cpuset to another this happens now:

root@juno:~# ps2 | grep DLN
   82    82 140      0   - DLN sugov:0
   83    83 140      0   - DLN sugov:1
 1615  1616 140      0   - DLN thread0-0
 1615  1617 140      0   - DLN thread0-1
 1615  1618 140      0   - DLN thread0-2
 1615  1619 140      0   - DLN thread0-3
 1615  1620 140      0   - DLN thread0-4
 1615  1621 140      0   - DLN thread0-5
 1615  1622 140      0   - DLN thread0-6
 1615  1623 140      0   - DLN thread0-7
 1615  1624 140      0   - DLN thread0-8
 1615  1625 140      0   - DLN thread0-9
 1615  1626 140      0   - DLN thread0-10
 1615  1627 140      0   - DLN thread0-11 <--

root@juno:~# cd /sys/fs/cgroup/cpuset
root@juno:~# mkdir cs1
root@juno:~# echo 0 > cs1/cpuset.mems
root@juno:~# echo 0,3-5 > cs1/cpuset.cpus

root@juno:~# echo 1627 > cs1/tasks

root@juno:~# [  154.968900] *** task=0000000000000000

[...]
