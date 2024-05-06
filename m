Return-Path: <cgroups+bounces-2791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DCD8BCFC3
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3681C23371
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225E13BC2D;
	Mon,  6 May 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zb5L/61g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA7137C4E
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004721; cv=none; b=Qxr9KInE2VS9bPLEwDmyC/IHbCALBa1j7cK1i1yLTpbE6Mj/OZxD8x3MuAbzwwJCQ6PJThxZhE4FYKENj4A+8j+J3vuOndo+eKu758GJ7bZhpUARDcDJrs6paAXtOUpMOGn9xjMcZ2CanjQ/xk13i82Rcq2pDhTp+Sf0zFGEbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004721; c=relaxed/simple;
	bh=ExBirt0SGaPOPcZMXwwBae4jatYvB1SNqI4HEIpY2LQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iifWvbgrb0WZrhR5zgaOl1G2KlktU8/pNeEdu7Km26jReu56blO8Huvw386UNSt2Iu+UGiUuUyXeS2qQH4E6E0gpkA1b+/iQd5i8KuF36x9GG3/h8nzpDKIvKH7KYdwGWAR1nLdy/JWGQrDelUUkNTMLsAI91mPLgmU2PCZpEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zb5L/61g; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf35636346so1628924a12.3
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715004719; x=1715609519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rybRiGbcuMZ0JyaRfONRcOqvfackBPFbCzYjcQ//jA=;
        b=zb5L/61gsu6CEhCMfX6DUSrrh0inyybFpj4k+LeHBqJ66bXIAth/+Nb0tdaaG8+s8p
         1GQu3LnVVRF7LnLvbfk+TaFdeFNfu9VKlsQLZc7UJtGPo2m+2uDofUyCXznUFR6+bVas
         nBSB7rryPqS4YWDCX8t5ffC163ByVXHOf7tLrmui1c58o/apuoor4NEdPLujc7kFtHa0
         G36p1w3ozfLF0tDWo7sGG7qRoR5QpCgzq6548DqGqGXS4d011eyCvGqgpi8HJGd6OczC
         8YIXP6wGBSVRthH8R4ApduMWK42s6vurXhGmdd+uCom4ribgIYm1ZjzQ17wl2uvO8m4k
         kyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004719; x=1715609519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rybRiGbcuMZ0JyaRfONRcOqvfackBPFbCzYjcQ//jA=;
        b=Zz7sAgmvtvHManxup28bJgITyBD43GufupPfW6sjpNWlfFgZBaAm7XdFP/M0lfStAB
         uswK+n+Qmsc3YVU7Il8gZGCNUEDuGsr88tE+DVwV2z70+X6dSKmj0m7LR2/bXSBMyJvV
         3tFpRwpoPklcpopUvQCD0b0OxiMP3TyzzTMD3LSogx7vwbtaZaN66rVbbIujnbs5Xkfk
         /kIIpHtlqgQwIsdZGZhilXPPe+Z0BEwUcssi8K01BixOH4VcKX2FLY3kHSPzNnBv3t39
         ScDomYx2G++NpeNGnB6qpHa1xoSWfDgsuAUqb6TfuNNiFy4koQy8pAlbUsOEPQTHb4bF
         nQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoPI59nh8y8GaVVakMX84p8FWknUHrKzYOPlxSZi2UopF5tW2B74fmxjVeHPvimRQbjmNRQnx0EeFy8IZouI4PnBguTSQKvA==
X-Gm-Message-State: AOJu0Yz9yH/zvMx9LaskToQUzrDhr9o2+gkOWzbA564hO1U6UQi9lo/P
	n/Knz1j9ONY1zHvBSLSylUQ2Sr5n94Kn8jnoYfUdclBLcqElnr36B8arN2TKplyxva15GNTp0Gb
	DDGZCSegqSiIYEGQVfA==
X-Google-Smtp-Source: AGHT+IFsPyCDxX6XqIyh+dT1bq7RxRgsQ0lBRlV/v+UFcICYKh7V0MGyY7/tPU8xlnByRAKTG4aO+chA/o56dtB5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a02:69b:b0:5f7:9ef9:e6b with SMTP
 id ca27-20020a056a02069b00b005f79ef90e6bmr34670pgb.5.1715004719446; Mon, 06
 May 2024 07:11:59 -0700 (PDT)
