Return-Path: <cgroups+bounces-5030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5398F827
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA311F21D1C
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D71AD418;
	Thu,  3 Oct 2024 20:37:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DE1A76CE
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987846; cv=none; b=nfir8tYR2i9kHXaeE5wvxdJUHzxZvrHKQhYoEMLpdPLxYPPX/meXLb2htXUZ2l/vC8vBnZ3s5ZatgRUPyne9BlF05ILChLoMpCM8ZszzSvHRqAZAPH6t4UJt00e3eY7JPLisbq2mPA+/gjY12M/kHPQFLbaS+oMO6eM//IYkmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987846; c=relaxed/simple;
	bh=9WfR3E8rL/t4jEdZVyE735sV+wbRLe+GZPcYunM97+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hdr6Vw3noln21I9jxaTiBGSAWFyjAFfFgapVBNZlxQd6XhlB21QqMAkHCl632mvmSwURxm1sRP2OJVlfOe2Xs9bdCaWJKVFXzCT0VhFurMVMHRnvz/awoEU7gU62gZLCXuQCnxCaMloNgVE2NNO8IE25VDXy7veBxLEZjhwMRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so15517945ab.0
        for <cgroups@vger.kernel.org>; Thu, 03 Oct 2024 13:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987843; x=1728592643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTqjy8372TJNApdQHUYuln7NssfJrkTFFq2hUVewtH0=;
        b=uUgPKmzXJH+uj5Tg+tNpTXtnwBdRMic/gsTNT6iVm72t+PIg/0lU1OloXQejaTmCX4
         10pmRzCBWPkinLWk4NOmDw+yerR+uBPoFMw3akxip4WAvqx0urNvLnvOhY1GWr7yNhrq
         8s+RLKvgSPgy/8B3xbB2R3cjhFGqtl1Ss1VdkjNhwAboeRZ2FaE5PklGJur0FArHmKFx
         1scGhTIpouZVyOEa8vjqG45WGTc7Ky+cNUwkbGJCYem2Xi9IA/3kp4c4CX0orKGh/FXk
         hJP7tvjXV4E9SfZ6aR5iBMSBnkRpnnkgRNcaNmfpEoIu+3rEyBfUURlv0DywzPTL+ij0
         Ou3Q==
X-Gm-Message-State: AOJu0YxDORclXWRL/gFFcRq8r9wlEFyY7pZbsypXY0oRae8p23YwOCON
	X9YZLa+DDuj9w1G9XHjz6jRD+7nil2yzlPiCSQbRbxC8X8J/SORcDp+fxA7PA8+4xf1wTlWQ9Nt
	/f5QCfif/qT6Z2kfYNhs5n9taQm/EwXsce+jS7n5nx2GY0sY1KoRCobM=
X-Google-Smtp-Source: AGHT+IGIsJoMCcOcUdlisxRjXIZ1HQtZPB1JPyc1pg8+fp6t7HGKLUAzgaMvI49KLbUIgmEmPHWwRwdE37sLBcEMiJ1195tw3Mar
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a375997255mr5732365ab.7.1727987843224; Thu, 03 Oct 2024
 13:37:23 -0700 (PDT)
Date: Thu, 03 Oct 2024 13:37:23 -0700
In-Reply-To: <0000000000001e66f5061fe3b883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff0083.050a0220.49194.03bb.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in console_lock_spinning_enable
 (5)
From: syzbot <syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	len.brown@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-serial@vger.kernel.org, pavel@ucw.cz, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1237cb9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1637cb9f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f0f580580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/de597512c7c3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
------------------------------------------------------
kworker/0:2/5992 is trying to acquire lock:
ffff80008f7436e0 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x88/0xec kernel/printk/printk.c:1869

