Return-Path: <cgroups+bounces-4345-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820E956484
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84132281235
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D715AD9C;
	Mon, 19 Aug 2024 07:22:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F6156F5E
	for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052143; cv=none; b=XISC8utofYEP8W3eal+7tRVrqWpLTYobLyPRP0ZBgIuLZ7pgUSKwG0AVVz/VBnTohJ+NyGOpCNoY4vUWIXExRSrvLvDvSCSBY6WwU4jLVpgtOkHaDpHHGaSMC61ZhfwKTzv5setjfAfcy+d0R97SUJhsrfdmHvv8mtMpkY32srQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052143; c=relaxed/simple;
	bh=2me7zVx2GmjOHQDHLKUDPIzYi47ZhOoRG4hfFeTYoEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UFlNz9R+MYrazM/fLYQjactgRcPx6KVlxyaP9ZcJrb9SB+zLgWZdNZeQVIq79WmL475e9IGMYz4pwkQ8OVYDGqa97LQ1xtImPKCiRWnnAXNtZWfGC6j8MIk4Y9yLW3S8/6gHK0gF5kSdJiGK+yKSMt0IhkSLWuf5Cw52pWldTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c745e31so9999045ab.0
        for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 00:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052141; x=1724656941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykEXTbVIQDRm2luDU1GXtcD9k37uNv5MQnJdGrHB3lA=;
        b=WCMfNK7kM1NRfhcaKGtH1ooczM3+b/N4II6RKnRNpdYCtZ5ERYH+sHvIyzDz/BDnIX
         0SIf3MCqIGvkEUdQxIZRLQHLEFign9nCP3MMzVI1qJXknAxDRoB70rvzqnFpabo42HlX
         hdPK9E7Ufq642kaGugp9uRPCApwHGFEpwpCDxkajM1pFvxPG2uuwQb2nVyPgytB+hdC4
         WfCfvRGuDSrvhNL7NIdAoZiYC0khB3AOdjZSiFivQLVLJSCI73dE+RVvnSjfi6oKm1r5
         6uT67xcMMTk6ni707pHHYvMTN+zAh1H4lQduJCruMBVCSqNDPV1nQbIPgKEF6plYIC9N
         mOlA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+3ioGFT7XYKgapECjUDWHsOe9fN04nebYTHx6fYlOk/wXOMchTrMARWv6OAe451+jUBv//rP1E5WCQSqUeUyp/616Ck6VA==
X-Gm-Message-State: AOJu0Ywgo18TINV9WDMwKhovFdF3ahEb1RF5NFoA5gRuOSflQSUhNmQW
	mF7IvsejPQWBp+hpw8FXVYdIu4zHkKBIV3THrwMJgRmZX9vChWK8qgKm/o7du7s7EpvfhJLQfx/
	zHzixwcot7QQ/NUqLBeHWne4wN1Qg7qjrmW3k/6oVx/6DvvMTHQrHpC4=
X-Google-Smtp-Source: AGHT+IF/TN1/v3MlEnKcn910JEIaodiACsPB2ly1CpnYzbGxi4rD66QCpwKtxEpqVfbtab/KGM1BEn9Y2n0vvXL9A2Wh4v+GMNMB
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:39a:e91e:38e0 with SMTP id
 e9e14a558f8ab-39d26d9c1bamr4857465ab.6.1724052140943; Mon, 19 Aug 2024
 00:22:20 -0700 (PDT)
Date: Mon, 19 Aug 2024 00:22:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f7e4d0620042b96@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in folio_memcg
From: syzbot <syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11be396b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ef4ecf7b6bdc4157bfa4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147469f5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153c5ad5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz

The issue was bisected to:

commit ebadc95608dc3ee87ad4e5dc4f2c665c709bb899
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Wed Aug 14 09:34:15 2024 +0000

    mm: kmem: add lockdep assertion to obj_cgroup_memcg

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170875f5980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148875f5980000
console output: https://syzkaller.appspot.com/x/log.txt?x=108875f5980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
Fixes: ebadc95608dc ("mm: kmem: add lockdep assertion to obj_cgroup_memcg")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5235 at include/linux/memcontrol.h:373 obj_cgroup_memcg include/linux/memcontrol.h:373 [inline]
WARNING: CPU: 1 PID: 5235 at include/linux/memcontrol.h:373 folio_memcg+0x111/0x220 include/linux/memcontrol.h:443
Modules linked in:
CPU: 1 UID: 0 PID: 5235 Comm: syz-executor874 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:obj_cgroup_memcg include/linux/memcontrol.h:373 [inline]
RIP: 0010:folio_memcg+0x111/0x220 include/linux/memcontrol.h:443
Code: 10 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 e2 2f f8 ff 48 8b 1b 48 89 d8 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 eb ce 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 55 ff ff ff
RSP: 0018:ffffc9000361ef40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880276c5000 RCX: 0000000080000000
RDX: 0000000000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c60a8c0
RBP: ffffea0001dc8008 R08: ffffffff9018c5af R09: 1ffffffff20318b5
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: dffffc0000000000
R13: 0000000001000108 R14: ffffea0001dc8000 R15: ffffea0001dc8030
FS:  000055556cc4f380(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000005247a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 split_page_memcg+0x58/0x3f0 mm/memcontrol.c:3083
 vm_area_alloc_pages mm/vmalloc.c:3614 [inline]
 __vmalloc_area_node mm/vmalloc.c:3669 [inline]
 __vmalloc_node_range_noprof+0xa63/0x1400 mm/vmalloc.c:3850
 __kvmalloc_node_noprof+0x142/0x1b0 mm/util.c:681
 nf_tables_newset+0x1743/0x2ea0 net/netfilter/nf_tables_api.c:5282
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x14dc/0x2ad0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x298/0x390 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9c3845d49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe78486ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff9c3845d49
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff9c388f036
R13: 00007ffe78486be0 R14: 00007ffe78486c20 R15: 0000000000000000
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

