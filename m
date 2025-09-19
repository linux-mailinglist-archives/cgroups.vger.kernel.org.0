Return-Path: <cgroups+bounces-10298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B7AB8AEC9
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01287C2D6B
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0870214A93;
	Fri, 19 Sep 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmdyVVM6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E360B8A
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306734; cv=none; b=MY7o+ov/k09DTk82ofnRFJlBGxdQ+7Bnyw2NNikicqO1+t4i48Xgtbr1XjVnqI/xRZsTJJPh4UWhMapXhtqtNWgyYZPNOOKdbjfvahbPZNVAZbURpI+fd4B3j8QD2YEXseS0HaX+vZzogkZWB+xQNkwjfx1vGRrV4DvQOzxzP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306734; c=relaxed/simple;
	bh=3ViMnQZvMw/PVfgt6tOZ2gE26gfqdnyhKLJT1uzuiiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1+SNKSP/+b2noDH4Iq8aFVWLTeCouGIx0uQfGXiLyxAXBSUO4BJ1YZmmxrLgwd/iJdDMMUYSnMS1a9pQ/GnhRPL+FIlybQ9IO4FNR+F0ZV5XA6VUzzKhbeNkUtwwj8+DJG9XNFO7XT0zDSNSIEpv79rDWz1krhGhSu5jfvCY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmdyVVM6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1655175f8f.3
        for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306731; x=1758911531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNz2rvWdWurkAjYnYhECzBshCI3+0s6yD1fA4kNT29Q=;
        b=CmdyVVM6SuU0NGT09gnOWq1piDekA0BWWdVUtlkYtRBFfa//8/wljKSaun/0Chn6QR
         BqOh3bkdOaD+41Z1CwnDlRyx64hVMFimTrjTRTFj2lUjoeA1DUQturT04H2Sa+lN8XYL
         LU6JjPvGa7rItKd4DXChSK9/1bFGLRoQwtkMXInw3nlxWOTbI+zpdxQICy2YzWM3A4Mm
         2BSUVC2ObEi4m51ZD/vC47lFUWe4FgRXJK//zknpYNQrjkBKKJj91ViOx21XZaDIL1df
         gzdM3CgDxLeKNQB2lNtT8PkrqIQKKGAEdhmF7nTr04RcXReD56PS+GiDDFWLUF3MP7x7
         GL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306731; x=1758911531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNz2rvWdWurkAjYnYhECzBshCI3+0s6yD1fA4kNT29Q=;
        b=lonibs63pYf5N9ArEgXjJf2GcV1Gd9bX7QUiKZHF/N1GP4tWXUDOdEcELbjtOafTip
         69DwgdVL1GTozBUmUn4ts9EOyfov/RxsUQrVEfeezCM8uNK27nSH/3WMWlyI14enGaQ0
         eH/VdqNuDGJPJOzOsh/IexyR9CV1FczO1AFowoFGstyNwDT92skDcEC7Mxtg864R/Ici
         KGylVFj8TMUxrUcbkkglaVLHJJRatz8MRXJy4gLZtgHSWVyqdCQ0XiDZqAUgb1LPCHAF
         Hoti/VCot+Y82RhlD7Vb/FmEf8aNYOiuyTyf4S2b3b4BmqNbetcUJnKILcZ8oDOehNG2
         zmYA==
X-Forwarded-Encrypted: i=1; AJvYcCXoV4s8lLAFWf8NX6XDFidnDp0SaD04YcIe1L2VlyDcz3xp2BAmi1GB2FFeKTt7DU6POfBe5Sji@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xf36vxrLQkQ7EV94tateKwo3G70rs5yd0E1J26iYOB65iZsq
	Jv9ufaMi0+et/qqf/hZ5aLoLeEegzWwWrDKhBSQHzREBT2AYI+SWLcbOHrZILJeKuK0OFmOEL7b
	QYBqm/g1cQKz4ZeNj4Ktvyi+3GJLDx+0=
