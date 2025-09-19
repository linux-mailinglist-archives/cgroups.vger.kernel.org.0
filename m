Return-Path: <cgroups+bounces-10292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F284B8A27A
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A655A054C
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423C3148DC;
	Fri, 19 Sep 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jez4x7X1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5176313D71
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294111; cv=none; b=cgH7fqK2klaGR5COBm6NDYWbJJudt4TS9m2kYpf8CgYmxAGdkKkZFNUal0MtZ+uKxT4irFS9X7DoxEoDf5X2QITDmDoYAgcD3SVxeNBYD+2oW7rcpGCJKT/OLPW9CBIuYJYpW9RFS6uDLbOJ/WaaG3v/tKuvWkUrPOfjBZHBzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294111; c=relaxed/simple;
	bh=wi4ES0kK1PeTlxSFJk6bhN7E9AN+deonxTtypWb1ZEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgk3F6VI+a4o1+NKxX6HW0zNKnX03haDrsPdHzQKr4yrt1qNqERzp819j1JHgSPM86/oOd8sWlLR9NqRePqjl+ukFj0fym4gQvV48f0b7Lz8yLGqQ3cKrQm3JocSZXzI4louhflw92l1KUHX+3lSmBGOm3QQ39TPQITYR6Bxbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jez4x7X1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b4bcb9638aso424521cf.0
        for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294108; x=1758898908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd49/q/5YBCJxAFGP/L8ktabS8R9TywHti0W/ntbZ14=;
        b=Jez4x7X1k76icv38SPaEjCEGTQvmviXx2UoUGTf2QcKHyHZd8auJTweLSLc857tMr6
         8L/VeQNrwvhAt9sUz8CeAOIqHjoI6EBnpDUUiKZe+GXWt4HhyWWb8ZK45vGGbf8klFDn
         6WATYbO+BmjHnfInepaWJsMAo/IqfJHvKPSc3+zqGnw9UjR76qcIMRDBg52aBF7uoZJX
         OF+D4yQE/zn0ZYl9ODeCddXTsBuvV+pCxhlSxIKJxj63+OVwKsj2QHJD+tE2Xj8LW+wy
         1cfXcDjXf3Yv3oFV4oOabwgZiaII+c9b/A9EBMSs+ZeJF8lHyHyhbgj+lWUeBUg0HfM+
         L/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294108; x=1758898908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd49/q/5YBCJxAFGP/L8ktabS8R9TywHti0W/ntbZ14=;
        b=rXJ0aPz7zQmF5fVfrA3VTLICOTZ4D1bYC4THeE/OUrAffbA2hKfFD03cTQi/DGArWC
         mkivTvVadVgpv6xVJDYrlS3xU2MVy0Gp3dXYo1p36eqlWCzytOiU7J0xADSg9kgrCP72
         d09BWvcyKwNH+KLg4+VB3/lLZRmZdgaUPbOK3zWffT+JudtKPcbh2/GjvQ6lzRXwm8dh
         UqzWwynrtsapNgI223GLMrhxqlNNAGHPLIbE/usl3bSDyyCNMus8/yoFN4IEfVdw6ofu
         UqEcDzEd9SpyWxSgLvupaXBdI7qgr5MAAPQGqtFP/fvuoegV53dieQZjgWwA1e1OW5Ck
         M8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX3t50XL9ay7lpOPr8oi/81MIDmod4PIpEUI86voIfVVcQHQqLEoI8SGm+J3++KXzG/95Bf1wH7@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtpNKwfeqQdfdiHzLOsD2K+3vOyQKc2aUh9tiNt+PVMNqfOld
	t0tMnVk68rOy1Wd5k//HNp2cQZ7YrvjUE0Xtb1TwHjXEEuQJfhRfRoLWxmrpZrmSeX4tDyTIncG
	k3cWh8ONc4zPpx1KH/nP/+ItzFpf6mxoll+HHNk6L
