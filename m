Return-Path: <cgroups+bounces-16682-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Mp0MrukI2rIwAEAu9opvQ
	(envelope-from <cgroups+bounces-16682-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 06:40:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0064C5F4
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 06:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16682-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16682-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDC2F302D1B6
	for <lists+cgroups@lfdr.de>; Sat,  6 Jun 2026 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60C2701CF;
	Sat,  6 Jun 2026 04:40:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506AC23505E
	for <cgroups@vger.kernel.org>; Sat,  6 Jun 2026 04:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780720823; cv=none; b=bU1JTRpz0jWc0UyhKWalWcodTNpmaqb3+vymCOZajiE8S3yG0magqGeYwcuTtZzyxLjZ669qy9nJ8U2rxVHliFX6lj479InXOJXx7SyoLZIGbPHM5qvSSB13q9ie7gtCI6epa0eH8IGZIXCgBclZiTmmbVxq5GZgLLVl+6uF3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780720823; c=relaxed/simple;
	bh=Dd4RGXAXvX1kiPUnQcVTFJQtvBG7Wn7NzM8rMQnk4DU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QumWpFi6AvXJfsFcGQN0oWen1SxYX8utkDk7Evs1isyfKMzz9CX+Ch2puo9NzI6EtBi2L5XbBVXnQDf54s8sX1YLgq76oQSqX4QFK1mpTL8tLUxkEcpSWnz/AujPpGuY5UJaTubxQ3BeyFJQ3tPcjuwfHGK/Qhd3hJDdGX4bb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4412c255fd4so2358322fac.3
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 21:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780720820; x=1781325620;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2lZyYkFq8xtMJFgRZ0HaHv7rmTmWkGgstrJiBcReno=;
        b=ifek2sUhn7mFVvQclXzKGml4k/Xb1e7TUemgP31JDiqqXTfA8lkNji8r1R6eKf9fTp
         7UtI0HQMnQRAyBZHQ+X9ghm5+v3LAffQcOR6rPfnX81xqHChb466sOi2rO6bZkDLZXvt
         MNzDlDeWLXRagAxUvVK1UrAz2lmjmh+b/+qoA4obxPQ+3Ze/5fhhZEe5H90cqk92C2ak
         vPSroShANxk4mrTy1Wrch828NogtfbYnf/aH/CwVcHgIbii/6gBu+cuGR1p7nee3DZ6q
         2W8IeTcl7vLUr9pJhlEhK+ZjhlLmHzsBO40jU/7qDjRQUcmwoRk9FBDlLJOutJNE08Xa
         0cjA==
X-Gm-Message-State: AOJu0YwO/0p6VJWatmoD+gr8Z61XSHSfJjP421pFcLvwUH5CNzPDi9Ae
	hLjnzXfpMk/LpGkjgxhWL+za+tdUBxwCeaayC+cB7Zh/rMM+NaXe1hcKdqRc7WwlpQ/KSvyi0dA
	5V7+5ySAL0QgZNxZxHwEX2L3hJhpNiI04Rsu6VAlRZ1l7mSsBAD4JujovTdIKog==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200f:b0:69d:9547:c961 with SMTP id
 006d021491bc7-69e68b954ffmr3938459eaf.22.1780720820314; Fri, 05 Jun 2026
 21:40:20 -0700 (PDT)
Date: Fri, 05 Jun 2026 21:40:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a23a4b4.e4db5ad2.3b7dfb.0000.GAE@google.com>
Subject: [syzbot] [cgroups?] INFO: task hung in cgroup_subtree_control_write (2)
From: syzbot <syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8540f3ea107c5da4];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16682-lists,cgroups=lfdr.de,bb2e19a1190a556c01b1];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:syzkaller-bugs@googlegroups.com,m:tj@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 34F0064C5F4

Hello,

syzbot found the following issue on:

HEAD commit:    f7af91adc230 Add linux-next specific files for 20260528
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10fba1b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8540f3ea107c5da4
dashboard link: https://syzkaller.appspot.com/bug?extid=bb2e19a1190a556c01b1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/201366128b18/disk-f7af91ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18bd352284cf/vmlinux-f7af91ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83c27fa66016/bzImage-f7af91ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com

