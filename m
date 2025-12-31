Return-Path: <cgroups+bounces-12840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCACEC2B8
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C9D3062933
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C43280CF6;
	Wed, 31 Dec 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/MiUlto"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B525B663;
	Wed, 31 Dec 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194753; cv=none; b=LyKbk/rMpAYMPEaFFxgC0uuJom1D2I4BqAXaSf55F9klUgIUahAp2FHWHN0+PefkFv7eelMYZqyjaVr0gs0Xdje35QBowf9Q9WPB7oC/FDnDh8hYwv9eWa6fQK4UzwU5fzsiF9xIYcrrUA4YECCOErmHGDnr0H7vCLKWOATqKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194753; c=relaxed/simple;
	bh=3zCSe0pygUa6B0hxj7uhQQbY3y5VvVFZcfM1W6inRQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSUbMSNDHaJA/p34uAz34iuoAsQDxFYLsWElRTT3OBgpCNgIwn6JwpAJVJ/SpSBcWWlQA5KZe25PR4b53xBuWfWCeW+t268u1ecVlD25cj4XzPBqdsS3W6owFD3WUTbywVpb8zpQQznEFxjI39ud+8KgVXvdXnh4fJZxq7r4yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/MiUlto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AAFC113D0;
	Wed, 31 Dec 2025 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767194753;
	bh=3zCSe0pygUa6B0hxj7uhQQbY3y5VvVFZcfM1W6inRQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/MiUltoCktzz6D0wiCqcLuak2qC1jPP+t9uF/Wpp9NyhlhUYJRh4a7DANVK3dS3Y
	 5TBAIkOcZD7Uzm31uIRNg+KPXeRfrFDCHo5KImNpcVVxeo6H0CXL4UnXKcwUINX/Ll
	 U1vQ9nn+42I+5DqP4hDp4p5tUlokQFV23MAaxYG5+JRLq2JJ2SJ1zhhHcouBH7kW4n
	 j7tnzqkJRksmGaZ82fg+JWX+rpM1JKmvmvmVA/5WAT8i/ukuaEkGR1UaA6w9uc8YRq
	 7msaf9wYLApzpxDT1X8VKz50GKA//Mk01dWdH2ak+Kw+9n2yKX+4XwtHIVWi3pdEqj
	 QbzdgFhA2MRZA==
Date: Wed, 31 Dec 2025 16:25:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 33/33] doc: Add housekeeping documentation
Message-ID: <aVVAfb2eaeyd7l-h@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-34-frederic@kernel.org>
 <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>

Le Fri, Dec 26, 2025 at 07:39:28PM -0500, Waiman Long a écrit :
> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++++
> >   Documentation/core-api/index.rst        |   1 +
> >   2 files changed, 112 insertions(+)
> >   create mode 100644 Documentation/core-api/housekeeping.rst
> > 
> > diff --git a/Documentation/core-api/housekeeping.rst b/Documentation/core-api/housekeeping.rst
> > new file mode 100644
> > index 000000000000..e5417302774c
> > --- /dev/null
> > +++ b/Documentation/core-api/housekeeping.rst
> > @@ -0,0 +1,111 @@
> > +======================================
> > +Housekeeping
> > +======================================
> > +
> > +
> > +CPU Isolation moves away kernel work that may otherwise run on any CPU.
> > +The purpose of its related features is to reduce the OS jitter that some
> > +extreme workloads can't stand, such as in some DPDK usecases.
> Nit: "usecases" => "use cases"

Are you sure? I'm not a native speaker but at least the kernel
has established its use:

$ git grep usecase | wc -l
517

> > +
> > +The kernel work moved away by CPU isolation is commonly described as
> > +"housekeeping" because it includes ground work that performs cleanups,
> > +statistics maintainance and actions relying on them, memory release,
> > +various deferrals etc...
> > +
> > +Sometimes housekeeping is just some unbound work (unbound workqueues,
> > +unbound timers, ...) that gets easily assigned to non-isolated CPUs.
> > +But sometimes housekeeping is tied to a specific CPU and requires
> > +elaborated tricks to be offloaded to non-isolated CPUs (RCU_NOCB, remote
> > +scheduler tick, etc...).
> > +
> > +Thus, a housekeeping CPU can be considered as the reverse of an isolated
> > +CPU. It is simply a CPU that can execute housekeeping work. There must
> > +always be at least one online housekeeping CPU at any time. The CPUs that
> > +are not	isolated are automatically assigned as housekeeping.
> Nit: extra white spaces between "not" and "isolated".

Somehow it has disappeared in my tree, some Brunaidh must have fixed
that while I was sleeping. That's nice!

> > diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> > index 5eb0fbbbc323..79fe7735692e 100644
> > --- a/Documentation/core-api/index.rst
> > +++ b/Documentation/core-api/index.rst
> > @@ -25,6 +25,7 @@ it.
> >      symbol-namespaces
> >      asm-annotations
> >      real-time/index
> > +   housekeeping.rst
> >   Data structures and low-level utilities
> >   =======================================
> Acked-by: Waiman Long <longman@redhat.com>

Thanks! 

-- 
Frederic Weisbecker
SUSE Labs

