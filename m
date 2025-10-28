Return-Path: <cgroups+bounces-11288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB7C16226
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B370A3A4DB5
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF034BA20;
	Tue, 28 Oct 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs/uSPNN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91152765F5
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672265; cv=none; b=VkKLNB8WwDAeMVJ+tPcF+FpYSfcZS5nYc9x62iNLF8aFHmLlE4C0t0zPB2fDd4Bpg2d35VjvgWoljS7lC1uIIG0dwEifKuLRumC0jidlR7g5hsiKoufWbRLO2c37mtPagxk9qU6g6eB729DAseaG2Mddi3eQ9ZRFeKfcuoZ8vGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672265; c=relaxed/simple;
	bh=OewkxvHD9T8olwhI1f/2XQgi9rznzfBFvLBmKpBSzpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r99fbMIfby133uS7IYRan0m9xz5LSWeI4qc+yXXdarEFCu8EobJAiP44yu5E2dG145+W1fCqhGYJkN2wCbng0PQb+bMXNX2Mz/PnmVMSwFnNQYdk1tBmfhKzR+n6w1nrLYFu+LEs2b8RgeftcD6TBhAWTMwSa8LJpB341Mu37Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs/uSPNN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34003f73a05so133339a91.1
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672262; x=1762277062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tljGKA799ISeHe7sJ8nVq9wgNoDMbrBY6ATHrDEAPsw=;
        b=Fs/uSPNNxPDnHb/1kG8A+IX9qzaIBBfATKEcYDMrR907f+quLdKjSgjqMEI8yq7ouW
         MKjiekBSjlId9vDUtvwZDRoaXSFJ1BHTIWNZthwyJ6gdIZov+tE+w9/+mygYtbAiGNm9
         n3BJyjZBA0ncDDWlha+RTUCJPefiNbO2mqA4Ry8z1b3Tx8ZOq6/qaKRpCoFXdWzFfqmR
         LXkI1lhQuh9VytIGDQQJbiB45WnAsLgKyTiwz6h35tAhKmeI57fk5dV2j7z6af0NwzfQ
         Ys2CBsHsha7aP9ZLIug2uuEY8JsByKmasP1uIDuy3//p1nBi1c1FyK3BFq05uulZyEm3
         Yp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672262; x=1762277062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tljGKA799ISeHe7sJ8nVq9wgNoDMbrBY6ATHrDEAPsw=;
        b=K2Fklleb6OkV6dtNqkFIfEjtMb2dtwieE4cc5NLzyiSpiTbyw8DGnfmPE3lOj/IYvy
         NqSJtrccAg+F6Z+aa4zZhoKxb7xk++ubzEVMXhBs5Uf896YVBBGLkoDMTHzdTHsQSz3b
         UOM2vZwJwO2wiRTOscvS5wmWlfSuB2Mdl6BOI36qqbZDJ2HFBuVfnz5Bdns6mcNap04j
         ixV8CzeziXQM3mCTRAoX4KmY7fJlwyhAhnvyZzH/+Xv9yLbfHxjaN2kJ1GILXNReVCrq
         G1X3ifC6j3cpcN2ZL4WX+UjMD0CgbRm5+8f44RyLHA/v5xFe+9nHw3RACElTTkEZUNel
         ABng==
X-Forwarded-Encrypted: i=1; AJvYcCWFni7EGXdrfgV6MMVSv2+SKzKRKNSONQGPklnByPZsmn7L45Lk+cOq7DOs6kq3fZ2iO7bxi9/6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HaLJLYPFvJB96esTzBrwbjR9aI+kr40oSalAMM+UBtvlQUZd
	RY+7PxA/ZpjrYoGWd2yduTT36lvtLhrwoM/m0DsnknXxvTFtGwTg6qK76iCkoN7hCvLHVdJGzpJ
	+MXp72ZPiBQs8ycUrCzUSVOzq+w7wXy8=
X-Gm-Gg: ASbGnct3CufAAXkA0OzEavCJWGjJRC9AZ638bVMXCUYVvUUJz5oqF3JxnRk7KaZuwlS
	yJ30sjMCHvUVXBUfbqbLwucsYC2U4cMBMzfgr33t0UyAJB7BlfrA5ciHWpmc7MecrJtcGtujbQn
	I8cufE4f9Fy3pUPDR0+W3ST9OKtR/uoJrVgCSvK/TEPmZEdxp8MnGy4KkeBG6fSShsyVGqpy6mx
	mTMEYGO85hK0okHPyY2XR2gJ9nvcbfcoLstNEVcoB3e8c7n2tKI/VKVVrCwJml/gVhG41hOiPbk
