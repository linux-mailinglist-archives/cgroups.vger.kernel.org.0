Return-Path: <cgroups+bounces-13008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDCFD07627
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 07:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B04333037696
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC1299A87;
	Fri,  9 Jan 2026 06:22:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A34287517;
	Fri,  9 Jan 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939748; cv=none; b=USYC9cnwv5CVQvplU5rcZh4Pmj0SZVOCG6zr6uMqg6EF/uXwD22N0vyhQuurME6ZGf/QlZHRv2VjvlhIJHNXRS3D3NKX2iTfdUdZBpNCeDH1uKLTvfHPg0bCFJrBVQrtilwnLQJWqAV1R+wLP3jaGh12PpYHYNb2My1nLvzbKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939748; c=relaxed/simple;
	bh=w0330BGIWmi7mp7CkC76lDurCaat5GIPaj+F36EaUqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDkIhheeKfp7A7gSQIVPsTA/QLNVMF/Zrj/tyr9NnGdRZeFvnAYTP8+abD/NRmm8oeJL685iJtq4ruIgSrCdfT92AIlM6Ueaq3vzfvVjPloPE7u8F4X1VrAPa2bZ6f14wlyxFbigxzJNq3rRJA9UdtXDBJ857qyJhoxrXAIr02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dnWs01nBWzYQts3;
	Fri,  9 Jan 2026 14:22:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 18B8B40579;
	Fri,  9 Jan 2026 14:22:17 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPmXnmBpHNShDA--.7943S3;
	Fri, 09 Jan 2026 14:22:16 +0800 (CST)
Message-ID: <5fdbd368-6d00-4453-8f03-23d17c8c1338@huaweicloud.com>
Date: Fri, 9 Jan 2026 14:22:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy() racing
 with blkg_free_workfn()
To: yukuai@fnnas.com
Cc: hch@infradead.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 zhengqixing@huawei.com
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
 <72dc0ed6-1ba9-46b8-a43f-d11c32e2f341@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <72dc0ed6-1ba9-46b8-a43f-d11c32e2f341@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPmXnmBpHNShDA--.7943S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar45Ww1kAFyUAr1rtFWDArb_yoW7Zr47pr
	1DA3yxCr48Za48ArWa9r15Kw1qqFs7CF47tr97Aa1j9rWDG3y8tFn0vryvqwnrGrW8uF12
	vF1jvryrKFy7Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2026/1/9 0:11, Yu Kuai 写道:
> This looks correct, however, I think it's better also to protect q->blkg_list iteration from
> blkcg_activate_policy() and blkg_destroys_all() as well. This way all the q->blkg_list access
> will be protected by blkcg_mutex, and it'll be easier to convert protecting blkg from queue_lock
> to blkcg_mutex.

I tried adding blkcg_mutex protection in blkcg_activate_policy() and 
blkg_destroy_all() as suggested.

Unfortunately, the UAF still occurs even with proper mutex protection.

The mutex successfully protects the list structure during traversal 
won't be added/removed from

q->blkg_list while we hold the lock. However, this doesn't prevent the 
same blkg from being released

twice.

[  108.677948][    C0] 
==================================================================
[  108.678541][    C0] BUG: KASAN: slab-use-after-free in 
rcu_cblist_dequeue+0xb1/0xe0
[  108.679117][    C0] Read of size 8 at addr ffff888108ee9e48 by task 
swapper/0/0
[  108.679654][    C0]
[  108.679827][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
6.6.0-ga7706cf69006-dirty #43
[  108.680437][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.16.1-2.fc37 04/01/2014
[  108.681125][    C0] Call Trace:
[  108.681369][    C0]  <IRQ>
[  108.684870][    C0]  rcu_cblist_dequeue+0xb1/0xe0
[  108.685239][    C0]  rcu_do_batch+0x24c/0xd80
[  108.686892][    C0]  rcu_core+0x4d1/0x7d0
[  108.687205][    C0]  handle_softirqs+0x1ca/0x720
[  108.687561][    C0]  irq_exit_rcu+0x141/0x1a0
[  108.687896][    C0]  sysvec_apic_timer_interrupt+0x6e/0x90
[  108.689218][    C0] RIP: 0010:pv_native_safe_halt+0xb/0x10
[  108.689642][    C0] Code: 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 97 d9 
3d 00 fb f4 <e9> 50 ce 02 00 90 90 90 90 90 90 90 90 90 90 90 90 90 9b
[  108.691075][    C0] RSP: 0018:ffffffff9cc07e00 EFLAGS: 00000206
[  108.691537][    C0] RAX: 0000000000000006 RBX: 0000000000000000 RCX: 
ffffffff9b280422
[  108.692129][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffffff97b74d45
[  108.692714][    C0] RBP: 0000000000000000 R08: 0000000000000001 R09: 
ffffed10e3602165
[  108.693305][    C0] R10: ffff88871b010b2b R11: 0000000000000000 R12: 
1ffffffff3980fc5
[  108.693892][    C0] R13: ffffffff9cc88ec0 R14: dffffc0000000000 R15: 
0000000000014810
[  108.695293][    C0]  default_idle+0x5/0x10
[  108.695594][    C0]  default_idle_call+0x97/0x1d0
[  108.695942][    C0]  cpuidle_idle_call+0x1e5/0x270
[  108.697162][    C0]  do_idle+0xef/0x150
[  108.697454][    C0]  cpu_startup_entry+0x51/0x60
[  108.698108][    C0]  rest_init+0x1cc/0x320
[  108.698410][    C0]  arch_call_rest_init+0xf/0x30
[  108.698761][    C0]  start_kernel+0x392/0x400
[  108.699085][    C0]  x86_64_start_reservations+0x14/0x30
[  108.699474][    C0]  x86_64_start_kernel+0x9b/0xa0
[  108.699822][    C0]  secondary_startup_64_no_verify+0x194/0x19b
[  108.700255][    C0]  </TASK>
[  108.700477][    C0]
[  108.700644][    C0] Allocated by task 1045:
[  108.700948][    C0]  kasan_save_stack+0x1c/0x40
[  108.701293][    C0]  kasan_set_track+0x21/0x30
[  108.701617][    C0]  __kasan_kmalloc+0x8b/0x90
[  108.701946][    C0]  blkg_alloc+0xbc/0x940
[  108.702251][    C0]  blkg_create+0xcf6/0x13d0
[  108.702576][    C0]  blkg_lookup_create+0x47b/0x810
[  108.702935][    C0]  bio_associate_blkg_from_css+0x1a0/0x8c0
[  108.703354][    C0]  bio_associate_blkg+0xa2/0x190
[  108.703704][    C0]  bio_init+0x272/0x8d0
[  108.704000][    C0]  bio_alloc_bioset+0x454/0x770
[  108.704350][    C0]  ext4_bio_write_folio+0x68e/0x10d0
[  108.704729][    C0]  mpage_submit_folio+0x14a/0x2b0
[  108.705090][    C0]  mpage_process_page_bufs+0x1b1/0x390
[  108.705492][    C0]  mpage_prepare_extent_to_map+0xa91/0x1060
[  108.705915][    C0]  ext4_do_writepages+0x9af/0x1d60
[  108.706288][    C0]  ext4_writepages+0x281/0x5a0
[  108.706634][    C0]  do_writepages+0x165/0x5f0
[  108.707057][    C0]  filemap_fdatawrite_wbc+0x111/0x170
[  108.707450][    C0]  __filemap_fdatawrite_range+0x9d/0xd0
[  108.707851][    C0]  file_write_and_wait_range+0x97/0x110
[  108.708251][    C0]  ext4_sync_file+0x1fb/0xb60
[  108.708592][    C0]  __x64_sys_fsync+0x55/0x90
[  108.708932][    C0]  do_syscall_64+0x6b/0x120
[  108.709262][    C0]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[  108.709690][    C0]
[  108.709867][    C0] Freed by task 338:
[  108.710150][    C0]  kasan_save_stack+0x1c/0x40
[  108.710496][    C0]  kasan_set_track+0x21/0x30
[  108.710835][    C0]  kasan_save_free_info+0x27/0x40
[  108.711203][    C0]  __kasan_slab_free+0x106/0x180
[  108.711564][    C0]  __kmem_cache_free+0x1dd/0x470
[  108.711923][    C0]  process_one_work+0x774/0x13a0
[  108.712288][    C0]  worker_thread+0x6eb/0x12c0
[  108.712631][    C0]  kthread+0x29f/0x360
[  108.712928][    C0]  ret_from_fork+0x30/0x70
[  108.713251][    C0]  ret_from_fork_asm+0x1b/0x30


