Return-Path: <cgroups+bounces-11406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A303BC1D67A
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B07403695
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6F63191B0;
	Wed, 29 Oct 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz2iWWUE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6131691D
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772692; cv=none; b=hy532ozjBx7EgaJR16RBTHajRZllQD94O1MquUKSLBRWNIpsMjl2RqmPyf5YMvqMtOIjWOOxUi8iU8lhSZdNkJ9TGn0PrN9W3V5BYwNjAbx+CBJUf8Q8H9p2jDYYxX7iFZSM0EByc9gEhsdN35pVe1uIvSgVyCNSOGZBeiHkGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772692; c=relaxed/simple;
	bh=cuFb2Bmsds1bYdOqwF51q8ehVD++6Lbcv+GiUD2iDHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JA46xcw22LI2h9nRkUOOy7eeMQAJn6Q7cV/iWHMw9UidL2NsihLUXz4tHl9MvoQ3F1HbHqXnLr6kUCevxiSqtNohyLiX8wXaKkeYH8P/5Qf7TtYJ6qm+oI569hzycwW1LRTELnv/wVK9e4DS/rrZ5ittplcMqyodEnRAA3oMFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz2iWWUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B961C116D0
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761772692;
	bh=cuFb2Bmsds1bYdOqwF51q8ehVD++6Lbcv+GiUD2iDHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oz2iWWUE7hccwyVGlEF3r6UTArZdg3Xoc4kGN6SnOifGAXUy5nnqNQpdT1ZZYdhNH
	 n7+ARHzP8KA+6dSTBrMwfQ0nsRTVRfgWX7NvskV9ShfYoZTTn+3YYQSL4Z/fb6cJ0O
	 mhQ3UVOvBzUkbS5ndtq3H6f+lDO+qhoUVWMZImaARjltrf1JStNbt2/uBOET8EGvHv
	 qyzDnipgv3z2ZnOVqbqM/5SH0DTN/Ompe0TdBSDrfcDV1Eui4DfmOQxfNr5nNaUwph
	 kxVRN5GyKlndyD7SYqPlKuvEWIEHdYQaW9aSOxcoEfounAFW5HAnpa+bo6pDMsQydH
	 7iZ7rqV3LttIw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78f30dac856so4602526d6.2
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 14:18:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAEF3+FivvvsXhYF/Ltg9Ra/72te8naI3hws4o35feS6sT3oyM3qq1hM9WRltP5eE56ierxQZE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/PY2QoM7KHziN9pafvQeZ4S42sI7uxMC8zSToHzTemX/4Zhe
	JiqY0JjOFNOZi6Qu2YrkQc1ygT+yxHHGuPTU9XAI3e7Ni9RIPT876sPNX/PCWZwPo6hX21Ys1+c
	AYPnhVsOSIYI2eu2gU28vHQUcD7DjW6w=
X-Google-Smtp-Source: AGHT+IGqt5WH9bVZjwQ7L0MKNy5u5e+ux4TrQuXYXpXYL2H3wSTNJxaAS/0+3Z8ip9WwmuFtQYIJYHWO7C9BhxfqNAU=
X-Received: by 2002:a05:6214:d81:b0:87f:fc07:c51d with SMTP id
 6a1803df08f44-88009c13947mr49538016d6.64.1761772691101; Wed, 29 Oct 2025
 14:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
In-Reply-To: <aQJ61wC0mvzc7qIU@slm.duckdns.org>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 14:18:00 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
X-Gm-Features: AWmQ_bkkCVXDFm03jUeATippuBWXlsBI6kcPhGNhj9qa68CaimgckVtdqRiaqvA
Message-ID: <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Wed, Oct 29, 2025 at 1:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Oct 29, 2025 at 01:25:52PM -0700, Roman Gushchin wrote:
> > > BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> > > struct_ops, which seems to work fine. It'd be nice to align on the sa=
me
> > > approach. What are the benefits of doing this through fd?
> >
> > Then you can attach a single struct ops to multiple cgroups (or Idk
> > sockets or processes or some other objects in the future).
> > And IMO it's just a more generic solution.
>
> I'm not very convinced that sharing a single struct_ops instance across
> multiple cgroups would be all that useful. If you map this to normal
> userspace programs, a given struct_ops instance is package of code and al=
l
> the global data (maps). ie. it's not like running the same program multip=
le
> times against different targets. It's more akin to running a single progr=
am
> instance which can handle multiple targets.
>
> Maybe that's useful in some cases, but that program would have to explici=
tly
> distinguish the cgroups that it's attached to. I have a hard time imagini=
ng
> use cases where a single struct_ops has to service multiple disjoint cgro=
ups
> in the hierarchy and it ends up stepping outside of the usual operation
> model of cgroups - commonality being expressed through the hierarchical
> structure.

How about we pass a pointer to mem_cgroup (and/or related pointers)
to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structures l=
ike
struct file_operations and struct tcp_congestion_ops use this method. And
we can actually implement struct tcp_congestion_ops in BPF. With the
struct tcp_congestion_ops model, the struct_ops map and the struct_ops
link are both shared among multiple instances (sockets).

With this model, the system admin with root access can load a bunch of
available oom handlers, and users in their container can pick a preferred
oom handler for the sub cgroup. AFAICT, the users in the container can
pick the proper OOM handler without CAP_BPF. Does this sound useful
for some cases?

Thanks,
Song

