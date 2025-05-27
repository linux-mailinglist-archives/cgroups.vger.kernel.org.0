Return-Path: <cgroups+bounces-8355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522CAC5005
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B778A1B6E
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C21274FE4;
	Tue, 27 May 2025 13:37:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67942741AB
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353055; cv=none; b=IV6b8GqQ85FiSs3miptK7IFhyn7RFgRO6Pj2P7g0zbpTeWtJoHrg0nHeYlzuA4E1R3jkC6Cw4BMV80RdlYlrLwS4gua9UkQ+bwwZtRUXDU9UyverYzdgeaVrTGp+o1MJV5gW0Lb2OggO2Cx6B7JmVvkQmund09RnEhYzGcu3PbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353055; c=relaxed/simple;
	bh=lkaAvlqrC2g3iGkCUuii5W10Di5fl/UKXiMCltLNGBI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E+nCawmmJitnCy5BRI/8Yvd8iKOApuOY3iG2kgc/HwLeEzFZ69sJKxSCPkEt74fKqNS+uTcEI9QyWOvtCntkxbYb8lftffGIWPXNn9AyS6UlBOXCv53IZsYVwExIlA7/TKp0dzQIxwQUXN6gzblGzkZnyYJY9u9fiLRFdm5o7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso298788739f.1
        for <cgroups@vger.kernel.org>; Tue, 27 May 2025 06:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353053; x=1748957853;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1py+DZ00oyprkVc+fla+24rh0dRjdu53vtBg26tccdo=;
        b=CR9YtWJvNTazEy+lzDXGfWqcFllMBZjjD3Lk/ZlNpBJ3xTCEnMn2I7vQmZW1grk0Kd
         LJfUo45h/F4h8j9x17K1A06VDNuG7s6ItWdDX2eOEhlVp9NKgT1f5RsQX+Y8Wf5f0PjJ
         UUYr96IBbiv4+PqetPxulQqEkTQgR8OKkZhOFnbyXaaXj47ZjkDn05cMRcTnfZgieF3E
         2unCzCVlGn0khpFFAOwISolo+HHykWcVhG66NjYnUSjYCPLJ6EBOVWcnvFxZ21Y+V85w
         037AbhXIahwOAoy6ZhfjkJtVaEFp8m2DYlvNhtRvM9UGgp9ChafTujs9MSzef0MBzn4w
         aOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKb3KGkdk01YYpaDJy6PskJX4UqoV6+qgIl8rC+KA1Q7mTkuIU7WCctW9PZk2XxFvjf3rk3tym@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcbqb6FejmeM7spUwrGvv9YSUYk6B2mF45jY6pLDINtnolDLe
	kCRiC3DRXgPUeFrBWsb9PbUyIlzYlk9X6KSBG91Zs0TwdW6JuHeu+CF/dEHyLASGidW/6fFbB5d
	V0HK1WOIXy8AvWf1BBvfDYn5x2CnHXaUvJitXRTS20idjG4+vMHkWCobShHY=
X-Google-Smtp-Source: AGHT+IHdbMEwKKnSrAAWp9WJoD6Pkfj9S+jcbGbdg4O4YoCpSQaOks7NJu+irfJruvpaLyymr000eUHQSzT+i9eb+zocGnOyME+j
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4191:b0:867:6c90:4867 with SMTP id
 ca18e2360f4ac-86cbb91658cmr1572338539f.14.1748353052928; Tue, 27 May 2025
 06:37:32 -0700 (PDT)
