Return-Path: <cgroups+bounces-11418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F41C1DE4D
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 01:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A303A6FEA
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D73A1C9;
	Thu, 30 Oct 2025 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ou6lXpME"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B49126BF1
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783681; cv=none; b=Onhd2d0nitqUlwbj/0ENmiaLMZCyiCkWfr6/mw3ul9OZJAiHCit19isGqNhW496Go/EbcsEtJtQFZlIzvO9Xzw7k6Mg/ukw6JjHidRn1CCXp43/gpTbEs6oS+A2ccbPXlR/PEki0jYWNozzgiMdd8RM4WJOCkaPbuZDIPgDFNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783681; c=relaxed/simple;
	bh=UlI0p08rtDQUqoWrx/Sy02yZVCto5WkOezMZFNPdTJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFj5FVkVIEmw1z0qbOhZpU3Gt1vwTecC2eCj0Qn49ewK63OKCTMoLPdJv2KFDoskehbe4eqvNf5zmF1mMJjSAzOcPGQ4MZHIezqTq6JRbdjIKfYLiLHlFVR/8qkuY1/WWsBwC/HorKyze+P5WHi5uOZOyAG/s2fTUlbcUGwVwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ou6lXpME; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8110233-0028-48e3-8850-fcf1ba528ca6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761783673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83mMGh350mPzHP98dPD6s3KeImQJSZE2GZvMHCWiYug=;
	b=Ou6lXpMEg6AqmuZ/ORasDA2Z1gZfMXc150P3f6XPtSgAvMkorNWutkS0E81mOft92TJwJh
	/NS+uKNqJfSaDkGHSPBzE22BT7+2t9s3Xaig7fF7dcWqRm3evUFCCu9Gk1sDvVgTt+3WpF
	+KoSrppdvxU88J3q0sanTF0tbwaKSmk=
Date: Wed, 29 Oct 2025 17:20:59 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 4:17 PM, Roman Gushchin wrote:
> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> new file mode 100644
> index 000000000000..18c32a5a068b
> --- /dev/null
> +++ b/include/linux/bpf_oom.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_OOM_H
> +#define __BPF_OOM_H
> +
> +struct oom_control;
> +
> +#define BPF_OOM_NAME_MAX_LEN 64
> +
> +struct bpf_oom_ctx {
> +	/*
> +	 * If bpf_oom_ops is attached to a cgroup, id of this cgroup.
> +	 * 0 otherwise.
> +	 */
> +	u64 cgroup_id;
> +};

A function argument can be added to the ops (e.g. handle_out_of_memory) 
in the future. afaict, I don't see it will disrupt the existing bpf prog 
as long as it does not change the ordering of the existing arguments.

If it goes down the 'struct bpf_oom_ctx" abstraction path, all future 
new members of the 'struct bpf_oom_ctx' will need to be initialized even 
they may not be useful for most of the existing ops.

For networking use case, I am quite sure the wrapping is unnecessary. I 
will leave it as fruit of thoughts here for this use case.

> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link = container_of(link, struct bpf_struct_ops_link, link);

link could be NULL here. "return -EOPNOTSUPP" for the legacy kdata reg 
that does not use the link api.

In the future, we should enforce link must be used in the 
bpf_struct_ops.c except for a few of the existing struct_ops kernel users.

> +	struct bpf_oom_ops **bpf_oom_ops_ptr = NULL;
> +	struct bpf_oom_ops *bpf_oom_ops = kdata;
> +	struct mem_cgroup *memcg = NULL;
> +	int err = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +		/* Attach to a memory cgroup? */
> +		memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +		if (IS_ERR_OR_NULL(memcg))
> +			return PTR_ERR(memcg);
> +		bpf_oom_ops_ptr = bpf_oom_memcg_ops_ptr(memcg);
> +	} else {
> +		/* System-wide OOM handler */
> +		bpf_oom_ops_ptr = &system_bpf_oom;
> +	}
> +
> +	/* Another struct ops attached? */
> +	if (READ_ONCE(*bpf_oom_ops_ptr)) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/* Expose bpf_oom_ops structure */
> +	WRITE_ONCE(*bpf_oom_ops_ptr, bpf_oom_ops);
> +exit:
> +	mem_cgroup_put(memcg);
> +	return err;
> +}
> +
> +static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link = container_of(link, struct bpf_struct_ops_link, link);
> +	struct bpf_oom_ops **bpf_oom_ops_ptr = NULL;
> +	struct bpf_oom_ops *bpf_oom_ops = kdata;
> +	struct mem_cgroup *memcg = NULL;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +		/* Detach from a memory cgroup? */
> +		memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +		if (IS_ERR_OR_NULL(memcg))
> +			goto exit;
> +		bpf_oom_ops_ptr = bpf_oom_memcg_ops_ptr(memcg);
> +	} else {
> +		/* System-wide OOM handler */
> +		bpf_oom_ops_ptr = &system_bpf_oom;
> +	}
> +
> +	/* Hide bpf_oom_ops from new callers */
> +	if (!WARN_ON(READ_ONCE(*bpf_oom_ops_ptr) != bpf_oom_ops))
> +		WRITE_ONCE(*bpf_oom_ops_ptr, NULL);
> +
> +	mem_cgroup_put(memcg);
> +
> +exit:
> +	/* Release bpf_oom_ops after a srcu grace period */
> +	synchronize_srcu(&bpf_oom_srcu);
> +}
> +
> +#ifdef CONFIG_MEMCG
> +void bpf_oom_memcg_offline(struct mem_cgroup *memcg)

Is it when the memcg/cgroup is going away? I think it should also call 
bpf_struct_ops_map_link_detach (through link->ops->detach [1]). It will 
notify the user space which may poll on the link fd. This will also call 
the bpf_oom_ops_unreg above.

[1] 
https://lore.kernel.org/all/20240530065946.979330-7-thinker.li@gmail.com/

> +{
> +	struct bpf_oom_ops *bpf_oom_ops;
> +	struct bpf_oom_ctx exec_ctx;
> +	u64 cgrp_id;
> +	int idx;
> +
> +	/* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +	idx = srcu_read_lock(&bpf_oom_srcu);
> +
> +	bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> +	WRITE_ONCE(memcg->bpf_oom, NULL);
> +
> +	if (bpf_oom_ops && bpf_oom_ops->handle_cgroup_offline) {
> +		cgrp_id = cgroup_id(memcg->css.cgroup);
> +		exec_ctx.cgroup_id = cgrp_id;
> +		bpf_oom_ops->handle_cgroup_offline(&exec_ctx, cgrp_id);
> +	}
> +
> +	srcu_read_unlock(&bpf_oom_srcu, idx);
> +}



