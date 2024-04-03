Return-Path: <cgroups+bounces-2289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D0897178
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5991C263F8
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1BB148844;
	Wed,  3 Apr 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAnq1OxB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956B14830F
	for <cgroups@vger.kernel.org>; Wed,  3 Apr 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151992; cv=none; b=K0dOZs9exTijHlwGp7Gy+kna6cZA0I1Bv2LmdSaEb3d6jRfwpFwdrZEO1hGHouSiqcq2NM7kO9dUqxJpxcN3aJWCIr6RYwhVET3bLYdeI47wK6vFPvWmSRj8coGh/LInOuXCabHCj2MqB5hUGSdkx7viggIvvNOq2+iqD/z7PWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151992; c=relaxed/simple;
	bh=tkJNBlE+azjHfuN+qTWSVtGlKcW+lyA6yAnCrxz0si4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUaTsSIJniIwhMTYi2YN6Pa4DHNghWR+A1Lv/j5C6mn8hqZS5h10pIJN9ZG8PhXdZjjbtrOlM2axmDFEzGZztyDWlGj8kPLw0ZANUCNbLiUtSlRUAmEu4jDq08JGN2ih0goG5y9SdwUDcJS/RW5AhRsOO+peBGCTnFTszQzt31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAnq1OxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712151989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5njsq27kAwiBFtlgchtw0wHtXa6EUfl9Vkl4lFScYQg=;
	b=VAnq1OxBVKkVqr7q1ExUM8IznYVr7rM0zNW8IIh9tLfovkVfhREdeKCZ5p6erQ9ekJOk3s
	gfjY1MerK/yqsJ9MJ27k1JRlJ3TudD0N3mSAIsDeE9E1aU+pMCvwlHHK6eRN5mU2RGJvHy
	RReafY7D6d8x3vl1bFqMOhExZNecChA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-Rexn_fZcPXSqKFYZooRhfQ-1; Wed,
 03 Apr 2024 09:46:25 -0400
X-MC-Unique: Rexn_fZcPXSqKFYZooRhfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DA363816B42;
	Wed,  3 Apr 2024 13:46:25 +0000 (UTC)
