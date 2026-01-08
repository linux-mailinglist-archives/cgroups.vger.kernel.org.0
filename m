Return-Path: <cgroups+bounces-12991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C03D05C21
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01AF6301D152
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102B314B60;
	Thu,  8 Jan 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g3EeLTXU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0220E6E2;
	Thu,  8 Jan 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899428; cv=none; b=YnvwASIoUT5qQ368JQp+nERXlcuav2ObPWI06KlH3/w+bTQeI81IXo7V/MtrNx6JqUnC86lOeA2bTtitFEYuesSsn4lOYpn+Dkb7QlJy2UjFhQbjGMM78QPnoDjuibv2Td6+cktxmYDeturwt9uSsckrYvmdlALOJIh3lvjklR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899428; c=relaxed/simple;
	bh=VNrN8JUZQcrq/pnCYgjUgfyW0bmZkPgoeILN/bAbbMI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DJV787+G3fvSxDUIj/pT4hVYs8aa9V+qoaLAI1SDA2WlmGFf9E/MGUh9HEPMFytDYlZBKOUhrYjuRAF3akya1wNQ/1VF+gdH2JGwmfemVy6Krs0mi7DuoQUYHjWveeFPfYbXgRdrhBdv2ygllJ4unJd73R0KdqqQzuLJHqGgPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g3EeLTXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2662C116C6;
	Thu,  8 Jan 2026 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767899428;
	bh=VNrN8JUZQcrq/pnCYgjUgfyW0bmZkPgoeILN/bAbbMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3EeLTXUeU3eKRuS7y4uPO7sanUqMNZ5VF1Qp663J3H3gUDLjN9dx6+io8FYXgDPU
	 8NXIBIRdOMKfJwd4YfT+RwvyMLCa2/ZuyAwt01EYIQ5PjiSR4ZN3K+57VDA1VyHQPf
	 oe6G5dewC7dXXQEN8iLnyIst4LRTtL+WbdH7HiJA=
Date: Thu, 8 Jan 2026 11:10:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: jianyuew@nvidia.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optimize stat output for 11% sys time reduce
Message-Id: <20260108111027.172f19a9a86667e8e0142042@linux-foundation.org>
In-Reply-To: <20260108093741.212333-1-jianyuew@nvidia.com>
References: <20260108093741.212333-1-jianyuew@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 17:37:29 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:

> From: Jianyue Wu <wujianyue000@gmail.com>
> 
> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> printf parsing in memcg stats output.
> 
> Key changes:
> - Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
> - Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
> - Update __memory_events_show(), swap_events_show(),
>   memory_stat_format(), memory_numa_stat_show(), and related helpers
> 
> Performance:
> - 1M reads of memory.stat+memory.numa_stat
> - Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
> - After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)
> 
> Tests:
> - Script:
>   for ((i=1; i<=1000000; i++)); do
>       : > /dev/null < /sys/fs/cgroup/memory.stat
>       : > /dev/null < /sys/fs/cgroup/memory.numa_stat
>   done
> 

I suspect there are workloads which read these files frequently.

I'd be interested in learning "how frequently".  Perhaps
ascii-through-sysfs simply isn't an appropriate API for this data?

> @@ -1795,25 +1795,33 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  	mem_cgroup_flush_stats(memcg);
>  
>  	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
> -		seq_printf(m, "%s=%lu", stat->name,
> -			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
> -						   false));
> -		for_each_node_state(nid, N_MEMORY)
> -			seq_printf(m, " N%d=%lu", nid,
> -				   mem_cgroup_node_nr_lru_pages(memcg, nid,
> -							stat->lru_mask, false));
> +		seq_puts(m, stat->name);
> +		seq_put_decimal_ull(m, "=",
> +				    (u64)mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
> +								  false));
> +		for_each_node_state(nid, N_MEMORY) {
> +			seq_put_decimal_ull(m, " N", nid);
> +		seq_put_decimal_ull(m, "=",
> +				    (u64)mem_cgroup_node_nr_lru_pages(memcg, nid,
> +								       stat->lru_mask, false));

The indenting went wrong here.

The patch does do a lot of ugly tricks to constrain the number of
columns used.  Perhaps introduce some new local variables to clean this
up?



