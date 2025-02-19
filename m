Return-Path: <cgroups+bounces-6608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC06A3BFC9
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087491885DDB
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920831E5732;
	Wed, 19 Feb 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y48oya/i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B91E25F1
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971449; cv=none; b=geumUe93zFVN17ilUY9XulEZHc50fcN/6suN6XWN4lIBorMj18f5xIRsWMOGFWczLPXPWbeWmAcCw/6Mvrj+YzhGdkz2QnAjOXxM3O8DsFK3BnugoOSK6cJpjRMi1vONvd9IV8lDZGmQFssetJEKZKHLjM47LYp3+R46uLkJxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971449; c=relaxed/simple;
	bh=hrmqbTw5nXFiCLF3XbuU+w7rXvRvzpFDu9PD+VV3EAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfwLjoyUXd1g0y98TMDRXA38+Oz79t0sqcbipZ/5v8f3RJlVsg+iN8GJ8fhnwsUI3ocEXjqKdF8bUPKItGMbsqBQ2zcP6ctMA+4nS9GI1pSyB8QIDFw8lBXNUBU0TZpnYHlG+4KziR6seA2xAqy3UMD0oxp8J6DhzaCgPSp18Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Y48oya/i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso3626575f8f.0
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739971446; x=1740576246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6cGsw4jqrcJ6wKuFhhp6XRGQKCyudNO1D27r9k9Kyk=;
        b=Y48oya/iFVyTPAIsk9ZVGVv9p5w2FV6oFJCQ68P+S0svsyhHSj6PpUfl6OYd7ehp2B
         VhkMHOtpl0Oo+uTFaxrh4QIS5dokaNChwKwHR8JOQWncTe4HzLVbuCP6xb2orAgiAmjT
         J8gmt2/rgiNWFg7yskWyU5UqGTboI87A39ALE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971446; x=1740576246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6cGsw4jqrcJ6wKuFhhp6XRGQKCyudNO1D27r9k9Kyk=;
        b=u1kR5ejMBSpdpeLUbMJ+6CIj3EpwNsseikYElv7I5YMlEb3ihreQKvIn0TRJhOz8Kg
         +k08wWRiItYCVno93ZzLZemDlzKM8lE8y4YPs1Ug+iHUBbkURfDlmLR+YuYDt8/eUXny
         yox7G+OpFNF9Jpw85e12wLBPAgzEM5Bqv4SZUkpwPVtjUkOve2zXoVFIM8NlD+gdYvm0
         naoATi7+VfJN5MksY4U0Y+iDav+hwVH4Uh8DyvB7UkBlk5Cd/NMFQfltnA9uij1BE9EI
         3aiTR3Gg1vB7FqnBMwgG+jUaUCJXQRbWp3KqkvHyHY4Pz8CCJpHViXvnsRiye05Qp9wV
         +vQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQmnITQDh9VtgoLUl/h7miM/CkKomVTr+jZNPD5M4uXjO9jC8KV5PX1Y2ep/popxTlfVL3Yo1G@vger.kernel.org
X-Gm-Message-State: AOJu0YxRL3R5WVmocYMWFX9qvz04T7tjcwZ9xZqJXEmqrEy1qUPG5fMu
	72vE+kVAV3WPKyurEzn3GuVKDDXc0bPNmHhYO00Lp5GICtVBETD5AWXGAkfShP8=
X-Gm-Gg: ASbGncvWMCcbvRiFYxHbUurNpdSG92neHXSUfz9GDY/lOaciIR1i2Xp3uGbJyVyt/yN
	7r6tVHy4kPoL3dH0dRcDFpdGioB0X3iLrCo9wkccB1Q9QSBnK/e52N5eES0Wl6Enu05y8Pcvxi1
	bsuFRuFbQH0fWlR68TYFlFmoiOJ40KnXwL9CcJm2OM9Z1rOFdBlhZaDyEKU+q8c2s12M7N1/BoH
	nN8F0VgeEdxcI+fYTbZptKTrjuIMYxHTysOIl0+eaOPb2kDGUgFsR7cxzYKCdtdIXrucqHbpGuh
	5Wq+D2ESqzBK5fBcAVY0JK1My5U=
