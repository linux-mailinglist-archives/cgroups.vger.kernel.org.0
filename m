Return-Path: <cgroups+bounces-13737-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePMpH9qYhWmUDwQAu9opvQ
	(envelope-from <cgroups+bounces-13737-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:31:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8999FAFFA
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB462301F781
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808A30FF2A;
	Fri,  6 Feb 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="th1huW93"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F8030FC0B
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363093; cv=pass; b=V4NgFGGUeoqcQXqIiOcJipIX7dDwk7DyAVGbXbAovrMqZs7IT5bDRdl2vh3QE9w3N7agwPToKpt1O63Yw1RDJ9nAG2xTYfNtplwpMCV2O//PclU5g8VEFkN3stqFxI96nOO1pjNuGb5BtMgWl4sx9jH12El5hYF5eS2Y970DBFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363093; c=relaxed/simple;
	bh=x+/AQzQNeZo2Pba9Q/fJa0ixPMtFp1VSkqSeJExC+yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyjdQ959LO2387ZJh0mlteRWwuUAcYj5wPWh2MtJYY5wnhPGr30pTZLw7h2aKrGAwapF5GZ/KJ3mVhGCLRKlF1UPYMphKd0DMfyJeVlr1gzBlGQzo/Oa1C4mCMzAYXzUtfTMjef7RjSrdHOY9RPagjWB8YIqmRDHQQiWuOVjFV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=th1huW93; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso2227342e87.0
        for <cgroups@vger.kernel.org>; Thu, 05 Feb 2026 23:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770363091; cv=none;
        d=google.com; s=arc-20240605;
        b=F3pP9Wu7orA3yi1bKUiLrQ9/kTIIdVxa7aQ5flrkeeQPJcL/JAnnwUueOJuYtlhewr
         FUReevZ8mBAXQv6VaokG49ZBGGNqyRnbwKnOaJPJvdZM3pStWLijVrfXifDdpoD/Q7Ax
         YV0jVa42Le2xz9uVoJDpsA0fTqnoo7ZMyZt7JBW/zDSq+Wj9gCnSCGMD3GsBZDQPdAjB
         N83UyHnRFcboULalNsfZ72EUpnLh9TDZcOh+JFEOUPX1KExeQzZYpTid52gkWalu7pb8
         nHBlhABaO3ZUwimTWwUN50eOGb6gAfzW1naB9nbRcPK9vK5rzvGnAPzFMPgkNsxSGXR2
         V76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AzhRNn4TRcoUApoouAvvxIqUSyjUpCRjRf8yuPMUqoA=;
        fh=+cstFSLsEJlsx+nEbb399mAw5ZCqOWQ1ev9eGPAmrgw=;
        b=HWOJi/VtmuvFjGk+odvfxnmXzp+g7fmtT3NeQ4NexnA5eHVnH3YODgPcHiXdwwTj2y
         QeJeVVWQpEDiVdJMwEJJbgBd+7z3UsoQ8BTeMtiUkPpJykD9tfSaqpbqIOIJreQFX7Xq
         rck4fsRpRqfqQ7jfjSHrJ3VfneEszV7jKhCs/dX5g5WD59/eoXjZqStnxs2CG81Fahf4
         /dPmXrRThIerJMkLI+BPfwgz2yH7ejq4wNMklXwMthsxgvcWOlr8ooJdcyUpmCPKno6U
         xg5zaGMQJRIBM/oUmOD93XrPGqFx6ea0DfXmcYE9rgTy24xJvJi7/O/JuBaYFswwk/Lo
         H8hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770363091; x=1770967891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AzhRNn4TRcoUApoouAvvxIqUSyjUpCRjRf8yuPMUqoA=;
        b=th1huW93ZhDoUUU0ZVTzM3zQMmMngU+Jh8V/Mmi3Jc502wKjeCY0Knki+8kHsE41Dt
         NsBAw3nYnRAXIMn5pZVyZueYV30tNkiK4NFaniyIL8YUXspNNI4nYu2cyb5jjjLurASN
         yGAv5Hu7Q/oq24tnwf9GJN/BOjg6XPR1ORDgEc1GtBq1/og54OgxugPDueatob5KKQfj
         J0l1+Hc2yWUBG27lUyUBubfdwrrq3eOzl+x3ZvktIwJi2tAQQP0Hvtk7RKeojyqx/rVm
         jjPyYL1O6U8O92sSluiQENI85t+7jtmwWTt1n+jZN3oZ0r0ueWi3Rg5ib4zZE9VLgdlp
         oFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363091; x=1770967891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzhRNn4TRcoUApoouAvvxIqUSyjUpCRjRf8yuPMUqoA=;
        b=bkS34zBRL0Su+8Fc9RGkuCml8jIFw6w+WvDhytElqqikQ0rIpGVj0IvTjNqPoMA4qd
         m9tNU03jmCDzgPnG8ULAjoQeA93uRUXLXD6HptGa0ByhWzLF/86vOqo0FK6MD1DBUCnH
         Nne1gmoHrEx67nj59Aa2ikQREGhI65rxxScLyI996Yswr2M7uG6wMTE6pkvfWuc8bgmS
         B7XSwc54474jvGDb4YZNWfZ8g8HjzgRBBzRuh2X3DPSi6czMXo3DoenutK4ipUvKcUBo
         Trd7V4qKoiNivDu8X7EIlay4BzdII5Cb5xdtPQPdpq3i9kmhrOHheXiaz9sXT7VhzqpQ
         RNyg==
X-Forwarded-Encrypted: i=1; AJvYcCW+96pVqApTT1ZRcgK2uIGjp4FfpH0YIEZqblSl++BZ6otG/mnPY92PakEcknRJixdw0kPprGIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb50/bll0J3b+lz7E+XsoeWnj+6mLIfAYeNjKSFEr/Z8IzTDf0
	Ft91b8iuhVQnAO7vGkMco4IPGdEfoVPnYo+8IhP7L3mJrli7P6ULK3FrE2zSPSE0DYItmsRYvF/
	foZb3pzoHd6vzNrUCk9G0bWTtzr3M6NL89HijNWLe
X-Gm-Gg: AZuq6aJ7lkJFwdCsqO9an/DR2Z/No0e0O6ileRL/KjF8Dac3vdTn3S7wCFZPyZAXpxq
	0+3s71bEOHqushYwsQBSxeaNADYwg29UiT4r+00HxUQuRmPy0VhUrM1aPMtKkqvzU4H94zmvSQI
	UV8tZ5p41QVA0pb6y0XVjPRYUupHs/CcrDK7hz1/dtzofkrbDRY2ZX+mA/m7tMmDgGxZ9obR0rO
	o1VETJnvhGYgjnabENL0eO2urMi7JIke7wXEurtbkvO6rfrgA28Qp3SBcR672+hPS5rwa/Nifll
	SpUqpOOPYBoi7fsEbtTfb83qMxNcbQS2sMVrVS4=
X-Received: by 2002:ac2:51c3:0:b0:59d:d1f0:a76a with SMTP id
 2adb3069b0e04-59e450440f3mr515122e87.7.1770363090363; Thu, 05 Feb 2026
 23:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69859728.050a0220.3b3015.0033.GAE@google.com>
In-Reply-To: <69859728.050a0220.3b3015.0033.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 08:31:19 +0100
X-Gm-Features: AZwV_QhOFdnB0m5Ad97mbhbaY-W6xpdlp3ux9BAVJiSy8vSV-fBjGk_XoVNPMww
Message-ID: <CACT4Y+bd+PcL=XzkehM-bmsfAB95UA2y9jr5JY2ov8zVOp1DWA@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] KASAN: wild-memory-access Read in
 lookup_swap_cgroup_id (2)
