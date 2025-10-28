Return-Path: <cgroups+bounces-11285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BADC160BD
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998214EA693
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B8F348898;
	Tue, 28 Oct 2025 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGxR66ac"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CD348460
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671240; cv=none; b=c6SKkiUOjhmKeHFbZCq8r74RPUtVm3i/6bVwcfxvPN1tEHLl203qNSYF7zW/iWB94lN7cOHONvOjvsSkXNvCN2+gKAs38R5TNv42zOAbwCAVcRjVANrI+9pgscyBpOqio8VSQisa6l33D2xoAsVSJpGJO6+EQFExrXrvsobsXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671240; c=relaxed/simple;
	bh=3LKMsmv0SwwVJPfJr0Fzwyrb1geTmwxPKDxfrNjRMBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7d0GwdPH6CRUF5amfPcnMo/2zu0C8cg6D+FbAde2vgmL5mNv6OyCX45NZd7RS2BYQlYnpQwyQXj8twWdGAl10RyhqYPHDqvGoVAgu4ZOFj3zcOPDvoWeWdXtiHpbUfR5YUe2SEZ13LMfU34ezbN2dlJI117yePzp+k8pIAbdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGxR66ac; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761671234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSDMZEnhQraFtTVM8HTNniThlkRiXJWMYrj8+oAXJIw=;
	b=iGxR66acQyngyL2qi4BOBXGsUCyP+daS9iWon0hZ5r54kQTcFpt1nd7l8KG7fvUyvbTnrF
	6CAST3vIF1ZJw/DoUvX3lIWScgV8oH3hAUfGma8ixVXV42n02K8zOB71ozkNkyG51Z8DOE
	XN6ucICOhHoRAiQoqsOffgPkp3aWf/M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 16/23] libbpf: introduce
 bpf_map__attach_struct_ops_opts()
In-Reply-To: <5e97ecea6574f100385cb21507076c6efb2667eb9def24f322306be038e98165@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:10 +0000 (UTC)")
References: <20251027232206.473085-6-roman.gushchin@linux.dev>
	<5e97ecea6574f100385cb21507076c6efb2667eb9def24f322306be038e98165@mail.kernel.org>
Date: Tue, 28 Oct 2025 10:07:04 -0700
Message-ID: <87o6pruf9j.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit b58d54ed56054e3a550e02c324982feb20a2671e
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> libbpf: introduce bpf_map__attach_struct_ops_opts()
>
> This commit introduces a new API function that extends the existing
> bpf_map__attach_struct_ops() to accept additional options, specifically
> allowing attachment of struct_ops maps to cgroups via a relative_fd.
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b90574f39..be56a5dee 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -13196,12 +13196,19 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>  	return close(link->fd);
>>  }
>>
>> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>> +struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
>> +						 const struct bpf_struct_ops_opts *opts)
>>  {
>> +	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
>>  	struct bpf_link_struct_ops *link;
>>  	__u32 zero = 0;
>>  	int err, fd;
>>
>> +	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
>> +		pr_warn("map '%s': invalid opts\n", map->name);
>> +		return libbpf_err_ptr(-EINVAL);
>> +	}
>> +
>>  	if (!bpf_map__is_struct_ops(map)) {
>>  		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
>>  		return libbpf_err_ptr(-EINVAL);
>
> [ ... ]
>
>>  	link = calloc(1, sizeof(*link));
>>  	if (!link)
>>  		return libbpf_err_ptr(-EINVAL);
>
> Should this return -ENOMEM instead of -EINVAL? All other calloc failures
> in libbpf.c return -ENOMEM (see lines 11006, 11802, 12288, 12746, 12829,
> 12891, 13089, 13129 in the same file).

This code was introduced by e9fc3ce99b34 ("libbpf: Streamline error
reporting for high-level APIs"), so it's new. I agree that ENOMEM is
correct, however it might be too late to fix. I'll let libbpf
maintainers to decide.

>
> [ ... ]
>
>> -	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
>> +	link_opts.cgroup.relative_fd = OPTS_GET(opts, relative_fd, 0);
>> +
>> +	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);
>
> Is the expected_revision field being propagated correctly? The new
> bpf_struct_ops_opts structure includes an expected_revision field
> (see libbpf.h), and bpf_link_create() with BPF_STRUCT_OPS reads
> opts->cgroup.expected_revision (see bpf.c line 889), but this code only
> sets relative_fd in link_opts. Should it also include:
>
>     link_opts.cgroup.expected_revision = OPTS_GET(opts,
>     expected_revision, 0);

Correct, fixed.

Thanks!

