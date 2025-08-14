Return-Path: <cgroups+bounces-9152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A93B25885
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9C45A61D1
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2B1552FA;
	Thu, 14 Aug 2025 00:45:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC862FF64E;
	Thu, 14 Aug 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132302; cv=none; b=GPGtCiFbaOC9duvws0Hd9k+ch7ttc8KrdkfL54kKV00hhsaa2eP4lJQ3AX5KEvvB9z9cpuQgTLGUmAm07UMzQO2CACcmcvizlV7lCvBV44MAW8IGzkS39VEcN08XPQSICHEE8RuTcayhOZuA4w+sRVeAFBXZI5IINaDAxYPxRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132302; c=relaxed/simple;
	bh=Wt6hmav3wLkFt0xc9QToGleOM54+T5q9i5hftisO7g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDAJT+PxoSIRJ/1n3VCP9g7QGaQT5MPYCf12Of1zZOXuc8Ano52hEZRN/9FUjQDyQSGyV8Yf6S+8DRjxdubIV4l4wbgZXqnvUiJulIbx4xiyTO1x17ERUgZf4QyEGUWNOScuL1GgcKnvb5RbMG46QTq09y7cAWxk/PSticvGJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2RNC5mxGzYQtxg;
	Thu, 14 Aug 2025 08:44:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 69A151A07BB;
	Thu, 14 Aug 2025 08:44:58 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDnrNeJMZ1ocyMmDg--.27924S2;
	Thu, 14 Aug 2025 08:44:58 +0800 (CST)
Message-ID: <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
Date: Thu, 14 Aug 2025 08:44:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
 <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnrNeJMZ1ocyMmDg--.27924S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4Utw15Cw4xGr17CF15urg_yoW8CrWDpF
	n5GFW3JFWjkFn7uw13u3W5WFyrKw4rKa1UGrnxJFy8ZFy2yF12vF1DWasIgryYyrWxCr1j
	vFnF9a1a9FyDJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/14 4:09, Waiman Long wrote:
> On 8/13/25 4:29 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>
>> Replace repetitive locking patterns with new helpers:
>> - cpus_read_cpuset_lock()
>> - cpus_read_cpuset_unlock()
>>
>> This makes the code cleaner and ensures consistent lock ordering.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |  2 ++
>>   kernel/cgroup/cpuset-v1.c       | 12 +++------
>>   kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>   3 files changed, 28 insertions(+), 34 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 75b3aef39231..6fb00c96044d 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>                       char *buf, size_t nbytes, loff_t off);
>>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
>> +void cpus_read_cpuset_lock(void);
>> +void cpus_read_cpuset_unlock(void);
> 
> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also, there is
> now no external user of cpuset_lock/unlock, we may as well remove them from include/linux/cpuset.h.
> 
> Cheers,
> Longman

I like the idea and have considered it.
However, I noticed that cpuset_locked is being used in __sched_setscheduler.

-- 
Best regards,
Ridong


