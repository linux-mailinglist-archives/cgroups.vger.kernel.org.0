Return-Path: <cgroups+bounces-11851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6633C507D5
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 05:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933B9189B825
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7C2D23BC;
	Wed, 12 Nov 2025 04:12:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE1239573;
	Wed, 12 Nov 2025 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920725; cv=none; b=RbJmGhL6+QSUwYXQeeR82VWaVTA/TawbW//B4o0lFV1B8AQQiIEazB5oGAyVwnmNqKoFqxLIFc7gOtOlHU1jHCLOs1TZtpE1I2FUcxaqKUspHml+iaoYgZznOD+VJ2XE5fy/QCacPWBARzoovgwKi7D91uKPvnO8jtYxMchEklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920725; c=relaxed/simple;
	bh=RxRAGYGYU5PFONAM3lzzTzxdGF7ioygfDYl3P/MNw3k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SCDHBzrO7TwSu1jU7XhJHKnQ/rOGXjl3u5gyxyNWdiIaxcEC6Pn/eLtB7OpQH3l24DMZ0mG+v0Q+QY0WXuUVYypqxyudLyvJnTbO2DI20SwhYOXjbzipBhnu7TibOJHa+YpZt2vkfv8vNmq8Mf6msmI+DE+xjVCfUM4rdi6UcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5qj01TgXzYQts6;
	Wed, 12 Nov 2025 12:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0AC651A08DC;
	Wed, 12 Nov 2025 12:12:00 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgAHQUoPCRRpBKTHAQ--.28912S2;
	Wed, 12 Nov 2025 12:11:59 +0800 (CST)
Message-ID: <c5c4e977-9194-42c8-9045-0ed0ff16f5a5@huaweicloud.com>
Date: Wed, 12 Nov 2025 12:11:59 +0800
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
 <31b58b15-0b46-4eba-bd50-afc99203695a@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <31b58b15-0b46-4eba-bd50-afc99203695a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHQUoPCRRpBKTHAQ--.28912S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45trWfCr48try7GFy3Arb_yoWrGF45pF
	98Gayft34UJry5C3srJFs7Aw4FgwsrJFyUt3ZxZw1xJr12yw1vvFWIy395Za42gr98Ary8
	ZFnFgrs7u3WUu3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/3 19:18, Chen Ridong wrote:
> 
> 
> On 2025/10/25 14:48, Chen Ridong wrote:
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
>> 1. Fix a bug that isolcpus stat in root partition.
>>
>> 2. Infrastructure Preparation (Patches 2-3):
>>    - Code cleanup and preparation for the refactoring work
>>
>> 3. Introduce partition operation helpers (Patches 4-6):
>>    - Intoduce out partition_enable(), partition_disable(), and
>>      partition_update() functions.
>>
>> 4. Use new helpers for remote partition (Patches 7-9)
>>
>> 5. Local Partition Implementation (Patches 10-13):
>>    - Separate update_parent_effective_cpumask() into dedicated functions:
>>      * local_partition_enable()
>>      * local_partition_disable()
>>      * local_partition_invalidate()
>>      * local_partition_update()
>>
>> 6. Optimization and Cleanup (Patches 14-22):
>>    - Remove redundant partition-related operations
>>    - Additional optimizations based on the new architecture
>>
>> ---
>>
>> Changes in v2:
>> - Added bugfix for root partition isolcpus at series start.
>> - Completed helper function implementations when first introduced.
>> - Split larger patches into smaller, more reviewable units.
>> - Incorporated feedback from Longman.
>>
>> Chen Ridong (22):
>>   cpuset: fix isolcpus stay in root when isolated partition changes to
>>     root
>>   cpuset: add early empty cpumask check in partition_xcpus_add/del
>>   cpuset: generalize validate_partition() interface
>>   cpuset: introduce partition_enable()
>>   cpuset: introduce partition_disable()
>>   cpuset: introduce partition_update()
>>   cpuset: use partition_enable() for remote partition enablement
>>   cpuset: use partition_disable() for remote partition disablement
>>   cpuset: use partition_update() for remote partition update
>>   cpuset: introduce local_partition_enable()
>>   cpuset: introduce local_partition_disable()
>>   cpuset: introduce local_partition_invalidate()
>>   cpuset: introduce local_partition_update()
>>   cpuset: remove update_parent_effective_cpumask
>>   cpuset: remove redundant partition field updates
>>   cpuset: simplify partition update logic for hotplug tasks
>>   cpuset: unify local partition disable and invalidate
>>   cpuset: use partition_disable for compute_partition_effective_cpumask
>>   cpuset: use validate_local_partition in local_partition_enable
>>   cpuset: introduce validate_remote_partition
>>   cpuset: simplify update_prstate() function
>>   cpuset: remove prs_err clear when notify_partition_change
>>
>>  kernel/cgroup/cpuset.c | 1000 +++++++++++++++++++---------------------
>>  1 file changed, 463 insertions(+), 537 deletions(-)
>>
> 
> Hi Longman,
> 
> I'd appreciate it if you could have a look at this series when you have a moment.
> 

Hi Longman,

Could you kindly take a look at this series when you have a moment?
I'd appreciate any feedback you might have, and I’ll update the series accordingly.

-- 
Best regards,
Ridong


