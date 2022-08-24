Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB559F828
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiHXKse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 06:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiHXKsc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 06:48:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4639FE0
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:48:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p13so3952757pld.6
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=thSzRW4aWni7cQ3cLMCpXQQdcNuVFeBQihn5wBZ1w4Y=;
        b=QyJwad6uBlx7EONkiwSQtU4C7ogMIXSM6RBdTUMtbA/aPQEB9EtM6HaSOGkglKqE2H
         4STb9aTrlkFFu/WK6ZlEFiu35fXmkVlO7XK9twUpzjhHlTBJTJtGo10n1ylFKSz9LJgr
         nJyUqtTEm19jj0n1bosKsbU+W8ATWCGmCJEZiBudnD1xsrRlUzRMiiXODXcnT3SAUJls
         Kr23S2td6KubebWec7dlWiTrGJL9AiU/pBZwfH5D2CMi+XMTq2ZAeB/tDDGBzQ0lMn/E
         HvafMRvKKhaSmPKSQRXTefAywsKaKU+6oQrtg9DJvEvKigpaPw1Wd9dd31Sqe6slhKuG
         YyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=thSzRW4aWni7cQ3cLMCpXQQdcNuVFeBQihn5wBZ1w4Y=;
        b=R5i8GcQUAC3Tj4AXSybtxZNUbD2gdnS/aBly9vONACOCruop8GL84EQtPXkf2BDEHu
         nmrFItfeTUibWL+hBe0RvY4gJ23fQj38zFI2PhltTESBX2bnjpS4gv9cA/dILa/Gr8ra
         kMR5l1P/eqa9AeK3+fUg1iGJlR41MO9uv49Ld68a/LQMRhmf6gyMpT4++F6Kq0RyazlE
         Lkcq4exiaS71ZkjzdJHLL39Im4SibJOnDYlIUuG3wFQSGgtRdbjQc7i+O/SR3jTZyJBI
         YE1gEzdAUkTm+SAlp29p1hGGVu0NdbLIdXrhEoIxIAdmINF6Ju1RywhCool5QW6Q2wIV
         xYpQ==
X-Gm-Message-State: ACgBeo2oJtu5RL6oXGmN2Gge1f4frLi5Dqv9NCyG5wHoEr5tED6IqcZP
        BajhwiNV09m4I10Gaxe8Xogmzw==
X-Google-Smtp-Source: AA6agR70JPk07DaMsRmMalX5acSeZrU1VRvwgNd2pP2A1mE75w9HpahiFgSAiBd33nQbAVyPweTKrA==
X-Received: by 2002:a17:902:d643:b0:172:84c4:d513 with SMTP id y3-20020a170902d64300b0017284c4d513mr28522266plh.138.1661338110437;
        Wed, 24 Aug 2022 03:48:30 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090a8d1600b001ef9659d711sm1068848pjo.48.2022.08.24.03.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 03:48:30 -0700 (PDT)
Message-ID: <c3e9c6ce-fded-8736-1261-7cd0e98edced@bytedance.com>
Date:   Wed, 24 Aug 2022 18:48:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3 09/10] sched/psi: cache parent psi_group to speed up
 groups iterate
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-10-zhouchengming@bytedance.com>
 <YwX7CeeRDDAhV3UH@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YwX7CeeRDDAhV3UH@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/24 18:18, Johannes Weiner wrote:
