Return-Path: <cgroups+bounces-11399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27902C1CAB5
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 375DF4E668E
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FADF354AEF;
	Wed, 29 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgJGfjhJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C512354702
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760873; cv=none; b=aDEhDes7WZeYEqsH6EXw0G3yIrPrRQuhKtF/8Z24FhqG7Nv+1JEBapxlP8KqUjXFiuKs9phA/YIc+YeWkgsFAqudAbltToBy4bSmtVntEeVquc0iu2WflbdumwvtZqo2FdXSB7/W2rvhBCrKDhyPtrqn7GGxzfoMOKz4dUZDCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760873; c=relaxed/simple;
	bh=JkICoGulKusPgrOc+3fQ7LIX9fdSC22eFlUBUNRokJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGkDHBBAIOFcj2/a73h95WefKJ5c+8GDyn1Ti2uysOW2b4RbEoWkXF3djGsOjd3a994RbqwXi0ey1ftX4BDqMAv4ytuZwuGJcf4wFcNyNTWwEYVIvX4vVeMCGyRarGI9btGSGoas7Mk19qKUS5rC/fmneHiwYFxbFmfKsiC7M6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgJGfjhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2F5C4CEFF
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760872;
	bh=JkICoGulKusPgrOc+3fQ7LIX9fdSC22eFlUBUNRokJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgJGfjhJaNs4l82+eMSh2r1EAx9uk5HPJAyypHw9PeFAnh2Pd/T9Ut6BEUZDAxvMW
	 C51qBFa5otR/uKQ7dcLeycr0Ay+T0GY6ye9UTaCGCjrJu/lkMmwtbaJOSfdo3XJHd1
	 ObCh5UYVDwzRvT+NLz+PqSgB5CBSK1564+6og8MbDc86VgxBGBy1xAjPIcIDlPsT0u
	 hW5hzztdbZa2bABOBiKSqpn0d4KBxiMJThHlo5sPOMM2g34vAqpZgX63HfzlaZ4nN2
	 H0VO0XKTKApg1SgG+qo2ojtqWg35sQ3GMu5U4W5++yNuGiU1RZ3tsm73dC8fHRQsUt
	 ASSg8KjoiFbFg==
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-934bbe85220so66619241.3
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 11:01:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNd7n10g7IJM1qVsJJEbFlpNsfsQwg5q/iSnf/CLhWfW+RQG2RgwBy0gtUEyJggU+1nnCMMmfw@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbBhJb1kfplZAVffdB7IZwuVh82kaXMWaqlwXug3f6W9/Uc20
	so6UKJTq6phHX/NLPobSV02v8QB7d/QTalHBIwqRnOZ7v5zIjjVbLI46yeuVpQvK9qIR3ZTIqZc
	fx5swklZAp+GZQwAG6H1Q38kKc/wszew=
X-Google-Smtp-Source: AGHT+IGGluDTc586NCbCdlpQu935QL/Y8fXJ0sSPv0be/Dt3sEhhVMZJsoK1V7je9HKakunNObg8WJdRv0NwLivAn6M=
X-Received: by 2002:a05:6102:2c06:b0:5d6:6e6:e097 with SMTP id
 ada2fe7eead31-5db906819d1mr1467428137.33.1761760871248; Wed, 29 Oct 2025
 11:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-3-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 11:01:00 -0700
X-Gmail-Original-Message-ID: <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
X-Gm-Features: AWmQ_bmAg580HVj5YBdyFsS189BaIn-vGa9b15QV_82EsPqPQmTP0zb5M7q-qAQ
Message-ID: <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
[...]
>  struct bpf_struct_ops_value {
>         struct bpf_struct_ops_common_value common;
> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>         }
>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL,
>                       attr->link_create.attach_type);
> +#ifdef CONFIG_CGROUPS
> +       if (attr->link_create.cgroup.relative_fd) {
> +               struct cgroup *cgrp;
> +
> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup.rela=
tive_fd);

We should use "target_fd" here, not relative_fd.

Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
global memcg.

Thanks,
Song

> +               if (IS_ERR(cgrp))
> +                       return PTR_ERR(cgrp);
> +
> +               link->cgroup_id =3D cgroup_id(cgrp);
> +               cgroup_put(cgrp);
> +       }
> +#endif /* CONFIG_CGROUPS */
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> --
> 2.51.0
>

