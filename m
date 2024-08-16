Return-Path: <cgroups+bounces-4319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004A954155
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 07:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831BA1F237FE
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC23757E0;
	Fri, 16 Aug 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9j7ZHwU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE82837B;
	Fri, 16 Aug 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787334; cv=none; b=Ff1uhjQUmmgGdfhK5m7BtdxdLgcLp++zuVQDGLWgNTzsIXQNMa6QDy1S0K08LB+7SPHZSBGOVc44MXG//1zcvTyU7k3UQFZXBBQQ7bBErVYeT3MZJ0uIVahnzV2fAXOQz2YSgeOdcYtV/SZjPPpCejsjzUC0fF+x9xqNwLpuGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787334; c=relaxed/simple;
	bh=JPfg4Xd+P4+mCh+fOYqY0gSeE0W/MpGyb5IlESfAElc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2J4i+7Zzek/vNatCv+iG2Q2VXyShfNi2VKDdQ70DbLpdjnjiDK98hKqc6oBlgIVFZ7228Atl/UgVqO976UjVdyyzMZDbv5DIBcZ+stHIGla21iw0b8EP8RLH/XzWmVlQo/Uu8p+BhkfUNj2UfEcDGL/9YWhckwikiZLUH8mA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9j7ZHwU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-492aae5fde6so603042137.1;
        Thu, 15 Aug 2024 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723787331; x=1724392131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsITD29GQKKzt+brx0HtKi3cyWy83WQoQtDAWl5bz7A=;
        b=m9j7ZHwUvct10YwGCAGK17qUZTcKZ3kvtanttkm5WVMm+QMWFFk/wOMzy7B9qNgZME
         VXXn6y91UBkf0xssYYq8ATkOHQxJ+KsMdYy99vqoKEgeu4csfQwj5znq/hnwdewh3ibJ
         /zDSm3xDjPILyIMQ5I3doWOFLhAAPWZhKRIQ9/MeWPfY+lPrJdzXoXVvARQ4LTvpQzGR
         ekLeKIGgM5HIbphgi8kf4bu5j18DYXGKswiAFK4wWB6zYynWPYPYLgVmgnK4T+C7xhnX
         N0fuEqnN5a6kXsaZJXPJn3d0iQbpNqS3/cvplNKufgb3ROEa3ghgstb+79ev4t3K3kik
         /1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723787331; x=1724392131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsITD29GQKKzt+brx0HtKi3cyWy83WQoQtDAWl5bz7A=;
        b=PfW6GF0QGjyOWzWdTBtFUtQXpg4xullP2uyzyDznHtSS+ojlgvNPa7TFY+F8EPtkc9
         lIGxcp0+yvvXPwp05cayRzmts7eB7bUZIxUddWTkKOYurEdUeD7++pVG+rfZBiQN/kCw
         SG6vdMe0zUI1D6CmZKjK7vOBFhoEqz8WEIV3b9KHGzczqi9PbB8bPOco26e/5hhW3Z7z
         RLI12q/m8a6p3HkUk67cAa34CivR8AdVpCOs/vxkUmjOUkD1r/jkWW7zcyc7wqiCDZmn
         H/dew5MvKIl5PuIXBSvc76qd3MT30V1MEiU+ynyimgSv0QAydZdJMuwK/wPo+i53IwmI
         HgHg==
X-Forwarded-Encrypted: i=1; AJvYcCX9XBYv2XNcbt/Fvrv4nqRnrotGGKFe27okmwInQ+oaatcljTlKScx7GoruIxBoj7TlDSu8aP1w6CAGzJLpGr1uV8jtopBH3NPGQ4RxIQp9VjpsrBAcGlPasrwb/S1kXjPhQuPjXg==
X-Gm-Message-State: AOJu0Yxqa8Vy7kgVCenjODODckCGv5jhQSYnGtdYtkZ8khX3wzc/vHhi
	AOyCBcv7T7nUYMp2nm4JkpGFTJ896j4qCpp7Okg1J+lJSy7thfGV/3FIVJAeRiJgHutPET9FkRY
	WtWN3ns1zRZBu6gS4F2B996X3TD0=
X-Google-Smtp-Source: AGHT+IF6wnxgprfcq9EOAwtOK7lLNrWrTzMtkbSUOUjpBVOYX8nKGt8Nr46zBC38tsrKs+oAI6t65bNeJ6NMOCI/Lzg=
X-Received: by 2002:a05:6102:cd2:b0:497:70dc:c with SMTP id
 ada2fe7eead31-49779991214mr2249009137.19.1723787331048; Thu, 15 Aug 2024
 22:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005cff41061fc63a83@google.com>
