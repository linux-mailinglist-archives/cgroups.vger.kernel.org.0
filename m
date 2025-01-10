Return-Path: <cgroups+bounces-6083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C030A08ADC
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C947A3125
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BBB206F04;
	Fri, 10 Jan 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM2CRfJ/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36619AD8D
	for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736499776; cv=none; b=WjQFmRwx6//jLms9bPUPHkd8Qt6Oe2IGSPV93pko+fxlhPsZp4ZXL3PQl/qY8eKhOgdcFMVysMBDk4fTJO8WiNROQaUDmcrhnQxv5JH58kNnSD5OEFiiuLJPfoEAG4uWiSuyILJVTwjc7zmm+MrTeGvhJjB5xFTB0WHiwuzCeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736499776; c=relaxed/simple;
	bh=AD//XGJ0/HAC1KGLiAFVILPRmeBSx8qiHQCDQ5HvV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dvK+UFTSz6cnb1ZaONC7VaGEWSobwqiFOq338f7key2kNEV2kKChEfpPseia83Qr6yYjjmzQODS0kwHoL6Me/ygV4+4WlKx9f2/iizEVMnfvrM7waiB+03ydZOvMKuwk3Wire+w4YlNzEaPLcpcQu9UzQ1urIG1Jm0299VbYzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM2CRfJ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736499771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4WOJ3w75jtY5Q6TYGw/iqmA+q/AkMXTEBxiFCrQsJ1M=;
	b=XM2CRfJ/8JZtQp5YgAjz8/w99MJPtKdNxdr+P3WrfzraSoQyQwpvu/lSe0EPGHJBl8kcej
	uWGmCb4HDWmp26+jx2XHRjwrPjCMJ46v+IClPuVUpYwHlj7bTzhKvrzHYX2yoetMQQOYFK
	CrlYkDz0tcr++GhCtS3GS6iiWtZvPjI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ANn3_iBaPoSzhoxCiMJkvA-1; Fri, 10 Jan 2025 04:02:48 -0500
X-MC-Unique: ANn3_iBaPoSzhoxCiMJkvA-1
X-Mimecast-MFC-AGG-ID: ANn3_iBaPoSzhoxCiMJkvA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so14684395e9.0
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 01:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736499766; x=1737104566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WOJ3w75jtY5Q6TYGw/iqmA+q/AkMXTEBxiFCrQsJ1M=;
        b=VVepAem+Jhv8Oa01OfGMWJXARLwW+VFb94Cj+oB6WkM7LryEvY7cFDlV1A5gtMEQ3A
         tD9Cj11lEhWxWr++sSLlhwFhXSYqYtA7Muwvi/HOuYLBTT1YSLjHgZq22R/JP/7fEXK0
         ITTQbijCrXcK6Yo92RDYF3cZuhwELgFZ02MFx5vNznSWm4mchmRjw8chLQtmajuFgsQO
         cyZhnCrr/oh5h/tBwUiRu9Jx1RbzqrjiC5ONjA5tp0m0bJp6jnrPQwVfoIZi8rBgAp95
         ehumAhSs0P4tHspuH+UvJgA0Dz/+6Ot6aiORvHwfUif08206i9SoQTYAm1qYnmXPT53y
         mO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRQ4gqeF0W/PvlS7E02NsgIpcn2tYYUj5FXWoVvTeqQcdea5ek3HY3NWpCmzFhXSX5ge9AbTfx@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWG3S7haPFdL2aIiHJw4P3/4LydVGS6l4hGJzrhKOAaG1YpFY
	+8aft3sspbQuNeiwjnLOdwHafzKdm6aKrs4NzRiSPt1htp+3OXxHPvOl7AMssY4LQhNHJ1RLDBB
	HltEIZg9C+HuqT5QZt/S2HR9JM9l6ypy/kfD1VIHvPNnWFKo2vGZ3CAE=
X-Gm-Gg: ASbGncseKwEvFhQya6bSgtFHremva9ODXDy25T4Z7jPr5fkpE/zKilclQ6JGhbtPmTX
	CP0eOmMvlXKcCyuSFOGpROuOo+bhD9839fGgKuXWpPHKK2qE6pduAblg5zDi+OiZNlW+VhOckpl
	wp5f+nTiC4/r15lVyvxD3u+h2Jyl8IsgkvQnOa05vf9oJDTCLJmG1MVJKr3z0dUoePtS21WLFnL
	6A8QHx3ToNoutWi8mGoKEIrtBd75e9v
