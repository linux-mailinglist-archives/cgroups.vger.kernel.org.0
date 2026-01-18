Return-Path: <cgroups+bounces-13293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D31D39201
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 01:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181A33014A17
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203B1A9FA0;
	Sun, 18 Jan 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n8OmmJFe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA717B506;
	Sun, 18 Jan 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768697843; cv=none; b=nmUYmdDmJ/empvgvNwAMbDzZY/FsHsldX0orh8sSpgYossgpni+VloCRMi1/11psu+kiv3E5XiwsfjDocnw+PI3e/Zph3IZ3dowS6q6i6234ENs5OTX2Iq8VY1pvs7jA12RNh+A8xU+qf0XLBQWfm4EgSkWismEgPdyJLIznThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768697843; c=relaxed/simple;
	bh=+qlEcociOsXhFIAAdcAIVtM1BeAAOHRNXsXknKhk1Ls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UUYHKLfrvxcgO8Fi8l3Kuq0/eGvngTDwbPcZFFsomFjlMdEf9apEx70K8Mgk8IFD1vSRByHojna8E8sulweYW7dfr4cZt0j0a1feqNnYrBiL//uS41V4MykniggsQ5Nr6zBsnMr675EHEnqiUVqp6mJADR8+KLkHeMry5v3JO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n8OmmJFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17332C4CEF7;
	Sun, 18 Jan 2026 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768697843;
	bh=+qlEcociOsXhFIAAdcAIVtM1BeAAOHRNXsXknKhk1Ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n8OmmJFeegpmjTXfCuPr2nsg2Ue6kyfKGMGToVw4/bRZTybt/tEyM8TIi4ilXkN/o
	 qTY7n2OxXZpNLddYJZCg32+yFIOXNJXnUtSjF6bL8Bpn/PQ9MNGJoAcI45Wt01Sbrp
	 EGUMyYxytM7ELn4tlZqNLM9//8orztSXrFJ9YIGQ=
Date: Sat, 17 Jan 2026 16:57:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 syzkaller-bugs@googlegroups.com, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Deepanshu Kartikey
 <kartikey406@gmail.com>, Minchan Kim <minchan@kernel.org>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
Message-Id: <20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
In-Reply-To: <696b56b1.050a0220.3390f1.0007.GAE@google.com>
References: <696b56b1.050a0220.3390f1.0007.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 01:30:25 -0800 syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f7259a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d6e5303d96e21b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=079a3b213add54dd18a7
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167ef922580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d295fa580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/480cd223f3f6/disk-0f853ca2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1ca2f0dbb7cc/vmlinux-0f853ca2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/60a0fef5805b/bzImage-0f853ca2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com

Thanks.

> ------------[ cut here ]------------
> WARNING: mm/memcontrol-v1.c:642 at memcg1_swapout+0x6c2/0x8d0 mm/memcontrol-v1.c:642, CPU#0: syz.4.233/6746

That's

	VM_WARN_ON_ONCE(oldid != 0);

which was added by Deepanshu's "mm/swap_cgroup: fix kernel BUG in
swap_cgroup_record".

This patch has Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT"),
which is six years old.  For some reason it has no cc:stable.

Deepanshu's patch has no reviews.

So can I please do the memcg maintainer summoning dance here?  We have a
repeatable BUG happening in mainline Linux.


