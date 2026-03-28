Return-Path: <cgroups+bounces-15087-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAOEHsNjx2kWWgUAu9opvQ
	(envelope-from <cgroups+bounces-15087-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 06:14:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C270634D4D6
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 06:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE5030210C5
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 05:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BE329C6D;
	Sat, 28 Mar 2026 05:14:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5F2CCB9
	for <cgroups@vger.kernel.org>; Sat, 28 Mar 2026 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774674871; cv=none; b=KwBQsD8K7QmHZs+tzLHKjb0stdHyMVO5iCAftlyE/ArXEyM7kUNsS9hRT2O08UWIN6/k4bX7RqzBMfZIXjXtXPVwYw2Fdut+P8IcOjvRmIPDJKS8XSvuCNljD0VJPp9cgGdy6IuQpUaYH4hKd4+l6Z0zH2SgushS3eFZdC40PlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774674871; c=relaxed/simple;
	bh=Zhx+/Pik8mjbNJSvOH75wH+cVSSjqnEyEngckM27kY0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g6IDetwcPz8/UWG8QzY1DU9iKigzdo6fdcBrrrOzQO5eUaZEJ5tnGxmiU4GC8vU25IdcxqqZBI7LHCQR2gvzJNqCZvnKRd8cv74yaES8fwvjm06AsLY/ynqJud/aPCVhmtIKs9W4NiK+jvYDtJWbWWyaP3ou5jNEXbaCxZuyiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d7e660f1e2so12043718a34.3
        for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 22:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774674869; x=1775279669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrlfYzGaZgd+YLZ9uL1yPOfSpJdSlyUyCfs6atiEcFw=;
        b=Tl4vG/rPR9r+A7LPB3bWwGiKdmWx43/vfdQi1wD/pK+oW22dX+FQIBI/6NRliPGBPU
         XWXNxluQm0lBBKZCw6Y54O8aSuUhtKvr90xRAYs6qLPSsUzlIdyL57NvyZRFhTTeB1+K
         nkWHMhB2bqeyhoHdSvpjAzxUOe9dh+u5+YOD/d+RYwIoXOVWLbQl6id94zcbjZnTlEPz
         +pI0ndw5XP1tUJdErSXlp2ud34LUWm5/tf6AQnNbYf/ImFik3+ZY0BsmPpotEXn5CW32
         0n68yc/B9Jw647vDklS4kN65fyvfF28INfkkciYVo/7MG4o8MdFpf1od/mqypMPjcTjl
         7IHg==
X-Forwarded-Encrypted: i=1; AJvYcCX0tz0qkK+NoJoGW2aNElJOtAMlhO2r37QYMF1jsr08qAW+WUIIYorn/gD8kr/oDosoOSQ2IByy@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnmzfF/wXkJ+D1vcMvziVr22kxeJBkso0MMCmdV+0jbupRHIn
	TxLZoXi94hOm9t/IdGx9VCFBBzCoA160Bj1iYbYUO0kC4tNf/f6u3jAuIwd62YEGLTfjIcsj7OC
	HrHJTWOSFUJGDcJl73vMlN2p8C0WNr5TaAP/lGA7oN1gJHxkF1M1norrAJmE=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:99c:b0:67b:c9fa:c310 with SMTP id
 006d021491bc7-67e187726b3mr2714750eaf.68.1774674869418; Fri, 27 Mar 2026
 22:14:29 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:14:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c763b5.a70a0220.128fd0.001a.GAE@google.com>
Subject: [syzbot] [mm?] [cgroups?] WARNING in page_counter_uncharge (2)
From: syzbot <syzbot+226c1f947186f8fef796@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, netdev@vger.kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15087-lists,cgroups=lfdr.de,226c1f947186f8fef796];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: C270634D4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    5597dd284ff8 net: ti: icssg-prueth: fix missing data copy ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17f536da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=226c1f947186f8fef796
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131baeda580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167d6f72580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6c0ef6a1be9/disk-5597dd28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38b971059ff5/vmlinux-5597dd28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55dd4bd79e77/bzImage-5597dd28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+226c1f947186f8fef796@syzkaller.appspotmail.com

