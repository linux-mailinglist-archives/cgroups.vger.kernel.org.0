Return-Path: <cgroups+bounces-11410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390ABC1D7F8
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B63BB47E
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A4274FE8;
	Wed, 29 Oct 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6PhZS4h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559F20C00C;
	Wed, 29 Oct 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774348; cv=none; b=o4nd3wsNIS1e/KvcKZYEDYIg2pDzNSimAChS78zkHRSeKz78JhLtsvJkc0qmasAY/ypOG2sv4HPd/e572CAzZm+05KeY8SOoZagXEVNms+z5ZjK6wYdwYXD+AzeX4BKPO9gw4awDXGGwbjMEZFDLSOFjH9O+/LISFCH/ufdYw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774348; c=relaxed/simple;
	bh=6N/PDZDuG63mYbRBd/5edZFLahJKbOcfDaWvIWC0rbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YELRnYK7FD1pGOImXIKZK+TsTSItThnGP03VfrefJ6Hz3I1I/m4cZHj/oHGD6UrA6lb3rEaTF2t7FQXUtNWvVc8ToFW2kwXa5Jrxz4elNZDCJIaErLfg7Mu8y3d88/hg2SVTseq9P1PpdUMfwamYXzrBx+vMK3mQOIktvmu+FfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6PhZS4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD00C4CEF7;
	Wed, 29 Oct 2025 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774347;
	bh=6N/PDZDuG63mYbRBd/5edZFLahJKbOcfDaWvIWC0rbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6PhZS4h4d4Jm70pbTD/Zfvh2zE6PPSle2THnyGlLX/hJnApn3A30pp1+KONryzHU
	 G4vMy07i+dWaiV9Unw3bEjkSfMgDiy7LXqA56qdwBWgka3hIyIVGQSWk2MePRwBx7j
	 by9zJmb6zmYL8BLUqVOcMrzFgDmqwdvyZ1uVttNzM1bmaEqefuWoie+ML0wRMrF2Jp
	 NH/vu3oNwHKj8LWnuB3SzolEAi4kJY1f79MhEFq0AzJWrGWfNysT9A4kxC/XDJa1LL
	 aZiOGqNN/KPM4BvnP8NrgOWRpUngIuHXzBzvQvMMTuCV6W7F+r9DhOSQfDBE3vgeK3
	 BYINY2jsETllQ==
Date: Wed, 29 Oct 2025 11:45:46 -1000
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
Message-ID: <aQKLCuX5v5aO3fDa@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
 <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <aQKGrqAf2iKZQD_q@slm.duckdns.org>
 <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHzjS_tEYA2oboJ-SPq5wJLJTpJDNiA2Fk1wMRgyEpH0gjZRJw@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 02:37:38PM -0700, Song Liu wrote:
> On Wed, Oct 29, 2025 at 2:27 PM Tejun Heo <tj@kernel.org> wrote:
> > Doesn't that assume that the programs are more or less stateless? Wouldn't
> > oom handlers want to track historical information, running averages, which
> > process expanded the most and so on?
> 
> Yes, this does mean the program needs to store data in some BPF maps.
> Do we have concern with the performance of BPF maps?

It's just a lot more awkward to do and I have a difficult time thinking up
reasons why one would need to do that. If you attach a single struct_ops
instance to one cgroup, you can use global variables, maps, arena to track
what's happening with the cgroup. If you share the same struct_ops across
multiple cgroups, each operation has to scope per-cgroup states. I can see
how that probably makes sense for sockets but cgroups aren't sockets. There
are a lot fewer cgroups and they are organized in a tree.

Thanks.

-- 
tejun

