Return-Path: <cgroups+bounces-10477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C681FBA6E62
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6089D7AD97F
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1342DA765;
	Sun, 28 Sep 2025 09:57:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA52D9EE2;
	Sun, 28 Sep 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053455; cv=none; b=CkUb1RC3CeYCxMu3qZnpPAk0dxPCZG0aE+nh1NkFfst5xFpkAiJdeRQ9/d58oINdnQMx5RfAgw5QFwV56avF6c+g9fShoXxjZMfKZODCEPaQdbiMfJqoFymenPXX31VWUN8KhOfVR48UxTfGH1OGvEaeWSCWgpWbvUdQ60TEJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053455; c=relaxed/simple;
	bh=dumUV71p1sLstCNKKFhagPnBXc90yU8aoRHsBryCCWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oGSJste4ZUQev0YXNtMZcSkLIzcEMP2EbcHmLp4PB8prIXWDEsbdiq7OjPUsJuUTC1/o0j0dcRyqCfOo/3lesiSGs5k01nkHrl8IpWjJjc8NnT9ZdCqM7DO0BkKWaJpOQRbxRwgdJ/meNN0lNr4I8yJdcrY8AjfOkMR4lJkYadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZKVf4H4gzYQvLb;
	Sun, 28 Sep 2025 17:57:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A5B231A0FC8;
	Sun, 28 Sep 2025 17:57:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXWmKHBtloA2FiBA--.6421S2;
	Sun, 28 Sep 2025 17:57:28 +0800 (CST)
Message-ID: <2ccc217a-09f5-483a-bb91-4d0a25d98434@huaweicloud.com>
Date: Sun, 28 Sep 2025 17:57:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 00/16] cpuset: rework local partition logic
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXWmKHBtloA2FiBA--.6421S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF17JF1ktr45ArWkCrW8Crg_yoW5ZrWDpF
	9xCrWSk34UGry3C3srJan7Zw4rGws7JFyUtrnrXw18Xr17Aw1vyFyIy3ykZa47Xr98Ary8
	Z3ZrWr4xX3WqkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/


On 2025/9/28 15:12, Chen Ridong wrote:
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
> 2. Core Partition Operations (Patches 3-5):
>    - Factor out partition_enable(), partition_disable(), and
>      partition_update() functions from remote partition operations
> 
> 3. Local Partition Implementation (Patches 6-9):
>    - Separate update_parent_effective_cpumask() into dedicated functions:
>      * local_partition_enable()
>      * local_partition_disable()
>      * local_partition_invalidate()
>      * local_partition_update()
> 
> 4. Optimization and Cleanup (Patches 10-16):
>    - Remove redundant partition-related operations
>    - Additional optimizations based on the new architecture
> 
> Key improvements:
> - Centralized management of partition-related fields (partition_root_state,
>   prs_err, nr_subparts, remote_sibling, effective_xcpus) within the
>   partition_enable/disable/update functions
> - Consistent operation patterns for both local and remote partitions
>   with type-specific validation checks
> - Fixed bug where isolcpus remained in root partition after isolated
>   partition transitioned to root
> 
> Chen Ridong (16):
>   cpuset: use update_partition_sd_lb in update_cpumasks_hier
>   cpuset: generalize validate_partition() interface
>   cpuset: factor out partition_enable() function
>   cpuset: factor out partition_disable() function
>   cpuset: factor out partition_update() function
>   cpuset: introduce local_partition_enable()
>   cpuset: introduce local_partition_disable()
>   cpuset: introduce local_partition_invalidate()
>   cpuset: introduce local_partition_update()
>   cpuset: remove redundant partition field updates
>   cpuset: simplify partition update logic for hotplug tasks
>   cpuset: unify local partition disable and invalidate
>   cpuset: use partition_disable for compute_partition_effective_cpumask
>   cpuset: fix isolcpus stay in root when isolated partition changes to
>     root
>   cpuset: use partition_disable for update_prstate
>   cpuset: remove prs_err clear when notify_partition_change
> 
>  kernel/cgroup/cpuset.c | 907 ++++++++++++++++++-----------------------
>  1 file changed, 408 insertions(+), 499 deletions(-)
> 

+cc cgroups@vger.kernel.org

-- 
Best regards,
Ridong


