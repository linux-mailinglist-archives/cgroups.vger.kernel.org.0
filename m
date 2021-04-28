Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33336DC6B
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhD1Pvi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 11:51:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240572AbhD1Pvh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 11:51:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C77A1FB;
        Wed, 28 Apr 2021 08:50:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5BE23F73B;
        Wed, 28 Apr 2021 08:50:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load
 decay
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@ugedal.com>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
Date:   Wed, 28 Apr 2021 17:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 28/04/2021 17:35, Vincent Guittot wrote:
> On Wed, 28 Apr 2021 at 15:10, Odin Ugedal <odin@ugedal.com> wrote:
>>
>> Hi,
>>
>>> Would be good to mention that the problem happens only if the new cfs_rq has
>>> been removed from the leaf_cfs_rq_list because its PELT metrics were already
>>> null. In such case __update_blocked_fair() never updates the blocked load of
>>> the new cfs_rq and never propagate the removed load in the hierarchy.
>>
>> Well, it does technically occur when PELT metrics were null and therefore
>> removed from this leaf_cfs_rq_list, that is correct. We do however not add
>> newly created cfs_rq's to leaf_cfs_rq_list, so that is also a reason for it
> 
> You're right that we wait for the 1st task to be enqueued to add the
> cfs_rq in the list
> 
>> to occur. Most users of cgroups are probably creating a new cgroup and then
>> attaching a process to it, so I think that will be the _biggest_ issue.
> 
> Yes,  I agree that according to your sequence, your problem mainly
> comes from this and not the commit below
> 
>>
>>> The fix tag should be :
>>> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
>>>
>>> This patch re-introduced the del of idle cfs_rq from leaf_cfs_rq_list in order to
>>> skip useless update of blocked load.
>>
>> Thanks for pointing me at that patch! A quick look makes me think that that
>> commit caused the issue to occur _more often_, but was not the one that
>> introduced it. I should probably investigate a bit more tho., since I didn't
>> dig that deep in it. It is not a clean revert for that patch on v5.12,
>> but I did apply the diff below to test. It is essentially what the patch
>> 039ae8bcf7a5 does, as far as I see. There might however been more commits
>> beteen those, so I might take a look further behind to see.
>>
>> Doing this does make the problem less severe, resulting in ~90/10 load on the
>> example that without the diff results in ~99/1. So with this diff/reverting
>> 039ae8bcf7a5, there is still an issue.
>>
>> Should I keep two "Fixes", or should I just take one of them?
> 
> You can keep both fixes tags
> 
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 794c2cb945f8..5fac4fbf6f84 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7941,8 +7941,8 @@ static bool __update_blocked_fair(struct rq *rq,
>> bool *done)
>>                  * There can be a lot of idle CPU cgroups.  Don't let fully
>>                  * decayed cfs_rqs linger on the list.
>>                  */
>> -               if (cfs_rq_is_decayed(cfs_rq))
>> -                       list_del_leaf_cfs_rq(cfs_rq);
>> +               // if (cfs_rq_is_decayed(cfs_rq))
>> +               //      list_del_leaf_cfs_rq(cfs_rq);
>>
>>                 /* Don't need periodic decay once load/util_avg are null */
>>                 if (cfs_rq_has_blocked(cfs_rq))
>>
>>> propagate_entity_cfs_rq() already goes across the tg tree to
>>> propagate the attach/detach.
>>>
>>> would be better to call list_add_leaf_cfs_rq(cfs_rq)  inside this function
>>> instead of looping twice the tg tree. Something like:
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 33b1ee31ae0f..18441ce7316c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -11026,10 +11026,10 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>>>         for_each_sched_entity(se) {
>>>                 cfs_rq = cfs_rq_of(se);
>>>
>>> -               if (cfs_rq_throttled(cfs_rq))
>>> -                       break;
>>> +               if (!cfs_rq_throttled(cfs_rq))
>>> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
>>>
>>> -               update_load_avg(cfs_rq, se, UPDATE_TG);
>>> +               list_add_leaf_cfs_rq(cfs_rq);
>>>         }
>>>  }
>>>  #else
>>
>>
>> Thanks for that feedback!
>>
>> I did think about that, but was not sure what would be the best one.
>> If it is "safe" to always run list_add_leaf_cfs_rq there (since it is used in
> 
> If the cfs_rq is already in the list list_add_leaf_cfs_rq() will exit
> early but if it's not, we don't have to make sure that the whole
> branch in the list
> 
> In fact, we can break as soon as list_add_leaf_cfs_rq() and
> cfs_rq_throttled() return true
> 
>> more places than just on cgroup change and move to fair class), I do agree
>> that that is a better solution. Will test that, and post a new patch
>> if it works as expected.
>>
>> Also, the current code will exit from the loop in case a cfs_rq is throttled,
>> while your suggestion will keep looping. For list_add_leaf_cfs_rq that is fine
>> (and required), but should we keep running update_load_avg? I do think it is ok,
> 
> When a cfs_rq is throttled, it is not accounted in its parent anymore
> so we don't have to update and propagate the load down.
> 
>> and the likelihood of a cfs_rq being throttled is not that high after all, so
>> I guess it doesn't really matter.

