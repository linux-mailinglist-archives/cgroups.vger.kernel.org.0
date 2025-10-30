Return-Path: <cgroups+bounces-11435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF09C211E6
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 17:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87D6407B4C
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083113655F4;
	Thu, 30 Oct 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLSYhk4d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202C18859B;
	Thu, 30 Oct 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840841; cv=none; b=Mb7uR6luG/jjl2+w2cGFcq0vctY0aDDiS2eJ4CEs/My4CTgdQJSbhz/Dg3strM8GhhKXflKVfMZeRVzRBwTh5WZ3koLZ4XX8A7coQFrOTHZlfqsae7QIq/Vza6xEdgir6rtOhy7BBOKkKgQfW+CgXwWvcMVsh3w9Hp5vgqtXd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840841; c=relaxed/simple;
	bh=81xY3et/CDlan4zato2VKfVrhsKD6Dy0acKVQafxgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT2/1wRCkDQ+QiOrUWL0PCA65Bylwh58hSQUahhubAq/LjtZ7S4n8CRpiLUDI2xZz97SqkO+NheUTGY3uXgnoG8M+nYhKn8K2OyNuL/EqQakgvA+WjuHhgWcmHrZ/YHMei2n3j/lHrE3sCXcwAkC+PFEXmAwxN8a6FRkHNTF4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLSYhk4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031D3C4CEF1;
	Thu, 30 Oct 2025 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840841;
	bh=81xY3et/CDlan4zato2VKfVrhsKD6Dy0acKVQafxgnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLSYhk4dHqZ1dor08LN5ap2JBv3bG3N0GXsdH6f913EZk4xaZBcnfMvFv1C4K5mgf
	 0xLQloW0iTP/7YCZg/JeYH9gJeTa7h7N4w0pxp0nJ+GhSachiJYzWK4iiimAYxP6Bk
	 y/5NdkYtfklb0hB429t42B+VfjiM8DznMQgWZhOoV60Vg7n+M0HmFiEvSxkHmou7lG
	 GAh3ytHVmPZ97ggPjChUxRXzgaNDIkxXuWhyBxVtYuVJwKTYtWhp1s8xW5PLBi62o+
	 77g5MFoT4CJGhnN6RMNEmD68K1DSQbWOcltqcre4r+Bu5s8cIdfHphXYTbz1qZ9+8Q
	 B9DMm9tFQd4Aw==
Date: Thu, 30 Oct 2025 06:13:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQOOxybyymnUk8fr@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
 <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <aQKGrqAf2iKZQD_q@slm.duckdns.org>
 <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>
 <aQKLCuX5v5aO3fDa@slm.duckdns.org>
 <CAHzjS_uqFLEzvU0PTQiXajdFDsjC4gfk0Z4qMoiRQJ2uVPw6BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHzjS_uqFLEzvU0PTQiXajdFDsjC4gfk0Z4qMoiRQJ2uVPw6BA@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 09:32:44PM -0700, Song Liu wrote:
> If the use case is to attach a single struct_ops to a single cgroup, the author
> of that BPF program can always ignore the memcg parameter and use
> global variables, etc. We waste a register in BPF ISA to save the pointer to
> memcg,  but JiT may recover that in native instructions.
> 
> OTOH, starting without a memcg parameter, it will be impossible to allow
> attaching the same struct_ops to different cgroups. I still think it is a valid
> use case that the sysadmin loads a set of OOM handlers for users in the
> containers to choose from is a valid use case.

I find something like that being implemented through struct_ops attaching
rather unlikely. Wouldn't it look more like the following?

- Attach a handler at the parent level which implements different policies.

- Child cgroups pick the desired policy using e.g. cgroup xattrs and when
  OOM event happens, the OOM handler attached at the parent implements the
  requested policy.

- If further customization is desired and supported, it's implemented
  through child loading its own OOM handler which operates under the
  parent's OOM handler.

> Also, a per cgroup oom handler may need to access the memcg information
> anyway. Without a dedicated memcg argument, the user need to fetch it
> somewhere else.

An OOM handler attached to a cgroup doesn't just need to handle OOM events
in the cgroup itself. It's responsible for the whole sub-hierarchy. ie. It
will need accessors to reach all those memcgs anyway.

Another thing to consider is that the memcg for a given cgroup can change by
the controller being enabled and disabled. There isn't the one permanent
memcg that a given cgroup is associated with.

Thanks.

-- 
tejun