X-Gm-Gg: ASbGnctPmFiavXRwgam/KzJCXaDnEuzhUBX59hxGtKOlVsNsPn2SxYn8sS4QcYfC8n4
	3C89WW58WkJPJaa4+THni8EDL2AWPS+s2jPvb2RvmUl4g1INoKObyWHGG2LXIJ4CIlBTPQLLWIn
	a6E45k5Q6iWdYMMxXtZ+95iwXY6ADUZp16HS4WwSodsrKFIfYJMDPWZkaMKYFTgaX8hmqYgJdw8
	hcBaeJXX01yCGx1BlfUQ0g=
X-Google-Smtp-Source: AGHT+IE1qLgPZ2JZjML9mfB4gOIrZqCWSfRd0LbOWc+PJ+zRKBIhXbuoNJMp3mTSX/to1tTNSiq+a5JIlxqbwS6zv+k=
X-Received: by 2002:a05:6000:2486:b0:3ed:f690:a390 with SMTP id
 ffacd0b85a97d-3ee8481fdffmr3766244f8f.40.1758306730884; Fri, 19 Sep 2025
 11:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz> <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
 <ce3be467-4ff3-4165-a024-d6a3ed33ad0e@suse.cz> <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
 <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com> <CAJuCfpGA_YKuzHu0TM718LFHr92PyyKdD27yJVbtvfF=ZzNOfQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGA_YKuzHu0TM718LFHr92PyyKdD27yJVbtvfF=ZzNOfQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 11:31:57 -0700
