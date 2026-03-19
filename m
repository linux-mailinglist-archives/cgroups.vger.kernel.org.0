Return-Path: <cgroups+bounces-14931-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PPcA9SGvGlk0AIAu9opvQ
	(envelope-from <cgroups+bounces-14931-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 00:29:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC12D41D4
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 00:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C79F302FFEC
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B173EDADA;
	Thu, 19 Mar 2026 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZjyjfGr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD03F8E09
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962785; cv=pass; b=Kfz7Vctrq/irVVqUK+LMqwttvRqvf59XHuUECFQ0FAtruxlWqZpLwRW7VkpUAY8bLo33WRljbCYCA4CO6tfZg9Rz2SiRtFeid8y87b4ij6Fx4tqb8SLdgkSE/b7Aws4lDYhwSIJgbY1Xi5omwzth2idSonUmeCgcsmjyoDCohzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962785; c=relaxed/simple;
	bh=biWQzYmkSAT7COHU3SJ1yQbLPGtRxmVBoGdTj8nctes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGB1Rv3E7U2YHx1mttcQ3LequQN8ssa/YDzRWq2vmiOse3tTTXCyqclom5yEwiwMzkXsNRQ5t7id8TPyD9vEXBHRqHiNcVRD4f0DCmHkbyWxkvYeVNcxaEdhuvn5btI8IB7lDeDAvxwzTVAklnB3Qxj2AVD099hHv814anvYFV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZjyjfGr; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b7c2788dso22867f8f.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 16:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773962782; cv=none;
        d=google.com; s=arc-20240605;
        b=He95YF6NDas9BuV+ky0Tj2rXfnauYnUT3kKyzkVwtohnmS19HGk1UbQU6DF23e0iYz
         KUk5a4+/ZHb3dh4c0DBGp8sWk/RFULRH8NOP3Amk54B/+H6MZwOkNgIPi7Z0G93BalcD
         /Gj5/ByLQ63Y7VZi/UHHb9Ut477p2pyhd0a0YB58zI53BFdX388fXRYphvTdNg2VpOk7
         O/OYuGeb4pBmpTXHhYnkdzKINwy3X1NBslnqonuuj0xDsxo95BaGy+mkIqe7inqV83xm
         3fNEUmo3ljpnGIymWYoe2dW0BPrTK5V6EtYse4mw6LDgJtJDfqnKrqc4Acfo67Jva9T0
         6paA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        fh=/KWw2Yuo9WpzPT8sUfbeYJggWvfzq8pDb/mSATY47aM=;
        b=lhmhe1LaZXB3XDUMebcmcBrWqrmhumabRh/P+Vo7+RV+KR/jhGoJv/AxjuSEprmUIs
         4nWPyHV/89adLNOin40wKnKk1jAJo62GB8T3XFQoZjMEhA3Fg04T90VgajB/3YtXN1kj
         GPSrW9SAoP+ThDxyl874UsP8C+2ZY24DzNAiBpruxeRAOXnkJDc24eBNuU9i539Mq7Rk
         z002wH7BeScBCbV8p4Mtf06i4eKc71eQ3IrIclMLztqQHUg4EpXiMRkfC8J+5cpVOCxL
         2MtGz2lpshFJSeER1UzXzXVkAF1vj+FxZ7yMJOjPtwzWmYmoEHZhOytWfy+ZoO5ixgHU
         NUkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773962782; x=1774567582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        b=hZjyjfGrKp6/17A6t7uU+OrJML0J38+3AvZMwgwCYFolY1XGTM7f8osamH+gMvoTu6
         b4Zq/j2TEz+YGIJvB+v3C3hABISG/9nc3+YQbPtxc7CV9Lk29PaeM6wFs1gKKxBak1Bc
         146+wYgFl3w2upobFF8LK67fVdMlZPi55p7bPh8NDZ2GISYRDlEks3mKfyN+RJzTsRzv
         ETUuTu5p2f5sWnk+QvWZgz3YBJE05JNGw3WUGCdoKI9ZXe5F/h+GGlc7SjKro9KGgMxX
         YAu8RkfJAuDGcWK7fw/wVrsFMJ5vgVMUWcP8wblvjPmbeZWmNyuWSU+E0Y4RgpqYso9M
         tvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962782; x=1774567582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        b=cDlMTejGatl1b0hwWAaKHj0k8i3mN21oA8SqVO5+mY6bJBUOfYHLkfWbC4zPDDUJSN
         d36/eg4TbExsx0vpCh9xmNXYsWe8vDTQ2DNoS/fqiCQyGKJPk8Ej0kl0d1X5vTNCqYOK
         QEFz5HvhkwqsN9THOEnJqqX3XZBWA2hYbPvCZX7+ox/o6pQZLf5UH4RtixrFGqEmZmBE
         2sUFlwqaaG8wjURsX4MEnMHafeoQzmwzsZ8nsCgrDvr++LTkHnQuA2A/yCuNb+QnMK3o
         /Qe96AIclAyUiSND3JSxivfuVjyRRHPWobKNRar2TBfeTL4h6FudAvJXQLW2yPXx+pm0
         J2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjmbLgje+c/LQBnt8a/13CjnwmV9fnOHvcc1nv9RwCmgJyTT4Y755ERqRa+L5/V9WF+/DM5Ntw@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmJpBy6T2zx+xKYV6z683FRfilYOniWayiOib1iOmKR35dS3q
	DMalRiV1t49123MSqsj7YXh/MeKFCjUdWbM5S0PAjZO/uae9hO2AKOc5lN2wB+IJHTuqRBp19Tb
	slIfLDhofGkFs79AtN0RA045HwzojCHQ=
X-Gm-Gg: ATEYQzwLQbtYWiKCVgEDF7g8LAFGb85Lvofq47K1h6QVuKGiNdIZrvDuQ28exDyeFif
	cPRStY3VhcQDEV5dQyfhsH73x6TAELyaMywjxoLp0HhpKfrsLj9iwcXwRi59xt9ClTnkb4vd0qt
	Ystak5xrQLhTQ49O8DnNzcVZVOC1ESnmFfcu/+R+JWA+ddhwAilcKR85qXrSrOmWbTg/GeSQqVM
	q+S8S2QpAIxduRDjka6Vk5fsG2jo4oMmdNiAbLTOIkN6/lLklo6C1QVqiINxY/aKu3eijNdPN9+
	gPTaX4fH9KHaP/zScn8wjRUCsGAx8TLx2peimsg=
X-Received: by 2002:a05:6000:1a88:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-43b64257edamr2078092f8f.23.1773962781517; Thu, 19 Mar 2026
 16:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <69bc6c4f.050a0220.3bf4de.0001.GAE@google.com>
In-Reply-To: <69bc6c4f.050a0220.3bf4de.0001.GAE@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 16:26:10 -0700
X-Gm-Features: AaiRm53Xe0ySNcLwX_1MJR-ZkSlSVSu1aeYx4yiRcGwlx-CLDipgZeR1y7Vur74
Message-ID: <CAKEwX=PF470op0e+eXcFS3SHKaLRd5v6ZuE+_aUk_4xfdGosog@mail.gmail.com>
Subject: Re: [syzbot ci] Re: Virtual Swap Space
To: syzbot ci <syzbot+ci0215525ee2c0ed89@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, bhe@redhat.com, 
	byungchul@sk.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, kasong@tencent.com, kernel-team@meta.com, 
	lance.yang@linux.dev, lenb@kernel.org, liam.howlett@oracle.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14931-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,oracle.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,surriel.com,huaweicloud.com,suse.cz,lists.linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.771];
	TAGGED_RCPT(0.00)[cgroups,ci0215525ee2c0ed89];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzbot.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlesource.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 99CC12D41D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:36=E2=80=AFPM syzbot ci
