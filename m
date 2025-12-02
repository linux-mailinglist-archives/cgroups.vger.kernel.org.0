Return-Path: <cgroups+bounces-12241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFEC99AB1
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 01:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796664E1605
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B9184524;
	Tue,  2 Dec 2025 00:44:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FE22097;
	Tue,  2 Dec 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636247; cv=none; b=K5e4ExHfRauCedu+6BjLrP+66eZ+8Skl1cMglLzxaem1CNSAidBUpGTGjUWE73omFmgQ263YmDsjHjUsoJU95pIIegyzh8RQngjsK+5cCyCDmR7//hcC5kx1GnT/VIjX0sVJFcQzn17yw7sZFimlq6TWcR5f+5k857aJ769S3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636247; c=relaxed/simple;
	bh=TkpYmsSX9irKWyRqJtTDjNzxbmVgXCK36/9gAZvPgRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI/ZtQbVB+n5dRxifIDUyZFbWHxFnQ8RmTxzukpQa0b86GDdXTcrzXDE3GptVocAB3vMIx8zIIxVP/k3QtRpGa24u947a3jtpFY+gLSy9iJpNKyF9h+uwHOMvdfo93xg3RK4d7Wsc79+bU84SqvFiddWDHvcRr6YN78N2bNKYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dL28C1vpGzYQtg1;
	Tue,  2 Dec 2025 08:43:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1E8D81A07BD;
	Tue,  2 Dec 2025 08:43:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgD31U9KNi5pEt8mAQ--.20673S2;
	Tue, 02 Dec 2025 08:43:55 +0800 (CST)
Message-ID: <8b7994af-fa75-473f-8b62-2473c7074686@huaweicloud.com>
Date: Tue, 2 Dec 2025 08:43:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 00/21] cpuset: rework local partition logic
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251117024627.1128037-1-chenridong@huaweicloud.com>
 <2943236a-bb0e-4417-aee4-31146988709a@huaweicloud.com>
 <ca3b31ca-e9c3-41e8-ae88-d4b126f574b3@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ca3b31ca-e9c3-41e8-ae88-d4b126f574b3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD31U9KNi5pEt8mAQ--.20673S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy7tw1rKr1UXr1kXrW8WFg_yoWrZw1DpF
	yDGayftryUCF1vk3sFqF4xA3yrKwsrJFyDtwn8Z34xXrsFyw1v9FW09398ua4UWrWkAr18
	ZF1DXr4xu3W2yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/25 9:09, Waiman Long wrote:
> On 11/24/25 7:49 PM, Chen Ridong wrote:
>>
>> On 2025/11/17 10:46, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The current local partition implementation consolidates all operations
>>> (enable, disable, invalidate, and update) within the large
>>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>>> This monolithic approach has become increasingly difficult to understand
>>> and maintain. Additionally, partition-related fields are updated in
>>> multiple locations, leading to redundant code and potential corner case
>>> oversights.
>>>
>>> This patch series refactors the local partition logic by separating
>>> operations into dedicated functions: local_partition_enable(),
>>> local_partition_disable(), and local_partition_update(), creating
>>> symmetry with the existing remote partition infrastructure.
>>>
>>> The series is organized as follows:
>>>
>>> 1. Infrastructure Preparation (Patches 1-2):
>>>     - Code cleanup and preparation for the refactoring work
>>>
>>> 2. Introduce partition operation helpers (Patches 3-5):
>>>     - Introduce out partition_enable(), partition_disable(), and
>>>       partition_update() functions.
>>>
>>> 3. Use new helpers for remote partition (Patches 6-8)
>>>
>>> 4. Local Partition Implementation (Patches 9-12):
>>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>>       * local_partition_enable()
>>>       * local_partition_disable()
>>>       * local_partition_update()
>>>
>>> 5. Optimization and Cleanup (Patches 13-21):
>>>     - Remove redundant partition-related operations
>>>     - Additional optimizations based on the new architecture
>>>
>>> base-commit: 6d7e7251d03f98f26f2ee0dfd21bb0a0480a2178
>>>
>>> ---
>>>
>>> Changes from RFC v2:
>>> 1. Dropped the bugfix (already merged/fixed upstream)
>>> 2. Rebased onto next
>>> 3. Introduced partition_switch to handle root state switches
>>> 4. Directly use local_partition_disable()—no longer first introduce
>>>     local_partition_invalidate() before unifying the two
>>> 5. Incorporated modifications based on Longman's suggestions
>>>
>>> Changes in RFC v1:
>>> 1. Added bugfix for root partition isolcpus at series start.
>>> 2. Completed helper function implementations when first introduced.
>>> 3. Split larger patches into smaller, more reviewable units.
>>> 4. Incorporated feedback from Longman.
>>>
>>> Chen Ridong (21):
>>>    cpuset: add early empty cpumask check in partition_xcpus_add/del
>>>    cpuset: generalize the validate_partition() interface
>>>    cpuset: introduce partition_enable()
>>>    cpuset: introduce partition_disable()
>>>    cpuset: introduce partition_update()
>>>    cpuset: use partition_enable() for remote partition enablement
>>>    cpuset: use partition_disable() for remote partition disablement
>>>    cpuset: use partition_update() for remote partition update
>>>    cpuset: introduce local_partition_enable()
>>>    cpuset: introduce local_partition_disable()
>>>    cpuset: user local_partition_disable() to invalidate local partition
>>>    cpuset: introduce local_partition_update()
>>>    cpuset: remove update_parent_effective_cpumask
>>>    cpuset: remove redundant partition field updates
>>>    cpuset: simplify partition update logic for hotplug tasks
>>>    cpuset: use partition_disable for compute_partition_effective_cpumask
>>>    cpuset: use validate_local_partition in local_partition_enable
>>>    cpuset: introduce validate_remote_partition
>>>    cpuset: simplify the update_prstate() function
>>>    cpuset: remove prs_err clear when notify_partition_change
>>>    cpuset: Remove unnecessary validation in partition_cpus_change
>>>
>>>   kernel/cgroup/cpuset.c | 1014 ++++++++++++++++++----------------------
>>>   1 file changed, 453 insertions(+), 561 deletions(-)
>>>
>> Hi Longman,
>>
>> I would greatly appreciate it if you could review this series when you are available.
>>
> I was expecting a v3 and so I had probably missed it. Will take a look sometimes this week.
> 

Hi Longman,

Looking forward to your review. :)

-- 
Best regards,
Ridong


