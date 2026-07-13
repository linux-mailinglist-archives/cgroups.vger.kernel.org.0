Return-Path: <cgroups+bounces-17698-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /QA1Mca4VGpOqAMAu9opvQ
	(envelope-from <cgroups+bounces-17698-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:07:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1854A749A06
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:07:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=AIPV4hMS;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17698-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17698-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6CD300B601
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039633C81A9;
	Mon, 13 Jul 2026 10:07:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCB343896
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937219; cv=none; b=c6M8bMzSmn5coDVc4xWOSfDJmbqJtNDLEt3uoW60asAD77C7Wbzz5xZHJw5etMJeBd0kz/dM6JDmbxbdOrePDjtPpVXA4bM3UAGPMv/9mJJQ+93x9zZ31eaFxz3UqA/dwdp4f5MNjfoivEe7mkzXvWFiKAq/EpYNGkPmzVrjZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937219; c=relaxed/simple;
	bh=W7oqSuaZB2ccmyWneTUFNc7JdiJBHZKqqDjFcQtrvrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4tFRf0WoCF9Kg1bq6+VPZfkaykg6/ywONVVLtDDtdQJguyHOlkETljHKVBNx6nAmrvb4WKxGP88kyrOqguP4bRZ+rcRAFhbBiLnN92b+9yisvFQ8mDwEXkhhDuEX2D/30caz0IA7BEjYzkFN9Hn6erm6n5skTaA8ne0YYDVeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AIPV4hMS; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b27c7451so48695115e9.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783937217; x=1784542017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaLYxWzQpErVcY7Rt38G1DE6Q5Yue9eCJtuT5mqHvNM=;
        b=AIPV4hMSp02bdoIWQbrYItPqT+39WHpu3vQmhNgR/RpoK30VDfMZqDgBqmpuAFKmQx
         3RSD5g4EvhdLpUtNTLkzp03T+ciPBHVdFADjZ1fSrfLGBw2F5f4EC2ULVGBTZA7Xce/f
         8pphmT2dDpvARapLSVcAn4nbwK1EhnW6IMWfp4Xf4AlRPZS8fkg41PVHlJrGWuaeZquY
         qp83iIuInN1ou3sXR+8IUOwLGkkTE8se7TvjbQIbX1YxOP9JYHF3hyjAFKXKtqohA6Gk
         igO1Bf1zzM8dgu6M3gOscX8Vo/o0kleeJR92+78eLZ96hXwlh3UB+nDzYlbxuaR6k3eE
         Y4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937217; x=1784542017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaLYxWzQpErVcY7Rt38G1DE6Q5Yue9eCJtuT5mqHvNM=;
        b=kmpd6PiU0oHcOHrz2LbnC6I1KX3Q8/nqLqGdg6JTVPxBRbc46+ZKylSflp4Lpvna5f
         sfEsJ7nAA/8vq5wrULUyCYGYXTdIpUAOwOf+OJrCtiOhgNdACFWI4Jz+Op2/TryhRuC9
         mqcQedG84g3rTHavxyPud+kRmZNTY0mF9L6vuHTa/6wSZC8oQcEQCccdd2fvlLskT2Y/
         Fs7V2rmkoBvsvbZiof9kYoaa0cw8v7NcKVOUSPsNfiP5pLyzY+UHWaXvcW0G7L8A9Ptq
         /SrJkMq/cJzWkQtcBSeafBo0U/wUXR7IEZQHE474CUasm6xlCoreBaJKrCsXeNeNTpcv
         2rnw==
X-Forwarded-Encrypted: i=1; AHgh+RrINKpo91A5D2Z2Gfi3nWLgxl8/iEvHXpOLkN8BeuTDEazz8EmafgX/yi/bTQFaiW8a0wg+nxsW@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcZgjyK4SblvKguQC997p7PHhJKcEWCIi1LUBmK5wmhC29vTC
	YH/x+YOqku0hFuGTWiOtRh1GrAgIJzpHJXGhhckFhVj6uLEfKx/V1q2wavLsXX2hRPc=
X-Gm-Gg: AfdE7clUpegOVZRZ07p+0XQ9dCTBQPkAOuS6prY1Z+8L6bXytwHRFJL62GTn8qotanf
	xNfd2fimquoBX+7ldiNPxdr63js/Ox0xJwzha+dJdPrcPwVKVeqlDvtCs2r7RmN+igskN0Ihko2
	X+xCI/rwpq+vtuA2ivTOHYLNpUlccRyR0tWw2UqUWAyRfx/3j4Q2U79ZdLirOop0L+4MbNniXXg
	/bLXPqJPnTYhb502BWuK8F/kW5hEkB1scy9jH+TCpFgDm5jJBNtLhzpXIGIUHe3j6HzRWPuGH2z
	WZuwAPdJx79SzVZz1SXr3hIrXuuaFbLCZaa+Gsyt57C27scmQcd18CoZulNmiyTYT3/v73KIV1j
	5f5zYs0+jj4JgN0zQaDOy5TAibl5vxY6GX2y/DOf0wTH5w9OyGpFjnllLyhvCmClToNYzuctorb
	e50mXKSYNrRqf0+vS4NhbaZ7tbMARRzW+Ynw==
X-Received: by 2002:a05:6000:2f86:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-47eee0b8778mr16404780f8f.0.1783937216714;
        Mon, 13 Jul 2026 03:06:56 -0700 (PDT)
Received: from localhost (109-81-90-85.rct.o2.cz. [109.81.90.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm83341119f8f.14.2026.07.13.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:06:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 12:06:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: fix wrong linux-mm list address in
 deprecation warnings
Message-ID: <alS4v5spUF224idW@tiehlicka>
References: <20260713085756.2973549-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713085756.2973549-1-guopeng.zhang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17698-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,tiehlicka:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1854A749A06

On Mon 13-07-26 16:57:56, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> The deprecation warnings for memory.oom_control and
> memory.pressure_level use linux-mm-@kvack.org instead of the linux-mm
> mailing list address. Remove the extra hyphen.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

Altohough this is not a critical fix we would like to have that address
correct also in older stable trees so I would recommend backporting to
stable as well.

> ---
>  mm/memcontrol-v1.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index e8b6e1560278..178e1466d898 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1182,13 +1182,13 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  		event->unregister_event = mem_cgroup_usage_unregister_event;
>  	} else if (!strcmp(name, "memory.oom_control")) {
>  		pr_warn_once("oom_control is deprecated and will be removed. "
> -			     "Please report your usecase to linux-mm-@kvack.org"
> +			     "Please report your usecase to linux-mm@kvack.org"
>  			     " if you depend on this functionality.\n");
>  		event->register_event = mem_cgroup_oom_register_event;
>  		event->unregister_event = mem_cgroup_oom_unregister_event;
>  	} else if (!strcmp(name, "memory.pressure_level")) {
>  		pr_warn_once("pressure_level is deprecated and will be removed. "
> -			     "Please report your usecase to linux-mm-@kvack.org "
> +			     "Please report your usecase to linux-mm@kvack.org "
>  			     "if you depend on this functionality.\n");
>  		event->register_event = vmpressure_register_event;
>  		event->unregister_event = vmpressure_unregister_event;
> @@ -2340,7 +2340,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
>  	pr_warn_once("oom_control is deprecated and will be removed. "
> -		     "Please report your usecase to linux-mm-@kvack.org if you "
> +		     "Please report your usecase to linux-mm@kvack.org if you "
>  		     "depend on this functionality.\n");
>  
>  	/* cannot set to root cgroup and only 0 and 1 are allowed */
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs

