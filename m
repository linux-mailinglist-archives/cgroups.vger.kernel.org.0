Return-Path: <cgroups+bounces-11484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A085DC29F2F
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134601888EDD
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CC2877F1;
	Mon,  3 Nov 2025 03:26:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D6F50F;
	Mon,  3 Nov 2025 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140415; cv=none; b=MhxidDVmjxIbk1g3lJSm44mvvYW60SKWIOaf150Ol+Yk5vxgP244lk5lVVH+1oPLd2ANZaDZBbOolHLDSjDlrbpixlrvrVXamrOajQ24JyFQXOdEEQFC0r3UOqgScqVHErsB8ediR0RMWI7IwMoFK+Fngak9xHDjU/afb+o1v78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140415; c=relaxed/simple;
	bh=86+IdC1DpWQkV5Q7uOtRz8SuIEBBom7reINTxCmVlng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU05oA0Uxv3EjPFvNqQSnEFAUmE+ozpG+57vOamf3WiOosQy8an+eBVmeopijgo9xFeF5+aFL+ll48Cc87+ipDZz3V6KqkS6o6WZFzyKYJ8K9mdjc0ro3RUiWTFfVK1jJsOpG0wyOe0r665pexXXYxgTLY1H/1mtwgaBP+Xfaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0H7K5RcmzYQtsH;
	Mon,  3 Nov 2025 11:26:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7B2CF1A07C0;
	Mon,  3 Nov 2025 11:26:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgA3qk35IAhpNvL8CQ--.48937S2;
	Mon, 03 Nov 2025 11:26:50 +0800 (CST)
Message-ID: <8747f1ef-1c88-4cff-acf2-51e54f778760@huaweicloud.com>
Date: Mon, 3 Nov 2025 11:26:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
 <8da89966-b891-4088-9699-e82863e52415@huaweicloud.com>
 <b34dc762-5a90-428b-815f-0c2b351078bf@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <b34dc762-5a90-428b-815f-0c2b351078bf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3qk35IAhpNvL8CQ--.48937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1rtF48Zr4ftryUJF4fZrb_yoW5tF18pF
	y8KFy3CrWkKF1fC34aqF1kWryrKwn7J3WUGrnxJFykXrnxtFnFgry2vw4Y9F4kWrW8WryU
	ZrWq9rZ3ua4jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/3 11:12, Waiman Long wrote:
> On 11/2/25 9:55 PM, Chen Ridong wrote:
>>
>> On 2025/11/3 9:34, Waiman Long wrote:
>>> From: Gabriele Monaco <gmonaco@redhat.com>
>>>
>>> Currently the user can set up isolated cpus via cpuset and nohz_full in
>>> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
>>> domain isolated nor nohz full). This can be a problem for other
>>> subsystems (e.g. the timer wheel imgration).
>>>
>>> Prevent this configuration by blocking any assignation that would cause
>>> the union of domain isolated cpus and nohz_full to covers all CPUs.
>>>
>>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>> Reviewed-by: Waiman Long <longman@redhat.com>
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 66 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index da770dac955e..d6d459c95d82 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask
>>> *xcpus
>>>           cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>>>   }
>>>   +/*
>>> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>>> + * @prs: new or old partition_root_state
>>> + * @parent: parent cpuset
>>> + * Return: true if isolated_cpus needs modification, false otherwise
>>> + */
>>> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>>> +{
>>> +    if (!parent)
>>> +        parent = &top_cpuset;
>>> +    return prs != parent->partition_root_state;
>>> +}
>>> +
>> Hi Longman,
>>
>> I am confused about this function.
>>
>> Why do we need to compare the partition_root_state (prs) with the parent's partition_root_state?
>>
>> For example, when a local partition is assigned to a member, I don't think the isolated cpumasks
>> should be updated in this case.
>>
>> In my understanding, the isolated CPUs should only be updated when an isolated partition is being
>> disabled or enabled. I was thinking of something like this:
>>
>> bool isolated_cpus_should_update(int new_prs, int old_prs)
>> {
>>      if (new_prs == old_prs)
>>          return false;
>>      if (old_prs == 2 || new_prs == 2)
>>          return true;
>>      return false;
>> }
>>
>> I would really appreciate it if you could provide some further explanation on this.
> 
> This function should only be called when both the current and the parent (top_cpuset for remote) are
> valid partition roots. For both local and remote partition, the child cpuset takes CPUs from the
> parent. The list of isolated CPUs will only change if parent and child cpusets have different
> partition root types. If parent is an isolated partition, taking CPUs from parent to form another
> isolated partition will not change isolated_cpus. The same is true if both parent and child are root.
> 
> You are right that this check may not be obvious for a casual observer. I can add some more comments
> to clarify that.
> 

Thank you for your explanation.

Yes, this can be a common scenario.

More comments will be helpful.

-- 
Best regards,
Ridong


