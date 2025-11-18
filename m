Return-Path: <cgroups+bounces-12050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A107C66AA8
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 01:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8165D4E247C
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262621ABC1;
	Tue, 18 Nov 2025 00:31:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D8134CF;
	Tue, 18 Nov 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425880; cv=none; b=a9AEqprCrAsOCmSnu+yojIe5Cgxt3Z43jnfm291VNMFPXaF7c99+DPoM7Tm8kkoI82M6hsQnsg9tn+oEhPFthjMYhDa9fnrHDcRc+JhWV02kiFs/wexWIztGDksEFrq6/gr5k2sqOlOUXZ80qWVZwvboCFYKLD0JEpuIIqnXK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425880; c=relaxed/simple;
	bh=47RJ5yobGMsyb96XZ5FBNvaWHrhCWUqSg4uJMN7Yst4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4DK6wzvR9b7VmlgRf8JFzEtLUXxwXQNwRWsI8m9X8Ou81Uf4rTp3UaSQd4Q3QbFlyEj8aaSSSmjo0QmufUJHOMj3uYts888n/InLsGtK1AoOB01noUoxxRwMFzcNhKe7pz/wtLDgOxFWK/URvrrLDBjZxSsGhFn8cHQ+SYHBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d9QWJ3PWMzYQtqY;
	Tue, 18 Nov 2025 08:30:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1DE611A09D8;
	Tue, 18 Nov 2025 08:31:14 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB3_kdQvhtpyVduBA--.50976S2;
	Tue, 18 Nov 2025 08:31:13 +0800 (CST)
Message-ID: <634e0352-f3c1-4f75-9afb-4ba96a4bddb1@huaweicloud.com>
Date: Tue, 18 Nov 2025 08:31:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] cpuset: Treat cpusets in attaching as populated
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251114020847.1040546-1-chenridong@huaweicloud.com>
 <145d57ba-ed38-40b6-a495-57691cb41b63@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <145d57ba-ed38-40b6-a495-57691cb41b63@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3_kdQvhtpyVduBA--.50976S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17Gw1UAw4fuFWUuF18uFg_yoWrtry5pF
	ykGFWUJrWUGwn5Cw4UJa4UXFy5tw1kJ3WDJr1rJF1rJr17Jr1j9r1UXF90gr1UJr48Gr1U
	Jr1DXrnru3ZrJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/18 4:50, Waiman Long wrote:
> On 11/13/25 9:08 PM, Chen Ridong wrote:
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
>>   kernel/cgroup/cpuset.c | 35 +++++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index daf813386260..8bf7c38ba320 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -356,6 +356,15 @@ static inline bool is_in_v2_mode(void)
>>             (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>>   }
>>   +static inline bool cpuset_is_populated(struct cpuset *cs)
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
>> @@ -373,19 +382,29 @@ static inline bool is_in_v2_mode(void)
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
>> +
>> +        if (is_partition_valid(cp)) {
>> +            pos_css = css_rightmost_descendant(pos_css);
>>               continue;
>> -        if (cgroup_is_populated(child->css.cgroup)) {
>> +        }
>> +
>> +        if (cpuset_is_populated(cp)) {
>>               rcu_read_unlock();
>>               return true;
>>           }
>> @@ -670,7 +689,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>        * be changed to have empty cpus_allowed or mems_allowed.
>>        */
>>       ret = -ENOSPC;
>> -    if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
>> +    if (cpuset_is_populated(cur)) {
>>           if (!cpumask_empty(cur->cpus_allowed) &&
>>               cpumask_empty(trial->cpus_allowed))
>>               goto out;
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks.

-- 
Best regards,
Ridong


