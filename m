Return-Path: <cgroups+bounces-11903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B4C55439
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C84534615D
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239428D8F1;
	Thu, 13 Nov 2025 01:36:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E13B1BD;
	Thu, 13 Nov 2025 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997786; cv=none; b=QqHn29Zu9udrV0LZG2vsjEKiCprfe/rpoSx7Z3w6cBV87YmMXcL9W3tHZaoBP8vdGclNrgwSLGLom8kBGuP3GVgC+yQLleT+oUDvQYQVp0nqj6LNHjMVbHBMC5KzzdUteQIq2lwwR1xd5l/iPinXVp/uzMxkqKEq6sFYT2OIduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997786; c=relaxed/simple;
	bh=K+2b+IyeZvWNwL7IA5XzdG/CeYwFnpHLZsl3b4SjHOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR0aCIVlNcAYYZ0i+eyPZDQZdII+hMUz45pKnKz70isWZrzXYzcAv9Q8H4g7Oyyfd/mJNLiPjiLDOXX22+XzHaMf/wKeGBz2NDc+5WVEqAI9u+bYAa3fwr75jYjgqTtLwPRt7y9/ZHWsvwnURRLfswZMOByUupcsShH2sZF5bT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6NBv307KzYQv5D;
	Thu, 13 Nov 2025 09:35:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B7B8E1A08FE;
	Thu, 13 Nov 2025 09:36:20 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgA3cksTNhVp5sEuAg--.25431S2;
	Thu, 13 Nov 2025 09:36:20 +0800 (CST)
Message-ID: <931a4ff2-f240-403b-adff-822449b49d31@huaweicloud.com>
Date: Thu, 13 Nov 2025 09:36:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/22] cpuset: add early empty cpumask check in
 partition_xcpus_add/del
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-3-chenridong@huaweicloud.com>
 <3c449d75-2a44-4acc-b3f6-0b2c261db1bd@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3c449d75-2a44-4acc-b3f6-0b2c261db1bd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3cksTNhVp5sEuAg--.25431S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur43tr1UJFWktw18GF17Wrg_yoW8Kw13pr
	s5KFWUGFW5Kr1rC3srta1xCFyfKws7G3WUtwnYqFy8AF17W3ZYgF9F9a90gw15X3ykCr4U
	ZF13XrsFvF17Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/13 4:18, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Add a check for an empty cpumask at the start of partition_xcpus_add()
>> and partition_xcpus_del(). This allows the functions to return early,
>> avoiding unnecessary computation when there is no work to be done.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6af4d80b53c4..3ba9ca4e8f5e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1345,6 +1345,9 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>>         WARN_ON_ONCE(new_prs < 0);
>>       lockdep_assert_held(&callback_lock);
>> +    if (cpumask_empty(xcpus))
>> +        return false;
>> +
>>       if (!parent)
>>           parent = &top_cpuset;
>>   @@ -1377,6 +1380,9 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>>         WARN_ON_ONCE(old_prs < 0);
>>       lockdep_assert_held(&callback_lock);
>> +    if (cpumask_empty(xcpus))
>> +        return false;
>> +
>>       if (!parent)
>>           parent = &top_cpuset;
>>   
> 
> partition_xcpus_add() and partition_xcpus_del() are supposed to be called only when action is really
> needed. The empty xcpus check should be done earlier to avoid calling them in the first  place. So
> unless you are planning to change the logic that they will always be called even if action is not
> really needed. If so, you have to state in the commit log.
> 
> Cheers,
> Longman
> 

Thanks Longman,

partition_xcpus_add() and partition_xcpus_del() are called in serial contexts. If we move the check
outside these functions, we’ll end up with more conditional statements like this:

if (!is_empty(xxx))
	partition_xcpus_add()/partition_xcpus_del()

So I prefer to handle the check inside the functions themselves. This way, we don’t need to care
whether xcpus is empty when calling them—and the overhead is negligible.

I’ll update the commit log to clarify that these functions can be called even when the action isn’t
strictly necessary.

-- 
Best regards,
Ridong


