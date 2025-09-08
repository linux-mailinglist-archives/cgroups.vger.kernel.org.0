Return-Path: <cgroups+bounces-9791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCAB4969E
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AF1735BB
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446263126C5;
	Mon,  8 Sep 2025 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg/yNx3D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657063112BA;
	Mon,  8 Sep 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351504; cv=none; b=dGgFEVWyJik3+YP5T69xFUJmVG6Z0Vttdhawn2lNRFqV/oHpJmPhZ4sVZppag8nSyGNriCr+V4sE5jN7gDkNmiulQ8MoMgqomFolnibncG6+kdRo/NPsxcbkIzQ4+XUXBQxbIJazRxRbk5nD1Ph5jcplPnKniPZF2+oPj4/O6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351504; c=relaxed/simple;
	bh=nc/qUGfo82fdUqUDWPiQzP0//A1I8DqE1JSdgWBo+Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at9nACvES3MhqqY77wXCR0nWuf6zE/hv9wfNK4srWVhmNN0RtPpjunYItu39cdNkZI0Dq+TwHUu/pnyK3BJVIK0yci5LcLRPV1YdknKVqUP9XhE/TFLMPl/xmqvNghHtk/zEr+lR99jdJDJlrqjRWGUEzD/D53brk5u/gd/l9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg/yNx3D; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo1902652f8f.1;
        Mon, 08 Sep 2025 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757351501; x=1757956301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1/Xo26IpLOmm9VGHwt34+har9g1uHoZGkWPqsB7phg=;
        b=eg/yNx3DCHdSa+OPAbsEjN2oWBdyoLILBrsh/oZGbbrl5guGLUFsux/o2wC4eBAsc5
         mAR1+Yr7qxmm6E2NMrmW/C9urwg7FN+wMNAP/H+5KmJACbmwNSKl3THwVM9xBOkid8yj
         0EuFi37o6VMjNu+gxPVGUaW7XxaS0WEya0XYoMscs5XGGw3YbUddAD/GZfoV6H4ucEWR
         RDO9f2jtayQEcuQn2aP0RKSWUg3JiB5agYsfRoWLOM30oh07OAImq60ipnlSdXJ4k2Z8
         91qiEQLlSk5HZpwn+IWSENvfJFn8yC9bPVeSRCZ/oyFMWvgN1g/L3NXncFy7LGAvpIGt
         V4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351501; x=1757956301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1/Xo26IpLOmm9VGHwt34+har9g1uHoZGkWPqsB7phg=;
        b=w6BXq5DibsesDAL/zpaM3VVNJN/mgZxXs24lXT2nU7jVfatZNJ/kpaaTKWMaRATcbB
         PHEpn149NsjslYJDLMgmPPy99vu6z9i4ecIrlrTNVy6W9afyvLzVLA6ydtITV1XL76a2
         faRI0EjuZ6kPZGHm4B4tVz72dA9E0k8KrT8J7Q+FM+aMNSEfahUL6dhvi/vFFeDHCMHn
         vrXkjFlFYzKwTwQGUqcdxO1BNaY8zMuy0kKs26Ma6eEd6jtLlmOgHQk5oQnSfnTXxNWf
         grb92imbbIFpPrWe+e/HijPsRYShK7D8sd14yBW4BIhFgJHS753qHUQIjEC+HMOJHXsy
         kXZg==
X-Forwarded-Encrypted: i=1; AJvYcCURLVc3IMiTQuCa3bPtpo/kIANcqhbemQG0HzDlGZ7KT8v9mH3pzEe54PcgV7JxW02iRtQ=@vger.kernel.org, AJvYcCW6y44gKzcXY1fVNUUi9/0Cfnjaern1BtyGX9P7L3i3LouXyrz4TzOoEA7XLWLc+rxQh7C+Dvwnjw==@vger.kernel.org, AJvYcCWug+UHAXtKqIJx5LH9v8XrvlUeIJgAy4BaW5tU6xJHdTdHDVzKSQO52bL21Vm1vHtsPamirfhIcZpZ+hbT@vger.kernel.org
X-Gm-Message-State: AOJu0YwJx/8wQO/FunyiSSJNcEdBGKXmKKIUq+5J8lNCppkgnwKHNgJE
	OwwmQ1+QJM8MQYehr+x8Uj+EORwTS5JYHcgs/E4rddyoPdWDDRCwySK65QBhTLUFol9k8BLAwmo
	wUwYD3LFh0xCeimLqqryAMttUOfgVmRE=
X-Gm-Gg: ASbGnct5q0yBcP1KrNscCCW2zXTtokgao8k7k8uJEc+DEsUHV+W6EB+MYSph2Qvs9Pr
	jygQGGU8Y4Joy+A2s3mFF7vWNF/5Yx5xmM8Sg2/ElOIPvhwhUIdWbPsKESFlcHEtqCV1rxF5eKN
	6Z7ewKREEgY5WcI3Dei8Ea2SdeMgponexPE99z9oRAdmuq4D1UfmZ53qwNLV9i3H+5gSJg3p6rN
	U2/E3QQkmtwzb9XGqJfEVmBO2O6yLMnxv0d
X-Google-Smtp-Source: AGHT+IHLSc9z9t6zrJNIia9iqmvjLGG9Y3cJVAfc2BnuuchdOalrLs4aZRfsDiiM6JS6UgJelkC0rFMQMh3PO0dNIHE=
X-Received: by 2002:a05:6000:3113:b0:3dc:1a8c:e878 with SMTP id
 ffacd0b85a97d-3e642cad4b3mr6110427f8f.18.1757351500438; Mon, 08 Sep 2025
 10:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com> <aL6dBivokIeBApj8@tiehlicka>
In-Reply-To: <aL6dBivokIeBApj8@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 10:11:29 -0700
X-Gm-Features: AS18NWCPGMAuKGdXbwS4CiI7NiTNAFh-3hy8_bYRFu2qhn-yMLQ9ZTr5pJnwwvw
Message-ID: <CAADnVQLtc+OOQ67AS_1+u-sRmO+bDLWJrrihASXMrDNnvrmNSw@mail.gmail.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
To: Michal Hocko <mhocko@suse.com>
Cc: Peilin Ye <yepeilin@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:08=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 05-09-25 20:48:46, Peilin Ye wrote:
> > On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > > Generally memcg charging is allowed from all the contexts including N=
MI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() -=
>
> > > cgroup_file_notify().
> > >
> > > The possible function call tree under cgroup_file_notify() can acquir=
e
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, le=
t's
> > > just skip cgroup_file_notify() from memcg charging if the context doe=
s
> > > not allow spinning.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > Tested-by: Peilin Ye <yepeilin@google.com>
> >
> > The repro described in [1] no longer triggers locking issues after
> > applying this patch and making __bpf_async_init() use __GFP_HIGH
> > instead of GFP_ATOMIC:
> >
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
> >         }
> >
> >         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> > -       cb =3D bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_no=
de);
> > +       cb =3D bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_no=
de);
>
> Why do you need to consume memory reserves? Shouldn't kmalloc_nolock be
> used instead here?

Yes. That's a plan. We'll convert most of bpf allocations to kmalloc_nolock=
()
when it lands.

