Return-Path: <cgroups+bounces-11401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7493C1CB80
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 19:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D851895897
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2253557FF;
	Wed, 29 Oct 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj2Sop8s"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99012F83BE;
	Wed, 29 Oct 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761667; cv=none; b=vGVNOcCADOM+vl1maAOhaUHNPh62wThT4GoQbi8lPn4sDbvFD4HFPAeiw6wywweSuxudPPinadobOiQFqPXfr7zQHmdbLLAqACe8+PkMqpn+MqylFfHDMJPX1olC0hlKoG2jDoBBm34j8y5NKHpgP92J8hQ2uSoty22hXyCZih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761667; c=relaxed/simple;
	bh=kY1V/QJFs1h44N/K6efseCUY65CASyAedOZu2/bpKm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bedSXP27I6dd4rHdc52oU/ZUmXNe+XAPrKVNpS4cbkmMRXyf83Tw4b5I3AdHAOqqOnhcLe5MwtA8zw6qfypSmGsReiEUf/Izotz//PWhqAnvZpYlylmriBaFtcE09P9P50Hml0gR6yK3S0Wn4IS5/00t006naSHmgu3JHy0RgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj2Sop8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4485EC4CEF7;
	Wed, 29 Oct 2025 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761761666;
	bh=kY1V/QJFs1h44N/K6efseCUY65CASyAedOZu2/bpKm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj2Sop8sSHOaqPkc3ZcouOA0BeyHTP/TNIJPDnKa6OL1M1cai0IJ12t6rUPYhMo5f
	 aQ3nH2Yw94Jwug09AOD/tfVe3pKBeC/FCu84k6NzjnZwashb3wRtAKjpa3GP/XYHlS
	 kzgxg0AZsJVSe/bGBGAt+mn8DNraSO0xzFSsLN/CYYqvlTTJHcwNPcMf+jVzseNy2N
	 Dqeff1I9EkAZDxmvMxCjL8X6erqZTxddlEl+VwvhBEtus7/b6vjybe+uHIMe6rSgNm
	 6xOPif8V1incnhlbEZa6wBVHpQarnjv9J0wWGVYLVYkJbvXRrCAZ/TOi4TmrR1tEry
	 IAUdfrT8XT33w==
Date: Wed, 29 Oct 2025 08:14:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQJZgd8-xXpK-Af8@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>

Hello,

On Mon, Oct 27, 2025 at 04:17:05PM -0700, Roman Gushchin wrote:
> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>  	struct bpf_link link;
>  	struct bpf_map __rcu *map;
>  	wait_queue_head_t wait_hup;
> +	u64 cgroup_id;
>  };

BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
struct_ops, which seems to work fine. It'd be nice to align on the same
approach. What are the benefits of doing this through fd?

Thanks.

-- 
tejun

