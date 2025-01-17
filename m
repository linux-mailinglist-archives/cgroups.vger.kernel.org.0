Return-Path: <cgroups+bounces-6216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43EA149E8
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98A416756D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9F1F78E7;
	Fri, 17 Jan 2025 06:59:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAB1F78E1;
	Fri, 17 Jan 2025 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097168; cv=none; b=AKJ+unoyEe1djvy2FSIpckCdqKXTj4L22TmSjhQgZc66Jz632i2lKtttfYEy922q/38V63orzeo3xoprTr1GLgrKv6aClxM/BCdAeU0Kzr2Rz6OUL9TUfcD70xkLfNrhmkqMXPzluzYEm07JRYTquFl6U7bVghSDOTYaMyhqxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097168; c=relaxed/simple;
	bh=bT/lws0qdKKEVqXiASK2cA33sHXAEJPrHrOb8JKK8AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItueL73OTfxoFmMrqkz19DTmjSziAxfPgvrKDqpwvCa26WhNvd+gzbdyh7BGfa2x+WgISXQUpDMQ0GtQZ1UJK4mohdD4gkc5vsDve06Vb1jnWZ7l2ZEgS0tbaiAlyYlZlGRUS0xaKLO2/kH/nSCa0YEmuevFRLMJsDm365dRRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YZ9V31bHmz1W49p;
	Fri, 17 Jan 2025 14:55:23 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 69E3B180101;
	Fri, 17 Jan 2025 14:59:16 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 17 Jan
 2025 14:59:15 +0800
Message-ID: <a9f98b54-19ac-4ea6-bb8b-76eeb9c89608@huawei.com>
Date: Fri, 17 Jan 2025 14:59:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: <paulmck@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
CC: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Andrew
 Morton <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
	<yosryahmed@google.com>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <davidf@vimeo.com>,
	<handai.szj@taobao.com>, <rientjes@google.com>,
	<kamezawa.hiroyu@jp.fujitsu.com>, RCU <rcu@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka> <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
 <0b6a3935-8b6c-4d11-bacc-31c1ba15b349@huaweicloud.com>
 <81294730-1cd9-4793-b886-9ababe29d071@paulmck-laptop>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <81294730-1cd9-4793-b886-9ababe29d071@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2025/1/15 2:42, Paul E. McKenney wrote:
> On Tue, Jan 14, 2025 at 08:13:37PM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/1/14 17:20, Vlastimil Babka wrote:
>>> On 1/14/25 09:40, Michal Hocko wrote:
>>>> On Mon 13-01-25 19:45:46, Andrew Morton wrote:
>>>>> On Mon, 13 Jan 2025 14:51:55 +0800 Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>>
>>>>>>>> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
>>>>>>>>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>>>>>>>>  	else {
>>>>>>>>  		struct task_struct *p;
>>>>>>>> +		int i = 0;
>>>>>>>>  
>>>>>>>>  		rcu_read_lock();
>>>>>>>> -		for_each_process(p)
>>>>>>>> +		for_each_process(p) {
>>>>>>>> +			/* Avoid potential softlockup warning */
>>>>>>>> +			if ((++i & 1023) == 0)
>>>>>>>> +				touch_softlockup_watchdog();
>>>>>>>
>>>>>>> This might suppress the soft lockup, but won't a rcu stall still be detected?
>>>>>>
>>>>>> Yes, rcu stall was still detected.
>>>
>>> "was" or "would be"? I thought only the memcg case was observed, or was that
>>> some deliberate stress test of the global case? (or the pr_info() console
>>> stress test mentioned earlier, but created outside of the oom code?)
>>>
>>
>> It's not easy to reproduce for global OOM. Because the pr_info() console
>> stress test can also lead to other softlockups or RCU warnings(not
>> causeed by OOM process) because the whole system is struggling.However,
>> if I add mdelay(1) in the dump_task() function (just to slow down
>> dump_task, assuming this is slowed by pr_info()) and trigger a global
>> OOM, RCU warnings can be observed.
>>
>> I think this can verify that global OOM can trigger RCU warnings in the
>> specific scenarios.
> 
> We do have a recently upstreamed rcutree.csd_lock_suppress_rcu_stall
> kernel boot parameter that causes RCU CPU stall warnings to suppress
> most of the output when there is an ongoing CSD-lock stall.
> 
> Would it make sense to do something similar when the system is in OOM,
> give or take the traditional difficulty of determining exactly when OOM
> starts and ends?
> 
> 1dd01c06506c ("rcu: Summarize RCU CPU stall warnings during CSD-lock stalls")
> 
> 							Thanx, Paul
> 

I prefer to just drop it.

Unlike memcg OOM, global OOM doesn't usually happen. Although it
'verified' that the RCU warning can be observed, we haven't encountered
it in practice. Besides, other RCU warnings may also be observed during
global OOM, and it's difficult to circumvent all the warnings.

Best regards,
Ridong

>>>>>> For global OOM, system is likely to struggle, do we have to do some
>>>>>> works to suppress RCU detete?
>>>>>
>>>>> rcu_cpu_stall_reset()?
>>>>
>>>> Do we really care about those? The code to iterate over all processes
>>>> under RCU is there (basically) since ever and yet we do not seem to have
>>>> many reports of stalls? Chen's situation is specific to memcg OOM and
>>>> touching the global case was mostly for consistency reasons.
>>>
>>> Then I'd rather not touch the global case then if it's theoretical? It's not
>>> even exactly consistent, given it's a cond_resched() in the memcg code (that
>>> can be eventually automatically removed once/if lazy preempt becomes the
>>> sole implementation), but the touch_softlockup_watchdog() would remain,
>>> while doing only half of the job?
>>
>>

