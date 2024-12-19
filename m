Return-Path: <cgroups+bounces-5966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6889F71C2
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 02:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8047D166536
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE84D8DA;
	Thu, 19 Dec 2024 01:28:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFF1E4BE;
	Thu, 19 Dec 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571681; cv=none; b=VZJ5Xhn6wGP5EP+LhJKAIRUDYswURUKjtsdr9ltdRXwjSZyZxSIu9P2dkPbgNmLjsZDmpFD6Xmcml8Zqdmv8ps/CH/oVwFDKbmgDxZAtAf1lPEpOk+lKPWRzPByc5K9JEAi94ZR7V1QVyJGNEOBVmuRbW9Yw/htBj/EJF761HG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571681; c=relaxed/simple;
	bh=w22cCMmNAlPeByFGMuqQ51dMyas4xIm0I0kFLFMZ92s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOFvT78BTIWK4H3XugXK8SFGcIIp/L1CwDC46QGQ72CcBqSLatAy2SDNvcOkdF6mpC4cDRsMgety9Xs6csFdgVgkEZZ4IhCRv7KY3BDLUbwdLahk71316aQ40M0ZM9gqoECurOnz/Wl3WPKLUXKjtZISEPwpZZpgFwykqkeCiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDCbB0YRRz4f3lfX;
	Thu, 19 Dec 2024 09:27:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9FE2F1A058E;
	Thu, 19 Dec 2024 09:27:54 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAnToKYdmNn59MBFA--.16175S2;
	Thu, 19 Dec 2024 09:27:54 +0800 (CST)
Message-ID: <7d7b3c01-4977-41fa-a19c-4e6399117e8e@huaweicloud.com>
Date: Thu, 19 Dec 2024 09:27:52 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
 handai.szj@taobao.com, rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
 <Z2F0ixNUW6kah1pQ@tiehlicka>
 <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>
 <Z2KAJZ4TKZnGxsOM@tiehlicka>
 <02f7d744-f123-4523-b170-c2062b5746c8@huaweicloud.com>
 <Z2KichB-NayQbzmd@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z2KichB-NayQbzmd@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnToKYdmNn59MBFA--.16175S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45Zw1DCFWftr4ftry5urg_yoW5KFW5pF
	yDXa4jyan5J3yFqr12vw10vryayrWIka15Xr4Dtr15KrnIqw1avry2krW7uF97uFn2yF12
	vr4j9w1xWr4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/18 18:22, Michal Hocko wrote:
> On Wed 18-12-24 17:00:38, Chen Ridong wrote:
>>
>>
>> On 2024/12/18 15:56, Michal Hocko wrote:
>>> On Wed 18-12-24 15:44:34, Chen Ridong wrote:
>>>>
>>>>
>>>> On 2024/12/17 20:54, Michal Hocko wrote:
>>>>> On Tue 17-12-24 12:18:28, Chen Ridong wrote:
>>>>> [...]
>>>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>>>>> index 1c485beb0b93..14260381cccc 100644
>>>>>> --- a/mm/oom_kill.c
>>>>>> +++ b/mm/oom_kill.c
>>>>>> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
>>>>>>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
>>>>>>  		return 0;
>>>>>>  
>>>>>> +	cond_resched();
>>>>>>  	task = find_lock_task_mm(p);
>>>>>>  	if (!task) {
>>>>>>  		/*
>>>>>
>>>>> This is called from RCU read lock for the global OOM killer path and I
>>>>> do not think you can schedule there. I do not remember specifics of task
>>>>> traversal for crgoup path but I guess that you might need to silence the
>>>>> soft lockup detector instead or come up with a different iteration
>>>>> scheme.
>>>>
>>>> Thank you, Michal.
>>>>
>>>> I made a mistake. I added cond_resched in the mem_cgroup_scan_tasks
>>>> function below the fn, but after reconsideration, it may cause
>>>> unnecessary scheduling for other callers of mem_cgroup_scan_tasks.
>>>> Therefore, I moved it into the dump_task function. However, I missed the
>>>> RCU lock from the global OOM.
>>>>
>>>> I think we can use touch_nmi_watchdog in place of cond_resched, which
>>>> can silence the soft lockup detector. Do you think that is acceptable?
>>>
>>> It is certainly a way to go. Not the best one at that though. Maybe we
>>> need different solution for the global and for the memcg OOMs. During
>>> the global OOM we rarely care about latency as the whole system is
>>> likely to struggle. Memcg ooms are much more likely. Having that many
>>> tasks in a memcg certainly requires a further partitioning so if
>>> configured properly the OOM latency shouldn't be visible much. But I am
>>> wondering whether the cgroup task iteration could use cond_resched while
>>> the global one would touch_nmi_watchdog for every N iterations. I might
>>> be missing something but I do not see any locking required outside of
>>> css_task_iter_*.
>>
>> Do you mean like that:
> 
> I've had something like this (untested) in mind
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..37abc94abd2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1167,10 +1167,14 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  	for_each_mem_cgroup_tree(iter, memcg) {
>  		struct css_task_iter it;
>  		struct task_struct *task;
> +		unsigned int i = 0
>  
>  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> -		while (!ret && (task = css_task_iter_next(&it)))
> +		while (!ret && (task = css_task_iter_next(&it))) {
>  			ret = fn(task, arg);
> +			if (++i % 1000)
> +				cond_resched();
> +		}
>  		css_task_iter_end(&it);
>  		if (ret) {
>  			mem_cgroup_iter_break(memcg, iter);

Thank you for your patience.

I had this idea in mind as well.
However, there are two considerations that led me to reconsider it:

1. I wasn't convinced about how we should call cond_resched every N
iterations. Should it be 1000 or 10000?
2. I don't think all callers of mem_cgroup_scan_tasks need cond_resched.
Only fn is expensive (e.g., dump_tasks), and it needs cond_resched. At
least, I have not encountered any other issue except except when fn is
dump_tasks.

If you think this is acceptable, I will test and update the patch.

Best regards,
Ridong


