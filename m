Return-Path: <cgroups+bounces-7603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42FA90B40
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A51904A39
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B2221D86;
	Wed, 16 Apr 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXgQnTOh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F57221727
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828043; cv=none; b=XC2PdZ9a6ERsjtUbSfFcjAXBW1wrti3gbyG3fMmmqKgzCC7BiL2wLf/ag/iLKc+hLScmPyM9LD0Grr4wb8kMsv54rwEKtijXXRPaIg1XQk3NPZ1DX11GBlYMnGxVCdKAYvwUoCdYddv/04TYf8fQmHaOXrl9lOBmbYqQCnvXxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828043; c=relaxed/simple;
	bh=Si3T9g34tLwRu+I/ZcdrJ4sHmlM5Q2ZsPVwjTIbvTkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX73BNLfiHEY66bZidAOL8wLKnTGRVQ1EuBq8mLFk/CQMhvAxia3l2+dYAjRRylyhxY3nRyfHM5uj23xtDGwLNONE0eCa90JLW0xH3g7W0lcPrkgYCGLM2sVrqRR6tD+9ALj8u/4CQE4Ul5aHUaWDv4niV0FJKNhB+4GMh0rnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXgQnTOh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774611d40bso38381cf.0
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744828040; x=1745432840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVFY0bq/2fKFFwQxdNRxoC/3a3hJaQuA3a878lkmZSE=;
        b=KXgQnTOh9+g7+plpl0H9CDQjzpvL9J0LG2ZUMBh+n7olK5+WiEVxe/c+kw5Qh4unPF
         r9zLn7gvnVFMIp+MFjEmDGZId0CzHsjZTLEy6e5S0csD49aJn8blZDl2EgpSAgQkVqX0
         bCpLijAmUNgQ/qkCyv0i3Cm5nlLa6KydyzdhVUdowxRyjYVmnzYccuT+wRZt6d8DX753
         IoLuPDXmmOD50BdXuzl8KhoJ9Fe2IO3M/YzCEANS2SSRxeIHEzBKc5KatfmJb73s+ghV
         eJaF/81n/fLqB/Wq3qXC+HjgX8ikN1RItBsYkOOWefxBOhkSBC55xHokkp/Y6GrkEFg7
         NZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828040; x=1745432840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVFY0bq/2fKFFwQxdNRxoC/3a3hJaQuA3a878lkmZSE=;
        b=w0xVExncslOkCJLFyEL2/7NAMHcbw9G7lBnhLolsexQiOReCmfTGN6wzehxHVSfzRR
         y1QkjTVFQj8WfFdfpk6Gh3Z38ZhKTWNj6Q7wMSS2i7NLYKkvwx8/52BTwbhCISS22Laj
         a9sajm+9XrOSnVA8Y++SawtA3lxPLMhRWGkkS5+vxijoy39320BMo/9qf76zB6aH/Gun
         /VXe1HT6mSamLJBb3KSG3OzBVHTXOrf2zbhD7CG1QkB9Qo9SSwZ0kiCdYo9TpELKr+Qa
         jqI/RCZFaBZW86+mvqYhgm8jOwCxjAh2JleRveMUuOTZkmmySrBR1VsU0k8RICW+AFqQ
         gADQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38RNlhn6FjifxaERPWbFTJPLN0AmH53Z5aPA6eYwP9gDCpBv53q3XNenI7la4DllQn944ckck@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCFDcVF8/fMnxPTzSdWPsZFW84lckixITfqLscjpZoG0ox30R
	6QiFwIZADwxCkg1OQhPgB2exG0reCu/wSEPij/nkVCoqT4oWm7dYWiD9IL1Hl4ZmsF7TJQv8pca
	hKkEJIsgcIVXm/JHh17s2trgkqP7orTw0r0e2
X-Gm-Gg: ASbGncug24DVsWtw32HjN3ldZAO19TfSjHOcIiV1vovUZQNZHcmJB6AOza5Ol9BHkn9
	fRA2VvBLYJ/tn4fwXrR0G99tXdAIQNUTcLl/RgCLGAVrmwN3pFciUZSUtjw/94C85ON18rD2Yxy
	9D8VJA0rMxF6zz7ZNxR3kdrT78nUYYIv2EbOSpGhZ1Pps9+avrdtcs
