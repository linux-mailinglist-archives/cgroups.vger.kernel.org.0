Return-Path: <cgroups+bounces-9109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA74B23D5D
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 02:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C74F1894C43
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3E41C72;
	Wed, 13 Aug 2025 00:54:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA8F50F;
	Wed, 13 Aug 2025 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046476; cv=none; b=pOuSBCiYEevLB7eTBkyzG7wRvoehIBdDdO+0DZObsKHxknhpfXS1LHZwkwDWa0lgxG6LCGSlhNRNQUwg4Baz33Hl/GOng+sD0xOAYEYvEhYfup1LEKbnmAoWk+VP/vA8HixJbi/ukxjPV7ElBDjXidoakMhVijbJd75SpUN5b8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046476; c=relaxed/simple;
	bh=YyKlomfw0E3fDy8WWGYhYNZHc3Vf5ss/Lk0fAYYVbRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBab1LYFZvm7Qqz2kOacMdCq6hJjjVUoss/vdxxcRUkd4o/92EWzr7eeSuF+NLh6p0JC1GLYcTiJGqPGt0eEbFl9q0LIFGx9OrI5gJp2qlxyCFtBx3SJ5STwDoL02p0XfoJZcIj5QkhLdcatlxsomSbaf1ZGWT9bZUjkx8FbTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1qdd5KyrzKHMnd;
	Wed, 13 Aug 2025 08:54:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 009B91A0A22;
	Wed, 13 Aug 2025 08:54:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXYBFC4pto_F_4DQ--.14246S2;
	Wed, 13 Aug 2025 08:54:28 +0800 (CST)
Message-ID: <775ef75a-b796-4171-b208-df110a73c558@huaweicloud.com>
Date: Wed, 13 Aug 2025 08:54:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/4] cpuset: remove redundant CS_ONLINE flag
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-2-chenridong@huaweicloud.com>
 <db5fdf29-43d9-4e38-a5a8-02cd711b892a@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <db5fdf29-43d9-4e38-a5a8-02cd711b892a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXYBFC4pto_F_4DQ--.14246S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45ury7Jw4ruFWDJw48Crg_yoWrur45pF
	1kCFyUA398Ca4xGayDt3yjga4rKwsIy3WUGr1kKa4rAF12yFyj9r10q34YgFyUAFW8Cryj
	yF4SvrWa9FnrJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/8/12 22:44, Waiman Long wrote:
> On 8/8/25 5:25 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
>> cpuset subsystem. Currently, the flag setting sequence is as follows:
>>
>> 1. cpuset_css_online() sets CS_ONLINE
>> 2. css->flags gets CSS_ONLINE set
>> ...
>> 3. cgroup->kill_css sets CSS_DYING
>> 4. cpuset_css_offline() clears CS_ONLINE
>> 5. css->flags clears CSS_ONLINE
>>
>> The is_cpuset_online() check currently occurs between steps 1 and 3.
>> However, it would be equally safe to perform this check between steps 2
>> and 3, as CSS_ONLINE provides the same synchronization guarantee as
>> CS_ONLINE.
>>
>> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
>> synchronization benefits, we can safely remove it to simplify the code.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   include/linux/cgroup.h          | 5 +++++
>>   kernel/cgroup/cpuset-internal.h | 3 +--
>>   kernel/cgroup/cpuset.c          | 4 +---
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index b18fb5fcb38e..ae73dbb19165 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>>       return css->flags & CSS_DYING;
>>   }
>>   +static inline bool css_is_online(struct cgroup_subsys_state *css)
>> +{
>> +    return css->flags & CSS_ONLINE;
>> +}
>> +
>>   static inline bool css_is_self(struct cgroup_subsys_state *css)
>>   {
>>       if (css == &css->cgroup->self) {
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 383963e28ac6..75b3aef39231 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -38,7 +38,6 @@ enum prs_errcode {
>>     /* bits in struct cpuset flags field */
>>   typedef enum {
>> -    CS_ONLINE,
>>       CS_CPU_EXCLUSIVE,
>>       CS_MEM_EXCLUSIVE,
>>       CS_MEM_HARDWALL,
>> @@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>>   /* convenient tests for these bits */
>>   static inline bool is_cpuset_online(struct cpuset *cs)
>>   {
>> -    return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
>> +    return css_is_online(&cs->css) && !css_is_dying(&cs->css);
>>   }
>>     static inline int is_cpu_exclusive(const struct cpuset *cs)
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index f74d04429a29..cf7cd2255265 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>>    * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
>>    */
>>   static struct cpuset top_cpuset = {
>> -    .flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
>> +    .flags = BIT(CS_CPU_EXCLUSIVE) |
>>            BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>       .partition_root_state = PRS_ROOT,
>>       .relax_domain_level = -1,
> 
> top_cpuset.css is not initialized like the one in the children. If you modify is_cpuset_online() to
> test the css.flags, you will probably need to set the CSS_ONLINE flag in top_cpuset.css.flags. I do
> doubt that we will apply the is_cpuset_online() test on top_cpuset. To be consistent, we should
> support that.
> 
> BTW, other statically allocated css'es in the cgroup root may have similar problem. If you make the
> css_is_online() helper available to all other controllers, you will have to document that limitation.
> 
> Cheers,
> Longman

Hi, Longman, thank you for your response.

If I understand correctly, the CSS_ONLINE flag should be set in top_cpuset.css during the following
process:

css_create
  css = ss->css_alloc(parent_css);  // cgroup root is static, unlike children
  online_css(css);
     ret = ss->css_online(css);     // css root may differ from children
     css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css

I think css online must be successful, and it's CSS_ONLINE flag must be set. Do I missing anything?

Best regards,
Ridong


