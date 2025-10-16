Return-Path: <cgroups+bounces-10799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A59BE12E4
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 03:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37ECF4E6D4C
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF99207A09;
	Thu, 16 Oct 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVQIDwjy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E145C0B
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578824; cv=none; b=WQUiz/aQj7ncjTE+4yTdYf/s0LzAnm+0kPgCmYZ08A7jFuBUyJLA33gnrIoakL8mmCiPzSw+k2kfOy7HWs/Oy4F9/vq8ptYp/KzY8fkOOQhoaVCgb4yXoEsh0K40gyPRHYCw6hzG5b4t9dmTyPAYJZHYPeqpYrcvqc1IJJS+3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578824; c=relaxed/simple;
	bh=lIa08DDm+ODL68Y7Dc2IuubGF7kPBUWh+ukBXTNTDdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oml0VDw8VA4U8jWEtr+7i4sMIlmzfne2yGOItzWUmQ5wcDpeET/FVTO4itQ34XIaW/pGl3vVDDuPkPKyLqx1ABRLDTIgBgei+gzetz0TCRElm7mK70p2AJ+X+NFN1nDl4yd6SQmu/CwNCYHl6BVk1YAVf47Ea787LFTaPGT/L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVQIDwjy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760578820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8j77l8B/4CaGghMinMZVNzQZrb0KQZNw9uL/x2i+5pg=;
	b=FVQIDwjyLwrgfsQ9ZgN0VC3paYaWI3yRv04UlT5EMyyAXUVIr4sKEme9jspNGClnzu0jm8
	qpFtRWn8QHyTS2xll53HCNN0IPcGwfXSeux8e7VNKPmGH0ovn67oOqWf9ttLsfGaun+6GR
	4HFwY21reLopqPQtP/hmBvQJqGA9/l0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Tejun Heo <tj@kernel.org>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  "David S . Miller" <davem@davemloft.net>,
  Matyas Hurtik <matyas.hurtik@cdn77.com>,  Daniel Sedlak
 <daniel.sedlak@cdn77.com>,  Simon Horman <horms@kernel.org>,  Neal
 Cardwell <ncardwell@google.com>,  Wei Wang <weibunny@meta.com>,
  netdev@vger.kernel.org,  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg
 memory pressure
In-Reply-To: <20251016013116.3093530-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Wed, 15 Oct 2025 18:31:16 -0700")
References: <20251016013116.3093530-1-shakeel.butt@linux.dev>
Date: Wed, 15 Oct 2025 18:40:12 -0700
Message-ID: <87o6q77hfn.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The kernel can throttle network sockets if the memory cgroup associated
> with the corresponding socket is under memory pressure. The throttling
> actions include clamping the transmit window, failing to expand receive
> or send buffers, aggressively prune out-of-order receive queue, FIN
> deferred to a retransmitted packet and more. Let's add memcg metric to
> indicate track such throttling actions.
>
> At the moment memcg memory pressure is defined through vmpressure and in
> future it may be defined using PSI or we may add more flexible way for
> the users to define memory pressure, maybe through ebpf. However the
> potential throttling actions will remain the same, so this newly
> introduced metric will continue to track throttling actions irrespective
> of how memcg memory pressure is defined.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 4 ++++
>  include/linux/memcontrol.h              | 1 +
>  include/net/sock.h                      | 6 +++++-
>  kernel/cgroup/cgroup.c                  | 1 +
>  mm/memcontrol.c                         | 3 +++
>  5 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 0e6c67ac585a..057ee95e43ef 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1515,6 +1515,10 @@ The following nested keys are defined.
>            oom_group_kill
>                  The number of times a group OOM has occurred.
>  
> +          socks_throttled
> +                The number of times network sockets associated with
> +                this cgroup are throttled.

I'd prefer sockets_throttled or sock_throttled. And same for the
constant name.

Otherwise,
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

