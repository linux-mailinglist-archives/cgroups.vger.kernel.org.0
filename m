Return-Path: <cgroups+bounces-10277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1310B879F3
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFDD7E6DE8
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F99241114;
	Fri, 19 Sep 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuNNIsq4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94999238C0F
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245998; cv=none; b=A2TehiUgeJAqQHl8ArlZjPQx/cdYbB1vLnlMcUahzZDO19UkKqcQIkplTp7z6OA8bh/TFer4xX7K8+HzHl16OSj6RSUourBdFrXJtLEXe0ezFGntoMhd8j35tYRIMjV+WN1ovakbk42pfM1QaDBCqT6Wlgy3Lw2vOwnJ10CZWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245998; c=relaxed/simple;
	bh=KIw6ZWu58UPeXZnaL50P3OddqSxMtJ092ldQDSK/q34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+J7hLIkXJoxQe1MgSyzscaDq/z92ZeW0kfmBi11ZmOj+FFL5v7dQ9fTWrokMjilysXnSvFc90Ad6A2ogpY6Wx9Xuq1wSIFUuRnURsm6qNjRjlyoJaLfmrau2U9rWbqm3Ffkz0vZ6+79d1gcynA/w+wawYqMViUAUKjHq0MxaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuNNIsq4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46897c60e38so332155e9.0
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758245995; x=1758850795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLWwqggp3K/TaMuP/qh+3dUHM74KL5ZFGLTQM4YRlUo=;
        b=GuNNIsq4YKRtk12K/sYq6uK7adgzWK7F7afNzhmkmnWVsu0F8S2uQ0PrTT+DjlAOLF
         hwprqQq0Paqp7Gk76nCBHbt3LQnlmMG8FmyQq4F5kp4CT6IaeZLUcASetX73DR/cqx3Q
         dbgrBAkJrI5HAcvwsNkP1WeocQHpZoKRlZiMx/otaTehFTRhJzPEzavfj9mk11n8SZc4
         pEXD7X1MRvBBY6eRPN18rvcJkUnhWJOJ6JhHFQ/OAfPVAYTwVgKpSWA3B1WW2ASo/enr
         3DQhi0rMXttFlB/qXheGX3vhQDAZsXmrRV3rPwg0PHEX5GjU+J/Hwy4p6UKWv8LzO6bp
         iaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245995; x=1758850795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLWwqggp3K/TaMuP/qh+3dUHM74KL5ZFGLTQM4YRlUo=;
        b=nRgtxQfD/HDfqLZFlx27kiKmevsb4U+PnObOxIS7wtzo/2gcRs+RSnk4nVtm+b/aWk
         aCH/y7FUc45aLNfvU0d176set01dS8XCYx6RMy7gkWXcXazyeoGf4G6GPtOJJxOAvIqr
         Z8aNna4MdDs4LqzpdMSzFy0lHl7X7uWrfWQgqJKYYeK97aBGLfTFP0P3hPCHVim1TjWl
         CLLe1dEznS2Roep5HYfCY3ggQ5MpuropuHwE/fA1y5FFHo6msdlPksVaosLM78V7n1VF
         z3hIfA/OzAr3mAhOjLVTUaRy5W6SiVdtXYfkB6s9pSwgwxcIaC9BOO+jSUaA5yi49WdS
         MZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs61FCiZ80cnlXABMKCdwl248NL/Eq6Wo3YGVG6WyjqL9dCvdtoN4rrGQsCjRkqHDDcMxEaeuI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Vb37fy2tpvLHzGnu1oBM9N0sXi5KLXnanRRmvabcwBup8v9S
	JeJM0q9mA7J00USCC+rfmZ1wWSIUMA+2OftbujrWR2vxKtXNuCz0ofLOzRBtNW5Yjj6f3DQ0dKa
	wYYIq8ryQXudbX3jjL/Ni4V21zD2bgyM=
X-Gm-Gg: ASbGncsBCDy75FYV9Gp1BXlLIQJGHK21HAfUoaYpbfFVmRIFBfITkMjWki7g8xaMSF7
	wbk+UH82G751oNGNm5ZGmw++1EOqnOyp8AuuX0f7tjjwQ4ONx5IuoCeor00eNkYzU8rRH0Qo31s
	H560grP2USZx2OyxX1bxiLAhNQ+h/ywrpW2wK0qzT4F0UGO8em+zwKu3QHTVbxvYjMxjfgbsUTa
	3gukXJaL3Kyh9+AGz0D8E5BmtjF9YIM1bH6
X-Google-Smtp-Source: AGHT+IGLUHNvVeU7x3xV9/sHYbwwni9HCE8NZCidCtCfno9QqZD0/k8AaMlh+DMF0H+c7wtm4oRSBiysUcySWCH78RQ=
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id
 5b1f17b1804b1-467eed8f915mr8129025e9.12.1758245994492; Thu, 18 Sep 2025
 18:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz> <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
 <ce3be467-4ff3-4165-a024-d6a3ed33ad0e@suse.cz> <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