INFO: task syz.4.3305:20367 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.3305      state:D stack:28920 pid:20367 tgid:20365 ppid:18600  task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5402 [inline]
 __schedule+0x16f9/0x5500 kernel/sched/core.c:7204
 __schedule_loop kernel/sched/core.c:7283 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7298
 cgroup_lock_and_drain_offline+0x516/0x650 kernel/cgroup/cgroup.c:3248
 cgroup_kn_lock_live+0x120/0x230 kernel/cgroup/cgroup.c:1699
 cgroup_subtree_control_write+0x4b3/0x10a0 kernel/cgroup/cgroup.c:3550
 cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4289
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffad184ce59
RSP: 002b:00007ffacfa7d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffad1ac6090 RCX: 00007ffad184ce59
RDX: 0000000000000005 RSI: 0000200000000040 RDI: 0000000000000006
RBP: 00007ffad18e2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffad1ac6128 R14: 00007ffad1ac6090 R15: 00007ffe4a0d9fe8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8e1cac60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e1cac60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e1cac60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6777
2 locks held by getty/5367:
 #0: ffff888037c8b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13a0 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:6/5762:
 #0: ffff88813fe16538 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc9000550fc40 ((gc_work).work){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294
 #2: ffffffff8ececcf8 ("ratelimiter_table_lock"){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffffffff8ececcf8 ("ratelimiter_table_lock"){+.+.}-{3:3}, at: wg_ratelimiter_gc_entries+0x5d/0x480 drivers/net/wireguard/ratelimiter.c:63
2 locks held by kworker/u8:39/16177:
 #0: ffff88813fe54138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc90007a0fc40 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294
3 locks held by syz.4.3305/20367:
 #0: ffff88803b51c328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1260
 #1: ffff8880353ea480 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #1: ffff8880353ea480 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff888034fed478 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:343
2 locks held by syz-executor/20485:
 #0: ffffffff8e900c38 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #0: ffffffff8e900c38 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #0: ffffffff8e900c38 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
 #0: ffffffff8e900c38 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x1d3/0x470 security/tomoyo/file.c:772
 #1: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3752 [inline]
 #1: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: __refill_objects_node+0x89/0x620 mm/slub.c:7071
1 lock held by syz.6.3865/22401:
 #0: ffff888040d99d90 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
 #0: ffff888040d99d90 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_fault+0xa92/0x1470 mm/filemap.c:3571
