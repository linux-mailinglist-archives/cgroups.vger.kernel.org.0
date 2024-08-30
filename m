Return-Path: <cgroups+bounces-4644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00049668A8
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 20:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20CD1C23689
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765891BAEE3;
	Fri, 30 Aug 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeJ2XGHT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943D1BAEF6
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041057; cv=none; b=q781SiYW5B/mskXl9JCH3qmjm+Th19xt/2jW80mocHth/v7Varu+CBrXt9zU8LhDxP0sZm0iXmph/j03QsXs3Jadz5vSMeO1d1Nnj1B7uvIOOawqxImxvSHWjrjJy+I75xwrbHrq9BeAmX0mpwnl5SQ02uLQfaSDYaSEd2ca9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041057; c=relaxed/simple;
	bh=EBtYIn/UzgCwtXVUOgQGNeHiEVTEozkl0lHq31mKb/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEUeystRMTZ0oVZGhLD3M9UGDHA+VvjXSNVuZj6RcVLGJbkN7MmUtFEvHpSMHRvnofEmzzV+/AMnxchyxZ0r0ery+6g0tsOKtJrL+eBwwVGRkKSkMp3iAbwKO4Vvp+lx6cRj7b+HYcIrLkUO71pD9T+8z2L2TFBJomhNGv7vskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeJ2XGHT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a868b8bb0feso256234566b.0
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725041054; x=1725645854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMJEJ0mgWPS/u1UL/uZmUQxpZyJybEAjbxvXKENMJBs=;
        b=aeJ2XGHT+CEQVrhaOVyPB49sH80o0x/7bpF0To5qNeMwdK1q2FL2o5/LLSfYSu4Fcq
         pSY+ofwCiu14318RH2uvX62sxyu7IVEIuEAS8YE1uOrCyvDOYqXhYeSrbNLlXTf0TUl2
         Xq5nGa4gOFXbtj74e0Ijl9PefRpNjxkdNM8VsFu3DUKEUInFQaDMo4UAoWjJ3C6bvOQJ
         aFU8D6rYD91Oq2YmD7d0XiYg8FaJQITU9HVbbHGTnVO9f0Cvwb63pgTEgspOQm7znBgv
         CFc7GR6q4d350mGgrh9cROVcQjMyEKFXAnrxFQMrnCY1sMO24RbF4nZ8D9tAwuG6kr56
         Zn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725041054; x=1725645854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMJEJ0mgWPS/u1UL/uZmUQxpZyJybEAjbxvXKENMJBs=;
        b=CycGiAPvuxgdWO8iiakHOsKtdvE4PTjQgHM+DTty18uGpRJKsB/6XIDAQMRo/Dsxdj
         FgjK4W1Q4xMr73HhtE4WIm/g1UhFRNpClNUzFyZ4zz3hkf1RAS+WRk0LhO+Zm2fs4KSn
         d8w0mmnyeXFefDx9YkmaeZzvN7hAiWqu0MwP3X78dyUOBqT4q+hkvC7g7ssi7CWrtPnt
         M7iamnehNIWoRiXc+TIjfEhO3vxrBHcK+iijduTYa2IqDFS0CnJOGhkKJgKCcL9+nsHK
         WyFB75xHKaaZ+zskoCrwrOGB/jNoN9uIJ1rsVJ9FqgR84ncNP7VXMmKUHYOml/jHkpQz
         +QOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx6NtkpQcykZ4S4SLCqDysc1sC/aakInbp9OiGGjWLkv3AnoAOtUv1PnP78kkp68gN/HPMz+bZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjkvzCLGy7PPTojw5kF+sOCe1Mu9HLrfIaGDX97OewxUyOJZ8
	OGFIozSTJ+yva5ZEAgs29tNfR0hG0C6dSTTe60ONczBfe63ANez0/RhCzOkdqartPZn81+21PwB
	MXTTUXN3lJOmlNbv8vUhAV5X5Y5i1WMyckBSB
