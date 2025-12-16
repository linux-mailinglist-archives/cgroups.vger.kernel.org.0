Return-Path: <cgroups+bounces-12383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343ACC54A2
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 23:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6F1301764D
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 22:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4F31AF1E;
	Tue, 16 Dec 2025 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5zH3lZ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4idtTs3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8352DEA87
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922623; cv=none; b=DmLCu6VsFd22kjgfqn1/NrZJiaRbdW2ASr6Yda7HhaSCLyK6Z2ow9NERvLW9Euib8Tv9efDYpM1fU3gQmL1BZP4jBoO4f9A0xd0hPHc6WovtJdoGEtEYH1Pur0scALltS1XBU83Xla7+gyurpMOyRlSLMAe3BMxSZy6JSou5VfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922623; c=relaxed/simple;
	bh=e3TenpmgcFVEvaNzqb/nU1G3X4PBKD+pPlREWlxrSnY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mzFSdT71xs1CoYk0ZmREK5mwo03Sbc41RjKg28XQ5voFARfpqRHx9trdoR9LeNlUfVFhvYRHM/RaBY28+4suzVQbp+BqTSw2eZHXK5GhFpiNkbIH3JTFWasTlGDWeQnVe9CGF8bfhds/zZSnMwr3Avyv9oTw7bKR+G19X1gISaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5zH3lZ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4idtTs3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765922620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKSyqNo+qzV1NGIPWzMplW/8Mdv5v7QuwcXiszFReS4=;
	b=R5zH3lZ6PKCeg8GtNt9lEaQoKY7MdySxh2MUdhFFybOExmFNpATfrES36ycDgQlZvTJZnY
	2QRcpFa0OWzvggsHJvQxRJL8dGOdA9l5T9o2WdMNJfsY75cZWlCNlErqeHGFsCy5Q29+6i
	Rjw12nFP9Owc7p4hqEcd8gn/ysXP4nM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648--e27WtPLP0WU_jZt_ar-Ug-1; Tue, 16 Dec 2025 17:03:39 -0500
X-MC-Unique: -e27WtPLP0WU_jZt_ar-Ug-1
X-Mimecast-MFC-AGG-ID: -e27WtPLP0WU_jZt_ar-Ug_1765922619
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee416413a8so59901751cf.1
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 14:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765922618; x=1766527418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKSyqNo+qzV1NGIPWzMplW/8Mdv5v7QuwcXiszFReS4=;
        b=e4idtTs3TqPo95InbS+h/1qOVuB1q9moyov0Q7JMBnsihb+q1q0U47ZChzefh8t3cZ
         86Ky9qo3fCF0AkJ0BRg+09NxWCneSo50OnrTx2W9tweu3ufGGhWJAUmsx5i8AEVtva54
         iRg37Z6iSJDr0n5jHNrdYrMcPYTt6mjC726c5+dXQ8G6V3qkMmK1l2MQIRxtxyoaF3ZU
         4/F8p3s+poOBfd+PygP/HRbIB38xoTMbYIr1jn7QWQyaZPp/szU0CBvszLT6BE8Jo9ts
         2tUDM5Y46e0HMk2bsRxoQqQmov4RoFzHHD8y91i7D1p4iyIqNROMzFwpz13iyL3tgs3i
         W8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765922618; x=1766527418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKSyqNo+qzV1NGIPWzMplW/8Mdv5v7QuwcXiszFReS4=;
        b=tQ/V8xxf181DguD8JVKOcLIMeqiTEWvRqy25F9ZSYrsCrBYabzPOkANrlC600HTXFO
         mDKzsg7op8fgS93M7mktaxDQqfABHbp1RRLdco7/VOegTxkpSmHVxj99/0Jaqkq4fWBU
         7J2/dPnEHyjNE3UOnYEay4lo9qQwlupc9aDjqhO+APHS/gHEysJTJTKtt4/ZFYdHH67T
         nH5J35OoG2ACkhYy1TitbNpejgSijNlHLvcOZJsE3bKozEhg3kSN/94HVRaVkFGvykbw
         h6UuoomyALyi+0pQFSgYRwCaV6QtQIeSknF6MuZ3RgQL5DF9gbrQdnVu0WdLi+IKpXtz
         oGVA==