Date: Mon, 6 May 2024 14:11:57 +0000
In-Reply-To: <0000000000001b9d500617c8b23c@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000007545d00615188a03@google.com> <0000000000001b9d500617c8b23c@google.com>
Message-ID: <ZjjlLcjHuQoV-7gh@google.com>
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
From: Yosry Ahmed <yosryahmed@google.com>
To: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, yuzhao@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 06, 2024 at 06:03:29AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2b84edefcad1 Add linux-next specific files for 20240506
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1164931f180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
> dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d5d1f180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16527450980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14/disk-2b84edef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vmlinux-2b84edef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a662/bzImage-2b84edef.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> __mod_memcg_lruvec_state: missing stat item 25
> WARNING: CPU: 0 PID: 5091 at mm/memcontrol.c:999 __mod_memcg_lruvec_state+0x18c/0x430 mm/memcontrol.c:999

This doesn't seem to be the same issue as the original one syzbot
reported. It's the same function but a different warning. I am not sure
how to tell syzbot that.

Anyway, this warning is the one newly introduced by Shakeel. It is
firing because NR_SHMEM_PMDMAPPED and/or NR_FILE_PMDMAPPED are being
updated using __lruvec_stat_mod_folio(), which also updates the memcg
stats. However, these stats are not exported per-memcg.

I think the following should fix it.

#syz test

diff --git a/mm/rmap.c b/mm/rmap.c
index 12be4241474ab..d3a26ea4dbae2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1441,7 +1441,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
 	if (nr_pmdmapped)
-		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
+		__mod_node_page_state(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);


> Modules linked in:
> CPU: 0 PID: 5091 Comm: syz-executor374 Not tainted 6.9.0-rc7-next-20240506-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:__mod_memcg_lruvec_state+0x18c/0x430 mm/memcontrol.c:999
> Code: ad 35 94 0d 00 0f 85 a4 01 00 00 c6 05 a0 35 94 0d 01 90 48 c7 c7 80 53 d7 8b 48 c7 c6 54 27 b8 8d 44 89 fa e8 55 f1 54 ff 90 <0f> 0b 90 90 e9 7c 01 00 00 4c 8d 7c 24 60 4c 89 fb 48 c1 eb 03 42
> RSP: 0018:ffffc9000338f1e0 EFLAGS: 00010246
> RAX: 38a0635190e19e00 RBX: ffffffff8fad3cb9 RCX: ffff8880221f0000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000338f2c0 R08: ffffffff815846c2 R09: fffffbfff1c3995c
> R10: dffffc0000000000 R11: fffffbfff1c3995c R12: 0000000000000200
> R13: dffffc0000000000 R14: 1ffff92000671e40 R15: 0000000000000019
> FS:  00005555900be380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000061cca0 CR3: 0000000075f1c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __mod_lruvec_state mm/memcontrol.c:1055 [inline]
>  __lruvec_stat_mod_folio+0x1a4/0x300 mm/memcontrol.c:1075
>  __folio_add_file_rmap mm/rmap.c:1444 [inline]
>  folio_add_file_rmap_pmd+0x29c/0x700 mm/rmap.c:1485
>  do_set_pmd+0x767/0xc40 mm/memory.c:4650
>  set_huge_pmd+0x28a/0x710 mm/khugepaged.c:1452
>  collapse_pte_mapped_thp+0x5c7/0x10b0 mm/khugepaged.c:1655
>  madvise_collapse+0x661/0xcc0 mm/khugepaged.c:2762
>  madvise_vma_behavior mm/madvise.c:1094 [inline]
>  madvise_walk_vmas mm/madvise.c:1268 [inline]
>  do_madvise+0xc5f/0x44d0 mm/madvise.c:1464
>  __do_sys_madvise mm/madvise.c:1481 [inline]
>  __se_sys_madvise mm/madvise.c:1479 [inline]
>  __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1479
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1421be72a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffb7f38b78 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007fffb7f38d58 RCX: 00007f1421be72a9
> RDX: 0000000000000019 RSI: 0000000000800018 RDI: 0000000020000000
> RBP: 00007f1421c5a610 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fffb7f38d48 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

