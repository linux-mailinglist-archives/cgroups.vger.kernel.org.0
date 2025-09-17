Return-Path: <cgroups+bounces-10215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6FB815D4
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932EF4684EA
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF443002DA;
	Wed, 17 Sep 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efiezoTU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91130B524
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134337; cv=none; b=g3jNSZauA51yaRXdM1vXpef5FYLJFu6bduPmuMpK+SEgoeq/6n9IKrfw11OvGQJa2SYO5awQhZZXEoqrOrTkqUw1HKdC4nLKZ7Yu0iy13cbyEOn00SHn58cdsMmzmoiO8R7Krq1Qn7DrfahQ1dYcZQp4twiNJ4l93EQSdwmSW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134337; c=relaxed/simple;
	bh=bApZjDgNHu0DHYFMp6uEKVBzjQNP8g1j8ojQ1FfPa48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fExc1A/AT/NkPFLudhqkLamHloXGcTMgrHwbx8Knfj0L0LKmXkrhzJOvEkerobqKhBvfFIEw8PzXH6vATpZS+Bnu/nu726Ciyq3CrFBs//EdmEQx/cVSqaKhfTY0/1WjJUIsfIrilNAanNabcaCSnbjMsrmMd9gGZHNDlM05Csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efiezoTU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ea7af25f8aso27626f8f.0
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758134333; x=1758739133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSe+/0Ppv6md7i7Zvl8mHAv4aY3npVBA8JoXdsiKzcU=;
        b=efiezoTUmQQFWAM4TFBNejpWMfI457AEPV3n/yAIBt6KODD6aKgpH/v6HbGQdo/XqK
         pRomkl6BEGH5FI1Ld/y0lDGCTDh5PCJnKCCfXmj6P8HwBrHNK66b6Y1/W6hM4X03NhP3
         OeRqB29XnEkTn9bEDRcapejxRmhdKrrdgBDzuIyUc8k+WFw9YRoz+wm1FrEi1QAfwn00
         lvZxn5EXXb4IcpyNf8FVbMAwK3jPoAD3wg+3qzSW1fqJshXN1AoG1lCljiCuXyBs2KD8
         /sJUCp1MS+HyFfQYw32mzQArHWEnkOeOeTlsc8S2OcWKZhkoZcT1kqTy319jih6aXY7X
         /d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134333; x=1758739133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSe+/0Ppv6md7i7Zvl8mHAv4aY3npVBA8JoXdsiKzcU=;
        b=fbZELvWqwxorEbuinDKBZEi09HhWSt4303TIWQtDNu5npx8YNHqWtwGncKwvrTWISn
         9fdGhcwUI0eFPSGdLB4CL2DQ3PvFlvIzgST8Fz+lWKpGF7hCei6aae1gopzoGjTIg/ti
         bxemwV9w30QEfmOcw5JqjrAg1s8rQ+m/6lXg/mhB7H/heIPvk97qSHULp71uDg3TNzTu
         P+TT73OkYy3mgnf1N4FirCQMQdYrp62FTmKk/jwZB1BJ6InNi6bYyTEBrM4zadxTg887
         LeqQiBva2Jg4oCro6dN+KBCIIMjRRXmPBDBubbB7rh5RkM5dTxnegFSRy1JXjz+EMXen
         L+uw==
X-Forwarded-Encrypted: i=1; AJvYcCW7rNhv5XpY4TIMJ8xh1Y5Bt7VL8kWRcM5TGWMgzgM8TH1c7OWjYPqtVxXIEeazHrawCz5XMI6Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxw6+Mb+SgET7RSgodCREJlsV0UoeHApJvKDdb7r/b51vZ+2g
	iIrOIvz87NY0QE/eizW6vwbmV+oK24AR8z/kCEijLyY1pzq00Kerxv5b5XrPoLBJXf5r/Y9iwqa
	sT/GddIdOh1rwKebRUxQ5lp3wzZPHq26fYEGI
X-Gm-Gg: ASbGncuzYPs4B4GEQiMoaMIushBRcLmWZpAoaux91b9mML98mnakTdbRTZ/QJrlGO22
	P38KgztyqnBpfKtJM+CAU3PnqKck1je/1dUsIKH3B4oK8MI8BYB2uaD3hNkQKNY1V0k7TWc39SB
	EGbswEHPxyQil2prByBBunB7Ao5m6xGi531g5EVC+erF1gu21+0cE77QU1Rr65qRGz3EtLKIckG
	HXtxwlNMhW71Bqcq9dNOtom1v02gInb6+J8tuI3fXaUd7g=
X-Google-Smtp-Source: AGHT+IH65vHoAWQlQ3QxZg0jgRGWoc8ZKpbjQvB+6DwLthXrDAHZtbRQCJn4p44AxNGvT6W9g4Y7hgPMfFj54oU5Po4=
X-Received: by 2002:a5d:5d83:0:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-3ecdf9b19b2mr3358067f8f.5.1758134332921; Wed, 17 Sep 2025
 11:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz>
