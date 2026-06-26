Return-Path: <cgroups+bounces-17304-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyXjHNkJPmrK+wgAu9opvQ
	(envelope-from <cgroups+bounces-17304-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 07:10:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3036CA39A
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 07:10:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17304-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17304-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7BE3036637
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 05:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B683542F6;
	Fri, 26 Jun 2026 05:10:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB923BD1B
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 05:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782450646; cv=none; b=PlxMiTtqG8YyLLTlHynbA0l6sxhMpH0ETSXTlzewjok0VCLmsH1vs7X32uuV9Yis0vs+NyBGDMzzanfoAaaIeflQdi64VJiJuSQm7AjxgPg9DE6E7XJMzS2KIly5WMaF2k3PFUD4QuiY7sl498wWRVXQOg1Jj2LKCuKZTAQyJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782450646; c=relaxed/simple;
	bh=E1AnKSkvy/SR7910eEeXX6LnKezjUXwr4DVkJG9Xr6U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WEffjvpHfkYvdimV3qRBXqTmpy0MDclTPFy6k14SfpfMKrIOba++3sEbkfrsdFJlhJjs1s5hXsj4Tx7RGzaNU7qz4Y3ACxOLikRUccedtPR3+PKlJDE4gUbXlRnIfUm4S0hoCD399j9Uu+d3VBtIsgcdgV4EnrIi3a/GxuqRTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-48656ba24fdso813071b6e.2
        for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 22:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782450644; x=1783055444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqVuhnGlA98jHg+WNh0FbxGqsq0xgE7hvDd90gJez9Q=;
        b=naB9h+GpiaCA9WFmDhuvqHUM12yWaNa16+Z95R0HtBhKMOn1JnCp4ZagpktpgXmXpo
         kkM7DokUtg1qNbb3iYijQnOb0EfbltJc05BlGVKe0OvurD2/YQzOLW0rAUMM5zJW4kPP
         gS/H2v/Ah5PxH0Kwwl0llJIHNIPw8O1+053lp2DH0RLgf1UJLhCYSRa5qQkXmysHVaob
         FceYCfvxbsNvJw6oeOPQRmyOhWRvD6yEoca+6fpXxo795EFBZO8Yj/ZgNuBR3nseawHX
         kAby74BmdKgoqzsWW1V8/Id1aPKowsHdpw8i/l6EloF3YZNhZP1KGUHNTfE490U0tq7c
         26GQ==
X-Gm-Message-State: AOJu0YwosNbLX5vmwqGJaRnT8otxyBcuwI61rZP9fcMVE0FVCJymSN9t
	MkuEFqV1c5b/CuWL7nlGe1uv9OvaFBt3CF/IS1K06altKMrj++oEw+ucymFHaLPoi/55WleriGN
	HcZfHefNgdwRw+sKWNVtOWD5duzICc75eZmc8LDKAld95uYZnGPLXlr/f5VPG1g==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a15:b0:48a:9afa:e632 with SMTP id
 5614622812f47-49217721971mr4241241b6e.27.1782450644117; Thu, 25 Jun 2026
 22:10:44 -0700 (PDT)
Date: Thu, 25 Jun 2026 22:10:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3e09d4.ac7367b4.6675.0003.GAE@google.com>
Subject: [syzbot] [cgroups?] INFO: task hung in cgroup1_get_tree
From: syzbot <syzbot+4e415f7013e8d1af362b@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=77808e35144e725c];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17304-lists,cgroups=lfdr.de,4e415f7013e8d1af362b];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url,syzkaller.appspotmail.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:syzkaller-bugs@googlegroups.com,m:tj@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[cgroups];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE3036CA39A

Hello,

syzbot found the following issue on:

HEAD commit:    ab9de95c9cf9 Merge tag 'rust-7.2-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13976591580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77808e35144e725c
dashboard link: https://syzkaller.appspot.com/bug?extid=4e415f7013e8d1af362b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea216d6c635b/disk-ab9de95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4726046a068/vmlinux-ab9de95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ee56b4f63b2/bzImage-ab9de95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e415f7013e8d1af362b@syzkaller.appspotmail.com

