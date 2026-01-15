Return-Path: <cgroups+bounces-13228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF4D21E95
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F47303D147
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 00:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F841DD0EF;
	Thu, 15 Jan 2026 00:52:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE702B665;
	Thu, 15 Jan 2026 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438378; cv=none; b=GvfPGktrTig1To6iJLAAyByloyV4owN4iWaEUkBtS88BXHf4ohZ/vXP3GILWZPcr0DKroEH95YXIUsj0FMuVBraz5x5ZVUu0I2Hbeyj1oWvQvQMmSY0YB8GSO2gUSpksaIK7W9CTrNLQPY0Yypd/qDCVAqMXF6jKt6REAoVKa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438378; c=relaxed/simple;
	bh=UJNw2NzEqJ8GMhmjLvD9IaXdESoyf1TzIcGWll0En7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BD1QB0MxnQqrOJMVaJvaXvoJrWSjpNRvOSRhMDjc7T3dFvxDrCv7Xlw0chdmx7p2UvU5lZ44u7yF+sOqk86tY2Gl+r6RM1Wkzi9rPxELI0cW8s9xSlPurHsUDHFfEFCfD9F+VydCK0mJM1AqnoHHJSZ5QzAQ1Gt4If2tG+vcaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ds4Fy3SRlzYQv21;
	Thu, 15 Jan 2026 08:52:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 08A7F40539;
	Thu, 15 Jan 2026 08:52:53 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH9vZjOmhpd_JZDw--.10605S2;
	Thu, 15 Jan 2026 08:52:52 +0800 (CST)
Message-ID: <2e8bf48a-b819-40b9-bb9b-f6ac6672059a@huaweicloud.com>
Date: Thu, 15 Jan 2026 08:52:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cgroup: use nodes_and() output where appropriate
To: Waiman Long <llong@redhat.com>, Yury Norov <ynorov@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>, Byungchul Park <byungchul@sk.com>,
 David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>,
 Johannes Weiner <hannes@cmpxchg.org>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Brost <matthew.brost@intel.com>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ying Huang <ying.huang@linux.alibaba.com>,
 Zi Yan <ziy@nvidia.com>, cgroups@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-4-ynorov@nvidia.com>
 <51675d7c-5c9d-4596-8e5c-692c90b79e06@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <51675d7c-5c9d-4596-8e5c-692c90b79e06@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH9vZjOmhpd_JZDw--.10605S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45KFyxArWkKFykGw4xCrg_yoW8tFy8pF
	1kCry7Gay5AF1xGrWxXFyDW3s5Ja18Ja1UJr1UAF93JFnrJr10vF1UX34YgrWDCrW8Gr15
	Jrn0vw1IvFy3Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/1/15 6:33, Waiman Long wrote:
> On 1/14/26 12:22 PM, Yury Norov wrote:
>> Now that nodes_and() returns true if the result nodemask is not empty,
>> drop useless nodes_intersects() in guarantee_online_mems() and
>> nodes_empty() in update_nodemasks_hier(), which both are O(N).
>>
>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>> ---
>>   kernel/cgroup/cpuset.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3e8cc34d8d50..e962efbb300d 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -456,9 +456,8 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>>    */
>>   static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>>   {
>> -    while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
>> +    while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
>>           cs = parent_cs(cs);
>> -    nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
>>   }
>>     /**
>> @@ -2862,13 +2861,13 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>>       cpuset_for_each_descendant_pre(cp, pos_css, cs) {
>>           struct cpuset *parent = parent_cs(cp);
>>   -        nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
>> +        bool has_mems = nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
>>             /*
>>            * If it becomes empty, inherit the effective mask of the
>>            * parent, which is guaranteed to have some MEMs.
>>            */
>> -        if (is_in_v2_mode() && nodes_empty(*new_mems))
>> +        if (is_in_v2_mode() && !has_mems)
>>               *new_mems = parent->effective_mems;
>>             /* Skip the whole subtree if the nodemask remains the same. */
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