I think what I see on my Juno running the unfairness_missing_load_decay.sh script is
in sync which what you discussed here:

[   91.458079] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice/cg-1/sub delta=-769 cfs_rq->tg->load_avg=858->89 [sh 1690]
[   91.474596] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice/cg-1     delta=-32551 cfs_rq->tg->load_avg=32915->364 [ -1]
[   91.492881] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice          delta=-768 cfs_rq->tg->load_avg=776->8 [ -1]

...
[   91.514164]  dump_stack+0xd0/0x12c
[   91.517577]  attach_entity_cfs_rq+0xe4/0xec
[   91.521773]  task_change_group_fair+0x98/0x190      <---- !!!
[   91.526228]  sched_move_task+0x78/0x1e0
[   91.530078]  cpu_cgroup_attach+0x34/0x70
[   91.534013]  cgroup_migrate_execute+0x32c/0x3e4
[   91.538558]  cgroup_migrate+0x78/0x90
[   91.542231]  cgroup_attach_task+0x110/0x11c
[   91.546425]  __cgroup1_procs_write.constprop.0+0x128/0x170
...

[   91.597490] update_tg_load_avg: from=attach_entity_cfs_rq  *cpu2* cgroup=/slice/cg-2/sub delta=28 cfs_rq->tg->load_avg=0->28 [sh 1701]
[   91.609437] update_tg_load_avg: from=update_load_avg_2     cpu2 cgroup=/slice/cg-2     delta=27 cfs_rq->tg->load_avg=0->27 [ -1]
[   91.621033] update_tg_load_avg: from=update_load_avg_2     cpu2 cgroup=/slice          delta=27 cfs_rq->tg->load_avg=8->35 [ -1]
[   91.632763] update_tg_load_avg: from=__update_blocked_fair cpu0 cgroup=/slice/cg-1/sub delta=-7 cfs_rq->tg->load_avg=89->82 [ -1]
[   91.644470] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice          delta=-7 cfs_rq->tg->load_avg=35->28 [ -1]
[   91.656178] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice/cg-1     delta=-355 cfs_rq->tg->load_avg=364->9 [ -1]
[   91.656233] update_tg_load_avg: from=update_load_avg_2     cpu2 cgroup=/slice/cg-2     delta=-27 cfs_rq->tg->load_avg=27->0 [ -1]
[   91.668272] update_tg_load_avg: from=attach_entity_cfs_rq  cpu0 cgroup=/slice/cg-1/sub delta=1024 cfs_rq->tg->load_avg=82->1106 [stress 1706]
[   91.679707] update_tg_load_avg: from=update_load_avg_2     cpu2 cgroup=/slice          delta=-27 cfs_rq->tg->load_avg=28->1 [ -1]
[   91.692419] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice/cg-1     delta=46330 cfs_rq->tg->load_avg=9->46339 [ -1]
[   91.716193] update_tg_load_avg: from=update_load_avg_2     cpu0 cgroup=/slice          delta=1022 cfs_rq->tg->load_avg=1->1023 [ -1]

[   91.749936]  dump_stack+0xd0/0x12c
[   91.753348]  update_load_avg+0x460/0x490
[   91.757283]  enqueue_task_fair+0xe8/0x7fc
[   91.761303]  ttwu_do_activate+0x68/0x160
[   91.765239]  try_to_wake_up+0x1f4/0x594
...

[   91.833275] update_tg_load_avg: from=update_load_avg_1     *cpu0* cgroup=/slice/cg-2/sub delta=28 cfs_rq->tg->load_avg=28->56 [sh 1701]
[   91.845307] list_add_leaf_cfs_rq: cpu0 cgroup=/slice/cg-2/sub
[   91.851068] list_add_leaf_cfs_rq: cpu0 cgroup=/slice/cg-2

*cpu2* cgroup=/slice/cg-2 is not on the leaf_cfs_rq list.


root@juno:~# cat /proc/sched_debug | grep ":/slice" -A 28 | egrep "(:/slice)|load_avg"

...
cfs_rq[0]:/slice/cg-2
  .load_avg                      : 1
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1
  .tg_load_avg                   : 89     <--- !!!              
  .se->avg.load_avg              : 21
...

with the fix:

root@juno:~# cat /proc/sched_debug | grep ":/slice" -A 28 | egrep "(:/slice)|load_avg"

...
cfs_rq[0]:/slice/cg-2
  .load_avg                      : 2
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 2
  .tg_load_avg                   : 2     <--- !!!
  .se->avg.load_avg              : 1023
...

Snippet I used:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..7214e6e89820 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10854,6 +10854,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
                        break;
 
                update_load_avg(cfs_rq, se, UPDATE_TG);
+               if (!cfs_rq_is_decayed(cfs_rq))
+                       list_add_leaf_cfs_rq(cfs_rq);
        }
 }
