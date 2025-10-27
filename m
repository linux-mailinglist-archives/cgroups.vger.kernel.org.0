Return-Path: <cgroups+bounces-11228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC9C12184
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C36D2351943
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41E33031C;
	Mon, 27 Oct 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us920hjK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A832E695;
	Mon, 27 Oct 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608892; cv=none; b=UM1sACxisO3tki4gEmtJ9O6WQWzJkbmIkVO6AUBMI3Hzjh8/7AGiWQVssOeSgsDXbnBEOJVQNhX+B82J7d1KjbjPm3dgZPZ/9nS7FKji2kRxqU5CeP2qRPM+58LwBZqMILc7YiS2es3ho54JEaI/+l4ETZvZbk8CFCuRSZRl+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608892; c=relaxed/simple;
	bh=d+Afd6qG0+omy8Xr9NEfKvzByVvSsVWsm6DaVrUnLfQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hTOB+atA3ysOok4fWO5fer/m/zTPAcosqCC7NjBPfpyco7Dv0lxVfUvO369dJXMR7zeedRh/F/reVNJ6jsVIzUBP5vXlQLiVxrq87bH6SBDTIG3OoGDp2sTtYXxfnv2M4SXcG/N2STimRuMAVjjXz28E0Okzu9oufPC/IT8y8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us920hjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7699C4CEFB;
	Mon, 27 Oct 2025 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608892;
	bh=d+Afd6qG0+omy8Xr9NEfKvzByVvSsVWsm6DaVrUnLfQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Us920hjKG70fHpLMNB7lfpxLhKSXliu5ThF5h0imbY7NeLbqGUHc4lJYIOuldiwYv
	 Lew7/A5ljSRJN840oMsKIEKiJRt+LFWXTOnKEzKfc74pj6HCo+OYso4pmh4jXI9Fcl
	 G+eDHDi1HNYzKLf+nXO8CCoY+hw8k+AeGlmb6ORzqEUwtMxW8IOv3uIds/XxDk1i76
	 QMMGvVjD3zliwXY18GBCXaonuC1so0l56kT2D/2QAm9dGpxqSwPUUSTggPBR5fd8YU
	 gw5HmmZJPKQ+HIcUQoPa3m0+MwcFwm6b8MBNThX7jCOvLOeeMNXm7VqKx41p/ER0Cc
	 KWrPX/d/OjzpQ==
Content-Type: multipart/mixed; boundary="===============6095985643008399195=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e97ecea6574f100385cb21507076c6efb2667eb9def24f322306be038e98165@mail.kernel.org>
In-Reply-To: <20251027232206.473085-6-roman.gushchin@linux.dev>
References: <20251027232206.473085-6-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 16/23] libbpf: introduce bpf_map__attach_struct_ops_opts()
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:10 +0000 (UTC)

--===============6095985643008399195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit b58d54ed56054e3a550e02c324982feb20a2671e
Author: Roman Gushchin <roman.gushchin@linux.dev>

libbpf: introduce bpf_map__attach_struct_ops_opts()

This commit introduces a new API function that extends the existing
bpf_map__attach_struct_ops() to accept additional options, specifically
allowing attachment of struct_ops maps to cgroups via a relative_fd.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b90574f39..be56a5dee 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13196,12 +13196,19 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
>  	return close(link->fd);
>  }
>
> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
> +						 const struct bpf_struct_ops_opts *opts)
>  {
> +	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
>  	struct bpf_link_struct_ops *link;
>  	__u32 zero = 0;
>  	int err, fd;
>
> +	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
> +		pr_warn("map '%s': invalid opts\n", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
>  	if (!bpf_map__is_struct_ops(map)) {
>  		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
>  		return libbpf_err_ptr(-EINVAL);

[ ... ]

>  	link = calloc(1, sizeof(*link));
>  	if (!link)
>  		return libbpf_err_ptr(-EINVAL);

Should this return -ENOMEM instead of -EINVAL? All other calloc failures
in libbpf.c return -ENOMEM (see lines 11006, 11802, 12288, 12746, 12829,
12891, 13089, 13129 in the same file).

[ ... ]

> -	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	link_opts.cgroup.relative_fd = OPTS_GET(opts, relative_fd, 0);
> +
> +	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);

Is the expected_revision field being propagated correctly? The new
bpf_struct_ops_opts structure includes an expected_revision field
(see libbpf.h), and bpf_link_create() with BPF_STRUCT_OPS reads
opts->cgroup.expected_revision (see bpf.c line 889), but this code only
sets relative_fd in link_opts. Should it also include:

    link_opts.cgroup.expected_revision = OPTS_GET(opts, expected_revision, 0);

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5118d0a90..dc8489871 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -922,6 +922,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +
> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 relative_fd;
> +	__u64 expected_revision;
> +	size_t :0;
> +};
> +#define bpf_struct_ops_opts__last_field expected_revision
> +
> +LIBBPF_API struct bpf_link *
> +bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
> +				const struct bpf_struct_ops_opts *opts);

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `libbpf: introduce bpf_map__attach_struct_ops_opts()`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============6095985643008399195==--

