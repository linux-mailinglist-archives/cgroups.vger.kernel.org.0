Return-Path: <cgroups+bounces-10157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEFB58FEA
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFF93208D1
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B3281526;
	Tue, 16 Sep 2025 08:02:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A035950;
	Tue, 16 Sep 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009746; cv=none; b=upO7xZ0O2eiXEbKBmwvrvvuNqMqx8bauZTirKBr/CmyZf4vcjuT5fRR6it9WmE1fiJ+DLyQVDYj6CP358pzFIkT/tWsQbPVaWoQblVA3mmErfRa7ojXijaD2NmQefSb3JUOhLYgNJGmjBeDAfJTpxhEDlHbTnz9KXDE64dQHGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009746; c=relaxed/simple;
	bh=NDowxoHyjvn7mhhgjiaojNZOrdeAy6ObkXIbQtgn9G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+XbZbk+Lff5MUDJUkxj1cjWGqdba1fkub1aV14SlCGVmiq7PU91ohmBp0W7Ot7rLNeSkEYsxOthJffdPAQXspmo9agnkwpOv+awE0/7tiNVSjgzpTMxxnxLxCqZvbTC9zRU14RVWg03bx3QQe0X6C32eYm2zTew6+rXaAuNuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQvWf6cb9zYQtG4;
	Tue, 16 Sep 2025 16:02:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 841871A1ABE;
	Tue, 16 Sep 2025 16:02:21 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgBHko6NGcloY_K7Cg--.29687S2;
	Tue, 16 Sep 2025 16:02:21 +0800 (CST)
Message-ID: <a7296ecc-7d29-41aa-abc1-eec0900ce351@huaweicloud.com>
Date: Tue, 16 Sep 2025 16:02:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 11/11] cpuset: use partition_cpus_change for
 setting exclusive cpus
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-12-chenridong@huaweicloud.com>
 <7937af93-9652-4032-93c9-7d7d8571c52b@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <7937af93-9652-4032-93c9-7d7d8571c52b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHko6NGcloY_K7Cg--.29687S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45tr4UXw48uFyrtF15CFg_yoW5KF48pF
	18JrW7JrWUJw18Gw1UXr1DXryUJwsrJ3WDJr1DJF1rJF17AF12qr1UXw1vgr4UJw4xJr18
	JF1UJrnrZFy5ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/16 4:05, Waiman Long wrote:
> On 9/8/25 11:32 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Previous patches have refactored partition_cpus_change. Now replace the
>> exclusive cpus setting logic with this helper function.
> Nit: The term "refactor" usually mean updating the code of an existing function, sometimes
> extracting out code into new helper functions. In your case, partition_cpus_change() is a new helper
> function. This is also an issue in some of the earlier patches. I would prefer using phrase like "A
> previous patch has introduced a new helper function partition_cpus_change()"

Thank you, will update.

>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 29 ++---------------------------
>>   1 file changed, 2 insertions(+), 27 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 785a2740b0ea..6a44dfabe9dd 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2562,8 +2562,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>   {
>>       int retval;
>>       struct tmpmasks tmp;
>> -    struct cpuset *parent = parent_cs(cs);
>> -    bool invalidate = false;
>>       bool force = false;
>>       int old_prs = cs->partition_root_state;
>>   @@ -2595,32 +2593,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset
>> *trialcs,
>>       if (alloc_tmpmasks(&tmp))
>>           return -ENOMEM;
>>   -    if (old_prs) {
>> -        if (cpumask_empty(trialcs->effective_xcpus)) {
>> -            invalidate = true;
>> -            cs->prs_err = PERR_INVCPUS;
>> -        } else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
>> -            invalidate = true;
>> -            cs->prs_err = PERR_HKEEPING;
>> -        } else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
>> -            invalidate = true;
>> -            cs->prs_err = PERR_NOCPUS;
>> -        }
>> +    trialcs->prs_err = PERR_NONE;
>> +    partition_cpus_change(cs, trialcs, &tmp);
>>   -        if (is_remote_partition(cs)) {
>> -            if (invalidate)
>> -                remote_partition_disable(cs, &tmp);
>> -            else
>> -                remote_cpus_update(cs, trialcs->exclusive_cpus,
>> -                           trialcs->effective_xcpus, &tmp);
>> -        } else if (invalidate) {
>> -            update_parent_effective_cpumask(cs, partcmd_invalidate,
>> -                            NULL, &tmp);
>> -        } else {
>> -            update_parent_effective_cpumask(cs, partcmd_update,
>> -                        trialcs->effective_xcpus, &tmp);
>> -        }
>> -    }
>>       spin_lock_irq(&callback_lock);
>>       cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
>>       cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
> Reviewed-by: Waiman Long <longman@redhat.com>

-- 
Best regards,
Ridong


