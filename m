Return-Path: <cgroups+bounces-8343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B159AC31E6
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 02:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC083BD46A
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B1DDC1;
	Sun, 25 May 2025 00:43:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC978462
	for <cgroups@vger.kernel.org>; Sun, 25 May 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748133812; cv=none; b=rykRK6aVoSbkM8nFmiEUKI+JGfQMHCcqsq4e02165n6rMazrAMSoSF9qBBox76ByLdTqibed4VoTHOknAy9VbFM3iIS4rJxKWpPozw7qmDnjK2k6cYq/UOz3aYA/IPet5G3flIoE5/wptVgSOlA70aYaTfpUbvE1nXLH9tHCwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748133812; c=relaxed/simple;
	bh=su7qm94gAficTMpg8rSWDP3Y4+nKz6pRk9RIjP329yA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J0M94HX+zZrgD9En1/2aUSk/4GXAx0n2sNId/pGKWDSN1/PLaljt9nNJPk+oZSWOcN32Go3zdaSkqVFl43xxhlVUFGvewz+/vIjj9mcKXON/8fNZnZS3c+m7A5/GjGa9fev6MYEBDn4uDDAkQuWF0QAPT0x+FMKg3VDDXnbeQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso122295439f.2
        for <cgroups@vger.kernel.org>; Sat, 24 May 2025 17:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748133810; x=1748738610;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqHOmJFA8m2npjmyEJaevf7yl2IWLjfL6jgyzgqaidk=;
        b=HQeq6srhpAbOh7sSXux1Ycm/5ffbG63TnnfM4h9RtjJy8xRv+JTtyOde8q7qA8wVCL
         aG0OKwByIzTvhAShyrq8LATKqIe9HouBBHTFB3WDksbBvCUvkKoegX8Zwx8QTjCBO8RY
         ueUR3oSanWetWJCZ1NUqM4S+a3Om6W4tAPvor1/2AQcgAIrh2EZ/Ur+UY2LbVReEuEe9
         06TtHU861GnTzhmgcUr/dWIw+oT1N9txiXL9LvIEJHrUlvT7KhJfRvWk5VoNulHmEtC/
         nDVlQEg7wQzfsMri59cexUOczg1CSlWo6g07RKX0Z9i85OrhjeGE/N2RS5bPzgBzbnJ/
         JQHg==
X-Forwarded-Encrypted: i=1; AJvYcCX0RxUDiPwVPp+XqPzzsxenuo4K0NLyGxb8CkitFdJW+QqoFmAI/fdOBT1TNRWZIZ7nCGRyxR8b@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrrEZPEDJLhxsIUL+0xlRM/xx5THXMfeLVrZuF8r0adzVyLum
	lbNvtEcK7AT/WTkm/GcYygP+kxBOpiaFskN0nODzvafiuPHaftlhRZY7cELdvt5SRQgMlcBHoA9
	LmbTj5X3QTzd0EQQeTupA+cYucDGaxk7TrC/v+Z9MgV/4JdlNWdFDBGjZJuU=
X-Google-Smtp-Source: AGHT+IEbIqtk7AHxOIHwCk054aGSUpS0LwyjSCm1XJFLsoqOwLzNpJZBKZd4KKS1gQSsEk1MSUnECsOhenvprvw55AclTe1oxrtk
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4192:b0:85b:538e:1fad with SMTP id
 ca18e2360f4ac-86cbb7f02admr480478539f.6.1748133809751; Sat, 24 May 2025
 17:43:29 -0700 (PDT)
Date: Sat, 24 May 2025 17:43:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683267b1.a70a0220.253bc2.007b.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] BUG: unable to handle kernel paging request
 in percpu_ref_get_many (2)
From: syzbot <syzbot+3109abc43c8fcf15212b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7fa1af5b33e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=155428e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89c13de706fbf07a
dashboard link: https://syzkaller.appspot.com/bug?extid=3109abc43c8fcf15212b
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da97ad659b2c/disk-d7fa1af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/659e123552a8/vmlinux-d7fa1af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ec5dbf4643e/Image-d7fa1af5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3109abc43c8fcf15212b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address fffe8001ffe7cc00
KASAN: maybe wild-memory-access in range [0xfff8000fff3e6000-0xfff8000fff3e6007]
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
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000002079fa000
[fffe8001ffe7cc00] pgd=0000000000000000, p4d=1000000210124003, pud=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6597 Comm: udevd Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __percpu_add_case_64 arch/arm64/include/asm/percpu.h:127 [inline]
pc : percpu_ref_get_many+0xc4/0x1f4 include/linux/percpu-refcount.h:205
lr : rcu_read_lock include/linux/rcupdate.h:842 [inline]
lr : percpu_ref_get_many+0x3c/0x1f4 include/linux/percpu-refcount.h:202
sp : ffff8000a42973a0
x29: ffff8000a42973b0 x28: 0000000000000000 x27: 0000000000000000
x26: dfff800000000000 x25: ffff8000a42974e0 x24: ffff00019c365780
x23: ffff00019c365738 x22: 1fffe000193557a1 x21: dfff800000000000
x20: ffff0000c9aabd08 x19: 0000000000000001 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008adbe9e4 x15: 0000000000000001
x14: 1fffe00019b16b33 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000087fac5b3 x10: 0000000000000003 x9 : ffff80010d0e8000
x8 : fffe8001ffe7cc00 x7 : ffff800080c9fbbc x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : ffff80008b3ebc40 x0 : 0000000000000001
Call trace:
 percpu_ref_get_many+0xc4/0x1f4 include/linux/percpu-refcount.h:205 (P)
 percpu_ref_get include/linux/percpu-refcount.h:222 [inline]
 obj_cgroup_get include/linux/memcontrol.h:760 [inline]
 replace_stock_objcg mm/memcontrol.c:2774 [inline]
 refill_obj_stock+0x150/0x470 mm/memcontrol.c:2952
 obj_cgroup_uncharge mm/memcontrol.c:3015 [inline]
 __memcg_slab_free_hook+0x110/0x228 mm/memcontrol.c:3102
 memcg_slab_free_hook mm/slub.c:2205 [inline]
 slab_free mm/slub.c:4639 [inline]
 kmem_cache_free+0x270/0x550 mm/slub.c:4744
 anon_vma_chain_free mm/rmap.c:147 [inline]
 unlink_anon_vmas+0x224/0x520 mm/rmap.c:421
 free_pgtables+0x200/0x63c mm/memory.c:370
 vms_clear_ptes+0x358/0x45c mm/vma.c:1189
 vms_complete_munmap_vmas+0x1d4/0x7e4 mm/vma.c:1233
 do_vmi_align_munmap+0x2c4/0x310 mm/vma.c:1492
 do_vmi_munmap+0x1dc/0x260 mm/vma.c:1540
 __vm_munmap+0x218/0x390 mm/vma.c:3013
 __do_sys_munmap mm/mmap.c:1084 [inline]
 __se_sys_munmap mm/mmap.c:1081 [inline]
 __arm64_sys_munmap+0x64/0x7c mm/mmap.c:1081
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 11000529 b9000289 d538d089 8b080128 (f833011f) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	11000529 	add	w9, w9, #0x1
   4:	b9000289 	str	w9, [x20]
   8:	d538d089 	mrs	x9, tpidr_el1
   c:	8b080128 	add	x8, x9, x8
* 10:	f833011f 	stadd	x19, [x8] <-- trapping instruction


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

