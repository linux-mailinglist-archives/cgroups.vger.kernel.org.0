Return-Path: <cgroups+bounces-15208-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG1OCqwy2WkOnQgAu9opvQ
	(envelope-from <cgroups+bounces-15208-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 19:26:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E13DB082
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 19:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0760830067AA
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E43E0C57;
	Fri, 10 Apr 2026 17:24:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C53E2769
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841867; cv=none; b=KIKWzcx/FJ1eDQwM/JafyP2SvQH/O0U2ZCmV7Ff7AhZhI0DRsLxfHGfb1cg4DVnspV4SLBb3tGi6UQuoYXIHfpmaIGX4da8hhe5ArItNezOMQ2whK2twqbAj6YoPM2mB0lnCSn2WIYB2Z/cwnkBEXoe7HDDi2Vf4RCN8rKL0Pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841867; c=relaxed/simple;
	bh=+gKTHxoxDMKo3u7evTWoh9TWfhwBQlT6ukGhjEx6wjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sewrpy2/XDMYg3sCSHVyIrj/V6Y4FNa/hp8kcY4JjnkiHKK1zoS44wZ1+5siAFos8ZAn5zVPjrOHUsGLYFu5iawRbDZSXqtXpESISmYNW9Uo3CiAw+Nb86M5rBavnCpvarmCktJxR3BEKAJTGWY+BMo95dgliUIOURBoeQUucTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d7f23bd25bso6830206a34.0
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 10:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841865; x=1776446665;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FOmNqJ3sPBDzLwH7LK8E0lSFhzB2S92n5VYz6A1mpM=;
        b=E8vQLLjZsjR9h9yXQrMryNd7RMx1U6O5p8S/8MHRZKa34pC0HU1rl3WGb8I78Ch5/7
         JmDZhdvM+qB/Mq56/tTWgJrkYBpBstE8FRX4a7/S+Rj5EFeM1T9olRdt+kCLdyI4UOBa
         RZX97fPPfOvR46Q/0tY0E2EJG14VuuL3T8C59UWCvE4z93qINL48WjH2TPcQe7CMUqra
         v6KCWsjwldnFQJDXa/u6boe6LlhYMSvndAEJhlF0XCttJUbonDEUfg3niz5jGGsDiZEk
         wlLUM5cur0Qlymi+yoTkeG598aXICRCX5Lb5mzt/YIAPbQj/rEohzwTER5ylV2pA5uk/
         +c5g==
X-Gm-Message-State: AOJu0YywOBpD2Dtjhs39Nh2xYPhzH1b6jDSwVVPhhCrivnS6tCX++ZIf
	BdU+FWsG6/A1wZjefHTRybABaYZA7hJhhLfFdPQe0G+y2O8i8xVip9Ed+4iUxfBc8NLkGWxshDq
	W7PTsFcendUZteOsmIHTZcwb1UxTGgcDYBgpvFdJx6Rs//CghFFw3vVMhXRSWXg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8406:b0:682:4005:5a56 with SMTP id
 006d021491bc7-68a68d601b9mr2542571eaf.12.1775841865008; Fri, 10 Apr 2026
 10:24:25 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:24:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d93248.050a0220.3030df.002f.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in cgroup_kn_lock_live (2)
From: syzbot <syzbot+6dc923fb5b4671f0fcf0@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=64e78d99d9bf8b4c];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15208-lists,cgroups=lfdr.de,6dc923fb5b4671f0fcf0];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 772E13DB082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    591cd656a1bf Linux 7.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138ddd02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e78d99d9bf8b4c
dashboard link: https://syzkaller.appspot.com/bug?extid=6dc923fb5b4671f0fcf0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf0f027c93ec/disk-591cd656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60d829be17f4/vmlinux-591cd656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/673c009c7550/bzImage-591cd656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6dc923fb5b4671f0fcf0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.1.1390/12323 is trying to acquire lock:
ffffffff8e84a7c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:394 [inline]
ffffffff8e84a7c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1732