X-Google-Smtp-Source: AGHT+IEMkiRLE303PY2VGK8dIbQqcHCo9kxRkhxSrS/G0HEqk/Ff0iwNgVtV9uMGa6/lqXwbklDsqg==
X-Received: by 2002:adf:cc8f:0:b0:38f:31fe:6d37 with SMTP id ffacd0b85a97d-38f33f4e465mr15485877f8f.44.1739971445945;
        Wed, 19 Feb 2025 05:24:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591570esm18080577f8f.59.2025.02.19.05.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:24:05 -0800 (PST)
Date: Wed, 19 Feb 2025 14:24:03 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@redhat.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: Re: [PULL] dmem cgroup
Message-ID: <Z7Xbc2vkFejhZSFS@phenom.ffwll.local>
References: <20250106-shaggy-solid-dogfish-e88ebc@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106-shaggy-solid-dogfish-e88ebc@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Jan 06, 2025 at 05:49:19PM +0100, Maxime Ripard wrote:
> Hi,
> 
> Here's a drm-next PR for the new "dmem" cgroup Maarten and I worked on.
> Given that it's only user for now is DRM, Tejun agreed to merge it
> through DRM.
> 
> This is based on the series sent by Maarten here:
> https://lore.kernel.org/all/20241204134410.1161769-1-dev@lankhorst.se/
> 
> The three last patches are not part of it, for different reasons:
> 
>   - patch 5: we haven't had the acks from the amdgpu maintainers
>   - patch 6: I didn't feel comfortable merging a patch defined as a "hack"
>   - patch 7: it's not clear yet how GEM is going to be supported, so we
>     need to have further discussion on this one.

Already discussed on irc, but I guess time to add a MAINTAINERS entry for
dmem so dri-devel gets cc'ed and we just managed it through drm-misc?
Tejun and cgroups folks overall will still get cc'ed, but it sounds like
this is the approach Tejun prefers?

Cheers, Sima

> 
> Thanks!
> Maxime
> 
> The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:
> 
>   Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git cgroup-dmem-drm
> 
> for you to fetch changes up to aa4f9d7f77836d5a48daaa99479c2603e9a548ed:
> 
>   drm/xe: Implement cgroup for vram (2025-01-06 17:25:36 +0100)
> 
> ----------------------------------------------------------------
> Maarten Lankhorst (3):
>       kernel/cgroup: Add "dmem" memory accounting cgroup
>       drm/ttm: Handle cgroup based eviction in TTM
>       drm/xe: Implement cgroup for vram
> 
> Maxime Ripard (1):
>       drm/drv: Add drmm managed registration helper for dmem cgroups.
> 
>  Documentation/admin-guide/cgroup-v2.rst          |  58 +-
>  Documentation/core-api/cgroup.rst                |   9 +
>  Documentation/core-api/index.rst                 |   1 +
>  Documentation/gpu/drm-compute.rst                |  54 ++
>  drivers/gpu/drm/drm_drv.c                        |  32 +
>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c          |  18 +-
>  drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   4 +-
>  drivers/gpu/drm/ttm/tests/ttm_resource_test.c    |   2 +-
>  drivers/gpu/drm/ttm/ttm_bo.c                     |  54 +-
>  drivers/gpu/drm/ttm/ttm_resource.c               |  23 +-
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c             |   8 +
>  include/drm/drm_drv.h                            |   5 +
>  include/drm/ttm/ttm_resource.h                   |  12 +-
>  include/linux/cgroup_dmem.h                      |  66 ++
>  include/linux/cgroup_subsys.h                    |   4 +
>  include/linux/page_counter.h                     |   2 +-
>  init/Kconfig                                     |  10 +
>  kernel/cgroup/Makefile                           |   1 +
>  kernel/cgroup/dmem.c                             | 861 +++++++++++++++++++++++
>  mm/page_counter.c                                |   4 +-
>  20 files changed, 1195 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/core-api/cgroup.rst
>  create mode 100644 Documentation/gpu/drm-compute.rst
>  create mode 100644 include/linux/cgroup_dmem.h
>  create mode 100644 kernel/cgroup/dmem.c



-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

