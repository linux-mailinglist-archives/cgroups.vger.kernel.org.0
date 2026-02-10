Return-Path: <cgroups+bounces-13838-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrFDzZyi2m7UQAAu9opvQ
	(envelope-from <cgroups+bounces-13838-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:00:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D876711E2F9
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74003041BF3
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366638B7A5;
	Tue, 10 Feb 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYZLmwgQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D9191F94
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746415; cv=pass; b=B/ze6SWP9X3r41f/vMiqMrj0/aN+nwM3gIqHo+W8WyI7X22glgAjrZo+EDkpzylM6225rTb43QawdthyVQeze2gn5CnrqeZXX1FwQjN3Oev+1xbHpQrTyLXSPQBS27V0ksPre0xhE5XT6feM6pT2O6tGyYHWlXB213aO/Ofe5VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746415; c=relaxed/simple;
	bh=S87tUlL4GFpfKiosQaW863Ba71AxTPRsXc2HVeG+yI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpQE1yn78TMLgdm6RjHXwqeLD2totL9OILrXI0D3ah41KV97pDiir1qFqX7/fQyMfw95O+DLZwDLju71vpvBnIosn4JIX5jfxsUn3N5J4PNW2o68ZC3Kycviv3FHmUx/RGxaawwtqEjlfRhGBg8sNgqkE/g1/Wt9X+aJEmDMnJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYZLmwgQ; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b86ed375d37so128012266b.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 10:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770746412; cv=none;
        d=google.com; s=arc-20240605;
        b=g5Kf8s6Rqyy38lSARKi0oxCNGBI1Ew6lFMmZioKIrUxhpEelLk4imLvGOmgmZ8KXls
         EqFO7DpoCjCAzm2l68yk2KkCSeT+dADbRSjCbu758zRgZUKg0UhOsn2jjfFTLRJjlqWX
         DR3lzpjKYzB4VBjgyhkjO0f3gnu6iGrNy9d7uIbPkt9AMB1fNqO4bFXzUkktHkg5akdF
         dScqfQLFFgf8piqkWd8iUBq1eEsvreYmoEMmTu0axCdf53csfLeZcrES8IOsW9yyjcp5
         LRBjI6p/mSKul4EHh2eJ8ATYvMwMzCX189Xj1Q1EuxkiSzwoJx+MKtheVCzU+wTbB+UE
         D2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0M5Ou8Dr19t94K73pKgRAsY639KugQQU9W89/USRqN0=;
        fh=X84g+Z3y2sx/+7YYJbgog9IOpaVzHfX+9mXigaN7Cos=;
        b=JzhlcZhAnhXCcVPjU+oH6v0odkZRZRtUVG9ZwyBJKRULuoQm8h99VCoy2lUBay3Oqs
         z2Go+xEh8RH8LyDPd4DvAJIW/OTU4aYhEubNLtC4gAAn3bZRxyM0nYNvPUR9E+zdypIc
         Qo4/Nbwxns8EfQKyEZo4O0tqTzzwm9EztJnYyu/04aVcYwvcM0nk2RYw1cfDBM6KsG79
         awDBLetmkpOUXgWZYBH5BtkiXFOZIDLQqrWIIZ9UZ2lO70UAndpQu+FBeiORRI+C4/bS
         J3IMYp3gCqe98RwSKlUOTpe/I/1Cj02qNcL8xlZP3CnagfdQSJ0gc8G4OyOmLJYBbWOX
         vG3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770746412; x=1771351212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M5Ou8Dr19t94K73pKgRAsY639KugQQU9W89/USRqN0=;
        b=hYZLmwgQ/ycsuQ+OxXnW2hsjwk889p5tuWO0nWnC31tcFk8Nw7GlKdqUWjBJ/GbPn2
         i7B8VDtk2yZHa6SIwiEit/+986XcDcX8HWwl04hBsSHR/+XvYve1/ZXji43YJiKx7AFu
         9gea2snWykd5n0rhuiAcZp18vqKyI3BI09UJMb2Kc9H1QUDdXKhzZgh3/H//nFI9xA58
         fb2VREcNrTF+K+RGxKYntfGh+/Qf4Kl12oBUoHyxrWBINxqtqTXC8qHLHfWmjIF9SKaw
         vzE0N/NfU454q+4SPY8qw13DhZ4+Ru3SldA5A0DDzqovma/nTMe6AEJSo+Vxm/7zkQFQ
         Q26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770746412; x=1771351212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0M5Ou8Dr19t94K73pKgRAsY639KugQQU9W89/USRqN0=;
        b=GsavXF6XP6h2KZ9Y18R3ema+vh9RpSMiElO0hbXoE8u+IHKmMIxeHoiE8XMsPF8rpk
         wLGMJd38GBQypn9FkGF5wBZbgMaHElCuCPq0LgdeFLF42rszlKIJKUl8m8WpwV44z/nA
         sEduIDXgIDRUW1DlFloC+Hk67Bi76wLuKbr5VIQbavy+kJtDD1QvoVQ3u9fBjTEShNIn
         HGHZD+O7WtYhJYGrVGES9bTnOuVBrMlcUE+E44IPqw0v0RPydglDYctT67VrQ9YhWP+i
         zHrFEBQd/+m3ctVGkXSeDo5+FsQF/CbBMysXW0GdGe9yZtR+JZ6z/bkpfIAXBAMrd9jB
         PmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY7pWKEoJ49NAFjGIY5zeqVi+YU+Kjj1EaEE1ewu2ZZSiE0g4Bmpud3QynxuinEo1nEPvrSoA/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2v4gk9Fw3ENqEL3JZUcB/Qi9FnJS6eSiULEa7ZE8WWci9Kju4
	EF0rIjJ2jqtq3CTiS84yuJebefx1bufv9eU0fHxjlfJKcj3zVuCucxDeOqW5M7sjPjesHslAmsx
	7ZY2q0MwTu0NlQn1FOexNftk4YcUaPT4=
X-Gm-Gg: AZuq6aKJVwCjP/Gdszj9R3P/6ljDwTMPx/ia41r4Aa9DFgIYPqokWS59hjQTmw1e/0g
	/0mVo2CUCnihEeQdMm7xtGI3BxfHgWZJunY3LF1zz7EXuK9ZU0J9zNI/BC7AJSXJjH1lr+PME3s
	emvSl633L9M+GPjxOx0oA/W53wXzBp/IjCIZ7jkoGyEkUndI1pLGhs4B1w4HN7SVvcYGjzCWAK8
	W4U8yBFimd2j7aRQpNs4UtgI/00dwFiunwIToiP+g7DxhkUdD9w3MBLd0gdzrVYa1aKItF3Ea/D
	wSu7shTtl/1/34g5E4w+t++qYunPztXQlxyYzpMGsAYQzvgfbJU=
X-Received: by 2002:a17:907:97cc:b0:b8e:3877:d1cb with SMTP id
 a640c23a62f3a-b8edf45cf7fmr962300066b.62.1770746411856; Tue, 10 Feb 2026
 10:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
In-Reply-To: <20260208222652.328284-1-nphamcs@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 11 Feb 2026 01:59:34 +0800
X-Gm-Features: AZwV_QgjgrVezF-d_BQ-9HaqLNY-NJc1Y-8aDIlBfdscQkLqG0fjwgzeysl6W44
Message-ID: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13838-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D876711E2F9
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 7:57=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Anyway, resending this (in-reply-to patch 1 of the series):

Hi Nhat,

> Changelog:
> * RFC v2 -> v3:
>     * Implement a cluster-based allocation algorithm for virtual swap
>       slots, inspired by Kairui Song and Chris Li's implementation, as
>       well as Johannes Weiner's suggestions. This eliminates the lock
>           contention issues on the virtual swap layer.
>     * Re-use swap table for the reverse mapping.
>     * Remove CONFIG_VIRTUAL_SWAP.

I really do think we better make this optional, not a replacement or
mandatory. There are many hard to evaluate effects as this
fundamentally changes the swap workflow with a lot of behavior changes
at once. e.g. it seems the folio will be reactivated instead of
splitted if the physical swap device is fragmented; slot is allocated
at IO and not at unmap, and maybe many others. Just like zswap is
optional. Some common workloads would see an obvious performance or
memory usage regression following this design, see below.

>     * Reducing the size of the swap descriptor from 48 bytes to 24
>       bytes, i.e another 50% reduction in memory overhead from v2.

Honestly if you keep reducing that you might just end up
reimplementing the swap table format :)