------------[ cut here ]------------
page_counter underflow: -512 nr_pages=512
WARNING: mm/page_counter.c:61 at page_counter_cancel mm/page_counter.c:60 [inline], CPU#1: syz.0.3396/16434
WARNING: mm/page_counter.c:61 at page_counter_uncharge+0xd2/0x150 mm/page_counter.c:184, CPU#1: syz.0.3396/16434
Modules linked in:
CPU: 1 UID: 0 PID: 16434 Comm: syz.0.3396 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:page_counter_cancel mm/page_counter.c:60 [inline]
RIP: 0010:page_counter_uncharge+0xd8/0x150 mm/page_counter.c:184
Code: f7 e8 7c 88 f8 ff 4d 8b 36 4d 85 f6 74 6e e8 cf 3f 8e ff e9 6c ff ff ff e8 c5 3f 8e ff 48 8d 3d 2e ea df 0d 4c 89 fe 48 89 da <67> 48 0f b9 3a 4c 89 f7 be 08 00 00 00 e8 e6 8a f8 ff 4c 89 f0 48
RSP: 0018:ffffc9000da772b0 EFLAGS: 00010093
RAX: ffffffff82376eab RBX: 0000000000000200 RCX: ffff88807c631e80
RDX: 0000000000000200 RSI: fffffffffffffe00 RDI: ffffffff901758e0
RBP: fffffffffffffe00 R08: ffff888032fd5387 R09: 1ffff110065faa70
R10: dffffc0000000000 R11: ffffed10065faa71 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888032fd5380 R15: fffffffffffffe00
FS:  0000000000000000(0000) GS:ffff88812555a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14ec9d5ff8 CR3: 000000000e54c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __hugetlb_cgroup_uncharge_folio+0x15e/0x510 mm/hugetlb_cgroup.c:354
 free_huge_folio+0xaef/0x11e0 mm/hugetlb.c:1782
 folios_put_refs+0x553/0x8d0 mm/swap.c:983
 folio_batch_release include/linux/pagevec.h:101 [inline]
 remove_inode_hugepages+0xf50/0x11a0 fs/hugetlbfs/inode.c:608
 hugetlbfs_evict_inode+0xaf/0x260 fs/hugetlbfs/inode.c:623
 evict+0x61e/0xb10 fs/inode.c:846
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 __fput+0x691/0xa70 fs/file_table.c:477
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x23c0 kernel/exit.c:976
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1118
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14ebb9c799
Code: Unable to access opcode bytes at 0x7f14ebb9c76f.
RSP: 002b:00007f14ec9d60e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f14ebe16098 RCX: 00007f14ebb9c799
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f14ebe16098
RBP: 00007f14ebe16090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f14ebe16128 R14: 00007ffc404c7910 R15: 00007ffc404c79f8
 </TASK>
----------------
Code disassembly (best guess):
   0:	f7 e8                	imul   %eax
   2:	7c 88                	jl     0xffffff8c
   4:	f8                   	clc
   5:	ff 4d 8b             	decl   -0x75(%rbp)
   8:	36 4d 85 f6          	ss test %r14,%r14
   c:	74 6e                	je     0x7c
   e:	e8 cf 3f 8e ff       	call   0xff8e3fe2
  13:	e9 6c ff ff ff       	jmp    0xffffff84
  18:	e8 c5 3f 8e ff       	call   0xff8e3fe2
  1d:	48 8d 3d 2e ea df 0d 	lea    0xddfea2e(%rip),%rdi        # 0xddfea52
  24:	4c 89 fe             	mov    %r15,%rsi
  27:	48 89 da             	mov    %rbx,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 89 f7             	mov    %r14,%rdi
  32:	be 08 00 00 00       	mov    $0x8,%esi
  37:	e8 e6 8a f8 ff       	call   0xfff88b22
  3c:	4c 89 f0             	mov    %r14,%rax
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

