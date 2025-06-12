Return-Path: <cgroups+bounces-8506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732DAD703A
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2396B3A16BA
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B771F1313;
	Thu, 12 Jun 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g63kpkoe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190D1917ED;
	Thu, 12 Jun 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731069; cv=none; b=FmKDKn6EPGFtyL9j+q4bnFoAmQQKHv0RtGQF8uN6bm0Ufc2uutm6wdgykt7ZsHtVb9FwSjI1rEzJAK7Uc3aRFPoiFVBxGiq26Pr4N0sqS8CUT+u7Kxs/2jY+6ixPd1oiPtIXKTtDrtqFwzYt7o1CrUlnnrZDCGe6swMBQnW3D1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731069; c=relaxed/simple;
	bh=mTlTGx5qMcj9oo7NbwlgffToNGz66QBd9EOnadHWMhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh5X4xqOmJgFiGmOOacTFiJTdGBlNyRijqG+zHPoW8nRXbG9XRggh41U2UI9oYIgE3KNMRFd9/67bBDJbhyWAtIKhsdYfgwErjIP3BpFmwClNOlqm575x/MT6FFW7TOrx/hdIb8aXVnpIhh/DJa4rOkcva2YuaodWx4UzmNfO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g63kpkoe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32a72cb7e4dso9595451fa.0;
        Thu, 12 Jun 2025 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749731066; x=1750335866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SweKlcwfC9UHjYra4TpM3WTLuJ0fF6U4YIJI8RKnNE=;
        b=g63kpkoeH/9yBMCQg079M1XO1r+QoP0Yx4+Gi0uJ0ShRaLl0sPg4IzX8pph3O4EbRJ
         b2cNZmRsxpOGApHIbQcuImpEa4QUxtaMfCtvRUEgFJxIIMLzjPS0KDKJ78BDuBBD+gqY
         ZFhx2VR1g1+bClwYfB2I5IFrw27OnTJm/nsvfrEn7ZjEwOTUPB/I89YR56JB7rEQvcsh
         ZTxYT9oVhn+7FlqyndMjUn8rk83NW+F1zZ8v3qbyP0u8PlB1PxRdQIqCPgtkeH1eVphD
         wFwV+Bheg3GTd75TqCzCB+be4/N5jLU6iVtjb4QxIuRFUj6FAfV8D2JmJWIEXCKkGfPL
         xgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749731066; x=1750335866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SweKlcwfC9UHjYra4TpM3WTLuJ0fF6U4YIJI8RKnNE=;
        b=Ig3p4F0pQaa4fh01yjV33mwlIDczVUZGY4GW4v/1AjSXT5Gz9/lYdme5PNB2arkddk
         w97ZNgVMDaX6Xi0t9r4o3TEhUbWKKg/hebzlCQfvnm2gVWfOja6o0IWQ1IMICxFNNICo
         dk2c/JQRSeabMwZ8lHaaS008cqNrleH6yZwllSRUWDMNx8Gob1ImNfso103eccglCfOS
         JxQPV119/KFJm4sKS3akCyZWbxPkGc0K1L+MqvXP9vagEev299NqHN3a0LCzY/VEOOTU
         m7Wbp/B8qqVUIme/HMJOvjzrATERyi9LUmOot8aGxwxRUgWbYE2QP0iA/4Q30UafZMGz
         lN1A==
X-Forwarded-Encrypted: i=1; AJvYcCURk4MjxOGNDFW4EuKDgwOc/ro5olmCJjxVKAFlglt3RC+TYk7s8pKofHaInbQ4Nffc5fJpyaVW@vger.kernel.org, AJvYcCWJYSe8J/pHoIMGP4J8iLdBcJLXLEUH5kBkqRmuRowxDr2nWKWcIYCQVrj3snXpheSe0WTZ7T/QBVITho8Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZGZdctFt1BkJOpN8pAEnrGaPeL/nE97STRJEt1Ja84acB4OW
	vlEzDeFqqnnwihMtuKqgx8x7QcYBRZW5u4ZAk8iA+F0e88HahLt75uy+Kz4nXmqvMCdTk4+lez2
	CpVytdtgVeax+h4xPdfziwmv3VkNSUkM=
X-Gm-Gg: ASbGncuNCWbE5pAxlLw2+Mmdo/YBY4q2rXZOyLnPk3KVzwaLXNdJMVnlHnQd2ZViY2A
	Sb7zabxX8B3DNR8JRrr1UklEcanNT2FxWKrEp21ZE9lAv3mTGFM2CTl1RRLwg3Luqk0l9kGfAsf
	tH+fXo80Rj10OQneB2gtVkHv9AC0VXfn0G0XT47WiCQKU=
