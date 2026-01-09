Return-Path: <cgroups+bounces-13012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0EED08051
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FD1F300B378
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1DC355807;
	Fri,  9 Jan 2026 08:57:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04203559C4
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949049; cv=none; b=a1gtfa2Z6YqfDKXhfEvpr04ILCL0Bj0nj2YKAW2IvRiqmNokyotbBQtahIYtOOf42iFKM8LhBNiKOYnaXpxJCSxRH+WlJoKdjsfHtGljI9JKvu1iuSkR9J23TOlDvYlBcgi0dlvxUfvSTloNxqtwL+C5iIGhtQ5vcbCdDYK+QZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949049; c=relaxed/simple;
	bh=bYvQeWULVQA4jygQF2Qi1y5u1I1wc6vswKcdpgnFi6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iTDQVxLVRNcJa99D/zsvFKKraXL2qlTLHSTN1IcfcP+bBl2yHNCCsAKrX2Rp9XWm+jePVYJ1aH7wQ1aoYuHKaVSx4RjUjTvm2YZVYkRgtN3wWpudl20bsTjxlp9JsLSUVadLNrOsFMcXRJL0osvixN1eniYGCnVivafgJc0U3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-459bcc4d8bcso4926239b6e.1
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 00:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949040; x=1768553840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W86WjpQ/KJudncm4mQNaQd0Gv5QEx6xj10h2rWhamY=;
        b=w8z5LYLet46rYgSV8bo8+qEXdYGm906E4gqAjxFl0UyajOadR12vRN4c2iQfhRtgLk
         LUaYhPVRhqckYRna/qgjtluROS9ANKs+EC0YVk3fk15z+pT7hvMAsNmIRiksPqf6X/jQ
         dtq/F10xm3RBiEv+gWfCk648F1B8LKjNZlozpaJZ5TUBUVUfTPauYxx9et70I2qCn2hY
         vg91/BIaTPaMlLbskqlerjbDRskSTIdbtpkLw3g3PQuzL1kk3JaXlj+N+UisgvNgqJg+
         viinpw9NQbj3f4BPquIDSc61oeLnBayIvpW5HHG+jSOU/8U78iEyHFZO/36UKet+wlj8
         4fCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNCEniu0x25V8h3AXFJAKXg4nuWnL2doNap9RBirXqhTeJBuCZ1MSv02vopjI/k2p3G3UwdUf+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nSMZQIOo5PNXfzmzLUl9UYSILWszlU3xbqxbfqzj1IBRAiAt
	y5lJfVDVsVjSZgV9WH1iDIlvmLBlcDdySU2Hc9KcgWq3WYLQqCKB9SREpEz7d9JdaEgpsPZ23ND
	M3rb887zzJlFH4uBc4oASEeOhUpVMcOkLq28YouE2GmnHEzYh14DlO0nUZCg=
X-Google-Smtp-Source: AGHT+IH94OxYqGbW8rUXBldeb7R123k2f0gTWOONAkk7FH6lMOxKPV7NFmPRoRd/t3wxr3ON97DuEnjmjXHuAuTjwsD9ch3UBkn9
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1599:b0:45a:5584:9bf6 with SMTP id
 5614622812f47-45a6be3f8b8mr4481115b6e.39.1767949040140; Fri, 09 Jan 2026
 00:57:20 -0800 (PST)
Date: Fri, 09 Jan 2026 00:57:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6960c2f0.050a0220.1c677c.03be.GAE@google.com>
Subject: [syzbot] [mm?] [cgroups?] kernel BUG in swap_cgroup_record (2)
From: syzbot <syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f8f97927abf7 Add linux-next specific files for 20260105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=131ff69a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0672dd8d69c3235
dashboard link: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17065efc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176c9e9a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1837bbc8e23e/disk-f8f97927.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07390717f7e4/vmlinux-f8f97927.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f4a72ec80dc/bzImage-f8f97927.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/swap_cgroup.c:78!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6176 Comm: syz.0.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
Code: 02 e9 6d ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 35 ff ff ff 4c 89 f7 e8 cf 84 f6 ff e9 28 ff ff ff e8 e5 c1 8f ff 90 <0f> 0b e8 dd c1 8f ff 4c 89 f7 48 c7 c6 80 f6 98 8b e8 de d4 f6 fe
RSP: 0018:ffffc90003176720 EFLAGS: 00010093
RAX: ffffffff8231359b RBX: 0000000000001b88 RCX: ffff8880351f9e40
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200062ecd4 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc900041b1000 R15: 0000000000000002
FS:  00007feeba18f6c0(0000) GS:ffff8881259c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feeba18ef98 CR3: 0000000077742000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 memcg1_swapout+0x2fa/0x830 mm/memcontrol-v1.c:623
 __remove_mapping+0xac5/0xe30 mm/vmscan.c:773
 shrink_folio_list+0x2786/0x4f40 mm/vmscan.c:1528
 reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2208
 reclaim_pages+0x454/0x520 mm/vmscan.c:2245
 madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
 walk_pmd_range mm/pagewalk.c:130 [inline]
 walk_pud_range mm/pagewalk.c:224 [inline]
 walk_p4d_range mm/pagewalk.c:262 [inline]
 walk_pgd_range+0x1037/0x1d30 mm/pagewalk.c:303
 __walk_page_range+0x14c/0x710 mm/pagewalk.c:410
 walk_page_range_vma_unsafe+0x34c/0x400 mm/pagewalk.c:714
 madvise_pageout_page_range mm/madvise.c:622 [inline]
 madvise_pageout mm/madvise.c:647 [inline]
 madvise_vma_behavior+0x3132/0x4170 mm/madvise.c:1366
 madvise_walk_vmas+0x575/0xaf0 mm/madvise.c:1721
 madvise_do_behavior+0x38e/0x550 mm/madvise.c:1937
 do_madvise+0x1bc/0x270 mm/madvise.c:2030
 __do_sys_madvise mm/madvise.c:2039 [inline]
 __se_sys_madvise mm/madvise.c:2037 [inline]
 __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:2037
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feeb938f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feeba18f038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007feeb95e6090 RCX: 00007feeb938f749
RDX: 0000000000000015 RSI: 0000000000800000 RDI: 0000200000000000
RBP: 00007feeb9413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feeb95e6128 R14: 00007feeb95e6090 R15: 00007ffd48399048
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
Code: 02 e9 6d ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 35 ff ff ff 4c 89 f7 e8 cf 84 f6 ff e9 28 ff ff ff e8 e5 c1 8f ff 90 <0f> 0b e8 dd c1 8f ff 4c 89 f7 48 c7 c6 80 f6 98 8b e8 de d4 f6 fe
RSP: 0018:ffffc90003176720 EFLAGS: 00010093
RAX: ffffffff8231359b RBX: 0000000000001b88 RCX: ffff8880351f9e40
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200062ecd4 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc900041b1000 R15: 0000000000000002
FS:  00007feeba18f6c0(0000) GS:ffff8881259c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feeba18ef98 CR3: 0000000077742000 CR4: 00000000003526f0


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