Received: from [10.22.33.218] (unknown [10.22.33.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6613240C6CC0;
	Wed,  3 Apr 2024 13:46:24 +0000 (UTC)
Message-ID: <712a47ae-9383-4f6d-9f02-e29a84e69574@redhat.com>
Date: Wed, 3 Apr 2024 09:46:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: fix race between rebuild scheduler domains and
 hotplug work
Content-Language: en-US
To: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org, daniel.m.jordan@oracle.com
Cc: peterz@infradead.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangweiyang2@huawei.com, lujialin4@huawei.com,
 xiujianfeng@huawei.com, caixinchen1@huawei.com
References: <20240403085245.335072-1-chenridong@huawei.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240403085245.335072-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 4/3/24 04:52, Chen Ridong wrote:
> When offlining cpus, it holds cpu_hotplug_lock and call
> cpuset_hotplug_workfn asynchronously, which holds and releases
> cpuset_mutex repeatly to update cpusets, and it will release
> cpu_hotplug_lock before cpuset_hotplug_workfn finish. It means that some
> interfaces like cpuset_write_resmask holding two locks may rebuild
> scheduler domains when some cpusets are not refreshed, which may lead to
> generate domains with offlining cpus and will panic.
>
> As commit 406100f3da08 ("cpuset: fix race between hotplug work and later
>   CPU offline")  mentioned. This problem happen in cgroup v2:
>
> This problem can also happen in cgroup v1 pressure test, which onlines
> and offlines cpus, and sets cpuset.cpus to rebuild domains with
> sched_load_balance off.
>
> smpboot: CPU 1 is now offline
> BUG: unable to handle page fault for address: 0000342bad598668
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 54 PID: 9966 Comm: sh Kdump: loaded Tainted: G S         OE      6.8.0-rc7+ #5
> Hardware name: Powerleader PR2715P3/T1DM-E2, BIOS OEM57.22 11/23/2021
> RIP: 0010:sd_init+0x204/0x390
> Code: 00 02 00 00 a8 80 0f 84 ad 00 00 00 41 c7 44 24 2c 6e 00 00 00 85 d2 74 2f 48 63 54 24 18 49 8b 45 20 48 8b 14 d5 60 0b 79 ab <48> 8b 04 02 49 89 84 24 10 01 00 00 f0 ff 00 49 8b 84 24 10 01 00
> RSP: 0018:ffff9f90669afc18 EFLAGS: 00010206
> RAX: 0000342c00e62668 RBX: 0000000000000000 RCX: 00000000ffffffa0
> RDX: ffffffffac736000 RSI: 0000000000000060 RDI: ffff8b24b8143930
> RBP: ffff8b24b8143920 R08: 0000000000000060 R09: ffff8b2635783670
> R10: 0000000000000001 R11: 0000000000000001 R12: ffff8b24b8143800
> R13: ffff8ae687511600 R14: ffffffffabc6b9b0 R15: ffff8b25c0040ea0
> FS:  00007fd93c734740(0000) GS:ffff8b24bca00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000342bad598668 CR3: 00000001e0934005 CR4: 00000000007706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x82/0x150
>   ? local_clock_noinstr+0xf/0xb0
>   ? exc_page_fault+0x69/0x1b0
>   ? asm_exc_page_fault+0x26/0x30
>   ? sd_init+0x204/0x390
>   ? sd_init+0x11c/0x390
>   build_sched_domains+0x171/0x640
>   partition_sched_domains_locked+0x2a1/0x3c0
>   rebuild_sched_domains_locked+0x14f/0x200
>   update_cpumask+0x27c/0x5f0
>   cpuset_write_resmask+0x423/0x530
>   kernfs_fop_write_iter+0x160/0x220
>   vfs_write+0x355/0x480
>   ksys_write+0x69/0xf0
>   do_syscall_64+0x66/0x180
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7fd93c4fc907
> Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007fff153c7f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd93c4fc907
> RDX: 0000000000000002 RSI: 000055d055679900 RDI: 0000000000000001
> RBP: 000055d055679900 R08: 00007fd93c5b01e0 R09: 00007fd93c5b0260
> R10: 00007fd93c5b0160 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007fd93c5f25a0 R14: 0000000000000002 R15: 00007fd93c5f27a0
>
> It must guarantee that cpus in domains passing to
> partition_and_rebuild_sched_domains must be active. So the domains should
> be checked after generate_sched_domains.
>
> Fixes: 0ccea8feb980 ("cpuset: Make generate_sched_domains() work with partition")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

We are in the process of taking out cpuset_hotplug_workfn() and make the 
hotplug operation synchronous again. See

https://lore.kernel.org/lkml/20240401145858.2656598-1-longman@redhat.com/

That should eliminate this particular problem that you have.

Cheers,
Longman

> ---
>   kernel/cgroup/cpuset.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 927bef3a598a..0e0d469c2591 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1210,6 +1210,7 @@ static void rebuild_sched_domains_locked(void)
>   	cpumask_var_t *doms;
>   	struct cpuset *cs;
>   	int ndoms;
> +	int i;
>   
>   	lockdep_assert_cpus_held();
>   	lockdep_assert_held(&cpuset_mutex);
> @@ -1251,6 +1252,12 @@ static void rebuild_sched_domains_locked(void)
>   	/* Generate domain masks and attrs */
>   	ndoms = generate_sched_domains(&doms, &attr);
>   
> +	/* guarantee no CPU offlining in doms */
> +	for (i = 0; i < ndoms; ++i) {
> +		if (!cpumask_subset(doms[i], cpu_active_mask))
> +			return;
> +	}
> +
>   	/* Have scheduler rebuild the domains */
>   	partition_and_rebuild_sched_domains(ndoms, doms, attr);
>   }


