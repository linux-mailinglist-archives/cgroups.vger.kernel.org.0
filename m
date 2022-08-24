Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ABA59FE61
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiHXPbA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiHXPaz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 11:30:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680871901E
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 08:30:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso3854394pjb.0
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Nr6VDxQ+9Z3MRjk/tSo9PTiJ5/YnHSGlAbzSQvtKymc=;
        b=qmjOD5wPUNDa8iTubLMf8v2s9M6JFSV1346e97d8+/FNWBwZ2rxbX0DX6lGi4Rhsim
         9Jju7OGBeF35kUbBqdgzumB8y0J0rYYdHqGts5j2+GE56XmLVT+6nI7SY9al0GMs0x62
         OTM6yf8WgWUY7pPvvb9P+GRM3OXq1+JGe3wJDAvEjFWB2YuetvY8J7IFCxhQckNs0rk9
         tGYYH2zB6V0VEe528zfagh6OLsIomAMjIY63L/i+/4dhst6HTC5iuV1mGz2MRe966WtE
         8r0Qx8bJLjfLSbtP88LDHqKAFr0whNygXd7u67EK7O8Hc/4BvDsDfila4lT8Yuf3g8K2
         OUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Nr6VDxQ+9Z3MRjk/tSo9PTiJ5/YnHSGlAbzSQvtKymc=;
        b=jsKiTOXw7mI3CqKm8RCKMZ3vDt5oXlFgEhNxzK508wIsXvZKQJjTy0fJAsovKo/5xL
         9FIYNBD53GMt9bEIpwmJ7ROgmtZqGtEhF9xvyR4Idfu4B7jLkOJrZvX+zcn+QF46MPlW
         fruGQwwnf+XIxDDswSx1h4vIyVaVtpidaSwXANHR+6D2S4jiBEvyXBtKVBg0tkqPWqeO
         lOSUKLjnbxx0pivhlAsobhi3+Df2U43hLkWljpxpir+53WT8Dk+IKfIwb1EUpwVB8bLz
         sWcASz6cGZRzQfUJtAyNx+ZY13gG3wRRxIFwmK1zA1zfMGbt7Nq533ECEMSFpnFdMpZm
         A/wQ==
X-Gm-Message-State: ACgBeo3l7AEKJ3swMidB2QW2d88Ma6ZvQUaCFl72S7mZ6mdBBb7YqplG
        p8jdWsZPGoIUVWR45rQi3NO7fg==
X-Google-Smtp-Source: AA6agR6TP7sJqf+FINNYGFswGkM7+NtmO+2XnKI4HuSUdqvl/BoQjFdrpoX3DJyaLGg41oZcQizYyg==
X-Received: by 2002:a17:902:f641:b0:172:9642:1bf1 with SMTP id m1-20020a170902f64100b0017296421bf1mr29706364plg.36.1661355051780;
        Wed, 24 Aug 2022 08:30:51 -0700 (PDT)
Received: from [10.254.35.15] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 82-20020a621555000000b0053655af14easm9094253pfv.45.2022.08.24.08.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 08:30:50 -0700 (PDT)
Message-ID: <7faa16c2-0488-e9df-da65-94265444b28d@bytedance.com>
Date:   Wed, 24 Aug 2022 23:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3 05/10] sched/psi: optimize task switch inside shared
 cgroups again
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-6-zhouchengming@bytedance.com>
 <YwYwUIjAGHLtRGue@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YwYwUIjAGHLtRGue@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/24 22:06, Johannes Weiner wrote:
> On Wed, Aug 24, 2022 at 04:18:24PM +0800, Chengming Zhou wrote:
>> commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
>> defer prev task sleep handling to psi_task_switch(), so we don't need
>> to clear and set TSK_ONCPU state for common cgroups.
>>
>>     A
>>     |
>>     B
>>    / \
>>   C   D
>>  /     \
>> prev   next
>>
>> After that commit psi_task_switch() do:
>> 1. psi_group_change(next, .set=TSK_ONCPU) for D
>> 2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C
>> 3. psi_group_change(prev, .clear=TSK_RUNNING) for B, A
>>
>> But there is a limitation "prev->psi_flags == next->psi_flags" that
>> if not satisfied, will make this cgroups optimization unusable for both
>> sleep switch or running switch cases. For example:
>>
>> prev->in_memstall != next->in_memstall when sleep switch:
>> 1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
>> 2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C, B, A
>>
>> prev->in_memstall != next->in_memstall when running switch:
>> 1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
>> 2. psi_group_change(prev, .clear=TSK_ONCPU) for C, B, A
>>
>> The reason why this limitation exist is that we consider a group is
>> PSI_MEM_FULL if the CPU is actively reclaiming and nothing productive
>> could run even if it were runnable. So when CPU curr changed from prev
>> to next and their in_memstall status is different, we have to change
>> PSI_MEM_FULL status for their common cgroups.
>>
>> This patch remove this limitation by making psi_group_change() change
>> PSI_MEM_FULL status depend on CPU curr->in_memstall status.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Hoo boy, that took me a second.
> 