5 locks held by syz.7.3869/22407:
 #0: ffff88803f089fc8 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x6a/0x90 net/xfrm/xfrm_user.c:3545
 #1: ffff88803de8c928 (nlk_cb_mutex-XFRM){+.+.}-{4:4}, at: __netlink_dump_start+0xfe/0x7e0 net/netlink/af_netlink.c:2410
 #2: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3752 [inline]
 #2: ffff88813feaad58 (&n->list_lock){+.+.}-{3:3}, at: __refill_objects_node+0x89/0x620 mm/slub.c:7071
 #3: ffff8880b863b8a0 (&rq->__lock){-...}-{2:2}, at: finish_lock_switch kernel/sched/core.c:5136 [inline]
 #3: ffff8880b863b8a0 (&rq->__lock){-...}-{2:2}, at: finish_task_switch+0x15f/0xbe0 kernel/sched/core.c:5257
 #4: ffff8880b8628418 (hrtimer_bases.lock){-...}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:191 [inline]
 #4: ffff8880b8628418 (hrtimer_bases.lock){-...}-{2:2}, at: hrtimer_start_range_ns+0x8c/0x3f0 kernel/time/hrtimer.c:1501

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 39 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 22407 Comm: syz.7.3869 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__bfs kernel/locking/lockdep.c:1755 [inline]
RIP: 0010:__bfs_backwards kernel/locking/lockdep.c:1862 [inline]
RIP: 0010:check_irq_usage kernel/locking/lockdep.c:2798 [inline]
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3171 [inline]
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3286 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3910 [inline]
RIP: 0010:__lock_acquire+0x1821/0x2d10 kernel/locking/lockdep.c:5239
Code: 00 0f 83 8a 01 00 00 4e 8b 24 fd a0 69 a2 95 ff c0 25 ff 0f 00 00 89 05 9d cb 01 14 4d 85 e4 0f 84 b2 01 00 00 49 8b 44 24 10 <48> 85 c0 0f 84 3c 0d 00 00 8b 0d 88 cb 01 14 39 48 5c 0f 84 67 ff
RSP: 0018:ffffc9001429e7e0 EFLAGS: 00000082
RAX: ffffffff934677a8 RBX: 00000000000003cd RCX: ffffffff9657db68
RDX: ffffffff934d1bd8 RSI: ffff888041d1cac8 RDI: 00000000000003cd
RBP: 9e3923e9df32e17b R08: ffffc9001429e7a8 R09: 0000000000000020
R10: ffffc9001429e9e8 R11: ffffffff81a17080 R12: ffffffff9657db68
R13: ffff888041d1cac8 R14: ffff888041d1be00 R15: 000000000000007c
FS:  00007fdb4f43e6c0(0000) GS:ffff888125c7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f03764ae3e3 CR3: 000000007a326000 CR4: 00000000003526f0
DR0: 0000000000000009 DR1: 00000000000000c9 DR2: 00000000000000f3
DR3: 0000000000000002 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 debug_object_deactivate+0x9a/0x250 lib/debugobjects.c:900
 debug_hrtimer_deactivate kernel/time/hrtimer.c:490 [inline]
 remove_and_enqueue_same_base kernel/time/hrtimer.c:1252 [inline]
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1402 [inline]
 hrtimer_start_range_ns_common+0x3f7/0xba0 kernel/time/hrtimer.c:1481
 hrtimer_start_range_ns+0x111/0x3f0 kernel/time/hrtimer.c:1503
 hrtimer_start include/linux/hrtimer.h:223 [inline]
 hrtick_cond_restart kernel/sched/core.c:933 [inline]
 hrtick_schedule_exit kernel/sched/core.c:995 [inline]
 finish_lock_switch kernel/sched/core.c:5138 [inline]
 finish_task_switch+0x3cd/0xbe0 kernel/sched/core.c:5257
 context_switch kernel/sched/core.c:5405 [inline]
 __schedule+0x1701/0x5500 kernel/sched/core.c:7204
 preempt_schedule_common+0x82/0xd0 kernel/sched/core.c:7385
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 class_preempt_destructor include/linux/preempt.h:468 [inline]
 raw_spin_unlock_irqrestore_wake include/linux/sched/wake_q.h:102 [inline]
 rtlock_slowlock kernel/locking/rtmutex.c:1919 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x316/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 get_partial_node_bulk mm/slub.c:3752 [inline]
 __refill_objects_node+0x89/0x620 mm/slub.c:7071
 refill_objects+0x62/0x3d0 mm/slub.c:7203
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4665
 alloc_from_pcs mm/slub.c:4763 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __do_kmalloc_node mm/slub.c:5308 [inline]
 __kmalloc_node_track_caller_noprof+0x60b/0x7e0 mm/slub.c:5412
 kmalloc_reserve net/core/skbuff.c:635 [inline]
 __alloc_skb+0x2c1/0x7d0 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1382 [inline]
 netlink_dump+0x1d8/0xe10 net/netlink/af_netlink.c:2296
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2446
 netlink_dump_start include/linux/netlink.h:341 [inline]
 xfrm_user_rcv_msg+0x951/0xc40 net/xfrm/xfrm_user.c:3503
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2556
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3546
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 ____sys_sendmsg+0x55c/0x870 net/socket.c:2716
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2770
 __sys_sendmsg net/socket.c:2802 [inline]
 __do_sys_sendmsg net/socket.c:2807 [inline]
 __se_sys_sendmsg net/socket.c:2805 [inline]
 __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2805
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb511ece59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb4f43e028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdb51465fa0 RCX: 00007fdb511ece59
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007fdb51282d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdb51466038 R14: 00007fdb51465fa0 R15: 00007fff24b1b738
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

