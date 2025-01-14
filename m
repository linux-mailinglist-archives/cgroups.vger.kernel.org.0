Return-Path: <cgroups+bounces-6122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6AA10650
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE947A488F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D4236ED2;
	Tue, 14 Jan 2025 12:13:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256E236ED0;
	Tue, 14 Jan 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856831; cv=none; b=MnLYxti2y0I0wDM1YiAcMFsjngIl9yspklqafk3uSxd/ym1DPgtQB9tDEKC+QY7MAVSRHaRLz/0uasDLMrJ/65C3NNmrgqECyRdGKyolm5qShI8JJcOgycn6XdBtczdnjHEvXjbI4ErENymM9wMohh1a6KwRf7PSPrehYFyWtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856831; c=relaxed/simple;
	bh=cwcTaWtNyHYXTGA3J62j/tDFYJP3FRQde2Cu9R3UXow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jep3F7I8Bi7HReGXW7alqcA717OGfz4H7o/gmSrNztoYjwgcMZqTB+mhUMfOZ9RxN6V3rxb0NgZfAWKn5Ua+YbSQI10vEozUjRiF1xFg7yBOH7YutMA3kWWIfatH4KeSqFf5suhsEGQ5jDMbgBjC+vWAlcnZX08DUrpbweEktuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXShG3sWPz4f3jMX;
	Tue, 14 Jan 2025 20:13:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DD23B1A0E99;
	Tue, 14 Jan 2025 20:13:38 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCXN8LxVIZnXCCuAw--.9620S2;
	Tue, 14 Jan 2025 20:13:38 +0800 (CST)
Message-ID: <0b6a3935-8b6c-4d11-bacc-31c1ba15b349@huaweicloud.com>
Date: Tue, 14 Jan 2025 20:13:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
 handai.szj@taobao.com, rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com,
 RCU <rcu@vger.kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka> <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCXN8LxVIZnXCCuAw--.9620S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15WrykJF47tFWDJrW3Awb_yoW8tFWxpF
	yUu3WUKFs5Jrn5Xw42q34Sgr12qw1kZrsrXr15Kr13urn8Krn7Zr17Kay5uF93Aryfu3W0
	vr4vgrWxurZ0yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/14 17:20, Vlastimil Babka wrote:
> On 1/14/25 09:40, Michal Hocko wrote:
>> On Mon 13-01-25 19:45:46, Andrew Morton wrote:
>>> On Mon, 13 Jan 2025 14:51:55 +0800 Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>
>>>>>> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
>>>>>>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>>>>>>  	else {
>>>>>>  		struct task_struct *p;
>>>>>> +		int i = 0;
>>>>>>  
>>>>>>  		rcu_read_lock();
>>>>>> -		for_each_process(p)
>>>>>> +		for_each_process(p) {
>>>>>> +			/* Avoid potential softlockup warning */
>>>>>> +			if ((++i & 1023) == 0)
>>>>>> +				touch_softlockup_watchdog();
>>>>>
>>>>> This might suppress the soft lockup, but won't a rcu stall still be detected?
>>>>
>>>> Yes, rcu stall was still detected.
> 
> "was" or "would be"? I thought only the memcg case was observed, or was that
> some deliberate stress test of the global case? (or the pr_info() console
> stress test mentioned earlier, but created outside of the oom code?)
> 

It's not easy to reproduce for global OOM. Because the pr_info() console
stress test can also lead to other softlockups or RCU warnings(not
causeed by OOM process) because the whole system is struggling.However,
if I add mdelay(1) in the dump_task() function (just to slow down
dump_task, assuming this is slowed by pr_info()) and trigger a global
OOM, RCU warnings can be observed.

I think this can verify that global OOM can trigger RCU warnings in the
specific scenarios.

>>>> For global OOM, system is likely to struggle, do we have to do some
>>>> works to suppress RCU detete?
>>>
>>> rcu_cpu_stall_reset()?
>>
>> Do we really care about those? The code to iterate over all processes
>> under RCU is there (basically) since ever and yet we do not seem to have
>> many reports of stalls? Chen's situation is specific to memcg OOM and
>> touching the global case was mostly for consistency reasons.
> 
> Then I'd rather not touch the global case then if it's theoretical? It's not
> even exactly consistent, given it's a cond_resched() in the memcg code (that
> can be eventually automatically removed once/if lazy preempt becomes the
> sole implementation), but the touch_softlockup_watchdog() would remain,
> while doing only half of the job?