<syzbot+ci0215525ee2c0ed89@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v4] Virtual Swap Space
> https://lore.kernel.org/all/20260318222953.441758-1-nphamcs@gmail.com
> * [PATCH v4 01/21] mm/swap: decouple swap cache from physical swap infras=
tructure
> * [PATCH v4 02/21] swap: rearrange the swap header file
> * [PATCH v4 03/21] mm: swap: add an abstract API for locking out swapoff
> * [PATCH v4 04/21] zswap: add new helpers for zswap entry operations
> * [PATCH v4 05/21] mm/swap: add a new function to check if a swap entry i=
s in swap cached.
> * [PATCH v4 06/21] mm: swap: add a separate type for physical swap slots
> * [PATCH v4 07/21] mm: create scaffolds for the new virtual swap implemen=
tation
> * [PATCH v4 08/21] zswap: prepare zswap for swap virtualization
> * [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each swappe=
d out page
> * [PATCH v4 10/21] swap: move swap cache to virtual swap descriptor
> * [PATCH v4 11/21] zswap: move zswap entry management to the virtual swap=
 descriptor
> * [PATCH v4 12/21] swap: implement the swap_cgroup API using virtual swap
> * [PATCH v4 13/21] swap: manage swap entry lifecycle at the virtual swap =
layer
> * [PATCH v4 14/21] mm: swap: decouple virtual swap slot from backing stor=
e
> * [PATCH v4 15/21] zswap: do not start zswap shrinker if there is no phys=
ical swap slots
> * [PATCH v4 16/21] swap: do not unnecesarily pin readahead swap entries
> * [PATCH v4 17/21] swapfile: remove zeromap bitmap
> * [PATCH v4 18/21] memcg: swap: only charge physical swap slots
> * [PATCH v4 19/21] swap: simplify swapoff using virtual swap
> * [PATCH v4 20/21] swapfile: replace the swap map with bitmaps
> * [PATCH v4 21/21] vswap: batch contiguous vswap free calls
>
> and found the following issue:
> possible deadlock in vswap_iter
>
> Full report is available here:
> https://ci.syzbot.org/series/f8238a2a-370e-404d-b3f7-5945b574bd63
>
> ***
>
> possible deadlock in vswap_iter
>
> tree:      bpf-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/b=
pf-next.git
> base:      05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~e=
xp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/cf1517a6-d391-46d8-bfbe-98e6be6b9=
3ce/config
> syz repro: https://ci.syzbot.org/findings/b4e84ae7-17d4-4bf8-9c3f-4c13b10=
a1e52/syz_repro
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.1.18/6001 is trying to acquire lock:
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock include/linu=
x/spinlock.h:351 [inline]
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: vswap_iter+0xfa/0x1b0 =
mm/vswap.c:274
>
> but task is already holding lock:
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/=
linux/spinlock.h:376 [inline]
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0x=
e2/0x190 mm/vswap.c:1529
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&cluster->lock);
>   lock(&cluster->lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by syz.1.18/6001:
>  #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock in=
clude/linux/mmap_lock.h:391 [inline]
>  #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: madvise_lock+0x15=
2/0x2e0 mm/madvise.c:1789
>  #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq inc=
lude/linux/spinlock.h:376 [inline]
>  #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_i=
rq+0xe2/0x190 mm/vswap.c:1529
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:867 [inline]
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: vswap_cgroup_recor=
d+0x41/0x440 mm/vswap.c:1909
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 6001 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
>  check_deadlock kernel/locking/lockdep.c:3093 [inline]
>  validate_chain kernel/locking/lockdep.c:3895 [inline]
>  __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
>  lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  vswap_iter+0xfa/0x1b0 mm/vswap.c:274
>  vswap_cgroup_record+0xeb/0x440 mm/vswap.c:1910
>  swap_cgroup_record+0xc5/0x130 mm/vswap.c:1933
>  memcg1_swapout+0x358/0x9e0 mm/memcontrol-v1.c:623

Good (syz)bot! We're already holding the cluster lock here - shouldn't
need to reacquire the lock.

Should be an easy-ish fix.

