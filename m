Return-Path: <cgroups+bounces-12447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD60CC99EB
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A88C30334EC
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAB274B28;
	Wed, 17 Dec 2025 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="bEjpfkas"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A50274B3B
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007915; cv=none; b=PQV9LAlKDVSQHKVP/wRJ+DaEomwNn5BybfuuA1iLGSPvXX6TY2fNi+OKGq0mo5hOFdI/kU6sVpNLx6SJ24fJPmlQsk3K5wgjiHtxZ+tqDIBXZOLf64PIrL/KZyMTtfMb+Gm0/k/tBTKZqT0xlw/T2eXMuosQThh/uB+74Va4bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007915; c=relaxed/simple;
	bh=c3Mj8ueLcWSuPg9cu2uv4HjE8fHYx/hD1+nTe4fdLX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq321toRcGhUF5ifL0yyPVf7Hdjz0AgNCDhWmi3WqLMaY1X0fLDWzhItRf5wl6UnW9rSNld/P5sMUWzgIWV/MfRDFkAZKqoArcDxa8iXmVV4W+P3Pt+pj2ruTWt7aY+N4Hp6VMVcttEv3bMIRo1Yamp9891xiooofdxFNVq/bCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=bEjpfkas; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2dec4d115so270785a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766007911; x=1766612711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCQw+7EYcHrhI0VW083rNx16bRSH0hX/loU89idlDA8=;
        b=bEjpfkasKhSi32kMrLT76QNWhnSLIPAHmYjIG36CMKu7Yjw9EaaC2WLTTqXlb8Qttp
         BTVCDBLMcoKM5KFwIhNE6doQPmVpUpSqddB+ywgFgk4NyJlnLY7OGDJGaKEDcHmAXMWY
         KEhRFky6fNSTFTRl/HJ/VOZD7/8Wmo9uFH8UuXOsrJBwYoE5ftsoQsn0Q3wYWixM7wTK
         H1yY6DQR4ox3n9OKwAcHkg45qK5c8Oz3Nn9VEzrjISP9ARejTSYBrcvVVEeKIu5JV/IW
         QoL4/I4mYwKeGdB/ox/Xdl2EKVi5HIiWc9uTCLSG43VKCvgzYmwWwhmVOUy1IRup9acj
         UjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007911; x=1766612711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCQw+7EYcHrhI0VW083rNx16bRSH0hX/loU89idlDA8=;
        b=f18u6GoXtKcOn+X/3LOxwqJ44ZN9eQC8/AxlQ8hjjBXnDiFpJ+IKcK7TJk8Nu5FIr9
         m6x9bXBx2C1js15M+RVdOSmTEXfvHcCU6/ljHKpNCcLLeP1PVQ2oJNXHTC8DuUD5yYTC
         aevfzsyFsh0UDSw2hQ3fFSh0ZDH7nW6OVU5Jlv6DTNLfwUuACOjqhplEx83gCa6L+q1T
         U10dieuG3GGtW3t80tGMx3oSDxEOvMw1UgEyaZf8jF4jnOidea3xyuQU8s0mN+V+TQ2G
         jBEGZfO6RvDckgunTYXgioAUFfgs5GzDnSbLpEMe8KVKTmDF7JZhu/d0JwonH/4OjLQD
         DkLg==
X-Forwarded-Encrypted: i=1; AJvYcCWekK1Ivv+2eW8WFCCiPj/W92Gtq1dP5REx3XdSAhRyjD2lr/xagAxH5upIK1qr167sbAwSzyIz@vger.kernel.org
X-Gm-Message-State: AOJu0YxjR3tPFy9WLNRIHJduObqSAvLooj4RmbddvMca3E3sSYppf49R
	/WWwg0frlM7zO0TlpaL7mh/Sa3whvxo5H6fpwqdNNb+Gf+GNBpEH7nio5Vl2rgusOFQ=
X-Gm-Gg: AY/fxX4MsK+cqBNv8dWQ5rFbv9ch+DZOwmcQn4sNVIf3wFdxAuY+gqevUS3SGJSgDL9
	b07oKxpFVazwlT9SGCiKfa7sM4xujgiv6vnwpIJVxqNd37ptPP6vX1UlvaBmx9XgZtXomSv3jfx
	0qj3Linln0mvlH8jlQC4obXGhZb8L4Kb48Cv5iL1KWKJ6BeUcqgvVrsudtvxdeXa1DKKSUeFa4x
	lMCq7Twr1KfpWi5GEKyoOIKzY+QNiBr8WfPid7JTzgHQ4lrZ4TkB9GryhfcMbSv9yMWias+Er90
	r//Mc6F54LzqZyHwnZG9n6G9MAXWsmKsFQqwgvmsgv6/m16ZAM22C7ltHwt2byrtK11ccRBwOIf
	ZUtjd0H+7NHa6mSvDzCy112pXnxs+fANOnD+CP7xhow6PzW1dKqxawknZ0lnia760XcQ21EhXkD
	HbqirZD49SyA==
X-Google-Smtp-Source: AGHT+IE7IeAzYEmDHvM2P4dl1qsqF97yDx6kfts+1/gZKkwJR3IpfyAacSXi+sv6340TQRr4kVA0Gw==
X-Received: by 2002:a05:620a:198a:b0:8b2:7679:4d2d with SMTP id af79cd13be357-8bb3a388998mr2861684185a.63.1766007911186;
        Wed, 17 Dec 2025 13:45:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeba2bca5sm31763985a.27.2025.12.17.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:45:10 -0800 (PST)
Date: Wed, 17 Dec 2025 16:45:06 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 08/28] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <aUMkYlK1KhtD5ky6@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:32PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in get_mem_cgroup_from_folio().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 21b5aad34cae7..431b3154c70c5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>   */
>  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	if (!folio_memcg_charged(folio))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> +retry:
> +	memcg = folio_memcg(folio);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;

So starting in patch 27, the tryget can fail if the memcg is offlined,
and the folio's objcg is reparented concurrently. We'll retry until we
find a memcg that isn't dead yet. There's always root_mem_cgroup.

It makes sense, but a loop like this begs the question of how it is
bounded. I pieced it together looking ahead. Since this is a small
diff, it would be nicer to fold it into 27. I didn't see anything in
between depending on it, but correct me if I'm wrong.

Minor style preference:

	/* Comment explaining the above */
	do {
		memcg = folio_memcg(folio);
	} while (!css_tryget(&memcg->css));

