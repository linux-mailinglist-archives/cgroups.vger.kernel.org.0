Return-Path: <cgroups+bounces-4318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AAB954124
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 07:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BEB1F2500D
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191127DA96;
	Fri, 16 Aug 2024 05:28:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90078C68
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786105; cv=none; b=ornTtiO5lwHVkeQZ8yGrbGQ8Ux3/+yf5v+B8KLXT/qW2XoP4cLICS0tcb/sWP6ibENuxqBgpXPf2ec4wrVWhMbU/iMpCt3OM1f6+fZi8EfNm/xMLySZQlpLkhGx5v/+n16dEYB5v3ep72BAZVDnqEGMtqlqexfHvbtb75NvuwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786105; c=relaxed/simple;
	bh=4z2Syb1+eS522vjsqVxXqzcKWCEZYptdpr7QFMsxdsg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cOIRcW5mttVzIj6JAocPsUgTeplTXvjeK+PTZcxIq8LOiO9aiw6q7wWpRx4/3udRESgLORjO3aYPsjtlnzUPMjlvYWvOHcmCGOQwjweMezeYX+vCH5kfVE7x3UZryZ59H7W7ePjfwuURc5yvMuvkyeShfBFP29Wnxb8mvcDB1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8489097eso165483839f.3
        for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 22:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786103; x=1724390903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfkpXZlVfKsNrt8/k0HrMw88NUkmjdtZRZe3QSFlO/8=;
        b=fbnjyUjonFG+eFLi9FEzu5Ghl+GDHnCj4ESdkqBc1lZIdBcmKfG1F5a/eRTcTSttjW
         BbpcTiN5VGxPD55oydMEYf6zs6lRySdhxkY8Ys+alhshwwiLxlHx5cFt1MVgqWVo9POa
         VHHRcg0zVaNm9Q02v/u0nIQ+swsODtcw/dHejHaonugyxpry4p+qSEwIl6JcsPfGwwsL
         x5M+Dg8aIzqlix9tC9cpd6L3vuLJq9G/J3eyEoH+SfmNGFqGBVHG8VuLAEAXfFJeAGJA
         q6hxlHb558R+3NSwXCItt9qFv+UPEeuDDufQQiw0Nty1DvDzjHM0CrU1nkT4TpaxZBgi
         43FA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Rdz5hG03y/Tr9809LDy1tZtJ6pLIKxcNGRvmbJNv9lg/O0E8w9JUUshiA/MbnfEYcs0czCciofqdQkrEqTDDcYtSeJcZ/Q==
X-Gm-Message-State: AOJu0YyXw1H3BFZ4478/OKNN1qH+HW03yPK7DuNVjy7rA85Fc3y887/E
	3ZYI0vkxHxSRlff3JaVUrfP1tEPj3EZq+FB+gSRYUivICaGugBc7cuU3Vcz+wMaOUUzGT4+LpUt
	/vR8aVSARa4FZ3JQVjX0t6OrfJqJxYWTxF2nrvdfQB3hdAcfoRz5LaVQ=
X-Google-Smtp-Source: AGHT+IFDit4P1gn68jUFHJU8L/e0XDfRjKECL8Eymwd2Zih5i4hexN6I8PdniqWcH8VorCrA5LmLAz4ovwjwLINinB+ct9CBe7hn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8416:b0:4c0:9380:a262 with SMTP id
 8926c6da1cb9f-4cce15bec24mr88570173.1.1723786103417; Thu, 15 Aug 2024
 22:28:23 -0700 (PDT)
Date: Thu, 15 Aug 2024 22:28:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cff41061fc63a83@google.com>
Subject: [syzbot] [cgroups?] [mm?] kernel BUG in swap_cgroup_record
From: syzbot <syzbot+4745e725b07d34503a64@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com, 
	v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c97e83980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=4745e725b07d34503a64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cf435d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz

The issue was bisected to:

commit d65aea610f0a14cda5ec56a154c724584ef7da17
Author: Barry Song <v-songbaohua@oppo.com>
Date:   Wed Aug 7 21:58:59 2024 +0000

    mm: attempt to batch free swap entries for zap_pte_range()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1493ea91980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1693ea91980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1293ea91980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4745e725b07d34503a64@syzkaller.appspotmail.com
Fixes: d65aea610f0a ("mm: attempt to batch free swap entries for zap_pte_range()")

------------[ cut here ]------------
kernel BUG at mm/swap_cgroup.c:141!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5371 Comm: syz.0.15 Not tainted 6.11.0-rc3-next-20240812-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:swap_cgroup_record+0x2cd/0x2d0 mm/swap_cgroup.c:141
Code: e7 e8 a7 c9 f6 ff e9 64 fe ff ff e8 cd 41 8e ff 48 c7 c7 c0 db a5 8e 48 89 de e8 2e 8c e8 02 e9 7a fd ff ff e8 b4 41 8e ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
RSP: 0018:ffffc90003e172f8 EFLAGS: 00010093
RAX: ffffffff82054c9c RBX: 000000000000000b RCX: ffff88802298bc00
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff82054b43 R09: fffff520007c2e3c
R10: dffffc0000000000 R11: fffff520007c2e3c R12: ffff88801cf0f014
R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9332107a8c CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mem_cgroup_uncharge_swap+0x84/0x2e0 mm/memcontrol.c:5118
 mem_cgroup_uncharge_swap include/linux/swap.h:668 [inline]
 swap_entry_range_free+0x45f/0x1120 mm/swapfile.c:1556
 __swap_entries_free mm/swapfile.c:1518 [inline]
 free_swap_and_cache_nr+0xa65/0xae0 mm/swapfile.c:1876
 zap_pte_range mm/memory.c:1653 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x1924/0x42c0 mm/memory.c:1807
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
 exit_mmap+0x267/0xc20 mm/mmap.c:1923
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9331f779f9
Code: Unable to access opcode bytes at 0x7f9331f779cf.
RSP: 002b:00007fff65ce5d18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9331f779f9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 00007fff65ce5dff R09: 00007f93320d0260
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f93320d0f68
R13: 00007f93320d0260 R14: 0000000000000003 R15: 00007fff65ce5dc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:swap_cgroup_record+0x2cd/0x2d0 mm/swap_cgroup.c:141
Code: e7 e8 a7 c9 f6 ff e9 64 fe ff ff e8 cd 41 8e ff 48 c7 c7 c0 db a5 8e 48 89 de e8 2e 8c e8 02 e9 7a fd ff ff e8 b4 41 8e ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
RSP: 0018:ffffc90003e172f8 EFLAGS: 00010093
RAX: ffffffff82054c9c RBX: 000000000000000b RCX: ffff88802298bc00
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff82054b43 R09: fffff520007c2e3c
R10: dffffc0000000000 R11: fffff520007c2e3c R12: ffff88801cf0f014
R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9332107a8c CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