To: syzbot <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13737-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups,e12bd9ca48157add237a];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E8999FAFFA
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 08:24, syzbot
<syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    18f7fcd5e69a Linux 6.19-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1428fc5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
> dashboard link: https://syzkaller.appspot.com/bug?extid=e12bd9ca48157add237a
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2c19d9acc149/disk-18f7fcd5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/02cf07c94e58/vmlinux-18f7fcd5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84011cec9819/bzImage-18f7fcd5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: wild-memory-access in __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
> BUG: KASAN: wild-memory-access in lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
> Read of size 4 at addr 0007fffffffffffc by task syz.5.3598/20029
>
> CPU: 1 UID: 0 PID: 20029 Comm: syz.5.3598 Tainted: G             L      syzkaller #0 PREEMPT(full)
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:186 [inline]
>  kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>  __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
>  lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
>  swap_pte_batch+0x3c3/0x720 mm/internal.h:390
>  zap_nonpresent_ptes mm/memory.c:1749 [inline]
>  do_zap_pte_range mm/memory.c:1818 [inline]
>  zap_pte_range mm/memory.c:1858 [inline]
>  zap_pmd_range mm/memory.c:1950 [inline]
>  zap_pud_range mm/memory.c:1978 [inline]
>  zap_p4d_range mm/memory.c:1999 [inline]
>  unmap_page_range+0x1f6f/0x43e0 mm/memory.c:2020
>  unmap_single_vma+0x153/0x240 mm/memory.c:2062
>  unmap_vmas+0x218/0x470 mm/memory.c:2104
>  exit_mmap+0x181/0xae0 mm/mmap.c:1277
>  __mmput+0x12a/0x410 kernel/fork.c:1173
>  mmput+0x67/0x80 kernel/fork.c:1196
>  exit_mm kernel/exit.c:581 [inline]
>  do_exit+0x78a/0x2a30 kernel/exit.c:959
>  do_group_exit+0xd5/0x2a0 kernel/exit.c:1112
>  get_signal+0x1ec7/0x21e0 kernel/signal.c:3034
>  arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
>  exit_to_user_mode_loop+0x86/0x4b0 kernel/entry/common.c:75
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
>  do_syscall_64+0x4fe/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2f8f19aeb9
> Code: Unable to access opcode bytes at 0x7f2f8f19ae8f.
> RSP: 002b:00007f2f900350e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f2f8f416098 RCX: 00007f2f8f19aeb9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2f8f416098
> RBP: 00007f2f8f416090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2f8f416128 R14: 00007ffc0c8cc050 R15: 00007ffc0c8cc138
>  </TASK>
> ==================================================================

This happened before:
https://lore.kernel.org/all/67d04360.050a0220.1939a6.000e.GAE@google.com/T/
and now 2 more times.
All reports look similar: exit_mm -> zap_p4d_range
And all access addresses look the same: top 13 bits are zeros, then
some garbage (0007fffffffffffc).
I am pretty sure it's telling us something, some kind of tricky race,
rather than a previous corruption. Swp entry is somehow invalid?

