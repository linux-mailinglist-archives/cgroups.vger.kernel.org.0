Return-Path: <cgroups+bounces-13112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4291D16002
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557693010FF3
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE1221FBB;
	Tue, 13 Jan 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvUkrcnM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D074A945
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264198; cv=none; b=iVuuAiFz3Bg0/GnCsY+0/3PmE57XwBYW/I7kYWlXXgPcB0se2FmeMfXCLn8L55WKC17AeGMCsPsSvEy9bojIo3no/KIgXGIZOvPXVdInaDTqZEi9BX5LTANM67gqnDPK5luKXh3GkwTjXHnCPXDLJBqL/087BfSBxTArGNbv1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264198; c=relaxed/simple;
	bh=EBJJtrl1VJWbowNzLOHxkDLG+HncCZZSjky2zqKecy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByvlZWLP0iS/GPh2ZHianspguPG2/xeiCh5X4zG1fpJnHLmOqcgGCLmDSEJeZCXHRMjS22/WbWwMvHA4kDIaFwB1+HJtEs30kbkmfwbx/5aA77ntc6H3bSj+KolYbFNGzaeEgXj9DvqN1zAR1HCp7xa5A/dlDgojT+q/KKmwBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvUkrcnM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 16:29:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768264195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pyL7GzwiaWM5TrGRV41/bPY6bHAncpMomm47aXJ9I8=;
	b=EvUkrcnMUbeWsrOdO4eoWuoOIbsPsFlpzJoGQGrQj0hpHaUfq3oz259SJnKbfSTOsz1Dw/
	GzfWv0wGyzkppJaCZtMOFUguWxJNEVnTXO7VPXob+wIOQHqRPtOngBo/gsKAm/gfc7Oo7M
	nIOkO3f+1Ts9XcpPHIq+csfBlqeTmdI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: optimize stat output for 11% sys time reduce
Message-ID: <wzanjpb5fb3cff6jaissuzx3yxghgd5n4l4ekgpltytbdb6new@6v2uhp3oka5t>
References: <CAJxJ_jioPFeTL3og-5qO+Xu4UE7ohcGUSQuodNSfYuX32Xj=EQ@mail.gmail.com>
 <20260110042249.31960-1-jianyuew@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110042249.31960-1-jianyuew@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jan 10, 2026 at 12:22:49PM +0800, Jianyue Wu wrote:
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
> - Introduce local variables to improve readability and reduce line length
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
> Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>

With a nit below, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

>  
> +/* Max 2^64 - 1 = 18446744073709551615 (20 digits) */
> +#define MEMCG_DEC_U64_MAX_LEN 20
> +
> +static inline void memcg_seq_put_name_val(struct seq_file *m, const char *name,
> +					  u64 val)
> +{
> +	seq_puts(m, name);
> +	/* need a space between name and value */
> +	seq_put_decimal_ull(m, " ", val);
> +	seq_putc(m, '\n');
> +}
> +
> +static inline void memcg_seq_buf_put_name_val(struct seq_buf *s,
> +					      const char *name, u64 val)
> +{
> +	char num_buf[MEMCG_DEC_U64_MAX_LEN];
> +	int num_len;
> +
> +	num_len = num_to_str(num_buf, sizeof(num_buf), val, 0);
> +	if (num_len <= 0)
> +		return;
> +
> +	if (seq_buf_puts(s, name))
> +		return;
> +	if (seq_buf_putc(s, ' '))
> +		return;
> +	if (seq_buf_putmem(s, num_buf, num_len))
> +		return;
> +	seq_buf_putc(s, '\n');
> +}

Move the above functions to memcontrol.c and add documentation for them.


