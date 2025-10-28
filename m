Return-Path: <cgroups+bounces-11277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F65C15A99
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2E402874
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B38345CDA;
	Tue, 28 Oct 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lID+5GGV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A44345756
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667080; cv=none; b=j1aDStSYu82Dx82r7yFV2iGWabW+C01WSWOjRhHuKObdKYjvJaIVopGCQSTtl53XLWarN0MQZp81hkCtmPKG1+R5mt/DPEKsoXEyMwkBBjw/TjwAsNMON6hF9LtBcKzk/IYL8vuJasLo5f/h5u13tWhutP9IGaC+9n1pAsA4yQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667080; c=relaxed/simple;
	bh=srMiYVzGarY3sG3QWMgla/QOJsi5tK5ro1nid71OW6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfw5U9+iRbX6r9DwYC7VsaIpK8u+iZSMQHTdqWeCR8lGFYhthnlgjhBNz7IbR0vGT+OqemfC71F76/5i+lZgLeg7kWqRVh9qVywx4V2EOEGcDUZe6iajhEX6SHXsRzAzWe/sLRKiguSAJfOloh70PA17JKMnPcSUmRsCiauFd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lID+5GGV; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761667076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgzHWai9b6XGwGZe0nQxw4+ISjl+G4EjaAYWoRIkLyE=;
	b=lID+5GGVDlXXyYSyM63V7A9rsUjWgkwaGuNygOvbcOIxV8HufF4T46NYOSn33PTyeVZpCa
	qPpwF1YPB6rSyaZR4D5wFdJBiw0wPdw1LRbpBJEK4hJH3G1V+2jv7TXR7LGYGL2Ppnkw9k
	fWg3hoNIpQ3I7CPwtQejzFWQFx0x91M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <9fd0fbd3d6e704d106423a333106d1296c916f288c3c3600ffde0539e8c266ec@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:17 +0000 (UTC)")
References: <20251027231727.472628-3-roman.gushchin@linux.dev>
	<9fd0fbd3d6e704d106423a333106d1296c916f288c3c3600ffde0539e8c266ec@mail.kernel.org>
Date: Tue, 28 Oct 2025 08:57:46 -0700
Message-ID: <87wm4f5891.fsf@linux.dev>
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
> commit 31d238f36a0a6a56efa48c847cb776e67ba2f079
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> bpf: initial support for attaching struct ops to cgroups
>
> When a struct ops is being attached and a bpf link is created, allow to
> pass a cgroup fd using bpf attr, so that struct ops can be attached to a
> cgroup instead of globally. Attached struct ops doesn't hold a reference
> to the cgroup, only preserves cgroup id.
>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index eae907218..7205b813e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>>  	struct bpf_link link;
>>  	struct bpf_map __rcu *map;
>>  	wait_queue_head_t wait_hup;
>> +	u64 cgroup_id;
>>  };
>>
>>  struct bpf_link_primer {
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 45cc5ee19..58664779a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/btf_ids.h>
>>  #include <linux/rcupdate_wait.h>
>>  #include <linux/poll.h>
>> +#include <linux/cgroup.h>
>>
>>  struct bpf_struct_ops_value {
>>  	struct bpf_struct_ops_common_value common;
>
> [ ... ]
>
>> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>  	}
>>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>>  		      attr->link_create.attach_type);
>> +#ifdef CONFIG_CGROUPS
>> +	if (attr->link_create.cgroup.relative_fd) {
>> +		struct cgroup *cgrp;
>> +
>> +		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
>> +		if (IS_ERR(cgrp))
>> +			return PTR_ERR(cgrp);
>                         ^^^^^^^^^^^^^^^^^^^^^^
>
> Can this leak the link and map? In bpf_struct_ops_link_create(), the link
> is allocated with kzalloc(GFP_USER) and map is obtained with bpf_map_get()
> before this point. If cgroup_get_from_fd() fails, the early return skips
> the err_out label which does kfree(link) and bpf_map_put(map).
>
> All other error paths in this function use "err = <error>; goto err_out;"
> but this one returns directly.

Ok, this is indeed wrong, will fix in the next version.

Thanks!

