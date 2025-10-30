Return-Path: <cgroups+bounces-11420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B89C1E5C7
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 05:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED32C4E678D
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8312F60A3;
	Thu, 30 Oct 2025 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeJnR1uN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372672D595B
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798777; cv=none; b=uh8aMzcmMO2XgN8OURg8vBa3cVqxZM4BKrTckUrYhqNI2C5c9Lln79H+nznLhrKhx/yOD7dlvcPwa804uYSD31k3ZoY+timZBYa19r5zf9SdHgbKHRdI6aRK7gzABNx7TIecSd/MmVF15UfymAzHUQWbpJY/tzeXVA3nmcSqbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798777; c=relaxed/simple;
	bh=2+HmoIuuPHdF46s6IU1j+vbuARn+2oyq4R4SBJ4cmyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ/IAhrCWeYXO6Rujd9JZgX9xVf7q8vKnRrbxrEMtfZlcRyR6nl1VHLwqOVfFm89eTz1NemHbSx47EAriIRknL1PIE4iNeAKpX2cRO3L/LLRutgHX8P6+ENeftHR7+7fu6krHHvQfQkLpHenYS0gfnt0jOPKiOJBfyleLWfy5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeJnR1uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D251BC4CEFF
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 04:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761798776;
	bh=2+HmoIuuPHdF46s6IU1j+vbuARn+2oyq4R4SBJ4cmyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WeJnR1uNJXyR/VIiggqLZKlHmEWtr8PryGvaMIFmduLJwWzm1WB3bNYZDNsL28ECc
	 MhDcS0HqaDu4a+jGMxGWRcOc3a9c3WeORfl68Q8MIVrn/3glItC3V/l8jPsSnetLWV
	 jgSiFHeJxzZfa4EdmfRpJBG4t0FtKzgdapHdkjBW7cXdWT+4JnANg3Y3vtkIsobS4G
	 QRziJ5k7RnLY1yelWNmBiZBFq2AxEhu1fa7zdDP4W3M3oplHLpwgHXEML3DEnepGmx
	 4+E3yX35xj2+E7UGfsPtOvB1r4EB9OTEHnDncfql3sxs+0VthaZ7+TzKGffw1AIwEf
	 eXybCRuKBpJRA==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c13813464so11125906d6.1
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJFfOA+Khh24dqPohWwE0IMt3dnqgluxhm3fU4q4OK/c31EVrBQ7QHOFuNXbbtOWP9PfqXEzps@vger.kernel.org
X-Gm-Message-State: AOJu0YyztXFqBdzYD+DaRxVJ01rKCSx6U0dmCWKw1AO69oBwCn7sBj3+
	L6wfRN8nO5ZlwIHNiIEt7ee8BkmpQ5/VVsFbvEct6DZh3CZ9C+y/ydPH69UmTKmttaItjTlg4fK
	Tkh3dVrzyauRXlIhmojsDoJ8vYlPMeQw=
X-Google-Smtp-Source: AGHT+IHloxlOPCQ2Ts01dfa61gbcBoNiGNoZLr759SYfOuTvCEnTg7bX+Fomvk0pFNs84BbMxKlEaTxyHv6uOFm83Y0=
X-Received: by 2002:a05:6214:d4a:b0:798:95da:611f with SMTP id
 6a1803df08f44-880099a7c5amr62818076d6.0.1761798775656; Wed, 29 Oct 2025
 21:32:55 -0700 (PDT)
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
 <aQKLCuX5v5aO3fDa@slm.duckdns.org>
In-Reply-To: <aQKLCuX5v5aO3fDa@slm.duckdns.org>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 21:32:44 -0700
X-Gmail-Original-Message-ID: <CAHzjS_uqFLEzvU0PTQiXajdFDsjC4gfk0Z4qMoiRQJ2uVPw6BA@mail.gmail.com>
X-Gm-Features: AWmQ_bl3_-nL5SrQXZYMREaXDnsMqEHzXuINIJP6UEpQTMQi_qleUcR8dgaKd7g
Message-ID: <CAHzjS_uqFLEzvU0PTQiXajdFDsjC4gfk0Z4qMoiRQJ2uVPw6BA@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 2:45=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 29, 2025 at 02:37:38PM -0700, Song Liu wrote:
> > On Wed, Oct 29, 2025 at 2:27=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > > Doesn't that assume that the programs are more or less stateless? Wou=
ldn't
> > > oom handlers want to track historical information, running averages, =
which
> > > process expanded the most and so on?
> >
> > Yes, this does mean the program needs to store data in some BPF maps.
> > Do we have concern with the performance of BPF maps?
>
> It's just a lot more awkward to do and I have a difficult time thinking u=
p
> reasons why one would need to do that. If you attach a single struct_ops
> instance to one cgroup, you can use global variables, maps, arena to trac=
k
> what's happening with the cgroup. If you share the same struct_ops across
> multiple cgroups, each operation has to scope per-cgroup states. I can se=
e
> how that probably makes sense for sockets but cgroups aren't sockets. The=
re
> are a lot fewer cgroups and they are organized in a tree.

If the use case is to attach a single struct_ops to a single cgroup, the au=
thor
of that BPF program can always ignore the memcg parameter and use
global variables, etc. We waste a register in BPF ISA to save the pointer t=
o
memcg,  but JiT may recover that in native instructions.

OTOH, starting without a memcg parameter, it will be impossible to allow
attaching the same struct_ops to different cgroups. I still think it is a v=
alid
use case that the sysadmin loads a set of OOM handlers for users in the
containers to choose from is a valid use case.

Also, a per cgroup oom handler may need to access the memcg information
anyway. Without a dedicated memcg argument, the user need to fetch it
somewhere else.

Thanks,
Song

