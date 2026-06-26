Return-Path: <cgroups+bounces-17331-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WhY7Hg6FPmq/HQkAu9opvQ
	(envelope-from <cgroups+bounces-17331-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 15:56:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA396CDBF1
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 15:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YkkxJIrh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17331-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17331-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93DED300B802
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCA3EB0E6;
	Fri, 26 Jun 2026 13:56:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779623EB810
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 13:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482178; cv=none; b=Z+3D2rAsfdCp0TrfkhdJrVQfLrQ9+Skd0kiQkOjTFyV+m+vlEf+ydkiaEfGVwuqJ3jFx+q8Ngbc8ptSS13iU7Bv5raY5r9MOLb0t45p7N550IJ4sixWXgmrg0AAHt0H9glw1Ex9V2M533Xe52s6qKv/jZV+nFe1X6cLeM2P+BNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482178; c=relaxed/simple;
	bh=8YjLWx3uGgLTfeLy1uzKCPph1jBGv2rvv9gzx0Sr4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv4O1CyF8ipyMVKyinxwtnVz6Z47yrji4nO21mPQh/Af4yQPzlZUGDaCmVSM2UwvdJHuK0TIs1siTTggnk0FN+VsOQ+NPDP+33CcxiEYnGze2w7QfB/2yrVMOTw59w+AJQKsScyaO7O+RwH2guD2T27Zbn4ole7oCaKV59FJUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkkxJIrh; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b5737bb2so1075467a34.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482174; x=1783086974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f5RmGjrL90PeH3JGsX34cT0iH3rBjCVdu823akYB8U=;
        b=YkkxJIrhmwIasBKM/f9cGBELgpIpZTNv76mCQPbObnKMydo5S3p8yu8z5ZRTewCLpv
         sbXXewgM+2uHawzAsfj1cVbN7SovNd605HR9+pKdhCTdJ4lsQf2xPnGN3hhle6jv0OZd
         tjjWDG9q/UVvzrkNPdZ8aVVIYRhKT/cf/5jAfmA53Uc6dS5KYZzcha9jM7CTvR52BSeb
         o/HWOkXuTHbmLuxQIAwvCT2lW2jIaSNB+KokB+3qHyjtguqBKHbnGLiGXBgKq5LXHJDp
         PyBX1OwbzCxgdqLuRLqGR1o41bH0Kt7Jelic93D/UVpfwHJ8qNQiaKpwiTqY7tbX2bcM
         Mb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482174; x=1783086974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3f5RmGjrL90PeH3JGsX34cT0iH3rBjCVdu823akYB8U=;
        b=g37SyshQOBOsGhsi2runcp9tvSdCfNqQxQipvWundPlI/BMLwxhb0wtjmYcOsMxW+Q
         kBsJhYA6545ouSz8L6I9lYlNtPEAzbS/iQnSzNTq092pbRg0kYYAblylv1bsQCa7r1uO
         wLsdHsZpQDOE6O6ue7CI28nGGs5DwlmP9DF6QpOZ9L0hDNgZg54rEI09Agp2pi9XMKtq
         Hs6b0mdELYG+zero/iN72T9vRr3kTyEYEnUzQdp3JHoEwHBT/lpu/2sQhPFbCEtppk2W
         Kmd2i9fKSFi8eQTccfdFoiYff3StKid6xm5C9ELSg/j3yYpKe03xGjQqaN3gHyh1de0/
         /o8w==
X-Forwarded-Encrypted: i=1; AFNElJ/5op1LpDa73xVxae0aOJweBUNaKaC0WpZcFZ26eOP9ABYGDjbHdOVXStAAMprHuvOgIGtnsHVm@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUlME5R6HqDW6oqgaBJAEh75t6ZpMAZKUytjdwbkEfSlzmTWE
	SbGq4YtGgGi6rZtFaV2KftndsuqZXjTRY6oi0ho5Vep/8TRnN497Aont
X-Gm-Gg: AfdE7ck1g0IF2IufJ2Dh+/OZ4IKtMC51VDrQKCTGLJrHU8ArAjM0fpolq3m/O2K/zaL
	wGq4oPJfVo1Fdzfnc5u38/kMHgLIudx58hhzm6wrR2we+3xolIkH1zEIMx7kW/oIE0730FkH/E2
	sV1B3MPFbdr4DKqFyKfIDpc9MSTqj85uWstOMgOjvNpEAxFYFdIedXo6McwQxPNS3N+S6T+typD
	bANhdLK2pl9WE4ndOQ9vZ+K9qMbUPM6dQ/lp9j6UbbWVz9Q0vT6G6vOVMOHywvOmpC18l1egs3Z
	EUzzj6dobmlN08ak2RaVM38jbvzoeyf9ySas93isOFJs6D9D/LeojpqqCWRCiVdDEeGKaxb2VtC
	7b2RmTZSxpfHximmUb0mI9uXdJ11LFj/EpOUCHzLdL/vV8QGQs7k+84JRNqW/v2Gle5H/HAEuHX
	r5foo+wz7j3Bkp1oZXHXguTFEJe8fNNHhYSWhG/TfbJG9x+ZDk3hhP3w==
X-Received: by 2002:a05:6820:190c:b0:69d:f889:f55c with SMTP id 006d021491bc7-6a135208f39mr5607866eaf.27.1782482174366;
        Fri, 26 Jun 2026 06:56:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44748ec8a42sm12948931fac.3.2026.06.26.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:56:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare() stub
Date: Fri, 26 Jun 2026 06:56:11 -0700
Message-ID: <20260626135612.3697893-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17331-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BA396CDBF1

Hi Breno, I hope you are doing well : -)
Woah, thank you for finding and fixing this bug! 

> Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memcontrol-v1.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index f92f81108d5ed..4fa6e2bc8413f 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -107,7 +107,11 @@ static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
>  static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
>  
> -static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
> +static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
> +{
> +	*locked = false;
> +	return true;
> +}
>  static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
>  static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}

Part of me wonders if we should just initialize locked = false in the
caller (mem_cgroup_oom) as to not make the stub have side effects,
but your chnage looks correct and this is a fix so perhaps that is
not so important.

Looks good to me! Thank you again Breno : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

