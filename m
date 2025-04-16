Return-Path: <cgroups+bounces-7597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A5A90AAE
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B48E1907C93
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600021ABB7;
	Wed, 16 Apr 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPg5gYXa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFF21A42C
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826448; cv=none; b=BXt6di24agdZtWxkYAb7uGC0zJ3GC4hkXmKO8mbga00fufstoHWzXQqL2TZtvEmG0COsk+RQyRF6W8Zs9dCN/nFY39yTEhU2B6OxUgMMdd10tCL0GfwRLo/HXmZ7EK2HJo4T0pCM5SADu/JEk95saigLfk2lQhTTySveSEHZ5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826448; c=relaxed/simple;
	bh=P9weY3ldi7FIMak0rp1fWR+FZZwuW0EwfA01UC/mLno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BncW8o2bLKgdANp5K+M4wqOVfn4HrGe2nyqq5zeegIj7NtC5RRp5J2uNGJdMEvgB38F0SKgpSuRthyVuk+ucDzlkMbIlvmbYbo9lKzr+Zz4xkNMnTXg1a+KAcxw7bkehiPHXTdW5B+uBLYSrOprAIXKJ2jwI6kTA/296ucJkZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPg5gYXa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47681dba807so24181cf.1
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826445; x=1745431245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vVhFNvbdydAJKcvh9ZAGYx+6XmXqXXve/KZNChtx7g=;
        b=jPg5gYXa404EUKyvGFmhtPeOjfwy+VEtWadaI1XLL6SCgGP5AJtfqLqwcwWZL9Mh8o
         yRMFB+H1Xbwexe3bfuCWv/GNSGshFWUxJYvvISqDj7Km/YpN99ZntwEkNMrPM6sgsj4c
         TU7n5Xfckrs3LnWwVS0yj5UGfaaGR2/Sb1P88hmTQ2GSUdyKrlN9+zbj/1qribHjSE8V
         oSvjq1Oqo7eWvy7cQtoy1Ry4plEcbQpVLIUphqrsuwrclL/iVZbYhzXdMuOyN1TCJnzJ
         fNY4rvQajInYrEGXSj6Vh0NXqcw804PSzFCXs5N6QUNTaVdYJYRlpWIWtAvmC2eumRrl
         zAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826445; x=1745431245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vVhFNvbdydAJKcvh9ZAGYx+6XmXqXXve/KZNChtx7g=;
        b=iEveNTG9nuLbmcHSNIdwFkUpp+45KOCzuD56PzsYEyKqJ3VtRaMRJnFjvYC9Z5wOlr
         FLddpkZHLjGJ9vPevxR29Xtnnoy6fwPnsYrVIy05j1JEvnCGPTVkJ8PgVUhkPvbKSnKF
         7fiPghNwwPlgDlX01LTA8ZckuXlJkkDem08ksUbXj0e9j4LeYTH+Pe6Z64Urg35EaZzE
         yea4rHyREnRANUkeJpDhoLmQBQbS/IH0NUyumtFa6He1y0BQj2tt9zS4nSalUQddfUTT
         FLZ5NgbSCFZX+NenrYhXUXmd4o2Gt0BcRmoP4ybacNhLtBwptLu+z85xfYh0iwS/M0qp
         gKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9XUAygjq5pah/6wX1gYWinq+QsltvD039R40+cxaGUTVvlwATR5Xg7UK5h7RKZxE5XJXjGc4c@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFrs943S2mrG7lABYjuyvyYn+7c/aAqkg+FmSU2bjHvN9eDVO
	phOz9R1rHQbXcxC+MjDK6icvMFDZdxnz398PsYpljab7Ra0aryqhOYUwZe7GYl7xxu/SgeYbEjm
	GM6klBP+qEbYhAHri1OEsKbwO8KKDOx0GtL7s
X-Gm-Gg: ASbGnctaCmc10DGOEaesZe+yLHGNCcZy7y4DKim7xumIHeErG9DeF0n+5iRWaNBHiqn
	cGA7KROeILKo7ubKUdAzH1d1NUgO//pVIZeWEnF1p/hBqVZFaBSYVks1WiBhASEV1dga/SJlhaB
	SP9YgK3adgIHBBKFairMpP0EY8T4bwmo1+zEODB2zalcbvT9a2j9Xh
