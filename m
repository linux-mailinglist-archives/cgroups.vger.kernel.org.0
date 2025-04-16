Return-Path: <cgroups+bounces-7590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF85A8AD5F
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 03:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7D43A6F12
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 01:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4E2066DD;
	Wed, 16 Apr 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDrEvyie"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0F205AC3
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765643; cv=none; b=VD3IjntGrrlVSiPM+t5lY9ZfysY5sj/PvCJGce5RHE6FhK/3pICJCnyLFEtEjrCV+nAXOeuIYYIPJYsR+bM5xrLB+Z42J8rXYxwpCSOGKeU4Pvs+VHmkobXq46SM372u+RXeo6f0yFJaysgK0djttWKWIYWqwj2KW1tg6Aa8mDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765643; c=relaxed/simple;
	bh=ynItsx9VlobavD/m9ywBxaQyHMxzKdeJNQN2wwMGYIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO7UEnPcTqhUAP4CsxKGN5yca2neoGW3BGHortYasWe559yAGtVmDBsJnKBVUG/SVdlwf1EDDKm+5jM5CfiIk6eDbsHN1I+D3jyg+o/xQ36zj6SCLlLhrmX2X4wlJCWOSR6+Ai3pMn0R6ttSMsT5jVTb0xxLTheznpom/S0DvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDrEvyie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744765639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWqUG7P0v1cOnPoUVc7aAn2jH8Xha4vfE5DOCxe6qxo=;
	b=CDrEvyieA/HGcMUfmbOH30dX0yQVBCll5y/9WyFknRbkj6kP23gv91fgFxL4+A6kbm3VZ3
	tNOpy6QkPYFC1AaT+lugk2JRkT1jWsMX15Xj6CXROzQA8VvMYhZreLTSnkglpMQuWcYu3e
	SqgXigANv6iSjanx29Hp4COJs7F8BmE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-qL3IZYAAO5-uck_js_6QCg-1; Tue,
 15 Apr 2025 21:07:15 -0400
X-MC-Unique: qL3IZYAAO5-uck_js_6QCg-1
X-Mimecast-MFC-AGG-ID: qL3IZYAAO5-uck_js_6QCg_1744765633
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9257519560AB;
	Wed, 16 Apr 2025 01:07:13 +0000 (UTC)
Received: from [10.22.64.119] (unknown [10.22.64.119])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC1501828A87;
	Wed, 16 Apr 2025 01:07:11 +0000 (UTC)
Message-ID: <4c0b253e-993f-45b5-9f8a-16c4c4c6b8ca@redhat.com>
Date: Tue, 15 Apr 2025 21:07:10 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
To: "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415235308.424643-1-tjmercier@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20250415235308.424643-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


On 4/15/25 7:53 PM, T.J. Mercier wrote:
> Android has mounted the v1 cpuset controller using filesystem type
> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> behavior where the controller name is not added as a prefix for cgroupfs
> files. [2]
>
> Later, a problem was discovered where cpu hotplug onlining did not
> affect the cpuset/cpus files, which Android carried an out-of-tree patch
> to address for a while. An attempt was made to upstream this patch, but
> the recommendation was to use the "cpuset_v2_mode" mount option
> instead. [3]
>
> An effort was made to do so, but this fails with "cgroup: Unknown
> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> update the special cased cpuset_mount(), and only the cgroup (v1)
> filesystem type was updated.
>
> Add parameter parsing to the cpuset filesystem type so that
> cpuset_v2_mode works like the cgroup filesystem type:
>
> $ mkdir /dev/cpuset
> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> $ mount|grep cpuset
> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)
>
> [1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/
>
> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>   kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 27f08aa17b56..cf30ff2e7d60 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type = {
>   };
>   
>   #ifdef CONFIG_CPUSETS_V1
> +enum cpuset_param {
> +	Opt_cpuset_v2_mode,
> +};
> +
> +const struct fs_parameter_spec cpuset_fs_parameters[] = {
> +	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
> +	{}
> +};
> +
> +static int cpuset_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, cpuset_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_cpuset_v2_mode:
> +		ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>   static const struct fs_context_operations cpuset_fs_context_ops = {
>   	.get_tree	= cgroup1_get_tree,
>   	.free		= cgroup_fs_context_free,
> +	.parse_param	= cpuset_parse_param,
>   };
>   
>   /*
> @@ -2392,6 +2420,7 @@ static int cpuset_init_fs_context(struct fs_context *fc)
>   static struct file_system_type cpuset_fs_type = {
>   	.name			= "cpuset",
>   	.init_fs_context	= cpuset_init_fs_context,
> +	.parameters		= cpuset_fs_parameters,
>   	.fs_flags		= FS_USERNS_MOUNT,
>   };
>   #endif

LGTM

Acked-by: Waiman Long <longman@redhat.com>