X-Google-Smtp-Source: AGHT+IFkyiuWYnkDIp71WVsWgP2T1HZJoDhkqxwhm486aWIEW5rmTrY+udAgGqOeeDcK/tb9koL6OWG1lM6HODvxYHI=
X-Received: by 2002:a17:907:980c:b0:a86:8f57:7de0 with SMTP id
 a640c23a62f3a-a89a37aa9famr218363766b.49.1725041053012; Fri, 30 Aug 2024
 11:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000817cf10620e20d33@google.com>
In-Reply-To: <000000000000817cf10620e20d33@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 30 Aug 2024 11:03:35 -0700
Message-ID: <CAJD7tkZDMHqSs9eZZN5Hb34a-Wxcu+HwjOgpqXPiyGk7CA78hw@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter
To: syzbot <syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com>, 
	Kinsey Ho <kinseyho@google.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:05=E2=80=AFAM syzbot
<syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D107a846398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fafac02e339c=
c84
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De099d407346c452=
75ce9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4a8763df1c20/dis=
k-20371ba1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f9678a905383/vmlinu=
x-20371ba1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ef6e49adc393/b=
zImage-20371ba1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter

+Kinsey Ho

This looks relevant to the recent mem_cgroup_iter() changes.

>
> read-write to 0xffff888114b82668 of 4 bytes by task 5527 on cpu 1:
>  mem_cgroup_iter+0x28e/0x380 mm/memcontrol.c:1080
>  shrink_node_memcgs mm/vmscan.c:5924 [inline]
>  shrink_node+0x74a/0x1d40 mm/vmscan.c:5948
>  shrink_zones mm/vmscan.c:6192 [inline]
>  do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
>  try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
>  try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
>  try_charge mm/memcontrol-v1.h:20 [inline]
>  charge_memcg mm/memcontrol.c:4439 [inline]
>  mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
>  __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
>  swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
>  swapin_readahead+0xe4/0x760 mm/swap_state.c:882
>  do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
>  handle_pte_fault mm/memory.c:5524 [inline]
>  __handle_mm_fault mm/memory.c:5664 [inline]
>  handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
>  do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x3b9/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>
> read to 0xffff888114b82668 of 4 bytes by task 5528 on cpu 0:
>  mem_cgroup_iter+0xba/0x380 mm/memcontrol.c:1018
>  shrink_node_memcgs mm/vmscan.c:5869 [inline]
>  shrink_node+0x458/0x1d40 mm/vmscan.c:5948
>  shrink_zones mm/vmscan.c:6192 [inline]
>  do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
>  try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
>  try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
>  try_charge mm/memcontrol-v1.h:20 [inline]
>  charge_memcg mm/memcontrol.c:4439 [inline]
>  mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
>  __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
>  swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
>  swapin_readahead+0xe4/0x760 mm/swap_state.c:882
>  do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
>  handle_pte_fault mm/memory.c:5524 [inline]
>  __handle_mm_fault mm/memory.c:5664 [inline]
>  handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
>  do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>  __get_user_8+0x11/0x20 arch/x86/lib/getuser.S:94
>  fetch_robust_entry kernel/futex/core.c:783 [inline]
>  exit_robust_list+0x31/0x280 kernel/futex/core.c:811
>  futex_cleanup kernel/futex/core.c:1043 [inline]
>  futex_exit_release+0xe3/0x130 kernel/futex/core.c:1144
>  exit_mm_release+0x1a/0x30 kernel/fork.c:1637
>  exit_mm+0x38/0x190 kernel/exit.c:544
>  do_exit+0x55e/0x1720 kernel/exit.c:869
>  do_group_exit+0x102/0x150 kernel/exit.c:1031
>  get_signal+0xf2f/0x1080 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000522 -> 0x00000528
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 5528 Comm: syz.3.488 Not tainted 6.11.0-rc5-syzkaller-=
00176-g20371ba12063 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> syz.3.488 (5528) used greatest stack depth: 9096 bytes left
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
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

