Return-Path: <cgroups+bounces-16938-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LitbJlGyL2qaEgUAu9opvQ
	(envelope-from <cgroups+bounces-16938-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 10:05:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC63684664
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 10:05:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16938-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16938-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B799E3002D1A
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E33C10BE;
	Mon, 15 Jun 2026 08:05:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9133C0A0D
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 08:05:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510731; cv=none; b=Aw+28rU8Ntpjmazdcfds1HNEoZ8lXZ19ecvyRJsUcx3vnvH6JMqB6dH0NZWvutiRPj/B3ET+LUI3YVOSyonaan7ZHX+7+9CZHotdZ8AdyhVAJL5lYxLoqg7qApf9eY/NEyE1yD7bYQRi7dOppGDOPRJvwIj4/4/ErJGcQ30M8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510731; c=relaxed/simple;
	bh=kJKtkYCUSK6/7Ycyn5qaD5nFdvqce34jtbUjzHXOj28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ON2aqgvSSnvoEGaN+bes5yH1JqpGyU2Hii2P2J7wIZ1XX3jqCdSzC9jBwjuM4ilybJdY3Poe75Dvst4eDGVm7BEL9OxCYKDCdzEvhaa8I0YsYa+3PhyduPbUUWDxpF/Lm7f+xOTNyiYWcQ9ShlKzUnuKb8ZXBBRgeaarRm+vNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-440e6bdc127so4237461fac.2
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510729; x=1782115529;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpIXCQzqfahWYhOAtNF5NHRLKpPfy5+DaDSfJ/OghqU=;
        b=GQycgv6gick/DDDy2VKRAyVdE9xxvCxi5j6N79S7afUcMgNxIlxB0IorDXBtxMSr3m
         ziTqkpPHkOvCkvYHJM+ySrltJ4eWiXyY6OgG7BIug/DW6rNpH867dDZnwfiiFhtms32x
         pxirSHYo4eS8+lNSRuqcUjsRElodlf8hOCImHHtuCaHHRvpFQxliV08iCcwV39LS8dx5
         wBO5pBsZFtV0ekttLJ9G23lojHXnKYxEtD35UKLOHEvHbu3hAF65arKK+xCeQ/aUfD6o
         zXS8AU67+k3uU771/aK9wMzJGXfYQ9bwja+oBkRwlHyQIbJr6VUREd+dO7Yi4chk6pEj
         cBRA==
X-Gm-Message-State: AOJu0YzCopO33m4ZM+aeLnGYEqx0fLsxQ3fXVD1jplLjFh+AaSZ8HpQ6
	9Wn2AJwwpDLKcxr//O7xgOWnUczf8YJpKX1yxEC3zwk8PIoucDTEkpjaY1EVv5+7bkUmAAYD5Jc
	2Es8TnOMnPDyYbQwpkaUXsiddZmgUSxucGayfr9CR58kiBB5bgUCJasroDBnaBA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221f:b0:69d:f0e8:3223 with SMTP id
 006d021491bc7-69edc5e7d8emr8428026eaf.7.1781510728847; Mon, 15 Jun 2026
 01:05:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 01:05:28 -0700
In-Reply-To: <6a23a4b4.e4db5ad2.3b7dfb.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2fb248.8812e0fc.3c3fa4.001a.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] INFO: task hung in cgroup_subtree_control_write
 (2)
From: syzbot <syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0d1fa2afcbce17c];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16938-lists,cgroups=lfdr.de,bb2e19a1190a556c01b1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,storage.googleapis.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:syzkaller-bugs@googlegroups.com,m:tj@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CC63684664

syzbot has found a reproducer for the following issue on:

HEAD commit:    ec039126b7fa Add linux-next specific files for 20260611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178e637a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0d1fa2afcbce17c
dashboard link: https://syzkaller.appspot.com/bug?extid=bb2e19a1190a556c01b1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b0d4ae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be809c32a471/disk-ec039126.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13ea1053e3b5/vmlinux-ec039126.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bcdab47ddc8/bzImage-ec039126.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com

INFO: task syz.1.18:6037 blocked for more than 143 seconds.
      Not[  392.048269][   T39]       Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:27936 pid:6037  tgid:6035  ppid:6000   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x172b/0x5550 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 cgroup_lock_and_drain_offline+0x516/0x650 kernel/cgroup/cgroup.c:3275
 cgroup_kn_lock_live+0x120/0x230 kernel/cgroup/cgroup.c:1715
 cgroup_subtree_control_write+0x4b3/0x10a0 kernel/cgroup/cgroup.c:3577
 cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4316
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3fb3b0ce59
RSP: 002b:00007f3fb3145028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3fb3d86090 RCX: 00007f3fb3b0ce59
RDX: 0000000000000005 RSI: 0000200000000040 RDI: 0000000000000006
RBP: 00007f3fb3ba2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3fb3d86128 R14: 00007f3fb3d86090 R15: 00007ffe868740f8
 </TASK>
