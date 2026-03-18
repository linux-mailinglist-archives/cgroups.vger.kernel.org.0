Return-Path: <cgroups+bounces-14868-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PqPE72QumnSXgIAu9opvQ
	(envelope-from <cgroups+bounces-14868-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 12:47:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0A2BB09D
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 12:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6015300DD52
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53733D1CAA;
	Wed, 18 Mar 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWXMmTzw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249233A8744
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834426; cv=none; b=ux4iekO7mfhXam8CpdcWI6bYf6HCBzR7LAmDWe6u7PvauPDdBrnVc8gALKfSRtRm/54YWYnk2n0OA/M2pXn7g8XkTZKrz0k6nyfVXYDX6/TXqkFfKyqWchs22IbrsBobhq9aW+7C0ajBA3VMMTTT1N+2ALse1qmpK5zh4v+Nujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834426; c=relaxed/simple;
	bh=qGJkUU026cCsLttfeYYuW9q3aD0hKwRfxjLRXqzmExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryx3zYSSwJLdMgt5D1bonOdQYYwdZSZFwONCeF2G8qG4pufuyF8KVodkeQ+0+681lrZD84in6XD4WznGXVefM7UI1NEtf97XpERX3Eo+IAVhg4ovZWkcXytI8eWuV3Uci5/xvIEOrX2iQ4RHNkEF2dBiTIrCexHHa/v7O/RK5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aWXMmTzw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c6fc2910so5148013f8f.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773834423; x=1774439223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXC+9ZKhTZVbYXK2Yzou2mwOrk2yBPN5TmkkaKwC8RI=;
        b=aWXMmTzwNGhZrdOGIIZYE3qeoGrRUIbqFLd6ivcFShk+6HgMV07icsxjpiaLM52Ie2
         zYZM2En8l4O5I6ejCQoU+s9ly80RDacPO3Aj70u0bzX96OgXvrssP2jFeFE72DFQHwzb
         TAjLLnoGhllz2k3ZcHuIdIioPouhWo/pMXjHDhha3eXRqWl0THD01Jd0gQLk/GHICo5m
         SSPoAY1UGLXvT3jSKlVW6DMwG799BYtR8/h9AQjkKmSsS1yW/1EWGsR4JLtjEJFn+Vgv
         rdhCQEelTSVGntEfKHrRfrkHAl0+NWXdy7bmeBPuWDJD6nUdfxOYY+1zv3H9sUIrSxwF
         4FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834423; x=1774439223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXC+9ZKhTZVbYXK2Yzou2mwOrk2yBPN5TmkkaKwC8RI=;
        b=UNX8MrHLa9SoUt9cqKV6wW+yyTg69Pdj67jOZB0+RsVmgQ/ibmPCT+0p9pZZZzSkWm
         Wp8J+6H02JdegoLIDG+uyU5MEXCeRjNhfi5QQ/KTYeghTIWzAzXnYzQMUuGd6bVkC3qh
         sRDGfnR+j32AhSLKwOuVHlgrKNtgE4uY7Y6lgS7Ifu1WC8PBaQgcFEVF1z5z46bIAuen
         biVAmMIbwaibM4ruEDg8dZcvOunYzDXZ3ZqH+EBripy9zpPOxNKnjQoMTST3mgLrIWda
         cGQ3m/ZGGZVCV7GQRZq1YkQF6UmEkPwX0gYKHHbrrODyChpOMiw3v1YtWWdsGk6Mae0S
         vWHw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJW1pKl00RRt+b/UNvdNtxPvXomTCaX2Je1sWaiU5owkUhEfxTwuTO52rc4qmSDHxxHACrPy4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4J/Aw8h4SGwKDLTeWTj4LlLWrMmRIRDyu1jecc3ZgVF6Y5Jj
	hwXiDj5lPpPjzbdkJl5WeOfcp6wBfA331HqTD803H1uzvKe1IU+C7cY8Np6ojACr9ok=
X-Gm-Gg: ATEYQzyhss9KwEP2Pu8PoShf6Q79IGPmaG1orjskrvresSSVywh4h6UNaNk02wfJZYj
	MhZwiv0hDanUxHzT5jPc0ieZvhu4YyIizP7cQRnZhA3tQKuIcaRjAnSydC6kKjrfXDm4V2DZx48
	5sBMWvC3CG8X/BYN6QGG+z4bNfPHVKicScFVS9zVnsJejouHHWlvKT+7xumNu3Qde6kKCw1vKOp
	gybO/KoiZ90SBpfPX/WWOndFHcG9kkqj1H6MleE9DSCNZDPFeh7Yi5JVbfohIS1HlXDgXwqKeDe
	MBqdrt/LCgJm5J+2CVLUSAE7zAACU8dsLKwS6sWeSp6KJTGUwnizlHXlXZPgK/IHglvkdq3bITx
	MMrHM5itYun2K6z6kbsFOTjh35wbMk3lRAv6eHRttiZFUdX19EG05kznRyU0yvpVzt08EZO8BTE
	X2w/SFD+xmVBY6ApUE3nUi88vm0lACsMSenSmt
X-Received: by 2002:a05:6000:1ac6:b0:43b:4362:8ef5 with SMTP id ffacd0b85a97d-43b527cb2fdmr5198029f8f.51.1773834423360;
        Wed, 18 Mar 2026 04:47:03 -0700 (PDT)
Received: from localhost (109-81-21-195.rct.o2.cz. [109.81.21.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518588a0sm11451811f8f.16.2026.03.18.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:47:02 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:47:01 +0100
From: Michal Hocko <mhocko@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
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
Message-ID: <abqQtcNqxzxiZyf1@tiehlicka>
References: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
 <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
 <abp3-iJbazCpygIm@tiehlicka>
 <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14868-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D0A2BB09D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 13:08:31, Daniil Tatianin wrote:
> 
> On 3/18/26 1:01 PM, Michal Hocko wrote:
> > On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
> > > On 3/18/26 12:20 PM, Michal Hocko wrote:
> > [...]
> > > > Shouldn't those use mlock?
> > > Absolutely, mlock is required to mark a folio as unevictable. Note that
> > > unevictable folios are still
> > > perfectly eligible for compaction. This new property makes it so a cgroup
> > > can say whether its
> > > unevictable pages should be compacted (same as the global
> > > compact_unevictable_allowed sysctl).
> > If the mlock is already used then why do we need a per memcg control as
> > well? Do we have different classes of mlocked pages some with acceptable
> > compaction while others without?

OK, I have misread the intention and this is exactly focused at mlock
rather than general protection of all memcg charged memory. Now 

> The way it works is mlock(2) only prevents pages from being evicted
> from the page cache by setting unevictable | mlocked flags on the
> page. Such pages, however, are still allowed for compaction by
> default, unless /proc/sys/vm/compact_unevictable_allowed is set to 0.
> That property essentially "promotes" ALL such (unevictable) pages to a
> new synthetic tier by making compaction skip them. The per-cgroup
> property works similarly, however, it allows the scope to be much
> smaller: from a global setting that promotes literally ALL unevictable
> (mlocked) pages to this tier, to only promoting pages belonging to the
> cgroup that has memory.compact_unevictable_allowed as 0.

This is clear but what is not really clear to me is whether this is
worth having as mlock workloads are already quite specific, the amount
of mlocked memory shouldn't really consume huge portion of the memory so
you still need to have a solid usecase where such a micro management
really is worth it. In other words why a global
compact_unevictable_allowed is not sufficient.

-- 
Michal Hocko
SUSE Labs