> This patch series is based on 6.19. There are a couple more
> swap-related changes in the mm-stable branch that I would need to
> coordinate with, but I would like to send this out as an update, to show
> that the lock contention issues that plagued earlier versions have been
> resolved and performance on the kernel build benchmark is now on-par with
> baseline. Furthermore, memory overhead has been substantially reduced
> compared to the last RFC version.

Thanks for the effort!

> * Operationally, static provisioning the swapfile for zswap pose
>   significant challenges, because the sysadmin has to prescribe how
>   much swap is needed a priori, for each combination of
>   (memory size x disk space x workload usage). It is even more
>   complicated when we take into account the variance of memory
>   compression, which changes the reclaim dynamics (and as a result,
>   swap space size requirement). The problem is further exarcebated for
>   users who rely on swap utilization (and exhaustion) as an OOM signal.

So I thought about it again, this one seems not to be an issue. In
most cases, having a 1:1 virtual swap setup is enough, and very soon
the static overhead will be really trivial. There won't even be any
fragmentation issue either, since if the physical memory size is
identical to swap space, then you can always find a matching part. And
besides, dynamic growth of swap files is actually very doable and
useful, that will make physical swap files adjustable at runtime, so
users won't need to waste a swap type id to extend physical swap
space.

> * Another motivation is to simplify swapoff, which is both complicated
>   and expensive in the current design, precisely because we are storing
>   an encoding of the backend positional information in the page table,
>   and thus requires a full page table walk to remove these references.