INFO: task syz.2.19:6081 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:28344 pid:6081  tgid:6079  ppid:6045   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x172b/0x5550 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 cgroup_lock_and_drain_offline+0x516/0x650 kernel/cgroup/cgroup.c:3275
 cgroup_kn_lock_live+0x120/0x230 kernel/cgroup/cgroup.c:1715
 cgroup_subtree_control_write+0x4b3/0x10a0 kernel/cgroup/cgroup.c:3577
 cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4316
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd96f6ce59
RSP: 002b:00007fcd965ad028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fcd971e6090 RCX: 00007fcd96f6ce59
RDX: 0000000000000005 RSI: 0000200000000300 RDI: 0000000000000006
RBP: 00007fcd97002d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcd971e6128 R14: 00007fcd971e6090 R15: 00007ffc255c33a8
 </TASK>
INFO: task syz.2.19:6082 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:28920 pid:6082  tgid:6079  ppid:6045   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x172b/0x5550 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7603
 rt_mutex_slowlock_block+0x505/0x670 kernel/locking/rtmutex.c:1669
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1746 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1786 [inline]
 rt_mutex_slowlock+0x2dc/0x780 kernel/locking/rtmutex.c:1826
 __rt_mutex_lock kernel/locking/rtmutex.c:1841 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 fdget_pos+0x252/0x320 fs/file.c:1259
 class_fd_pos_constructor include/linux/file.h:85 [inline]
 ksys_write+0x79/0x270 fs/read_write.c:730
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd96f6ce59
RSP: 002b:00007fcd9658c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fcd971e6180 RCX: 00007fcd96f6ce59
RDX: 0000000000000005 RSI: 0000200000000040 RDI: 0000000000000006
RBP: 00007fcd97002d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcd971e6218 R14: 00007fcd971e6180 R15: 00007ffc255c33a8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/32:
 #0: ffff88813fe57938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3301
 #1: ffffc90000a6fc40 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3302
 #2: ffffffff8f7b0bb8 (rtnl_mutex){+.+.}-{4:4}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/39:
 #0: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6777
2 locks held by getty/5366:
 #0: ffff88802940e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cbe2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x465/0x1490 drivers/tty/n_tty.c:2211
3 locks held by kworker/u8:18/5822:
 #0: ffff888032abd938 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3301
 #1: ffffc90003db7c40 ((work_completion)(&(&bat_priv->dat.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3302
 #2: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
3 locks held by syz.1.18/6037:
 #0: ffff88803a43f128 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff8880436a3c78 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
3 locks held by syz.2.19/6081:
 #0: ffff88803b865f28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff88803697fc78 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.2.19/6082:
 #0: ffff88803b865f28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.3.20/6122:
 #0: ffff888037837f28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff888036d05878 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.3.20/6123:
 #0: ffff888037837f28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.4.21/6167:
 #0: ffff88803bb00d28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff888033038478 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.4.21/6168:
 #0: ffff88803bb00d28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.5.22/6214:
 #0: ffff88803a467328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff8880408bb078 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.5.22/6216:
 #0: ffff88803a467328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.6.23/6264:
 #0: ffff888028ed0328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff88803c173c78 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.6.23/6265:
 #0: ffff888028ed0328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.7.24/6310:
 #0: ffff8880296e8328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff88803e05a878 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.7.24/6311:
 #0: ffff8880296e8328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.8.25/6356:
 #0: ffff8880257b2728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff888031468078 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.8.25/6357:
 #0: ffff8880257b2728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz.9.26/6407:
 #0: ffff888028ea4528 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2728 [inline]
 #1: ffff8880344f2500 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:683
 #2: ffff888032e47078 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:336
1 lock held by syz.9.26/6408:
 #0: ffff888028ea4528 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
3 locks held by syz-executor/6411:
 #0: ffffffff8f7b0bb8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f7b0bb8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8f7b0bb8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x883/0x1bb0 net/core/rtnetlink.c:4150
 #1: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffffff8e3cb2a0 (rcu_read_lock){....}-{1:3}, at: ib_device_get_by_netdev+0x81/0x4f0 drivers/infiniband/core/device.c:2357
 #2: ffff8880b8724540 (psi_seq){-...}-{0:0}, at: psi_task_change+0xd4/0x340 kernel/sched/psi.c:919

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 39 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 29 Comm: rcuc/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:mark_lock+0x9a/0x190 kernel/locking/lockdep.c:4776
Code: 0e 00 75 13 48 8d 3d e5 1a 31 0e 48 c7 c6 51 2b a9 8d 67 48 0f b9 3a 90 31 c9 4c 89 fe 4c 89 f7 b8 01 00 00 00 85 69 60 74 10 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 49 89 fe 49 89 f7
RSP: 0018:ffffc90000a3f970 EFLAGS: 00000006
RAX: 0000000000000001 RBX: 0000000000000009 RCX: ffffffff93640d68
RDX: 0000000000000008 RSI: ffff88801e694a30 RDI: ffff88801e693e00
RBP: 0000000000000200 R08: ffffffff81883dac R09: ffffffff8e3cb2a0
R10: dffffc0000000000 R11: fffffbfff1f9e71f R12: 0000000000000003
R13: ffff88801e694a30 R14: ffff88801e693e00 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125b6b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2e59a3b6b0 CR3: 000000003ef78000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4676 [inline]
 __lock_acquire+0x6b5/0x2d10 kernel/locking/lockdep.c:5193
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock include/linux/rcupdate.h:840 [inline]
 __local_bh_disable_ip+0x205/0x420 kernel/softirq.c:174
 local_bh_disable include/linux/bottom_half.h:20 [inline]
 rcu_cpu_kthread+0x214/0x1470 kernel/rcu/tree.c:2978
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

