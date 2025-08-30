Return-Path: <cgroups+bounces-9502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56732B3C6E8
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 03:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C49C1CC1C2A
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCCE22D4DD;
	Sat, 30 Aug 2025 01:11:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5119C54E;
	Sat, 30 Aug 2025 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516287; cv=none; b=kRy1B6Gv+v6B1d7Q14cnGLt/jSuBpd3gFyhprrv+uEPenDtNmzL13Pfwfp+9Y9btwW6rS/dVMHAfwNa/vboQSApg9CtVZgNWrK820LGTpiTsoii2mcnHoFLadheAKSIXHxI/IwSF5E+x0H0MGzgse4keJ0Uj/A1XvbjGbNhJojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516287; c=relaxed/simple;
	bh=vFjj3L6wA+nXkGTYuPC4TRsAiyRJ5Ctl9GIHKUeV4HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqb5GdEw7gj/CxBKZv2filONNd37YlRJNlQE2KPNYOImLyBvgXInQ+9CNe6je8AR/eZo0jEzJsUQL5xGDN+0W1kkWONZgARS7Eyj6Sl+NyjJapodLI9e8H9RxRRCnOq6Ei7Oo65NQ+H9SSwglrwk/WhJQ7WyTE1JOAYKtqAOkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cDHCG0WchzKHMw4;
	Sat, 30 Aug 2025 09:11:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C92671A0CE6;
	Sat, 30 Aug 2025 09:11:21 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAXYo64T7JoMSoGAw--.64461S2;
	Sat, 30 Aug 2025 09:11:21 +0800 (CST)
Message-ID: <4e662ffa-acc6-448c-bfc7-7b3d16b40341@huaweicloud.com>
Date: Sat, 30 Aug 2025 09:11:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/11] cpuset: move the root cpuset write check
 earlier
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-2-chenridong@huaweicloud.com>
 <e02b9c35-c51e-45c0-a2ca-3d1f0492af23@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <e02b9c35-c51e-45c0-a2ca-3d1f0492af23@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYo64T7JoMSoGAw--.64461S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48AF1xAF1DGw4xKFyxAFb_yoW5Cw4xpF
	ykC345KrW5WF18Cw1DJ3yUX345tw18t3WDJr1Yqa4rAF42yF1jvF1UX3s0gFyUCr4rGr1U
	JFsIgrW2vF9rArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/8/30 3:21, Waiman Long wrote:
> On 8/28/25 8:56 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The 'cpus' or 'mems' lists of the top_cpuset cannot be modified.
>> This check can be moved before acquiring any locks as a common code
>> block to improve efficiency and maintainability.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index a78ccd11ce9b..7e6a40e361ea 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -337,6 +337,11 @@ static inline bool cpuset_v2(void)
>>           cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
>>   }
>>   +static inline bool cpuset_is_root(struct cpuset *cs)
>> +{
>> +    return (cs == &top_cpuset);
>> +}
>> +
>>   /*
>>    * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>>    * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
>> @@ -2334,10 +2339,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>       bool force = false;
>>       int old_prs = cs->partition_root_state;
>>   -    /* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
>> -    if (cs == &top_cpuset)
>> -        return -EACCES;
>> -
>>       /*
>>        * An empty cpus_allowed is ok only if the cpuset has no tasks.
>>        * Since cpulist_parse() fails on an empty mask, we special case
>> @@ -2783,15 +2784,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>>   {
>>       int retval;
>>   -    /*
>> -     * top_cpuset.mems_allowed tracks node_stats[N_MEMORY];
>> -     * it's read-only
>> -     */
>> -    if (cs == &top_cpuset) {
>> -        retval = -EACCES;
>> -        goto done;
>> -    }
>> -
>>       /*
>>        * An empty mems_allowed is ok iff there are no tasks in the cpuset.
>>        * Since nodelist_parse() fails on an empty mask, we special case
>> @@ -3257,6 +3249,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>       struct cpuset *trialcs;
>>       int retval = -ENODEV;
>>   +    /* root is read-only */
>> +    if (cpuset_is_root(cs))
>> +        return -EACCES;
>> +
>>       buf = strstrip(buf);
>>       cpuset_full_lock();
>>       if (!is_cpuset_online(cs))
> 
> The (cs == &top_cpuset) check is pretty straight forward. So if the cpuset_is_root() helper is only
> used once, I don't think we need a new helper here.
> 
> Cheers,
> Longman

Thanks you Longman,

There are several places where cs == &top_cpuset could be replaced with the helper function
cpuset_is_root. However, since this series focuses on refactoring the CPU settings, I did not make
those replacements. Would it be acceptable to submit a separate patch that introduces this helper?

-- 
Best regards,
Ridong


