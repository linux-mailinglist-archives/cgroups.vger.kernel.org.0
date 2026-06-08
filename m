Return-Path: <cgroups+bounces-16701-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KyfNGe93Jmq+WwIAu9opvQ
	(envelope-from <cgroups+bounces-16701-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 10:06:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52540653CD7
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 10:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=aGQE7jsS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16701-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16701-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DF053014858
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A239934C;
	Mon,  8 Jun 2026 08:02:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB04395AF2
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 08:02:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905751; cv=none; b=EADnslCKBQ6XaR72Qoj/Zdwtz6DC/E+GxuEl+tLaUrOHU4f079lSRF/pMoAAHxP51GHDlefncIaTOhH3eKMvosgatRPUe8jJ4ItLRz8WW3GetIwunvY2lycO9VILM1EsNpWj0WLDdKDAC/kYg9pLAyNozjhj8QMnjqk9H+bDML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905751; c=relaxed/simple;
	bh=oSjjQCOpHsmpRILc6WfiBhPToJInYMi/ObdCxNJwjnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOOaVezwu1Yvwy997bZCtKV/9V4UuuXTgwnQKLM1dXnP9ZgkfbdaN1BEaxYBy6r4v7CcPBqMxCVXrYeMR194s7mYaIEsPq88g1dUXNDANM+Hzd1uE42LYjQISUsIPM+lo2eQf+pEF6CmxKa+QUIpIpjU2b3rSpAJ/wSDg/Wq7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aGQE7jsS; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef616daf6so3571623f8f.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780905747; x=1781510547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4D+rfriPl0lY9EHYm9kP066Cn47rD/uQ0mtQTBMxuw=;
        b=aGQE7jsSpCnYf7/Qqqn/++ZD4bYeo7H0qfIvbXmQMnQGjVeyM5kP7MMWYofvjKuryJ
         rA1Psk9uurXHOVE3RyDGY1FDa2QGAaevkSMmJnwn7XnqJma7uJYEWdoUL/ItahsEFl7o
         IPvFZCN7m5knLEFLM2rj64PRKf2QiCmJPaEEnToZ0dF3e0MzZ5kd/yx+VlGRbUh+9FFO
         i/koabJIVRFVC689ZVT7cAnl1I/QikSz8y7/E24wgm7nWiZxuUmR4jZ1+dcZ8uvcSG1Z
         IKXGr4NpUDuTSn6bEWdHDiVcTB4okW0mbYdYh8GVTKmx86ST57DfYeCmQhzIHBZstwZe
         34ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905747; x=1781510547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4D+rfriPl0lY9EHYm9kP066Cn47rD/uQ0mtQTBMxuw=;
        b=iyu/iDvV+dEtxntpb2FhGjWZjU7tgdfIfGiQ9ROv/BkT0Cxwy4oNbhdqy45/kYBHr/
         e4poJnecxu96Rt5ajaUo1I6bpdmNkPtz5TxMW2x2BzqYttqXFR9exmksiDd1FjYUv7uv
         lqgz+XiOwrV7X6LAKYkhFHYxgVbeQmrnTW0RHNuJHmLjoV5M8J+tCBLkJWDyazRTyG99
         +gh9Tmb+Yzc5F2dQgHdW17IZ1YG18xl8CdpgrJq3ZlfXMs9vtvBcY0xb3ZAwxHCjdBUN
         E0dRUum3BU3IyKJLihE/WtApZPFEU0lqXHyMlS0w6fx3wBKYO/CePtTKSADkg1/cygFJ
         GGEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CD880B/Ag+9kyRNekCun3fu7AbQmNf3MISjbM7obIIyA0tYHhoOYUZX/DdRIrHslAdFy2QNvr@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPoGXhXWsvEtOSz6n8XhWW5W+wKsQGZATV0fgxchVsBHNZ5sj
	GzyLIQ+n8T14PtghiD5fhtFd/WHjwTXVMGDvj6uIPd9mZRTCGyQRpHQL92KBsUTFBew=
X-Gm-Gg: Acq92OFHQizkD1Wb2WwD1Hbnr4R8JI4etX0xAqnmblkNBdrP0RNh/qH7kirZkyR/7FT
	triv8jwNcjSNc99CvpW02jWEL7xJv1bFwWsOrCl1oqTXV91yymXKg9JF96RKaMjTpBDD/nfD0Rb
	DZc+vFmH6kl1Tw/Mqg3P7OnwALvBKDQFuvDdeF2jS6IfwVlh5F3xSm8GPwBxkEGyuoehrB+rUsn
	4fS3xYBvdxlDN1HDXwNpccJ4OVfNrpdmWH4Kxws1M7CAf34h2tq2X3felFayP/8bycoVhS5+wgr
	Ld+sU+zA5UmWSbHVdvgvb6FcvyzIuQxkvvyAfWXjAH29cS/bBn4E7kj642epprrRp1IyYMPgmuE
	sFlAN1IOIQ+1whtWxpiX1JGCy4w/2pQ5SEvLwR8xI4hcNXaUpFKTtK6YIDGkYXVcZZVy0lBvRED
	c9RZ9ZVxcl+ZVIDUORSzDUlo10Y6ZB0ZVjVLhOODcisQ/Zad8=
X-Received: by 2002:a05:600c:1907:b0:490:b99c:9337 with SMTP id 5b1f17b1804b1-490c25a0800mr227077665e9.10.1780905747263;
        Mon, 08 Jun 2026 01:02:27 -0700 (PDT)
Received: from localhost (109-81-90-161.rct.o2.cz. [109.81.90.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm447585645e9.9.2026.06.08.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:02:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:02:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol-v1: use nofail allocations for soft limit
 trees
Message-ID: <aiZ3EZZV6LqsTxQM@tiehlicka>
References: <20260608063644.39-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608063644.39-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16701-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:dkim,tiehlicka:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52540653CD7

On Mon 08-06-26 14:36:44, Ruoyu Wang wrote:
> memcg1_init() allocates one soft-limit tree node per NUMA node and
> then initializes the returned object. If kzalloc_node() fails, the rb_root
> and lock initialization dereference NULL.
> 
> The per-node soft-limit tree is required by memcg v1. Use nofail
> GFP_KERNEL allocations for these init-time objects so the init path does
> not continue without the required tree nodes.

This is an early init code executing in during boot. Have you really
seen this allocation failing?

> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  mm/memcontrol-v1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 433bba9dfe715..3f41a15d8a8cf 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2246,7 +2246,8 @@ static int __init memcg1_init(void)
>  	for_each_node(node) {
>  		struct mem_cgroup_tree_per_node *rtpn;
>  
> -		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> +		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL | __GFP_NOFAIL,
> +				    node);
>  
>  		rtpn->rb_root = RB_ROOT;
>  		rtpn->rb_rightmost = NULL;
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs

