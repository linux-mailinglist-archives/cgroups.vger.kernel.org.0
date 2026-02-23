Return-Path: <cgroups+bounces-14170-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLQlCSbOnGllKQQAu9opvQ
	(envelope-from <cgroups+bounces-14170-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:01:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 955CD17DE96
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFE1301ECFC
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044C3793CD;
	Mon, 23 Feb 2026 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ab8IZINj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7E371056
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883680; cv=none; b=swvaa1KCUD0lmnS+ZQgabAFbvOzf/LuuwTseFH3eYTg3j6E3rGs1SCIDCXyBZE2HmEho4OOhdK6m7/htgX44bbO3N43GnpEx8RePMejJqx6eNmwNrGeAhWsDYEN7hOfFdc4NAoUqjUBBDwEftM/dfw2TZIy5WXY3edeEA1vclDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883680; c=relaxed/simple;
	bh=WNHqZIyc8twXb9YJJUScilSCBlovf1//RSYyEGGIf6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vv3ZgaXjNOATDetTayCQEpmOscbXFA+SGFUP2JQSxtgg5j7kZgE1knrrYa6KVAs7h2xBYm3sOeWwo77JVemTdYamoySOU9TF92zwMqXMwFmzxc/vvN5sF1ARpfFHp9aO4S63auPwYxsAFHVLmxC85OWCb6QAtf08EoyEYCyZbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chuyee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ab8IZINj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chuyee.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8a461dd9so26183942eec.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 13:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771883678; x=1772488478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TJ8o71seJqILAPmLfEBrLYSe+t10/7TirblBXHE7XU=;
        b=ab8IZINjoAJfVzx5r4P32Gdk8wd9MskKrOXx/jM0dts+SyKTimG2jxnzpEiCZQGKO4
         3vL+So3Pv7F8tLijCcft7sy6hLoJjQAGJERrxvKutwmQCTR4tnz4jbdZunwB3vd1oRTd
         3m6wIQfPoauCriISRCu1EIW7bvR/Ols84/ppqSvCb5uVsZzizJsTri4ch3uxSWLl65Uv
         VFCdNRTzVXAfdH8Rh2yxV5kOOe8JoxiJHLy/aeKh4n4loCa9AbIiF7n0kQ9QZOZU5saV
         /xAPwLhxklXNYM1+5JJfeZCPNGbD9mRVej2+VKS7OtV6GTAvZB1lVU0H+hYg9vVtxdFo
         AHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883678; x=1772488478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TJ8o71seJqILAPmLfEBrLYSe+t10/7TirblBXHE7XU=;
        b=BjhubWHX5EPmCzbItaDzPOoiuj0j7UwNoPgs32Zm25hFLsfLAAX41UI29Y+gEAUgr4
         AujhSX59WE8GHCJSSorSAI6MFnK/xuuHpZ4PFCgcIFCl2NQZyRbB1Hgg4G9FErlPFUKQ
         gHh1EDp+xsjf7XSUFWvFir48Lc3vRY4FHKIeZca3IgCPNCFGqvzsONOZziIRO2MqF3g3
         cBFmgwzRtOzttcF1WjngLrLDk0XDEXy07paFH2oc7+5XuuaiJ7+2mPasm8ZyWNIqiprN
         s5VSPH0hh8MyZT8xITWyG/YHoplv9LHVLitVMDar8dDzlA7pTMcZl1iQR22ZNSU++J/a
         bUvw==
X-Forwarded-Encrypted: i=1; AJvYcCWsVHHh00/fNlk37fybvwSMkhVSknDi5couzBtc4zvRKcoEzc6eQURBw8MWMzGKY95htvqfS/4M@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeEKshNy54+Vyc2tzuHdoNlwY7mWPVd7auW9nx3zGCelb98Ld
	QCdUldCNArW0AsYTorkWcmmjWeHb/KVv46UdCzq+3R+na5Lh553cRgLr1anFmQk+Kerj7o2lMVx
	eKxY6cg==
X-Received: from dybns8.prod.google.com ([2002:a05:7300:e908:b0:2ba:ab29:61ac])
 (user=chuyee job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6428:b0:2ba:6458:b325
 with SMTP id 5a478bee46e88-2bd7bd0974cmr4574435eec.23.1771883678044; Mon, 23
 Feb 2026 13:54:38 -0800 (PST)
Date: Mon, 23 Feb 2026 21:54:36 +0000
In-Reply-To: <20250213145023.2820193-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213145023.2820193-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260223215436.2669161-1-chuyee@google.com>
Subject: [PATCH v8 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
From: "Zhu, Yi" <chuyee@google.com>
To: bigeasy@linutronix.de
Cc: boqun.feng@gmail.com, cgroups@vger.kernel.org, elver@google.com, 
	gregkh@linuxfoundation.org, hannes@cmpxchg.org, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, paulmck@kernel.org, 
	tglx@linutronix.de, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,linuxfoundation.org,cmpxchg.org,sina.com,suse.com,kernel.org,linutronix.de];
	TAGGED_FROM(0.00)[bounces-14170-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuyee@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 955CD17DE96
X-Rspamd-Action: no action

Hi Sebastian,

We hit a potential ABBA deadlock while running selftests vfio_pci_device_test with this patch.

Thread 1 calls syscall getdents(2) on a kernfs directory: lock B->C->A dependency
  kernfs_fop_readdir()
  -> mutex_lock(&root->kernfs_rwsem): acquired root->kernfs_rwsem (Lock_A)
  -> dir_emit()
    -> filldir()
      -> unsafe_copy_dirent_name(): <- Hit page fault 
        -> do_user_addr_fault()
          -> lock_mm_and_find_vma()
            -> mmap_read_lock_killable(): acquired read mm->mmap_lock (Lock_C): Lock C depends on A
          ...
          -> handle_mm_fault()
            -> handle_pte_fault()
              -> __do_fault()
                -> vm_ops->fault() = vfio_pci_mmap_page_fault()
                  -> vfio_pci_mmap_huge_fault(): will acquire vdev->memory_lock (Lock_B): Lock B depends on C

Thread 2 runs vfio_pci_device_test kernel selftests: lock A->B dependency
  vfio_pci_irq_test__enable_trigger_disable()
  -> vfio_pci_irq_enable()
      -> vfio_pci_core_ioctl(VFIO_DEVICE_SET_IRQS...)
        -> vfio_pci_ioctl_set_irqs()
          -> vfio_irq_enable()
            -> vfio_pci_memory_lock_and_enable(): acquired vdev->memory_lock (Lock_B)
            -> pci_alloc_irq_vectors()
              -> msi_setup_device_data()
                -> msi_sysfs_create_group()
                  -> kernfs_create_dir_ns()
                    -> kernfs_add_one(): will acquire root->kernfs_rwsem (Lock_A): Lock A will depend on B

The full lockdep warning on v6.18 kernel can be found below.
Hardware: Intel Skylake
Kbuild: CONFIG_VFIO=y, CONFIG_IOMMUFD=y
Kernel Parameters: intel_iommu=on
--

[ 1055.224342] ======================================================
[ 1055.224346] WARNING: possible circular locking dependency detected
[ 1055.224349] 6.18.0-dbg-DEV #48 Tainted: G S         O
[ 1055.224353] ------------------------------------------------------
[ 1055.224356] vfio_pci_device/15895 is trying to acquire lock:
[ 1055.224359] ffff94f340a64188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x2d/0x330
[ 1055.224373]
               but task is already holding lock:
[ 1055.224376] ffff94f3f376c960 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_memory_lock_and_enable+0x2a/0x90
[ 1055.224387]
               which lock already depends on the new lock.

[ 1055.224391]
               the existing dependency chain (in reverse order) is:
[ 1055.224395]
               -> #2 (&vdev->memory_lock){++++}-{4:4}:
[ 1055.224400]        down_read+0x3f/0x180
[ 1055.224406]        vfio_pci_mmap_huge_fault+0xbc/0x1a0
[ 1055.224410]        __do_fault+0x46/0x180
[ 1055.224417]        do_pte_missing+0x214/0x1300
[ 1055.224421]        handle_mm_fault+0x795/0xb00
[ 1055.224425]        do_user_addr_fault+0x4b7/0x6d0
[ 1055.224431]        exc_page_fault+0x7d/0xe0
[ 1055.224437]        asm_exc_page_fault+0x26/0x30
[ 1055.224452]
               -> #1 (&mm->mmap_lock){++++}-{4:4}:
[ 1055.224457]        down_read_killable+0x47/0x1b0
[ 1055.224460]        mmap_read_lock_killable+0x12/0x50
[ 1055.224463]        lock_mm_and_find_vma+0x125/0x140
[ 1055.224470]        do_user_addr_fault+0x3d8/0x6d0
[ 1055.224474]        exc_page_fault+0x7d/0xe0
[ 1055.224478]        asm_exc_page_fault+0x26/0x30
[ 1055.224481]        filldir+0xe4/0x1a0
[ 1055.224501]        kernfs_fop_readdir+0x1af/0x2d0
[ 1055.224505]        iterate_dir+0x84/0x160
[ 1055.224510]        __se_sys_getdents+0x6c/0x110
[ 1055.224514]        do_syscall_64+0xf0/0x930
[ 1055.224518]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1055.224521]
               -> #0 (&root->kernfs_rwsem){++++}-{4:4}:
[ 1055.224526]        __lock_acquire+0x15a7/0x2d10
[ 1055.224531]        lock_acquire+0xe8/0x2b0
[ 1055.224534]        down_write+0x3a/0xb0
[ 1055.224537]        kernfs_add_one+0x2d/0x330
[ 1055.224541]        kernfs_create_dir_ns+0xab/0xe0
[ 1055.224545]        internal_create_group+0x19d/0x4f0
[ 1055.224549]        devm_device_add_group+0x49/0x80
[ 1055.224553]        msi_setup_device_data+0x5b/0x100
[ 1055.224557]        pci_setup_msi_context+0x1a/0xa0
[ 1055.224561]        __pci_enable_msix_range+0x19b/0x220
[ 1055.224565]        pci_alloc_irq_vectors_affinity+0xa0/0x130
[ 1055.224568]        vfio_pci_set_msi_trigger+0x12b/0x300
[ 1055.224571]        vfio_pci_core_ioctl+0x84c/0xf20
[ 1055.224575]        vfio_device_fops_unl_ioctl+0x18d/0x350
[ 1055.224581]        __se_sys_ioctl+0x71/0xc0
[ 1055.224585]        do_syscall_64+0xf0/0x930
[ 1055.224588]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1055.224591]
               other info that might help us debug this:

[ 1055.224594] Chain exists of:
                 &root->kernfs_rwsem --> &mm->mmap_lock --> &vdev->memory_lock

[ 1055.224602]  Possible unsafe locking scenario:

[ 1055.224605]        CPU0                    CPU1
[ 1055.224607]        ----                    ----
[ 1055.224610]   lock(&vdev->memory_lock);
[ 1055.224613]                                lock(&mm->mmap_lock);
[ 1055.224616]                                lock(&vdev->memory_lock);
[ 1055.224631]   lock(&root->kernfs_rwsem);
[ 1055.224633]
                *** DEADLOCK ***

[ 1055.224636] 2 locks held by vfio_pci_device/15895:
[ 1055.224639]  #0: ffff94f3f376c728 (&vdev->igate){+.+.}-{4:4}, at: vfio_pci_core_ioctl+0x830/0xf20
[ 1055.224646]  #1: ffff94f3f376c960 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_memory_lock_and_enable+0x2a/0x90
[ 1055.224654]
               stack backtrace:
[ 1055.224657] CPU: 90 UID: 0 PID: 15895 Comm: vfio_pci_device Tainted: G S         O        6.18.0-dbg-DEV #48 NONE
[ 1055.224660] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[ 1055.224660] Hardware name: Google LLC Indus/Indus_QC_00, BIOS 30.116.4 08/29/2025
[ 1055.224662] Call Trace:
[ 1055.224663]  <TASK>
[ 1055.224664]  dump_stack_lvl+0x7d/0xc0
[ 1055.224667]  print_circular_bug+0x2e8/0x300
[ 1055.224670]  check_noncircular+0xff/0x120
[ 1055.224672]  __lock_acquire+0x15a7/0x2d10
[ 1055.224675]  ? __kernfs_new_node+0x8c/0x2b0
[ 1055.224679]  ? kernfs_root+0x16/0x140
[ 1055.224680]  ? kernfs_add_one+0x2d/0x330
[ 1055.224682]  lock_acquire+0xe8/0x2b0
[ 1055.224684]  ? kernfs_add_one+0x2d/0x330
[ 1055.224687]  down_write+0x3a/0xb0
[ 1055.224689]  ? kernfs_add_one+0x2d/0x330
[ 1055.224690]  kernfs_add_one+0x2d/0x330
[ 1055.224693]  kernfs_create_dir_ns+0xab/0xe0
[ 1055.224695]  internal_create_group+0x19d/0x4f0
[ 1055.224698]  devm_device_add_group+0x49/0x80
[ 1055.224700]  msi_setup_device_data+0x5b/0x100
[ 1055.224702]  pci_setup_msi_context+0x1a/0xa0
[ 1055.224703]  __pci_enable_msix_range+0x19b/0x220
[ 1055.224705]  pci_alloc_irq_vectors_affinity+0xa0/0x130
[ 1055.224708]  vfio_pci_set_msi_trigger+0x12b/0x300
[ 1055.224710]  vfio_pci_core_ioctl+0x84c/0xf20
[ 1055.224713]  ? _raw_spin_unlock_irqrestore+0x35/0x50
[ 1055.224717]  vfio_device_fops_unl_ioctl+0x18d/0x350
[ 1055.224720]  __se_sys_ioctl+0x71/0xc0
[ 1055.224722]  do_syscall_64+0xf0/0x930
[ 1055.224724]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1055.224725]  ? exc_page_fault+0x9e/0xe0
[ 1055.224727]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1055.224729] RIP: 0033:0x7fd526765887
[ 1055.224731] Code: cc cc cc 48 8b 05 99 39 07 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 cc cc cc cc cc cc cc cc cc cc b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 39 07 00 f7 d8 64 89 01 48
[ 1055.224733] RSP: 002b:00007ffff5c63438 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1055.224735] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd526765887
[ 1055.224736] RDX: 00007ffff5c63440 RSI: 0000000000003b6e RDI: 0000000000000007
[ 1055.224737] RBP: 00007ffff5c634e0 R08: 0000000020ff67e8 R09: 0000000000000000
[ 1055.224738] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000021a180
[ 1055.224738] R13: 00007fd526836798 R14: 00007ffff5c63c78 R15: 0000000000000001
[ 1055.224743]  </TASK>


> The readdir operation iterates over all entries and invokes dir_emit()
> for every entry passing kernfs_node::name as argument.
> Since the name argument can change, and become invalid, the
> kernfs_root::kernfs_rwsem lock should not be dropped to prevent renames
> during the operation.
> 
> The lock drop around dir_emit() has been initially introduced in commit
>    1e5289c97bba2 ("sysfs: Cache the last sysfs_dirent to improve readdir scalability v2")
> 
> to avoid holding a global lock during a page fault. The lock drop is
> wrong since the support of renames and not a big burden since the lock
> is no longer global.
> 
> Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
> userpace buffer.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  fs/kernfs/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5f0f8b95f44c0..43fbada678381 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1869,10 +1869,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
>  		file->private_data = pos;
>  		kernfs_get(pos);
>  
> -		up_read(&root->kernfs_rwsem);
> -		if (!dir_emit(ctx, name, len, ino, type))
> +		if (!dir_emit(ctx, name, len, ino, type)) {
> +			up_read(&root->kernfs_rwsem);
>  			return 0;
> -		down_read(&root->kernfs_rwsem);
> +		}
>  	}
>  	up_read(&root->kernfs_rwsem);
>  	file->private_data = NULL;