X-Google-Smtp-Source: AGHT+IHFd5DPl+obAAkkqCbWnarwZP7oq1mSWxeUsF1Ti7Q9Tgw3A/y6hpCO0rvtJuNDg1o//v4MKFbVNq88UoRgMyc=
X-Received: by 2002:a05:622a:1903:b0:479:1958:d81a with SMTP id
 d75a77b69052e-47ade6170eemr124691cf.6.1744826444977; Wed, 16 Apr 2025
 11:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415235308.424643-1-tjmercier@google.com> <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
 <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
In-Reply-To: <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 11:00:31 -0700
X-Gm-Features: ATxdqUFWVjlyT3xruDHQcnvzQ1jd7bwRceap-OGpJygB9rNbA953SnuNmxgFfvg
Message-ID: <CABdmKX1Lc2+A8xV2pH8C9_YZENCV4HAhb3uhLx7T0u2fcVP8Rw@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:55=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Wed, Apr 16, 2025 at 2:19=E2=80=AFAM Kamalesh Babulal
> <kamalesh.babulal@oracle.com> wrote:
> >
> > Hi,
> >
> > On 4/16/25 5:23 AM, T.J. Mercier wrote:
> > > Android has mounted the v1 cpuset controller using filesystem type
> > > "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> > > behavior where the controller name is not added as a prefix for cgrou=
pfs
> > > files. [2]
> > >
> > > Later, a problem was discovered where cpu hotplug onlining did not
> > > affect the cpuset/cpus files, which Android carried an out-of-tree pa=
tch
> > > to address for a while. An attempt was made to upstream this patch, b=
ut
> > > the recommendation was to use the "cpuset_v2_mode" mount option
> > > instead. [3]
> > >
> > > An effort was made to do so, but this fails with "cgroup: Unknown
> > > parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> > > mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> > > update the special cased cpuset_mount(), and only the cgroup (v1)
> > > filesystem type was updated.
> > >
> > > Add parameter parsing to the cpuset filesystem type so that
> > > cpuset_v2_mode works like the cgroup filesystem type:
> > >
> > > $ mkdir /dev/cpuset
> > > $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> > > $ mount|grep cpuset
> > > none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v=
2_mode,release_agent=3D/sbin/cpuset_release_agent)
> > >
> > > [1] https://cs.android.com/android/_/android/platform/system/core/+/b=
769c8d24fd7be96f8968aa4c80b669525b930d3
> > > [2] https://cs.android.com/android/platform/superproject/main/+/main:=
system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=3D2dac5d89a0f024=
a2d0cc46a80ba4ee13472f1681;l=3D192
> > > [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385=
@redhat.com/T/
> > >
> > > Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use =
v2 behavior in v1 cgroup")
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >
> > The patch looks good to me, please feel free to add
> >
> > Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> >
> > One nit below:
> >
> > > ---
> > >  kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 27f08aa17b56..cf30ff2e7d60 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type=
 =3D {
> > >  };
> > >
> > >  #ifdef CONFIG_CPUSETS_V1
> > > +enum cpuset_param {
> > > +     Opt_cpuset_v2_mode,
> > > +};
> > > +
> > > +const struct fs_parameter_spec cpuset_fs_parameters[] =3D {
> > > +     fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
> > > +     {}
> > > +};
> >
> > A minor optimization you may want to convert the cpuset_fs_parameters i=
nto
> > a static const.
>
> Thanks, I copied from cgroup1_fs_parameters since that's where
> cpuset_v2_mode lives, which doesn't have the static currently
> (cgroup2_fs_parameters does). Let me update cpuset_fs_parameters in
> v3, and add a second patch for cgroup1_fs_parameters.

Ah nevermind, cgroup1_fs_parameters needs to be accessible from
cgroup.c. So just the v3 update then.
>
> > --
> > Cheers,
> > Kamalesh
> >

