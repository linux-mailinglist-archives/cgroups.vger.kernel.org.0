Return-Path: <cgroups+bounces-6042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C41A00BEE
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00747A0802
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FD1FAC5A;
	Fri,  3 Jan 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QeGN5OqR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78E1FA8F2
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921126; cv=none; b=jhuTbQj7W1jh1PC0feJhVxoX8oCtmys9IzA279PFwhfV3FwU7CJecZki7yENYqYbbi/9fvkCmEcaE3mTv571d/uL8wPRCI1X7i5pzx8VhKwIQNYmdy/Pv8Q9LxJgnHdWcaPpf3qTH+BZFDYoXTefRA8YaCGaOmdPT16G4xI95Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921126; c=relaxed/simple;
	bh=mGl7IDmigx3zQggt1eavJUJ+CpeAtg+Kk/l2kAGJTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+vwrN7Q9riz694izafhNgvYqtMOMW/2eOeqop0t6uaUFqtbzbTHXeEszgm7T2pqhg2WGIQbpuKG2LTlu+Qog0eobGBQ9YqRU5FRCf1tstLuJVFYFeV2iObiB350z1p6KI0zFQp1ySWJUuU68xKNOvJUnXsp7N3dwuYVJUlRUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QeGN5OqR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4368a293339so87438925e9.3
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735921122; x=1736525922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGl7IDmigx3zQggt1eavJUJ+CpeAtg+Kk/l2kAGJTFc=;
        b=QeGN5OqR/5S0H0lhnje4iM5jnDdU+WZI6lZOU30G83x5TWiK6jQ5hmmO7o5Latml1w
         rcXgQwLV0D7zU30i/i82TTLo7V0ew3G+sjYnq4U6hwiz6XRifcL+MeFHVX8Be8ON/2nR
         WDAIh/9kWbIQZ6fQckWchzR/aDJM5tT9VM3zxjg/CBqLt5476V5S0knJfeXIo5Nc1u72
         P7FJ2sFQthLS2NqRKKXRLnqA7FXhffm3tEkbjwAqyiW7vcsu9GNzJKJjkbdx7ix7pzv1
         Jxb55FAbpYkXgjhVTJsKmt/CIvRZ6P99sLlrahDaQO2xg+GlW9jsk4VUpewaWekHwKfx
         NFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735921122; x=1736525922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGl7IDmigx3zQggt1eavJUJ+CpeAtg+Kk/l2kAGJTFc=;
        b=Va6G5QGSyHVXzM2pp6DV82gRdernKQ7U6hvyEDdOj2+HP7nW8Dm/dICpXwMkCRDJ0H
         vzSQWTqJLZEABnHoFGuUGHnv83GsGi+9iTdAuif8a3u+SjcOWVXpXuk1LIGFdAtyi+7s
         9hqzwrCFjQ9Hl0Qyx3SfIlGvoRwPaYVZsYS1qZOXiUzwYv80pcKQqwP66yH5j6uKglYp
         zPdCOZROYlwoxE/eW1Bt6I1nE3YlVGPx/tC0DdbeLsji1q6k7DEELI1wZfbhuZHxT+Yb
         bshfy7lBq6lWn5a8XnTJQyku36A6CGrCgKUdTz4a+59+/vaNG0BVasKI39qs7bQtH8+h
         r7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt3xiijZ/x36ZNgbaoU96HLuskMzOBtgyOvOp5QzDsAKd3LXfwv9yOfNr2Yb/uEHbVJsN8+zSz@vger.kernel.org
X-Gm-Message-State: AOJu0YzWt7lzWmvOVzTjOAgZbPjrkEInjPudVcqLiQy5jxSt+5YY3NIA
	Frf8a3fFjf1AQtr/tTgf2YMWu5bErY1CWwmaP5xMUnaWI4728VkjmPuhFg/SR5A=
X-Gm-Gg: ASbGncv3rNTBAa8W9ixqYlwGRuv2rbhqvSRh99qnwbRRAxnwx/IBvomrpNxykdWe91C
	/8YUAs31dDMTTX0D9/NJ3hu0xt1LARn4cM4N6rDdUaO1FBCwJhWdDTmbnnWavPxKKVLSwTCeMRf
	D2XLnOSuYd7ji6+if/hM+fg8Ce6aT4wyfy9DM/hIk6FnrdtMmF0GMuHyNNqbLYU8iZ0ipNMuTyK
	zjlTwAnENiLp5Y8H4DEa6T/IQ67sKsrfK/5zMm6cWhk+nFB0Bs2kaoyUYs=
X-Google-Smtp-Source: AGHT+IFZmx/yuSj7je3QvEfpEwHUC2Ub/Ijj9UXZaGazHtmp4gTMiO1ry5deD/sKAYCmTXX2fl2X3Q==
X-Received: by 2002:a05:600c:4509:b0:436:1971:2a4 with SMTP id 5b1f17b1804b1-4366864722emr457280065e9.17.1735921122307;
        Fri, 03 Jan 2025 08:18:42 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8289a0sm42135554f8f.7.2025.01.03.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:18:41 -0800 (PST)
Date: Fri, 3 Jan 2025 17:18:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, handai.szj@taobao.com, 
	rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <ilnyxm3qdk5ix75tfketinbhm6ubrkklrafbvmcwrsnjlgnh35@sjltlqp434fv>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rcupueyfrbzf4mc7"
Content-Disposition: inline
In-Reply-To: <20241224025238.3768787-1-chenridong@huaweicloud.com>


--rcupueyfrbzf4mc7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
MIME-Version: 1.0

Hello.

On Tue, Dec 24, 2024 at 02:52:38AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> A soft lockup issue was found in the product with about 56,000 tasks were
> in the OOM cgroup, it was traversing them when the soft lockup was
> triggered.

Why is this softlockup a problem?=20
It's lot of tasks afterall and possibly a slow console (given looking
for a victim among the comparable number didn't trigger it).

> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
> function per 1000 iterations. For global OOM, call
> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.

This only hides the issue. It could be similarly fixed by simply
decreasing loglevel=3D ;-)

cond_resched() in the memcg case may be OK but the arbitrary touch for
global situation may hide possibly useful troubleshooting information.
(Yeah, cond_resched() won't fit inside RCU section as in other global
task iterations.)

0.02=E2=82=AC,
Michal

--rcupueyfrbzf4mc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ3gN3QAKCRAt3Wney77B
Sa6zAQC54Sd7KuanLbmfLaGOXxG7G6FlPC6aPzF++JEaooFm7gEA8z9Hl5K+ruKY
SyVpErXNAh4+caqnmTT99iRdkx6hdAE=
=DTHm
-----END PGP SIGNATURE-----

--rcupueyfrbzf4mc7--

