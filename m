Return-Path: <cgroups+bounces-5990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CDD9FA952
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F18718846C0
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 02:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE62AF14;
	Mon, 23 Dec 2024 02:23:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27118052;
	Mon, 23 Dec 2024 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734920618; cv=none; b=KOqI94+v5pIBQNwpP6jQnDIh/thEZVLzfSPIKmhmWGDxVM8UTN9Vu1RBKAHG8nOgc1GlvVRQIn/pcRF19cD6N+Kji6V24FiGcDPeNO1P8jSv2y9hGmfBsScSP+ayqfLZqgbtqrywSJGKGVk8O7hgSk+mAkBWyDT6gjmBZ4g5VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734920618; c=relaxed/simple;
	bh=+toB1KHsASLVgAFCBg5U9BL707sGVVcdgSyk3QM5I4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FecwwcY5JMRhezintIwGIv4wyvfKJznIKRUSb6R0CG845NrTjGRANRX0DXduCWzuVC93caNdjs6bo6dqcnSAy6XK7x3+bT7eLskpe/wgp42rxqjXkmmuFmoWIBo6gsmkT0cFTdNvx882Viwv7ntnfZ48B1znfSD33UafdcjgcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YGhdc3Lvlz4f3jqj;
	Mon, 23 Dec 2024 10:23:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0C31F1A07B6;
	Mon, 23 Dec 2024 10:23:31 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgB3a62hyWhniXD6FA--.18923S2;
	Mon, 23 Dec 2024 10:23:30 +0800 (CST)
Message-ID: <6319a3df-b19c-4e35-a46c-c4a5ea003a6b@huaweicloud.com>
Date: Mon, 23 Dec 2024 10:23:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: fix soft lockup in the OOM process
To: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
 vbabka@suse.cz, handai.szj@taobao.com, rientjes@google.com,
 kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241220103123.3677988-1-chenridong@huaweicloud.com>
 <20241220144734.05d62ef983fa92e96e29470d@linux-foundation.org>
 <Z2ZuDTYu3PwV1JmT@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z2ZuDTYu3PwV1JmT@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3a62hyWhniXD6FA--.18923S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5JF1fXF1UWr47CrWkCrg_yoW5CFyxpF
	ZrWa18ta1rJryUXr1av392v34I93yfWr1jqrn8tr1akr9xKr1xGFyUKr4YkFWrZFyakFyS
	vr4jvw1xurZ8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/21 15:28, Michal Hocko wrote:
> On Fri 20-12-24 14:47:34, Andrew Morton wrote:
>> On Fri, 20 Dec 2024 10:31:23 +0000 Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> A soft lockup issue was found in the product with about 56,000 tasks were
>>> in the OOM cgroup, it was traversing them when the soft lockup was
>>> triggered.
>>>
>>> ...
>>>
>>> This is because thousands of processes are in the OOM cgroup, it takes a
>>> long time to traverse all of them. As a result, this lead to soft lockup
>>> in the OOM process.
>>>
>>> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
>>> function per 1000 iterations. For global OOM, call
>>> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
>>>
>>> ...
>>>
>>> --- a/include/linux/oom.h
>>> +++ b/include/linux/oom.h
>>> @@ -14,6 +14,13 @@ struct notifier_block;
>>>  struct mem_cgroup;
>>>  struct task_struct;
>>>  
>>> +/* When it traverses for long time,  to prevent softlockup, call
>>> + * cond_resched/touch_softlockup_watchdog very 1000 iterations.
>>> + * The 1000 value  is not exactly right, it's used to mitigate the overhead
>>> + * of cond_resched/touch_softlockup_watchdog.
>>> + */
>>> +#define SOFTLOCKUP_PREVENTION_LIMIT 1000
>>
>> If this is to have potentially kernel-wide scope, its name should
>> identify which subsystem it belongs to.  Maybe OOM_KILL_RESCHED or
>> something.
>>
>> But I'm not sure that this really needs to exist.  Are the two usage
>> sites particularly related?
> 
> Yes, I do not think this needs to pretend to be a more generic mechanism
> to prevent soft lockups. The number of iterations highly depends on the
> operation itself.
> 

Thanks， I will update.

>>
>>>  enum oom_constraint {
>>>  	CONSTRAINT_NONE,
>>>  	CONSTRAINT_CPUSET,
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 5c373d275e7a..f4c12d6e7b37 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>>>  {
>>>  	struct mem_cgroup *iter;
>>>  	int ret = 0;
>>> +	int i = 0;
>>>  
>>>  	BUG_ON(mem_cgroup_is_root(memcg));
>>>  
>>> @@ -1169,8 +1170,11 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>>>  		struct task_struct *task;
>>>  
>>>  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
>>> -		while (!ret && (task = css_task_iter_next(&it)))
>>> +		while (!ret && (task = css_task_iter_next(&it))) {
>>>  			ret = fn(task, arg);
>>> +			if (++i % SOFTLOCKUP_PREVENTION_LIMIT)
>>
>> And a modulus operation is somewhat expensive.
> 
> This is a cold path used during OOM. While we can make it more optimal I
> doubt it matters in practice so we should aim at readbility. I do not
> mind either way, I just wanted to note that this is not performance
> sensitive.
> 

I think '(++i & 1023)' is much better, I will update.
Thank you all gays.

Best regards
Ridong

>>
>> Perhaps a simple
>>
>> 		/* Avoid potential softlockup warning */
>> 		if ((++i & 1023) == 0)
>>
>> at both sites will suffice.  Opinions might vary...
>>
> 


