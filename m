Return-Path: <cgroups+bounces-11916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3307C55EF5
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31913AE628
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DBF3218A6;
	Thu, 13 Nov 2025 06:33:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FA248F78;
	Thu, 13 Nov 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015636; cv=none; b=sqfXVpstz1uum559pKpZrJFCOwBH249gPO//htvlaExtW8XZqH2+AlVPSUFMmRx7MZ3zz3xMbWaipfXIP1dt8V6qzWcU+0Bp9Z5NDePqh8DTYDKeemKM7HAhvBjF8QZCaBskAqUu82BBDd4DChRceOebhPM7Si0am3wmsTecJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015636; c=relaxed/simple;
	bh=iSqld2kQTeDHTFqIiQOSFYISAvx7H/oD8ySXVslWgQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUOZRwNSPhO34/sPypZM8Q+21QOyjv6MxQFk85V7TUxm4PTOeUapsRy8uJF3Rx4GobJIjEaORZg3VykamhU2Cx6zPgM8Vv/b2hHffe3c/Wq4Re4AbOujjNLoctyhE+osa88XtYwNVJTbJQpp1AHx2CmC5IKhde0Ln5hp1buNWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6VpM4gkXzKHM0R;
	Thu, 13 Nov 2025 14:33:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 57F241A19D2;
	Thu, 13 Nov 2025 14:33:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgAHQUrNexVpetdGAg--.48893S2;
	Thu, 13 Nov 2025 14:33:50 +0800 (CST)
Message-ID: <90eb21c8-e6d8-4b65-a126-8a822d48afdf@huaweicloud.com>
Date: Thu, 13 Nov 2025 14:33:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/22] cpuset: introduce local_partition_update()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-14-chenridong@huaweicloud.com>
 <3b3b49df-c215-4f7d-b2c6-628eac823134@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3b3b49df-c215-4f7d-b2c6-628eac823134@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHQUrNexVpetdGAg--.48893S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW7ZrW3WrykXry3XFb_yoW8XF4DpF
	95GayrJ3yY9F17u3ZIyF4kAryrKan7Jr1Ut3Zxt3W8JF17tw1kKF1qvwnxJF4UXFZ7uF1U
	ZF909r42gFy7ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/13 10:06, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The local_partition_update() function replaces the command partcmd_update
>> previously handled within update_parent_effective_cpumask(). The update
>> logic follows a state-based approach:
>>
>> 1. Validation check: First verify if the local partition is currently valid
>> 2. Invalidation handling: If the partition is invalid, trigger invalidation
>> 3. State transition: If an invalid partition has no errors, transition to
>>     valid
>> 4. cpumasks updates: For local partition that only cpu maks changes, use
> "cpumask"

Thanks, will update.

>>     partition_update() to handle partition change.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 153 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 148 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 73a43ab58f72..49df38237c1d 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1822,6 +1822,59 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>       remote_partition_disable(cs, tmp);
>>   }
>>   +static bool is_user_cpus_exclusive(struct cpuset *cs)
> 
> Should we name this "is_user_xcpus_exclusive"?
> 
> Cheers,
> Longman
> 

Thanks, will update.

-- 
Best regards,
Ridong