X-Google-Smtp-Source: AGHT+IFwSzKoBcF7ID2T+P6G69X43FsObyrPgZc6+hgqV/3LbGXqSMbn531OFsTo73Kz5d8vP5uqHkvUYoZ6OcteLlI=
X-Received: by 2002:a2e:be9c:0:b0:32a:6aa0:216f with SMTP id
 38308e7fff4ca-32b307120d6mr11383471fa.29.1749731065631; Thu, 12 Jun 2025
 05:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
In-Reply-To: <20250612103743.3385842-1-youngjun.park@lge.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 12 Jun 2025 20:24:08 +0800
X-Gm-Features: AX0GCFtkixhsnGjXFLa3XHQn2P5tRNtM6hPsFB17j20v1d6bwb5YtLLUJ4LcUe0
Message-ID: <CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm/swap, memcg: Support per-cgroup swap device prioritization
To: youngjun.park@lge.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, muchun.song@linux.dev, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:38=E2=80=AFPM <youngjun.park@lge.com> wrote:
>
> From: Youngjun Park <youngjun.park@lge.com>
>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I am a kernel developer working on platforms deployed on commercial consu=
mer devices.
> Due to real-world product requirements, needed to modify the Linux kernel=
 to support
> a new swap management mechanism. The proposed mechanism allows assigning =
different swap
> priorities to swap devices per cgroup.
> I believe this mechanism can be generally useful for similar constrained-=
device scenarios
> and would like to propose it for upstream inclusion and solicit feedback =
from the community.
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Core requirement was to improve application responsiveness and loading ti=
me, especially
> for latency critical applications, without increasing RAM or storage hard=
ware resources.
> Device constraints:
>   - Linux-based embedded platform
>   - Limited system RAM
>   - Small local swap
>   - No option to expand RAM or local swap
> To mitigate this, we explored utilizing idle RAM and storage from nearby =
devices as remote
> swap space. To maximize its effectiveness, we needed the ability to contr=
ol which swap devices
> were used by different cgroups:
>   - Assign faster local swap devices to latency critical apps
>   - Assign remote swap devices to background apps
> However, current Linux kernel swap infrastructure does not support per-cg=
roup swap device
> assignment.
> To solve this, I propose a mechanism to allow each cgroup to specify its =
own swap device
> priorities.
>
> Evaluated Alternatives
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. **Per-cgroup dedicated swap devices**
>    - Previously proposed upstream [1]
>    - Challenges in managing global vs per-cgroup swap state
>    - Difficult to integrate with existing memory.limit / swap.max semanti=
cs
> 2. **Multi-backend swap device with cgroup-aware routing**
>    - Considered sort of layering violation (block device cgroup awareness=
)
>    - Swap devices are commonly meant to be physical block devices.
>    - Similar idea mentioned in [2]
> 3. **Per-cgroup swap device enable/disable with swap usage contorl**
>    - Expand swap.max with zswap.writeback usage
>    - Discussed in context of zswap writeback [3]
>    - Cannot express arbitrary priority orderings
>     (e.g. swap priority A-B-C on cgroup C-A-B impossible)
>    - Less flexible than per-device priority approach
> 4. **Per-namespace swap priority configuration**
>    - In short, make swap namespace for swap device priority
>    - Overly complex for our use case
>    - Cgroups are the natural scope for this mechanism
>
> Based on these findings, we chose to prototype per-cgroup swap priority c=
onfiguration
> as the most natural, least invasive extension of the existing kernel mech=
anisms.
>
> Design and Semantics
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Each swap device gets a unique ID at `swapon` time
> - Each cgroup has a `memory.swap.priority` interface:
>   - Show unique ID by memory.swap.priority interface
>   - Format: `unique_id:priority,unique_id:priority,...`
>   - All currently-active swap devices must be listed
>   - Priorities follow existing swap infrastructure semantics
> - The interface is writeable and updatable at runtime
> - A priority configuration can be reset via `echo "" > memory.swap.priori=
ty`
> - Swap on/off events propagate to all cgroups with priority configuration=
s
>
> Example Usage
> -------------
> # swap device on
> $ swapon
> NAME      TYPE      SIZE USED PRIO
> /dev/sdb  partition 300M  0B   10
> /dev/sdc  partition 300M  0B    5
>
> # assign custom priorities in a cgroup
> $ echo "1:5,2:10" > memory.swap.priority
> $ cat memory.swap.priority
> Active
> /dev/sdb  unique:1  prio:5
> /dev/sdc  unique:2  prio:10
>
> # adding new swap device later
> $ swapon /dev/sdd --priority -1
> $ cat memory.swap.priority
> Active
> /dev/sdb  unique:1  prio:5
> /dev/sdc  unique:2  prio:10
> /dev/sdd  unique:3  prio:-2
>
> # reset cgroup priority
> $ echo "" > memory.swap.priority
> $ cat memory.swap.priority
> Inactive
> /dev/sdb  unique:1  prio:10
> /dev/sdc  unique:2  prio:5
> /dev/sdd  unique:3  prio:-2
>
> Implementation Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The items mentioned below are to be considered during the next patch work=
.
>
> - Workaround using per swap cpu cluster as before
> - Priority propgation of child cgroup
> - And other TODO, XXX
> - Refactoring for reviewability and maintainability, comprehensive testin=
g
>   and performance evaluation