but task is already holding lock:
ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: vfs_rmdir fs/namei.c:5329 [inline]
ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: vfs_rmdir+0xed/0x8a0 fs/namei.c:5317

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&type->i_mutex_dir_key#7){++++}-{4:4}:
       down_read+0x99/0x460 kernel/locking/rwsem.c:1537
       inode_lock_shared include/linux/fs.h:1043 [inline]
       lookup_slow+0x42/0x70 fs/namei.c:1932
       walk_component fs/namei.c:2279 [inline]
       lookup_last fs/namei.c:2786 [inline]
       path_lookupat+0x5e8/0xc40 fs/namei.c:2810
       filename_lookup+0x202/0x590 fs/namei.c:2839
       kern_path+0x37/0x50 fs/namei.c:3046
       lookup_bdev+0xd8/0x280 block/bdev.c:1221
       bdev_file_open_by_path+0x82/0x330 block/bdev.c:1094
       add_device drivers/mtd/devices/block2mtd.c:279 [inline]
       block2mtd_setup2.isra.0+0x2ee/0xc70 drivers/mtd/devices/block2mtd.c:459
       block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
       param_attr_store+0x199/0x300 kernel/params.c:589
       module_attr_store+0x58/0x80 kernel/params.c:913
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1070 fs/read_write.c:688
       ksys_write+0x12a/0x250 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (param_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       ieee80211_rate_control_ops_get net/mac80211/rate.c:223 [inline]
       rate_control_alloc net/mac80211/rate.c:269 [inline]
       ieee80211_init_rate_ctrl_alg+0x1df/0x3b0 net/mac80211/rate.c:1016
       ieee80211_register_hw+0x2950/0x4140 net/mac80211/main.c:1544
       mac80211_hwsim_new_radio+0x2847/0x57d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5809
       init_mac80211_hwsim+0x6db/0x7f0 drivers/net/wireless/virtual/mac80211_hwsim.c:7172
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       cgrp_css_online+0xa1/0x1f0 net/core/netprio_cgroup.c:157
       online_css+0xb2/0x350 kernel/cgroup/cgroup.c:5739
       css_create kernel/cgroup/cgroup.c:5827 [inline]
       cgroup_apply_control_enable+0x8bd/0xbd0 kernel/cgroup/cgroup.c:3390
       cgroup_mkdir+0x57f/0x1330 kernel/cgroup/cgroup.c:6028
       kernfs_iop_mkdir+0x111/0x190 fs/kernfs/dir.c:1273
       vfs_mkdir+0x361/0x850 fs/namei.c:5239
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5272
       __do_sys_mkdirat fs/namei.c:5293 [inline]
       __se_sys_mkdirat fs/namei.c:5290 [inline]
       __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5290
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (cgroup_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       cgroup_lock include/linux/cgroup.h:394 [inline]
       cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1732
       cgroup_rmdir+0x22/0x300 kernel/cgroup/cgroup.c:6305
       kernfs_iop_rmdir+0x106/0x170 fs/kernfs/dir.c:1291
       vfs_rmdir fs/namei.c:5344 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5317
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5399
       __do_sys_rmdir fs/namei.c:5422 [inline]
       __se_sys_rmdir fs/namei.c:5419 [inline]
       __x64_sys_rmdir+0x46/0x70 fs/namei.c:5419
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  cgroup_mutex --> param_lock --> &type->i_mutex_dir_key#7

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#7);
                               lock(param_lock);
                               lock(&type->i_mutex_dir_key#7);
  lock(cgroup_mutex);

 *** DEADLOCK ***

3 locks held by syz.1.1390/12323:
 #0: ffff88807fec2420 (sb_writers#10){.+.+}-{0:0}, at: filename_rmdir+0x1ff/0x5c0 fs/namei.c:5388
 #1: ffff88805cae8148 (&type->i_mutex_dir_key#7/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff88805cae8148 (&type->i_mutex_dir_key#7/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2929 [inline]
 #1: ffff88805cae8148 (&type->i_mutex_dir_key#7/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2940 [inline]
 #1: ffff88805cae8148 (&type->i_mutex_dir_key#7/1){+.+.}-{4:4}, at: filename_rmdir+0x258/0x5c0 fs/namei.c:5392
 #2: ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: vfs_rmdir fs/namei.c:5329 [inline]
 #2: ffff888059c1d5c0 (&type->i_mutex_dir_key#7){++++}-{4:4}, at: vfs_rmdir+0xed/0x8a0 fs/namei.c:5317

stack backtrace:
CPU: 0 UID: 0 PID: 12323 Comm: syz.1.1390 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
 cgroup_lock include/linux/cgroup.h:394 [inline]
 cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1732
 cgroup_rmdir+0x22/0x300 kernel/cgroup/cgroup.c:6305
 kernfs_iop_rmdir+0x106/0x170 fs/kernfs/dir.c:1291
 vfs_rmdir fs/namei.c:5344 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5317
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5399
 __do_sys_rmdir fs/namei.c:5422 [inline]
 __se_sys_rmdir fs/namei.c:5419 [inline]
 __x64_sys_rmdir+0x46/0x70 fs/namei.c:5419
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8142b9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f81439b7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f8142e16180 RCX: 00007f8142b9c819
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000040
RBP: 00007f8142c32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8142e16218 R14: 00007f8142e16180 R15: 00007ffc92158f68
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