X-Gm-Message-State: AOJu0Yw0SI+DlvzNUbBFrFk+eqpqfKcrzQ6GPWTdnZuxH8Qkfh4yrAO1
	AanZNWXizSGcLl6m2y9bwmvpJspFF407bbCyOZi1aTm3tulbzIFsj9HOFt+Y2VkMiqrplyeIs2w
	PBUQkJT5jaHF4F8o1K1dSZsYh/64CudBgNRnz/kTEZW/zVtQab83kvJ42Izoe7hsxDyQ=
X-Gm-Gg: AY/fxX74dAES4OfsRpIohjFRNprkpG5R6t96hsCO2btLA1NhDDoyCmWW4qsQDgBXgzh
	WiOMPbJdbNdRK/P4ZLvVBeo43Ad1LleSxsMLpAZmGHQhSwNXg6D6KSvWgcex80jCjMFHkkFbaen
	FJAWdCEOy+B9JLZ0wf9ONj9nL6X9sAiztyUO1D9sTaKmzYIMQhYSSDl2hxeQIQv+37DI6S0iBWj
	O58lakl+d1UJX2jI7uTBUui7smssvzbU8yQEkbPZpbRmQc+tRPDXmUNK0m02ISZpMrzN26+dv+d
	RVZ/yxlJ1GM9C38MDJwrPbvCb18ng62IBPUDKxEBMj8Ro8nHJsrymy5xsE/DmqktwWN0403+Um3
	Cd6/9E0r8Odgk2+76qvT9SmQ4y50J0md+nxB7d+4RIXwGajh46sghakbN
X-Received: by 2002:ac8:7f03:0:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4f1d066fd5bmr202793881cf.81.1765922618373;
        Tue, 16 Dec 2025 14:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2IvNcFtgZ1tmGHRbYL8jwXE0r7cFYjVpSDcf2E/jDoUWlpl7oW5x1GOf7y7WVQtieDMdG3Q==
X-Received: by 2002:ac8:7f03:0:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4f1d066fd5bmr202793541cf.81.1765922617865;
        Tue, 16 Dec 2025 14:03:37 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c7dfbfsm21681741cf.31.2025.12.16.14.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 14:03:37 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0d057037-f1ef-4c8c-a843-42ad78581816@redhat.com>
Date: Tue, 16 Dec 2025 17:03:36 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: fix warning when disabling remote partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251127030450.1611804-1-chenridong@huaweicloud.com>
 <d43bc75d-0a5f-41e7-b127-df6c3d26f44b@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d43bc75d-0a5f-41e7-b127-df6c3d26f44b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 9:56 PM, Chen Ridong wrote:
> On 2025/11/27 11:04, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A warning was triggered as follows:
>>
>> WARNING: kernel/cgroup/cpuset.c:1651 at remote_partition_disable+0xf7/0x110
>> RIP: 0010:remote_partition_disable+0xf7/0x110
>> RSP: 0018:ffffc90001947d88 EFLAGS: 00000206
>> RAX: 0000000000007fff RBX: ffff888103b6e000 RCX: 0000000000006f40
>> RDX: 0000000000006f00 RSI: ffffc90001947da8 RDI: ffff888103b6e000
>> RBP: ffff888103b6e000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: ffff88810b2e2728 R12: ffffc90001947da8
>> R13: 0000000000000000 R14: ffffc90001947da8 R15: ffff8881081f1c00
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f55c8bbe0b2 CR3: 000000010b14c000 CR4: 00000000000006f0
>> Call Trace:
>>   <TASK>
>>   update_prstate+0x2d3/0x580
>>   cpuset_partition_write+0x94/0xf0
>>   kernfs_fop_write_iter+0x147/0x200
>>   vfs_write+0x35d/0x500
>>   ksys_write+0x66/0xe0
>>   do_syscall_64+0x6b/0x390
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> RIP: 0033:0x7f55c8cd4887