X-Gm-Gg: ASbGncsrU/7a5GdGJUmk7l2iT9+i9xhhbrmIMA3iLygDu65Z4h0uWLdG18MqdAptCBQ
	WEFhXn0m64JnffLVmX7WQiGLbKIlopkQcMajluc1sfjsJ2emMwCXMkBZspzYrRhZHLzBes2qyLP
	3l3JTKlfHKSSPOH3FuUI2g1JHqcfSNgLdnSBAvAeg2M1b20vVNBzReDfnJ3EYnoICk/I0K8yNDm
	v9Yww==
X-Google-Smtp-Source: AGHT+IHQKWY6HNPV+dUIZl6mPbASDwCVYU/qUliIO+mvEsbanwTZHZDc0ajD82tEvxz5DM4rad1N9lGhmUa33cuVXW8=
X-Received: by 2002:ac8:5f84:0:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4b9d33b6432mr19618551cf.0.1758294107407; Fri, 19 Sep 2025
 08:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz> <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
 <ce3be467-4ff3-4165-a024-d6a3ed33ad0e@suse.cz> <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
 <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com>
In-Reply-To: <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Sep 2025 08:01:36 -0700
X-Gm-Features: AS18NWD12crNOmM4aEy96ofaHX5zWtBB8_S_SE5RNjFC2qJWezk2NctkV6nki6A
Message-ID: <CAJuCfpGA_YKuzHu0TM718LFHr92PyyKdD27yJVbtvfF=ZzNOfQ@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 7:49=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 12:06=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > >
> > > On 9/17/25 20:38, Alexei Starovoitov wrote:
> > > > On Wed, Sep 17, 2025 at 2:18=E2=80=AFAM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> > > >>
> > > >> Also I was curious to find out which path is triggered so I've put=
 a