INFO: task syz.3.5067:25142 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.5067      state:D stack:27688 pid:25142 tgid:25139 ppid:24491  task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0xdd/0x390 kernel/sched/core.c:7322
 cgroup_lock_and_drain_offline+0x383/0x800 kernel/cgroup/cgroup.c:3275
 cgroup1_get_tree+0xc2/0x1620 kernel/cgroup/cgroup-v1.c:1265
 vfs_get_tree+0x92/0x320 fs/super.c:1694
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3765 [inline]
 do_new_mount fs/namespace.c:3841 [inline]
 path_mount+0x7d0/0x23d0 fs/namespace.c:4161
 do_mount fs/namespace.c:4174 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount fs/namespace.c:4367 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe24299ce59
RSP: 002b:00007fe243858028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe242c16090 RCX: 00007fe24299ce59
RDX: 0000200000000080 RSI: 0000200000001180 RDI: 0000000000000000
RBP: 00007fe242a32e6f R08: 0000200000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe242c16128 R14: 00007fe242c16090 R15: 00007ffc1d1628c8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e7e60c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e7e60c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e7e60c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6775
6 locks held by kworker/1:6/5718:
 #0: ffff8880202ea940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12b1/0x1940 kernel/workqueue.c:3297
 #1: ffffc900040d7d08 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x988/0x1940 kernel/workqueue.c:3298
 #2: ffff88802ac581d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #2: ffff88802ac581d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bd/0x4af0 drivers/usb/core/hub.c:5899
 #3: ffff88802ad59568 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3252 [inline]
 #3: ffff88802ad59568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5464 [inline]
 #3: ffff88802ad59568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 #3: ffff88802ad59568 (&port_dev->status_lock){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5871 [inline]
 #3: ffff88802ad59568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_event+0x2bd2/0x4af0 drivers/usb/core/hub.c:5953
 #4: ffff88802ac76760 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5465 [inline]
 #4: ffff88802ac76760 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 #4: ffff88802ac76760 (hcd->address0_mutex){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5871 [inline]
 #4: ffff88802ac76760 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_event+0x2bfb/0x4af0 drivers/usb/core/hub.c:5953
 #5: ffffffff8fbf2c48 (ehci_cf_port_reset_rwsem){.+.+}-{4:4}, at: hub_port_reset+0x1a5/0x1c60 drivers/usb/core/hub.c:3067
2 locks held by getty/13406:
 #0: ffff8880383d10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000202e2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
1 lock held by syz.2.5163/25788:
 #0: ffff88807d22e0d8 (&type->s_umount_key#64){++++}-{4:4}, at: do_remount fs/namespace.c:3404 [inline]
 #0: ffff88807d22e0d8 (&type->s_umount_key#64){++++}-{4:4}, at: path_mount+0x1757/0x23d0 fs/namespace.c:4153
1 lock held by syz.0.5462/27160:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x21c/0x2a0 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xcb1/0x1030 kernel/hung_task.c:561
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: d6 85 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 23 28 10 00 fb f4 <e9> fc 48 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e407e10 EFLAGS: 00000246
RAX: 00000000088c3e3f RBX: ffffffff8e491480 RCX: ffffffff8b9b72d5
RDX: 0000000000000000 RSI: ffffffff8df596ca RDI: ffffffff8c1e7180
RBP: fffffbfff1c92290 R08: 0000000000000001 R09: ffffed101708678d
R10: ffff8880b8433c6b R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffffffff1c80fc6 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881242e7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa09d875d58 CR3: 000000004c22a000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000007 DR2: 0000000000000004
DR3: 0000000000000008 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3a7/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:454
 rest_init+0x251/0x260 init/main.c:717
 start_kernel+0x48e/0x490 init/main.c:1175
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x158
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