but task is already holding lock:
ffff0001b36ade18 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4125 [inline]
ffff0001b36ade18 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x178/0x954 kernel/workqueue.c:4176

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
       __queue_work+0x8b0/0x1308
       queue_work_on+0xe0/0x1a0 kernel/workqueue.c:2392
       queue_work include/linux/workqueue.h:621 [inline]
       rpm_suspend+0xc20/0x1470 drivers/base/power/runtime.c:662
       rpm_idle+0x570/0x8c0 drivers/base/power/runtime.c:536
       __pm_runtime_idle+0x114/0x1d4 drivers/base/power/runtime.c:1104
       pm_runtime_put include/linux/pm_runtime.h:448 [inline]
       __device_attach+0x34c/0x434 drivers/base/dd.c:1047
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1078
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x728/0xa6c drivers/base/core.c:3682
       serial_base_port_add+0x25c/0x370 drivers/tty/serial/serial_base_bus.c:179
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3388 [inline]
       serial_core_register_port+0x2fc/0x1bf4 drivers/tty/serial/serial_core.c:3429
       serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:143
       pl011_register_port+0x1b4/0x44c drivers/tty/serial/amba-pl011.c:2744
       sbsa_uart_probe+0x488/0x608 drivers/tty/serial/amba-pl011.c:2914
       platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
       really_probe+0x38c/0x8fc drivers/base/dd.c:657
       __driver_probe_device+0x194/0x374 drivers/base/dd.c:799
       driver_probe_device+0x78/0x330 drivers/base/dd.c:829
       __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:957
       bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
       __device_attach+0x2b4/0x434 drivers/base/dd.c:1029
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1078
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x728/0xa6c drivers/base/core.c:3682
       platform_device_add+0x3e8/0x6e8 drivers/base/platform.c:716
       platform_device_register_full+0x4f0/0x608 drivers/base/platform.c:844
       acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
       acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2193
       acpi_bus_attach+0x804/0xad4 drivers/acpi/scan.c:2304
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1145
       device_for_each_child+0xec/0x174 drivers/base/core.c:4011
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1157
       acpi_bus_attach+0x868/0xad4 drivers/acpi/scan.c:2309
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1145
       device_for_each_child+0xec/0x174 drivers/base/core.c:4011
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1157
       acpi_bus_attach+0x868/0xad4 drivers/acpi/scan.c:2309
       acpi_bus_scan+0x118/0x4f0 drivers/acpi/scan.c:2590
       acpi_scan_init+0x214/0x6b0 drivers/acpi/scan.c:2727
       acpi_init+0x190/0x254 drivers/acpi/bus.c:1462
       do_one_initcall+0x24c/0x9c0 init/main.c:1267
       do_initcall_level+0x154/0x214 init/main.c:1329
       do_initcalls+0x58/0xac init/main.c:1345
       do_basic_setup+0x8c/0xa0 init/main.c:1364
       kernel_init_freeable+0x324/0x478 init/main.c:1578
       kernel_init+0x24/0x2a0 init/main.c:1467
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #2 (&dev->power.lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xf0/0x180 drivers/base/power/runtime.c:1171
       pm_runtime_get include/linux/pm_runtime.h:396 [inline]
       __uart_start+0x154/0x3d8 drivers/tty/serial/serial_core.c:148
       uart_write+0x154/0x374 drivers/tty/serial/serial_core.c:633
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xaec/0xed0 drivers/tty/n_tty.c:2389
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x410/0x7b8 drivers/tty/tty_io.c:1096
       tty_write drivers/tty/tty_io.c:1117 [inline]
       redirected_tty_write+0xac/0x14c drivers/tty/tty_io.c:1140
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x940/0xc80 fs/read_write.c:590
       ksys_write+0x15c/0x26c fs/read_write.c:643
       __do_sys_write fs/read_write.c:655 [inline]
       __se_sys_write fs/read_write.c:652 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (&port_lock_key){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       pl011_console_write+0x148/0x724 drivers/tty/serial/amba-pl011.c:2316
       console_emit_next_record kernel/printk/printk.c:2983 [inline]
       console_flush_all+0x570/0xafc kernel/printk/printk.c:3049
       console_unlock+0xfc/0x3d4 kernel/printk/printk.c:3118
       vprintk_emit+0x224/0x3a4 kernel/printk/printk.c:2348
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2363
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2373
       register_console+0x6e8/0xa74 kernel/printk/printk.c:3654
       uart_configure_port drivers/tty/serial/serial_core.c:2672 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3200 [inline]
       serial_core_register_port+0x1428/0x1bf4 drivers/tty/serial/serial_core.c:3437
       serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:143
       pl011_register_port+0x1b4/0x44c drivers/tty/serial/amba-pl011.c:2744
       sbsa_uart_probe+0x488/0x608 drivers/tty/serial/amba-pl011.c:2914
       platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
       really_probe+0x38c/0x8fc drivers/base/dd.c:657
       __driver_probe_device+0x194/0x374 drivers/base/dd.c:799
       driver_probe_device+0x78/0x330 drivers/base/dd.c:829
       __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:957
       bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
       __device_attach+0x2b4/0x434 drivers/base/dd.c:1029
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1078
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x728/0xa6c drivers/base/core.c:3682
       platform_device_add+0x3e8/0x6e8 drivers/base/platform.c:716
       platform_device_register_full+0x4f0/0x608 drivers/base/platform.c:844
       acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
       acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2193
       acpi_bus_attach+0x804/0xad4 drivers/acpi/scan.c:2304
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1145
       device_for_each_child+0xec/0x174 drivers/base/core.c:4011
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1157
       acpi_bus_attach+0x868/0xad4 drivers/acpi/scan.c:2309
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1145
       device_for_each_child+0xec/0x174 drivers/base/core.c:4011
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1157
       acpi_bus_attach+0x868/0xad4 drivers/acpi/scan.c:2309
       acpi_bus_scan+0x118/0x4f0 drivers/acpi/scan.c:2590
       acpi_scan_init+0x214/0x6b0 drivers/acpi/scan.c:2727
       acpi_init+0x190/0x254 drivers/acpi/bus.c:1462
       do_one_initcall+0x24c/0x9c0 init/main.c:1267
       do_initcall_level+0x154/0x214 init/main.c:1329
       do_initcalls+0x58/0xac init/main.c:1345
       do_basic_setup+0x8c/0xa0 init/main.c:1364
       kernel_init_freeable+0x324/0x478 init/main.c:1578
       kernel_init+0x24/0x2a0 init/main.c:1467
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
       console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1873
       console_emit_next_record kernel/printk/printk.c:2977 [inline]
       console_flush_all+0x53c/0xafc kernel/printk/printk.c:3049
       console_unlock+0xfc/0x3d4 kernel/printk/printk.c:3118
       vprintk_emit+0x224/0x3a4 kernel/printk/printk.c:2348
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2363
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2373
       __warn_printk+0x27c/0x484 kernel/panic.c:785
       check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
       start_flush_work kernel/workqueue.c:4139 [inline]
       __flush_work+0x21c/0x954 kernel/workqueue.c:4176
       flush_work kernel/workqueue.c:4233 [inline]
       flush_delayed_work+0xcc/0xf8 kernel/workqueue.c:4255
       hfs_file_fsync+0xec/0x148 fs/hfs/inode.c:681
       vfs_fsync_range+0x168/0x188 fs/sync.c:188
       generic_write_sync include/linux/fs.h:2822 [inline]
       dio_complete+0x4f0/0x65c fs/direct-io.c:314
       dio_aio_complete_work+0x28/0x38 fs/direct-io.c:326
       process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x978/0xec4 kernel/workqueue.c:3389
       kthread+0x288/0x310 kernel/kthread.c:389
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

other info that might help us debug this:

Chain exists of:
  console_owner --> &dev->power.lock --> &pool->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pool->lock);
                               lock(&dev->power.lock);
                               lock(&pool->lock);
  lock(console_owner);

 *** DEADLOCK ***

