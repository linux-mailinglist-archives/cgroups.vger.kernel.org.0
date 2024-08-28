Return-Path: <cgroups+bounces-4548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C4963538
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10771F23598
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8411AD3FD;
	Wed, 28 Aug 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EIvF278X";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UZpdHcJ5"
X-Original-To: cgroups@vger.kernel.org
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0F158DCD
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886602; cv=none; b=px5r4cxHzGmQ5pxJAmCL/DAnkV0UYoixUK/GuY7d8fJvBJsEZWwaCcQ0FD2nd7+37JAwZn99/WatWe2913gPOpDHIaKi/Y+cTPiOegIptQL6xTN56PCGDgfDcEKxWPnxcRY+SwTFyuVK4+DnFsOgbaU+g0Li9hiZjmEzGyGuEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886602; c=relaxed/simple;
	bh=xCowhrFNDBwFKLbw1efe3nEMDbDoY7A95IkeYotAsOQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Nh06NAW0AQIvqGKc29gUc93HXbESZRvgVmH61D8CBT1SEBg8gKpqlKFTsaHEP0VHpn7FUosAJMTuJv5UMZ9bvTHIA9Lru6IjMfJ5envRHsWAhMIqhdFSKZ3Szv+aXuDVVnCrp5juvLH90oRuWm6JtD6lalXVI9xsGotpCXLNHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=EIvF278X; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UZpdHcJ5; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724886601; x=1756422601;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=xCowhrFNDBwFKLbw1efe3nEMDbDoY7A95IkeYotAsOQ=;
  b=EIvF278Xr7jLycioqsrw2WaqWiw6A6IwnnqDTvaExBOnQmkr2+wLNnD5
   rxwVQ46WYTbGCpHwyE7MyJJVxHfL/b4kKo+5kx28khwVr+FbEoL/IZ2ND
   5YwE0MuhBbml30smzM/Vf4uGNk/Cypy5PKcplKoQ0+lTOU4ItJztYNKMU
   7gau6Mv/h8c2dbagd6Ee6TG6djuaU1OaUQciISJvDLWAQk2Nwy5Do6T18
   /AJwvRSnO3eJJPq0l+4paPia8LLY67aOuaxZ8SJqhfsqTFTyWjOBOJb/7
   3IWYzLpB9TQCwwPpVjjs6B+4Aaucaky+is5DL/ayVL2EjNoscy7kxR459
   g==;
X-CSE-ConnectionGUID: HtZlh0z+TzeC+xHEaUSGOg==
X-CSE-MsgGUID: olInY41US7GcpgNn1al2mQ==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:10:01 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3c9a5c673so34046a91.1
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724886600; x=1725491400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Qq45i3lF6rQjVvLCprXvQiGAo7T/IQyWfebCNoyFG0=;
        b=UZpdHcJ5kNv7SERZxpdJ8TUDagrJ+ZwVEs2Hsr8xfS/mLlgXVHvOrpHBDoy7FLQiTp
         LZkXahJSZwvAv9sOTl2R74Q4yk1Tuq+fE0/SshDELl05kpKmKh7yJsCiUiWSJO0cVLfn
         psUbJbvtEGafHSaQGR6nLv1fViVytSUSw5s94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886600; x=1725491400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Qq45i3lF6rQjVvLCprXvQiGAo7T/IQyWfebCNoyFG0=;
        b=enNBLp8YVQEMwO0K/j1iobbhYQ5Oq2nCMy+zSkwKo+h+YJlmNowiRcDbLmNV/G89B+
         /WF9kdo4hdai1+SkINfe9lK4176VhAuHjjXQA7KojEMAjpjRy46Z9D3GL5ZhWMcBICOn
         9w8iCPe/1TOyPWH49UtAjhjlf1zTXXx+XD05aeazc1hIsLyqKO/EJUZDKhqQ+/Lm1/jy
         ob612wiuJEliGV7TYWNvOjZ883a3noZoWLjNjEeVT6bqxJtwJkvylTliVfdQ/OFevM6N
         dlsD1OC95GrfInUyAOaz1dhXsZ9mmBfLjM9fCWBN93xYzReIBB+vrq9lzXMbhSJTA4w1
         1OUA==
X-Forwarded-Encrypted: i=1; AJvYcCUYDumS/xZaY+Z8HWAPrELa7c4dejJeSHe0ODZrLBUycD5s81HF2TKalmADKtj1PKLPSAUj6G+v@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMTBjefpdvfrn9EsZBTTWkjWQuDOGzLBs6bg/Hc5lcTzK0kbB
	TMNBIplm9+zEmh8ahyKqqSXC0XCEOco/U2xRnb5ZnqicPY0SqlJOTM+M3t/0FupiqHj7MVgeqbA
	+AxuvszPamjE1ewxvwbddJw6cLMgrNK5p78LqC12t/DBiQZ36YOBcL33iFXyi/ePrWn4MVOmKV0
	vl4Ot2WDZxnqHNk25BKl8CYEg/drsZgaY=
X-Received: by 2002:a17:90b:3685:b0:2d1:ca16:554d with SMTP id 98e67ed59e1d1-2d85617bfd0mr965952a91.4.1724886599625;
        Wed, 28 Aug 2024 16:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUc7nP6xZmRc2Zzo2ImVNf+ihu5N7n2QKpqXqzFRcsQPfqWjTaTKsyqWwr5+p8RCpdng2BLbljt7ZaCBccyBo=
