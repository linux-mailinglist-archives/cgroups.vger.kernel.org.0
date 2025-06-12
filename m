Return-Path: <cgroups+bounces-8510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55109AD7D9D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA013B594C
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2822E3F0;
	Thu, 12 Jun 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9c9+1mY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B372253B0;
	Thu, 12 Jun 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763987; cv=none; b=bJ4i86/7qgINvC85Y47VWiCnCOYBtuVkWzW9IKZtSnVgxgISjuxq5Jrg0g9fI5uAWR466kE5ozvC7fqymxnE/oztlSSKuBpQOjWIcQjirmbtRjMJDkVA13gfxnFB32VsyMxcWMK1CwnR36omzkwMgECUnIatcu7YAaMMPtwKEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763987; c=relaxed/simple;
	bh=YssUD+NCmWJwb33yCMf6hXDzVKxpytfHKqQNCavr3Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgtpR70Dr1uoanl9QIjHf69gathUbMO6/5TaiXaxM0VFdwBgfYO0VSrXuD/QZ7jL5k+AI3UPwllQ0/hj4ex6X4Z3ym3niB7rcs+LfyDeY0QLdjCONzqeIfnBi0ig//6mZ8KfhxSnNhWh+yn4VCtKKat59OpzVUPe4IDg9++f9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9c9+1mY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d09f11657cso144999385a.0;
        Thu, 12 Jun 2025 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763984; x=1750368784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W0E+0erWFRI6IuIwCEM9TnSMgthsjepghVvZBJq5Ag=;
        b=k9c9+1mYsdUVuHbXxNXUN4AcD7fl8UqBAn1WDJeqlCEOgxxOdh0EZ6XDyVhWNFWE7T
         lKQ+GYQi/nfG2e8JTkvdNILAAuLIuwCZxiNiWLvhReq+am639IFdQdmlZBhx1xBY9mfa
         lTZ2Oy1EEpHfgAk5lRGcJlDRbiArqe6S0EhwlJLalXcfOtL8rvgOlWYzgfKeKh8CmqLg
         IItS7S5DYW8juL2jWxD24iWk+y12rFp2NACTbIKi06EBg/4EmwfrGlU6nRX3ruHccZNU
         t5GE6jfilaMxeAUdCPxq8/j1vADnkt/X4f2KrdE5n/LYgoulNEMANQdYcyBy3lRm3E+O
         XXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763984; x=1750368784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W0E+0erWFRI6IuIwCEM9TnSMgthsjepghVvZBJq5Ag=;
        b=k/tNvAJnVRUPtQuCdDBtCx9JhmXogMa+8WnY8u0ZTcTjUjB8+eWb3ZLTFQ7N0ocjjs
         7CPG213aDcfX4bIaV/8vmbg8L6Q8vx9ckRhrvWcfb49HBbWq4XUpe1lOKy+s98i7QaMh
         TMkaXOISXcO0kRfv1ssnfMoa3q76HC0XPYaDWG2ClkhhrOZ/Jh7PpSgrZ8U3pzoALpjM
         V0yIXfRKPePrj6YD9QWyRRoOXVodIBPPvHslUAPsrIJZw53abBY2IcPYFTbMut/ldjlc
         HHnjj/PbtNEvcR0K5vTs1PSE7M+HRSI3WH8aHubSYyfvU7S/Iqdq8Szs1TjiToreC4Pq
         vtGw==
X-Forwarded-Encrypted: i=1; AJvYcCVB3NQSka6kFc4m5Zxs3ru9Db11cJxfQEEvggz0vwUFOTWXYYn09vchzDjCGoSvoy/KyUvTlYEwOeWz/XOC@vger.kernel.org, AJvYcCXAZbpRXQNU4CznrQxl7+qDbjTnUTp8m2WLVjQdjEKm6iOkgMYUbxm4rYrp0SynG0n5mPUHURfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrN0osRk89pzQJtV2V7CsRRGit962FRZvBiAT94dzQtmCNu+b
	1UFYkdSC5ilQyflFzidvkBXYIX2uC7CAK59HHcH+EaO4l5DutXSlovW+nLDAoYy2U/KKyj5Z5mj
	8cLrbqbJsvPuM9CL4iR0lQ/tZqvkmAuc=
X-Gm-Gg: ASbGnctg9iF266RUdEsfIi4a5anKTZi73IcBhuKNiQQOojTgQZYKBHPglYBplJH8JV/
	zzY+bTxxWmqPkf+i/aowu7sEYiU/uMY7/eyDWvJTNtYjuKV1GkLheBHbX5vz2ByYoKYG9f0AkvU
	ple8pk65wd+x8nJ6JKSv2aMF1V+fibgWeM4aQnI/iwMz0EQ1I2R8zx/fdz6gw=