7 locks held by kworker/0:2/5992:
 #0: ffff0000cc19e148 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8 kernel/workqueue.c:3205
 #1: ffff8000a2e57c20 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x6a0/0x15b8 kernel/workqueue.c:3205
 #2: ffff0000c5989620 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
 #2: ffff0000c5989620 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: hfs_file_fsync+0xa0/0x148 fs/hfs/inode.c:674
 #3: ffff80008f74dfa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:325
 #4: ffff0001b36ade18 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4125 [inline]
 #4: ffff0001b36ade18 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x178/0x954 kernel/workqueue.c:4176
 #5: ffff80008f62b000 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x208/0x3a4 kernel/printk/printk.c:2347
 #6: ffff80008f62ac30 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire+0x10/0x4c include/linux/rcupdate.h:330

stack backtrace:
CPU: 0 UID: 0 PID: 5992 Comm: kworker/0:2 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: dio/loop0 dio_aio_complete_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1873
 console_emit_next_record kernel/printk/printk.c:2977 [inline]
 console_flush_all+0x53c/0xafc kernel/printk/printk.c:3049
 console_unlock+0xfc/0x3d4 kernel/printk/printk.c:3118
 vprintk_emit+0x224/0x3a4 kernel/printk/printk.c:2348
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2363
 vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
 _printk+0xdc/0x128 kernel/printk/printk.c:2373
 __warn_printk+0x27c/0x484 kernel/panic.c:785
 check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
 start_flush_work kernel/workqueue.c:4139 [inline]
 __flush_work+0x21c/0x954 kernel/workqueue.c:4176
 flush_work kernel/workqueue.c:4233 [inline]
 flush_delayed_work+0xcc/0xf8 kernel/workqueue.c:4255
 hfs_file_fsync+0xec/0x148 fs/hfs/inode.c:681
 vfs_fsync_range+0x168/0x188 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2822 [inline]
 dio_complete+0x4f0/0x65c fs/direct-io.c:314
 dio_aio_complete_work+0x28/0x38 fs/direct-io.c:326
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
workqueue: WQ_MEM_RECLAIM dio/loop0:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 0 PID: 5992 at kernel/workqueue.c:3706 check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
Modules linked in:
CPU: 0 UID: 0 PID: 5992 Comm: kworker/0:2 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: dio/loop0 dio_aio_complete_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
lr : check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
sp : ffff8000a2e57790
x29: ffff8000a2e57790 x28: 0000000000000000 x27: 1fffe0001858492b
x26: 0000000000000000 x25: ffff8000927b6000 x24: ffff0000cc19e000
x23: dfff800000000000 x22: ffff0000d12a2e18 x21: ffff0000cc19e170
x20: ffff800081211778 x19: ffff0000c0029000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800083032784 x15: 0000000000000001
x14: 1fffe000366d325a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 9770cdebfc84a400
x8 : 9770cdebfc84a400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a2e56ed8 x4 : ffff80008f65b620 x3 : ffff8000806051a0
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 check_flush_dependency+0x27c/0x330 kernel/workqueue.c:3702
 start_flush_work kernel/workqueue.c:4139 [inline]
 __flush_work+0x21c/0x954 kernel/workqueue.c:4176
 flush_work kernel/workqueue.c:4233 [inline]
 flush_delayed_work+0xcc/0xf8 kernel/workqueue.c:4255
 hfs_file_fsync+0xec/0x148 fs/hfs/inode.c:681
 vfs_fsync_range+0x168/0x188 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2822 [inline]
 dio_complete+0x4f0/0x65c fs/direct-io.c:314
 dio_aio_complete_work+0x28/0x38 fs/direct-io.c:326
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 73714
hardirqs last  enabled at (73713): [<ffff80008b3388f8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (73713): [<ffff80008b3388f8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (73714): [<ffff80008b42e1b4>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (73714): [<ffff80008b42e1b4>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
softirqs last  enabled at (73712): [<ffff8000801f8e88>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (73712): [<ffff8000801f8e88>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (73693): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

