Return-Path: <cgroups+bounces-15493-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GPmCvHw6mm8GAAAu9opvQ
	(envelope-from <cgroups+bounces-15493-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:26:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C061A459B87
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7113013AA5
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3691325714;
	Fri, 24 Apr 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcFiP5/A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8E1A6810
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004777; cv=pass; b=o+EVOOWbGAjuCdUbMRA4+afM0BcKKQqPCHYMtZ1OW4bylU1/mKvp481qVUNAGBhC+74OeMz30fcPCvYheaVMUPWoLkyJReGnfZgqOydKAEt0rT7Htfel18Vsq5iUZ9SqUxbcQrLKfzV282OnBy5L9pfrfEp+sXBv7gIgkEBbYac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004777; c=relaxed/simple;
	bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcCnSQG9YM2O+J3/9VuJU/DFzAhYC/DboCTu6wT9t1gCNWf6eIfBxcZd/aQlZKMxPGQhBwLMdUKHVHHY7CAlqUONb0XbCpS+08qsLzscQdChRNLdYfDw8IYk7GdHEQQnGkgwL86wAxqeLIHPUjccPlJwekJ4j4cMgAISjPpD3Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcFiP5/A; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso9703155a12.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 21:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777004775; cv=none;
        d=google.com; s=arc-20240605;
        b=kf2c+pLTj0xlUO4R7IVc0PZa2SB2lBW+0rYcpb/2ZbyYwgwZXcGiaH0KdFYZM8c/Kd
         1g3krzHIl3SHYiIYJ6CWdpF/EtwOfS4Mp94fGaKrBwI1GihZESvXHFBop+mDumfn6Lrr
         TiHt+EXLd8qgobdS2QRJPvvBHXXsKyuMX/x95OY3li8GkW9f1UwkgChcSzLZKrfCDfG7
         kyVr0O34/m7j3rfu+T1uweLMmhGCHYayhKEe0yVeWhJfp4RgcIW5U7C7Ev8ZwEmc4EVJ
         GJ3mcTSbWZc5MQHqlQioAKQI9vYg/+/cAVFalaTGSAx3sjeIlSe4TMJ+dUqrxosOwbjR
         S3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        fh=1P6r8jXs0eyMsltjnx+8aEFzNCTF5KkEuwuviS2oRN4=;
        b=F1twQlz8PElTz6tRt/5qX66OCpqxfBlTa7cqI9R/DNFT0glbupEeWF3jjD58X7UuzB
         YDHn7VLAbOmmcnlpiraIapS/PLhFRJ0tifUBXPm5BmxfYvBY6feXF8bercYmx3cggbEF
         IcFh6w9+mPEsPPq3KMsYtAjG47Xjt93GHxDyu4UpCjE4xkn4CKtiuIPcEW8MRtmOJIgp
         9PCtku6+pouYrpauh1Px1Qn2NQzy2X3bjqlGbfAFSqdgWqLmcCL3VromyinD3NxEuCxE
         IbybuZ9rhK7Eoca32SZsX6m585dO/1Ulr/9pod+i4NYJ86IKgUvBfxgBK4C5Q59RkVTQ
         PCHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777004775; x=1777609575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        b=jcFiP5/Al5Xwhl4JoG6NyE0iNEX4w/A4Jr+jPw5FuuwJZ4utBjLuX1V5LOpRL7mFY3
         0Sx9EEwo/SyhruXyeHuxquH5IHomvjsUpdZwJXxde/c2XpySXQvYdF80z/Wlw4cFiYb6
         v2MEy2OndyUltBh3tVo67xpwa1ubRxLF/7qRa258PV/UG8DCwVlbh1+bwnM1XtmUaOnn
         LR8shV32nK8yTJP3atNcg10KsL2ghaIFP38ZIInrYp8HXJZs9Hf6M6/POjJ1xmsYDI5X
         jtdnS58aYn7L8amLlF2n/8huquEWLPNe9ayUPlbbPZU0ruhGgCe3vO+LNtYSN5gpVj9b
         BBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777004775; x=1777609575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        b=JBiTQ/0pIYBR2JEegNZlyFJKA7l8rL+ZMBdGIhUMhriLdzNHd9YvcEm+LpPGt3OBBh
         m/JOnGbqxUPwe8rViBIvC8YNdNwHJ2EYoSMf7HSOMVsxpI8u/7+y7J6nJvFXVYQQ68OK
         +/qDVidwMxloK28u2WnvYj2wUkSwIvDjXJ6x8rwa+PAO8MMLCjNu8GJIZK4zZBOVaqXU
         x61D54ioZ7A9nUi0SvL0RSvxqeX5RmA9/PHJ1p3dQZxL1er1NpZ7QQo+MyLj4baG6q8d
         GtfiXKH4p0IQJSTSSnRG8eFkTVHfbm5fJcsSKTXKJ/NxuG6zOjC4NVFn6h6cdG6y4qRE
         +ojQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oe37HOGwyZhblkZVToYU/NvrBbZxR+h8WNE6q6+gPFaptUSy0pD3vBZwCSE23f1IpR/L64gKd@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1uQsAwYDH/uJrpBk5TXHcqsmHB0EK/zbflDIxLuT7H4kTp6o
	vEx/WihIgyXL73qvdwo9+KGaF6p+XNzZJWxTTnM0WKMEjAvO1EB38hSn7Rgmo1NG8/v8s+b+B0u
	YoDeG8sec9iKqM/lMFu/OlGMQ2/mzAeg=
X-Gm-Gg: AeBDievcPUQ0l7TSc6fafchm52MZVEPF+yh/QxgUjtamqV9Nj65AZa/idqXnjGJnrhz
	sq4Aq3PINQ4GLNM1cmK+IqAxQFcrX/5eksB4m8WRAAiCFEFKUrUUnGwaE04+8M5FYGTyroHDvSq
	r4WOooojHLPkL21F7F7NVlZPUbyzBwwPdUdOs4zgtPyj9oA6u15NCnfPZbaR85xdIs9Cf13ogDR
	v6TJfjUAaqIrKLVirCv5SPZ1zALE1qlN3OSwIunCtD8Wl0ZUma6r+mbNLrBN+gNwcB1b74BxRki
	clxd7GYkemBrjU1FrsaG1I6reEEJvSkbJN2XsA1Rbp8V4UhSqw==
X-Received: by 2002:a17:907:7f94:b0:baa:3cf6:4f53 with SMTP id
 a640c23a62f3a-baa3d0598e6mr755922966b.5.1777004774432; Thu, 23 Apr 2026
 21:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com> <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
In-Reply-To: <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Apr 2026 12:25:37 +0800
X-Gm-Features: AQROBzDSTb6IkbZFirEBaP59AWqfa9zcQlpgQGNGPOmXf4DwwEQvNG1RpzWB-PY
Message-ID: <CAMgjq7D-xpzWz=v5jj76vuRRBJwaEkt-gJKaviJALLY7UX76cw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C061A459B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15493-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > Using a swapfile does have its benefits, though. For example, the
> > > virtual layer could act as an ordinary tier following YoungJun's
> > > design:
> > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.par=
k@lge.com/
> >
> > Hmm I didn't look too closely at this but I don't understand how
> > making it a swapfile helps with tiering? If anything, I think it makes
> > tiering more difficult. For tiering to work, we need an
> > abstraction/redirection layer, such that we don't need to update the
> > page tables (or shmem pagecache) if we demote/promote pages. That is
> > exactly the use case for a virtual swap layer. The page tables point
> > at a virtual swap ID and the backend could change transparently (e.g.
> > for zswap writeback, or tiering).
> >
> > If we make the virtual layer a swapfile, how do we demote/promote
> > without updating page tables?
> >
> > IOW, I think the whole reason we want a virtual layer is to separate
> > the backends, which would facilitate tiering. If the virtual layer is
> > itself a swapfile, wouldn't it become one of the tiers?
>
> That's exactly what I hoped, virtual layer being part of the tier.
> Tier could be set up per task / cgroup. So is the virtual tier.
>
> A standalone implementation of the virtual layer is more heavy than
> being a swapfile. Actually I think at this point, it is the word
> "swapfile" is misleading now. We may rename it to "swap mapping" or
> something. A swap mapping could be physical or virtual. Virtual
> mapping can realloc from physical ones (redirect), and swapoff of
> physical ones just read its data into virtual mapping's swap cache.
>
> I think it's actually functionally very similar to Nhat's design
> already from a high level, the only difference is we don't need
> standalone infra for virtual parts.
>
> For swapoff or migration you don't need to touch the page table, same
> as in this series, just update the virtual swap mapping to be cached
> or update the entry, it's identical to what this series is doing.

BTW it does look like file mapping. In the long term maybe we can
merge part of the swap mapping with file mapping again, not sure
though. Swap mapping is a bit different as it's integrated with
allocator, and previously it was reusing file mapping, but we had to
use a lot of strange techniques e.g. split the mapping to avoid lock
contention / special lookup routine / synchronization / handling
writeback in an entirely different way. Just an idea and reference
here.