X-Gm-Features: AS18NWDr8VuH5ucHYn2ibLVBASY5zct8WHDo7Mc0mqgDvlFRZ593jDOgzN6t5y4
Message-ID: <CAADnVQKt5YVKiVHmoB7fZsuMuD=1+bMYvCNcO0+P3+5rq9JXVw@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:01=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Sep 18, 2025 at 6:39=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 7:49=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 12:06=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > > >
> > > > On 9/17/25 20:38, Alexei Starovoitov wrote:
> > > > > On Wed, Sep 17, 2025 at 2:18=E2=80=AFAM Vlastimil Babka <vbabka@s=
use.cz> wrote:
> > > > >>
> > > > >> Also I was curious to find out which path is triggered so I've p=
ut a
> > > > >> dump_stack() before the kmalloc_nolock call:
> > > > >>
> > > > >> [    0.731812][    T0] Call Trace:
> > > > >> [    0.732406][    T0]  __dump_stack+0x18/0x30
> > > > >> [    0.733200][    T0]  dump_stack_lvl+0x32/0x90
> > > > >> [    0.734037][    T0]  dump_stack+0xd/0x20
> > > > >> [    0.734780][    T0]  alloc_slab_obj_exts+0x181/0x1f0
> > > > >> [    0.735862][    T0]  __alloc_tagging_slab_alloc_hook+0xd1/0x3=
30
> > > > >> [    0.736988][    T0]  ? __slab_alloc+0x4e/0x70
> > > > >> [    0.737858][    T0]  ? __set_page_owner+0x167/0x280
> > > > >> [    0.738774][    T0]  __kmalloc_cache_noprof+0x379/0x460
> > > > >> [    0.739756][    T0]  ? depot_fetch_stack+0x164/0x180
> > > > >> [    0.740687][    T0]  ? __set_page_owner+0x167/0x280
> > > > >> [    0.741604][    T0]  __set_page_owner+0x167/0x280
> > > > >> [    0.742503][    T0]  post_alloc_hook+0x17a/0x200
> > > > >> [    0.743404][    T0]  get_page_from_freelist+0x13b3/0x16b0
> > > > >> [    0.744427][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > > >> [    0.745358][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > > >> [    0.746290][    T0]  ? __next_zones_zonelist+0x26/0x60
> > > > >> [    0.747265][    T0]  __alloc_frozen_pages_noprof+0x143/0x1080
> > > > >> [    0.748358][    T0]  ? lock_acquire+0x8b/0x180
> > > > >> [    0.749209][    T0]  ? pcpu_alloc_noprof+0x181/0x800
> > > > >> [    0.750198][    T0]  ? sched_clock_noinstr+0x8/0x10
> > > > >> [    0.751119][    T0]  ? local_clock_noinstr+0x137/0x140
> > > > >> [    0.752089][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > > >> [    0.753023][    T0]  alloc_slab_page+0xda/0x150
> > > > >> [    0.753879][    T0]  new_slab+0xe1/0x500
> > > > >> [    0.754615][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > > >> [    0.755577][    T0]  ___slab_alloc+0xd79/0x1680
> > > > >> [    0.756469][    T0]  ? pcpu_alloc_noprof+0x538/0x800
> > > > >> [    0.757408][    T0]  ? __mutex_unlock_slowpath+0x195/0x3e0
> > > > >> [    0.758446][    T0]  __slab_alloc+0x4e/0x70
> > > > >> [    0.759237][    T0]  ? mm_alloc+0x38/0x80
> > > > >> [    0.759993][    T0]  kmem_cache_alloc_noprof+0x1db/0x470
> > > > >> [    0.760993][    T0]  ? mm_alloc+0x38/0x80
> > > > >> [    0.761745][    T0]  ? mm_alloc+0x38/0x80
> > > > >> [    0.762506][    T0]  mm_alloc+0x38/0x80
> > > > >> [    0.763260][    T0]  poking_init+0xe/0x80
> > > > >> [    0.764032][    T0]  start_kernel+0x16b/0x470
> > > > >> [    0.764858][    T0]  i386_start_kernel+0xce/0xf0
> > > > >> [    0.765723][    T0]  startup_32_smp+0x151/0x160
> > > > >>
> > > > >> And the reason is we still have restricted gfp_allowed_mask at t=
his point:
> > > > >> /* The GFP flags allowed during early boot */
> > > > >> #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_I=
O|__GFP_FS))
> > > > >>
> > > > >> It's only lifted to a full allowed mask later in the boot.
> > > > >
> > > > > Ohh. That's interesting.
> > > > >
> > > > >> That means due to "kmalloc_nolock() is not supported on architec=
tures that
> > > > >> don't implement cmpxchg16b" such architectures will no longer ge=
t objexts
> > > > >> allocated in early boot. I guess that's not a big deal.
> > > > >>
> > > > >> Also any later allocation having its flags screwed for some reas=
on to not
> > > > >> have __GFP_RECLAIM will also lose its objexts. Hope that's also =
acceptable.
> > > > >> I don't know if we can distinguish a real kmalloc_nolock() scope=
 in
> > > > >> alloc_slab_obj_exts() without inventing new gfp flags or passing=
 an extra
> > > > >> argument through several layers of functions.
> > > > >
> > > > > I think it's ok-ish.
> > > > > Can we add a check to alloc_slab_obj_exts() that sets allow_spin=
=3Dtrue
> > > > > if we're in the boot phase? Like:
> > > > > if (gfp_allowed_mask !=3D __GFP_BITS_MASK)
> > > > >    allow_spin =3D true;
> > > > > or some cleaner way to detect boot time by checking slab_state ?
> > > > > bpf is not active during the boot and nothing should be
> > > > > calling kmalloc_nolock.
> > > >
> > > > Checking the gfp_allowed_mask should work. Slab state is already UP=
 so won't
> > > > help, and this is not really about slab state anyway.
> > > > But whether worth it... Suren what do you think?
> > >
> > > Vlastimil's fix is correct. We definitely need __GFP_NO_OBJ_EXT when
> > > allocating an obj_exts vector, otherwise it will try to recursively
> > > allocate an obj_exts vector for obj_exts allocation.
> > >
> > > For the additional __GFP_BITS_MASK check, that sounds good to me as
> > > long as we add a comment on why that is there. Or maybe such a check
> > > deserves to be placed in a separate function similar to
> > > gfpflags_allow_{spinning | blocking}?
> >
> > I would not. I think adding 'boot or not' logic to these two
> > will muddy the waters and will make the whole slab/page_alloc/memcg
> > logic and dependencies between them much harder to follow.
> > I'd either add a comment to alloc_slab_obj_exts() explaining
> > what may happen or add 'boot or not' check only there.
> > imo this is a niche, rare and special.
>
> Ok, comment it is then.
> Will you be sending a new version or Vlastimil will be including that
> in his fixup?

Whichever way. I can, but so far Vlastimil phrasing of comments
were much better than mine :) So I think he can fold what he prefers.

