Return-Path: <cgroups+bounces-5784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508C9E9201
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975AF1881D6A
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693C218820;
	Mon,  9 Dec 2024 11:20:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D3218597
	for <cgroups@vger.kernel.org>; Mon,  9 Dec 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743222; cv=none; b=MBH5eWeXFqeWZy73qseH2WewJGy+65uWBiZ6hVRUm7P/0xauCLNaD2mFDz/rwxvT02ErSEz1u6XrBDlMajluBVvddg9F32NyoXo4tZsdS1cFKmhOSzWMRy2IpjbW7kAV/LpFdvcJLGmQfJTQ0nRosiWdGrlUf1JguTIo1SAtsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743222; c=relaxed/simple;
	bh=zS6eQlvu6POYh106NznQN1z38cHhi49hUjktKNh5TWM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lvK2oMfXsJdpri/O47HkLKdMS0Hm5lIqBqCvfVfJ7bHFcIRXQoN6LM3TzGVy9uiRAI49VkXPx5fCQ+LfAZpaNH0bMzT1+h79wlkfSWAW17npRnjhmp04ERx1H9/TQu7aOAQLX4618udznqRYPmgTAboWmXLXrDYXy9vm41QvVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so783925939f.3
        for <cgroups@vger.kernel.org>; Mon, 09 Dec 2024 03:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743220; x=1734348020;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6tHxk/lkXQjrFAbnpG2zrsTprcmq/H1iKz8IcZ7hO4=;
        b=notb1jx+nAsY5A71BM4I6O3Ki7j1Uh67jWoBFbr4oilrBHoDMC65p68bKHkm72m52v
         0x0tdR8c7sMOC4MlWYYiT8Ru6kU94j9GePDqXVizhTVXY3XWUlIuzjus+x9Xao6KZ6LC
         mf0notwk5bhUkJ+R57bd7TBQbah3VxcL8IWyyTdkdsc7wNUYfizw6AAh4Yx78pcwKMtS
         Q47dwEgolFa+tbIzomL1qIuC/NXReAjNIYtflZ6s9cCLagFAvAUWRWBBTKl8i4rcFwAp
         D+C6mKSpbDxfmlSbLInfHbrljzTOuX0gugEK4xGbmwvxEZ4Fc4g4s0xAodeSVtaG5t0u
         irIg==
X-Forwarded-Encrypted: i=1; AJvYcCViu3kx3hHjfetZYwTV2DsM6iKKUgAKnscIJW6ZqSvWEKwRab5/qQiiLH52F7s6j3Sd3u6Zg6gS@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+QDUmUHnJbX4Ap06eem3ZHsPCUz3KQEvcca2i7IZgXX0sN9j
	U2A8+dgXtzCGJ73nP1JRB3eedVrzNEcbq93b2RJr9ayB1iQEhnJ9yvnXS6fahkGSaKvraAaOquK
	3gOTu2CbGGa4HU3D1N78QFsrkP40x4nhBVT1i4G1WD4VqreJCRtKyi6o=
X-Google-Smtp-Source: AGHT+IGGONomxVVNylsUaJOOJ21mYYAMOrhrYz2DbbnAF9e/2pOW7o9cheSh7sFgmDiA865x+Wh93NztehNoWf6nZ24gQ2dnvedi
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3707:b0:3a7:9670:7abb with SMTP id
 e9e14a558f8ab-3a811e073a4mr132071805ab.15.1733743220157; Mon, 09 Dec 2024
 03:20:20 -0800 (PST)
Date: Mon, 09 Dec 2024 03:20:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d274.050a0220.2477f.003e.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] BUG: unable to handle kernel paging request
 in memcg_rstat_updated
From: syzbot <syzbot+c62387c3885ca12e1255@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17642de8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bc44a6de1ceb5d6
dashboard link: https://syzkaller.appspot.com/bug?extid=c62387c3885ca12e1255
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d4a0162c7c3/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8c47a4be472/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e173b91f83e/Image-7b1d1d4c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c62387c3885ca12e1255@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address f2c1800000000000
KASAN: maybe wild-memory-access in range [0x9610000000000000-0x9610000000000007]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[f2c1800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 8456 Comm: syz.4.287 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : memcg_rstat_updated+0xe4/0x288 mm/memcontrol.c:575
lr : memcg_rstat_updated+0x7c/0x288 mm/memcontrol.c:573
sp : ffff80009c567900
x29: ffff80009c567900 x28: 12c2000000000000 x27: ffff80008f8cd000
x26: 00000000000006d8 x25: 1ffff00011f19abd x24: 0000000000000001
x23: dfff800000000000 x22: fffffdffbf72c000 x21: 0000000000000001
x20: 9610000000000000 x19: 0000000000000001 x18: ffff0000f46d2240
x17: 0000000000000000 x16: ffff800083161638 x15: 0000000000000001
x14: 1fffe000366c41c1 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000080000 x10: 0000000000ff0100 x9 : 0000000000000003
x8 : 0000000000000000 x7 : ffff80008051ba0c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008036f2b8
x2 : 0000000000000001 x1 : 0000000000000080 x0 : 0000000000000000
Call trace:
 memcg_rstat_updated+0xe4/0x288 mm/memcontrol.c:575 (P)
 memcg_rstat_updated+0x7c/0x288 mm/memcontrol.c:573 (L)
 __mod_memcg_lruvec_state+0x370/0x57c mm/memcontrol.c:746
 __mod_objcg_mlstate+0x160/0x23c mm/memcontrol.c:2405
 drain_obj_stock+0x178/0x350 mm/memcontrol.c:2811
 refill_obj_stock+0xe8/0x2d8 mm/memcontrol.c:2860
 obj_cgroup_charge+0x17c/0x238 mm/memcontrol.c:2920
 __memcg_slab_post_alloc_hook+0x238/0x7fc mm/memcontrol.c:2979
 memcg_slab_post_alloc_hook mm/slub.c:2156 [inline]
 slab_post_alloc_hook mm/slub.c:4095 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x368/0x4dc mm/slub.c:4270
 __kvmalloc_node_noprof+0x88/0x24c mm/util.c:658
 groups_alloc kernel/groups.c:18 [inline]
 __do_sys_setgroups kernel/groups.c:208 [inline]
 __se_sys_setgroups kernel/groups.c:198 [inline]
 __arm64_sys_setgroups+0x130/0x5a0 kernel/groups.c:198
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: b4000c14 d343fe9c 12000a89 11000d29 (38f76b88) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b4000c14 	cbz	x20, 0x180
   4:	d343fe9c 	lsr	x28, x20, #3
   8:	12000a89 	and	w9, w20, #0x7
   c:	11000d29 	add	w9, w9, #0x3
* 10:	38f76b88 	ldrsb	w8, [x28, x23] <-- trapping instruction


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

