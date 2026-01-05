Return-Path: <cgroups+bounces-12901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F86CF1C82
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 05:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4904630019EF
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 04:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D03203B6;
	Mon,  5 Jan 2026 04:01:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1831A561;
	Mon,  5 Jan 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767585688; cv=none; b=mM1TAiOi16ksVKd8C5T0hipqm2AAMKrti4dveR6cGo3QIpD5n3IY8sKMZZJufKeDF3DVL5RfM8QHWjdQMxbrKA5d1UukPLsrWFzgUkRc94nuV7T51VmLhjgM9RT6S4QHDBEIxQamFb3pw2TjbQeLOGz9ILFzXUUN9CcsE0Kzyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767585688; c=relaxed/simple;
	bh=O/uHfBoAN79a/MKru3mBvmTzXPyiH9Qyb5XWYRH2lxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ06rcC387Hl59c6ewloIXExotEcXyQpJFkiyJgXGgKasP973ypCWplP3tjAwvE6QNt33NbxTyTXel9K/BaWSAA3Tnn5C2HQ+OGTojkVfKoEIQEzmOTX2HrtHnzJUgqSGI4TGoHDhTwi1YN9hI/IkB8katf+59o4gDKuFfi9ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dl0vF55RNzYQtwP;
	Mon,  5 Jan 2026 12:00:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9A2A4056C;
	Mon,  5 Jan 2026 12:01:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_eTN1tpBGm3Cg--.36911S2;
	Mon, 05 Jan 2026 12:01:23 +0800 (CST)
Message-ID: <7937ad21-8c98-4bd8-8a5d-93f868bcb8b5@huaweicloud.com>
Date: Mon, 5 Jan 2026 12:01:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND -next 00/21] cpuset: rework local partition logic
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251225123058.231765-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3l_eTN1tpBGm3Cg--.36911S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfZF1DuryfWr15Kr13twb_yoWrXryrpF
	98GaySyryUKry5C39rJFs7Aw4rWwsrJryUtwnxu348Xr12yw1vvFWI9395Za4jgryDAryU
	ZFnrWr48X3WUCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/25 20:30, Chen Ridong wrote:
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
> 1. Infrastructure Preparation (Patches 1-2):
>    - Code cleanup and preparation for the refactoring work
> 
> 2. Introduce partition operation helpers (Patches 3-5):
>    - Introduce out partition_enable(), partition_disable(), and
>      partition_update() functions.
> 
> 3. Use new helpers for remote partition (Patches 6-8)
> 
> 4. Local Partition Implementation (Patches 9-12):
>    - Separate update_parent_effective_cpumask() into dedicated functions:
>      * local_partition_enable()
>      * local_partition_disable()
>      * local_partition_update()
> 
> 5. Optimization and Cleanup (Patches 13-21):
>    - Remove redundant partition-related operations
>    - Additional optimizations based on the new architecture
> 
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
> 
> ---
> 
> Changes in RESEND:
> 1. Rebase on the next-20251219
> 
> Changes from RFC v2:
> 1. Dropped the bugfix (already merged/fixed upstream)
> 2. Rebased onto next
> 3. Introduced partition_switch to handle root state switches
> 4. Directly use local_partition_disable()—no longer first introduce
>    local_partition_invalidate() before unifying the two
> 5. Incorporated modifications based on Longman's suggestions
> 
> Changes in RFC v1:
> 1. Added bugfix for root partition isolcpus at series start.
> 2. Completed helper function implementations when first introduced.
> 3. Split larger patches into smaller, more reviewable units.
> 4. Incorporated feedback from Longman.
> 
> Chen Ridong (21):
>   cpuset: add early empty cpumask check in partition_xcpus_add/del
>   cpuset: generalize the validate_partition() interface
>   cpuset: introduce partition_enable()
>   cpuset: introduce partition_disable()
>   cpuset: introduce partition_update()
>   cpuset: use partition_enable() for remote partition enablement
>   cpuset: use partition_disable() for remote partition disablement
>   cpuset: use partition_update() for remote partition update
>   cpuset: introduce local_partition_enable()
>   cpuset: introduce local_partition_disable()
>   cpuset: user local_partition_disable() to invalidate local partition
>   cpuset: introduce local_partition_update()
>   cpuset: remove update_parent_effective_cpumask
>   cpuset: remove redundant partition field updates
>   cpuset: simplify partition update logic for hotplug tasks
>   cpuset: use partition_disable for compute_partition_effective_cpumask
>   cpuset: use validate_local_partition in local_partition_enable
>   cpuset: introduce validate_remote_partition
>   cpuset: simplify the update_prstate() function
>   cpuset: remove prs_err clear when notify_partition_change
>   cpuset: Remove unnecessary validation in partition_cpus_change
> 
>  kernel/cgroup/cpuset.c | 1023 ++++++++++++++++++----------------------
>  1 file changed, 454 insertions(+), 569 deletions(-)
> 

Hi Longman,

This series has been out for a while. I'd appreciate it if you could take some time to review it.

-- 
Best regards,
Ridong


