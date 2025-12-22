Return-Path: <cgroups+bounces-12572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE3CD4AE2
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 05:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28E1300B29E
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACDA3090EE;
	Mon, 22 Dec 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdLylCcb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQjAxiJd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B541DFDB8
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766376644; cv=none; b=WrFZyXrZmFguvp/H708sWlYyutQPT4IMDccgMmJjWevJ7AdFo0GQiLBTSzMHdBlHyTdKY7YZr+M9YZUNbDiwKAxAPn6opLdioUJ8pr5wuDyw8bH72lvt4FmVm/PfCETp6mOBsx6h5nAyWYPqyLkoWTDQQnlDcexs54N84W+NAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766376644; c=relaxed/simple;
	bh=W1YngHDZW6ZsrPDb1xICeavqh4kQtMhzCXHEcTXEBFk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=brNhfTqW2n5a9peAOw/uzMabz1EYAn/sA5TuzuSSu30WwjIYXefq8qKSkaDKnBnFK2PqOzpg11YSX0ksBq/iHnC4ZfgWImuHiMUoZSu4+v3zju/IJP0fNfiCeje9YbBzM/dYr+DJ5siz+DFoQwkKriHz0QMpLWtbyDicQsV4sbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdLylCcb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQjAxiJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766376641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMvOngQqHzrYql0DGxebGC7k/0y7G5dyTDe26P3fh3I=;
	b=fdLylCcb8OMgW7GtydiosAlADgEqprESdb8hGgRJQmY/YQ8+N4SIjwUEJiZ012tvmeEfHy
	+Vq6MXFCI7IOTIhgeFdarrQkMujDVjwqeOJuwOyygK3qCCqBGmq+Wp2GH9Hz7C146fRYxa
	NVLl1MPhsi9nLjKA5khgzU/uh5tlkEA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-H0ixDm_rN66ttgcL9zvNEA-1; Sun, 21 Dec 2025 23:10:39 -0500
X-MC-Unique: H0ixDm_rN66ttgcL9zvNEA-1
X-Mimecast-MFC-AGG-ID: H0ixDm_rN66ttgcL9zvNEA_1766376639
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b22ab98226so1237569385a.2
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 20:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766376639; x=1766981439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMvOngQqHzrYql0DGxebGC7k/0y7G5dyTDe26P3fh3I=;
        b=KQjAxiJdp2dsjfEDlOnkxUfIzl/EAikpmSlfW+E0oktK1uvZk7IJwZopOHncoETzER
         uNi3HmHLiDcnwLip83eG0+ELu+iAilMtDNWgsJaB13JM/e+zdap88iHLV1Xc8YA+J8/F
         eOIpR+lJNsLH4q3EjqN94qMu6eKZMU+10nRO5KrrAaaWtXtGMirb6DczjzqvF9TNumSW
         f6D6+FgbTk7JCbWdOeqVG7j0ElzeD1zOksuzVImH6RiPN1+D09fOGyY8K3IkFwEjTFbg
         3QKIVg6WL2KMJQz0ZDCsO/NsdBTHmrgr4p80OqGaQkSq9MauGI0sdLXnTVon8TADi4cN
         esWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766376639; x=1766981439;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMvOngQqHzrYql0DGxebGC7k/0y7G5dyTDe26P3fh3I=;
        b=hzp+N0xG9IFsSW5ifgxclywecBaTcrOQeuemzOvrLS8NdTqH49DM+A9JF4AYW1ZQjq
         UGNwRaqFxjw2OK7Vmg9nMpcX7fjMBTmC1luQxY0TEl0/uNDIJfu/bkOjUrHhf8Ndws80
         qKW27ge6GkzJhBhup2Y01dcUt2rRG5BLFf79BcxU67ngi80EX33fwocHXxuvCOjrWf35
         yhV84ALCwJpiq0xMYBXtezySir4LQdv6gvRaL+k8GSNWS8OjnKqfoPZTS+R/LshKXSSG
         rThfgDs+x0RXMo2j9+1izfimENrePevTsTo3UK+6gnKSzj7KuJkwS19dI4JpKh+t+ZR2
         8pAA==
