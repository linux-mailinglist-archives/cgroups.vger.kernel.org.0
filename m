Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB69700EC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGVNVw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 09:21:52 -0400
Received: from foss.arm.com ([217.140.110.172]:37402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfGVNVw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Jul 2019 09:21:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417BC344;
        Mon, 22 Jul 2019 06:21:51 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9013F71A;
        Mon, 22 Jul 2019 06:21:48 -0700 (PDT)
Subject: Re: [PATCH v9 4/8] sched/deadline: Fix bandwidth accounting at all
 levels after offline migration
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-5-juri.lelli@redhat.com>
 <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
 <20190722122828.GG25636@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <07a45864-07bf-aa5d-3ff7-a300326b9040@arm.com>
Date:   Mon, 22 Jul 2019 15:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722122828.GG25636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/22/19 2:28 PM, Juri Lelli wrote:
> On 22/07/19 13:07, Dietmar Eggemann wrote:
>> On 7/19/19 3:59 PM, Juri Lelli wrote:
>>
>> [...]
>>
>>> @@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
>>>  		double_lock_balance(rq, later_rq);
>>>  	}
>>>  
>>> +	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
>>> +		/*
>>> +		 * Inactive timer is armed (or callback is running, but
>>> +		 * waiting for us to release rq locks). In any case, when it
>>> +		 * will file (or continue), it will see running_bw of this
>>
>> s/file/fire ?
> 
> Yep.
> 
>>> +		 * task migrated to later_rq (and correctly handle it).
>>
>> Is this because of dl_task_timer()->enqueue_task_dl()->task_contending()
>> setting dl_se->dl_non_contending = 0 ?
> 
> No, this is related to inactive_task_timer() callback. Since the task is
> migrated (by this function calling set_task_cpu()) because a CPU hotplug
> operation happened, we need to reflect this w.r.t. running_bw, or
> inactive_task_timer() might sub from the new CPU and cause running_bw to
> underflow.

I was more referring to the '... it will see running_bw of thus task
migrated to later_rq ...) and specifically to the HOW the timer
callback can detect this. I should have made this clearer.
inactive_task_timer() checks if (dl_se->dl_non_contending == 0) so I
thought I have to find the place where dl_se->dl_non_contending is set 0?



