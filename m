Return-Path: <cgroups+bounces-10823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 212ABBE4324
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A78508096
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302C34AB0D;
	Thu, 16 Oct 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oOhTfCH5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBD346A0B
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628013; cv=none; b=syP+gA1b4CW/Ns/cHDHhFt2VtC+sqHjvX6+e6sr8q18AYmRFbLkXGzMqckkSeBGN9JSBYjpao6HfAJ7luyff9XNbZStJRsm8cn8ZrH/KHNKNQIflcX2pJ9cMMVX2BKEli4815CYN/bL2xqYjisMUBgwFtjEr27+XmOLhIPtddh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628013; c=relaxed/simple;
	bh=26jMUirKm+wIcrOSVQs8OZfr8lpMDHr014+xgDjz4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF7CbbJdQUBEg5aiF28Bgezq9pwR2rzladkkIcDmLTXDMFJiizXCCrOHn/X11/pM1Y+KmcbW3F+hRvfKkKaJ9RKLdHg9ORL5bhI8UPr5naCJcQV00Oub/TyTeWKSroXMvPQsbwwplI6NRc9FDJJdGSPzrm76T7Z9G0IEtyStSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oOhTfCH5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Oct 2025 08:19:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760627997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QydR/KidQ4HbXgklyLOEDbEgV2E+0HwjNzOJIhpMJek=;
	b=oOhTfCH5EcpmQIxThSointcsUzwwnMSWi2CVXUO3PAtN+tFAYj9JaQ83LL0qfezHl/X4qC
	KcOGJaj4y5BDDBHzk/TWudw0ZtGEMPKwxQ/S+/COqxS4zKQi77ZoqvSATgBXPxLOpLCJz8
	b1rMJc0HzKqMJEI24QKprikEqPRDCDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Matyas Hurtik <matyas.hurtik@cdn77.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weibunny@meta.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory
 pressure
Message-ID: <ucymjttvagptmpmf623q3zhsoxfhes6kprsgfbdtr5rf3otat7@trcc4vhtyswa>
References: <20251016013116.3093530-1-shakeel.butt@linux.dev>
 <87o6q77hfn.fsf@linux.dev>
 <CAAVpQUBXzBKfbH_iqn78k6d7ys9DNrXTVbnYSD4ecuKwgCwk8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBXzBKfbH_iqn78k6d7ys9DNrXTVbnYSD4ecuKwgCwk8A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 10:46:54PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Oct 15, 2025 at 6:40 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Shakeel Butt <shakeel.butt@linux.dev> writes:
> >
> > > The kernel can throttle network sockets if the memory cgroup associated
> > > with the corresponding socket is under memory pressure. The throttling
> > > actions include clamping the transmit window, failing to expand receive
> > > or send buffers, aggressively prune out-of-order receive queue, FIN
> > > deferred to a retransmitted packet and more. Let's add memcg metric to
> > > indicate track such throttling actions.
> > >
> > > At the moment memcg memory pressure is defined through vmpressure and in
> > > future it may be defined using PSI or we may add more flexible way for
> > > the users to define memory pressure, maybe through ebpf. However the
> > > potential throttling actions will remain the same, so this newly
> > > introduced metric will continue to track throttling actions irrespective
> > > of how memcg memory pressure is defined.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst | 4 ++++
> > >  include/linux/memcontrol.h              | 1 +
> > >  include/net/sock.h                      | 6 +++++-
> > >  kernel/cgroup/cgroup.c                  | 1 +
> > >  mm/memcontrol.c                         | 3 +++
> > >  5 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 0e6c67ac585a..057ee95e43ef 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1515,6 +1515,10 @@ The following nested keys are defined.
> > >            oom_group_kill
> > >                  The number of times a group OOM has occurred.
> > >
> > > +          socks_throttled
> > > +                The number of times network sockets associated with
> > > +                this cgroup are throttled.
> >
> > I'd prefer sockets_throttled or sock_throttled. And same for the
> > constant name.
> >
> > Otherwise,
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> +1 for sock_ like "sock" in memory.stat and its MEMCG_SOCK.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> 

Thanks Roman and Kuniyuki, will change the name to sock_throttled in v2.

