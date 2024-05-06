Return-Path: <cgroups+bounces-2788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95408BCEB1
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 15:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8981F250C8
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445674E37;
	Mon,  6 May 2024 13:03:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0626EB4C
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000611; cv=none; b=N3ms1QIit+601RyKTiESD1nGAhKFBw0KawcMKZ8CgW/nJAIxfp0mJyGMO29HgWUCkJ0Vp22Uv+U6k9snhdWfsL3y+FMHPfJModvGg4CwSVExxhEbCEw+Mx9qmb6D67z5n2CmNJGAEso7XCSgZFAWaf0teIkYH6+HscjzpFlAD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000611; c=relaxed/simple;
	bh=dKuYFNaRtimq+YcZdua1MFHMp125HM570Eh/PMm9fZI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mZKmqAJvuWsUvbkg8soG+FCSC75fawC7SfEE7oi+IuoUdI/i0uVpDKdXdbyYA7imw1vul52/3mIBVLUdk4k13nAr3JSVvseOHcIkUnnvYGYFnEo+Xfi5R0jiMgIRKCuflJt077ngyukkKAFita0+WcyKH5LU5ufQfdNke8LlGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36b2eee85edso24487015ab.0
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 06:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715000609; x=1715605409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayUmUkj75b20a/yrmcxbz71RUMESJKmQvIPlii2GJMo=;
        b=QxIPcWX4dTFTzzHbcyxEMJyUAhb1TuvLyZg0DBvtwueuxr6FDv4Rt7ngdQJMF4daw1
         XyMrnV5Oas0bN+34hNN2WWPMQXSYQCgE+ptTkukNgU3t17r4hMh5aHw0wLSkYWKz7vzi
         AmDddPM3lTUNGO3NIK3gOZeVB6aC4BG3ULt15efYPxXFlVKVZBKfL5J8TXLY/YkfLAVj
         Ukbse8udeCrbAir/dw7rz2Bxmd0nfwep1I5r1T/K3iAoKUk2aW6i3ILiu87nz2IVT1Y3
         12sDb0TvTnjR/4d5ar3SLGuMr+wn5BGCKWONFBgiBtp/2ucH+7j7t7gwxi59WNl8pIYa
         WRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/AxEH9bYb3jduf8Lx7tkvf0ifa35iqcdy6qXV4zSkYMVT56TxTPHm8436gqI5rNcgl7nzwxWQpRJJWbHBQFYzIpqPf5Xfw==
X-Gm-Message-State: AOJu0YxShHw+j6cZUzlQNRA0aG4s3PMziVxipCOLd3izDG5Fy3trzRWZ
	kvdCZcNOytVzqY6T1ZbAQOtzLcMMc5QseKlVdklBCLApQ6eW/t2E94z07x9M030+ZDXd4Rtc6YR
	mwhgdCG/BXFhPlh5L9zIBveDmze12b4dO5TYL4uNMtHXAxXSxoaf0cRs=
X-Google-Smtp-Source: AGHT+IEJpx4m3Yjz4c4OVuLaZqvf6g6pGt47CQiOGyJZisDJ+NOYgZwyTyWK+7nru3Pa0OqjtZhCcGYUHnxOFuyF+ixGTt5xkUdH
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:36b:3c9c:558d with SMTP id
 e4-20020a056e020b2400b0036b3c9c558dmr333411ilu.1.1715000609310; Mon, 06 May
 2024 06:03:29 -0700 (PDT)
Date: Mon, 06 May 2024 06:03:29 -0700
In-Reply-To: <0000000000007545d00615188a03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9d500617c8b23c@google.com>
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
From: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b84edefcad1 Add linux-next specific files for 20240506
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1164931f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d5d1f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16527450980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14/disk-2b84edef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vmlinux-2b84edef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a662/bzImage-2b84edef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com

------------[ cut here ]------------
__mod_memcg_lruvec_state: missing stat item 25
WARNING: CPU: 0 PID: 5091 at mm/memcontrol.c:999 __mod_memcg_lruvec_state+0x18c/0x430 mm/memcontrol.c:999
Modules linked in:
CPU: 0 PID: 5091 Comm: syz-executor374 Not tainted 6.9.0-rc7-next-20240506-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__mod_memcg_lruvec_state+0x18c/0x430 mm/memcontrol.c:999
Code: ad 35 94 0d 00 0f 85 a4 01 00 00 c6 05 a0 35 94 0d 01 90 48 c7 c7 80 53 d7 8b 48 c7 c6 54 27 b8 8d 44 89 fa e8 55 f1 54 ff 90 <0f> 0b 90 90 e9 7c 01 00 00 4c 8d 7c 24 60 4c 89 fb 48 c1 eb 03 42
RSP: 0018:ffffc9000338f1e0 EFLAGS: 00010246
RAX: 38a0635190e19e00 RBX: ffffffff8fad3cb9 RCX: ffff8880221f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000338f2c0 R08: ffffffff815846c2 R09: fffffbfff1c3995c
R10: dffffc0000000000 R11: fffffbfff1c3995c R12: 0000000000000200
R13: dffffc0000000000 R14: 1ffff92000671e40 R15: 0000000000000019
FS:  00005555900be380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061cca0 CR3: 0000000075f1c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mod_lruvec_state mm/memcontrol.c:1055 [inline]
 __lruvec_stat_mod_folio+0x1a4/0x300 mm/memcontrol.c:1075
 __folio_add_file_rmap mm/rmap.c:1444 [inline]
 folio_add_file_rmap_pmd+0x29c/0x700 mm/rmap.c:1485
 do_set_pmd+0x767/0xc40 mm/memory.c:4650
 set_huge_pmd+0x28a/0x710 mm/khugepaged.c:1452
 collapse_pte_mapped_thp+0x5c7/0x10b0 mm/khugepaged.c:1655
 madvise_collapse+0x661/0xcc0 mm/khugepaged.c:2762
 madvise_vma_behavior mm/madvise.c:1094 [inline]
 madvise_walk_vmas mm/madvise.c:1268 [inline]
 do_madvise+0xc5f/0x44d0 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1479
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1421be72a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb7f38b78 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fffb7f38d58 RCX: 00007f1421be72a9
RDX: 0000000000000019 RSI: 0000000000800018 RDI: 0000000020000000
RBP: 00007f1421c5a610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffb7f38d48 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

