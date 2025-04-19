Return-Path: <cgroups+bounces-7660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FAA943B8
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CA7189BA28
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC91D8A10;
	Sat, 19 Apr 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWWIooYE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43274690
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745072491; cv=none; b=S8H5gQGyjlDp+VFDK+NdSrzdLTUBHND7WZAxc9Q5+MsoGahybC66sDq1svfWcQ9um51uI6AM4hWS4CwV35oum5+P2jElLbMLq0+seGgrBx7oFdnOiYGXoHoQGbpKQtm1buTTZ88PLp510k/WRp5BRwc2IcXlcfww+Rw7J9dONqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745072491; c=relaxed/simple;
	bh=yqejJTrEmgBbkB5/ozdmd+Tc7TA2sv5z1vo2J22fkWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FTanbhdD4SUgC/WARfVvMOX8HaU2sXsoiqFT33xoLWadYRAKC9O018UdZWvi4ZXc0uiiZG1DhvyXWvv3fC3GV6NbhS3+rdvhDSgKulVJLLBFwWPCF5IwflcP55Rx2MEUV4LfUiIyyYMrOOygpT9sYoWCcVpCaXkxSTdigtPoJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWWIooYE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745072475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owGEYEvW/pvjQC1+jZhJzwVQIEbsWAz69NtVPwTDcJM=;
	b=CWWIooYE0uJZ5OeLqPiPvRZaxRCwz9d2r+Rn7NcCpTyZoqvnQOeoCr8PI70qr+pHBEiDgh
	C4J+OTX2pqSJCmBQyOnkZdQ/89oxelps296Lj5HisjXVwclQdX4plH1ehepJxatweQvX/U
	bmyuZAEXi/rwWbG+UMzVzn6s2Y70S9c=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RFC 06/28] mm: thp: introduce folio_split_queue_lock and
 its variants
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250418195013.GA877644@cmpxchg.org>
Date: Sat, 19 Apr 2025 22:20:33 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev,
 nphamcs@gmail.com,
 chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <555DF274-355C-4D96-A71F-8E74436D5587@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-7-songmuchun@bytedance.com>
 <20250418195013.GA877644@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 19, 2025, at 03:50, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Tue, Apr 15, 2025 at 10:45:10AM +0800, Muchun Song wrote:
>> @@ -4202,7 +4248,7 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
>> if (!--sc->nr_to_scan)
>> break;
>> }
>> - 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> + 	split_queue_unlock_irqrestore(ds_queue, flags);
>>=20
>> 	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
>> 		bool did_split =3D false;
>> @@ -4251,7 +4297,7 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
>> 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> 	list_splice_tail(&list, &ds_queue->split_queue);
>> 	ds_queue->split_queue_len -=3D removed;
>> - 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> + 	split_queue_unlock_irqrestore(ds_queue, flags);
>=20
> These just tripped up in my testing. You use the new helpers for
> unlock, but not for the lock path. That's fine in this patch, but when
> "mm: thp: prepare for reparenting LRU pages for split queue lock" adds
> the rcu locking to the helpers, it results in missing rcu read locks:

Good catch! Thanks for pointing out. You are right, I shouldn't use the
new unlock helpers here without the corresponding new lock helpers. I'll
revert this change in this function.

Muchun,
Thanks.

