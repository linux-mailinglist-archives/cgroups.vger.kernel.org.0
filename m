Return-Path: <cgroups+bounces-10486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F3BA7C05
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 03:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05CB3B8F42
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178B1BD9C9;
	Mon, 29 Sep 2025 01:17:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC744503B;
	Mon, 29 Sep 2025 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759108639; cv=none; b=tEvSpp/SFb81j++faltpbS2+nHx/8PM1q+QNy2dCyjHLekZv2fe771x/BISc1sdchxN5vM40j9gpkMl4lsRcoZGCpNMn3v4CSzzxmeeilT5Mg00fo+3fvpurW+34SwpsIrU1s+vyu75WvOYv0kshJRIBykBuQlp/6hLPsGm86No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759108639; c=relaxed/simple;
	bh=5MiYbiNvJNezXCKPK8O2NZxxNup8Me1COPnBwQyWBss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJruymQQNzuLLaX3uW7rtkz4VDfVt8jl0Xinp69c2gu+N2e4HZ57dlkVNZmwSW+MKx8/4ikn/F+O7Z8BVTihgR1yXbM9VlwuOYUisqTradALCtQBorcDZ5drKvW0+BXI50FKAJ+rxRURJoenCddna/zM1AKuU1VFkOtC3A9rJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZjvr2sxNzYQvBg;
	Mon, 29 Sep 2025 09:16:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 86D561A1ACB;
	Mon, 29 Sep 2025 09:17:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgCXSuMW3tlowGaYBA--.52208S2;
	Mon, 29 Sep 2025 09:17:11 +0800 (CST)
Message-ID: <5410a630-dea8-42d9-bf0d-e543352ed969@huaweicloud.com>
Date: Mon, 29 Sep 2025 09:17:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 00/16] cpuset: rework local partition logic
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <8a6a99e8-f171-4f1a-86db-21ecd3cd2287@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <8a6a99e8-f171-4f1a-86db-21ecd3cd2287@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXSuMW3tlowGaYBA--.52208S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45trWfCr48try7WrWfKrg_yoW5Xw48pF
	yvkayIya9rGr1rC347JFs7Z3yrWws7Ganrtr15W348Jr47Aw1vqFyI93yjv347XrZ5Jry0
	vF4jqr1xZ3W2vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/9/29 0:00, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The current local partition implementation consolidates all operations
>> (enable, disable, invalidate, and update) within the large
>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>> This monolithic approach has become increasingly difficult to understand
>> and maintain. Additionally, partition-related fields are updated in
>> multiple locations, leading to redundant code and potential corner case
>> oversights.
>>
>> This patch series refactors the local partition logic by separating
>> operations into dedicated functions: local_partition_enable(),
>> local_partition_disable(), and local_partition_update(), creating
>> symmetry with the existing remote partition infrastructure.
>>
>> The series is organized as follows:
>>
>> 1. Infrastructure Preparation (Patches 1-2):
>>     - Code cleanup and preparation for the refactoring work
>>
>> 2. Core Partition Operations (Patches 3-5):
>>     - Factor out partition_enable(), partition_disable(), and
>>       partition_update() functions from remote partition operations
>>
>> 3. Local Partition Implementation (Patches 6-9):
>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>       * local_partition_enable()
>>       * local_partition_disable()
>>       * local_partition_invalidate()
>>       * local_partition_update()
>>
>> 4. Optimization and Cleanup (Patches 10-16):
>>     - Remove redundant partition-related operations
>>     - Additional optimizations based on the new architecture
>>
>> Key improvements:
>> - Centralized management of partition-related fields (partition_root_state,
>>    prs_err, nr_subparts, remote_sibling, effective_xcpus) within the
>>    partition_enable/disable/update functions
>> - Consistent operation patterns for both local and remote partitions
>>    with type-specific validation checks
>> - Fixed bug where isolcpus remained in root partition after isolated
>>    partition transitioned to root
> 
> You are really active in restructuring the cpuset code. However, the next merge window for v6.18 is
> going to open later today or tomorrow. I will start reviewing this patch series once the merge
> window closes 2 weeks later.
> 
> Cheers,
> Longman
> 

Thank you for letting me know about your schedule.

I've been quite active in the cgroup, especially with cpuset, I believe. :)

I've been thinking about reworking this series for some time, and I finally got it done.
Looking forward to your review.

-- 
Best regards,
Ridong


