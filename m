Return-Path: <cgroups+bounces-15348-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CUtCvNe4mlM5QAAu9opvQ
	(envelope-from <cgroups+bounces-15348-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 18:25:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA441D17D
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55305303F4EE
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046134E774;
	Fri, 17 Apr 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epe3PpxU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480D346FAE
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442992; cv=none; b=riqOm8ILBJ7gzY9AzizwN6grqangIlIKvg8cXF4XGOI1T1lICydPhteB3lwuhGp8XmuaYtpiZX4y6vbaSl367gY832lA4DwiDmtmZkOQlAZymVLjMRw/8708JZJa+P9Knp6gzm8hYgRxAnQNpO5oZ7RDYrJSQjG3ihLRco+psrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442992; c=relaxed/simple;
	bh=1inrkQymh6YJtiIcOpocxYDPhUNrtx5Qz/ANslnvt4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNIirYLaJuJgcgfwjxqnCzzqf4weIWg+XEn2A55lSoGeun7d+yFw4yIio8OVhHM0rXomi+ZmHerFLUBSTmGYHJ6PKhFNQqNUwwJSN8gRXpVVf6SR8feByVnnULInes9E11x5Rym03PiHJGZhRWBHiuX+HF4C9SnBR3UQSH2fPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epe3PpxU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso681063a91.0
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442990; x=1777047790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhFcWEHC6x3NRrSWvUQYL2S86pVw9wWBWY42qwwALr0=;
        b=epe3PpxUHEbOzJLo5hqA2lKrGclcXQs5DGyw1eqkj9h6WNtbCuIQORMiawVohxs6ZX
         8/xjYmgozJR+vPJji6ypDcrUmuZhwqR4r2WeGO8Oo7p4EsivJHTMCOnz4JxN1qxuvtWY
         gN1IEs87iVBpSCQhlQC67su9QKcIfRMGCuZuMGpP1pLOESGwkojtWdmKc6xpebfwIB8F
         BYhmOvsP3tynZ01VJdft9I6QfAUzKib6qEQhCPweX7xEMY7TbsZCe2NQqW8ydT+r7Mca
         AHQVIHmuVIK2ZgOaMBUudCFb2C4N+fBNQnM25vmgGr19VJV2Foayb3Ts5kEsKoE7pS/w
         45FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442990; x=1777047790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhFcWEHC6x3NRrSWvUQYL2S86pVw9wWBWY42qwwALr0=;
        b=KIDPWamZWhDx4fAMFmoZ3NE/hv8iyfkQqESGcOOEg01kbaJAP9atjl21BpugixSCt2
         QuujsBietKRgnGrZpXmPAN/CrVUX5CT8Simxp0TVdMhCr++gem73hGesBHG98KENlL9i
         y0Lt8eJp6P40d7/siTqaWs/waHQVR3pxMAwUD2FpKP4l1uvHFMotvQNrGJY41FLFXOD0
         zUhGKq9VqyN3HurKNi/rXkVqHm40wZJsr8TniOmT3q4eUS66bBRizng9WmTCtycZPtsh
         ZTaAkz/VLY80ovgSzdLaYuKqm6NQZJxBhyDisAN6705mq6wmpYGOwtyLyr7Di72Wi6/6
         xHSA==
X-Forwarded-Encrypted: i=1; AFNElJ9nMz6l0uv43R1M4aPt9nvVSCfsEBsr/Ravubr1rrf7rDsH3hUAPHdIU60z2hE85QMoCQKSAYql@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3vxgRrDb3pRBFQwAy3n67lgMXuc32AcTiwmdTNWqZhQgewsv
	UkACFcUIlkFAdb0NBCFTIn6nfSgGBd1I/jniIvPDx/ixyWPZpPxGA1u1
X-Gm-Gg: AeBDies5tU7jfqlu/sHgp/nIYl+JFpJjJhSFUTI1jn6/cO3YTKTJAcy//r10ZmVkEUn
	UQmZWE0HNWt1LbPfK0yXsKkuFrde2YlcBhhxe5JksKBGc9A2cZWtI7pm3ea8wUVH2a49kJNkr4V
	Z7SsfD9Ur9uqRP0ZlSA1wOECUQ4ANUheXecYcFuDOkR/qraObpiCYlEFSgLDjnqfr85YPkdruEn
	WUTS991y01qEWOldKC+e8dEOyeChhy+9pTptU1nFmhsOb7+uWTyzXmtZBJOLHg7LOdRd2rVF+FJ
	kfmdEU7wxrqUpFUnnDnVi6qykt89R5tpqU5YMsrT/vA3b3VfE69RlN0zc4RV6fZK3bWrSkTMGoO
	8ema0KKCQOYcj6Pg0zd6ov9lkFP9/QvDYtVB4n+DR0I2c3dbMhWRI0BjHYMuN0evgUsVZtJ4KSW
	MviVmCOL4JDXyYzRS9nVvM5JeZ61vxSNXlerWKqxBoPfB1hEZ1cMMk2TTlru2v0gYJHQ7AwUg=
X-Received: by 2002:a17:90b:3f47:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-3614048ee93mr4232003a91.21.1776442990474;
        Fri, 17 Apr 2026 09:23:10 -0700 (PDT)
Received: from eric-acer (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613faf1103sm958121a91.8.2026.04.17.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:23:09 -0700 (PDT)
Date: Sat, 18 Apr 2026 00:23:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	shuah@kernel.org, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jserv@ccns.ncku.edu.tw, chia7712@gmail.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: add cpuset DL rollback test
Message-ID: <2yfjwt5s2h7lgr7dvm5fgsvogpt7b6f4oeto6nqu3snyjlwgjy@mnigfkcv2vqa>
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-3-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417033742.40793-3-zhangguopeng@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15348-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,manifault.com,nvidia.com,igalia.com,huaweicloud.com,vger.kernel.org,lists.linux.dev,ccns.ncku.edu.tw,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12BA441D17D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guopeng,

On Fri, Apr 17, 2026 at 11:37:42AM +0800, Guopeng Zhang wrote:
[...]
> +
> +#ifndef SYS_sched_setattr
> +#if defined(__x86_64__)
> +#define SYS_sched_setattr 314
> +#elif defined(__i386__)
> +#define SYS_sched_setattr 351
> +#elif defined(__aarch64__)

Nit: Since RISC-V uses the same assigned syscall number as ARM64, it
would be nice to support it here as well,

  +#elif defined(__aarch64__) || defined(__riscv)

> +#define SYS_sched_setattr 274
> +#else
> +#error "Unknown architecture: please define SYS_sched_setattr"
> +#endif
> +#endif

[...]

> +static enum scx_test_status run(void *arg)
> +{
> +	struct cpuset_dl_rollback_ctx *ctx = arg;
> +	char procs_path[PATH_MAX];
> +	long long before_bw, after_bw;
> +	int ret;
> +
> +	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);
> +	SCX_FAIL_IF(ret, "Failed to read baseline total_bw (%d)", ret);

The first read_cpu_total_bw() call is redundant because before_bw is
overwritten after spawn_dl_child(). Use a separate variable for the
baseline if needed. Otherwise, the second call already handles the same
error check.

> +
> +	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.cpuset_dl_rollback_ops);
> +	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
> +
> +	ret = spawn_dl_child(ctx);
> +	switch (ret) {
> +	case -EACCES:
> +	case -EPERM:
> +		fprintf(stderr,
> +			"Skipping test: unable to place child in the source cgroup or enable SCHED_DEADLINE due to permissions (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	case -EBUSY:
> +		fprintf(stderr,
> +			"Skipping test: SCHED_DEADLINE admission control rejected the child (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	case -EINVAL:
> +		fprintf(stderr,
> +			"Skipping test: unable to enable SCHED_DEADLINE for the child in this environment (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	}
> +	SCX_FAIL_IF(ret, "Failed to start SCHED_DEADLINE child (%d)", ret);
> +
> +	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);

Overwritten here.

> +	SCX_FAIL_IF(ret, "Failed to read pre-move total_bw (%d)", ret);

-- 
Thanks,
Cheng-Yang

