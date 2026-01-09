Return-Path: <cgroups+bounces-13015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27055D0AB65
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 15:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A84C306DA95
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6303612F7;
	Fri,  9 Jan 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="byYqCuHc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24163612E9
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969880; cv=none; b=m6OowG2gpGN/bBbweAhyAsyKyIQ7+M16yToNRO4K9IF7P8dZsTGEzxBGlEtMneUp8HwHDdEudwsTBeIkRT1cC6hAqFWobOytVuX6N4jtVFD0CDyO4CMapNm7sb0W8yJkAcMyxY+DIY1kh5U5RWrcrej0O7KB0iue2+dDD3ND7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969880; c=relaxed/simple;
	bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF+jhr9rC0CK/s0otAtIo8uzHS3vuzcSBohDHSNp/+pbj2GnFfR2Wan1sJWYuReHJYcBZrRI6WCbueOu0VjsnCqM45n9UF7ZbiYzrV5GpH3Pm+j1QmO0eG7qCzj5mLkXeKJ6q62SRcklmwV0Fnl5Nls4+JPGNp6LLteb1lsLwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=byYqCuHc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so15059585e9.0
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767969877; x=1768574677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
        b=byYqCuHc2gGCdX631PDgnpi+b/A1HSPGUy6zLWlxomwuu8vi1koDw4ecHqwnrYv2Vk
         PDoSsSjg/Y/1o3itkhfH/fiMspLBm98rPJ5CdpDxfNI5dMkJm83qQhWXrbpS4pyMYMNk
         fhb/REApmd1h7f6YJduY/poyGiICcJSaGZsKRV0JGgElW4Y7Yz9N1qX2uhpSRLsu/szm
         8IUdORu19hdSyL7/dxjxnXOSl7i7Md98FsS2km7RFVY8/tyT3pqJJp/LDbJh3HUL7NlV
         znj4g/oPh9HB+ocZ3Dx+K2QekL5k37OFQK5BJld6vif+HeKZdjwxKCwkGgYbvd4EaXYT
         XGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969877; x=1768574677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
        b=EvY/UK36vLMRGCD+eChVn30GKbGkFobVKQrR6j3ds5+Y1HHSyETJEtHsHcHK91z391
         CLsoV3ZfOCDoJnrjz57hesExF1dPLNTHEr+HObbjKDkMstdlmxz6Pz+DqeBCWbPtFwoG
         NhxLS/vxhQq41EiadTgchYAHIxlRKuJ13tRJGfFkwipzsqCg2z5n9KzaApsEHnzrQYL5
         YkI+lZD/TS/2bmhQjfumHW5XschVgDEdCqqARjVNGSXWRsOQs0nbksBFiA3JoQDvNfUA
         d+0ZO17NmQTgtu/66hWStv1JXOdkPqpKfXOBk8OPqpm4yR7dAcYZJuGhkXljr5ewNBBX
         Ra/w==
X-Forwarded-Encrypted: i=1; AJvYcCWJgrU7rmYJMXF4LTQn4+a96exRUDGrbSdANWg1gMWX7pNZGXtAAcMppWFhT/7Sw9gEhoO5fSKY@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcAgsWRVtbW8teUAQxMytxKCr1QNLjtJqm3yxIblcPsSLug2e
	fQon+2rdWhjkjNyuh83TGzqnM9Pw1wFVJFZx0+bJTlwWSdLpkuW4SNNDdvGkFSegp+A=
X-Gm-Gg: AY/fxX7SfSrYzhfQW6dHMfzpEZCyUqoDxyTY8//s1g3AZsCEsAgZ/1RLs7X7ad4q/V+
	bFWjhRZ5/+qXYVHJ7HTpcvTv29hcSHlLVKYFIr42R+8KWDrix3mmPWElyOYIdk8XWEHFQH5qH+L
	ndNXE1vsVWeE4HpQej365Ka6nCbJy8J4tqOnJaUYdjyxJ8yHl0sGggVvF6qmsNT7xGD6Iz+kmCL
	DBpIMQ0sPqZMxUDeNJ/ZFEMAQqdRDw6fz5lOF5w+LH7mk6qBaKE7OCJZbVgTuIwqYu22C95XbXV
	2yygVskwhhS1ZtDw+KdMUVWAFVZztB9jck8bGXIMfwAzqcML3epWqjsWAJB1DtUtzYYMr1u2KGX
	2q+10PZnMyrIE9/q3HY1tIRuR+J6BEsefzaOr+2HRD+rvXg2+AsRM79PYRlYND46BC4Ga07N5Rg
	mkgWzTnrbkhSJK46oQuVvT2Rt4/HkhWyw=
X-Google-Smtp-Source: AGHT+IH8FOAwnYy4OZuYKVuTUkzsl5zvNMupDK3PWM4j2did/Ahw9oYwLrTudoKw4NQ1y1JmyWkZcA==
X-Received: by 2002:a05:600c:3541:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d848787e3mr128657395e9.14.1767969877156;
        Fri, 09 Jan 2026 06:44:37 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm22648070f8f.31.2026.01.09.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:44:36 -0800 (PST)
Date: Fri, 9 Jan 2026 15:44:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
Message-ID: <heoizkdewdbvczav4xa4fylnkbswb7sjybt5naw7jlafbzmvin@tctcbn5oxqmb>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywuwths76adpwenh"
Content-Disposition: inline
In-Reply-To: <20260108014416.3656493-2-zhengqixing@huaweicloud.com>


--ywuwths76adpwenh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
MIME-Version: 1.0

Hi Qixing.

On Thu, Jan 08, 2026 at 09:44:14AM +0800, Zheng Qixing <zhengqixing@huaweic=
loud.com> wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
>=20
> Move the teardown sequence which offlines and frees per-policy
> blkg_policy_data (pd) into a helper for readability.
>=20
> No functional change intended.

This rework isn't so big, so I'd leave it upon your discretion but
consider please moving this patch towards the end of the series.
(Generally, eases backports of such fixes.)

Thanks,
Michal

--ywuwths76adpwenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWEUShsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiA0wEApu7S3lwu4BFXk2atN0ZG
Rj9eEkFVhXMjypkS3w+UiE8A/2euYms6kN4Br0fW1U7H1n/OS2G9qKo1fkYEd7DB
2BQD
=Dv65
-----END PGP SIGNATURE-----

--ywuwths76adpwenh--

