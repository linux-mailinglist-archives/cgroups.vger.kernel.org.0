Return-Path: <cgroups+bounces-15187-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAd6DZxE1WnY3wcAu9opvQ
	(envelope-from <cgroups+bounces-15187-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:53:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB033B2A22
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7B23006B35
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DF33B95C;
	Tue,  7 Apr 2026 17:53:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85D29B78F
	for <cgroups@vger.kernel.org>; Tue,  7 Apr 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584406; cv=none; b=pGD2vaeZgbmrmd2F4XwOWn780b3i4x9IIJ2xi9yHelbnUF7ra1ye51JSwZZBsy76LWSaXvZPoQLO6/29X8izOukYUwQ/yBveRV20tXEIRv3XNMWuLZDzQjWBeP3yA0O5Ye2HjgiZX6O9orBSmfy8QOgKqd5+ykLGs9/h2Eu0u5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584406; c=relaxed/simple;
	bh=OtMgjEprA6JbqD8nyWkhGUN0KTVynR4kAhDCdF2G6HY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rvpRH0ozzMUXL3a1vZ58bEhM6IihWLNvQbt7ZKFUHNjRC8sWJAg5blv641A8w5nCAzhi/XF19SaI5kfGLSZXE2MTWcpaCsFAq5Lib5D0R6eAQojZe32JimnH3edcdkfDZTGuxk8zGZXisDU3+MSdMdsdpRx41LagbK4xDc5Qo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-68240056f4cso10095402eaf.1
        for <cgroups@vger.kernel.org>; Tue, 07 Apr 2026 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584404; x=1776189204;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xNeqTXuG3fa9wSy2SvZqFSjE6EAjRf8K1JT5r8HsbU=;
        b=W5RXeabN2u8rIrH4dMkiyajmC7JVRfy52x0jx9bwLJIfSIztbP6nWse07pvtBZQ0ga
         skwh4njJvChxSVAqHmPbBrFm3+/PHKAinQJxyPq6XQ1ren5/yFlfiqjeWUp7J0TtMfQt
         kbS4TO0Zybg+ub/rLcFcDjcs0Iefwmu0iFdyrLyu1nnL1v3w0uXRnyMAPHD/sOaMYl3O
         irr5WlAeYUiGac5pmqIRcB1qux29E4gN2/Aux+gZ+5IehDCJyB/CrpNskhETwXo8/PGU
         +YLEWu07/741L0pFpAzZceEolsjohINEpbmML/KaxRgZDk4ttPhj6RxOpssLNf9dFXvk
         wnBg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJCkGktRINZBj9HSvHxaZWyUB15j1bUqnTtOErlNDsBgdiMi+ktur/qMGgTThDcj8M9csfIr/@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAVvTy/DxID5sPFw7ze3MkSS7lGxNwab33VR2VFGjfvR016WQ
	GaaKURg5BwG43/ZwsZmoDj4y94MToJeSMs0YSIpWxXZaOn8/Z8csz08ZxSPvY9NYX8L6SLrsFOX
	BcGVxxHIzP7yHJenlcu4svBpds/I+vNTAY+yIHX7rVHyvCyrHzGPpCIDTXbc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e90d:0:b0:687:a318:a2e6 with SMTP id
 006d021491bc7-687a318a77emr2671591eaf.31.1775584404155; Tue, 07 Apr 2026
 10:53:24 -0700 (PDT)
Date: Tue, 07 Apr 2026 10:53:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d54494.050a0220.3030df.0002.GAE@google.com>
Subject: [syzbot] [mm?] [cgroups?] WARNING: bad unlock balance in lruvec_stat_mod_folio
From: syzbot <syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15187-lists,cgroups=lfdr.de,1a3353a77896e73a8f53];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9CB033B2A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    cc13002a9f98 Add linux-next specific files for 20260402
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8946a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3353a77896e73a8f53
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e804756158fe/disk-cc13002a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be49b7dca580/vmlinux-cc13002a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5cb3fb091ba3/bzImage-cc13002a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com

cgroup: Unknown subsys name 'cpuset'
cgroup: Unknown subsys name 'rlimit'
=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz-executor/5830 is trying to release lock (rcu_read_lock) at:
[<ffffffff8237872e>] rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
[<ffffffff8237872e>] rcu_read_lock include/linux/rcupdate.h:850 [inline]
[<ffffffff8237872e>] lruvec_stat_mod_folio+0x6e/0x3e0 mm/memcontrol.c:974
but there are no more locks to release!