X-Google-Smtp-Source: AGHT+IFyyusQp9jVxJoqbcKJt1LGrdYEflLMuoSJ8Py8QQQ6PdrknVOCcNvnUgVhWXQIoX5kkVhJPU1j59NfN4UGYKI=
X-Received: by 2002:a17:90a:e7c9:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-340396c8960mr41024a91.10.1761672262000; Tue, 28 Oct 2025
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027232206.473085-6-roman.gushchin@linux.dev>
 <5e97ecea6574f100385cb21507076c6efb2667eb9def24f322306be038e98165@mail.kernel.org>
 <87o6pruf9j.fsf@linux.dev>
In-Reply-To: <87o6pruf9j.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 10:24:05 -0700
X-Gm-Features: AWmQ_bk6C1eqilbaEGQX1H9gGHgUPIMiUUod78Q2POZa47mMAp7WiEEcnvZm4YA
Message-ID: <CAEf4BzZu_mmUa6n=kKJBgivKpKh3R3c8TcKwGnKdAV1WenuUAA@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] libbpf: introduce bpf_map__attach_struct_ops_opts()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, surenb@google.com, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	andrii@kernel.org, inwardvessel@gmail.com, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org, 
	song@kernel.org, memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:07=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> > ```
> > commit b58d54ed56054e3a550e02c324982feb20a2671e
> > Author: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > libbpf: introduce bpf_map__attach_struct_ops_opts()
> >
> > This commit introduces a new API function that extends the existing
> > bpf_map__attach_struct_ops() to accept additional options, specifically
> > allowing attachment of struct_ops maps to cgroups via a relative_fd.
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index b90574f39..be56a5dee 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -13196,12 +13196,19 @@ static int bpf_link__detach_struct_ops(struc=
t bpf_link *link)
> >>      return close(link->fd);
> >>  }
> >>
> >> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map=
)
> >> +struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map=
 *map,
> >> +                                             const struct bpf_struct_=
ops_opts *opts)
> >>  {
> >> +    DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> >>      struct bpf_link_struct_ops *link;
> >>      __u32 zero =3D 0;
> >>      int err, fd;
> >>
> >> +    if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
> >> +            pr_warn("map '%s': invalid opts\n", map->name);
> >> +            return libbpf_err_ptr(-EINVAL);
> >> +    }
> >> +
> >>      if (!bpf_map__is_struct_ops(map)) {
> >>              pr_warn("map '%s': can't attach non-struct_ops map\n", ma=
p->name);
> >>              return libbpf_err_ptr(-EINVAL);
> >
> > [ ... ]
> >
> >>      link =3D calloc(1, sizeof(*link));
> >>      if (!link)
> >>              return libbpf_err_ptr(-EINVAL);
> >
> > Should this return -ENOMEM instead of -EINVAL? All other calloc failure=
s
> > in libbpf.c return -ENOMEM (see lines 11006, 11802, 12288, 12746, 12829=
,
> > 12891, 13089, 13129 in the same file).
>
> This code was introduced by e9fc3ce99b34 ("libbpf: Streamline error
> reporting for high-level APIs"), so it's new. I agree that ENOMEM is
> correct, however it might be too late to fix. I'll let libbpf
> maintainers to decide.

yeah, let's fix this to return -ENOMEM

>
> >
> > [ ... ]
> >
> >> -    fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> >> +    link_opts.cgroup.relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> >> +
> >> +    fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);
> >
> > Is the expected_revision field being propagated correctly? The new
> > bpf_struct_ops_opts structure includes an expected_revision field
> > (see libbpf.h), and bpf_link_create() with BPF_STRUCT_OPS reads
> > opts->cgroup.expected_revision (see bpf.c line 889), but this code only
> > sets relative_fd in link_opts. Should it also include:
> >
> >     link_opts.cgroup.expected_revision =3D OPTS_GET(opts,
> >     expected_revision, 0);
>
> Correct, fixed.

I haven't looked at the rest of patches, but this use of relative_fd
seems wrong. relative_fd/relative_id and expected_version are there
for ordering of programs within the same attach target (e.g., same
cgroup). If you just want to specify cgroup to attach to, I think you
should use attr.link_create.target_fd (which is already handled a bit
lower generically)

>
> Thanks!

