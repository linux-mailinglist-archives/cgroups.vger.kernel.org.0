Return-Path: <cgroups+bounces-11901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74AC553FA
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547843A8390
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA9264F81;
	Thu, 13 Nov 2025 01:24:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9922C181;
	Thu, 13 Nov 2025 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997092; cv=none; b=JTiDVipNilaMf/PlWMnxaukUeuYdqKFQ9fAkbz3E218IH1u/jb5Nm3R1OmyMFggbVrjp3bKVVnNEVzqTHoPJzU5XtK/7SMGqcGj+xQGWXdl68TfStJdyyrJPNKr1RGYzSXuw0f7wR9WMsjv7sbDmwxiTBN44AyWAN7DfOF33Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997092; c=relaxed/simple;
	bh=OEbbOGRMylgaX5DyOvKilo9zh8gcEn4AwE4f80dihWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIbTzdceSCd+jMrvYu4DDIgVM5XEjSUwLJNIZ6OLD3rq3Auqa/amWscICJc//1FNdhSnpHLpy/VAXlNZUD8t3BsLjZkx4XK2AUU7olJuIHX8b2U+6aGyjH29PxXNXSFbOMxbW1wqS2IHmgpXic7ENcYMarQ8At8EfqK6QL6evrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6Mxn47cdzKHLxS;
	Thu, 13 Nov 2025 09:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E7A5B1A0D51;
	Thu, 13 Nov 2025 09:24:47 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3YV5fMxVpPnYzAg--.26245S2;
	Thu, 13 Nov 2025 09:24:47 +0800 (CST)
Message-ID: <7387b588-bbfe-4aaa-ade2-0216d602cc60@huaweicloud.com>
Date: Thu, 13 Nov 2025 09:24:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/22] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-2-chenridong@huaweicloud.com>
 <28109443-4bee-4ec8-b7d1-599ce1464da6@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <28109443-4bee-4ec8-b7d1-599ce1464da6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3YV5fMxVpPnYzAg--.26245S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFWUCw1rtw47trW5ZFb_yoW8Zw45pF
	ykKFWUG3y5ur1rC342qF1Ivry5KFsrJ3WUJrs8GFyxXrsrGF1q9FWj9rZ0gr1UJrs7GryU
	AF9rur1S9F17JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 4:09, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A bug was detected with the following steps:
>>
>>    # cd /sys/fs/cgroup/
>>    # mkdir test
>>    # echo 9 > test/cpuset.cpus
>>    # echo isolated > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus.partition
>>    isolated
>>    # cat test/cpuset.cpus
>>    9
>>    # echo root > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus
>>    9
>>    # cat test/cpuset.cpus.partition
>>    root
>>
>> CPU 9 was initially listed in the "isolcpus" boot command line parameter.
>> When the partition type is changed from isolated to root, CPU 9 remains
>> in what becomes a valid root partition. This violates the rule that
>> isolcpus can only be assigned to isolated partitions.
>>
>> Fix this by adding a housekeeping conflict check during transitions
>> between root and isolated partitions.
>>
>> Fixes: 4a74e418881f ("cgroup/cpuset: Check partition conflict with housekeeping setup")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 96104710a649..6af4d80b53c4 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2995,6 +2995,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>            * Need to update isolated_cpus.
>>            */
>>           isolcpus_updated = true;
>> +        if (prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
>> +            err = PERR_HKEEPING;
>>       } else {
>>           /*
>>            * Switching back to member is always allowed even if it
> 
> This patch has been merged in somewhat different form.
> 
> Cheers,
> Longman
> 

Yes, I know, I will drop this patch.

Thanks,

-- 
Best regards,
Ridong


