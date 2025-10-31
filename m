Return-Path: <cgroups+bounces-11446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BCC22C30
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 01:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61BEC4E2B16
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 00:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE418B0F;
	Fri, 31 Oct 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4LwM/Pa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48281F513
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869136; cv=none; b=mslqEzhJ0UvFWm4AXTn7uGOJjZkwvYzwAoR2YS6MHCaK5/BdxuyMIVtfA3kHqHxQClOhWCtwT1B2FA1hYGZjHQOmum+achIrzFnkprticCE842h7lUWNAU9uC+e8XdHZqUh+Hvbf1gvfJXay+Ebfn+eo8JOzoxAtOF+7wPK7rn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869136; c=relaxed/simple;
	bh=9VKqbvQ0H9Mj3WzCt4xuE6UVqwjCj2GDyeee2UsBLTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuiGGrJo0AH9JRdocuh6+VJ0VDdl6c3qafPy1C8mjtDkosGdU4NSZEAKxwxwtNpXcx0R3t7DxdeODuFnFy5j6UsNAHLPhYqHFIY4wYGoTbMUNg5Xm+Gey6SdnLSVxKbnCsOU+KaH+Pc7Pp4C/enXpF+p/s/ZWp9RlwNwlrQiES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4LwM/Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D5CC2BC86
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761869136;
	bh=9VKqbvQ0H9Mj3WzCt4xuE6UVqwjCj2GDyeee2UsBLTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S4LwM/PacmjvNT/z+BGhXQR0bFJ/AA5NKaymAjclz9J7EzSpv+LW76C4QZcu470KF
	 Wpp/feMOtLlKKVaQLHvyL1Nw6Yfqc3jWAY2q6ccxUV7ao9L4oa7kFRDIe5rgoxd4Q6
	 9ZS/ZlWhsXw6bJkL75nXtbFGUqFdF4YbhGw37wTBuRuRHSFuQnvmR3eOkLmX7oz/dR
	 zKZy2PQgCm3cfb/J84aEubqUhMShsFMkskGYMWuDafUlu+sjxMIpg5jGXsGAmHCBxC
	 RH53HtgXAxUPYGHr+xZ2ce9gGpCfQgT8AYLMGEvnQXQIh626Hu/wb/FvOXp1bNYSDc
	 yqYalBOOJWfEw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c13813464so25996146d6.1
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 17:05:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHhpUc2Z17Ws8OcEf5TAk3DSoLg1yeYcBwAxW1VGlm36UG1nav4s1gWPDhKsHToAOA8fmSxy0t@vger.kernel.org
X-Gm-Message-State: AOJu0YzBu+Ero+4+4TyfEgUsUrsIAK5CfL7RWOPazq2miFMexxaQzZmK
	tZiYqU5foTbMoicd8TY1fnnnJQ4tDmcXW+gIURkJv9+WcYUb0/A3kANlw1ffGtSyD3n4wPrdy6C
	LFyFAS6z0dwV8LctAd7xK7ZyM/9yDcFQ=
X-Google-Smtp-Source: AGHT+IGIzNtfwNoDxezTaQZKGKWrOwEoUfbbhhapkjPj6bQRt6E/XRKTdN4NkyT+j42m2qLXtYIu1gkkBiOYxBVeCbU=
X-Received: by 2002:ad4:5bec:0:b0:87d:ff71:8fe6 with SMTP id
 6a1803df08f44-8802f2fe005mr17787766d6.24.1761869134901; Thu, 30 Oct 2025
 17:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
 <877bwcus3h.fsf@linux.dev> <CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
 <e027a330-8d51-44e5-badc-7c3ec4d41e23@linux.dev>
In-Reply-To: <e027a330-8d51-44e5-badc-7c3ec4d41e23@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 17:05:23 -0700
X-Gmail-Original-Message-ID: <CAHzjS_ub0KBECge8DhaEZts1aYL5bBFaU=fJ3U+ZV5XdSjq1WQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmvv5xFRVlfh5B0U--valCRYKaA4OXxb-nAPkWaZTi3-DVpvDlxN5zRvRE
Message-ID: <CAHzjS_ub0KBECge8DhaEZts1aYL5bBFaU=fJ3U+ZV5XdSjq1WQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:42=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
[...]
>
> The link can be detached (struct_ops's unreg) by the user space.
>
> The link can also be detached from the subsystem (cgroup) here.
> It was requested by scx:
> https://lore.kernel.org/all/20240530065946.979330-7-thinker.li@gmail.com/
>
> Not sure if scx has started using it.

I see. The user space can poll the link fd, and get notified when the
cgroup is removed.

> >
> >> 3) Move the attachment out of .reg() scope entirely. reg() will regist=
er
> >> the implementation system-wide and then some 3rd-party interface
> >> (e.g. cgroupfs) should be used to select the implementation.
> >>
> >>    +: ?
> >>    -: New hard-coded interfaces might be required to enable bpf-driven
> >>       kernel customization. The "attachment" code is not shared betwee=
n
> >>       various struct ops cases.
> >>       Implementing stateful struct ops'es is harder and requires passi=
ng
> >>       an additional argument (some sort of "self") to all callbacks.
> >>
> >> This approach works well for cases when there is already a selection
> >> of implementations (e.g. tcp congestion mechanisms), and bpf is adding
> >> another one.
> >
> > Another benefit of 3) is that it allows loading an OOM controller in a
> > kernel module, just like loading a file system in a kernel module. This
> > is possible with 3) because we paid the cost of adding a new select
> > attach interface.
> >
> > A semi-separate topic, option 2) enables attaching a BPF program
> > to a kernel object (a cgroup here, but could be something else). This
> > is an interesting idea, and we may find it useful in other cases (attac=
h
> > a BPF program to a task_struct, etc.).
>
> Does it have plan for a pure kernel module oom implementation?
> I think the link-to-cgrp support here does not necessary stop the
> later write to cgroupfs support if a kernel module oom is indeed needed
> in the future.

I am not aware of use cases to write OOM handlers in modules. Also
agreed that adding attach to cgroup link doesn't stop us from using
modules in the future.

Thanks,
Song

