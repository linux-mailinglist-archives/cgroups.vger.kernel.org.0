Return-Path: <cgroups+bounces-10273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0178B878B4
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9421C262DA
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FFD1E51FB;
	Fri, 19 Sep 2025 00:58:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F534BA2A;
	Fri, 19 Sep 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243514; cv=none; b=EmoUZaQf9zRjdTlud1TTjMtJfpWLWpanPfcg3Bcl6qMZeZzn5BjvRTn1FzAKGnJXBvzdxzBMZNlEIdnTUpCeiXUk7xBXBcZJxyOkX04UUKDa1hVMLYYRTD72eKK61X69efvYAnwRJ3jl4gZStq3M22tT5hCn7v6TAI1LtGnBNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243514; c=relaxed/simple;
	bh=TYS9BnvbY1k2NC4H7JCoVMhCVR0MM15yEaY1vUhXNZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbOx3zbkEAdDggCZWmaquVh1roGnsxmDTCK3/GgUvIlvV84dp1BQtN772tHPBdbFNlodMJqE+3IF8t6y/azWu2a+GrZ+asRcz8vCiyATSGkkwSDJKmckxc8hW1TVC/l4pKyCboIm9p6Sy+0bLDMRtfjogwNom05OaUu09d0fksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cSYzB0XLZzYQv1b;
	Fri, 19 Sep 2025 08:58:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AFF951A0B72;
	Fri, 19 Sep 2025 08:58:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCnPz6zqsxoSNg8AA--.61139S2;
	Fri, 19 Sep 2025 08:58:28 +0800 (CST)
Message-ID: <a1dea9aa-2a9f-4157-b2dc-32b64b9d7679@huaweicloud.com>
Date: Fri, 19 Sep 2025 08:58:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 1/2] cpuset: fix failure to enable
 isolated partition when containing isolcpus
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
 <20250918122532.2981503-2-chenridong@huaweicloud.com>
 <0ee6288f-c621-4c18-bd42-22dd4aa2d826@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0ee6288f-c621-4c18-bd42-22dd4aa2d826@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnPz6zqsxoSNg8AA--.61139S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFWUWryUtryxtw4kCrg_yoW8ZF1xpF
	Z0ka43Jws8ur1fC3yjvF1I9345KFsrtF1UJrs8GrWxZrsFqFyvkFWj9rZ8Ja4UXr4kGryU
	ZFy29rsagasrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/9/19 2:02, Waiman Long wrote:
> On 9/18/25 8:25 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The 'isolcpus' parameter specified at boot time can be assigned to an
>> isolated partition. While it is valid put the 'isolcpus' in an isolated
>> partition, attempting to change a member cpuset to an isolated partition
>> will fail if the cpuset contains any 'isolcpus'.
>>
>> For example, the system boots with 'isolcpus=9', and the following
>> configuration works correctly:
>>
>>    # cd /sys/fs/cgroup/
>>    # mkdir test
>>    # echo 1 > test/cpuset.cpus
>>    # echo isolated > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus.partition
>>    isolated
>>    # echo 9 > test/cpuset.cpus
>>    # cat test/cpuset.cpus.partition
>>    isolated
>>    # cat test/cpuset.cpus
>>    9
>>
>> However, the following steps to convert a member cpuset to an isolated
>> partition will fail:
>>
>>    # cd /sys/fs/cgroup/
>>    # mkdir test
>>    # echo 9 > test/cpuset.cpus
>>    # echo isolated > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus.partition
>>    isolated invalid (partition config conflicts with housekeeping setup)
>>
>> The issue occurs because the new partition state (new_prs) is used for
>> validation against housekeeping constraints before it has been properly
>> updated. To resolve this, move the assignment of new_prs before the
>> housekeeping validation check when enabling a root partition.
>>
>> Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Thanks for finding the bug. However, I think the commit to be fixed should be 4a74e418881f
> ("cgroup/cpuset: Check partition conflict with housekeeping setup"), not the one you listed above.
> 

Thank you for the correction, Longman, you are right. I'll update the commit ID with the correct one

-- 
Best regards,
Ridong


