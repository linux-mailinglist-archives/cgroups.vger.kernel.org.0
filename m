Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5673737FB
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhEEJoS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 05:44:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhEEJoB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 05:44:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB2ED6E;
        Wed,  5 May 2021 02:43:05 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468C13F70D;
        Wed,  5 May 2021 02:43:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load
 decay
To:     Odin Ugedal <odin@ugedal.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210425080902.11854-1-odin@uged.al>
 <20210425080902.11854-2-odin@uged.al> <20210427142611.GA22056@vingu-book>
 <CAFpoUr1KOvLSUoUac8MMTD+TREDWmDpeku950U=_p-oBDE4Avw@mail.gmail.com>
 <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com>
 <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
 <CAFpoUr3vMQq8QYajXZsQ6zWQOncO5Q8-2gFWOJLFm-APUznuZA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4b0d6562-db41-b4fc-ae51-694946c9255d@arm.com>
Date:   Wed, 5 May 2021 11:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFpoUr3vMQq8QYajXZsQ6zWQOncO5Q8-2gFWOJLFm-APUznuZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/05/2021 16:41, Odin Ugedal wrote:
> Hi,
> 
>> I think what I see on my Juno running the unfairness_missing_load_decay.sh script is
>> in sync which what you discussed here:
> 
> Thanks for taking a look!
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 794c2cb945f8..7214e6e89820 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10854,6 +10854,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>>                         break;
>>
>>                 update_load_avg(cfs_rq, se, UPDATE_TG);
>> +               if (!cfs_rq_is_decayed(cfs_rq))
>> +                       list_add_leaf_cfs_rq(cfs_rq);
>>         }
>> }
> 
> This might however lead to "loss" at /slice/cg-2/sub and
> slice/cg-1/sub in this particular case tho, since
> propagate_entity_cfs_rq skips one cfs_rq
> by taking the parent of the provided se. The loss in that case would
> however not be equally big, but will still often contribute to some
> unfairness.

Yeah, that's true.

By moving stopped `stress` tasks into

 /sys/fs/cgroup/cpu/slice/cg-{1,2}/sub

and then into

 /sys/fs/cgroup/cpuset/A

which has a cpuset.cpus {0-1,4-5} not containing the cpus the `stress`
tasks attached {2,3} to and then restart the `stress` tasks again I get:

cfs_rq[1]:/slice/cg-1/sub
  .load_avg                      : 1024
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1024  <---
  .tg_load_avg                   : 2047  <---
  .se->avg.load_avg              : 511
cfs_rq[1]:/slice/cg-1
  .load_avg                      : 512
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 512  <---
  .tg_load_avg                   : 1022 <---
  .se->avg.load_avg              : 512
cfs_rq[1]:/slice
  .load_avg                      : 513
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 513
  .tg_load_avg                   : 1024
  .se->avg.load_avg              : 512
cfs_rq[5]:/slice/cg-1/sub
  .load_avg                      : 1024
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1023 <---
  .tg_load_avg                   : 2047 <---
  .se->avg.load_avg              : 511
cfs_rq[5]:/slice/cg-1
  .load_avg                      : 512
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 510  <---
  .tg_load_avg                   : 1022 <---
  .se->avg.load_avg              : 511
cfs_rq[5]:/slice
  .load_avg                      : 512
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 511
  .tg_load_avg                   : 1024
  .se->avg.load_avg              : 510

I saw that your v2 patch takes care of that.