X-Google-Smtp-Source: AGHT+IHrvdMkNhbP02odv8o8St3nhbxaosHL7rrK9HEHzG56GYAHJ0bCrsO+VP4YauVKrmN0kZfCH6Vz33K6NOlIXOA=
X-Received: by 2002:a05:622a:d0:b0:477:637f:a63 with SMTP id
 d75a77b69052e-47ade60c5cbmr275611cf.6.1744828039809; Wed, 16 Apr 2025
 11:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415235308.424643-1-tjmercier@google.com> <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
 <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com> <146ecd0e-7c4c-4c8c-a11f-029fafb1f2e3@redhat.com>
In-Reply-To: <146ecd0e-7c4c-4c8c-a11f-029fafb1f2e3@redhat.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 11:27:06 -0700
X-Gm-Features: ATxdqUET1zUiRX-oof2Xojcaomp-kJimkCJ-cNW3d-EnaHVS7Nfzsp0x88QDz2o
Message-ID: <CABdmKX2Basoq0Sk6qemcP3Mne6-nJPNN0Mz9WYjvdKWNagoaZg@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
To: Waiman Long <llong@redhat.com>
Cc: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:05=E2=80=AFAM Waiman Long <llong@redhat.com> wro=
te:
>
> On 4/16/25 1:55 PM, T.J. Mercier wrote:
> > On Wed, Apr 16, 2025 at 2:19=E2=80=AFAM Kamalesh Babulal
> > <kamalesh.babulal@oracle.com> wrote:
> >> Hi,
> >>
> >> On 4/16/25 5:23 AM, T.J. Mercier wrote:
> >>> Android has mounted the v1 cpuset controller using filesystem type
> >>> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> >>> behavior where the controller name is not added as a prefix for cgrou=
pfs
> >>> files. [2]
> >>>
> >>> Later, a problem was discovered where cpu hotplug onlining did not
> >>> affect the cpuset/cpus files, which Android carried an out-of-tree pa=
tch
> >>> to address for a while. An attempt was made to upstream this patch, b=
ut
> >>> the recommendation was to use the "cpuset_v2_mode" mount option
> >>> instead. [3]
> >>>
> >>> An effort was made to do so, but this fails with "cgroup: Unknown
> >>> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> >>> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> >>> update the special cased cpuset_mount(), and only the cgroup (v1)
> >>> filesystem type was updated.
> >>>
> >>> Add parameter parsing to the cpuset filesystem type so that
> >>> cpuset_v2_mode works like the cgroup filesystem type:
> >>>
> >>> $ mkdir /dev/cpuset
> >>> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> >>> $ mount|grep cpuset
> >>> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v=
2_mode,release_agent=3D/sbin/cpuset_release_agent)
> >>>
> >>> [1] https://cs.android.com/android/_/android/platform/system/core/+/b=
769c8d24fd7be96f8968aa4c80b669525b930d3
> >>> [2] https://cs.android.com/android/platform/superproject/main/+/main:=
system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=3D2dac5d89a0f024=
a2d0cc46a80ba4ee13472f1681;l=3D192
> >>> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385=
@redhat.com/T/
> >>>
> >>> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use =
v2 behavior in v1 cgroup")
> >>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >> The patch looks good to me, please feel free to add
> >>
> >> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> >>
> >> One nit below:
> >>
> >>> ---
> >>>   kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
> >>>   1 file changed, 29 insertions(+)
> >>>
> >>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> >>> index 27f08aa17b56..cf30ff2e7d60 100644
> >>> --- a/kernel/cgroup/cgroup.c
> >>> +++ b/kernel/cgroup/cgroup.c
> >>> @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type=
 =3D {
> >>>   };
> >>>
> >>>   #ifdef CONFIG_CPUSETS_V1
> >>> +enum cpuset_param {
> >>> +     Opt_cpuset_v2_mode,
> >>> +};
> >>> +
> >>> +const struct fs_parameter_spec cpuset_fs_parameters[] =3D {
> >>> +     fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
> >>> +     {}
> >>> +};
> >> A minor optimization you may want to convert the cpuset_fs_parameters =
into
> >> a static const.
> > Thanks, I copied from cgroup1_fs_parameters since that's where
> > cpuset_v2_mode lives, which doesn't have the static currently
> > (cgroup2_fs_parameters does). Let me update cpuset_fs_parameters in
> > v3, and add a second patch for cgroup1_fs_parameters.
>
> Besides not exposing the structure outside the current file or maybe a
> tiny bit of linker speedup, is there other performance benefit by adding
> "static"?
>
> Regards,
> Longman
>

I thought it might decrease the text size a tiny bit, but it doesn't
because the symbol isn't exported and I guess the compiler knows to
just inline.