In-Reply-To: <0000000000005cff41061fc63a83@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Aug 2024 13:48:39 +0800
Message-ID: <CAGsJ_4x8O-+foqN7kdYQhaiPMZ=aTj=N8sg4Rsq=ML=Upgh+fw@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] kernel BUG in swap_cgroup_record
To: syzbot <syzbot+4745e725b07d34503a64@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com, 
	v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:28=E2=80=AFPM syzbot
<syzbot+4745e725b07d34503a64@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14c97e8398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee5=
467
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4745e725b07d345=
03a64
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10cf435d980=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/dis=
k-9e686969.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinu=
x-9e686969.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/b=
zImage-9e686969.xz
>
> The issue was bisected to:
>
> commit d65aea610f0a14cda5ec56a154c724584ef7da17
> Author: Barry Song <v-songbaohua@oppo.com>
> Date:   Wed Aug 7 21:58:59 2024 +0000
>
>     mm: attempt to batch free swap entries for zap_pte_range()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1493ea9198=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1693ea9198=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1293ea9198000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+4745e725b07d34503a64@syzkaller.appspotmail.com
> Fixes: d65aea610f0a ("mm: attempt to batch free swap entries for zap_pte_=
range()")
>
> ------------[ cut here ]------------
> kernel BUG at mm/swap_cgroup.c:141!

thanks! this is exactly what Chris and Yosry have reported:

https://lore.kernel.org/all/20240815215308.55233-1-21cnbao@gmail.com/

And this one is queued:
+ mm-attempt-to-batch-free-swap-entries-for-zap_pte_range-fix.patch
added to mm-unstable branch
https://lore.kernel.org/all/20240815221312.94782C32786@smtp.kernel.org/


> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5371 Comm: syz.0.15 Not tainted 6.11.0-rc3-next-202408=
12-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> RIP: 0010:swap_cgroup_record+0x2cd/0x2d0 mm/swap_cgroup.c:141
> Code: e7 e8 a7 c9 f6 ff e9 64 fe ff ff e8 cd 41 8e ff 48 c7 c7 c0 db a5 8=
e 48 89 de e8 2e 8c e8 02 e9 7a fd ff ff e8 b4 41 8e ff 90 <0f> 0b 90 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
> RSP: 0018:ffffc90003e172f8 EFLAGS: 00010093
> RAX: ffffffff82054c9c RBX: 000000000000000b RCX: ffff88802298bc00
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff82054b43 R09: fffff520007c2e3c
> R10: dffffc0000000000 R11: fffff520007c2e3c R12: ffff88801cf0f014
> R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9332107a8c CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __mem_cgroup_uncharge_swap+0x84/0x2e0 mm/memcontrol.c:5118
>  mem_cgroup_uncharge_swap include/linux/swap.h:668 [inline]
>  swap_entry_range_free+0x45f/0x1120 mm/swapfile.c:1556
>  __swap_entries_free mm/swapfile.c:1518 [inline]
>  free_swap_and_cache_nr+0xa65/0xae0 mm/swapfile.c:1876
>  zap_pte_range mm/memory.c:1653 [inline]
>  zap_pmd_range mm/memory.c:1736 [inline]
>  zap_pud_range mm/memory.c:1765 [inline]
>  zap_p4d_range mm/memory.c:1786 [inline]
>  unmap_page_range+0x1924/0x42c0 mm/memory.c:1807
>  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
>  exit_mmap+0x267/0xc20 mm/mmap.c:1923
>  __mmput+0x115/0x390 kernel/fork.c:1347
>  exit_mm+0x220/0x310 kernel/exit.c:571
>  do_exit+0x9b2/0x28e0 kernel/exit.c:926
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>  __do_sys_exit_group kernel/exit.c:1099 [inline]
>  __se_sys_exit_group kernel/exit.c:1097 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9331f779f9
> Code: Unable to access opcode bytes at 0x7f9331f779cf.
> RSP: 002b:00007fff65ce5d18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9331f779f9
> RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: 00007fff65ce5dff R09: 00007f93320d0260
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f93320d0f68
> R13: 00007f93320d0260 R14: 0000000000000003 R15: 00007fff65ce5dc0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:swap_cgroup_record+0x2cd/0x2d0 mm/swap_cgroup.c:141
> Code: e7 e8 a7 c9 f6 ff e9 64 fe ff ff e8 cd 41 8e ff 48 c7 c7 c0 db a5 8=
e 48 89 de e8 2e 8c e8 02 e9 7a fd ff ff e8 b4 41 8e ff 90 <0f> 0b 90 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
> RSP: 0018:ffffc90003e172f8 EFLAGS: 00010093
> RAX: ffffffff82054c9c RBX: 000000000000000b RCX: ffff88802298bc00
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff82054b43 R09: fffff520007c2e3c
> R10: dffffc0000000000 R11: fffff520007c2e3c R12: ffff88801cf0f014
> R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9332107a8c CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

Thanks
Barry