X-Google-Smtp-Source: AGHT+IHzFi+Yhlfe3OfvbdCP6olLDf/Vj/PEhdMIhOfhpXE3X2YdVUC/TGPx3vhfOdJdkc4ZxsUiIIWnYNlXs0IovoQ=
X-Received: by 2002:ad4:4ea7:0:b0:6f8:af2b:8ba4 with SMTP id
 6a1803df08f44-6fb3e602d09mr6664676d6.21.1749763984434; Thu, 12 Jun 2025
 14:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com> <CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com>
In-Reply-To: <CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Jun 2025 14:32:53 -0700
X-Gm-Features: AX0GCFtGOh_XJ_ZJGj3ooDLvZL6D9FGFouUhOscf4aRJ6ZvEyKWTCl2MLFPzvLI
Message-ID: <CAKEwX=OLqqvXCqBcTotAAWWx=dqLr9xk-Nw-=Hh5yUVZokzXgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm/swap, memcg: Support per-cgroup swap device prioritization
To: Kairui Song <ryncsn@gmail.com>
Cc: youngjun.park@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Jun 12, 2025 at 6:38=E2=80=AFPM <youngjun.park@lge.com> wrote:
> >
> > From: Youngjun Park <youngjun.park@lge.com>
> >
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I am a kernel developer working on platforms deployed on commercial con=
sumer devices.
> > Due to real-world product requirements, needed to modify the Linux kern=
el to support
> > a new swap management mechanism. The proposed mechanism allows assignin=
g different swap
> > priorities to swap devices per cgroup.
> > I believe this mechanism can be generally useful for similar constraine=
d-device scenarios
> > and would like to propose it for upstream inclusion and solicit feedbac=
k from the community.

We're mostly just using zswap and disk swap, for now, so I don't have
too much input for this.

Kairui, would this design satisfy your zram use case as well?

> >
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Core requirement was to improve application responsiveness and loading =
time, especially
> > for latency critical applications, without increasing RAM or storage ha=
rdware resources.
> > Device constraints:
> >   - Linux-based embedded platform
> >   - Limited system RAM
> >   - Small local swap
> >   - No option to expand RAM or local swap
> > To mitigate this, we explored utilizing idle RAM and storage from nearb=
y devices as remote
> > swap space. To maximize its effectiveness, we needed the ability to con=
trol which swap devices
> > were used by different cgroups:
> >   - Assign faster local swap devices to latency critical apps
> >   - Assign remote swap devices to background apps
> > However, current Linux kernel swap infrastructure does not support per-=
cgroup swap device
> > assignment.
> > To solve this, I propose a mechanism to allow each cgroup to specify it=
s own swap device
> > priorities.
> >
> > Evaluated Alternatives
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. **Per-cgroup dedicated swap devices**
> >    - Previously proposed upstream [1]
> >    - Challenges in managing global vs per-cgroup swap state
> >    - Difficult to integrate with existing memory.limit / swap.max seman=
tics
> > 2. **Multi-backend swap device with cgroup-aware routing**
> >    - Considered sort of layering violation (block device cgroup awarene=
ss)
> >    - Swap devices are commonly meant to be physical block devices.
> >    - Similar idea mentioned in [2]
> > 3. **Per-cgroup swap device enable/disable with swap usage contorl**
> >    - Expand swap.max with zswap.writeback usage
> >    - Discussed in context of zswap writeback [3]
> >    - Cannot express arbitrary priority orderings
> >     (e.g. swap priority A-B-C on cgroup C-A-B impossible)
> >    - Less flexible than per-device priority approach
> > 4. **Per-namespace swap priority configuration**
> >    - In short, make swap namespace for swap device priority
> >    - Overly complex for our use case
> >    - Cgroups are the natural scope for this mechanism
> >
> > Based on these findings, we chose to prototype per-cgroup swap priority=
 configuration
