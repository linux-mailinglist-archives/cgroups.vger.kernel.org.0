Return-Path: <cgroups+bounces-3945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B664940613
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 05:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8F11C210D5
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 03:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8591474A7;
	Tue, 30 Jul 2024 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyrYra8s"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E13EA72
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311293; cv=none; b=thveZJGeGRmBHfWIDt8pX+cNQA9nNv/Qvw/ylqGiXGD/9Bf7bKOezuYYkjqiBCxXQegbwTgb7oJFP1BSkcHbp4uLHtMEGPpAIOYxKQnYzIKy9S3/VEUkGNxibv6II0TNKBAzQKF9hRPH9FRIa280grH7S3Jqe2Tfg7yBkb67BoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311293; c=relaxed/simple;
	bh=UrL0apVcDcTNUcO67Di9Q+tlhdTcFAMwEVqVHiqZkiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pa2teSWjFTYlgfDEsuopFpUe7PFY62IODHKfg+pBf79lFmwffb81406EWCCgaK9QuZ2FMq+vJiwO5phRH19FoJRFOpypXsW0hAoyEtQJcOK6eVQ5sTyGyegX5qJSsaCoyCfc2oQe4IMKn7Nmx5cbeFvtDAb1BmmuErOWWRhPoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyrYra8s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722311290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tByB/lm2Bg50VslDaO35wRMaskah+DZXBMKvzGppraI=;
	b=SyrYra8sYlmjgJ+ZGjgTx4TukmOZML3kZc2KleWYHunHginHmLr9s54mP8fbKmHZlQ1DVO
	7VRHNRKrVte0qH3020QLwI81RFfxnjCwSGSE4Z1y8gsNnjjCr05wRAosZoc+1fXtUovgvh
	OXh6Ud/TzjHgfqWZbUEFtC02AhnvuMc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-i5Ezk1TCPwmfIBFmD1kCtQ-1; Mon,
 29 Jul 2024 23:48:07 -0400
X-MC-Unique: i5Ezk1TCPwmfIBFmD1kCtQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB13D1955D52;
	Tue, 30 Jul 2024 03:48:05 +0000 (UTC)
