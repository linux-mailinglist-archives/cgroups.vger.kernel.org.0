Return-Path: <cgroups+bounces-8602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9ADAE04F0
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2861898891
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E482441A7;
	Thu, 19 Jun 2025 12:02:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3ED242902
	for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334554; cv=none; b=dWO6aB+Y3r3WRqXx/skNdFl68LS6+0K8lDo7KNf/6s+mUr+itffaKRmWkU+tBLQA1+XC1WUYysU4UEazpsf2ncid++i6auc5XWXQed1hy1jKv1M0sTaLcIIZZ8YyogKfiuRphxWHrzY+bo7LJ2Zj90W3WzuSkweiqG6c//rvlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334554; c=relaxed/simple;
	bh=BYKuCV9M64mQhbaDKHTfDnmetVYcpDwkMASwExKUrd8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z4wDx6r9GAc4PBbtUtQzSee32fTdKQij6Vbo/7tf01dbBWmo276Hel9AWAOkHYXLZw2T+/J40k/jJRYXjFUf/nP2lECswjk/0tLOmlwJxoqfOOMFDvyXnesRBW27ExdLXtjtVY/y6B5RSkrPZH/uo90YYks0odVYt7CYsNs104Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86f4f032308so138955839f.1
        for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 05:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334552; x=1750939352;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7y5j2JBAlW/36clXSZNKqoUukF2n112h8sNTaQ5TG7E=;
        b=HpMKZ6FEzK8tyKTWEHbD1lu7wr9oFz2FfYzekwTE00WHgtsQXzBHyzwV7iNpLc0UNP
         o9WlvaV1b1l3/rhLnM1cPw0HYgQQOqt3XmtrX/b57Gg8DCXd0VWTuC5YDh6VJpLLRTNg
         2pRGJnAV9rg1Jp4QIZr+DAEs7sxjMllZeR+fe4ZB5mUvIQ9IA07qVwRWtDgH5qEiglCI
         quuoV38Pcg+Rz8K7jtQgOIS6eRe+c0IKRtjQ03wdCuJDWke2Td8iFvmmMDcUHLDNXJcl
         laTaCdLSxo3gIRuO0ts2H3VrhAFU5z8/L9uagdwROyPPfG6KgCbpVNZuQH+beXjuewmV
         Dvhw==
X-Forwarded-Encrypted: i=1; AJvYcCXF/imTRmRxBbmUijvgnM0TJlFZY5D5WK3HNQ2PyXRmc4K/Kb2sGfaqIrhIDBFb3oOS4WcI94J5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5oUglQ9+dq+RKruQ/oG5J1Jn7a1+nQUifEhmMRf4RSdWIfZK
	EWIymoXDHhsSjbo6rHNjo/Tsl02F6MNpAXX2WqYPD8+mVax7U/xQzUErlAAc/csL5zg6geguqDq
	F120r4xe66h4pCumXpGbkifgIBQH9sjZPpHoHgVZLVPC0k8/lCcEVJNbfy6w=
X-Google-Smtp-Source: AGHT+IGSqDCI6Q2927k9VKmm8G21vKiI1k9bL2sKeMEI0T3+Q+VZYcl5TxH7DPSpl8qNfvFEuXpZsGwC4UMFhj3ojY4Nq9Kfc0ZY
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2482:b0:3dc:79e5:e6a8 with SMTP id
 e9e14a558f8ab-3de07ccd64amr273170815ab.15.1750334551928; Thu, 19 Jun 2025
 05:02:31 -0700 (PDT)
Date: Thu, 19 Jun 2025 05:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853fc57.a00a0220.137b3.0009.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in folio_lruvec_lock
From: syzbot <syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc6e0ba6c9ba Add linux-next specific files for 20250613
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1126090c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f7a2e4d17ed458f
dashboard link: https://syzkaller.appspot.com/bug?extid=a74a028d848147bc5931
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2430bb0465cc/disk-bc6e0ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/436a39deef0a/vmlinux-bc6e0ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e314ca5b1eb3/bzImage-bc6e0ba6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com

 handle_mm_fault+0x740/0x8e0 mm/memory.c:6397
 faultin_page mm/gup.c:1186 [inline]
 __get_user_pages+0x1aef/0x30b0 mm/gup.c:1488
 populate_vma_page_range+0x29f/0x3a0 mm/gup.c:1922
 __mm_populate+0x24c/0x380 mm/gup.c:2025
 mm_populate include/linux/mm.h:3354 [inline]
 vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
 ksys_mmap_pgoff+0x587/0x760 mm/mmap.c:607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing
------------[ cut here ]------------
WARNING: CPU: 0 PID: 38 at ./include/linux/memcontrol.h:732 folio_lruvec include/linux/memcontrol.h:732 [inline]
WARNING: CPU: 0 PID: 38 at ./include/linux/memcontrol.h:732 folio_lruvec_lock+0x150/0x1a0 mm/memcontrol.c:1211
Modules linked in:
CPU: 0 UID: 0 PID: 38 Comm: ksmd Not tainted 6.16.0-rc1-next-20250613-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:folio_lruvec include/linux/memcontrol.h:732 [inline]
RIP: 0010:folio_lruvec_lock+0x150/0x1a0 mm/memcontrol.c:1211
Code: 7c 25 00 00 74 08 4c 89 ff e8 7c 66 f8 ff 4d 89 2f eb c4 48 89 df 48 c7 c6 60 4f 98 8b e8 58 9b dc ff c6 05 01 85 5f 0d 01 90 <0f> 0b 90 e9 d5 fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 4d
RSP: 0018:ffffc90000ae7660 EFLAGS: 00010046
RAX: b21d845e3554e000 RBX: ffffea0002108000 RCX: b21d845e3554e000
RDX: 0000000000000002 RSI: ffffffff8db792e4 RDI: ffff88801de83c00
RBP: ffffea0002108000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa14 R12: ffffea0002108000
R13: ffffea0002108008 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125c41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f475c15ef98 CR3: 000000005f95a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_unmapped_folio+0x42e/0x2cb0 mm/huge_memory.c:3487
 __folio_split+0xf78/0x1300 mm/huge_memory.c:3891
 cmp_and_merge_page mm/ksm.c:2358 [inline]
 ksm_do_scan+0x499b/0x6530 mm/ksm.c:2665
 ksm_scan_thread+0x10b/0x4b0 mm/ksm.c:2687
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