The swapoff here is not really a clean swapoff, minor faults will
still be triggered afterwards, and metadata is not released. So this
new swapoff cannot really guarantee the same performance as the old
swapoff. And on the other hand we can already just read everything
into the swap cache then ignore the page table walk with the older
design too, that's just not a clean swapoff.

> struct swp_desc {
>         union {
>                 swp_slot_t         slot;                 /*     0     8 *=
/
>                 struct zswap_entry * zswap_entry;        /*     0     8 *=
/
>         };                                               /*     0     8 *=
/
>         union {
>                 struct folio *     swap_cache;           /*     8     8 *=
/
>                 void *             shadow;               /*     8     8 *=
/
>         };                                               /*     8     8 *=
/
>         unsigned int               swap_count;           /*    16     4 *=
/
>         unsigned short             memcgid:16;           /*    20: 0  2 *=
/
>         bool                       in_swapcache:1;       /*    22: 0  1 *=
/

A standalone bit for swapcache looks like the old SWAP_HAS_CACHE that
causes many issues...

>
>         /* Bitfield combined with previous fields */
>
>         enum swap_type             type:2;               /*    20:17  4 *=
/
>
>         /* size: 24, cachelines: 1, members: 6 */
>         /* bit_padding: 13 bits */
>         /* last cacheline: 24 bytes */
> };

Having a struct larger than 8 bytes means you can't load it
atomically, that limits your lock design. About a year ago Chris
shared with me an idea to use CAS on swap entries once they are small
and unified, that's why swap table is using atomic_long_t and have
helpers like __swap_table_xchg, we are not making good use of them yet
though. Meanwhile we have already consolidated the lock scope to folio
in many places, holding the folio lock then doing the CAS without
touching cluster lock at all for many swap operations might be
feasible soon.

E.g. we already have a cluster-lockless version of swap check in swap table=
 p3:
https://lore.kernel.org/linux-mm/20260128-swap-table-p3-v2-11-fe0b67ef0215@=
tencent.com/

That might also greatly simplify the locking on IO and migration
performance between swap devices.

> Doing the same math for the disk swap, which is the worst case for
> virtual swap in terms of swap backends:

Actually this worst case is a very common case... see below.

> 0% usage, or 0 entries: 0.00 MB
> * Old design total overhead: 25.00 MB
> * Vswap total overhead: 2.00 MB
>
> 25% usage, or 2,097,152 entries:
> * Old design total overhead: 41.00 MB
> * Vswap total overhead: 66.25 MB
>
> 50% usage, or 4,194,304 entries:
> * Old design total overhead: 57.00 MB
> * Vswap total overhead: 130.50 MB
>
> 75% usage, or 6,291,456 entries:
> * Old design total overhead: 73.00 MB
> * Vswap total overhead: 194.75 MB
>
> 100% usage, or 8,388,608 entries:
> * Old design total overhead: 89.00 MB
> * Vswap total overhead: 259.00 MB
>
> The added overhead is 170MB, which is 0.5% of the total swapfile size,
> again in the worst case when we have a sizing oracle.

Hmm.. With the swap table we will have a stable 8 bytes per slot in
all cases, in current mm-stable we use 11 bytes (8 bytes dyn and 3
bytes static), and in the posted p3 we already get 10 bytes (8 bytes
dyn and 2 bytes static). P4 or follow up was already demonstrated
last year with working code, and it makes everything dynamic
(8 bytes fully dyn, I'll rebase and send that once p3 is merged).

So with mm-stable and follow up, for 32G swap device:

0% usage, or 0/8,388,608 entries: 0.00 MB
* mm-stable total overhead: 25.50 MB (which is swap table p2)
* swap-table p3 overhead: 17.50 MB
* swap-table p4 overhead: 0.50 MB
* Vswap total overhead: 2.00 MB

100% usage, or 8,388,608/8,388,608 entries:
* mm-stable total overhead: 89.5 MB (which is swap table p2)
* swap-table p3 overhead: 81.5 MB
* swap-table p4 overhead: 64.5 MB
* Vswap total overhead: 259.00 MB

That 3 - 4 times more memory usage, quite a trade off. With a
128G device, which is not something rare, it would be 1G of memory.
Swap table p3 / p4 is about 320M / 256M, and we do have a way to cut
that down close to be <1 byte or 3 byte per page with swap table
compaction, which was discussed in LSFMM last year, or even 1 bit
which was once suggested by Baolin, that would make it much smaller
down to <24MB (This is just an idea for now, but the compaction is
very doable as we already have "LRU"s for swap clusters in swap
allocator).

I don't think it looks good as a mandatory overhead. We do have a huge
user base of swap over many different kinds of devices, it was not
long ago two new kernel bugzilla issue  or bug reported was sent to
the maillist about swap over disk, and I'm still trying to investigate
one of them which seems to be actually a page LRU issue and not swap
problem..  OK a little off topic, anyway, I'm not saying that we don't
want more features, as I mentioned above, it would be better if this
can be optional and minimal. See more test info below.

> We actually see a slight improvement in systime (by 1.5%) :) This is
> likely because we no longer have to perform swap charging for zswap
> entries, and virtual swap allocator is simpler than that of physical
> swap.

Congrats! Yeah, I guess that's because vswap has a smaller lock scope
than zswap with a reduced callpath?

>
> Using SSD swap as the backend:
>
> Baseline:
> real: mean: 200.3s, stdev: 2.33s
> sys: mean: 489.88s, stdev: 9.62s
>
> Vswap:
> real: mean: 201.47s, stdev: 2.98s
> sys: mean: 487.36s, stdev: 5.53s
>
> The performance is neck-to-neck.

Thanks for the bench, but please also test with global pressure too.
One mistake I made when working on the prototype of swap tables was
only focusing on cgroup memory pressure, which is really not how
everyone uses Linux, and that's why I reworked it for a long time to
tweak the RCU allocation / freeing of swap table pages so there won't
be any regression even for lowend and global pressure. That's kind of
critical for devices like Android.

I did an overnight bench on this with global pressure, comparing to
mainline 6.19 and swap table p3 (I do include such test for each swap
table serie, p2 / p3 is close so I just rebase and latest p3 on top of
your base commit just to be fair and that's easier for me too) and it
doesn't look that good.

Test machine setup for vm-scalability:
# lscpu | grep "Model name"
Model name:          AMD EPYC 7K62 48-Core Processor

# free -m
              total        used        free      shared  buff/cache   avail=
able
Mem:          31582         909       26388           8        4284       2=
9989
Swap:         40959          41       40918

The swap setup follows the recommendation from Huang
(https://lore.kernel.org/linux-mm/87ed474kvx.fsf@yhuang6-desk2.ccr.corp.int=
el.com/).

Test (average of 18 test run):
vm-scalability/usemem --init-time -O -y -x -n 1 56G

6.19:
Throughput: 618.49 MB/s (stdev 31.3)
Free latency: 5754780.50us (stdev 69542.7)

swap-table-p3 (3.8%, 0.5% better):
Throughput: 642.02 MB/s (stdev 25.1)
Free latency: 5728544.16us (stdev 48592.51)

vswap (3.2%, 244% worse):
Throughput: 598.67 MB/s (stdev 25.1)
Free latency: 13987175.66us (stdev 125148.57)

That's a huge regression with freeing. I have a vm-scatiliby test
matrix, not every setup has such significant >200% regression, but on
average the freeing time is about at least 15 - 50% slower (for
example /data/vm-scalability/usemem --init-time -O -y -x -n 32 1536M
the regression is about 2583221.62us vs 2153735.59us). Throughput is
all lower too.

Freeing is important as it was causing many problems before, it's the
reason why we had a swap slot freeing cache years ago (and later we
removed that since the freeing cache causes more problems and swap
allocator already improved it better than having the cache). People
even tried to optimize that:
https://lore.kernel.org/linux-mm/20250909065349.574894-1-liulei.rjpt@vivo.c=
om/
(This seems a already fixed downstream issue, solved by swap allocator
or swap table). Some workloads might amplify the free latency greatly
and cause serious lags as shown above.

Another thing I personally cares about is how swap works on my daily
laptop :), building the kernel in a 2G test VM using NVME as swap,
which is a very practical workload I do everyday, the result is also
not good (average of 8 test run, make -j12):
#free -m
               total        used        free      shared  buff/cache   avai=
lable
Mem:            1465         216        1026           0         300       =
 1248
Swap:           4095          36        4059

6.19 systime:
109.6s
swap-table p3:
108.9s
vswap systime:
118.7s

On a build server, it's also slower (make -j48 with 4G memory VM and
NVME swap, average of 10 testrun):
# free -m
               total        used        free      shared  buff/cache   avai=
