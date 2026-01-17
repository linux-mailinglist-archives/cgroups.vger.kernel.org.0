Return-Path: <cgroups+bounces-13285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB225D38D61
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2946F301FC10
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711EF332EB4;
	Sat, 17 Jan 2026 09:30:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF80314A8F
	for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768642228; cv=none; b=m32J5YUI1MlW0jJil8nd4x2jToLfzBmm3iek+lVtdGWplXergyfKDNajDCV43b01Q6ce8p8tKkifqsqlHNvmDsrE1W15Q8w+mfmCcFk1fNI7EJo1YEu5CD20imAR1WOuFUwJgvcJUFuUv9MY8xwdoxDPtjMy5xcMSXMpSVFGA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768642228; c=relaxed/simple;
	bh=8Rfce3r4pM+pQS4Jd9xqoncdBeuOw34h1IDSD9xWTkk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HgF+wO/9DyF/V8I16IJlKJutSYrqkRGpPlAu7Ooa/5wnNTjRYAQVYW4sJIxf1cef+1NhSK60ySpeCchGnr1cZFnbJVjb7I+3/8COAOcCVoX9zkwCawmEYqjczJZchpfyjQ6rLRoZXHTorgiI5LojTSg7IFTV1AjFVb3dM/uZxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7cfd9a9c1beso3821381a34.3
        for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 01:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768642225; x=1769247025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XB3GJ9jGo12ah0YoMousYr0on+EB70qgKXZwNDEX3ik=;
        b=wfLWGwncnPnL3U3asHxIirEqAqPn2mWfBjXEON+LM2Rk7fjYjdqdTbBtKw/HskfsII
         IExRmaGC/l7Ap3z3wYUbi8J6YivuGBGbSgF08enir8pmaBCVHRhrK3fghH8BEOVlUd7j
         l3jxiktYyik5voY2v15PvOxtSeV3XsdAZ3YRFbwpV2c4PlA4sHSH3F22Hs57l2RNCey7
         olN07M+E1eWXfCfh5TGeX+R4YLInfX75L/xsn0DXhPjqqes9vCZBnXmzr6moVlKuT5z5
         Zheryo+ky6mlOj21EQNnuHaue1ZkOa94Ui/zAoQjpOLYyOj77lpwYVYrq9Y4KONoNVYI
         uwEw==
X-Forwarded-Encrypted: i=1; AJvYcCVjFnxxXDvRM6qnSdRLjokQai5vhAMcZFPR4uB9/dn/kXfzLq97JZQFBL95pXUVcdEt6VnQeC6i@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ/7EMeRI0VUIgMSpdMeLfPRLfWP8h3PrIV+LoKg93bopHjmh
	ZOJLVatWt/wSWZjcxfeRlBOcDTDF6nFACo0nXy+WMdu+hkLB6TXK4ZHUnAsBHG0W3quTfdns8zL
	11gJa4sc22nBO54QXZmlON8XLyM+brTpmmswlpR8X3iTalzse/nCvhDob++0=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1689:b0:659:9a49:8de3 with SMTP id
 006d021491bc7-6611891632fmr2171729eaf.37.1768642225708; Sat, 17 Jan 2026
 01:30:25 -0800 (PST)
Date: Sat, 17 Jan 2026 01:30:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696b56b1.050a0220.3390f1.0007.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
From: syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7259a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d6e5303d96e21b5
dashboard link: https://syzkaller.appspot.com/bug?extid=079a3b213add54dd18a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167ef922580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d295fa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/480cd223f3f6/disk-0f853ca2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ca2f0dbb7cc/vmlinux-0f853ca2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60a0fef5805b/bzImage-0f853ca2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/memcontrol-v1.c:642 at memcg1_swapout+0x6c2/0x8d0 mm/memcontrol-v1.c:642, CPU#0: syz.4.233/6746
Modules linked in:
CPU: 0 UID: 0 PID: 6746 Comm: syz.4.233 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:memcg1_swapout+0x6c2/0x8d0 mm/memcontrol-v1.c:642
Code: 6d 5d 0d 00 0f 85 01 fa ff ff 48 89 df 48 c7 c6 a0 c3 98 8b e8 bf 8c f8 fe c6 05 77 6d 5d 0d 01 90 0f 0b 90 e9 e2 f9 ff ff 90 <0f> 0b 90 e9 eb fb ff ff 90 0f 0b 90 41 80 3c 2e 00 0f 85 d5 fe ff
RSP: 0018:ffffc9000bbae718 EFLAGS: 00010002
RAX: 0000000000000004 RBX: ffffea00017e9100 RCX: ffff888021f5c150
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc9000b59b404
RBP: dffffc0000000000 R08: ffffc9000b59b407 R09: 1ffff920016b3680
R10: dffffc0000000000 R11: fffff520016b3681 R12: ffffea00017e9108
R13: 1ffffd40002fd220 R14: 1ffffd40002fd221 R15: ffff88805398b178
FS:  00007fdd6c81a6c0(0000) GS:ffff888125bf7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000009a000 CR3: 0000000075930000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __remove_mapping+0xac5/0xe30 mm/vmscan.c:764
 shrink_folio_list+0x28d8/0x5320 mm/vmscan.c:1542
 reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2222
 reclaim_pages+0x454/0x520 mm/vmscan.c:2259
 madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
 walk_pmd_range mm/pagewalk.c:130 [inline]
 walk_pud_range mm/pagewalk.c:224 [inline]
 walk_p4d_range mm/pagewalk.c:262 [inline]
 walk_pgd_range+0x1037/0x1d30 mm/pagewalk.c:303
 __walk_page_range+0x14c/0x710 mm/pagewalk.c:410
 walk_page_range_vma_unsafe+0x34c/0x400 mm/pagewalk.c:714
 madvise_pageout_page_range mm/madvise.c:622 [inline]
 madvise_pageout mm/madvise.c:647 [inline]
 madvise_vma_behavior+0x30c7/0x4420 mm/madvise.c:1366
 madvise_walk_vmas+0x575/0xaf0 mm/madvise.c:1721
 madvise_do_behavior+0x38e/0x550 mm/madvise.c:1937
 do_madvise+0x1bc/0x270 mm/madvise.c:2030
 __do_sys_madvise mm/madvise.c:2039 [inline]
 __se_sys_madvise mm/madvise.c:2037 [inline]
 __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:2037
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd6b98f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd6c81a038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fdd6bbe5fa0 RCX: 00007fdd6b98f749
RDX: 0000000000000015 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fdd6ba13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdd6bbe6038 R14: 00007fdd6bbe5fa0 R15: 00007ffcd3996008
 </TASK>


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

