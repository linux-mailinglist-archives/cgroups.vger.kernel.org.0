Return-Path: <cgroups+bounces-7944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50FAA43E9
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B288E467012
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6520C00B;
	Wed, 30 Apr 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AMMURuwr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39721EC01B
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998064; cv=none; b=PmY7MD4JEdGw+FQJZ1dZcKiyqeb45J8YCCZ5lfcRjv8QTGyzIjY1ctpgEYRrXsQlXwUh9fkapb3K37xQ2f8f5uW9c1wzofUnpxjlm01kf0cqMxMiYbUy3L/4b1cmOSSQIf5u0HxAG7lWgTR20n9zXuZ2fUgJxSmmyz3Og7+of+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998064; c=relaxed/simple;
	bh=zDGaPsNn+sHsyuMSVVCvcKEN9xOybH1pQe4tKyhYIbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYe8jVs8RmpPZ66ptPWrxXMDAmOwinNwHS/owXbTo3DY89DnlMx5M0MMDhwmEw/WsnDlHk2wUKNV/TixFTQXq3s6CDQ/NByIt4Qix2ON/6w6AmXrYzB9fePynzKOzsyX8RlzxAy7ZnXsXv0Dn1ZNfCdpSlouol1L7b6rp9t/Tsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AMMURuwr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb615228a4so124322566b.0
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745998060; x=1746602860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlBz7iF1hek+FTGw3X4aAHw5f1S4jYqTggUPhRMIVXc=;
        b=AMMURuwrJ5A5njlldNIV6popjXuhXpRp056f0DCoCYg9aodP5BPku5C/GCqupBLy9w
         tBc/YDVjDSrWikWqRLwE+RwIf6hWyuc+8vCSP6Rio0NJ/U6Nfd3WfVUJ0jil/NVHMyhX
         0L5M2GSlcu8/Z0v0B0xzPAEwmqgCynZY38GTwp+tDDH59OLoCKyYqns7UAVgWS7bY+Ei
         qjdXntdbDuwuoTMRBt/W9J4ZuZL7ddTWeuQ3uDMshqPGmssBIblLBTNu40IG5cE9YIvh
         +qg0zhgayhMexJOuFwiBd9o2fUUUSMCB/XaZVe20s99v7bUH929ZWpqw+83QqALJN4mr
         avbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745998060; x=1746602860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlBz7iF1hek+FTGw3X4aAHw5f1S4jYqTggUPhRMIVXc=;
        b=LBgTBZS/Jy72JakkDXG0Mv7ZjnWoPY9kiLC/a43VyKTKEuMKlNZWKy/qv3tRwxPDlH
         kQvSaKXL9lXuU7YP6Bn9HGhr3cn4uHAgguW1YM0LWDxgB7kIx91UegXJXGMv/F44ij5L
         Xe2zsgoNhGYqw1ym/uSTNW9a5DhcnvPzV4QUN1aN0aErVSJjiRfKc/+PdkpQKoSU8O6u
         PInHdbpw6EskIWHeLpywmS/J+yXJuWAAV5wOKrpWUFCrhZJO9X+U9Nw6jtrGdKS/H5Qd
         4fqHBRrDHYj0iusek4FvxQjpxMxUgoUD5yiI5TsjPS7pzkrKX3vSQsXSsUDalxBxXTmm
         Tfyg==
X-Forwarded-Encrypted: i=1; AJvYcCV1GjHlgw2LcJBXZ5XgkOWpjJgxES5IB4KZYhHLhfYDwm+CrpopObGLS/zVYaU75HA94yLJ2sog@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpaelRUQZ7bMUm991r2pKqinkQKpPeqD6m0ar9CEpVvX1L0Xf
	tgEpxQ+IXlXE9EsVCXdHtG55YviUVxA4m7gNS9PBSfdesDVmStYl5Y2XGhE41lE=
X-Gm-Gg: ASbGncugdrb4ExPyApmrkkDW52y0OGJwHQRtR9kkWe2sCKwhDe6GOvouSeaY6VdvUET
	uC/H2Ug/EpIsvmCDgIcimQODkv7/Trypa0usDEUUAwseCKKYeJ7SDgDfK4F9vbuVMzGdlCKi7lT
	uxJdiAZEtvunuBgv9OaJ11ObxRaf4UHbulEfVGWPWKHN1Smv5UgVzzEV3UJAe/Ig6Tz5STr3lvX
	3dTRfdcmigP3muJidtLJKz6UAq7ryq/u+2qmwqM2D+QDE1VE3Z0SkNP9XgFzPKbgwjtNZSGofm2
	CPEBpGuCREVwDPtowHjdB1eWNM9im6A=
X-Google-Smtp-Source: AGHT+IGHXR5iYRXyJph1iKrCVhcSCgbOSnDW32/4au9VmEwpUAXHvuV7+98LviohpFzXoUW7wi3S0Q==
X-Received: by 2002:a17:907:f495:b0:ace:4ed9:a8c3 with SMTP id a640c23a62f3a-acedf68c196mr173112266b.7.1745998060149;
        Wed, 30 Apr 2025 00:27:40 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ed6affesm884107766b.130.2025.04.30.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:27:39 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:27:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBHQ69_rCqjnDaDl@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
 <aBC7_2Fv3NFuad4R@tiehlicka>
 <aBFFNyGjDAekx58J@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBFFNyGjDAekx58J@google.com>

On Tue 29-04-25 21:31:35, Roman Gushchin wrote:
> On Tue, Apr 29, 2025 at 01:46:07PM +0200, Michal Hocko wrote:
> > On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> > > Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> > > an out of memory events and trigger the corresponding kernel OOM
> > > handling mechanism.
> > > 
> > > It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> > > as an argument, as well as the page order.
> > > 
> > > Only one OOM can be declared and handled in the system at once,
> > > so if the function is called in parallel to another OOM handling,
> > > it bails out with -EBUSY.
> > 
> > This makes sense for the global OOM handler because concurrent handlers
> > are cooperative. But is this really correct for memcg ooms which could
> > happen for different hierarchies? Currently we do block on oom_lock in
> > that case to make sure one oom doesn't starve others. Do we want the
> > same behavior for custom OOM handlers?
> 
> It's a good point and I had similar thoughts when I was working on it.
> But I think it's orthogonal to the customization of the oom handling.
> Even for the existing oom killer it makes no sense to serialize memcg ooms
> in independent memcg subtrees. But I'm worried about the dmesg reporting,
> it can become really messy for 2+ concurrent OOMs.
> 
> Also, some memory can be shared, so one OOM can eliminate a need for another
> OOM, even if they look independent.
> 
> So my conclusion here is to leave things as they are until we'll get signs
> of real world problems with the (lack of) concurrency between ooms.

How do we learn about that happening though? I do not think we have any
counters to watch to suspect that some oom handlers cannot run.
-- 
Michal Hocko
SUSE Labs

