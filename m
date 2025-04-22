Return-Path: <cgroups+bounces-7703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2BA95CB0
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F060E189459C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4118A6AD;
	Tue, 22 Apr 2025 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L7I5E0Uj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E428382
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294833; cv=none; b=U3XZhhpZvolG4MuUXSwOPycjqwr6RFYt63r+n1OtXaSxqp8jt399IS6T2hKZ3HTSxLzsvnR9IuebTW7byEO9ZesxF2sMPnmhImct2C1NWFY3+oyWDkaEnIzynzCrFXe61Vm1gytYg/1itAaAOjiJPS5CqspFDbEJx18zFsS/Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294833; c=relaxed/simple;
	bh=QAdDrtj1nuZWWw4f191Dtr6SFFTVJHIvpOTS7gaWUHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENVKZyq9c6jzViRylOxQ3aFflLeCqaNegZ4dqZwVAVRkpmGqCvvEl9s4icfnQoY/rqG0GecKTnH8/WwaEA7vUN96vKqgm6E6wkC3yWSnbCKeWf67CqvrAkTYT79jBdggUUVVQkHxteUBk00hX/smVjccJyC5Th5Pfn5kX3LI+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L7I5E0Uj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c55b53a459so469264585a.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745294830; x=1745899630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn51hFpFTFagOSHuF4DEwBg/7u0CH8uTd7Ja7DWosA0=;
        b=L7I5E0UjDaJ9Kw43mBYcXRbUwwn0OwmdkoO2lTm+Ox3CRyvs51GKcrCGZPSPq9twdm
         QKMWauOQbhMKMdjEWmUrWrbW1Ynp0vTKmMCLeFiVOU6M0u27qynPP1bPWDu3PlIYataQ
         cO1T3nH15sVSTtg64oVF1lLavVBax9p0eGX12o4bMMZJ846ooTQ1xXcLuRnWBS0ooWdH
         cQUCpPEb84PyJHqncUvvDP6qEu2DIRR9idO40Nm/dj32++eOn1LBnNbx99jpl1XZdPmv
         LRED1mnJnG2nTcszS0DdfPH4B3mtnA3feZ5Nfj5I0+CNJj6hEy/pP7pqHYJOhODtktLV
         LoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745294830; x=1745899630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn51hFpFTFagOSHuF4DEwBg/7u0CH8uTd7Ja7DWosA0=;
        b=bezd4wlvSZhEr9/EN9OKL34fTaxUzRpWDs6VEEjxaJZF8bT2+VBS+DXjeFkpLJ0Rp7
         jEHXjdrM184efOud00Wlhju2ab6dWpsVSuq5jjqEE2PTzis+6Gyjm9pSRcylX91aPEMs
         exVutlS6WlMUqBYdMdiwFMfbK/Wfmlb7cG+PXj/Jktm3dXY4uyO7uF7k52kejSfMvt46
         uf7yXqrp8sek8EoSSbnWrAFqtExuW+P4V+Cuve18vtH47CYzBg/rCBoLtnu7lF/P7GqZ
         kOiNX9s3w0u7YFijwJRFA2EflvbYF0fPfSxwgDaXBWAW2DdRSMxEDqFuLVmFTS3AD3MO
         1kmg==
X-Forwarded-Encrypted: i=1; AJvYcCWSeb2PrGb3PhVsKiJk3baTqK0qYLXNt2A/EWKynvoq0ndo/OsLLtg0lF36B9r5KcYklbnyk0Gn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+SpByhfKzE/t+O1sv64u12OMpUYjBCBV2r3R0AaSsOkFiK7i
	XbiKTi1KPxjNzapl5Yo3c8CzfAMK3EVnr9jS70OE4et6fAbTlWtiUZr8z5t9xg8=
X-Gm-Gg: ASbGncvpFaqkymyB/f+hXqVXDw9QSI5S0Kgi9lEcNOinzysWpVmYeYcqmnzT4uJ3Lf9
	JJ6sdU/3uE3mYvGNy9LZVfSUfFkaY6CEpXa9F/O5mXaNqpnlqzFEn26jOWaUqFuncplsTd1nb5h
	vmn11AvW5MjnDbCHe9rnXYJFI6fJe2c9BjrVXc2OpOYZhgULod+zR1e3SLPa1FGyG1x/cN/C9q1
	rvQ6AeFZm3v1L2kRpky9WHr/HPTlSUkLwAOtLjl4NBKJEW5/MRT45ID8UyuYR5P//Yod88m2yO5
	QSZpTcBMY/Kzj26CEZcjdBakNubo8usBsx11qnatmURmzd6ReaSMt05yyiuRR07bxqqLHYbKm/7
	+ocIsbjdj0iUQAZWfGbr8NwI=
X-Google-Smtp-Source: AGHT+IEiqfCY4yW0u7a48f8L6A0kzRDy2F8MnJUbXRTzNqpzbAbE0B6Uy/hIslrtvzFwl6GwITBPpA==
X-Received: by 2002:a05:620a:1929:b0:7c9:2537:be48 with SMTP id af79cd13be357-7c927f81067mr2156091385a.24.1745294830360;
        Mon, 21 Apr 2025 21:07:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b6e198sm500347285a.103.2025.04.21.21.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 21:07:09 -0700 (PDT)
Date: Tue, 22 Apr 2025 00:07:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <llong@redhat.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v4 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAcV7GmTJGbC1R_s@gourry-fedora-PF4VCD3F>
References: <20250422012616.1883287-1-gourry@gourry.net>
 <20250422012616.1883287-3-gourry@gourry.net>
 <d7568176-6199-488f-b45a-c494c8baec25@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7568176-6199-488f-b45a-c494c8baec25@redhat.com>

On Mon, Apr 21, 2025 at 10:02:22PM -0400, Waiman Long wrote:
> > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +	struct cpuset *cs;
> > +	bool allowed;
> > +
> > +	/*
> > +	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
> > +	 * and mems_allowed is likely to be empty even if we could get to it,
> > +	 * so return true to avoid taking a global lock on the empty check.
> > +	 */
> > +	if (!cpuset_v2())
> > +		return true;
> > +
> > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > +	if (!css)
> > +		return true;
> > +
> > +	cs = container_of(css, struct cpuset, css);
> > +	rcu_read_lock();
> 
> Sorry, I missed the fact that cgroup_get_e_css() will take a reference to
> the css and so it won't go away. In that case, rcu_read_lock() isn't really
> needed. However, I do want a comment to say that accessing effective_mems
> should normally requrie taking either a cpuset_mutex or callback_lock, but
> is skipped in this case to avoid taking a global lock in the reclaim path at
> the expense that the result may be inaccurate in some rare cases.
> 

I'll add a differential patch here.

~Gregory