Hi Youngjun,

Interesting idea. For your current approach, I think all we need is
per-cgroup swap meta info structures (and infrastures for maintaining
and manipulating them).

So we have a global version and a cgroup version of "plist, next
cluster list, and maybe something else", right? And then
once the allocator is folio aware it can just prefer the cgroup ones
(as I mentioned in another reply) reusing all the same other
routines. Changes are minimal, the cgroup swap meta infos
and control plane are separately maintained.

It seems aligned quite well with what I wanted to do, and can be done
in a clean and easy to maintain way.

Meanwhile with virtual swap, things could be even more flexible, not
only changing the priority at swapout time, it will also provide
capabilities to migrate and balance devices adaptively, and solve long
term issues like mTHP fragmentation and min-order swapout etc..

Maybe they can be combined, like maybe cgroup can be limited to use
the virtual device or physical ones depending on priority. Seems all
solvable. Just some ideas here.

Vswap can cover the priority part too. I think we might want to avoid
duplicated interfaces.

So I'm just imagining things now, will it be good if we have something
like (following your design):

$ cat memcg1/memory.swap.priority
Active
/dev/vswap:(zram/zswap? with compression params?) unique:0 prio:5

$ cat memcg2/memory.swap.priority
Active
/dev/vswap:/dev/nvme1  unique:1  prio:5
/dev/vswap:/dev/nvme2  unique:2  prio:10
/dev/vswap:/dev/vda  unique:3  prio:15
/dev/sda  unique:4  prio:20

$ cat memcg3/memory.swap.priority
Active
/dev/vda  unique:3  prio:5
/dev/sda  unique:4  prio:15

Meaning memcg1 (high priority) is allowed to use compressed memory
only through vswap, and memcg2 (mid priority) uses disks through vswap
and fallback to HDD. memcg3 (low prio) is only allowed to use slow
devices.

Global fallback just uses everything the system has. It might be over
complex though?


>
> Future Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> These are items that would benefit from further consideration
> and potential implementation.
>
> - Support for per-process or anything else swap prioritization
> - Optional usage limits per swap device (e.g., ratio, max bytes)
> - Generalizing the interface beyond cgroups
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://lkml.iu.edu/hypermail/linux/kernel/1404.0/02530.html
> [2] https://lore.kernel.org/linux-mm/CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBki=
wFHgy9uMk-F8Y-w@mail.gmail.com
> [3] https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZ=
SBVJrcGFXCA@mail.gmail.com
>
> All comments and feedback are greatly appreciated.
> Patch will follow.
>
> Sincerely,
> Youngjun Park
>
> youngjun.park (2):
>   mm/swap, memcg: basic structure and logic for per cgroup swap priority
>     control
>   mm: swap: apply per cgroup swap priority mechansim on swap layer
>
>  include/linux/memcontrol.h |   3 +
>  include/linux/swap.h       |  11 ++
>  mm/Kconfig                 |   7 +
>  mm/memcontrol.c            |  55 ++++++
>  mm/swap.h                  |  18 ++
>  mm/swap_cgroup_priority.c  | 335 +++++++++++++++++++++++++++++++++++++
>  mm/swapfile.c              | 129 ++++++++++----
>  7 files changed, 523 insertions(+), 35 deletions(-)
>  create mode 100644 mm/swap_cgroup_priority.c
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> --
> 2.34.1
>
>

