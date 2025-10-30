Return-Path: <cgroups+bounces-11438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF5C21B3F
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 19:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BB354ECBF6
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4C23B607;
	Thu, 30 Oct 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHGz/OkY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28951DB127
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847429; cv=none; b=HE3fs9Lv6p4uZjygLOztCGWmRBdS0swF6UXMb0cfJGdlj3fpVrKwYjIRRVc8bjtkcQkSkuUnaVubH/R4PTfZc7Bilak3+kzMPg21lc529oNiCAoOrb+Zp5mEbH2+gj49bnQFtMsaDRfXyTV2x3vkInqlYR8Rpv/4OuzbAtB8ECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847429; c=relaxed/simple;
	bh=d5pYIM+DlvI/eeXCbPFua+nftpLWGhp6JWVLglPWRyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWn00eJanlsKfsQAXzPBH6ksNYBP9wgp/bATlihi/c92W1btZOhysaVTeE+UFi1rhicpRQnLc6+ErwuPH6HhbRAWtLOEwU9vOS9W6J8LMC2Wicmd7i6+Red/dhsE56t0dhUJXuZEC22T2V4QLXVWOpWz45QdQI9L3rHYYRPl7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHGz/OkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D63C19421
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847428;
	bh=d5pYIM+DlvI/eeXCbPFua+nftpLWGhp6JWVLglPWRyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IHGz/OkYI+QItig99Q9PGNA+cMatvujXM/apZeeTMF0iX7kTQifeSPHY1QLmrhO7o
	 tAt55mrv91Obwlxr6fAsubSGK0TSLM2i9twln8XyjLSpMPgjpmMS4vGXX2OnYYkH7H
	 AaktQisIQOnrEsDJ0sDDutbevtTsF0G/bZSP1lxWZVPyTfbcHGAkt2GNvkg8YNQR6d
	 tZ+hFuKhsFEi11PaRCUeJ8ILOqbq+SaUpeziVRMxGzaDaQBFG2/EwWeP3cPPQ/yRD+
	 ZNtt4nptVYiETD3+jemBJd7mzeDh3DHpnesDiuiHzfRZudaZ09Hvy9CgoP5eqGm32G
	 Plt/idPH+L+sQ==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7f7835f4478so11305126d6.1
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+k9sJqkJsH8RudXXylFeGEUXAwWewXUJNrigcaS375rR+CJV7ITLrZ9MAL32cFO5PyqTx7X2B@vger.kernel.org
X-Gm-Message-State: AOJu0YwjU1ZDOUEFbtaUZVbkLbN/L7fs2S520eLiY5CGsqXMWpsUUkz1
	ztx0h1LDtU7DhgPJUPx6tmSHQAOAt7x4BeyyePEC/IvmzUq/eY6ZmyxmDW74/PxyVXpvR61Lfj/
	Ur27PrdIi+xWIWoJrNKU5J8smVrGDGMA=
X-Google-Smtp-Source: AGHT+IHhsYhWatkhUtR9Thi3jups/Zf6twLHgbotCak5ADv4q6trdZ9jUiXcieO2Ocfd/pZQOSvORcXRaoUyXxEzlH0=
X-Received: by 2002:ad4:5cad:0:b0:880:2582:b7b5 with SMTP id
 6a1803df08f44-8802f2f3cc5mr7911166d6.23.1761847427883; Thu, 30 Oct 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev>
In-Reply-To: <87zf98xq20.fsf@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 11:03:36 -0700
X-Gmail-Original-Message-ID: <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
X-Gm-Features: AWmQ_bmwqDpuhyP64DRlFdaSqpW8LEt5_ngM2TCJT1ee3IRNDHD_d8LbTVxeNBg
Message-ID: <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:22=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > [...]
> >>  struct bpf_struct_ops_value {
> >>         struct bpf_struct_ops_common_value common;
> >> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *=
attr)
> >>         }
> >>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_stru=
ct_ops_map_lops, NULL,
> >>                       attr->link_create.attach_type);
> >> +#ifdef CONFIG_CGROUPS
> >> +       if (attr->link_create.cgroup.relative_fd) {
> >> +               struct cgroup *cgrp;
> >> +
> >> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup.r=
elative_fd);
> >
> > We should use "target_fd" here, not relative_fd.
> >
> > Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
> > global memcg.
>
> Yep, but then we need somehow signal there is a cgroup fd passed,
> so that struct ops'es which are not attached to cgroups keep working
> as previously. And we can't use link_create.attach_type.
>
> Should I use link_create.flags? E.g. something like add new flag
>
> @@ -1224,6 +1224,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER            (1U << 4)
>  #define BPF_F_ID               (1U << 5)
>  #define BPF_F_PREORDER         (1U << 6)
> +#define BPF_F_CGROUP           (1U << 7)
>  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>
> and then do something like this:
>
> int bpf_struct_ops_link_create(union bpf_attr *attr)
> {
>         <...>
>         if (attr->link_create.flags & BPF_F_CGROUP) {
>                 struct cgroup *cgrp;
>
>                 cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
>                 if (IS_ERR(cgrp)) {
>                         err =3D PTR_ERR(cgrp);
>                         goto err_out;
>                 }
>
>                 link->cgroup_id =3D cgroup_id(cgrp);
>                 cgroup_put(cgrp);
>         }
>
> Does it sound right?

I believe adding a flag (BPF_F_CGROUP or some other name), is the
right solution for this.

OTOH, I am not sure whether we want to add cgroup fd/id to the
bpf link. I personally prefer the model used by TCP congestion
control: the link attaches the struct_ops to a global list, then each
user picks a struct_ops from the list. But I do agree this might be
an overkill for cgroup use cases.

Thanks,
Song