X-Received: by 2002:a17:90b:3685:b0:2d1:ca16:554d with SMTP id
 98e67ed59e1d1-2d85617bfd0mr965932a91.4.1724886599181; Wed, 28 Aug 2024
 16:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:09:49 -0700
Message-ID: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
Subject: BUG: general protection fault in get_mem_cgroup_from_objcg
To: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a  null
pointer dereference bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/315733cb1dc3bc8cbe055b457c1918c0

The bug report is:

Syzkaller hit 'general protection fault in get_mem_cgroup_from_objcg' bug.

Oops: general protection fault, probably for non-canonical address
0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 PID: 8129 Comm: syz-executor347 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:css_tryget include/linux/cgroup_refcnt.h:44 [inline]
RIP: 0010:get_mem_cgroup_from_objcg+0xb1/0x150 include/linux/memcontrol.h:536
Code: 49 83 c4 10 4c 89 e5 48 c1 ed 03 42 80 7c 2d 00 00 74 08 4c 89
e7 e8 3e 3e f8 ff 4d 8b 3c 24 49 8d 5f 54 48 89 d8 48 c1 e8 03 <42> 0f
b6 04 28 84 c0 75 14 f6 03 01 75 25 49 8d 7f 10 e8 a8 ac 00
RSP: 0018:ffffc9000abb74e8 EFLAGS: 00010207
RAX: 000000000000000a RBX: 0000000000000054 RCX: ffff888014bd5a00
RDX: 0000000000000000 RSI: ffffffff8ba956c0 RDI: ffffffff8ba95680
RBP: 1ffff110057e4c72 R08: dffffc0000000000 R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: ffff88802bf26390
R13: dffffc0000000000 R14: ffffffff81fc1db9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5504f14000 CR3: 000000001e6f2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 obj_cgroup_uncharge_pages mm/memcontrol.c:3392 [inline]
 refill_obj_stock+0x41e/0x6b0 mm/memcontrol.c:3665
 obj_cgroup_uncharge mm/memcontrol.c:3714 [inline]
 __memcg_slab_free_hook+0x1db/0x310 mm/memcontrol.c:3801
 memcg_slab_free_hook mm/slub.c:2130 [inline]
 slab_free mm/slub.c:4435 [inline]
 kmem_cache_free+0x194/0x280 mm/slub.c:4513
 anon_vma_chain_free mm/rmap.c:147 [inline]
 unlink_anon_vmas+0x58b/0x5e0 mm/rmap.c:447
 free_pgtables+0x215/0xbb0 mm/memory.c:386
 exit_mmap+0x435/0xa20 mm/mmap.c:3352
 __mmput+0x114/0x3b0 kernel/fork.c:1346
 exit_mm+0x207/0x2e0 kernel/exit.c:567
 do_exit+0x996/0x2560 kernel/exit.c:863
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f3ec1159bed
Code: Unable to access opcode bytes at 0x7f3ec1159bc3.
RSP: 002b:00007fff23d68ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 00007f3ec1159bed
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 002367732f766564 R09: 00007fff23d68c30
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff23d68bf0 R14: 0000000000000000 R15: 00007fff23d68c30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:css_tryget include/linux/cgroup_refcnt.h:44 [inline]
RIP: 0010:get_mem_cgroup_from_objcg+0xb1/0x150 include/linux/memcontrol.h:536
Code: 49 83 c4 10 4c 89 e5 48 c1 ed 03 42 80 7c 2d 00 00 74 08 4c 89
e7 e8 3e 3e f8 ff 4d 8b 3c 24 49 8d 5f 54 48 89 d8 48 c1 e8 03 <42> 0f
b6 04 28 84 c0 75 14 f6 03 01 75 25 49 8d 7f 10 e8 a8 ac 00
RSP: 0018:ffffc9000abb74e8 EFLAGS: 00010207
RAX: 000000000000000a RBX: 0000000000000054 RCX: ffff888014bd5a00
RDX: 0000000000000000 RSI: ffffffff8ba956c0 RDI: ffffffff8ba95680
RBP: 1ffff110057e4c72 R08: dffffc0000000000 R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: ffff88802bf26390
R13: dffffc0000000000 R14: ffffffff81fc1db9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5504f14000 CR3: 000000001a258000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 49 83 c4 10           add    $0x10,%r12
   4: 4c 89 e5             mov    %r12,%rbp
   7: 48 c1 ed 03           shr    $0x3,%rbp
   b: 42 80 7c 2d 00 00     cmpb   $0x0,0x0(%rbp,%r13,1)
  11: 74 08                 je     0x1b
  13: 4c 89 e7             mov    %r12,%rdi
  16: e8 3e 3e f8 ff       call   0xfff83e59
  1b: 4d 8b 3c 24           mov    (%r12),%r15
  1f: 49 8d 5f 54           lea    0x54(%r15),%rbx
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 0f b6 04 28       movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f: 84 c0                 test   %al,%al
  31: 75 14                 jne    0x47
  33: f6 03 01             testb  $0x1,(%rbx)
  36: 75 25                 jne    0x5d
  38: 49 8d 7f 10           lea    0x10(%r15),%rdi
  3c: e8                   .byte 0xe8
  3d: a8 ac                 test   $0xac,%al




-- 
Yours sincerely,
Xingyu

