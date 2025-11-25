Return-Path: <cgroups+bounces-12184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE5C82FE9
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 02:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0E94E23D5
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3A26ED5F;
	Tue, 25 Nov 2025 01:17:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99411E5B7B;
	Tue, 25 Nov 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764033433; cv=none; b=ZmwIkKnCxcAjDa2TX2zc55KkzhlQRPHkvuNObQ9mMit8p1wiAv8EO3HswDNmRKTw5ziHbHY5OjXuedbfZzGTJGWwXZlPPHc9JwS5y9Sau1yotsor1mN0R0e3NqU55D8rYOPCnm6ulTnWlpkTXfbc/HpxXYdQ5+vOw0NvCF3F96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764033433; c=relaxed/simple;
	bh=MgT/hbrZ1twUBbKcZVrj1YYxqsGHHFuCvpT4DCUeRwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrZEEx6phtOy/eOp90iTODvJC/V8KW5N4QBHunxki0Q29w0GFJnHeAwUYH7aGP/ijsDbzdUP+gAx9YYsxyMD3M7tdnO9tOXW2dp+9sX9OOcWRtXAYievH0bEyUpdHC4w6TI1NvxBvphCH2rGhYHf3hs2s046tK627BjRFnZ2AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dFlBz2XNdzKHM0L;
	Tue, 25 Nov 2025 09:16:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D82DB1A07C0;
	Tue, 25 Nov 2025 09:17:03 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgB3IHeOAyVpBYCuBw--.32966S2;
	Tue, 25 Nov 2025 09:17:03 +0800 (CST)
Message-ID: <5441e4ee-d8b9-4308-9b9c-986cc6a5c09d@huaweicloud.com>
Date: Tue, 25 Nov 2025 09:17:02 +0800
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
X-CM-TRANSID:Syh0CgB3IHeOAyVpBYCuBw--.32966S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy7tw1rKr1UXr1kXrW8WFg_yoWrZFy3pF
	yDGayftryUCF1vk342qF4xA3yrKwnrJFyDtwn8Z34xXrsFyw1v9FW09398ua4UWrWkAr18
	ZF1DXr4xu3WakaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
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

Thank you very much.

-- 
Best regards,
Ridong


