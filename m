Return-Path: <cgroups+bounces-10508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28EBBB1B05
	for <lists+cgroups@lfdr.de>; Wed, 01 Oct 2025 22:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9924A37D9
	for <lists+cgroups@lfdr.de>; Wed,  1 Oct 2025 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8032F25E7;
	Wed,  1 Oct 2025 20:29:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39B26A0D5
	for <cgroups@vger.kernel.org>; Wed,  1 Oct 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350574; cv=none; b=hHcZFCM6Pqiq6asvStdFEfrgQzbaHMCKY2SRUrWFKNKRym9yAwP4s59XEPxJ+OS7zcozzgVu3onyOcNgvkEIb0xv6NI1vplSUQGmeG07ufVbs6UwSYQY7jSvD2sCqo6N9BkpV2toK4CYVrh7XU2fbQ0AjWJyvlqzp6ltrT5QMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350574; c=relaxed/simple;
	bh=XH3T/10P72IKKUmVFp7Rv+eTmEHZ1Y74XJiYJxDoHBQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PC5CzyyySH+S1Kls0LsGRDi7UQgV1DmN3KjXlrVYq4JqJ9jzRtpcc+VvV1MFA3xEZywqbrIIuEHvTq8vdwKBV1OvKPYG8FI32LDlbAKNxQ6Upfa9BtIad6ALulU+dw96dHwCIO3RIdKcOUtEIlXpAE8dKKRq+pJhNT4G2XsGmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42571c700d2so6508215ab.1
        for <cgroups@vger.kernel.org>; Wed, 01 Oct 2025 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350572; x=1759955372;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rKCMY37CxQD46qh+PeRnNb2w8TXgMHK01H6JHH+B/Q=;
        b=v2WHGY/b0DNKHxR4N83KXc60aKKf3M5aQoieHlFqdebyTjCffqoLRNSSOrvCCIhzMU
         Ndeyj2Oej/AFXCZLOfcWpNI3RR5rO6jQvR20kphVeJ8AgaJMvbqPKk07GijCsX79fhiw
         6soqnUJqE/85We3q0MjiW2ejdu58VQe3Ol2Ho7v8GeCzmxzGBF+5S5vzvhOmY8cOv9qj
         GoDiZU+LwE69shp2qvSUTEIeZpDcc6xJu5zg5fJiMWA2c3f6ROPYNu6HAWTYk7wFsZBg
         G7ssJgPXaH6jmIijpbbv2dvkYpO5WOnowDBzABE+tT4DMic0Y/9EBewpaGzI8HZspDVJ
         SSEg==
X-Gm-Message-State: AOJu0YwweeJTk+gRPOCwOHBOIaoxOetIS6mS3zPoAGrUmcWYXaqyeqUY
	x0cFFjlX0NM8YmEycV+meCyiVemIRkMnhhNMpFhBaCJzRseDaEsNJhCDBy8ZqQCmcTSQ0BLP5Ic
	lrJ86bwDZ0gXOrtWiSXB8vmMgpKRO87i6Z7YlUjEtEb5mY6ZTq+CyTo/6GJJ5Pw==
X-Google-Smtp-Source: AGHT+IHFvXXdC+FlJy5u0LnRTwKXq+EYlppH8dctvYNVwRSUDYn0WWU7ltijsHXNzIyff9gNVUTlG7RjO5fyQ+caYDdfDJN1cm+s
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:427:6e7f:89f8 with SMTP id
 e9e14a558f8ab-42d815b058cmr71169935ab.10.1759350572263; Wed, 01 Oct 2025
 13:29:32 -0700 (PDT)
Date: Wed, 01 Oct 2025 13:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd8f2c.a00a0220.102ee.0064.GAE@google.com>
Subject: [syzbot] [cgroups?] WARNING in free_cgroup_ns
From: syzbot <syzbot+df1938772e627cb4c344@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=17833858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=df1938772e627cb4c344
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab28792ceef0/disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74ce29f3948d/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7409ad2d53d2/bzImage-50c19e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df1938772e627cb4c344@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=1036 which is not allocated.
WARNING: CPU: 0 PID: 12953 at lib/idr.c:592 ida_free+0x280/0x310 lib/idr.c:592
Modules linked in:
CPU: 0 UID: 0 PID: 12953 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x280/0x310 lib/idr.c:592
Code: 00 00 00 00 fc ff df 48 8b 5c 24 10 48 8b 7c 24 40 48 89 de e8 71 2c 0c 00 90 48 c7 c7 a0 7b 76 8c 44 89 fe e8 41 11 54 f6 90 <0f> 0b 90 90 eb 34 e8 85 a2 90 f6 49 bd 00 00 00 00 00 fc ff df eb
RSP: 0018:ffffc90004bb7980 EFLAGS: 00010246
RAX: 055dca84e2fee400 RBX: 0000000000000a02 RCX: ffff88807e55dac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90004bb7a70 R08: ffff8880b8824293 R09: 1ffff11017104852
R10: dffffc0000000000 R11: ffffed1017104853 R12: 1ffff92000976f34
R13: dffffc0000000000 R14: ffff888030161f00 R15: 000000000000040c
FS:  0000000000000000(0000) GS:ffff888126373000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a1adf5dac CR3: 0000000064586000 CR4: 00000000003526f0
DR0: 0000200000000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 free_cgroup_ns+0x136/0x180 kernel/cgroup/namespace.c:43
 put_cgroup_ns include/linux/cgroup_namespace.h:40 [inline]
 free_nsproxy+0x231/0x350 kernel/nsproxy.c:194
 do_exit+0x6b0/0x2300 kernel/exit.c:960
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ca338d710
Code: Unable to access opcode bytes at 0x7f0ca338d6e6.
RSP: 002b:00007ffca2477370 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: 0000000000000007 RBX: 0000000000000000 RCX: 00007f0ca338d710
RDX: 0000000000000000 RSI: 00007ffca24774a0 RDI: 00000000ffffff9c
RBP: 00007ffca24774a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffca2478590
R13: 00007f0ca3411d7d R14: 000055556af604a8 R15: 0000000000000007
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