>=20
> [  108.814880]
> [  108.816378] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  108.821069] WARNING: bad unlock balance detected!
> [  108.825762] 6.15.0-rc2-00028-g570c8034f057 #192 Not tainted
> [  108.831323] -------------------------------------
> [  108.836016] cc1/2031 is trying to release lock (rcu_read_lock) at:
> [  108.842181] [<ffffffff815f9d05>] deferred_split_scan+0x235/0x4b0
> [  108.848179] but there are no more locks to release!
> [  108.853046]
> [  108.853046] other info that might help us debug this:
> [  108.859553] 2 locks held by cc1/2031:
> [  108.863211]  #0: ffff88801ddbbd88 (vm_lock){....}-{0:0}, at: =
do_user_addr_fault+0x19c/0x6b0
> [  108.871544]  #1: ffffffff83042400 (fs_reclaim){....}-{0:0}, at: =
__alloc_pages_slowpath.constprop.0+0x337/0xf20
> [  108.881511]
> [  108.881511] stack backtrace:
> [  108.885862] CPU: 4 UID: 0 PID: 2031 Comm: cc1 Not tainted =
6.15.0-rc2-00028-g570c8034f057 #192 PREEMPT(voluntary)
> [  108.885865] Hardware name: Micro-Star International Co., Ltd. =
MS-7B98/Z390-A PRO (MS-7B98), BIOS 1.80 12/25/2019
> [  108.885866] Call Trace:
> [  108.885867]  <TASK>
> [  108.885868]  dump_stack_lvl+0x57/0x80
> [  108.885871]  ? deferred_split_scan+0x235/0x4b0
> [  108.885874]  print_unlock_imbalance_bug.part.0+0xfb/0x110
> [  108.885877]  ? deferred_split_scan+0x235/0x4b0
> [  108.885878]  lock_release+0x258/0x3e0
> [  108.885880]  ? deferred_split_scan+0x85/0x4b0
> [  108.885881]  deferred_split_scan+0x23a/0x4b0
> [  108.885885]  ? find_held_lock+0x32/0x80
> [  108.885886]  ? local_clock_noinstr+0x9/0xd0
> [  108.885887]  ? lock_release+0x17e/0x3e0
> [  108.885889]  do_shrink_slab+0x155/0x480
> [  108.885891]  shrink_slab+0x33c/0x480
> [  108.885892]  ? shrink_slab+0x1c1/0x480
> [  108.885893]  shrink_node+0x324/0x840
> [  108.885895]  do_try_to_free_pages+0xdf/0x550
> [  108.885897]  try_to_free_pages+0xeb/0x260
> [  108.885899]  __alloc_pages_slowpath.constprop.0+0x35c/0xf20
> [  108.885901]  __alloc_frozen_pages_noprof+0x339/0x360
> [  108.885903]  __folio_alloc_noprof+0x10/0x90
> [  108.885904]  __handle_mm_fault+0xca5/0x1930
> [  108.885906]  handle_mm_fault+0xb6/0x310
> [  108.885908]  do_user_addr_fault+0x21e/0x6b0
> [  108.885910]  exc_page_fault+0x62/0x1d0
> [  108.885911]  asm_exc_page_fault+0x22/0x30
> [  108.885912] RIP: 0033:0xf64890
> [  108.885914] Code: 4e 64 31 d2 b9 01 00 00 00 31 f6 4c 89 45 98 e8 =
66 b3 88 ff 4c 8b 45 98 bf 28 00 00 00 b9 08 00 00 00 49 8b 70 18 48 8b =
56 58 <48> 89 10 48 8b 13 48 89 46 58 c7 46 60 00 00 00 00 e9 62 01 00 =
00
> [  108.885915] RSP: 002b:00007ffcf3c7d920 EFLAGS: 00010206
> [  108.885916] RAX: 00007f7bf07c5000 RBX: 00007ffcf3c7d9a0 RCX: =
0000000000000008
> [  108.885917] RDX: 00007f7bf06aa000 RSI: 00007f7bf09dd400 RDI: =
0000000000000028
> [  108.885917] RBP: 00007ffcf3c7d990 R08: 00007f7bf080c540 R09: =
0000000000000007
> [  108.885918] R10: 000000000000009a R11: 000000003e969900 R12: =
00007f7bf07bbe70
> [  108.885918] R13: 0000000000000000 R14: 00007f7bf07bbec0 R15: =
00007ffcf3c7d930
> [  108.885920]  </TASK>


