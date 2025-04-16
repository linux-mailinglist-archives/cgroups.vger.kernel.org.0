Return-Path: <cgroups+bounces-7596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BFA90A8F
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1575A204B
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745C217F34;
	Wed, 16 Apr 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrF6BGcQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C314B950
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826137; cv=none; b=hG6IVlVlTxVR89HlKcTdXPGQkdG+dI4oKNVVKndkx8kncQUp8Wht+y0Z6KX8JKyWfd/0AdSDMXH4mmrHIDDnNRu3X1jF8l8DiDwzZ2nXydLptCnq6kSk2XUvn0D/sYxmNBliOzbNp/bwqX90/mn7nEPiFhojUSlWe3JKyYQWDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826137; c=relaxed/simple;
	bh=2CfjplX8zscpXUoal04dv9hwYU8t1NGe72Imp4iy5fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZoimKQHN8QtA+/0+v+KUW9WY0vwAajo8O7bEoMfFKH5f3GSH3E3fyKKNmXE/Y13HBylQ96LZv0hKx+SEwRAouvTElI+Ieh+jyojhz5XZaunkaS7oeYY1VyrQHZ5KE0O48lJtje6e/hhMXg0DnqkC4NVDGIHS9jRyyXUMZDOEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nrF6BGcQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso5465e9.1
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826134; x=1745430934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tO3E3xALB/t7rctpx9zy1Q881g7OQ2piRAkNHbzMn8=;
        b=nrF6BGcQmW0K3vznUjHilJ1OTF0iDniW6uCHjcGtnIe53FOjQ6bQXUbNIegdH8g4BM
         rx79IS5Pjzn6xZJCecb/N1XzM7Nk1zEdlV2bdL3G3tZFRShDWHwxr2ToT8cxsBlFcc64
         TrbVtn76n8bkaKpK1lBzG8zegQqHZLF7f4KOQYLQ7PhsC2JrM2H+HwaMBhfNSDb0B/Ls
         /iOS/Sb8UmnbUh4vjaSOSWHlIYMhIB8XeObdXkT3oA9Tdkei8DTU+RvjC9a0zMyYB2pt
         +bbd/qs2/VNvsyp+c8Z/QpJOT5wc1AMGyhXe2QHS2Rlot+CxWgqFSIMtIBPW/RTdqKp7
         wKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826134; x=1745430934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tO3E3xALB/t7rctpx9zy1Q881g7OQ2piRAkNHbzMn8=;
        b=qYH4Vy86AfiZ4vjWXw6QfqOoj/tP2e93a5JaPGb8NIz4+zIW/r+DHiQIS/8rPofvs3
         Xqr/IFPoJU4rH8znnTF7cY1ijNLt5QHliNtouQIndHMtdaUizEjHCjRrFG3ofafrDpNs
         uhctNBbDxxEonL9Pc8bAKpf5+ENBhpmAYLxElrPvXlwrbHELu73B38zf3smrLkOmG4GX
         +KfVTuaY/C3/ynbZz89xd3U2aH105G5tTi5cRikQ1FGVrtSI3+sszlI4m1R6HVxgEKRa
         ++7x4/EfU5B0XjH3oanHvSr+J4wMuqX5IVrG8gZ3we4TVtv693PxgQk3+LOIns+7ECUS
         h89w==
X-Forwarded-Encrypted: i=1; AJvYcCVzbgJy0dnVzCWdl8ttmDLRwGPbIGVnGWqHoEvw6WL8Q5CGAbJp95VXrAcG4cL1ALbxepJI2joy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SfiXqW7CdNTJkU2CSBung+5vdB2QRXjniGFU40ieE7WWe3Tx
	3QZ1vbjPfA/19tQrQMR1pW+Tzez6rm3955dQ3oUlEVaeMBnURLKnAsOnzO9vorNrIRK9Y8PTeb5
	x5dh/TLxznzDZ+amrq51pGN10NbUXZTyvqhpb
X-Gm-Gg: ASbGncu5+XdNUgMInSCQAQUWGJq3+zWVaP9Z0ysOunZICoT+vyQKMcO2rjgEQPvdMjc
	KpK8Et3zNOekRHKNOZGix2XyvQrFPey7e72QC2+ugVqsy3v1VGAdCvOxIBoCr+U8ZawPDic1NSH
	gdHLjSyFbG8O5CcqPIS03KFc6sIG7ee8EWeD7IPwLWSaMNIxg3hbH+
X-Google-Smtp-Source: AGHT+IFj3pE5zdkYxEZY4aBG+o6bCeM3IfRKyL3i3Kw46tKIu/J5VpCIswp+cj2mEYBuvzx+IfzLj6h4UxCBN0hfGPw=
X-Received: by 2002:a05:600c:358e:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-44062a912f8mr34195e9.2.1744826134040; Wed, 16 Apr 2025 10:55:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415235308.424643-1-tjmercier@google.com> <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
In-Reply-To: <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 10:55:22 -0700
X-Gm-Features: ATxdqUFGVI9JR-cfNSa7cIRPm3k9k6vDZ64btl4ethiLao_mMPbM-xa3GVv2MjA
Message-ID: <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:19=E2=80=AFAM Kamalesh Babulal
<kamalesh.babulal@oracle.com> wrote:
>
> Hi,
>
> On 4/16/25 5:23 AM, T.J. Mercier wrote:
> > Android has mounted the v1 cpuset controller using filesystem type
> > "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> > behavior where the controller name is not added as a prefix for cgroupf=
s
> > files. [2]
> >
> > Later, a problem was discovered where cpu hotplug onlining did not
> > affect the cpuset/cpus files, which Android carried an out-of-tree patc=
h
> > to address for a while. An attempt was made to upstream this patch, but
> > the recommendation was to use the "cpuset_v2_mode" mount option
> > instead. [3]
> >
> > An effort was made to do so, but this fails with "cgroup: Unknown
> > parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> > mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> > update the special cased cpuset_mount(), and only the cgroup (v1)
> > filesystem type was updated.
> >
> > Add parameter parsing to the cpuset filesystem type so that
> > cpuset_v2_mode works like the cgroup filesystem type:
> >
> > $ mkdir /dev/cpuset
> > $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> > $ mount|grep cpuset
> > none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_=
mode,release_agent=3D/sbin/cpuset_release_agent)
> >
> > [1] https://cs.android.com/android/_/android/platform/system/core/+/b76=
9c8d24fd7be96f8968aa4c80b669525b930d3
> > [2] https://cs.android.com/android/platform/superproject/main/+/main:sy=
stem/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=3D2dac5d89a0f024a2=
d0cc46a80ba4ee13472f1681;l=3D192
> > [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@r=
edhat.com/T/
> >
> > Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2=
 behavior in v1 cgroup")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> The patch looks good to me, please feel free to add
>
> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>
> One nit below:
>
> > ---
> >  kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 27f08aa17b56..cf30ff2e7d60 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type =
=3D {
> >  };
> >
> >  #ifdef CONFIG_CPUSETS_V1
> > +enum cpuset_param {
> > +     Opt_cpuset_v2_mode,
> > +};
> > +
> > +const struct fs_parameter_spec cpuset_fs_parameters[] =3D {
> > +     fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
> > +     {}
> > +};
>
> A minor optimization you may want to convert the cpuset_fs_parameters int=
o
> a static const.

Thanks, I copied from cgroup1_fs_parameters since that's where
cpuset_v2_mode lives, which doesn't have the static currently
(cgroup2_fs_parameters does). Let me update cpuset_fs_parameters in
v3, and add a second patch for cgroup1_fs_parameters.

> --
> Cheers,
> Kamalesh
>

