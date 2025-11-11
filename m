Return-Path: <cgroups+bounces-11797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF5CC4BA06
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066334E9AB4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A62D0610;
	Tue, 11 Nov 2025 06:16:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025442C3272;
	Tue, 11 Nov 2025 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841805; cv=none; b=SDHW5JaGH0HLugrV54B5uMcksGBnalAkYzHWFKSQVGSBUynyhqy3InoFFuSxqjy5ikm2VPXnf2sZ76J596jsbLQvvvBMOAjx08eD/CXkdyydNFFzpoHkGBT8/vyFWXQ+H4OoESi0aMZSGhFBaQOoX7v0Decdpo2hYkjYlsk67j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841805; c=relaxed/simple;
	bh=KzTfcpPApk6yMpNyusdmq7Lu6t04BUL+jLH1LZ6i5Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQMzqoZJJNi2HNSMFDwqM4sdPsk6ESDqQOvKuvq6GpI+lLwPg8MXIpnNlf7Xuo5ai4q7mO1Zqw41stMAQ4joyhqt6tp710ZXTG/cZwId4t5y3QBR1rctY8neVcr3vPubtm0I7UEACwIYzxxY1lkIUquql17kRrjw2k5vyVyzhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5GWP68dWzKHMTh;
	Tue, 11 Nov 2025 14:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8FBAB1A13E4;
	Tue, 11 Nov 2025 14:16:33 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDXgXjA1BJpnf5iAQ--.54859S2;
	Tue, 11 Nov 2025 14:16:33 +0800 (CST)
Message-ID: <40005c6e-9786-4f77-a118-482912022270@huaweicloud.com>
Date: Tue, 11 Nov 2025 14:16:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-2-chenridong@huaweicloud.com>
 <cd1fbcd1-37e6-4aa8-8654-3305cbe085c3@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <cd1fbcd1-37e6-4aa8-8654-3305cbe085c3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXgXjA1BJpnf5iAQ--.54859S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDXr48tF15WF1UXFyfCrg_yoW8tw18pF
	WkG34UCrW5GryfGr15trZ8XFyUJr18J3ZrJr1kXFyxAry2yFy2gF1UXwnFgryUJrZ7GF15
	Jr15ZrsrZF9rtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/11 12:26, Waiman Long wrote:
> On 11/9/25 8:52 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> There is no need to jump to the 'done' label upon failure, as no cleanup
>> is required. Return the error code directly instead.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 8238fd8c0c29..c90476d52f09 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2897,21 +2897,19 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>>        */
>>       retval = nodelist_parse(buf, trialcs->mems_allowed);
>>       if (retval < 0)
>> -        goto done;
>> +        return retval;
>>         if (!nodes_subset(trialcs->mems_allowed,
>> -              top_cpuset.mems_allowed)) {
>> -        retval = -EINVAL;
>> -        goto done;
>> -    }
>> +              top_cpuset.mems_allowed))
>> +        return -EINVAL;
>> +
>> +    /* No change? nothing to do */
>> +    if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed))
>> +        return 0;
>>   -    if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {
>> -        retval = 0;        /* Too easy - nothing to do */
>> -        goto done;
>> -    }
>>       retval = validate_change(cs, trialcs);
>>       if (retval < 0)
>> -        goto done;
>> +        return retval;
>>         check_insane_mems_config(&trialcs->mems_allowed);
>>   @@ -2921,8 +2919,7 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>>         /* use trialcs->mems_allowed as a temp variable */
>>       update_nodemasks_hier(cs, &trialcs->mems_allowed);
>> -done:
>> -    return retval;
>> +    return 0;
>>   }
>>     bool current_cpuset_is_being_rebound(void)
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks.

-- 
Best regards,
Ridong


