Return-Path: <cgroups+bounces-14910-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KsqHm+1u2ksmwIAu9opvQ
	(envelope-from <cgroups+bounces-14910-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:35:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00622C7F43
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84E033057E8F
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A33AA4FA;
	Thu, 19 Mar 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SFeFoZPP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E933AA4F3
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909343; cv=none; b=icNvcgfjxhNBpQk+U/2xFH+NR9qed6y+/rgJXpgoxQgzi+zwWWji914QBK3oK/JRhLyoq3KXw87cr5drDSyTijiumz0TyBTriEKC2lkHbX1AHheXbkmVkE+wvibKN4LsMSfXKHXZfeKhMR36ITvSE7JDk2FAcXoAntzXZBlW0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909343; c=relaxed/simple;
	bh=brlHYeYbANutdqbkUniu7UEfgllAoV3PFIv7GsJEY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7RmQKv9sjDUkV9v3mY3P6lbQ1ie3ATRX+9DFH/KTKoBGuaLCKrF1xOgYDvd2lC2NbaXHXS0pbUei0SMEwW5PhyH4qr7v6CusdWB9nMgForCI5WkKjGp7adCABFwmjLF5dbWkYs8WbeG2jD22/X54CxlwnCHo5QXgT9jXOmMrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SFeFoZPP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fb439299so2904865e9.0
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773909340; x=1774514140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31Icc71U+5J9ABaJwtmAWm2GzoqXy8yAq2rOU0PBch0=;
        b=SFeFoZPPXZsfcj1O71ulrL7ungQBhtUDIaVQMq++lmUuN3NbawcLM5JWbtOsGWrGrx
         RVfIiKhAGxhsZnnLBAMTgkhFRN44dq1VzFdbaB6drKLqCTVPQqgym1HI8kjw2c/GKY11
         BEHUMiOwMgJGSRAx7GOvaO3eiNKv5rE2YuUoBA/67SnbyHKbqv4fQoNnomVS6A7k8nzS
         3r2su98kKgR8TmahALIzIcXR1Zed0E/QgOogF/vNMnuZG3Az6ReG0Bbq8N0MAxlTFMdO
         u4UiuRdr9Bvh7elcxOP3hbgnk5znNDaJ7EAiSBagmiOXZxTVSMLF54tXWgxpwk6dfcSr
         13kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773909340; x=1774514140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31Icc71U+5J9ABaJwtmAWm2GzoqXy8yAq2rOU0PBch0=;
        b=ZxsJXtd4lUsTiPUE7evUvkmYcZWoqtmFzKOyNhId0U+rQYuj3OhgDmnkkza50imu/C
         284ujCgzw6vwQncHHROulB4p+0kwC5toDnBmlvkarE9rPbXnlM/AIiKixnnCZzlVkXZW
         eTAmT/KOnRlXAzl/DJA4fL6cDNTy+qrHgXf6O3fDU3ZCpghiW63bR8O85Xtvk5axsZto
         2toxI0cZPyKTi+eBVCZ60MkmYTjRTQ3PV5SEAvtNMLDxs6DwsxycktXtFj7f2whCEmr5
         GC8L7nidCUe+17B/+74kfuvdl8VVCoVPa/AqwHgwTft8MiVp5dgpctlG3BQMzgjh3nEB
         K8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVH9e+1yXlsmsx++JpWpV4nk9ie6QgCdZWeDzp9q1week5laTX4k66ZRkMzUs+GaVmweBh54f@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwZYTNDBGaK2Bpp4JV7hhYcEiC97vLNRFLVX5pPXKqSSoAj2x
	PmF93TuBgnGZRAe1Sh94DHn0Y0pn3UJF2XRH+EfCPDg4OSaXeLISAKTDzz72vMxKI4I=
X-Gm-Gg: ATEYQzzyMa4ZCrELr1rf9sRwszY3D5GlbIc7MnDF0H0LWccQxoOXrzqHBFYs5usvKgI
	hgIjhPoP5wcjstJi6wrI0El0HGCrR7StdDtfMNGNVjiAJfQ6d4ybJq1xk72CtTrmSN0tU7Lf1WQ
	TOYigkNBytN8pg2+oli/rYgFx+G2zCHDJDJw99GYEJt/IhYimard1FyMd3fLRSkIMQYDucCCAVb
	pHH3EiP6Qw5iwSHkzBNSMNyv/GoHkMXxFWGzrUkOa0m5E43HkWfa8IrW7cycXp4a0enYLCDxRT6
	8M6ZhEPAYQTjiJZj9hj3cf1BoVRqnf4okj4GC9/3tg4PvsNLAFqjSNt9D7Gm6O+24ZaYuwc5MtZ
	61Lq/dHeNsLpF5MkmqBFfuol4E2pC/+Rt9/akWf834/BqsD9Sz22D28AI3bbWhEXg+AUr3SbRts
	PNk1rFbNZr7oDRJ6lt7zRsrruvidKftM9KvA==
X-Received: by 2002:a05:600c:8483:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-486f4430051mr100136185e9.15.1773909340450;
        Thu, 19 Mar 2026 01:35:40 -0700 (PDT)
Received: from localhost (109-81-88-11.rct.o2.cz. [109.81.88.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm48894715e9.2.2026.03.19.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:35:40 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:35:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
Message-ID: <abu1WmUNw8c3ubGO@tiehlicka>
References: <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
 <abp3-iJbazCpygIm@tiehlicka>
 <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
 <abqQtcNqxzxiZyf1@tiehlicka>
 <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
 <absA_ryDAnfaKJXC@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <absA_ryDAnfaKJXC@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14910-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F00622C7F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 12:55:49, Shakeel Butt wrote:
[...]
> IMO we should actually deprecate compact_unevictable_allowed and always allow
> compaction for unevictable memory. We should decouple the notion of mlocked
> memory from the pinned/unmovable memory. Pinned memory has much more
> consequences on the system related to fragmentation and availability of larger
> folios than mlocked memory. If there are applications which need unmovable
> memory, they should request it explicitly. I don't think there is an API for
> such memory but for such use-cases, it makes sense to have an explicit API.

That would be really hard to do in a backward compatible way and there
are workloads (e.g. RT) where mlock is supposed to imply even no minor
faults.
-- 
Michal Hocko
SUSE Labs

