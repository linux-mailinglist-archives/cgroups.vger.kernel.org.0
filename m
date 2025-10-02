Return-Path: <cgroups+bounces-10512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B0BB2852
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 07:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13654169DC7
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73231C84DF;
	Thu,  2 Oct 2025 05:18:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A12AF1D
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382307; cv=none; b=DNMMvu92uRTO7Y44V39TPSZ276KmQZqOZtA3kOvfQl1f6yDCtr/apyXi5FlcQ5bDeEZOYwf/ZuJsNgEpQFCV2OvlsBVjgz/oyw9ZDDxFDRgj7ikTfwbw80Y2oueR7vlKdRQaNJQc2ghKtAtEMgnGKDLd/RuWLcdMrF1PW3dD1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382307; c=relaxed/simple;
	bh=+gv1NPtxVyBvjhO4poNs692kcgzTCPR39tA2vbSRsyE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M8/jHp7htu84KJhPqZ9nlNjdI2crztZXMz1YG4qFcfXRQf/lMVzPf0Jx9qRIR0ZOJfgjdaV/O61cnNZjKkfsv7QLfp6sv+kLtkqaEz7uZU3LvqCZ6yT773JHUcV9pzk8J8U3LVKv2h0mxTK6yayo3jAJ+7RhBIDWgn/TqYguWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8875a8663d0so69745739f.1
        for <cgroups@vger.kernel.org>; Wed, 01 Oct 2025 22:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759382305; x=1759987105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uswKdbmbFdorjou4cYVY+CuInKwkUZTHRb1ChJq4MHM=;
        b=QYXNImGRnBCRpoGTCh7U8xB2Fr0CDABdukWhNrozKOljlb/O+7g3R4hI9tOrUviOMt
         oRPNWipRcHQBrpvq6lo1iCEtOClM0byRJozY/kc+2ikPMDSgwUEdrR03XYkmlOARo5GO
         TminuX/op/mayTMacFpgKKLHOk/+ZzPTFsXki5qXLxIF7Uls0QROAkDGg705xLtGH6pz
         7OUDOW3aS5Mv96Lpj2WZaHizNvRKisIOhGjpLu7swUp2FzjqfF+eVhffBmgkeu9Hmq/u
         wzkxkshCHmKbTvjyLDBMXSSh9CowBu4DLaEjaw435sfbpTrQllkdp1kkj4bS0CU2M0B+
         KiDA==
X-Gm-Message-State: AOJu0YxTveDXLVeSs98SK+RdAQy6MbWcxZu/dMo4QpFrqC2noJILQH85
	6Q98GK5jZtaZ81lRP6bAAwNrfq6igvqabUR4G2GCedVxbXNotgEqAtjtZQC+bo+LwG/ZuFnKfPC
	LFy9AwwcymrTX+GRtTfxP9p3UI7y8Tv8SS24BbhnBIAwnHrI1gu1ahnNowHh9Hw==
X-Google-Smtp-Source: AGHT+IHyrdlk2I1QlbI0wSYbvczysDkAsI4dSX9iWmCyD06Om9SRHKXunKhmzQ+juNoCADMlnUXy58ziTz15dLl6v3Q3kH9i9J5F
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1482:b0:92e:772:9323 with SMTP id
 ca18e2360f4ac-937ade42cf6mr999929439f.16.1759382305117; Wed, 01 Oct 2025
 22:18:25 -0700 (PDT)
Date: Wed, 01 Oct 2025 22:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de0b21.050a0220.25d7ab.077d.GAE@google.com>
Subject: [syzbot] [cgroups?] WARNING in cgroup_freeze
From: syzbot <syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, corbet@lwn.net, hannes@cmpxchg.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, ynaffit@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137446e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfc4e6ee70d55834
dashboard link: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eba42c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15de5d04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10a80b79b188/disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e782595cfe10/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9166ef44f6be/bzImage-50c19e20.xz

The issue was bisected to:

commit afa3701c0e45ecb9e4d160048ca4e353c7489948
Author: Tiffany Yang <ynaffit@google.com>
Date:   Fri Aug 22 01:37:52 2025 +0000

    cgroup: cgroup.stat.local time accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c22092580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c22092580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c22092580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6062 at ./include/linux/seqlock.h:221 __seqprop_assert include/linux/seqlock.h:221 [inline]
WARNING: CPU: 0 PID: 6062 at ./include/linux/seqlock.h:221 cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
WARNING: CPU: 0 PID: 6062 at ./include/linux/seqlock.h:221 cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
Modules linked in:
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
RIP: 0010:cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
RIP: 0010:cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
Code: 90 e9 9e fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c e7 f9 ff ff 4c 89 f7 e8 e1 43 67 00 e9 da f9 ff ff e8 17 68 06 00 90 <0f> 0b 90 e9 10 fc ff ff 44 89 f9 80 e1 07 38 c1 48 8b 0c 24 0f 8c
RSP: 0018:ffffc90003e7f8e0 EFLAGS: 00010293
RAX: ffffffff81b6c6a9 RBX: 0000000000000000 RCX: ffff88802ff60000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003e7fa70 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d6d2a7 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff888031790791
FS:  0000555589dcd500(0000) GS:ffff888127017000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f163fff CR3: 000000002f824000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cgroup_freeze_write+0x156/0x1c0 kernel/cgroup/cgroup.c:4174
 cgroup_file_write+0x39b/0x740 kernel/cgroup/cgroup.c:4312
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f717e32eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6a7c7c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f717e585fa0 RCX: 00007f717e32eec9
RDX: 0000000000000012 RSI: 0000200000000200 RDI: 0000000000000004
RBP: 00007f717e3b1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f717e585fa0 R14: 00007f717e585fa0 R15: 0000000000000003
 </TASK>


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

