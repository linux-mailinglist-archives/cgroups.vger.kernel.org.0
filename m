Return-Path: <cgroups+bounces-6158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2CCA1126C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 21:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72F1188A3D3
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3D02116F5;
	Tue, 14 Jan 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTG0Aby"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC120D500;
	Tue, 14 Jan 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887523; cv=none; b=F+gyS5lAb04yeRRfGqBrZeJLjRNqB7GETLYcMPNpW6IC7O4dGJxU6uYf6TPUWTe1uoHB8FpHgi8ktDoNV+vmo7rSTxlvMGfnvIfR3JqeUpnLvdKzXUizWLb2dXNsxYpUlGEA9Dj+AFVP0TJkXW1dI3T1JWmJbkU/gN6wZpl5dmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887523; c=relaxed/simple;
	bh=R1oFIOZuyTlZ9/KSoUnY5+kMbKSnchbcns49StwnNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3OYGr1lGXx5e2ThEAAUHkebNOQJaSudJL5/fekiQwFTmoStqK8R886VgpYYFbHq18HURcYi3FkkeYOhIFpC6lvWz/DmQ5pF5wSUDJigF+hAJk2BsrRpO3mtk/FWHmTEx8hYXvmpahMtqVTmdJ9n+u8EjsAso1euxVB58bQyxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXTG0Aby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEFBC4CEDD;
	Tue, 14 Jan 2025 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736887523;
	bh=R1oFIOZuyTlZ9/KSoUnY5+kMbKSnchbcns49StwnNTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXTG0AbyqtcAzO6bElAJ+A1VCxciW52E5T26xpTEyw2whJqlqaaG2aoCpGwZFC/tQ
	 8mtWaDLWzFKpBaTl7Bvl9SR59K2yiCPVqxKnlU4rcp0olpQOfBmpy4L8VkFIhY8qLP
	 I9TFOiigEGmOvMfeSn42mImNnlR4zBre/X+pSsGjZnxEAiccE6Pjqo3MiybOct3e75
	 RDDb81Pv/uLTjnUBF22O7+I/aIsWpjgZdcic+YlOUMtxSk8oJCBFuZmRu1NxpB/pzV
	 KtFm/vNw9m5pUB+Ch4GykG6SPLObuzSAxKY7VI/N5WUlh0N2N7l70AnkhkAxAXv5yW
	 T7o0gebuclBAQ==
Date: Tue, 14 Jan 2025 10:45:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
Message-ID: <Z4bM4unKfX_bTop5@slm.duckdns.org>
References: <20250113092608.1349287-1-mripard@kernel.org>
 <Z4Z6Y5Xy5m4wMu_l@phenom.ffwll.local>
 <20250114-convivial-axolotl-of-performance-7c2f63@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-convivial-axolotl-of-performance-7c2f63@houat>

On Tue, Jan 14, 2025 at 04:02:55PM +0100, Maxime Ripard wrote:
> On Tue, Jan 14, 2025 at 03:53:23PM +0100, Simona Vetter wrote:
> > On Mon, Jan 13, 2025 at 10:26:05AM +0100, Maxime Ripard wrote:
> > > The dmem cgroup the page counting API implemented behing the
> > > PAGE_COUNTER kconfig option. However, it doesn't select it, resulting in
> > > potential build breakages. Select PAGE_COUNTER.
> > > 
> > > Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202501111330.3VuUx8vf-lkp@intel.com/
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > 
> > Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> These patches have been pulled as a separate PR into drm-next, and I'm
> not sure how we should merge these patches.
> 
> Obviously, we'd need Tejun's, Johannes', or Michal's ack, but should we
> backmerged drm-next into drm-misc-next-fixes and apply them there?

Acked-by: Tejun Heo <tj@kernel.org>

Please route them with the existing dmem patches.

Thanks.

-- 
tejun

