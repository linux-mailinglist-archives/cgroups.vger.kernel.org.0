Return-Path: <cgroups+bounces-6058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91116A02E35
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDE164CE9
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AF1990C7;
	Mon,  6 Jan 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bikjy1EL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10873176
	for <cgroups@vger.kernel.org>; Mon,  6 Jan 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182167; cv=none; b=WonvbfkafpZdnXL95MRq1tDcQ2Wzsykx5VUbprbpWggJmri7Rn2LsnNrcCI6p/EshkpfK7omhQCld+66fkA/LXRvK1B8tOo4Z5TSbTKHdWSgxblPq15x4BvKC31BlgsR7OCSsmWXbiUEsD2pt+WBwRrBL3G+8SWK0GFo+F2wTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182167; c=relaxed/simple;
	bh=secG/XT8Jt266PWDPPAKaRXDuOCjJlKOlKyHHcszmxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBL77PQ1vjXC+f1fOP+eGLt1Uqb0a+WXmSABThMR8pNe2PS+s1HpExR82/NtlcZW1h3RtcAzmm1DpOR9hGEtanSR0yiHTCO+oDcoYD0dC3xoXqIfUoVBRIDoElZGVDmvH5utDUo0GP/m2+StsUFTsQgp/NalnWFW/tbhYqR4+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bikjy1EL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736182165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wc+S5am7KzrFLfEBnVdPYV5YpHUWiDElU/++lQC/xPE=;
	b=Bikjy1ELSBSjPkB0o8hsyo6Bd1jdcnJTA4hROkdjbpk9PBeF/fvSAQkEybafGr5Cf+zhbM
	NzJ0GwjHSnOkro8MH3FwqY2KkLDHDWo4k7BtcqY9t//jSx5nFd++TR3gADc06HzLbBXbat
	pBsgQh0/jwGg4GEWhaDh9IM91zSq+xE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-8ekQsPIyP--94I2qT8MoFA-1; Mon, 06 Jan 2025 11:49:22 -0500
X-MC-Unique: 8ekQsPIyP--94I2qT8MoFA-1
X-Mimecast-MFC-AGG-ID: 8ekQsPIyP--94I2qT8MoFA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43626224274so42739595e9.0
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2025 08:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736182161; x=1736786961;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc+S5am7KzrFLfEBnVdPYV5YpHUWiDElU/++lQC/xPE=;
        b=wde3JnH9/q4b0AVpreghYcVYGapyje1WXORxfwUwFfCfBRvJrT0ElBL9o9lVG0hH9Z
         ozaNAFW458JJrVFbNRx6X2VeJ+AuBim4278qphTtCd7Z3R3jh87sFfKp2BVPKcsjz/r8
         MokwQ8rO7h79mqmkoAZ2OeqO3mOi+Pfnq9pSPZWGmi6827hJEQ2aShgJ/l3k4aD42b1U
         /KjhCXG0rcEAzJUclmBOggy7/Jb4kHeNlaNgcdz0gsQUM00HVylpZe6M60ZSjROyohxG
         nWe5tLWETFXfblnMb6puGxbqG9p4ThYauf0Y1bC7CB1tQBHSBOgQupV6LyUiG/gn0cJD
         iHYA==
X-Forwarded-Encrypted: i=1; AJvYcCWbVtYh1xuiJOd970hCPbZD8woUiXLd4QbrnAk3ltFmLVzTzdZRm9wDkmKtcyPZYp1xFPvBq86j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+e7y4egRfMOQ45UaFHNHyP/otuvTkFtFy2ZGhsWKWfbrDYlU
	0LBpo8J0i1/rhTi2q4zKohCYYR3Tmf9kduBTT69FiNmFhM2djtXmkjrvCHioL0QQGNm1ah3gTSW
	SOEQ0HiVsYGm+80ybxeGc6LM5pp220AGIpuXelNiYBdeTFqOrrJtrAYI8I5yp+/IozIct
X-Gm-Gg: ASbGncvmukLuopEoRM38znfgxQnNclnKv74sgz/+0ghmO4Xqd9dZQRofx5vsNMn2PSY
	rgLhG+hsIByNKEdIo4W+/4QTD3OAuOczrtIk8Y5DSUBjR1nN8wHovRmmRhLJi7c5hGP0otb+kk5
	CVDCiVTgZKprXfAQPd71us/RGtcE+xBrJe9bSxH5Ir2Y9HobHgYUggSfHC8RsYzNrYGdNtEG+kX
	Su4Tna/pOZQamwfB3EA1WscC2kbAUx9
X-Received: by 2002:a05:600c:35c9:b0:434:f5c0:328d with SMTP id 5b1f17b1804b1-43668b4999fmr442374285e9.23.1736182161132;
        Mon, 06 Jan 2025 08:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRcVmympLgSyeUS/JQoWsfW/886KWuwB6W1I7v6jo2dza+QtA+NFpor8TnqCp06dzsM2FbrQ==
X-Received: by 2002:a05:600c:35c9:b0:434:f5c0:328d with SMTP id 5b1f17b1804b1-43668b4999fmr442374055e9.23.1736182160665;
        Mon, 06 Jan 2025 08:49:20 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013a1sm610927275e9.11.2025.01.06.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:49:20 -0800 (PST)
Date: Mon, 6 Jan 2025 17:49:19 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, 
	David Airlie <airlied@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Subject: [PULL] dmem cgroup
Message-ID: <20250106-shaggy-solid-dogfish-e88ebc@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yhsrcqc5j7lsvcd3"
Content-Disposition: inline


--yhsrcqc5j7lsvcd3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] dmem cgroup
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

Thanks!
Maxime

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git cgroup-dmem-drm

for you to fetch changes up to aa4f9d7f77836d5a48daaa99479c2603e9a548ed:

  drm/xe: Implement cgroup for vram (2025-01-06 17:25:36 +0100)

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
 drivers/gpu/drm/ttm/ttm_bo.c                     |  54 +-
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
 20 files changed, 1195 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/core-api/cgroup.rst
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_dmem.h
 create mode 100644 kernel/cgroup/dmem.c

--yhsrcqc5j7lsvcd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ3wJjwAKCRAnX84Zoj2+
djBtAX9PBF98qdb1juGmXkvROcKeUvdTHoMwDdk7JvbEv1xL2gS7fA1WI2BRKjN+
IlMoQlsBgJ1LyOIweLBzhnuTyzDfekwIC+kFFSAAKZsPI1VY8KgD85K9ep8dMhsn
WSHsq+Qlcw==
=ey+d
-----END PGP SIGNATURE-----

--yhsrcqc5j7lsvcd3--