Date: Tue, 27 May 2025 06:37:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6835c01c.a70a0220.253bc2.00b7.GAE@google.com>
Subject: [syzbot] [mm?] [cgroups?] general protection fault in refill_obj_stock
From: syzbot <syzbot+5dd4e428fa723938e6fd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    914873bc7df9 Merge tag 'x86-build-2025-05-25' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12dcf882580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=231a962e5fdb804b
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd4e428fa723938e6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ecae640d0786/disk-914873bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d451e50efeae/vmlinux-914873bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f7363263e49/bzImage-914873bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5dd4e428fa723938e6fd@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xffff11019a0ac400: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xfff8a80cd0562000-0xfff8a80cd0562007]
CPU: 0 UID: 0 PID: 13104 Comm: dhcpcd Not tainted 6.15.0-syzkaller-01972-g914873bc7df9 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:percpu_ref_get_many include/linux/percpu-refcount.h:205 [inline]
RIP: 0010:percpu_ref_get include/linux/percpu-refcount.h:222 [inline]
RIP: 0010:obj_cgroup_get include/linux/memcontrol.h:760 [inline]
RIP: 0010:replace_stock_objcg mm/memcontrol.c:2772 [inline]
RIP: 0010:refill_obj_stock+0x1e1/0x7d0 mm/memcontrol.c:2950
Code: 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 80 3c 02 00 0f 85 96 05 00 00 49 8b 04 24 a8 03 0f 85 23 03 00 00 <65> 48 ff 00 e8 a6 40 ff ff 49 8d 7c 24 18 be 04 00 00 00 48 89 7c
RSP: 0018:ffffc90002e27928 EFLAGS: 00010046
RAX: ffff888075701400 RBX: ffffffff93a8a0c0 RCX: 0000000028853866
RDX: 1ffff1100d2a5000 RSI: ffffffff8bf4fb80 RDI: ffffffff8dcf8da0
RBP: ffffffff908687e4 R08: 85b13f40d71cc5de R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888069528000
R13: 0000000000000078 R14: ffff8880b84350c0 R15: ffff8880b8435108
FS:  0000000000000000(0000) GS:ffff8881249ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563fcc194660 CR3: 000000004f19d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 obj_cgroup_uncharge mm/memcontrol.c:3013 [inline]
 __memcg_slab_free_hook+0x23d/0x610 mm/memcontrol.c:3100
 memcg_slab_free_hook mm/slub.c:2205 [inline]
 slab_free mm/slub.c:4639 [inline]
 kmem_cache_free+0x37e/0x4d0 mm/slub.c:4744
 anon_vma_chain_free mm/rmap.c:147 [inline]
 unlink_anon_vmas+0x173/0x820 mm/rmap.c:421
 free_pgtables+0x2d4/0x810 mm/memory.c:391
 exit_mmap+0x3fb/0xb90 mm/mmap.c:1295
 __mmput+0x12a/0x410 kernel/fork.c:1381
 mmput+0x62/0x70 kernel/fork.c:1404
 exit_mm kernel/exit.c:595 [inline]
 do_exit+0xa3a/0x2c70 kernel/exit.c:947
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1108
 __do_sys_exit_group kernel/exit.c:1119 [inline]
 __se_sys_exit_group kernel/exit.c:1117 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1117
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad55e056c5
Code: Unable to access opcode bytes at 0x7fad55e0569b.
RSP: 002b:00007ffdf148a868 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fad55e056c5
RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000001
RBP: 00007ffdf148ae78 R08: 0000563fee1c62c0 R09: 0000000000000002
R10: 00000000000000e0 R11: 0000000000000206 R12: 00007ffdf148a8b0
R13: 0000563fee1c7950 R14: 00007ffdf148aaf0 R15: 00007ffdf148a8a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:percpu_ref_get_many include/linux/percpu-refcount.h:205 [inline]
RIP: 0010:percpu_ref_get include/linux/percpu-refcount.h:222 [inline]
RIP: 0010:obj_cgroup_get include/linux/memcontrol.h:760 [inline]
RIP: 0010:replace_stock_objcg mm/memcontrol.c:2772 [inline]
RIP: 0010:refill_obj_stock+0x1e1/0x7d0 mm/memcontrol.c:2950
Code: 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 80 3c 02 00 0f 85 96 05 00 00 49 8b 04 24 a8 03 0f 85 23 03 00 00 <65> 48 ff 00 e8 a6 40 ff ff 49 8d 7c 24 18 be 04 00 00 00 48 89 7c
RSP: 0018:ffffc90002e27928 EFLAGS: 00010046
RAX: ffff888075701400 RBX: ffffffff93a8a0c0 RCX: 0000000028853866
RDX: 1ffff1100d2a5000 RSI: ffffffff8bf4fb80 RDI: ffffffff8dcf8da0
RBP: ffffffff908687e4 R08: 85b13f40d71cc5de R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888069528000
R13: 0000000000000078 R14: ffff8880b84350c0 R15: ffff8880b8435108
FS:  0000000000000000(0000) GS:ffff8881249ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563fcc194660 CR3: 000000004f19d000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df
   c:	4c 89 e2             	mov    %r12,%rdx
   f:	48 c1 ea 03          	shr    $0x3,%rdx
  13:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  17:	0f 85 96 05 00 00    	jne    0x5b3
  1d:	49 8b 04 24          	mov    (%r12),%rax
  21:	a8 03                	test   $0x3,%al
  23:	0f 85 23 03 00 00    	jne    0x34c
* 29:	65 48 ff 00          	incq   %gs:(%rax) <-- trapping instruction
  2d:	e8 a6 40 ff ff       	call   0xffff40d8
  32:	49 8d 7c 24 18       	lea    0x18(%r12),%rdi
  37:	be 04 00 00 00       	mov    $0x4,%esi
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	7c                   	.byte 0x7c


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

