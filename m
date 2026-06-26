Return-Path: <cgroups+bounces-17355-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNcvNsnKPmpQLwkAu9opvQ
	(envelope-from <cgroups+bounces-17355-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:54:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD006CFD1B
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=dAcnO2eD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17355-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17355-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C858D302A508
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A33BAD82;
	Fri, 26 Jun 2026 18:53:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1403B9DA9
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 18:53:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500005; cv=none; b=l7md1gtcwEEqI35tTKxSscepqEXW3ao+EGl9HlkMVTAcgsCZAZ1VzWN1hjf4O8FmQeCydzu4z9umjbi588r5WjpowXN2vYsmXBfguea1Y4hsatbeFYk1JCBXg4Evq7Ub6ijzS2tQCIskw0QHOEXeJjL6coqwiyLLlj72Mr/NmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500005; c=relaxed/simple;
	bh=9XZqRQr/DXO0LxKf+tpIzaYO4GMeJs4kCEdyLaXiu2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs83rVi8uaCseUmqwibfre20O9hLj4q9R6i6rtA3KIsAjqD/IPxlHCCYgdkuxLArDOndjVrKJyXsdYfhs+KhF3F8qKbzr5BebuApHCNvZk6uSKmKL0zkjP5oPDb6gDjw8bXzJ4+eOFSotM3aE0mMhH3xWcF1EZrayJm8Fa97usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dAcnO2eD; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8dd74f90e3eso12545316d6.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782500002; x=1783104802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69VEjjKoDye+wBUZ6dmdcwCgt8H3I0Ua/NDklzX2JWs=;
        b=dAcnO2eDaFxfoCwz9CoVaF0XkL/rzd5Y8ltZgUwXVXuq5eDUVxQrdIG9B/OiPEEQvm
         Q+eCzVYHIQkJelsH+g9qf7UYocUszgZ/qp7tGmDJ7m7cNAQ7WTTPFhei3sU0YvuWAZBF
         P3WlMIX9wyoWDlyDhpYsj5DsBUeKc9MpqRg+kEKEg3toIf3ggqOvHC5duQmJwO13suLR
         A9ex83CV4R0/IpCGDuAVMAoUbDCqCzniJYPG7GrbNbMGxX8WiQyIkx7xrQzZOiijaZqB
         1Gg7+imZAw60UaMwpuITG5fZcx3tVYnNTY6JnnDBfIO1Ta+hvfW3zGZLvSdQYfl6S/VC
         r3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500002; x=1783104802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69VEjjKoDye+wBUZ6dmdcwCgt8H3I0Ua/NDklzX2JWs=;
        b=VldfNTUOCDGxDjnBBV8xAtPvgdXn2kLsxQ4QvZdmZkTr/oMB03K8QSteqSrRct4RYM
         lF5veVzQcOFAEOWWkVHX53ubDOfEi/uSjIfmVk7NZLl4YYWvnQALGfrr7+2OK7qFKgWT
         nxxKTIIK/6HpJ10dVJL61P21E4VA9iXEFgUpKCM1pMzL8JtYuCJBJeVmanlIE5GQr7s6
         du/hqooEsja6/S0joi06lGLMlopqwzPALerMaJHYiLAG0oXHHDioDyMT7h1S3lmkZm2w
         m8KF7z38sm1FZJuMV5fYLdgSrhk3OXpqsPLZ4upP+ja/0/NnHQgBug256dV+qWI1ifYS
         IwfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNU5UsiJRcDvteOFdYbLuT6Zi0l8eQ+s9cIS+idkqB0rmYsJM6mhsxx7OTuNTBqJEBBNRpYIHB@vger.kernel.org
X-Gm-Message-State: AOJu0YyskVgJoJIwuNDd3jMTLPttWyHPctKPH5Up2QDaYbZs9L12n0hY
	g/oOblbRSXgjKHam5fIHZqyfrOgMd/innm409RPV9qvBub+x9KA1anOFbWNDHlknjck=
X-Gm-Gg: AfdE7clYKclz0yF0oqwM9yALdT0/8WASBuEJL4hxHdv+Y8VK64B5rtTI2k9u9n0yCgs
	WCiofK0Zou20R+YJXJ8VACqctmjv3iLkb7+2+eNszR9umbo5GtrzMDK7FA/sBOkh/91Ye6XYW/e
	RryLcHiFxM995Ad/sNi3Xrt21z2bhINXipBx5OFYfNdhpx0nPIKn2NiKhb9tLll4bjEAjtLBCF7
	qrFr7D+oDNrv2gBg1BpI1IHen0PfmFJlCadi+QaV9MvmL9N2dvM1sqYjwD+KMRlKHXv0f/HeW/F
	CI6LxbSgMffaL9EbwBZfZo72MfAeLvk0wfitSSO3NVRm7bxZVJJqhGzw6QQAztuOHKr4S1ATyl1
	9AoBTJIim8JfwM8y9eOd48uLE88COYo0QB6nvqPAFu5LQXv10WpBc++knsn+3f37l2WPDVXJCHN
	TqGaPnnuMX1vA=
X-Received: by 2002:a05:6214:3907:b0:8db:a79d:1f0d with SMTP id 6a1803df08f44-8e98609495amr30686266d6.31.1782500002098;
        Fri, 26 Jun 2026 11:53:22 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0180d3sm219727366d6.3.2026.06.26.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:53:21 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:53:20 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Breno Leitao <leitao@debian.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare()
 stub
Message-ID: <aj7KoDXJv3NByGUm@cmpxchg.org>
References: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17355-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AD006CFD1B

On Fri, Jun 26, 2026 at 05:43:02AM -0700, Breno Leitao wrote:
> mem_cgroup_oom() passes an uninitialized "locked" to memcg1_oom_prepare()
> and reads it back in memcg1_oom_finish():
> 
> 	bool locked, ret;
> 	...
> 	if (!memcg1_oom_prepare(memcg, &locked))
> 		return false;
> 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> 	memcg1_oom_finish(memcg, locked);
> 
> This relies on memcg1_oom_prepare() setting *locked whenever it returns
> true.  The CONFIG_MEMCG_V1=y version does, but the stub used when
> CONFIG_MEMCG_V1=n returns true without touching *locked, so
> memcg1_oom_finish() consumes an uninitialized value.  On a memcg OOM this
> is reported by UBSAN:
> 
>   UBSAN: invalid-load in mm/memcontrol.c:1932:27
>   load of value 0 is not a valid value for type 'bool' (aka '_Bool')
> 
> Initialize *locked to false in the stub; with cgroup v1 compiled out
> there is no OOM lock to take.
> 
> Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I prefer this way over the idea to initialize in the caller. For the
actual implementation, the protocol is that the thing is initialized
when the function returns true. This version of the fix maintains that
for the dummy as well:

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

