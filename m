Return-Path: <cgroups+bounces-8985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88577B1BCE6
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 01:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77B718523D
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91B29E0E3;
	Tue,  5 Aug 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNsnmiz7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A77285069
	for <cgroups@vger.kernel.org>; Tue,  5 Aug 2025 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434962; cv=none; b=RKHpiPcjHrDIMzsIfau9oju3TFw7LpUEOUq72NRws27cHeTs9fymX8hwwikWYgTxTKTYvIWYiLkr/UH2O7kzTeKybgXcCN9BkMQJUnoWFib12Du5NDwXFBCZIR8Q8FJW123LV+ebvUAH0Y5XKQhE847AabTAzG+kQ2/r8Jkd3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434962; c=relaxed/simple;
	bh=5A+aq2bNUS5hbR4FLbGbEKBrxPsIwoWoPZuxCe7/moI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv0nnQFQE6PwMyUAwaNVRXwpr2UFuJMcK7smPHcnubO5CLOaDPomVsL5hykGYYv0xONlI04XoAr8XdXLSL4+R7TNG5Teyf4tIAU4mzAiJztgkyzsxT4qqUrtUjVqZjwwXYZTn5d/DAZa9vw0GoT5oqcaSVvHNHyBSznW+Oo/pIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNsnmiz7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Aug 2025 16:02:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754434948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGuBAxZMWvC+J3RFqR4e3qgqgb7nwGWm8ALGJz/pnD8=;
	b=uNsnmiz7GsewtRxSv/3NhFtNEAOki9pk6rDsAcrEZ69Anw7iAm01t6a+vvZS4g7Op0zG5n
	XvHXdUacB+TH1ws2JoRuleLrEiAhekAffBJFEZhDuFPiOzr5OoYBYwRJSDEg932OfIchrt
	TwL6CJlbRe3cL3gITV4J1a5v7vQ1GJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 05, 2025 at 08:44:29AM +0200, Daniel Sedlak wrote:
> This patch is a result of our long-standing debug sessions, where it all
> started as "networking is slow", and TCP network throughput suddenly
> dropped from tens of Gbps to few Mbps, and we could not see anything in
> the kernel log or netstat counters.
> 
> Currently, we have two memory pressure counters for TCP sockets [1],
> which we manipulate only when the memory pressure is signalled through
> the proto struct [2]. However, the memory pressure can also be signaled
> through the cgroup memory subsystem, which we do not reflect in the
> netstat counters. In the end, when the cgroup memory subsystem signals
> that it is under pressure, we silently reduce the advertised TCP window
> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
> throughput reduction.
> 
> Keep in mind that when the cgroup memory subsystem signals the socket
> memory pressure, it affects all sockets used in that cgroup.
> 
> This patch exposes a new file for each cgroup in sysfs which signals
> the cgroup socket memory pressure. The file is accessible in
> the following path.
> 
>   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure

let's keep the name concise. Maybe memory.net.pressure?

> 
> The output value is a cumulative sum of microseconds spent
> under pressure for that particular cgroup.
> 
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
> Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> ---
> Changes:
> v3 -> v4:
> - Add documentation
> - Expose pressure as cummulative counter in microseconds
> - Link to v3: https://lore.kernel.org/netdev/20250722071146.48616-1-daniel.sedlak@cdn77.com/
> 
> v2 -> v3:
> - Expose the socket memory pressure on the cgroups instead of netstat
> - Split patch
> - Link to v2: https://lore.kernel.org/netdev/20250714143613.42184-1-daniel.sedlak@cdn77.com/
> 
> v1 -> v2:
> - Add tracepoint
> - Link to v1: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sedlak@cdn77.com/
> 
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  include/linux/memcontrol.h              |  2 ++
>  mm/memcontrol.c                         | 15 +++++++++++++++
>  mm/vmpressure.c                         |  9 ++++++++-
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 0cc35a14afbe..c810b449fb3d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1884,6 +1884,13 @@ The following nested keys are defined.
>  	Shows pressure stall information for memory. See
>  	:ref:`Documentation/accounting/psi.rst <psi>` for details.
>  
> +  memory.net.socket_pressure
> +	A read-only single value file showing how many microseconds
> +	all sockets within that cgroup spent under pressure.
> +
> +	Note that when the sockets are under pressure, the networking
> +	throughput can be significantly degraded.
> +
>  
>  Usage Guidelines
>  ~~~~~~~~~~~~~~~~
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 87b6688f124a..6a1cb9a99b88 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -252,6 +252,8 @@ struct mem_cgroup {
>  	 * where socket memory is accounted/charged separately.
>  	 */
>  	unsigned long		socket_pressure;
> +	/* exported statistic for memory.net.socket_pressure */
> +	unsigned long		socket_pressure_duration;

I think atomic_long_t would be better.

>  
>  	int kmemcg_id;
>  	/*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 902da8a9c643..8e299d94c073 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3758,6 +3758,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	INIT_LIST_HEAD(&memcg->swap_peaks);
>  	spin_lock_init(&memcg->peaks_lock);
>  	memcg->socket_pressure = jiffies;
> +	memcg->socket_pressure_duration = 0;
>  	memcg1_memcg_init(memcg);
>  	memcg->kmemcg_id = -1;
>  	INIT_LIST_HEAD(&memcg->objcg_list);
> @@ -4647,6 +4648,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  	return nbytes;
>  }
>  
> +static int memory_socket_pressure_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +
> +	seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure_duration));
> +
> +	return 0;
> +}
> +
>  static struct cftype memory_files[] = {
>  	{
>  		.name = "current",
> @@ -4718,6 +4728,11 @@ static struct cftype memory_files[] = {
>  		.flags = CFTYPE_NS_DELEGATABLE,
>  		.write = memory_reclaim,
>  	},
> +	{
> +		.name = "net.socket_pressure",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = memory_socket_pressure_show,
> +	},
>  	{ }	/* terminate */
>  };
>  
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index bd5183dfd879..1e767cd8aa08 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -308,6 +308,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		level = vmpressure_calc_level(scanned, reclaimed);
>  
>  		if (level > VMPRESSURE_LOW) {
> +			unsigned long socket_pressure;
> +			unsigned long jiffies_diff;
>  			/*
>  			 * Let the socket buffer allocator know that
>  			 * we are having trouble reclaiming LRU pages.
> @@ -316,7 +318,12 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  			 * asserted for a second in which subsequent
>  			 * pressure events can occur.
>  			 */
> -			WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> +			socket_pressure = jiffies + HZ;
> +
> +			jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> +			memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);

KCSAN will complain about this. I think we can use atomic_long_add() and
don't need the one with strict ordering.

> +
> +			WRITE_ONCE(memcg->socket_pressure, socket_pressure);
>  		}
>  	}
>  }
> 
> base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> -- 
> 2.39.5
> 