lable
Mem:            3877        1444        2019         737        1376       =
 2432
Swap:          32767        1886       30881

# lscpu | grep "Model name"
Model name:                              Intel(R) Xeon(R) Platinum
8255C CPU @ 2.50GHz

6.19 systime:
435.601s
swap-table p3:
432.793s
vswap systime:
455.652s

In conclusion it's about 4.3 - 8.3% slower for common workloads under
global pressure, and there is a up to 200% regression on freeing. ZRAM
shows an even larger workload regression but I'll skip that part since
your series is focusing on zswap now. Redis is also ~20% slower
compared to mm-stable (327515.00 RPS vs 405827.81 RPS), that's mostly
due to swap-table-p2 in mm-stable so I didn't do further comparisons.

So if that's not a bug with this series, I think the double free or
decoupling of swap / underlying slots might be the problem with the
freeing regression shown above. That's really a serious issue, and the
global pressure might be a critical issue too as the metadata is much
larger, and is already causing regressions for very common workloads.
Low end users could hit the min watermark easily and could have
serious jitters or allocation failures.

That's part of the issue I've found, so I really do think we need a
flexible way to implementa that and not have a mandatory layer. After
swap table P4 we should be able to figure out a way to fit all needs,
with a clean defined set of swap API, metadata and layers, as was
discussed at LSFMM last year.

