Return-Path: <cgroups+bounces-2310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF52897D4C
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 03:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750171F25A55
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57520525E;
	Thu,  4 Apr 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p0SeqJJv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160C2F37;
	Thu,  4 Apr 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192874; cv=none; b=bUXfd/sO9rD04p1njrJlyfa7DfiutWnQHEyGy+3C/j/TtTaT3mgupUTfOdgT288qi+AW/wCZh8Hnsu++BhtGCRgtuF/jrC1Ec7N0VjT8uaS3c5suLnAQaHvyuyVqxPb0d5+qxtcM5Dr3Tk62+LuHTAiGauoSCY5WtMYAhw1msGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192874; c=relaxed/simple;
	bh=FtaGvZn9DU8zSy564EUnjvqdBkYKe+7qJxI5a/lH6GE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bqQjwKIhvrKRHh4QdMi7xh9feLKGD1IrhVUoi8Ar8nvx6TmmQh9sMGC7dRgj5rCGIBxZPf2M/cHBaW07HaTEvSRt13wGWvVnXg0LyeYG5M9DWMoAgr9P4ZhV75bJNymYvRWZC42EytN+2d8t/H9+JDAM5Bd2PWUxMdllTtY4/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p0SeqJJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B1FC433F1;
	Thu,  4 Apr 2024 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712192873;
	bh=FtaGvZn9DU8zSy564EUnjvqdBkYKe+7qJxI5a/lH6GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0SeqJJv5v7ULZGvarHpc1u8KHj7ZFli8N09Omm2YvQzu7bRwLxryoH9UnRltzubl
	 XvFEtCl7YTXsjpcqwRKp9kqT59CkvQTC6Lu1rNqo+O8VI5K6Y6GJn5gh2y3U+XLqb0
	 8UtnPjuYEc0CVtYAz+h//EWBxcQUS9vqQzHHoy0c=
Date: Wed, 3 Apr 2024 18:07:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
Message-Id: <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
In-Reply-To: <0000000000007545d00615188a03@google.com>
References: <0000000000007545d00615188a03@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Apr 2024 01:03:26 -0700 syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fd40c5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-317c7bc0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/efab473d72c0/vmlinux-317c7bc0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5ba3f56d362d/bzImage-317c7bc0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 30105 at mm/memcontrol.c:865 __mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
> Modules linked in:
> CPU: 0 PID: 30105 Comm: syz-executor.2 Not tainted 6.9.0-rc1-syzkaller-00178-g317c7bc0ef03 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:__mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
> Code: 45 85 e4 75 1d 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc b8 00 04 00 00 e9 80 fd ff ff 89 c6 e9 a0 fd ff ff 90 <0f> 0b 90 e9 a7 fc ff ff 48 c7 c7 18 43 e1 8f e8 32 51 f8 ff e9 5e
> RSP: 0018:ffffc900034beef8 EFLAGS: 00010202
> RAX: 0000000000000292 RBX: 0000000000000001 RCX: 1ffffffff1fc2863
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024b92bc8
> RBP: ffff888024b92000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: ffff88801c326000 R14: 0000000000000001 R15: ffff888024b92000
> FS:  00007f0811bf96c0(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000cfff1dd CR3: 000000003e4e2000 CR4: 0000000000350ef0
> DR0: 0000000000000031 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __update_lru_size include/linux/mm_inline.h:47 [inline]
>  lru_gen_update_size include/linux/mm_inline.h:199 [inline]
>  lru_gen_add_folio+0x62d/0xe80 include/linux/mm_inline.h:262
>  lruvec_add_folio include/linux/mm_inline.h:323 [inline]
>  lru_add_fn+0x3fc/0xd80 mm/swap.c:215
>  folio_batch_move_lru+0x243/0x400 mm/swap.c:233

Well it beats me.  I assume we failed to update for a new case.  I'll
toss this into -next to perhaps shed a bit of light.

--- a/mm/memcontrol.c~__mod_memcg_lruvec_state-enhance-diagnostics
+++ a/mm/memcontrol.c
@@ -860,10 +860,12 @@ void __mod_memcg_lruvec_state(struct lru
 		case NR_ANON_THPS:
 		case NR_SHMEM_PMDMAPPED:
 		case NR_FILE_PMDMAPPED:
-			WARN_ON_ONCE(!in_task());
+			if (WARN_ON_ONCE(!in_task()))
+				pr_warn("stat item index: %d\n", idx);
 			break;
 		default:
-			VM_WARN_ON_IRQS_ENABLED();
+			if (VM_WARN_ON_IRQS_ENABLED())
+				pr_warn("stat item index: %d\n", idx);
 		}
 	}
 
_


