Return-Path: <cgroups+bounces-10826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2CBE5457
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5061886B9B
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D938298CBE;
	Thu, 16 Oct 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eV2n/1Eh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB45216E24;
	Thu, 16 Oct 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643972; cv=none; b=up1l2D8sRdQGbP88pBbXV423q0TyUn3y66IIi2smjKuaGhalemp+tr3Cvo9JC5X0BizxU0JnQINn7kpo5Wamb03NiMRkG1hGN8prk66sx3zj1OGZ+UUEQKJvc4T1ybR/mycFdb4dzw8m+aKHMBWvMn00gXFOKDzNNLohgK5kgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643972; c=relaxed/simple;
	bh=lL6q+PP45aV1hUhjB5GLRugpFv1HA+TwJ5wUIHf5o2U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lH8D5YOo23BFK5GsuWa5o2uCFGzs80Hd+X5hBJU2uCXdhgXqiDE6EzCrUhHQFUJtXWPXQ+/ALdOCqIifymQvMt0sP/9H/Ft5VujSApFHBN6gVxiuNuALMFPu/y0pMwY3bVGucj3d69R08hzq5ad6YYWfG2Rn041PQSilwA+UYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eV2n/1Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5791C4CEF1;
	Thu, 16 Oct 2025 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760643971;
	bh=lL6q+PP45aV1hUhjB5GLRugpFv1HA+TwJ5wUIHf5o2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eV2n/1Eh/uFNVs+bGO9Yvu9htxPiA2g6EXrUM4r/6gZB/TFZ2H4XBCoTWctusvFMy
	 UuHjsTss+DPW+AMx5q+KHEZJfXXijavpQTPVNVCXIQg4ECkUhKv/2WMh9fFCSJ70DO
	 yLKuLj97eF9hCyLCK70GYYzSFGnqQrNgAxLbr/Jc=
Date: Thu, 16 Oct 2025 12:46:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Matyas Hurtik
 <matyas.hurtik@cdn77.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Wei Wang
 <weibunny@meta.com>, netdev@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: net: track network throttling due to memcg
 memory pressure
Message-Id: <20251016124610.0fcf17313c649795881db43c@linux-foundation.org>
In-Reply-To: <20251016161035.86161-1-shakeel.butt@linux.dev>
References: <20251016161035.86161-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 09:10:35 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

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
> ...
>
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2635,8 +2635,12 @@ static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
>  #endif /* CONFIG_MEMCG_V1 */
>  
>  	do {
> -		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
> +		if (time_before64(get_jiffies_64(),
> +				  mem_cgroup_get_socket_pressure(memcg))) {
> +			memcg_memory_event(mem_cgroup_from_sk(sk),
> +					   MEMCG_SOCK_THROTTLED);
>  			return true;
> +		}
>  	} while ((memcg = parent_mem_cgroup(memcg)));
>  

Totally OT, but that's one bigass inlined function.  A quick test
indicates that uninlining just this function reduces the size of
tcp_input.o and tcp_output.o nicely.  x86_64 defconfig:

   text	   data	    bss	    dec	    hex	filename
  52130	   1686	      0	  53816	   d238	net/ipv4/tcp_input.o
  32335	   1221	      0	  33556	   8314	net/ipv4/tcp_output.o

   text	   data	    bss	    dec	    hex	filename
  51346	   1494	      0	  52840	   ce68	net/ipv4/tcp_input.o
  31911	   1125	      0	  33036	   810c	net/ipv4/tcp_output.o



