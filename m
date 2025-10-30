Return-Path: <cgroups+bounces-11441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F1C226D3
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 22:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67AAA344827
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D722FD7B2;
	Thu, 30 Oct 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVkgTo8z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90D2D94A0
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860062; cv=none; b=fJMSIXL6JxnUOm9gmXZQDszFvqga+dNVD0xfTL/RdoHQRFQijBOgnU0V0lG86AgTz4x8+65nvlv4rTNYxEFwlha5/XCAHbrJlCIOeHDWz0gBXLFDAy5vAx4JTePriLCQAKpY37XjxehXCpXTsfvkd9Hy6T7HpfFiJb5x+jDUjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860062; c=relaxed/simple;
	bh=vA3cQcFFKPHYjkv/o095+U48maXEWxIDrmI8GV0FkR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcUZfTW1wP2sEXidvL6O7DpUnIJgwMiiGHAuLU7aHDJAPqoIVXSCHePJrb+1S+rUGn8cCLsFfyQm/TgEn5Jq2ifviOjd8LlUMgTjZoP35ijMQ3F9NquS02uKD2pSQ/HoNEo5dZ2dnF9FYApa+qh2txO6yP2wquCRgZSUCq/cet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVkgTo8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733F2C4CEFD
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761860062;
	bh=vA3cQcFFKPHYjkv/o095+U48maXEWxIDrmI8GV0FkR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NVkgTo8zsh/oLtwCRGHu02MRlHkXjU+0bxw2XcUHuagq5PJLN22kQBFZbdeMY7efS
	 2MTJdgK0VYBtO97xuZ0uisPN4RrlxI/WvEcHqfuhrvNI/Y5a97boExAn4Ycg6oVNob
	 c02S5GXecCSsPAreWAfcsKrMVgQHvlf4rczHVAD6J79JtcmY7HPuo3NeP/vRGVLLEz
	 s4gfZsgjB54VRsiZrOJ1pViSDlr3dOfKN7Lk3KIpofVaxxCTc4e7BeCm9SUcQFrJyp
	 3NLPq2OIweWu/X2DT2D4jEpFhoyzaTcyKLubXPmJ4jVQBZUGX2dSXTf/JHgC7QaGFz
	 krQmQNvq4YLtA==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c0ea50881so24147986d6.2
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 14:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVknch5CwvTFI6T4nRsYiiB0QemxxnrA7F+PEhg+5xizbYski1LfjfkvUKMkEqlgtZE89WvETtd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj62jfCshuWaJUxtyYyBxxYVhHd2yj3CCvlJznWYo/6MubfpUM
	NtP3glO57570xOaCwD+0UmtR9OoPcAE1IA1Hov2os5uwj2Jxm7Nn0/1mV8kkQhxjAOm7cREk5J9
	ycVesCqr4gQVCyku5dQnoLd8aXVJQNys=
X-Google-Smtp-Source: AGHT+IHMkX2vgEpmo54ScXG2z+0WIl2vpMLiW/fIKrF0LrJBFRJd62XKtruZSD0g4dhRrF2T+Nff4509mwhwddlY7x4=
X-Received: by 2002:a05:6214:21e2:b0:87f:c009:79cc with SMTP id
 6a1803df08f44-8802f4db53cmr14665996d6.51.1761860061351; Thu, 30 Oct 2025
 14:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com> <877bwcus3h.fsf@linux.dev>
In-Reply-To: <877bwcus3h.fsf@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 14:34:10 -0700
X-Gmail-Original-Message-ID: <CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
X-Gm-Features: AWmQ_bk7HNuiosItrXA1dyLcCJexg7C-WNSjzhjZ-UrPmMqZcQrRacrRjcLhdZg
Message-ID: <CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Thu, Oct 30, 2025 at 12:07=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
[...]
> > In TCP congestion control and BPF qdisc's model:
> >
> > During link_create, both adds the struct_ops to a list, and the
> > struct_ops can be indexed by name. The struct_ops are not "active" by
> > this time.
> > Then, each has their own interface to 'apply' the struct_ops to a
> > socket or queue: setsockopt() or netlink.
> >
> > But maybe cgroup-related struct_ops are different.
>
> Both tcp congestion and qdisk cases are somewhat different because
> there already is a way to select between multiple implementations, bpf
> just adds another one. In the oom case, it's not true. As of today,
> there is only one (global) oom killer. Of course we can create
> interfaces to allow a user make a choice. But the question is do we want
> to create such interface for the oom case specifically (and later for
> each new case separately), or there is a place for some generalization?

Agreed that this approach requires a separate mechanism to attach
the struct_ops to an entity.

> Ok, let me summarize the options we discussed here:

Thanks for the summary!

>
> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
> itself. The attachment is happening at the reg() time.
>
>   +: It's convenient for complex stateful struct ops'es, because a
>       single entity represents a combination of code and data.
>   -: No way to attach a single struct ops to multiple entities.
>
> This approach is used by Tejun for per-cgroup sched_ext prototype.
>
> 2) Make the attachment details a part of bpf_link creation. The
> attachment is still happening at the reg() time.
>
>   +: A single struct ops can be attached to multiple entities.
>   -: Implementing stateful struct ops'es is harder and requires passing
>      an additional argument (some sort of "self") to all callbacks.
> I'm using this approach in the bpf oom proposal.
>

I think both 1) and 2) have the following issue. With cgroup_id in
struct_ops or the link, the cgroup_id works more like a filter. The
cgroup doesn't hold any reference to the struct_ops. The bpf link
holds the reference to the struct_ops, so we need to keep the
the link alive, either by keeping an active fd, or by pinning the
link to bpffs. When the cgroup is removed, we need to clean up
the bpf link separately.

> 3) Move the attachment out of .reg() scope entirely. reg() will register
> the implementation system-wide and then some 3rd-party interface
> (e.g. cgroupfs) should be used to select the implementation.
>
>   +: ?
>   -: New hard-coded interfaces might be required to enable bpf-driven
>      kernel customization. The "attachment" code is not shared between
>      various struct ops cases.
>      Implementing stateful struct ops'es is harder and requires passing
>      an additional argument (some sort of "self") to all callbacks.
>
> This approach works well for cases when there is already a selection
> of implementations (e.g. tcp congestion mechanisms), and bpf is adding
> another one.

Another benefit of 3) is that it allows loading an OOM controller in a
kernel module, just like loading a file system in a kernel module. This
is possible with 3) because we paid the cost of adding a new select
attach interface.

A semi-separate topic, option 2) enables attaching a BPF program
to a kernel object (a cgroup here, but could be something else). This
is an interesting idea, and we may find it useful in other cases (attach
a BPF program to a task_struct, etc.).

Thanks,
Song