> Hi Chengming,
> 
> This looks generally good to me, but I have one comment:
> 
> On Wed, Aug 24, 2022 at 04:18:28PM +0800, Chengming Zhou wrote:
>> @@ -772,30 +772,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>>  }
>>  
>> -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>> +static inline struct psi_group *task_psi_group(struct task_struct *task)
>>  {
>> -	if (*iter == &psi_system)
>> -		return NULL;
>> -
>>  #ifdef CONFIG_CGROUPS
>> -	if (static_branch_likely(&psi_cgroups_enabled)) {
>> -		struct cgroup *cgroup = NULL;
>> -
>> -		if (!*iter)
>> -			cgroup = task->cgroups->dfl_cgrp;
>> -		else
>> -			cgroup = cgroup_parent(*iter);
>> -
>> -		if (cgroup && cgroup_parent(cgroup)) {
>> -			*iter = cgroup;
>> -			return cgroup_psi(cgroup);
>> -		}
>> -	}
>> +	if (static_branch_likely(&psi_cgroups_enabled))
>> +		return cgroup_psi(task_dfl_cgroup(task));
>>  #endif
>> -	*iter = &psi_system;
>>  	return &psi_system;
>>  }
>>  
>> +#define for_each_psi_group(group) \
>> +	for (; group; group = group->parent)
> 
> It would be better to open-code this. It's hiding that it's walking
> ancestors, and the name and single parameter suggest it's walking some
> global list - not that the parameter is iterator AND starting point.
> 
> This makes for particularly obscure code in the discontiguous loops in
> psi_task_switch():
> 
> 	group = task_psi_group(task);
> 	for_each_psi_group(group)
> 		if (group == common)
> 			break;
> 	/* This looks like a second full loop: */
> 	for_each_psi_group(group)
> 		...
> 

Good point, it's not clear as open-code, I will change these in next version.

Thanks!


>>  static void psi_flags_change(struct task_struct *task, int clear, int set)
>>  {
>>  	if (((task->psi_flags & set) ||
>> @@ -815,7 +803,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>>  {
>>  	int cpu = task_cpu(task);
>>  	struct psi_group *group;
>> -	void *iter = NULL;
>>  	u64 now;
>>  
>>  	if (!task->pid)
>> @@ -825,7 +812,8 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>>  
>>  	now = cpu_clock(cpu);
>>  
>> -	while ((group = iterate_groups(task, &iter)))
>> +	group = task_psi_group(task);
>> +	for_each_psi_group(group)
>>  		psi_group_change(group, cpu, clear, set, now, true);
> 
> task_psi_group() is never NULL, so this should be a do-while loop:
> 
> 	group = task_psi_group(task);
> 	do {
> 		psi_group_change(group, cpu, clear, set, now, true);
> 	} while ((group = group->parent));
> 
>> @@ -834,7 +822,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  {
>>  	struct psi_group *group, *common = NULL;
>>  	int cpu = task_cpu(prev);
>> -	void *iter;
>>  	u64 now = cpu_clock(cpu);
>>  
>>  	if (next->pid) {
>> @@ -845,8 +832,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		 * we reach the first common ancestor. Iterate @next's
>>  		 * ancestors only until we encounter @prev's ONCPU.
>>  		 */
>> -		iter = NULL;
>> -		while ((group = iterate_groups(next, &iter))) {
>> +		group = task_psi_group(next);
>> +		for_each_psi_group(group) {
> 
> Ditto.
> 
>>  			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
>>  			    PSI_ONCPU) {
>>  				common = group;
>> @@ -887,9 +874,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  
>>  		psi_flags_change(prev, clear, set);
>>  
>> -		iter = NULL;
>> -		while ((group = iterate_groups(prev, &iter)) && group != common)
>> +		group = task_psi_group(prev);
>> +		for_each_psi_group(group) {
>> +			if (group == common)
>> +				break;
> 
> Ditto.
> 
>>  			psi_group_change(group, cpu, clear, set, now, wake_clock);
>> +		}
>>  
>>  		/*
>>  		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
>> @@ -897,7 +887,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		 */
>>  		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
>>  			clear &= ~TSK_ONCPU;
>> -			for (; group; group = iterate_groups(prev, &iter))
>> +			for_each_psi_group(group)
>>  				psi_group_change(group, cpu, clear, set, now, wake_clock);
> 
> This can stay as is, group may already be NULL here.
> 
>> @@ -907,7 +897,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  void psi_account_irqtime(struct task_struct *task, u32 delta)
>>  {
>>  	int cpu = task_cpu(task);
>> -	void *iter = NULL;
>>  	struct psi_group *group;
>>  	struct psi_group_cpu *groupc;
>>  	u64 now;
>> @@ -917,7 +906,8 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
>>  
>>  	now = cpu_clock(cpu);
>>  
>> -	while ((group = iterate_groups(task, &iter))) {
>> +	group = task_psi_group(task);
>> +	for_each_psi_group(group) {
>>  		groupc = per_cpu_ptr(group->pcpu, cpu);
> 
> do-while again.
> 
> With that,
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thanks!