In-Reply-To: <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 18:39:43 -0700
X-Gm-Features: AS18NWBlUth1kJvWS5JXtLwteu2b8Preo5gOd_kEK4OqVju9jJmrGXsODrzjcRM
Message-ID: <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Sep 18, 2025 at 12:06=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > On 9/17/25 20:38, Alexei Starovoitov wrote:
> > > On Wed, Sep 17, 2025 at 2:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > >>
> > >> Also I was curious to find out which path is triggered so I've put a
> > >> dump_stack() before the kmalloc_nolock call:
> > >>
> > >> [    0.731812][    T0] Call Trace:
> > >> [    0.732406][    T0]  __dump_stack+0x18/0x30
> > >> [    0.733200][    T0]  dump_stack_lvl+0x32/0x90
> > >> [    0.734037][    T0]  dump_stack+0xd/0x20
> > >> [    0.734780][    T0]  alloc_slab_obj_exts+0x181/0x1f0
> > >> [    0.735862][    T0]  __alloc_tagging_slab_alloc_hook+0xd1/0x330
> > >> [    0.736988][    T0]  ? __slab_alloc+0x4e/0x70
> > >> [    0.737858][    T0]  ? __set_page_owner+0x167/0x280
> > >> [    0.738774][    T0]  __kmalloc_cache_noprof+0x379/0x460
> > >> [    0.739756][    T0]  ? depot_fetch_stack+0x164/0x180
> > >> [    0.740687][    T0]  ? __set_page_owner+0x167/0x280
> > >> [    0.741604][    T0]  __set_page_owner+0x167/0x280
> > >> [    0.742503][    T0]  post_alloc_hook+0x17a/0x200
> > >> [    0.743404][    T0]  get_page_from_freelist+0x13b3/0x16b0
> > >> [    0.744427][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > >> [    0.745358][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > >> [    0.746290][    T0]  ? __next_zones_zonelist+0x26/0x60
> > >> [    0.747265][    T0]  __alloc_frozen_pages_noprof+0x143/0x1080
> > >> [    0.748358][    T0]  ? lock_acquire+0x8b/0x180
> > >> [    0.749209][    T0]  ? pcpu_alloc_noprof+0x181/0x800
> > >> [    0.750198][    T0]  ? sched_clock_noinstr+0x8/0x10
> > >> [    0.751119][    T0]  ? local_clock_noinstr+0x137/0x140
> > >> [    0.752089][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > >> [    0.753023][    T0]  alloc_slab_page+0xda/0x150
> > >> [    0.753879][    T0]  new_slab+0xe1/0x500
> > >> [    0.754615][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > >> [    0.755577][    T0]  ___slab_alloc+0xd79/0x1680
> > >> [    0.756469][    T0]  ? pcpu_alloc_noprof+0x538/0x800
> > >> [    0.757408][    T0]  ? __mutex_unlock_slowpath+0x195/0x3e0
> > >> [    0.758446][    T0]  __slab_alloc+0x4e/0x70
> > >> [    0.759237][    T0]  ? mm_alloc+0x38/0x80
> > >> [    0.759993][    T0]  kmem_cache_alloc_noprof+0x1db/0x470
> > >> [    0.760993][    T0]  ? mm_alloc+0x38/0x80
> > >> [    0.761745][    T0]  ? mm_alloc+0x38/0x80
> > >> [    0.762506][    T0]  mm_alloc+0x38/0x80
> > >> [    0.763260][    T0]  poking_init+0xe/0x80
> > >> [    0.764032][    T0]  start_kernel+0x16b/0x470
> > >> [    0.764858][    T0]  i386_start_kernel+0xce/0xf0
> > >> [    0.765723][    T0]  startup_32_smp+0x151/0x160
> > >>
> > >> And the reason is we still have restricted gfp_allowed_mask at this =
point:
> > >> /* The GFP flags allowed during early boot */
> > >> #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__=
GFP_FS))
> > >>
> > >> It's only lifted to a full allowed mask later in the boot.
> > >
> > > Ohh. That's interesting.
> > >
> > >> That means due to "kmalloc_nolock() is not supported on architecture=
s that
> > >> don't implement cmpxchg16b" such architectures will no longer get ob=
jexts
> > >> allocated in early boot. I guess that's not a big deal.
> > >>
> > >> Also any later allocation having its flags screwed for some reason t=
o not
> > >> have __GFP_RECLAIM will also lose its objexts. Hope that's also acce=
ptable.
> > >> I don't know if we can distinguish a real kmalloc_nolock() scope in
> > >> alloc_slab_obj_exts() without inventing new gfp flags or passing an =
extra
> > >> argument through several layers of functions.
> > >
> > > I think it's ok-ish.
> > > Can we add a check to alloc_slab_obj_exts() that sets allow_spin=3Dtr=
ue
> > > if we're in the boot phase? Like:
> > > if (gfp_allowed_mask !=3D __GFP_BITS_MASK)
> > >    allow_spin =3D true;
> > > or some cleaner way to detect boot time by checking slab_state ?
> > > bpf is not active during the boot and nothing should be
> > > calling kmalloc_nolock.
> >
> > Checking the gfp_allowed_mask should work. Slab state is already UP so =
won't
> > help, and this is not really about slab state anyway.
> > But whether worth it... Suren what do you think?
>
> Vlastimil's fix is correct. We definitely need __GFP_NO_OBJ_EXT when
> allocating an obj_exts vector, otherwise it will try to recursively
> allocate an obj_exts vector for obj_exts allocation.
>
> For the additional __GFP_BITS_MASK check, that sounds good to me as
> long as we add a comment on why that is there. Or maybe such a check
> deserves to be placed in a separate function similar to
> gfpflags_allow_{spinning | blocking}?

I would not. I think adding 'boot or not' logic to these two
will muddy the waters and will make the whole slab/page_alloc/memcg
logic and dependencies between them much harder to follow.
I'd either add a comment to alloc_slab_obj_exts() explaining
what may happen or add 'boot or not' check only there.
imo this is a niche, rare and special.