> > > >> dump_stack() before the kmalloc_nolock call:
> > > >>
> > > >> [    0.731812][    T0] Call Trace:
> > > >> [    0.732406][    T0]  __dump_stack+0x18/0x30
> > > >> [    0.733200][    T0]  dump_stack_lvl+0x32/0x90
> > > >> [    0.734037][    T0]  dump_stack+0xd/0x20
> > > >> [    0.734780][    T0]  alloc_slab_obj_exts+0x181/0x1f0
> > > >> [    0.735862][    T0]  __alloc_tagging_slab_alloc_hook+0xd1/0x330
> > > >> [    0.736988][    T0]  ? __slab_alloc+0x4e/0x70
> > > >> [    0.737858][    T0]  ? __set_page_owner+0x167/0x280
> > > >> [    0.738774][    T0]  __kmalloc_cache_noprof+0x379/0x460
> > > >> [    0.739756][    T0]  ? depot_fetch_stack+0x164/0x180
> > > >> [    0.740687][    T0]  ? __set_page_owner+0x167/0x280
> > > >> [    0.741604][    T0]  __set_page_owner+0x167/0x280
> > > >> [    0.742503][    T0]  post_alloc_hook+0x17a/0x200
> > > >> [    0.743404][    T0]  get_page_from_freelist+0x13b3/0x16b0
> > > >> [    0.744427][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > >> [    0.745358][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > >> [    0.746290][    T0]  ? __next_zones_zonelist+0x26/0x60
> > > >> [    0.747265][    T0]  __alloc_frozen_pages_noprof+0x143/0x1080
> > > >> [    0.748358][    T0]  ? lock_acquire+0x8b/0x180
> > > >> [    0.749209][    T0]  ? pcpu_alloc_noprof+0x181/0x800
> > > >> [    0.750198][    T0]  ? sched_clock_noinstr+0x8/0x10
> > > >> [    0.751119][    T0]  ? local_clock_noinstr+0x137/0x140
> > > >> [    0.752089][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > >> [    0.753023][    T0]  alloc_slab_page+0xda/0x150
> > > >> [    0.753879][    T0]  new_slab+0xe1/0x500
> > > >> [    0.754615][    T0]  ? kvm_sched_clock_read+0xd/0x20
> > > >> [    0.755577][    T0]  ___slab_alloc+0xd79/0x1680
> > > >> [    0.756469][    T0]  ? pcpu_alloc_noprof+0x538/0x800
> > > >> [    0.757408][    T0]  ? __mutex_unlock_slowpath+0x195/0x3e0
> > > >> [    0.758446][    T0]  __slab_alloc+0x4e/0x70
> > > >> [    0.759237][    T0]  ? mm_alloc+0x38/0x80
> > > >> [    0.759993][    T0]  kmem_cache_alloc_noprof+0x1db/0x470
> > > >> [    0.760993][    T0]  ? mm_alloc+0x38/0x80
> > > >> [    0.761745][    T0]  ? mm_alloc+0x38/0x80
> > > >> [    0.762506][    T0]  mm_alloc+0x38/0x80
> > > >> [    0.763260][    T0]  poking_init+0xe/0x80
> > > >> [    0.764032][    T0]  start_kernel+0x16b/0x470
> > > >> [    0.764858][    T0]  i386_start_kernel+0xce/0xf0
> > > >> [    0.765723][    T0]  startup_32_smp+0x151/0x160
> > > >>
> > > >> And the reason is we still have restricted gfp_allowed_mask at thi=
s point:
> > > >> /* The GFP flags allowed during early boot */
> > > >> #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|=
__GFP_FS))
> > > >>
> > > >> It's only lifted to a full allowed mask later in the boot.
> > > >
> > > > Ohh. That's interesting.
> > > >
> > > >> That means due to "kmalloc_nolock() is not supported on architectu=
res that
> > > >> don't implement cmpxchg16b" such architectures will no longer get =
objexts
> > > >> allocated in early boot. I guess that's not a big deal.
> > > >>
> > > >> Also any later allocation having its flags screwed for some reason=
 to not
> > > >> have __GFP_RECLAIM will also lose its objexts. Hope that's also ac=
ceptable.
> > > >> I don't know if we can distinguish a real kmalloc_nolock() scope i=
n
> > > >> alloc_slab_obj_exts() without inventing new gfp flags or passing a=
n extra
> > > >> argument through several layers of functions.
> > > >
> > > > I think it's ok-ish.
> > > > Can we add a check to alloc_slab_obj_exts() that sets allow_spin=3D=
true
> > > > if we're in the boot phase? Like:
> > > > if (gfp_allowed_mask !=3D __GFP_BITS_MASK)
> > > >    allow_spin =3D true;
> > > > or some cleaner way to detect boot time by checking slab_state ?
> > > > bpf is not active during the boot and nothing should be
> > > > calling kmalloc_nolock.
> > >
> > > Checking the gfp_allowed_mask should work. Slab state is already UP s=
o won't
> > > help, and this is not really about slab state anyway.
> > > But whether worth it... Suren what do you think?
> >
> > Vlastimil's fix is correct. We definitely need __GFP_NO_OBJ_EXT when
> > allocating an obj_exts vector, otherwise it will try to recursively
> > allocate an obj_exts vector for obj_exts allocation.
> >
> > For the additional __GFP_BITS_MASK check, that sounds good to me as
> > long as we add a comment on why that is there. Or maybe such a check
> > deserves to be placed in a separate function similar to
> > gfpflags_allow_{spinning | blocking}?
>
> I would not. I think adding 'boot or not' logic to these two
> will muddy the waters and will make the whole slab/page_alloc/memcg
> logic and dependencies between them much harder to follow.
> I'd either add a comment to alloc_slab_obj_exts() explaining
> what may happen or add 'boot or not' check only there.
> imo this is a niche, rare and special.

Ok, comment it is then.
Will you be sending a new version or Vlastimil will be including that
in his fixup?

