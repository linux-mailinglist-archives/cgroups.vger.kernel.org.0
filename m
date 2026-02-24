Return-Path: <cgroups+bounces-14230-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGQkIMrynWk2SwQAu9opvQ
	(envelope-from <cgroups+bounces-14230-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:49:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92D618B8FC
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D141D304E72F
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37312D8DB0;
	Tue, 24 Feb 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="icVbHHVB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31723D7E3
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958966; cv=none; b=TcPqU4+a5bBhSmMXS8AD4vbxT3dME77Xao6UfO1qHdqCORlz5T8eTL6D1hjWzCZfKIi1FgeKYj3itS2Q7mCgpKYt1v5ungVS7geQBhF8Be3AeCuFXN8fxTQmSqj1eZRSNCkH9sfJ2bK6hyC7/ygr8c7DWAmmv4fzpmZNByBHKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958966; c=relaxed/simple;
	bh=k+k/ky5K4U9YDjJn6omM+gNVT1kvEpYyJXBxCe7iuvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPSzMx9rPRP9JNeWkmVWYbIRF6oPs2XYYafuFQZ70olBkTbnMxILVG7h25WffwWcCEglMNKroufhBh2fGqADHizWRpNuhCEzciir/h7FSnEd8JUu9bCkhWerhkWKFl8UUSiILxMbg/mOmBGsm79mUp24X5LBLi93JWjBoTypMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=icVbHHVB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb5c9ba82bso936890385a.2
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771958964; x=1772563764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVC2sVLMOxnBh5X5m0M42esgcaqLVi1+yt0xbhnz3dk=;
        b=icVbHHVBEEJhfl/ty9MkmsXGatTK5dKtkU3CSyFAlyN7zwofX0D1+9E4XkbPiYNTaQ
         ABo9gLMM1jZHBosM+kZsNsqIF3pw+rGMmgIrr6uWAHUSbr5vU3HZoBAkiazVWW8YOJMk
         2rPCl5Qt6dsSS0BP6+/Rnt04+2MZweqXaS8HBX1o3aL18J9Dr8IjnwT3d2SUMXmQ4c7Y
         1QrbRPy6EzyiKcelVwAP5JYc20lagSMPQQQA01Vxnql9X9ZN/dVCPVzO667NtWiilgcP
         afu0Sn1Z05Z4Re3X/sitNrXClncyBASH2584Ij5NJQev4Vu8/BM/tlZtK+JTYjC2nXlF
         q8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958964; x=1772563764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVC2sVLMOxnBh5X5m0M42esgcaqLVi1+yt0xbhnz3dk=;
        b=u08YPwS7AjEAE7WWtYGJc31v1+0+ElKRqqYRw4mfwd1XeJIUoAUo7SpeW9QASJXL5l
         9wy1/WtyUb6cFiUlPMN2t3jtHZU3zEz0cUkMh3Z1/Xp+FzzTjP0N0Ls80TRXnmMEYo26
         j1nW6A5IxnF30/JSOGRce+mBxqf5x6P/gl+MlJ7Nj1t9GeAPnC3vCwdxX5HPrzJJx2ht
         WXkKwoFy/AB33WtpIGBsFZdAAG5wpQaCYUMzvK8wFcyjw4LHjNco/3iVtkqIWzESqF9Q
         C/OQBzAB4oQp1InROhqEKusiUb61VII3UmpvUBsYkKpYw8lszNKWj40SuDBo6i54Nql0
         zcRg==
X-Forwarded-Encrypted: i=1; AJvYcCULYjDXC2c1djiFeMBRlr64n2bA7RF/8y2gpup2RGLQC+6QIh+KSa+1aRaU5JNEcYDLJlMWqdbO@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUOQZRLEGB3JLos4JoF+YfG/N0k3cuhTkPM72O//lUl4ALk3f
	ETz/BUGrIL1bIqk6AxFygfY98srPI7nEDhzjsTfubyAoTx9Xo3h0j5sc9yrKOclsnnA=
X-Gm-Gg: AZuq6aK1g7VYlWLLEpnwqAGAFwXzqqMVgpeNmbhd/rXSUZVYXBOMzBHCPkj/BVY8g9L
	YqPfrf7h/YoD1wpTu06c1BpyJi8YGY+jk+ym9+68RtNAQiTFbHZG6ei9aZzHiooFiH4sRmWKriw
	1gMQi0yIu2cxlXcLnnCOY0M/lvy7pjNhWrbV6ZAoETgtsEAFlmp0q6XFfr6ENGDyO71d8p7/xQR
	MY2bR/vKX7mVSVnJqlGckCJ8kq1wzSVaCoCZHSefsrm03t+lYF8zZ1INfi03AKMD5DP2anjbH9s
	Em02dG53KTHcG2EW4sImvN1AtD6/BKXGBWZ8W8364t13AvPPQ6oQnh2EgqWj541ey20mJKtmCm1
	Ui3GrlrnkTOfxEd7mKMsBLVyyuw1QvFhjTsYfrrui47BcMfERlFzAe5TxcbJMFYjlvEK6RWHxxd
	P77uC9zBFvr3FYk0lOZHSx75+st/vraWkHv4gbxZMHYk03cT5hjxUVOAousMA/Fpc18FAPRxpHz
	VUVoWEw5A==
X-Received: by 2002:a05:620a:280c:b0:8cb:5442:d537 with SMTP id af79cd13be357-8cb8c9e005dmr1650957585a.12.1771958964121;
        Tue, 24 Feb 2026 10:49:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d122906sm1023135085a.51.2026.02.24.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:49:23 -0800 (PST)
Date: Tue, 24 Feb 2026 13:49:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Message-ID: <aZ3ysV-k1UisnPRG@gourry-fedora-PF4VCD3F>
References: <aZ2LC0KPF0xsAwAL@tiehlicka>
 <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14230-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: E92D618B8FC
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:13:56AM -0800, Joshua Hahn wrote:
> ... snip ...

Just injecting a few points here
(disclosure: I have been in the development loop for this feature)

> 
> > Otherwise promotions would make sure to that we have the most active
> > memory in the top tier.
> 

Yes / No.  This makes the assumption that you always want this.

Barring a minimum Quality of Service mechanism (as Joshua explains)
this reduces the usefulness of a secondary tier of memory.

Services will just prefer not to be deployed to these kinds of
machines because the performance variance is too high.

> 
> > Is this typical in real life configurations?
> 
> I would say so. I think that the two examples above are realistic
> scenarios that cloud providers and hyperscalers might face on tiered systems.
> 

The answer is unequivocally yes.

Lacking tier-awareness is actually a huge blocker for deploying mixed
workloads on large, dense memory systems with multiple tiers (2+).

Technically we're already at 4-ish tiers: DDR, CXL, ZSWAP, SWAP.

We have zswap/swap controls in cgroups already, we just lack that same
control for coherent memory tiers.  This tries to use the existing nobs
(max/high/low/min) to do what they already do - just proportionally.

~Gregory