Received: from [10.2.16.36] (unknown [10.2.16.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFF613000193;
	Tue, 30 Jul 2024 03:48:03 +0000 (UTC)
Message-ID: <8281a529-23d6-45a1-85bb-8b7c0a543084@redhat.com>
Date: Mon, 29 Jul 2024 23:48:02 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: fix panic caused by partcmd_update
To: chenridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730015316.2324188-1-chenridong@huawei.com>
 <0ba00b7c-5292-4242-b648-4ca8d4a457c6@redhat.com>
 <425f1151-14e6-43f6-810e-efe95f6f401e@huawei.com>
 <a93a670c-27fa-4159-a910-ccb17066edc0@redhat.com>
 <a3ff05d8-3acd-4d7d-b2b5-3c512fe93cbf@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a3ff05d8-3acd-4d7d-b2b5-3c512fe93cbf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/29/24 23:46, chenridong wrote:
>
>
> On 2024/7/30 11:15, Waiman Long wrote:
>> On 7/29/24 22:55, chenridong wrote:
>>>
>>>
>>> On 2024/7/30 10:34, Waiman Long wrote:
>>>> On 7/29/24 21:53, Chen Ridong wrote:
>>>>> We find a bug as below:
>>>>> BUG: unable to handle page fault for address: 00000003
>>>>> PGD 0 P4D 0
>>>>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>>> CPU: 3 PID: 358 Comm: bash Tainted: G        W I 6.6.0-10893-g60d6
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>>>>> 1.15.0-1 04/4
>>>>> RIP: 0010:partition_sched_domains_locked+0x483/0x600
>>>>> Code: 01 48 85 d2 74 0d 48 83 05 29 3f f8 03 01 f3 48 0f bc c2 89 
>>>>> c0 48 9
>>>>> RSP: 0018:ffffc90000fdbc58 EFLAGS: 00000202
>>>>> RAX: 0000000100000003 RBX: ffff888100b3dfa0 RCX: 0000000000000000
>>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002fe80
>>>>> RBP: ffff888100b3dfb0 R08: 0000000000000001 R09: 0000000000000000
>>>>> R10: ffffc90000fdbcb0 R11: 0000000000000004 R12: 0000000000000002
>>>>> R13: ffff888100a92b48 R14: 0000000000000000 R15: 0000000000000000
>>>>> FS:  00007f44a5425740(0000) GS:ffff888237d80000(0000) 
>>>>> knlGS:0000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000000100030973 CR3: 000000010722c000 CR4: 00000000000006e0
>>>>> Call Trace:
>>>>>   <TASK>
>>>>>   ? show_regs+0x8c/0xa0
>>>>>   ? __die_body+0x23/0xa0
>>>>>   ? __die+0x3a/0x50
>>>>>   ? page_fault_oops+0x1d2/0x5c0
>>>>>   ? partition_sched_domains_locked+0x483/0x600
>>>>>   ? search_module_extables+0x2a/0xb0
>>>>>   ? search_exception_tables+0x67/0x90
>>>>>   ? kernelmode_fixup_or_oops+0x144/0x1b0
>>>>>   ? __bad_area_nosemaphore+0x211/0x360
>>>>>   ? up_read+0x3b/0x50
>>>>>   ? bad_area_nosemaphore+0x1a/0x30
>>>>>   ? exc_page_fault+0x890/0xd90
>>>>>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>>>>>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>>>>>   ? asm_exc_page_fault+0x26/0x30
>>>>>   ? partition_sched_domains_locked+0x483/0x600
>>>>>   ? partition_sched_domains_locked+0xf0/0x600
>>>>>   rebuild_sched_domains_locked+0x806/0xdc0
>>>>>   update_partition_sd_lb+0x118/0x130
>>>>>   cpuset_write_resmask+0xffc/0x1420
>>>>>   cgroup_file_write+0xb2/0x290
>>>>>   kernfs_fop_write_iter+0x194/0x290
>>>>>   new_sync_write+0xeb/0x160
>>>>>   vfs_write+0x16f/0x1d0
>>>>>   ksys_write+0x81/0x180
>>>>>   __x64_sys_write+0x21/0x30
>>>>>   x64_sys_call+0x2f25/0x4630
>>>>>   do_syscall_64+0x44/0xb0
>>>>>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>> RIP: 0033:0x7f44a553c887
>>>>>
>>>>> It can be reproduced with cammands:
>>>>> cd /sys/fs/cgroup/
>>>>> mkdir test
>>>>> cd test/
>>>>> echo +cpuset > ../cgroup.subtree_control
>>>>> echo root > cpuset.cpus.partition
>>>>> echo 0-3 > cpuset.cpus // 3 is nproc
>>>> What do you mean by "3 is nproc"? Are there only 3 CPUs in the 
>>>> system? What are the value of /sys/fs/cgroup/cpuset.cpu*?
>>> Yes, I tested it with qemu, only 3 cpus are available.
>>> # cat /sys/fs/cgroup/cpuset.cpus.effective
>>> 0-3
>>> This case is taking all cpus away from root, test should fail to be 
>>> a valid root, it should not rebuild scheduling domains.
>> I see. So there are 4 CPUs in the systems. So nproc should be 4. That 
>> is why I got confused when you said nproc is 3. I think you should 
>> clarify this in your patch.
>
> Sorry about that. Is it clear as below?
>
> It can be reproduced with cammands:
> cd /sys/fs/cgroup/
> mkdir test
> cd test/
> echo +cpuset > ../cgroup.subtree_control
> echo root > cpuset.cpus.partition
> # cat /sys/fs/cgroup/cpuset.cpus.effective
> 0-3
> echo 0-3 > cpuset.cpus // taking away all cpus from root

Yes, that looks good to me.

Thanks,
Longman