> > as the most natural, least invasive extension of the existing kernel me=
chanisms.
> >
> > Design and Semantics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Each swap device gets a unique ID at `swapon` time
> > - Each cgroup has a `memory.swap.priority` interface:
> >   - Show unique ID by memory.swap.priority interface
> >   - Format: `unique_id:priority,unique_id:priority,...`
> >   - All currently-active swap devices must be listed
> >   - Priorities follow existing swap infrastructure semantics
> > - The interface is writeable and updatable at runtime
> > - A priority configuration can be reset via `echo "" > memory.swap.prio=
rity`
> > - Swap on/off events propagate to all cgroups with priority configurati=
ons
> >
> > Example Usage
> > -------------
> > # swap device on
> > $ swapon
> > NAME      TYPE      SIZE USED PRIO
> > /dev/sdb  partition 300M  0B   10
> > /dev/sdc  partition 300M  0B    5
> >
> > # assign custom priorities in a cgroup
> > $ echo "1:5,2:10" > memory.swap.priority
> > $ cat memory.swap.priority
> > Active
> > /dev/sdb  unique:1  prio:5
> > /dev/sdc  unique:2  prio:10
> >
> > # adding new swap device later
> > $ swapon /dev/sdd --priority -1
> > $ cat memory.swap.priority
> > Active
> > /dev/sdb  unique:1  prio:5
> > /dev/sdc  unique:2  prio:10
> > /dev/sdd  unique:3  prio:-2
> >
> > # reset cgroup priority
> > $ echo "" > memory.swap.priority
> > $ cat memory.swap.priority
> > Inactive
> > /dev/sdb  unique:1  prio:10
> > /dev/sdc  unique:2  prio:5
> > /dev/sdd  unique:3  prio:-2
> >
> > Implementation Notes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The items mentioned below are to be considered during the next patch wo=
rk.
> >
> > - Workaround using per swap cpu cluster as before
> > - Priority propgation of child cgroup
> > - And other TODO, XXX
> > - Refactoring for reviewability and maintainability, comprehensive test=
ing
> >   and performance evaluation
>
> Hi Youngjun,
>
> Interesting idea. For your current approach, I think all we need is
> per-cgroup swap meta info structures (and infrastures for maintaining
> and manipulating them).

Agreed.

>
> So we have a global version and a cgroup version of "plist, next
> cluster list, and maybe something else", right? And then
> once the allocator is folio aware it can just prefer the cgroup ones
> (as I mentioned in another reply) reusing all the same other
> routines. Changes are minimal, the cgroup swap meta infos
> and control plane are separately maintained.
>
> It seems aligned quite well with what I wanted to do, and can be done
> in a clean and easy to maintain way.
>
> Meanwhile with virtual swap, things could be even more flexible, not
> only changing the priority at swapout time, it will also provide
> capabilities to migrate and balance devices adaptively, and solve long
> term issues like mTHP fragmentation and min-order swapout etc..

Agreed.

>
> Maybe they can be combined, like maybe cgroup can be limited to use
> the virtual device or physical ones depending on priority. Seems all
> solvable. Just some ideas here.

100%

>
> Vswap can cover the priority part too. I think we might want to avoid
> duplicated interfaces.

Yeah as long as we have a reasonable cgroup interface, we can always
change the implementation later. We can move things to virtual swap,
etc. at a latter time.

>
> So I'm just imagining things now, will it be good if we have something
> like (following your design):
>
> $ cat memcg1/memory.swap.priority
> Active
> /dev/vswap:(zram/zswap? with compression params?) unique:0 prio:5
>
> $ cat memcg2/memory.swap.priority
> Active
> /dev/vswap:/dev/nvme1  unique:1  prio:5
> /dev/vswap:/dev/nvme2  unique:2  prio:10
> /dev/vswap:/dev/vda  unique:3  prio:15
> /dev/sda  unique:4  prio:20
>
> $ cat memcg3/memory.swap.priority
> Active
> /dev/vda  unique:3  prio:5
> /dev/sda  unique:4  prio:15
>
> Meaning memcg1 (high priority) is allowed to use compressed memory
> only through vswap, and memcg2 (mid priority) uses disks through vswap
> and fallback to HDD. memcg3 (low prio) is only allowed to use slow
> devices.
>
> Global fallback just uses everything the system has. It might be over
> complex though?

Sounds good to me.

>
>
> >
> > Future Work
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > These are items that would benefit from further consideration
> > and potential implementation.
> >
> > - Support for per-process or anything else swap prioritization

This might be too granular.


> > - Optional usage limits per swap device (e.g., ratio, max bytes)
> > - Generalizing the interface beyond cgroups
> >
> > References
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://lkml.iu.edu/hypermail/linux/kernel/1404.0/02530.html
> > [2] https://lore.kernel.org/linux-mm/CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejB=
kiwFHgy9uMk-F8Y-w@mail.gmail.com
> > [3] https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkX=
UZSBVJrcGFXCA@mail.gmail.com
> >
> > All comments and feedback are greatly appreciated.
> > Patch will follow.
> >
> > Sincerely,
> > Youngjun Park
> >
> > youngjun.park (2):
> >   mm/swap, memcg: basic structure and logic for per cgroup swap priorit=
y
> >     control
> >   mm: swap: apply per cgroup swap priority mechansim on swap layer
> >
> >  include/linux/memcontrol.h |   3 +
> >  include/linux/swap.h       |  11 ++
> >  mm/Kconfig                 |   7 +
> >  mm/memcontrol.c            |  55 ++++++
> >  mm/swap.h                  |  18 ++
> >  mm/swap_cgroup_priority.c  | 335 +++++++++++++++++++++++++++++++++++++
> >  mm/swapfile.c              | 129 ++++++++++----
> >  7 files changed, 523 insertions(+), 35 deletions(-)
> >  create mode 100644 mm/swap_cgroup_priority.c
> >
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > --
> > 2.34.1
> >
> >

