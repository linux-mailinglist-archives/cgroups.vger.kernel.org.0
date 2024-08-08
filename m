Return-Path: <cgroups+bounces-4174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411C94C3D4
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C29282D59
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0F1917D9;
	Thu,  8 Aug 2024 17:38:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7A190470;
	Thu,  8 Aug 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138704; cv=none; b=iGCIjlpt2qA4+60Eh1WIGxY2IpgHwlDuauapw5MP+4rtccSVcOA/KqBYdzA62aOsg1dAgVK90nqZ2lsHYFdmqTOpUu9mvhvWq4KQZEdyJ85DTbDTpk+5b3q8aEu2hGTFglLGuFSoyl4qDV4JwLi5gaBg84GYP0Fdc93eD/m/U94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138704; c=relaxed/simple;
	bh=pAr7DXImQlP366n+SlKe0A7CyDQY+GO6hKQByYK7bJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzLlWrFSzTTXd14OsUkt0FstoOuBaezWn3++nUm+Hcb+5myFC5JXe/xDudkpf7297c6tOaioY3bPkLyGUrfuFRSfEjByqrVHofdXD4dTxpL1+ya7gyD7zeDnYYbbqFuH/ngk5IqZGNPAoU9FFwQ3axLED5jbI0EyjUIyYeM0a4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3dab336717fso850034b6e.0;
        Thu, 08 Aug 2024 10:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138701; x=1723743501;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAr7DXImQlP366n+SlKe0A7CyDQY+GO6hKQByYK7bJY=;
        b=LzrsIeZtcUwej93JK8qj7zZDlexIIJsHfzCfleEmuYCa/crWWHsVhaZGMCBLKj4Pjf
         1rLqpzfVxC6iCrAsyDyui5PEq5XmGNlknfKkYED6n0TtXZcGWtgFEIQEtuF68Y8qRQAb
         Ku/Ld+xbBZCmAGNtFnCm/66qr9jFkAvRDdkd1h3PjnKa11SoFRh1NeoUGRuyaRK/XHcK
         8H1JWWsTPhnaFd8s1P8vaMdARFhR7vofaj+6ZEt3/nTLJqz0XhI9efaoO455VpLsHmqy
         kongcWXxb16KVO9TP8IU0oAMtwym3jfL7a4c3SdzrBz3JWoAbqsEDdTtKJ4Jz+mwe7Yl
         /fdg==
X-Forwarded-Encrypted: i=1; AJvYcCV+wTQTwOLRZYzd9xZHjID/PJ1SHWpqfrENxbG17WVZnFeEpdczQyqpuK4kuJ0UVMlq7gc7uzuy1/1MgwZ4@vger.kernel.org, AJvYcCXDU4FCZsgb0Izq+H9dtl1AgTiWYOBP5QxH6BIeSxD+TG3ODPoKGynRDyhla2o21fArijSz9OiR@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXxIBHJGhTRB+RoOTA8n4XpdAKTaBYWb75VHmgA/yGeJbYJiB
	l5UumIBmpROc0ssQQ4fs2ThSDqEpqdsYqYeT/ATbfRTae0ncJuU8
X-Google-Smtp-Source: AGHT+IGVvCfkYpaOMqeZeuNMPnt975m+WWRITIkQi4Ej7HVSn6d1Hnn4z5jdUcnYvn6bJAncutZ8Lg==
X-Received: by 2002:a05:6808:13d1:b0:3db:24a5:c5e2 with SMTP id 5614622812f47-3dc3b459704mr2877603b6e.45.1723138701465;
        Thu, 08 Aug 2024 10:38:21 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87da6f7sm14856351cf.70.2024.08.08.10.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:38:20 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:38:18 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, cgroups@vger.kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched: Make cpu_shares_read_u64() use tg_weight()
Message-ID: <20240808173818.GC6223@maniforge>
References: <20240808002550.731248-1-tj@kernel.org>
 <20240808002550.731248-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LsyBMcNvJid2tREC"
Content-Disposition: inline
In-Reply-To: <20240808002550.731248-5-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--LsyBMcNvJid2tREC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 02:25:26PM -1000, Tejun Heo wrote:
> Move tg_weight() upward and make cpu_shares_read_u64() use it too. This
> makes the weight retrieval shared between cgroup v1 and v2 paths and will=
 be
> used to implement cgroup support for sched_ext.
>=20
> No functional changes.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--LsyBMcNvJid2tREC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrUCigAKCRBZ5LhpZcTz
ZDB7AP9RJTRwzXtZA26u4xqDLK+vVEUP6Y6jGRrqBj7OTBHewwD9FzKx8Ee/GaRO
n8L1g8dN7qsM8mQZCuLXqZacIsuOkgI=
=EAZS
-----END PGP SIGNATURE-----

--LsyBMcNvJid2tREC--

