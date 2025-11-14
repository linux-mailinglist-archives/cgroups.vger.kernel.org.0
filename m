Return-Path: <cgroups+bounces-11943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CDC5ADBD
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 01:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F7D4E5312
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E821CC55;
	Fri, 14 Nov 2025 00:54:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75419E819;
	Fri, 14 Nov 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081694; cv=none; b=UcpZeH+eAbvm/wF/H2llxbO4CHHLhDPG/QYAa8x2UCdpak7PswzcE/eUe8dpWmUXAoxAbO2EqAVWhMzGmhFIa4OajxBMs8azuoXy3XjnZVIvfG6+mU8Btvnkj/Hq/N5oQPMFiGer7aT6ZCS52hoKbh3lNWJFL8x4n0j4NHxXsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081694; c=relaxed/simple;
	bh=ihGiwPmkqRHByXqArUfad0o0gwbbYhkS9NN+WaPgqd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cifcQvXLvsdUaNZIRs4Sad6dQG/Msvz6Vl1cGa4vtgI3pej8VgGcDjnQLaTbNmkEtAPXAAuOYvGgXCSxsylABaa0xvqvWPRL9xyUh53Ko9gVHeIgDn5flNCkcYaEjArtQaXTyYAOp0YhsHy44Od+CRfcwFRFMnWOnjjQgZ45utM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6zDW0fWnzYQtdq;
	Fri, 14 Nov 2025 08:54:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0F4EA1A0879;
	Fri, 14 Nov 2025 08:54:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCH5HrZfRZpV1amAg--.32703S2;
	Fri, 14 Nov 2025 08:54:49 +0800 (CST)
Message-ID: <b0e817cc-320a-40e6-b405-cb4b2e85a8aa@huaweicloud.com>
Date: Fri, 14 Nov 2025 08:54:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] cpuset: Treat cpusets in attaching as populated
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251113132833.1036960-1-chenridong@huaweicloud.com>
 <b161acba-2e0b-4d00-9bf1-3930b307653d@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <b161acba-2e0b-4d00-9bf1-3930b307653d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH5HrZfRZpV1amAg--.32703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45Wr1fGF4rGryDZw4Dtwb_yoWrKrWxpF
	ykGFW7JrWUGwn5Cw4UGa4UXFy5tw1kJ3WDJr1rJF1rJr17Jr1j9r1UXr90gr15Jr48Cr1U
	Jr1DXrnru3ZrJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 22:14, Waiman Long wrote:
> On 11/13/25 8:28 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Currently, the check for whether a partition is populated does not
>> account for tasks in the cpuset of attaching. This is a corner case
>> that can leave a task stuck in a partition with no effective CPUs.
>>
>> The race condition occurs as follows:
>>
>> cpu0                cpu1
>>                 //cpuset A  with cpu N
>> migrate task p to A
>> cpuset_can_attach
>> // with effective cpus
>> // check ok
>>
>> // cpuset_mutex is not held    // clear cpuset.cpus.exclusive
>>                 // making effective cpus empty
>>                 update_exclusive_cpumask
>>                 // tasks_nocpu_error check ok
>>                 // empty effective cpus, partition valid
>> cpuset_attach
>> ...
>> // task p stays in A, with non-effective cpus.
>>
>> To fix this issue, this patch introduces cs_is_populated, which considers
>> tasks in the attaching cpuset. This new helper is used in validate_change
>> and partition_is_populated.
>>
>> Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index daf813386260..bd273b1e09b0 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -356,6 +356,15 @@ static inline bool is_in_v2_mode(void)
>>             (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>>   }
>>   +static inline bool cs_is_populated(struct cpuset *cs)
> Could you name it as "cpuset_is_populated()" as it is a cpuset specific version of
> cgroup_is_populated()?

Sure, will update.

>> +{
>> +    lockdep_assert_held(&cpuset_mutex);
>> +
>> +    /* Cpusets in the process of attaching should be considered as populated */
>> +    return cgroup_is_populated(cs->css.cgroup) ||
>> +        cs->attach_in_progress;
>> +}
>> +
>>   /**
>>    * partition_is_populated - check if partition has tasks
>>    * @cs: partition root to be checked
>> @@ -373,19 +382,25 @@ static inline bool is_in_v2_mode(void)
>>   static inline bool partition_is_populated(struct cpuset *cs,
>>                         struct cpuset *excluded_child)
>>   {
>> -    struct cgroup_subsys_state *css;
>> -    struct cpuset *child;
>> +    struct cpuset *cp;
>> +    struct cgroup_subsys_state *pos_css;
>>   -    if (cs->css.cgroup->nr_populated_csets)
>> +    /*
>> +     * We cannot call cs_is_populated(cs) directly, as
>> +     * nr_populated_domain_children may include populated
>> +     * csets from descendants that are partitions.
>> +     */
>> +    if (cs->css.cgroup->nr_populated_csets ||
>> +        cs->attach_in_progress)
>>           return true;
>>         rcu_read_lock();
>> -    cpuset_for_each_child(child, css, cs) {
>> -        if (child == excluded_child)
>> +    cpuset_for_each_descendant_pre(cp, pos_css, cs) {
>> +        if (cp == cs || cp == excluded_child)
>>               continue;
>> -        if (is_partition_valid(child))
>> +        if (is_partition_valid(cp))
> 
> You should add " pos_css = css_rightmost_descendant(pos_css);" to skip the whole subtree.
> 
> Cheers,
> Longman
> 

Oh... you're right, I should have caught this.

Thank you so much, Longman!

> 
>>               continue;
>> -        if (cgroup_is_populated(child->css.cgroup)) {
>> +        if (cs_is_populated(cp)) {
>>               rcu_read_unlock();
>>               return true;
>>           }
>> @@ -670,7 +685,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>        * be changed to have empty cpus_allowed or mems_allowed.
>>        */
>>       ret = -ENOSPC;
>> -    if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
>> +    if (cs_is_populated(cur)) {
>>           if (!cpumask_empty(cur->cpus_allowed) &&
>>               cpumask_empty(trial->cpus_allowed))
>>               goto out;
> 

-- 
Best regards,
Ridong


