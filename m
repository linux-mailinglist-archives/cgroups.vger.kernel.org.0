Return-Path: <cgroups+bounces-5767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CC9E5D9E
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832FB165B28
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC1225770;
	Thu,  5 Dec 2024 17:48:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5667218E98
	for <cgroups@vger.kernel.org>; Thu,  5 Dec 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420908; cv=none; b=dq5aN4Jd72T8bY5fTWlEfK0cyF00PZcod5VnsY7Di1jmzE8UeBNYspEMslv/PZ3hWTT4WA4VsWI9VeRhfbiIx8jPqNwh6hliMnkMsovPmdTFuuqfCxXmYgOXGtDQMIu9UQQaDBp3VR0el24Ik6FDXtItGAWda2E71Nl4Rk6Yeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420908; c=relaxed/simple;
	bh=jKJaUzc7Q2siYZjc6/SsnwWJq8cwB+WZDnbLWj9XuqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TeiUfoYcUPAO7C7txdX/0d1jazAPh/W+mNvo9zkWG9rAxPwZlDfh4vpOl4On3WI7Q0nwNHFuCv0oouEAv0usNF1SoR7wHEG04BpACevw0++mXlPONGNbiLUELGpn3KByUPTQrSTBQoXHcHuAsVUcyBas3XPS4IGAVmw0k5FEWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso22063075ab.3
        for <cgroups@vger.kernel.org>; Thu, 05 Dec 2024 09:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420906; x=1734025706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCiTiXYqWNNwhIPIBBgITq4kwye1QvnR7vCtkwlzAg0=;
        b=Mj4fcL28tSdQ2ShaFHJasV4W+b3+Q/6/vlT/dVx47Idfr/+ahGzlm217XpFurAMCSA
         ht/4iQSeGkE/CFw+P3SdVqflJCwiJgoSxm6GXr8Nas/n6H/uh9pgixZi1A/R6MlMs+9c
         Pm/Ks5+59CGMNR+qsIeOJTwbQow8OypW+w+IWEb+i7rsl2xz06b+60h2/cmwetGzeo7D
         psZDR6zqJh8rR0SBt4wPjE8QFQUVjzkaoViM7wcWUAWTOjL3BmTiOa8PX1YqdBvIhFbB
         eDZv+kyXqVKIeguq33G3KWMSLHPlDjc9l33sa531JdEj+tlbYVgm/rpKkdrCyh+SItiu
         HTsw==
X-Gm-Message-State: AOJu0YzxTBX0l1JuUn7L3EbeEpUaOyYmuddJZZVMQZ2i/HGTGmmO9pEt
	O4CULiJ5MHeuFA3xqQFWxMvZ4ateI4HpGL4F76+rJ9F7Fucum3rlWngpf4Bo77nJe5UbHXvfMZm
	RJh2zYZXlWIn3JEeSEzUVWDf0fL7iB3G2l2l+HEurBksHDMZMIIlGLzTeNQ==
X-Google-Smtp-Source: AGHT+IGXUT71MVLjpr6Etx8JynFsUg0ESuSnn3CKBCgOdDQ55gg//Q6DeXFNFM3BA8UILtYdHoc/05CRd1ksnhP9mgVPuVK5Xs9E
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3a811e2f7femr2193935ab.21.1733420905894; Thu, 05 Dec 2024
 09:48:25 -0800 (PST)
Date: Thu, 05 Dec 2024 09:48:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751e769.050a0220.b4160.01df.GAE@google.com>
Subject: [syzbot] [cgroups?] general protection fault in __cgroup_rstat_lock
From: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    932fc2f19b74 Merge branch 'irq-save-restore'
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fd6330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cdfc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dfc8df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afd76657938b/disk-932fc2f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ab299e9b5df/vmlinux-932fc2f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6617519fa7b9/bzImage-932fc2f1.xz

Bisection is inconclusive: the first bad commit could be any of:

