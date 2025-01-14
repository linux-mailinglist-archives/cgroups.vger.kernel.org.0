Return-Path: <cgroups+bounces-6137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F03A10B95
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1D1886A9B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F868165F13;
	Tue, 14 Jan 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NaBQ5ELX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BA15746B
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870321; cv=none; b=LlR58N9rr7UTHm0/+KTQ5TSfZg6KArEbkM4DIZyXjuMVUiG6YTy8c9daI4xp0+Jlcw+SaaWDnElDx7ygoXOEf4AZNAFGnJoo+fFU9nRFwsOoOEhUZePojWupU+l/htjPGQkoHc3TQEmUPiv4y7qbVSHb7F8jLD4glQofw3SacZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870321; c=relaxed/simple;
	bh=Jy053pveFc5vOQULkJgdhfgLtZi8bhMtaMMo61vm9vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr9Fsx7mmVeJrLI6uHQ9ZqnJhydBFapMfX9d3Wn2hVSD6DfjuVVNMmSpOaxYRASIOY3VR5vIlbkaPUleNTIpEf8EXjmRrWT1/exlZtTM+SvBUhgo0UOwGIWXCk65RuuJOLx+5Cgyn5VeT5X54BxeNjL2ixeLwkQEVcvMhiBRSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NaBQ5ELX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso40702005e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736870317; x=1737475117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy053pveFc5vOQULkJgdhfgLtZi8bhMtaMMo61vm9vk=;
        b=NaBQ5ELXKYHutk445huzePOtFlQoWerGRWySlWe+DXOsJPEkpJez3P+GoA2bKscJ+M
         FHrNeGgD38da4AAY0Y/VCG8ddKXd7x/gKFRS9CYjwQj78RdbV/4wGk7MDYX0EDtE9LXF
         00h8NykODenIjVjVsdOV5BEEqLesSI7ybQRC2/II+y6uJKcNkpywnHQ7kHehC/irZI2s
         goYAHUX5hVuYLnBA/7fo5we6GHl+xN0SguthvaLremJsCxuBDDqKDSFWRpghsCnheOuL
         G6fNq9T1snekcdILzt5jI3GZqfMDVk4npU7ybrW/sq5Xx9l6pvK8oplf4wCpi7EZiINv
         Je6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870317; x=1737475117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy053pveFc5vOQULkJgdhfgLtZi8bhMtaMMo61vm9vk=;
        b=U8+7s9Oyle5lHuKxQVT4++LGBYqT4QhJZ09azgcyp67k8B/Cuncd6B4+x5oPRIiL3q
         2X9fzsIA83jWDI4xueVJ1ZDPfb1bdtYiAqQA/UeTSTGNXCoK/xImNm1sCzp3aqv+emGA
         ippmtuEO/WJ7HpVJnDwfOLTPbLIQoY0LiZPVUQIjApAN9szXmvw+t4JA/tDtPtfEKAT6
         DNap0InOp71qqkkLjMy7n8SisUNntY1cziv/McIlefb6X/L01gab0NkBa/WScGBtipJR
         93XC9Nn0fktuAbMjwNi9+MV8vJxSQIFBhiBodlDwD9iWvu1CG9BqHtg/xOMYZWjBotSE
         j5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYvLzsT36tSnrwkAWhLHEd+VG6bS3PhANCl58pr/oHxmvXX2korQfSUjT+e5nedptiweOCFBG/@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJMj6jO90O3BcXiDyWZURQC9r96ekYSk0it3AHCB033AFWtaQ
	ikiMFbzZbNhiXUdxKFCgJU5rFA+pZuIePSI8JI5vLnTsd8oIE2eZbPnzodDRQeU=
X-Gm-Gg: ASbGnct6GyBTrcR28L0evOm2aw8zHZYTf8D9bXl8S6gK1D5p4dQvFrWimGFcfleqasv
	SeZcfInp/pbirXHYSCLa8j+Z5l8qB1Yk+421tV7k58BMVX3v+gF9yNDiouVakg1d6vstd/ioTki
	MrvhU/vKdPlZt0ZrBflbjKaLi1gaPyqtHhNwdMavXiSmt9BGbadxb25LYf3M91g91BsOwQySAgy
	9VsNnt/2P6D5rV+looj4E8FHdj9bi/cka3DuxahfuxiDw8qDRU2EQUHFmQ=
X-Google-Smtp-Source: AGHT+IGJhudVR8zz9A+ucF0FCTkf/6lu/MjcBn4kAg2gfn0Lg/cER2ZyrWmwTBO/3c4T29HM2nx7kw==
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id 5b1f17b1804b1-436e26a7578mr245284945e9.15.1736870317330;
        Tue, 14 Jan 2025 07:58:37 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37bd0sm177839635e9.26.2025.01.14.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:58:37 -0800 (PST)
Date: Tue, 14 Jan 2025 16:58:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
Message-ID: <ijjhmxsu5l7nvabyorzqxd5b5xml7eantom4wtgdwqeq7bmy73@cz7doxxi57ig>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibfckbdhvcclcywt"
Content-Disposition: inline
In-Reply-To: <20250114153912.278909-1-friedrich.vock@gmx.de>


--ibfckbdhvcclcywt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
MIME-Version: 1.0

On Tue, Jan 14, 2025 at 04:39:12PM +0100, Friedrich Vock <friedrich.vock@gmx.de> wrote:
> If the current css doesn't contain any pool that is a descendant of
> the "pool" (i.e. when found_descendant == false), then "pool" will
> point to some unrelated pool. If the current css has a child, we'll
> overwrite parent_pool with this unrelated pool on the next iteration.

Could this be verified with more idiomatic way with
cgroup_is_descendant()? (The predicate could be used between pools [1]
if they pin respective cgroups).

Thanks,
Michal

[1] https://lore.kernel.org/all/uj6railxyazpu6ocl2ygo6lw4lavbsgg26oq57pxxqe5uzxw42@fhnqvq3tia6n/

--ibfckbdhvcclcywt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4aJqAAKCRAt3Wney77B
SQc5AQDnhZPEDQ5xOwuloCpkFjE7OGy9XDVbMoEBwHiqAgMD4gD3V6Q/12Rtz2RP
isY6dnqfsRxL6wDbK6TxQjf2z7GpAA==
=Erot
-----END PGP SIGNATURE-----

--ibfckbdhvcclcywt--