In-Reply-To: <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 11:38:41 -0700
X-Gm-Features: AS18NWCa5a8ExJYAmvo8581Fjoj9FqLlIlKIfMzQMBKR4Zv-pgzwhyjut6uI-zc
Message-ID: <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/17/25 10:03, Vlastimil Babka wrote:
> > On 9/17/25 07:01, kernel test robot wrote:
> >>
> >>
> >> Hello,
> >>
> >> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address=
" on:
> >>
> >> commit: db93cdd664fa02de9be883dd29343b21d8fc790f ("slab: Introduce kma=
lloc_nolock() and kfree_nolock().")
> >> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git maste=
r
> >>
> >> in testcase: boot
> >>
> >> config: i386-randconfig-062-20250913
> >> compiler: clang-20
> >> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
> >>
> >> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
> Managed to reproduce locally and my suggested fix works so I'm going to f=
old
> it unless there's objections or better suggestions.

Thanks for the fix. Not sure what I was thinking. __GFP_NO_OBJ_EXT
is obviously needed there.

> Also I was curious to find out which path is triggered so I've put a
> dump_stack() before the kmalloc_nolock call:
>
> [    0.731812][    T0] Call Trace:
> [    0.732406][    T0]  __dump_stack+0x18/0x30
> [    0.733200][    T0]  dump_stack_lvl+0x32/0x90
> [    0.734037][    T0]  dump_stack+0xd/0x20
> [    0.734780][    T0]  alloc_slab_obj_exts+0x181/0x1f0
> [    0.735862][    T0]  __alloc_tagging_slab_alloc_hook+0xd1/0x330
> [    0.736988][    T0]  ? __slab_alloc+0x4e/0x70
> [    0.737858][    T0]  ? __set_page_owner+0x167/0x280
> [    0.738774][    T0]  __kmalloc_cache_noprof+0x379/0x460
> [    0.739756][    T0]  ? depot_fetch_stack+0x164/0x180
> [    0.740687][    T0]  ? __set_page_owner+0x167/0x280
> [    0.741604][    T0]  __set_page_owner+0x167/0x280
> [    0.742503][    T0]  post_alloc_hook+0x17a/0x200
> [    0.743404][    T0]  get_page_from_freelist+0x13b3/0x16b0
> [    0.744427][    T0]  ? kvm_sched_clock_read+0xd/0x20
> [    0.745358][    T0]  ? kvm_sched_clock_read+0xd/0x20
> [    0.746290][    T0]  ? __next_zones_zonelist+0x26/0x60
> [    0.747265][    T0]  __alloc_frozen_pages_noprof+0x143/0x1080
> [    0.748358][    T0]  ? lock_acquire+0x8b/0x180
> [    0.749209][    T0]  ? pcpu_alloc_noprof+0x181/0x800
> [    0.750198][    T0]  ? sched_clock_noinstr+0x8/0x10
> [    0.751119][    T0]  ? local_clock_noinstr+0x137/0x140
> [    0.752089][    T0]  ? kvm_sched_clock_read+0xd/0x20
> [    0.753023][    T0]  alloc_slab_page+0xda/0x150
> [    0.753879][    T0]  new_slab+0xe1/0x500
> [    0.754615][    T0]  ? kvm_sched_clock_read+0xd/0x20
> [    0.755577][    T0]  ___slab_alloc+0xd79/0x1680
> [    0.756469][    T0]  ? pcpu_alloc_noprof+0x538/0x800
> [    0.757408][    T0]  ? __mutex_unlock_slowpath+0x195/0x3e0
> [    0.758446][    T0]  __slab_alloc+0x4e/0x70
> [    0.759237][    T0]  ? mm_alloc+0x38/0x80
> [    0.759993][    T0]  kmem_cache_alloc_noprof+0x1db/0x470
> [    0.760993][    T0]  ? mm_alloc+0x38/0x80
> [    0.761745][    T0]  ? mm_alloc+0x38/0x80
> [    0.762506][    T0]  mm_alloc+0x38/0x80
> [    0.763260][    T0]  poking_init+0xe/0x80
> [    0.764032][    T0]  start_kernel+0x16b/0x470
> [    0.764858][    T0]  i386_start_kernel+0xce/0xf0
> [    0.765723][    T0]  startup_32_smp+0x151/0x160
>
> And the reason is we still have restricted gfp_allowed_mask at this point=
:
> /* The GFP flags allowed during early boot */
> #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_F=
S))
>
> It's only lifted to a full allowed mask later in the boot.

Ohh. That's interesting.

> That means due to "kmalloc_nolock() is not supported on architectures tha=
t
> don't implement cmpxchg16b" such architectures will no longer get objexts
> allocated in early boot. I guess that's not a big deal.
>
> Also any later allocation having its flags screwed for some reason to not
> have __GFP_RECLAIM will also lose its objexts. Hope that's also acceptabl=
e.
> I don't know if we can distinguish a real kmalloc_nolock() scope in
> alloc_slab_obj_exts() without inventing new gfp flags or passing an extra
> argument through several layers of functions.

I think it's ok-ish.
Can we add a check to alloc_slab_obj_exts() that sets allow_spin=3Dtrue
if we're in the boot phase? Like:
if (gfp_allowed_mask !=3D __GFP_BITS_MASK)
   allow_spin =3D true;
or some cleaner way to detect boot time by checking slab_state ?
bpf is not active during the boot and nothing should be
calling kmalloc_nolock.