X-Received: by 2002:a05:600c:a07:b0:434:a815:2b57 with SMTP id 5b1f17b1804b1-436e27082e1mr87034535e9.20.1736499766376;
        Fri, 10 Jan 2025 01:02:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2FpLNTlrXyxku0NvMBalD8uzV6r0w5RKPxtBo9lxq1ygqDJg58aVsONODuy+3Q6te4eRsmw==
X-Received: by 2002:a05:600c:a07:b0:434:a815:2b57 with SMTP id 5b1f17b1804b1-436e27082e1mr87034195e9.20.1736499765925;
        Fri, 10 Jan 2025 01:02:45 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm81245515e9.24.2025.01.10.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:02:45 -0800 (PST)
Date: Fri, 10 Jan 2025 10:02:44 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, 
	David Airlie <airlied@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Subject: [PULL] dmem cgroup, v2
Message-ID: <20250110-cryptic-warm-mandrill-b71f5d@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3fa2kwnpd5jjbtlo"
Content-Disposition: inline


--3fa2kwnpd5jjbtlo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] dmem cgroup, v2
MIME-Version: 1.0

Hi,

Here's a drm-next PR for the new "dmem" cgroup Maarten and I worked on.
Given that it's only user for now is DRM, Tejun agreed to merge it
through DRM.

This is based on the series sent by Maarten here:
https://lore.kernel.org/all/20241204134410.1161769-1-dev@lankhorst.se/

The three last patches are not part of it, for different reasons:

  - patch 5: we haven't had the acks from the amdgpu maintainers
  - patch 6: I didn't feel comfortable merging a patch defined as a "hack"
  - patch 7: it's not clear yet how GEM is going to be supported, so we
    need to have further discussion on this one.

This new version was asked by Dave to fix a warning introduced by an
uninitialized variable, which has been addressed.

Thanks!
Maxime

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/cgroup-dmem-drm-v2

for you to fetch changes up to dfe6aa163c3b3780add4392d93b686b399ceb591:

  drm/xe: Implement cgroup for vram (2025-01-10 09:54:50 +0100)

----------------------------------------------------------------
DMEM cgroup pull request

This introduces a new cgroup controller to limit the device memory.
Notable users would be DRM, dma-buf heaps, or v4l2.

This pull request is based on the series developped by Maarten
Lankhorst, Friedrich Vock, and I:
https://lore.kernel.org/all/20241204134410.1161769-1-dev@lankhorst.se/

----------------------------------------------------------------
Maarten Lankhorst (3):
      kernel/cgroup: Add "dmem" memory accounting cgroup
      drm/ttm: Handle cgroup based eviction in TTM
      drm/xe: Implement cgroup for vram

Maxime Ripard (1):
      drm/drv: Add drmm managed registration helper for dmem cgroups.

 Documentation/admin-guide/cgroup-v2.rst          |  58 +-
 Documentation/core-api/cgroup.rst                |   9 +
 Documentation/core-api/index.rst                 |   1 +
 Documentation/gpu/drm-compute.rst                |  54 ++
 drivers/gpu/drm/drm_drv.c                        |  32 +
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c          |  18 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c    |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                     |  52 +-
 drivers/gpu/drm/ttm/ttm_resource.c               |  23 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c             |   8 +
 include/drm/drm_drv.h                            |   5 +
 include/drm/ttm/ttm_resource.h                   |  12 +-
 include/linux/cgroup_dmem.h                      |  66 ++
 include/linux/cgroup_subsys.h                    |   4 +
 include/linux/page_counter.h                     |   2 +-
 init/Kconfig                                     |  10 +
 kernel/cgroup/Makefile                           |   1 +
 kernel/cgroup/dmem.c                             | 861 +++++++++++++++++++++++
 mm/page_counter.c                                |   4 +-
 20 files changed, 1194 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/core-api/cgroup.rst
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_dmem.h
 create mode 100644 kernel/cgroup/dmem.c

--3fa2kwnpd5jjbtlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ4DiNAAKCRAnX84Zoj2+
dtsTAYDPJhsY75AuDCrZSIfvGZ1VCyYlrWWSmdkoVatZwPxh47MzdmvoR9Pq7Gvd
F2w4MToBfitymaCigHlfK7D/5lDvKdgkb/4MZIMmxNut7zKY5CszyBfKcC2+sTVR
mdDOn/BldQ==
=wX7Z
-----END PGP SIGNATURE-----

--3fa2kwnpd5jjbtlo--