42d9e8b7ccdd Merge tag 'powerpc-6.13-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121e8020580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00007ffee33edd87 R09: 00007fe28ebf71e7
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffee33ee00c
R13: 00007ffee33ee030 R14: 00007ffee33ee070 R15: 0000000000000001
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 5842 Comm: syz-executor126 Not tainted 6.13.0-rc1-syzkaller-00032-g932fc2f19b74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:do_perf_trace_cgroup_rstat include/trace/events/cgroup.h:207 [inline]
RIP: 0010:perf_trace_cgroup_rstat+0x2b2/0x580 include/trace/events/cgroup.h:207
Code: 8d 98 58 04 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 fc 0c 75 00 48 8b 1b 48 83 c3 0c 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 d5 01 00 00 44 8b 2b 49 8d 5f 08 48 89
RSP: 0018:ffffc90003837a80 EFLAGS: 00010003
RAX: 0000000000000001 RBX: 000000000000000c RCX: ffff8880345ada00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880b8737768
RBP: ffffc90003837b70 R08: ffffffff81a90e9b R09: 1ffffffff20328d6
R10: dffffc0000000000 R11: fffffbfff20328d7 R12: ffff8880b87376e0
R13: 1ffff92000706f5c R14: dffffc0000000000 R15: ffffe8ffffd30be8
FS:  000055558b3013c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000050c CR3: 00000000329de000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_cgroup_rstat_locked include/trace/events/cgroup.h:242 [inline]
 __cgroup_rstat_lock+0x3e1/0x590 kernel/cgroup/rstat.c:292
 cgroup_rstat_flush+0x30/0x50 kernel/cgroup/rstat.c:353
 cgroup_rstat_exit+0x27/0x1e0 kernel/cgroup/rstat.c:411
 cgroup_create kernel/cgroup/cgroup.c:5782 [inline]
 cgroup_mkdir+0x53a/0xd60 kernel/cgroup/cgroup.c:5831
 kernfs_iop_mkdir+0x253/0x3f0 fs/kernfs/dir.c:1246
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4311
 do_mkdirat+0x264/0x3a0 fs/namei.c:4334
 __do_sys_mkdir fs/namei.c:4354 [inline]
 __se_sys_mkdir fs/namei.c:4352 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4352
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe28eba7a19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee33edfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe28eba7a19
RDX: 0000000000000000 RSI: d0939199c36b4d28 RDI: 0000000020000000
RBP: 0000000000000001 R08: 00007ffee33edd87 R09: 00007fe28ebf71e7
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffee33ee00c
R13: 00007ffee33ee030 R14: 00007ffee33ee070 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_perf_trace_cgroup_rstat include/trace/events/cgroup.h:207 [inline]
RIP: 0010:perf_trace_cgroup_rstat+0x2b2/0x580 include/trace/events/cgroup.h:207
Code: 8d 98 58 04 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 fc 0c 75 00 48 8b 1b 48 83 c3 0c 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 d5 01 00 00 44 8b 2b 49 8d 5f 08 48 89
RSP: 0018:ffffc90003837a80 EFLAGS: 00010003
RAX: 0000000000000001 RBX: 000000000000000c RCX: ffff8880345ada00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880b8737768
RBP: ffffc90003837b70 R08: ffffffff81a90e9b R09: 1ffffffff20328d6
R10: dffffc0000000000 R11: fffffbfff20328d7 R12: ffff8880b87376e0
R13: 1ffff92000706f5c R14: dffffc0000000000 R15: ffffe8ffffd30be8
FS:  000055558b3013c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000050c CR3: 00000000329de000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 98 58 04 00 00    	lea    0x458(%rax),%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 fc 0c 75 00       	call   0x750d18
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 0c          	add    $0xc,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 d5 01 00 00    	jne    0x20c
  37:	44 8b 2b             	mov    (%rbx),%r13d
  3a:	49 8d 5f 08          	lea    0x8(%r15),%rbx
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