X-Gm-Message-State: AOJu0Yzi5pSAYJEXM9ZHkT/WmEdFHk0gwqG6/duxih+3J2kS7Sb3kBf6
	Y957AghFBBUMU3wx0RmYvt9z0psMK/C+QT+f4YgvtM3slWKLhu3yCH//eDmpuab+J5zlIwsh87C
	dTyKcF06+Vp1XAGrPV8Ryfqj6cRY9MhAu3kxR9xJ53q/n+a1BM7rV+17FrQ8=
X-Gm-Gg: AY/fxX6CcAT4pQ+i2S6HbbMyoS6FtFKdJ5/5G+p9RsCvwfkE6V9CD7rusWoAeNH2Zy5
	lF89FP8Q35COfXyCZssyVWQHc/5QCJUGkhUCNlSY8l5NMWaL3m1A9PCMLDGgylT0yRts2VIcKbf
	S0V78E6cshh61o3IsJYppnVYtxpNnsera1GeWTOZKfuaAeqAdPhr/sXMvygLVJ13jVoYuLgnMyy
	sseHvCocQsDV8/BycLj6SbZ9VDQfY8Ogl0E01R9RUx27PpOQ65Ap+w34ASEHcD7d+2HxkxLq9Os
	HaWdGcLuB4zV6kBruHj139YjAlsZlgLCy/OGVh6z8K8T1mdReYSVSRz+LuKl2/vZscx0xXrMGe2
	A2EZJckPj1L5EFM3Wac/330Jdx4QeH2VO+lOVNylf8GNk+eA4FMgPSryp
X-Received: by 2002:a05:620a:40cb:b0:893:2ba8:eec8 with SMTP id af79cd13be357-8c08fd18594mr1455034985a.79.1766376638954;
        Sun, 21 Dec 2025 20:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg/CJEkPRRiX/W3BHMoXPl6BjC3jHwswQHYqzmLL+jCYavItFC9JE51/njF1CIPKDUgxa9CQ==
X-Received: by 2002:a05:620a:40cb:b0:893:2ba8:eec8 with SMTP id af79cd13be357-8c08fd18594mr1455032485a.79.1766376638461;
        Sun, 21 Dec 2025 20:10:38 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968913ccsm760352185a.16.2025.12.21.20.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 20:10:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2a829c98-9e6e-4c99-85c1-110a776db43e@redhat.com>
Date: Sun, 21 Dec 2025 23:10:36 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch -next] cpuset: remove dead code in cpuset-v1.c
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huawei.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, dan.carpenter@linaro.org
References: <20251220101557.2719064-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251220101557.2719064-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/25 5:15 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The commit 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1
> and v2") introduced dead code that was originally added for cpuset-v2
> partition domain generation. Remove the redundant root_load_balance check.
>
> Fixes: 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1 and v2")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/cgroups/9a442808-ed53-4657-988b-882cc0014c0d@huaweicloud.com/T/
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 7303315fdba7..ecfea7800f0d 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -605,7 +605,6 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>   	int ndoms = 0;		/* number of sched domains in result */
>   	int nslot;		/* next empty doms[] struct cpumask slot */
>   	struct cgroup_subsys_state *pos_css;
> -	bool root_load_balance = is_sched_load_balance(&top_cpuset);
>   	int nslot_update;
>   
>   	lockdep_assert_cpuset_lock_held();
> @@ -615,7 +614,7 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>   	csa = NULL;
>   
>   	/* Special case for the 99% of systems with one, full, sched domain */
> -	if (root_load_balance) {
> +	if (is_sched_load_balance(&top_cpuset)) {
>   		ndoms = 1;
>   		doms = alloc_sched_domains(ndoms);
>   		if (!doms)
> @@ -638,8 +637,6 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>   	csn = 0;
>   
>   	rcu_read_lock();
> -	if (root_load_balance)
> -		csa[csn++] = &top_cpuset;
>   	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>   		if (cp == &top_cpuset)
>   			continue;
Reviewed-by: Waiman Long <longman@redhat.com>


