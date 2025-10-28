Return-Path: <cgroups+bounces-11290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F229C162BC
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9141F1C266E2
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A14333430;
	Tue, 28 Oct 2025 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdogaS6+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58671B042E;
	Tue, 28 Oct 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672775; cv=none; b=WNxd/YtwiFxKpjXA3u13bVfFpNb33PkdbHi1wzSaJoJzD2xbRIwe8CCahwWud1bRPYt6JEnUdqynMBByK0f6WhWTwiIowfzPRPQFuFhGWMzVr/z1Zz7KyU7tY5LgTfsqq39P1zN/nsX3ZTSq1ImcbK8KH4KmSaCninG10VP8Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672775; c=relaxed/simple;
	bh=LDSkULaJ0QmPMjiDLgn3aAAk5v7Uvm0FUgU27v4WPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHmfCnDDCztPZmHOQzQ6qqvRcemtHRj4j5j40GnXYgcgywmUBPK5r791YBQQgNjCLUo/ZLrSMgfIGyiiZXT5RC2383LikqJHqoYFN1LFpxKI7n4QHv2Jni0NkqnF8TEm/BD3e0peIDD5/ZUsKkhq8VMUNTlSF6KmUXvf66YEZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdogaS6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01EC4CEE7;
	Tue, 28 Oct 2025 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672775;
	bh=LDSkULaJ0QmPMjiDLgn3aAAk5v7Uvm0FUgU27v4WPAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdogaS6+LIPuo6XrzKc4ZRQ+7witXcilXONT3n7r34/LM37IrHGLhCySHeXGsVOMr
	 xwTZHZLO2TDfb6JCiCWxILKwZgSqnUMtTTtzSK56q9qT2QvNCqx5o1F7ZvZQuLbnPV
	 aYLwOJa/gdB5jSIQ/P/QZMZ7W4E9pza3j+jeiz4ILX9kLZpkGseRSIbCrQFJH+2MFg
	 sqilqCC5FPu1IqNFqd52bdulInQzvHIrTN1Bz72H/wkXkk4AJrdphWE4jlqAd4EPbH
	 I2E07VUNX1ii8raeV4+zt5kqbhnAUldgX6lALNNcEKmVTm/IWPeOZQ+4wsZ37TOvn2
	 9C2pHjlTVsunA==
Date: Tue, 28 Oct 2025 07:32:54 -1000
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
Subject: Re: [PATCH v2 15/23] mm: introduce bpf_task_is_oom_victim() kfunc
Message-ID: <aQD-RvxrX8_7QtxT@slm.duckdns.org>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-5-roman.gushchin@linux.dev>

On Mon, Oct 27, 2025 at 04:21:58PM -0700, Roman Gushchin wrote:
> Export tsk_is_oom_victim() helper as a BPF kfunc.
> It's very useful to avoid redundant oom kills.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/oom_kill.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 72a346261c79..90bb86dee3cf 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1397,11 +1397,25 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>  	return ret;
>  }
>  
> +/**
> + * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
> + * @task: task to check
> + *
> + * Returns true if the task has been previously selected by the OOM killer
> + * to be killed. It's expected that the task will be destroyed soon and some
> + * memory will be freed, so maybe no additional actions required.
> + */
> +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
> +{
> +	return tsk_is_oom_victim(task);
> +}

In general, I'm not sure it's a good idea to add kfuncs for things which are
trivially accessible. Why can't things like this be provided as BPF helpers?

Thanks.

-- 
tejun

