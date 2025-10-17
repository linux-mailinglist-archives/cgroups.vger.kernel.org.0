Return-Path: <cgroups+bounces-10834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C2BE603E
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 03:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 955824F33CA
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F31F9EC0;
	Fri, 17 Oct 2025 01:05:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBB189B80;
	Fri, 17 Oct 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663153; cv=none; b=OfNASH/4pzhw18v9832uTarjZy2AyK6RBOgDpeW2Mthfg2I66BbeBJteb8O6MTuvrokSiyF2F0EfSElPLn3x0foV2fsmI0fRevM0a3i4M4xZ6lx7ixWDUc5RQEm/ii79yfBcmsy1/7eoZVw2kq92AFT9lg1e94gtLr8vncCIvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663153; c=relaxed/simple;
	bh=V6FlxoQvMpjYT398PvEkUm0hGDP9IeuAT/C0+hlPh4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnY9y73uTWM7g0XiPRTnD14Ao+uGRHRp+CrJcpEBAWVzH0Qw8SJmmHh61fdp51YeJamp1n07jZckxtKurtuycnSt+zyhAvwyouB3qkP1xWbaWb3PdLfo0c9uwB52/SbUPgnMrUccSTW1Bll8kvLTzBbKZ9SRG3Wwg04ElTsuUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cnmnn47xMzKHMMX;
	Fri, 17 Oct 2025 09:05:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 72B881A104A;
	Fri, 17 Oct 2025 09:05:41 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCXOEFklvFo39p+Ag--.22137S2;
	Fri, 17 Oct 2025 09:05:41 +0800 (CST)
Message-ID: <9cdd5042-a592-4db3-a4bf-2ec126f1a169@huaweicloud.com>
Date: Fri, 17 Oct 2025 09:05:39 +0800
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
X-CM-TRANSID:Syh0CgCXOEFklvFo39p+Ag--.22137S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45trWfCr48try7WrWfKrg_yoW5Xr48pF
	yvkayIyayDKr1rC347JFs7ZrWrWwsrGayDtrn8Wa4xJr17Aw1vqFWI93yjv3y7WrZ5Jryj
	vF4jgrn7Z3W29F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Longman,

I noticed that v6.18-rc1 was tagged on October 12.
I’d really appreciate it if you could find some time to review this patch series when you’re available.

-- 
Best regards,
Ridong