Thanks for your time. :-)

> 
> Way back when PSI_MEM_FULL was accounted from the timer tick, task
> switching could simply iterate next and prev to the common ancestor to
> update TSK_ONCPU and be done.
> 
> Then memstall ticks were replaced with checking curr->in_memstall
> directly in psi_group_change(). That meant that now if the task switch
> was between a memstall and a !memstall task, we had to iterate through
> the common ancestors at least ONCE to fix up their state_masks.
> 
> We added the identical_state filter to make sure the common ancestor
> elimination was skipped in that case. It seems that was always a
> little too eager, because it caused us to walk the common ancestors
> *twice* instead of the required once: the iteration for next could
> have stopped at the common ancestor; prev could have updated TSK_ONCPU
> up to the common ancestor, then finish to the root without changing
> any flags, just to get the new curr->in_memstall into the state_masks.
> 
> This patch recognizes this and makes it so that we walk to the root
> exactly once if state_mask needs updating.
> 
> 
> Unless I missed anything, would you mind adding this to the changelog?

Your explanation is very clear and accurate, will add it.

> 
> I'm not quite sure how 4117cebf1a9f ("psi: Optimize task switch inside
> shared cgroups") fits into the picture. That optimized the sleep case,
> but the sleep case never had the common ancestor optimization (the dq
> would have already cleared TSK_ONCPU up to the root). Let me know if I
> am mistaken.

That commit skiped clearing TSK_ONCPU in dequeue when sleep, so also have
the common ancestor optimization.

> 
> AFAICS I can see, this patch here is simply catching up on a missed
> optimization that could have been done in 7fae6c8171d2 ("psi: Use
> ONCPU state tracking machinery to detect reclaim") directly already.

Yes, apart from catching on a missed optimization, I later found in testing
this patch is necessary for the next patch 06/10.

Imaging we walk the common ancestors twice:
(1) psi_group_change(.clear = 0, .set = TSK_ONCPU)
(2) psi_group_change(.clear = TSK_ONCPU, .set = 0)

We previously used tasks[NR_ONCPU] to record TSK_ONCPU, so tasks[NR_ONCPU]++
in (1) then tasks[NR_ONCPU]-- in (2), tasks[NR_ONCPU] still be correct.

The patch 06/10 change to use one bit in state mask to record TSK_ONCPU,
so PSI_ONCPU bit will be set in (1), but then be cleared in (2), which
cause the psi_group_cpu has task running but without PSI_ONCPU bit set!

With this patch, we will never walk the common ancestors twice, so don't
have above problem anymore.

> 
> So I think it all makes sense. I have just two notes on the diff:
> 
>> @@ -820,8 +820,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  	u64 now = cpu_clock(cpu);
>>  
>>  	if (next->pid) {
>> -		bool identical_state;
>> -
>>  		psi_flags_change(next, 0, TSK_ONCPU);
>>  		/*
>>  		 * When switching between tasks that have an identical
>> @@ -829,11 +827,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		 * we reach the first common ancestor. Iterate @next's
>>  		 * ancestors only until we encounter @prev's ONCPU.
>>  		 */
> 
> The comment is rather stale now. Could you change it to this?

Good, will update the comment.

> 
> 		/*
> 		 * Set TSK_ONCPU on @next's cgroups. If @next shares any
> 		 * ancestors with @prev, those will already have @prev's
> 		 * TSK_ONCPU bit set, and we can stop the iteration there.
> 		 */
> 
>> -		identical_state = prev->psi_flags == next->psi_flags;
>>  		iter = NULL;
>>  		while ((group = iterate_groups(next, &iter))) {
>> -			if (identical_state &&
>> -			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
>> +			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
>>  				common = group;
>>  				break;
>>  			}
>> @@ -880,7 +876,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
>>  		 * with dequeuing too, finish that for the rest of the hierarchy.
>>  		 */
>> -		if (sleep) {
>> +		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
>>  			clear &= ~TSK_ONCPU;
>>  			for (; group; group = iterate_groups(prev, &iter))
>>  				psi_group_change(group, cpu, clear, set, now, wake_clock);
> 
> Okay, this computes too. But it is somewhat special-cased, without
> explaining why the memstall state in particular matters. Instead of
> focusing on the exceptions though, can we just generalize this a bit?
> 
> 		/*
> 		 * TSK_ONCPU is handled up to the common ancestor. If there are
> 		 * any other differences between the two tasks (e.g. prev goes
> 		 * to sleep, or only one task is memstall), finish propagating
> 		 * those differences all the way up to the root.
> 		 */
> 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
> 			clear &= ~TSK_ONCPU;
> 			for (; group; group = iterate_groups(prev, &iter))
> 				psi_group_change(group, cpu, clear, set, now, wake_clock);
> 		}

I think this is much better and the comment is very clear!

Thanks.

