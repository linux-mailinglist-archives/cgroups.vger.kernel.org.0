Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2148E8DB
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 12:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiANLGf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 06:06:35 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57587 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237845AbiANLGf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 06:06:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1oHN1x_1642158390;
Received: from 30.21.164.113(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V1oHN1x_1642158390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 19:06:31 +0800
Message-ID: <e071a66e-e7d5-8657-725b-8d48cb8ddbb7@linux.alibaba.com>
Date:   Fri, 14 Jan 2022 19:06:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
 <Yd7JO1UYlRXR0dWE@hirez.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <Yd7JO1UYlRXR0dWE@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/12 下午8:27, Peter Zijlstra 写道:
> On Tue, Jan 11, 2022 at 05:56:00PM +0800, Cruz Zhao wrote:
> 
>> @@ -1115,6 +1118,7 @@ struct rq {
>>  	unsigned int		core_forceidle_seq;
>>  	unsigned int		core_forceidle_occupation;
>>  	u64			core_forceidle_start;
>> +	bool			in_forcedidle;
> 
> naming is wrong
> 
>>  #endif
>>  };
>>  
>> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
>> index 07dde29..ea22a8c 100644
>> --- a/kernel/sched/stats.c
>> +++ b/kernel/sched/stats.c
>> @@ -108,6 +108,16 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_SCHED_CORE
>> +static inline u64 get_rq_forceidle_time(struct rq *rq) {
>> +	return rq->rq_forceidle_time;
>> +}
>> +#else
>> +static inline u64 get_rq_forceidle_time(struct rq *rq) {
>> +	return 0;
>> +}
>> +#endif
> 
> indent is wrong, and if you put the #ifdef inside the function it'll be
> smaller.

Thanks for reviewing and suggestions, I'll fix these problems in the
next version.

Best,
Cruz Zhao