other info that might help us debug this:
3 locks held by syz-executor/5830:
 #0: ffff88802cb7f588 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7f1/0x1c80 security/integrity/ima/ima_main.c:319
 #1: ffff888077946ff0 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1094 [inline]
 #1: ffff888077946ff0 (mapping.invalidate_lock#2){++++}-{4:4}, at: do_page_cache_ra mm/readahead.c:333 [inline]
 #1: ffff888077946ff0 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_order+0xad4/0xe80 mm/readahead.c:538
 #2: ffff888077946f50 (&xa->xa_lock#10){..-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:372 [inline]
 #2: ffff888077946f50 (&xa->xa_lock#10){..-.}-{3:3}, at: __filemap_add_folio+0x9fe/0x1330 mm/filemap.c:876

stack backtrace:
CPU: 1 UID: 0 PID: 5830 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5537 [inline]
 lock_release+0x248/0x3c0 kernel/locking/lockdep.c:5889
 rcu_lock_release include/linux/rcupdate.h:322 [inline]
 rcu_read_unlock include/linux/rcupdate.h:881 [inline]
 lruvec_stat_mod_folio+0x28b/0x3e0 mm/memcontrol.c:985
 __filemap_add_folio+0xceb/0x1330 mm/filemap.c:924
 filemap_add_folio+0x264/0x530 mm/filemap.c:967
 page_cache_ra_unbounded+0x494/0xa10 mm/readahead.c:282
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0xae4/0xe80 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2664 [inline]
 filemap_get_pages+0x897/0x1ef0 mm/filemap.c:2710
 filemap_read+0x447/0x1230 mm/filemap.c:2806
 __kernel_read+0x504/0x9b0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x446/0x860 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x51d/0x9c0 security/integrity/ima/ima_api.c:300
 process_measurement+0x12cd/0x1c80 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2653
 do_open fs/namei.c:4701 [inline]
 path_openat+0x2e4d/0x3860 fs/namei.c:4858
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 file_open_name+0x162/0x1c0 fs/open.c:1322
 __do_sys_swapon mm/swapfile.c:3471 [inline]
 __se_sys_swapon+0x84a/0x2090 mm/swapfile.c:3436
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efed519c7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc370182b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007efed519c7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007efed5232e5b
RBP: 00007efed5232e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007efed53e63e0
R13: 00007efed524dd26 R14: 0000000000200000 R15: 00007efed53e63a0
 </TASK>
------------[ cut here ]------------
rrln < 0 || rrln > RCU_NEST_PMAX
WARNING: kernel/rcu/tree_plugin.h:443 at __rcu_read_unlock+0x79/0xe0 kernel/rcu/tree_plugin.h:443, CPU#1: syz-executor/5830
Modules linked in:
CPU: 1 UID: 0 PID: 5830 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:__rcu_read_unlock+0x79/0xe0 kernel/rcu/tree_plugin.h:443
Code: 75 66 41 83 3e 00 75 27 43 0f b6 04 3c 84 c0 75 41 8b 03 3d 00 00 00 40 73 0f 5b 41 5c 41 5d 41 5e 41 5f e9 59 12 11 0a cc 90 <0f> 0b 90 eb eb e8 6d 00 00 00 eb d2 89 d9 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90003b863f0 EFLAGS: 00010086
RAX: 00000000ffffffff RBX: ffff88803567a344 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8e37db44 RDI: ffff888035679e80
RBP: ffffc90003b86588 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1d06db0 R12: 1ffff11006acf468
R13: dffffc0000000000 R14: 00000003fffffffc R15: dffffc0000000000
FS:  00005555886db540(0000) GS:ffff888125304000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36450057b8 CR3: 00000000762a4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __filemap_add_folio+0xceb/0x1330 mm/filemap.c:924
 filemap_add_folio+0x264/0x530 mm/filemap.c:967
 page_cache_ra_unbounded+0x494/0xa10 mm/readahead.c:282
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0xae4/0xe80 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2664 [inline]
 filemap_get_pages+0x897/0x1ef0 mm/filemap.c:2710
 filemap_read+0x447/0x1230 mm/filemap.c:2806
 __kernel_read+0x504/0x9b0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x446/0x860 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x51d/0x9c0 security/integrity/ima/ima_api.c:300
 process_measurement+0x12cd/0x1c80 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2653
 do_open fs/namei.c:4701 [inline]
 path_openat+0x2e4d/0x3860 fs/namei.c:4858
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 file_open_name+0x162/0x1c0 fs/open.c:1322
 __do_sys_swapon mm/swapfile.c:3471 [inline]
 __se_sys_swapon+0x84a/0x2090 mm/swapfile.c:3436
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efed519c7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc370182b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007efed519c7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007efed5232e5b
RBP: 00007efed5232e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007efed53e63e0
R13: 00007efed524dd26 R14: 0000000000200000 R15: 00007efed53e63a0
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

