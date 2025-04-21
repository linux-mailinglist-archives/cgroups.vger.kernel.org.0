Return-Path: <cgroups+bounces-7689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA1A959F6
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E8A3B6045
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF522D798;
	Mon, 21 Apr 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="owl51VIf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA11DEFE8
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279929; cv=none; b=anN0jyjY+qNAkzow8KhIaR335kmpmBgwQSxN6Ynzj7P5pSJQ9zWN0k4oh6bHEtZ6Fc/MsRKJuq48b4QQkMO0Gj+O+4+Cuhzq2AYnBRFplprEidlt2UgjTyCDHroePLpvoyVjUJt+ZNeXYCj5DYZvkvJPi21aoqr4HKK8C4Llrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279929; c=relaxed/simple;
	bh=3zy2VvTpdSwwEY7USo4c58p9TwHIBfYdkLktzGmo8vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB4BaIAUn0ia9Rzt5x+hZ96YNsHsEbBNZb/gKQvbyDiM2FT/AtsVsmYrb2PvRCT6aOyg3SdNPrzBh1o9+zWLWHMhfd4M/Ojt56PXe9VCjmDdUMBNbTB7j10kviDz80BAxcip5Z1l4i3cY5S9hfH2WucQ+NBl2VHbRHlJw7f7Oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=owl51VIf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4774d68c670so52985711cf.0
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745279927; x=1745884727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt9oqc8GpIrrFJN7eyvDbfp/Y6mGw45gh826BWQtRsM=;
        b=owl51VIfPuosnPNUa51JdrkhebRutajfhoiFn19EMyy8IU0aDKJ0ABNixxDWZGKmjS
         F/sKJ+diyEMLbWq/DUb7aaEQvg233834B6DXyBSwFRd8J4RsX9EmNgRbUCPSsAyMTSOb
         87IpQqn5mV9MbhOaeFVTmTDzFVp2LUItve0Om94pijv3hwhTJIVLoX+OLNSdy30u+wDM
         Zrk5uBGKyWUtbc3aK7fFKVgDfgC0rXGntR3+QagKBKMpN2svGSIQipQycpvQyXrG+slZ
         hsSbklX4qcJZPzI8/XV3TEg5nVyj41NaKRE1HOKp2YFIPH/yomaSqBc/Zc457lzghsVx
         adVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279927; x=1745884727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt9oqc8GpIrrFJN7eyvDbfp/Y6mGw45gh826BWQtRsM=;
        b=Zg2Jqme2KwCWtQIMahmJAGmYe8SqXgRRokmxPhJRMWOyGu24nP33HjEzxeuWYRfBZ5
         KKPPI9WuPGJaN2m8oKUDrl0XRHbMKE171A7sKo3xqGqx9i5pTqGHbkWmRFgPZZxDePj5
         Z4KMJ8ZAa/cigwAaXKuEv4LxfTDcY6FaXRYjht3L7S52QjnSoWrly0aaC9SCXhFDjFia
         dSDR2ghPpYGpFRXjH56p0nNDFFezS4C4s7YmGWNkUH+1qOqaFpauMskLtkthWxbyU+rC
         rJb2dH4EXsh0uPkaFb4uFuToiE835Wt5tLg2t8B7Xm22omgWqkCRxuChTyFCz4jSygR/
         8s4g==
X-Forwarded-Encrypted: i=1; AJvYcCX+IvR/xjuZmlEU/LvpkiSuhjCR4fdmDAM6080QheYmcFK1lP9qAS37ZnWmcd1vgIOQxRL3Kfjm@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrLNvSGQ/qfyA2FHVppN/XdP+ojIjFans9/0yFX8BA/OmoRay
	PkdVPaoA8Zcm+4BlFklh7mp4BHMPZTTughakGotCxKFd1aupyZHUzLLcIh437NQ=
X-Gm-Gg: ASbGnctxqWkJjYPdmuZUVk6viCs0uLE/B/jfs/HbFcTqOppCWu2b3L0ipYTIicBZ+te
	+0GdcePZ/UuwkK6mwLnLVvsPEydUBDaahmb02Dfjhl71Ru+jry24Yi31VpvenSwyFWvEw4DF3vp
	97rUEZF6sbyHyGd6F8DCI/GsT0CiYBCA3S36bF1FlxS8C6MB7Rb50mE5k0gVv97ubjwZSrzQni7
	sFc8N/a3nyXQGwcOSvqzi9dFs0MS1BzqpDniqC3ZrD+bndeW+GXX7hk3S2lG4V1zjCy4q7T4ATH
	8znCm/GJx+GK1Gimf6w1KV1k91tfHommjj8EXiDKGDawln8GGKnNDxdh2+Y9zbJ2R537vEF3Jdi
	jUATdAHg5s26QQuBqYH6LzzA=
X-Google-Smtp-Source: AGHT+IHyw2Ep7wGNuJcJaK9OYDj8tPnDiyNi+wpNnGzryaafEwPJbTCS6g9qpNwxguuCPeJgVM9iKQ==
X-Received: by 2002:ac8:5916:0:b0:477:1ee1:23d9 with SMTP id d75a77b69052e-47aec3a7331mr260243311cf.20.1745279927250;
        Mon, 21 Apr 2025 16:58:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9851b8esm48411951cf.0.2025.04.21.16.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 16:58:46 -0700 (PDT)
Date: Mon, 21 Apr 2025 19:58:44 -0400
From: Gregory Price <gourry@gourry.net>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>

On Mon, Apr 21, 2025 at 04:15:49PM -0700, Shakeel Butt wrote:
> On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
> > On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
> > > On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> > > > 
> > > > On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > > > > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > > > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > > > > +{
> > > > > > +	struct cgroup_subsys_state *css;
> > > > > > +	unsigned long flags;
> > > > > > +	struct cpuset *cs;
> > > > > > +	bool allowed;
> > > > > > +
> > > > > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > > > > +	if (!css)
> > > > > > +		return true;
> > > > > > +
> > > > > > +	cs = container_of(css, struct cpuset, css);
> > > > > > +	spin_lock_irqsave(&callback_lock, flags);
> > > > > Do we really need callback_lock here? We are not modifying and I am
> > > > > wondering if simple rcu read lock is enough here (similar to
> > > > > update_nodemasks_hier() where parent's effective_mems is accessed within
> > > > > rcu read lock).
> > > > 
> > > > The callback_lock is required to ensure the stability of the effective_mems
> > > > which may be in the process of being changed if not taken.
> > > 
> > > Stability in what sense? effective_mems will not get freed under us
> > > here or is there a chance for corrupted read here? node_isset() and
> > > nodes_empty() seems atomic. What's the worst that can happen without
> > > callback_lock?
> > 
> > Fairly sure nodes_empty is not atomic, it's a bitmap search.
> 
> For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
> smaller than 64 in all the archs.

Unfortunately, it's config-defined on (NODES_SHIFT) and the max is 1024.

Is there an argument here for ignoring v1 and just doing the bit-check
without the lock?  Is there an easy ifdef way for us to just return true
if it's v1?

~Gregory