Sorry for the late reply. I was in the Linux Plumbers Conference last 
week and so didn't time to fully review it.

>>
>> Reproduction steps (on a 16-CPU machine):
>>
>>          # cd /sys/fs/cgroup/
>>          # mkdir A1
>>          # echo +cpuset > A1/cgroup.subtree_control
>>          # echo "0-14" > A1/cpuset.cpus.exclusive
>>          # mkdir A1/A2
>>          # echo "0-14" > A1/A2/cpuset.cpus.exclusive
>>          # echo "root" > A1/A2/cpuset.cpus.partition
>>          # echo 0 > /sys/devices/system/cpu/cpu15/online
>>          # echo member > A1/A2/cpuset.cpus.partition
>>
>> When CPU 15 is offlined, subpartitions_cpus gets cleared because no CPUs
>> remain available for the top_cpuset, forcing partitions to share CPUs with
>> the top_cpuset. In this scenario, disabling the remote partition triggers
>> a warning stating that effective_xcpus is not a subset of
>> subpartitions_cpus. Partitions should be invalidated in this case to
>> inform users that the partition is now invalid(cpus are shared with
>> top_cpuset).

This is real corner case as such a scenario should rarely happen in a 
real production environment.


>>
>> To fix this issue:
>> 1. Only emit the warning only if subpartitions_cpus is not empty and the
>>     effective_xcpus is not a subset of subpartitions_cpus.
>> 2. During the CPU hotplug process, invalidate partitions if
>>     subpartitions_cpus is empty.
>>
>> Fixes: 4449b1ce46bf ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index fea577b4016a..fbe539d66d9b 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1648,7 +1648,14 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>>   static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>>   {
>>   	WARN_ON_ONCE(!is_remote_partition(cs));
>> -	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
>> +	/*
>> +	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
>> +	 * which should clear subpartitions_cpus. We should not emit a warning for this
>> +	 * scenario: the hierarchy is updated from top to bottom, so subpartitions_cpus
>> +	 * may already be cleared when disabling the partition.
>> +	 */
>> +	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus) &&
>> +		     !cpumask_empty(subpartitions_cpus));
>>   
>>   	spin_lock_irq(&callback_lock);
>>   	cs->remote_partition = false;
>> @@ -3956,8 +3963,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>>   	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
>>   		compute_partition_effective_cpumask(cs, &new_cpus);
>>   
>> -	if (remote && cpumask_empty(&new_cpus) &&
>> -	    partition_is_populated(cs, NULL)) {
>> +	if (remote && (cpumask_empty(subpartitions_cpus) ||
>> +			(cpumask_empty(&new_cpus) &&
>> +			 partition_is_populated(cs, NULL)))) {
>>   		cs->prs_err = PERR_HOTPLUG;
>>   		remote_partition_disable(cs, tmp);
>>   		compute_effective_cpumask(&new_cpus, cs, parent);
>> @@ -3970,9 +3978,12 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>>   	 * 1) empty effective cpus but not valid empty partition.
>>   	 * 2) parent is invalid or doesn't grant any cpus to child
>>   	 *    partitions.
>> +	 * 3) subpartitions_cpus is empty.
>>   	 */
>> -	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
>> -				tasks_nocpu_error(parent, cs, &new_cpus)))
>> +	if (is_local_partition(cs) &&
>> +	    (!is_partition_valid(parent) ||
>> +	     tasks_nocpu_error(parent, cs, &new_cpus) ||
>> +	     cpumask_empty(subpartitions_cpus)))
>>   		partcmd = partcmd_invalidate;
>>   	/*
>>   	 * On the other hand, an invalid partition root may be transitioned
> Friendly ping.
Reviewed-by: Waiman Long <longman@redhat.com


