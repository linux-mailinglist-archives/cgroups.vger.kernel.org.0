Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8476FBD1
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGVJIW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 05:08:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfGVJIW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Jul 2019 05:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D71A344;
        Mon, 22 Jul 2019 02:08:21 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E6DF3F694;
        Mon, 22 Jul 2019 02:08:19 -0700 (PDT)
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b18f1ec3-46a1-e65e-2c6e-85729031c996@arm.com>
Date:   Mon, 22 Jul 2019 11:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722083214.GF25636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/22/19 10:32 AM, Juri Lelli wrote:
> On 22/07/19 10:21, Dietmar Eggemann wrote:
>> On 7/19/19 3:59 PM, Juri Lelli wrote:
>>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> [...]
>>
>>> @@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
>>>  			 */
>>>  			if (!cpumask_subset(span, &p->cpus_allowed) ||
>>
>> This doesn't apply cleanly on v5.3-rc1 anymore due to commit
>> 3bd3706251ee ("sched/core: Provide a pointer to the valid CPU mask").
>>
>>>  			    rq->rd->dl_bw.bw == 0) {
>>> -				task_rq_unlock(rq, p, &rf);
>>> -				return -EPERM;
>>> +				retval = -EPERM;
>>> +				goto unlock;
>>>  			}
>>>  		}
>>>  #endif
> 
> Thanks for reporting. The set is based on cgroup/for-next (as of last
> week), though. I can of course rebase on tip/sched/core or mainline if
> needed.

Not sure, there is another little issue on 3/8 since uclamp is in
v5.3-rc1 as well commit 69842cba9ace8 ("sched/uclamp: Add CPU's clamp
buckets refcounting").
