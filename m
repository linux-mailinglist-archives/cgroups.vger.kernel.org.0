Return-Path: <cgroups+bounces-11498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D50C2B45F
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 12:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB654EBAAB
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40872EB87A;
	Mon,  3 Nov 2025 11:18:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F22E1EE7;
	Mon,  3 Nov 2025 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168739; cv=none; b=YLfLUVMYNS0vVfHRDmHrd5exd9kJiHhxR0dFESDDZqfdhUDVePNL3BrcLaz8UnWVn3hKRkrbHgRymtGGjVxs1YimMAtf3QA8a71a5DxGOtDFUFbZVS3UDsLsX75o+EFKgFqiSaABRZL7SMUtiXUS4DLr0SCWnuo2Y2OFNDWj6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168739; c=relaxed/simple;
	bh=taFBnJJqqaEpZM3jo5utaLQzQlREaiFFTxcTAHk/CIA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qo/4XeyRTkYn7QxAWhyKvKXMF7O9Uts17zAce6cnfUZ9Gfm1aT3whJ6tUIBlFEkKNqSfaSY7IsGY3hCfE+ZKKkxYJEOlgBNc20W/SmMBIHAikOBgWWRgn1f3Hr4shPO36Dmkf4kbvbaudW9EnzDBvHPZ+nZGs5iSOYGUmH1l2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0Tc11XnHzYQttL;
	Mon,  3 Nov 2025 19:18:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7AB231A0C73;
	Mon,  3 Nov 2025 19:18:54 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDHWt+djwhp8cQMCg--.64504S2;
	Mon, 03 Nov 2025 19:18:54 +0800 (CST)
Message-ID: <31b58b15-0b46-4eba-bd50-afc99203695a@huaweicloud.com>
Date: Mon, 3 Nov 2025 19:18:52 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/22] cpuset: rework local partition logic
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDHWt+djwhp8cQMCg--.64504S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1kWFWruFWDKr15tFW3GFg_yoW5tw4kpF
	98GaySyryUGry5C3srJFs7Aw4rWwsrJFyUtwnxu348Xr17Aw1vvayIy395Za47XryDZryU
	Z3ZrWr4xX3W7C3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YYLPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/25 14:48, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The current local partition implementation consolidates all operations
> (enable, disable, invalidate, and update) within the large
> update_parent_effective_cpumask() function, which exceeds 300 lines.
> This monolithic approach has become increasingly difficult to understand
> and maintain. Additionally, partition-related fields are updated in
> multiple locations, leading to redundant code and potential corner case
> oversights.
> 
> This patch series refactors the local partition logic by separating
> operations into dedicated functions: local_partition_enable(),
> local_partition_disable(), and local_partition_update(), creating
> symmetry with the existing remote partition infrastructure.
> 
> The series is organized as follows:
> 
> 1. Fix a bug that isolcpus stat in root partition.
> 
> 2. Infrastructure Preparation (Patches 2-3):
>    - Code cleanup and preparation for the refactoring work
> 
> 3. Introduce partition operation helpers (Patches 4-6):
>    - Intoduce out partition_enable(), partition_disable(), and
>      partition_update() functions.
> 
> 4. Use new helpers for remote partition (Patches 7-9)
> 
> 5. Local Partition Implementation (Patches 10-13):
>    - Separate update_parent_effective_cpumask() into dedicated functions:
>      * local_partition_enable()
>      * local_partition_disable()
>      * local_partition_invalidate()
>      * local_partition_update()
> 
> 6. Optimization and Cleanup (Patches 14-22):
>    - Remove redundant partition-related operations
>    - Additional optimizations based on the new architecture
> 
> ---
> 
> Changes in v2:
> - Added bugfix for root partition isolcpus at series start.
> - Completed helper function implementations when first introduced.
> - Split larger patches into smaller, more reviewable units.
> - Incorporated feedback from Longman.
> 
> Chen Ridong (22):
>   cpuset: fix isolcpus stay in root when isolated partition changes to
>     root
>   cpuset: add early empty cpumask check in partition_xcpus_add/del
>   cpuset: generalize validate_partition() interface
>   cpuset: introduce partition_enable()
>   cpuset: introduce partition_disable()
>   cpuset: introduce partition_update()
>   cpuset: use partition_enable() for remote partition enablement
>   cpuset: use partition_disable() for remote partition disablement
>   cpuset: use partition_update() for remote partition update
>   cpuset: introduce local_partition_enable()
>   cpuset: introduce local_partition_disable()
>   cpuset: introduce local_partition_invalidate()
>   cpuset: introduce local_partition_update()
>   cpuset: remove update_parent_effective_cpumask
>   cpuset: remove redundant partition field updates
>   cpuset: simplify partition update logic for hotplug tasks
>   cpuset: unify local partition disable and invalidate
>   cpuset: use partition_disable for compute_partition_effective_cpumask
>   cpuset: use validate_local_partition in local_partition_enable
>   cpuset: introduce validate_remote_partition
>   cpuset: simplify update_prstate() function
>   cpuset: remove prs_err clear when notify_partition_change
> 
>  kernel/cgroup/cpuset.c | 1000 +++++++++++++++++++---------------------
>  1 file changed, 463 insertions(+), 537 deletions(-)
> 

Hi Longman,

I'd appreciate it if you could have a look at this series when you have a moment.

-- 
Best regards,
Ridong


