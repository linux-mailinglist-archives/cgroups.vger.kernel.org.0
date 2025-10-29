Return-Path: <cgroups+bounces-11409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC730C1D755
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D153A72F6
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8531A053;
	Wed, 29 Oct 2025 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjMn/gm/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931C31283D
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773870; cv=none; b=RIaDkp1RQDA49bQZ5fV2NWp5tS085HT1h8qmxe1FWVgiI1BM4+ULZ6+ZI1w+hYOvLn0jtE+ZjEdYLU7n28IQmopJ2287y4O8Wqh3Xv0yqyRlrvmsu4RlTqaWHa9V2AboBz+FHrln0zJdb7uibgk/nTngvY5dJTEmgtU6fk9xtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773870; c=relaxed/simple;
	bh=2m6E3KOecuxoequ8DNsV+fUpEVK37fOzsOWy6portyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/Pg7LuLJlvWl21LZCU/v6u9u7UucnoBLRC2ckubil9bXZV2rOGze34KuidoDAkLq2scLmLHfA7R66cz/+N55qjM8bxsF2uaYY/As1CKbE4U8PdU8wty7UUpR4gwOhL7Uio5aBJ5iRBm22onb6qKOBj6IOrSTPUZGqt4kwhp6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjMn/gm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A4CC19421
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761773870;
	bh=2m6E3KOecuxoequ8DNsV+fUpEVK37fOzsOWy6portyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fjMn/gm/CDewlocIko0JwpcUbQNTVXJfqhcLmVmlIxZ6TEhg012hI0UEbsfewfbTt
	 NEyzf/ciIDB8DT5NwyBP5NPO8ILWXAt1x7lpFo9imF6bbuGnHyJ/mm9OCM9/UqxEPe
	 plTDtO4nfJPJ8wxcKHUSEtnGNQ7iq5GlRWi3es698U/Sc1WL9UsfXczphrDyg8BanY
	 DVLK+k+n74VW2UgrrsiUeRKXL1OSpeGiQ61wxlR43E3jshlTrZft9QUKvMIBWF7s3j
	 c9MKG+ZSAKw7+Spt9tjivzpDHxKdgWQp2aBUkFEh3LOxq9paAqCf3V2B3kLGCpbR3f
	 kb7GKkZj7Y+XA==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ecf0336b61so2312031cf.0
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 14:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDf6zeKjQSZAgwBHo73Y8rAP/azsVKILsMEqOs8lART82+VkngxjGXQt/2xVGua/omKtdeInXA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sT9/ZGMYCsvqyIjzpPjAq23qwgzMWKvIgZGoaMLUFud1AhgG
	q1gHMz8/MKJv+rHtNhLsYxgNNagClAoueqKbndtqST8Sz/RulyCvisR2L1KbtVS+y7w0CJhwYWR
	fAjmGTJQ2U2P+QCKyAqHK5WNqTlWBjSc=
X-Google-Smtp-Source: AGHT+IHf7xJb92TiwVJcd4HpaDmN2Evk7yYp3/gpWQvWWAHb0Jqi2EVJBlDw942F/nUwWhx1w32vHDcnFFGm0iLiRgo=
X-Received: by 2002:ac8:7dc2:0:b0:4e8:acc0:1e86 with SMTP id
 d75a77b69052e-4ed15c1cd6emr57252001cf.45.1761773869510; Wed, 29 Oct 2025
 14:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com> <aQKGrqAf2iKZQD_q@slm.duckdns.org>
In-Reply-To: <aQKGrqAf2iKZQD_q@slm.duckdns.org>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 14:37:38 -0700
X-Gmail-Original-Message-ID: <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>
X-Gm-Features: AWmQ_bnEP6btBVaHkNJVps6IoG-AZx4A3wkxixrfqUMH1dY2e5xFkESMzpATyCo
Message-ID: <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 2:27=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 29, 2025 at 02:18:00PM -0700, Song Liu wrote:
> ...
> > How about we pass a pointer to mem_cgroup (and/or related pointers)
> > to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structur=
es like
> > struct file_operations and struct tcp_congestion_ops use this method. A=
nd
> > we can actually implement struct tcp_congestion_ops in BPF. With the
> > struct tcp_congestion_ops model, the struct_ops map and the struct_ops
> > link are both shared among multiple instances (sockets).
> >
> > With this model, the system admin with root access can load a bunch of
> > available oom handlers, and users in their container can pick a preferr=
ed
> > oom handler for the sub cgroup. AFAICT, the users in the container can
> > pick the proper OOM handler without CAP_BPF. Does this sound useful
> > for some cases?
>
> Doesn't that assume that the programs are more or less stateless? Wouldn'=
t
> oom handlers want to track historical information, running averages, whic=
h
> process expanded the most and so on?

Yes, this does mean the program needs to store data in some BPF maps.
Do we have concern with the performance of BPF maps?

Thanks,
Song

