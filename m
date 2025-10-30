Return-Path: <cgroups+bounces-11437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DADC219E7
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35AE1889384
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB936E34F;
	Thu, 30 Oct 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNy1TNIH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015136CE0C
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847018; cv=none; b=sqBFMHxgoqUrz08jasGMfyvU09WznK2UOsFnt+Bz5qsy9dNz362Ucxd/XlmMXctsyekAosw1b8+/wqqGAcKcUtxf/m+x3PAYLirZJhkWrVc9jTrzWMgZuGJ2UgtIFVlk7VF0hypu1t0PpQuuUUmsQXoUyrr/5R014i8rQyZC/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847018; c=relaxed/simple;
	bh=L4e38dPwrZFuVUdrOXcK15IuGB2HADfsVSi/LH7EXVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc9Xt3XK4It/lnK1qddglY4vdGj3I6tj2vMO85V1jSInLhHD1ncY8U6UsLKM5f91738giDCe8wEGUhInMkQcSV9TBEZ7Zb+ECA5bfLCiy3dkakzWoItLYJgNQrXL5hQjSHhif3H+Bxy7HcZKLkiJSG6i5w027Yav4a2uPFmi1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNy1TNIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25744C19424
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847018;
	bh=L4e38dPwrZFuVUdrOXcK15IuGB2HADfsVSi/LH7EXVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bNy1TNIHT4oh1zNcC8sVErbqeUGH0NdpOLL23T5ZLdkao4z9GIIVqIiseSkcpwvnR
	 ODrApNwOMu49aC8f4/Ay41C2Z5Rl/jRXuTbwc9uutwpuYKYafqz0lfzpHPZaFkjPBq
	 /Gv6wJwGllB3EB5b7c/8Udarnxn4FJqQmba34/yh/jurgpBWzaUJ4WEGVxChmZmPJy
	 Lbw1PHiI9glZW16qK1noe35LNZQ++1PZHp+hRcUyFMgZh4Ha0OmebYoBHW3ZaQiJcs
	 pGoSX9w/5hQsrXHv9WVMNE0RFVMjDdhb6XaZv79XOUPhKxk0fCz2g8LLZt+FKlZGZT
	 lHoN6TphqhRWw==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87a092251eeso31314566d6.0
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 10:56:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWn1pleAHES4CSilgHUsbpGyyG6y+YOSbraGu6VEZ39NPVkM6gT4r9ZGoYcqsUKS0yjL2/0licH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhv2FeT9J6I5cnDMm6o+BlR8AvHduyBJRLRKyA2N0tbR6AmTT
	QWfaAz4fsu0yXVIiFpuwWglI5wvm4T8NUbIDKaoANNhE8BBHMBeeA6lnvo9j5tpZWKgbXwZfk5M
	7kD2xwqRs6fQKpejse4VuKS+funG1WeU=
X-Google-Smtp-Source: AGHT+IGYyUVn099A8jUIhDfDtH7YzdBkaylMEjjWSMZn4ZGTG4lQaMNVRWm1lO7yUAm0bhxQuqgolicbaQLQisRUzJg=
X-Received: by 2002:ad4:5e87:0:b0:87c:2405:5d93 with SMTP id
 6a1803df08f44-8801ace00d3mr46673516d6.26.1761847017110; Thu, 30 Oct 2025
 10:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <aQKGrqAf2iKZQD_q@slm.duckdns.org> <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>
 <aQKLCuX5v5aO3fDa@slm.duckdns.org> <CAHzjS_uqFLEzvU0PTQiXajdFDsjC4gfk0Z4qMoiRQJ2uVPw6BA@mail.gmail.com>
 <aQOOxybyymnUk8fr@slm.duckdns.org>
In-Reply-To: <aQOOxybyymnUk8fr@slm.duckdns.org>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 10:56:46 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vp3xpCx8w9k7ct1RHOLnwu5og59Uxqs9DE_Ye06x3m4w@mail.gmail.com>
X-Gm-Features: AWmQ_bkz9aBpQvreSJqyHHlBR3lFj06W4EhoUxVWBl9_g8_PXU87iBGP0a7GP5w
Message-ID: <CAHzjS_vp3xpCx8w9k7ct1RHOLnwu5og59Uxqs9DE_Ye06x3m4w@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Song Liu <song@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:14=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 29, 2025 at 09:32:44PM -0700, Song Liu wrote:
> > If the use case is to attach a single struct_ops to a single cgroup, th=
e author
> > of that BPF program can always ignore the memcg parameter and use
> > global variables, etc. We waste a register in BPF ISA to save the point=
er to
> > memcg,  but JiT may recover that in native instructions.
> >
> > OTOH, starting without a memcg parameter, it will be impossible to allo=
w
> > attaching the same struct_ops to different cgroups. I still think it is=
 a valid
> > use case that the sysadmin loads a set of OOM handlers for users in the
> > containers to choose from is a valid use case.
>
> I find something like that being implemented through struct_ops attaching
> rather unlikely. Wouldn't it look more like the following?
>
> - Attach a handler at the parent level which implements different policie=
s.
>
> - Child cgroups pick the desired policy using e.g. cgroup xattrs and when
>   OOM event happens, the OOM handler attached at the parent implements th=
e
>   requested policy.

OK, using xattrs is another way to achieve this.

> - If further customization is desired and supported, it's implemented
>   through child loading its own OOM handler which operates under the
>   parent's OOM handler.
>
> > Also, a per cgroup oom handler may need to access the memcg information
> > anyway. Without a dedicated memcg argument, the user need to fetch it
> > somewhere else.
>
> An OOM handler attached to a cgroup doesn't just need to handle OOM event=
s
> in the cgroup itself. It's responsible for the whole sub-hierarchy. ie. I=
t
> will need accessors to reach all those memcgs anyway.
>
> Another thing to consider is that the memcg for a given cgroup can change=
 by
> the controller being enabled and disabled. There isn't the one permanent
> memcg that a given cgroup is associated with.

In the current version, bpf_oom_ops is attached to the memcg. As long as
we feed a pointer to memcg to all struct_ops functions, these functions
can be implemented in a stateless way. I think having the option to do
this stateless implementation will help us in the long term.

Thanks,
Song

