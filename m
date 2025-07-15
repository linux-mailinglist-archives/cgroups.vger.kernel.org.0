Return-Path: <cgroups+bounces-8736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F6B04DD5
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 04:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416EA189D178
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043322C374E;
	Tue, 15 Jul 2025 02:29:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66563A927;
	Tue, 15 Jul 2025 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546571; cv=none; b=n2s6j7dlORrw49DYst2caXDdzB7r1C5bVoiXTIdyVQR0jOJ5TvlJ0pYDMi5OUtN5uD7DgSQtyJn7N7GfaZxZs1FvJLCPpU3a4A3mYQUU3QANkIB0jeUb0eSqePWzF9BunDL6s5/8KJEetU2hmZfhyB5HFxLLwK9N5vCE4lMSE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546571; c=relaxed/simple;
	bh=fEysLKM7EuV4EVLDkY7ddvkFabw3bTMPghrbJPwPVv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3I3q1XMkwtbLuBCTKz2T/He/7P8wic+EtUWwKml2G1z2umeyujhSW7Inep1lIbQBkb7yCfM8YUIFsfiyR41TSdoZbAKFUCKeR+pZBEgyxLGYvhxNBaywe14/nbmiv/qhnBE5cPIYijtYBBh/ydw9BEH9CHhUCSRnZECkh6WDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bh36S2S75zYQvFw;
	Tue, 15 Jul 2025 10:29:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1EB171A0CE6;
	Tue, 15 Jul 2025 10:29:19 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDXSLT9vHVom_0xAQ--.56845S2;
	Tue, 15 Jul 2025 10:29:18 +0800 (CST)
Message-ID: <386c58cb-2330-4627-90c5-9f548f2a9a3e@huaweicloud.com>
Date: Tue, 15 Jul 2025 10:29:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
 <20250714084109.GK905792@noisy.programming.kicks-ass.net>
 <090bd627-95dc-49ef-a4f6-d78d8f6d6cec@huaweicloud.com>
 <20250714115915.GU905792@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250714115915.GU905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXSLT9vHVom_0xAQ--.56845S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7Cr1xCF4UWryDJFy7Jrb_yoW8Zr4kpa
	ykta4jka15XF1jv3sFvw4qqryFqws2kFnxG3Z5t3y5tF9FkF10vw4Dta4YvrySvws5uF12
	qF4DWFW7WF1qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/14 19:59, Peter Zijlstra wrote:
> On Mon, Jul 14, 2025 at 07:30:39PM +0800, Chen Ridong wrote:
> 
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index f74d04429a29..5401adbdffa6 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>>>>  	if (cs != &top_cpuset)
>>>>  		guarantee_active_cpus(task, cpus_attach);
>>>>  	else
>>>> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
>>>> +		cpumask_andnot(cpus_attach, cpu_active_mask,
>>>>  			       subpartitions_cpus);
>>>
>>> This breaks things. Any task mask must be a subset of
>>> task_cpu_possible_mask() at all times. It might not be able to run
>>> outside of that mask.
>>
>> Hi Peter,
>>
>> Thanks for your feedback. I'm afraid I don't fully understand what you
>> mean by "breaks things".  Could you please explain in more detail?
>>
>> To clarify my current understanding: this patch simply changes the
>> cpus_attach initialization from task_cpu_possible_mask(task) to
>> cpu_active_mask. The intention is that when CPUs are offlined and
>> tasks get migrated to root cpuset, we shouldn't try to migrate tasks
>> to offline CPUs. And since cpu_active_mask is a subset of
>> cpu_possible_mask, I thought this would be safe. Did I miss anything?
> 
> task_cpu_possible_mask() is the mask a task *MUST* stay inside of.
> 
> Specifically, this was introduced for ARMv9 where some CPUs drop the
> capability to run ARM32 instructions. Trying to schedule an ARM32 task
> on a CPU that does not support that instruction set is an immediate and
> fatal fail.
> 
> Your change results in in something akin to:
> 
>   set_cpus_allowed_task(task, cpu_active_mask & ~subpartition_cpus);
> 
> Which does not honor the task_cpu_possible_mask() constraint.

Thanks for your patience. See now.

Best regards,
Ridong


