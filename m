Return-Path: <cgroups+bounces-12260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0DCA47C8
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 17:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4FD3028FF7
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFC2D4816;
	Thu,  4 Dec 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EsES/a3R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AB296BBE
	for <cgroups@vger.kernel.org>; Thu,  4 Dec 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865428; cv=none; b=myhRqt9GZYnuFHWCg60PrOSfmNMCd2iEerpPAB6jllzywMC44VrmP1nwe5j0qwuQhK9/csCyaXGiPvbo+edDxNQt7aBH9xr8SczS72WNxKTGzcQVUYLrAAQSTQYUMYapotUW9rLMOYnMwtoGf5W740hTNCQBOp0rCzegml/gb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865428; c=relaxed/simple;
	bh=1GjpoTnVFzjq6x9x8bUV8qPtsRgUP+T8kcMfCrgZ/E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF0bC/23pULZltWA3rFZShJxAWvwTMeNDHxFV4FfD4us/vby4zbAko+27IHoDPBBbXe9DRA4bIL/eYnJ0d9M4R7n+YDLl1hdzS9ShKSiFCE9h8yzKT9B+NZbfqkQfyLD4k1mpBE1X2CPXkrp96F07gTLSUlOWFywE7Jh9FpZHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EsES/a3R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779d47be12so10760225e9.2
        for <cgroups@vger.kernel.org>; Thu, 04 Dec 2025 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764865424; x=1765470224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0djcKe+XMG2FSc1KgB5nDW2raQnLgYGOtnt/v+yYDk4=;
        b=EsES/a3RMj3MJnFwwFKKLAgi9Xfj4v1wVLUGaS9yyVoddtOIhN7RTzpyksHXFSNO2E
         8plSNkrM1VfWrc7ssCMNm0PmWavnnpBaVtNfVY8Z/7wR4H2ReUF46DAkbLlRHT+L3tCf
         3r/UNkthlzj7C1KyN4OXaOy0faTTZBIlbqlvpRlp3Msa+7jET/LRbNHoQo/Qe7eMvGzh
         hB5ymcLe/GVXoSJlDEhIfAWUrpOV5JTlg4//h37lfzCLsi2W2Pb/XCHbXQE3B86Dh0cv
         f1tJdnKTInnpPZk+mDlJnAsWrE+3/0suMNzTt1rRiJz7Y6PYxJ3N8AIRGFrg5RAWxFaN
         0aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865424; x=1765470224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0djcKe+XMG2FSc1KgB5nDW2raQnLgYGOtnt/v+yYDk4=;
        b=Tj5jnWFTob+gp4fH4Dmrh1WJbt/SMV/fDaMUsz8O6EApR1B+J3Kp4uOGrs0oixiDuO
         mJh4sjJt9pBapjZy75xzfj4e3VIPoaNnwEVwrJ4ZykoJU2DLXRy7tKK56ngxSY+9hhb3
         ojcPPcM8ln8YF3HKPDWwB9Yio35xZ5X2RqboBdy+N3Le4WKxvb1Oci6ujQvNAfJHXsM1
         XWLQFOIWX3GOxNr9C1sQHkd7wFt3A+m4QR6P6ht2+kYusHQ0o/QEAcshmTJIjTtuWSm7
         K2m5+A7HbhvawTlq3s+wa3pqZ+hCXjz3R29y3mcuPCHofyNW6hoclEbFH1s93RQ8z4LX
         +jjg==
X-Forwarded-Encrypted: i=1; AJvYcCVkN0ycJoLhndtX5mFJc1zcEH1hJaMeWRMvCVztNxnSh0EkBGC8vGBpz2b7hZs746/XOt6ph/V4@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmRHLtxQiUINBNLj0ee/j+6xoO0HkWPWb9fscAJoPD1uU8Dzb
	usBnS8OUOBEaC0shlH2sJdr1iO7kH9wOfBT3iicNaWlwEJRKcS/vp1osX5Dq/CSlrl4=
X-Gm-Gg: ASbGnct3Pjo9Bh+Z1+uDhml27B/kCV7msyqnov8ls+ap07gkTYZUedAHBvOsjRNOLXE
	/hCBxL9eVO8iybXPUE56KzS+/18jjlSxVOqt+2HPOc00/QCqpizZjCye5vh0O8PdgTpkS6PHkle
	wSsmPZZtqJn4Q6WMY0QEEnuPvJXLPlGcwOZvxEgCT4H4A+3TDpHqWi/iwsatzrsCxdD+ouKn3kF
	xuiTQT8B3yYCts/R8osVnVRsjnmNad4Ik/ElylbyLRv5UbYGcOPheC/W6S4sL/TRdhPIasH/0E/
	halt1+glA6ijAovRfFiVg8ic5ph+FmklrtjO3bLkLOR1MwBPDV44+WHZvGZrbA8qAZFzKEnymYS
	HvQnoMWgGk27tnZEJlzLQR1Ofy1S5JAnPU6g/kX3ADNg0bnm7WqxOcEi3ymL+DwFHNsVU1PB+kE
	DueqB4hkdLnXna6E8C1Pn+sOHjaanHw3M=
X-Google-Smtp-Source: AGHT+IFQwkb1Anz+WapakCJFim8AqZYDdaERIjM3D5sSp8rjfuHaKioVm8UQnTS/RlHRc7sSUSdOcg==
X-Received: by 2002:a05:600c:45c9:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-4792aeeb570mr73331715e9.10.1764865424349;
        Thu, 04 Dec 2025 08:23:44 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b05ce9bsm41095635e9.8.2025.12.04.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:23:43 -0800 (PST)
Date: Thu, 4 Dec 2025 17:23:42 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
Message-ID: <ybae7fgr2cszhu2g2gx6v2pgmovajsue5atvxha4dhpe7alco7@vq3jdgy2ksmu>
References: <20251126020825.1511671-1-chenridong@huaweicloud.com>
 <nz6urfhwkgigftrovogbwzeqnrsnrnslmxcvpere7bv2im4uho@mdfhkvmpret4>
 <e5b53c3a-563a-4af6-94e6-1ce4acc7b399@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d76e5fgmjnzoexjg"
Content-Disposition: inline
In-Reply-To: <e5b53c3a-563a-4af6-94e6-1ce4acc7b399@huaweicloud.com>


--d76e5fgmjnzoexjg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
MIME-Version: 1.0

On Tue, Dec 02, 2025 at 09:53:11PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> What do you think about this approach? If you have any suggestions for further improvement, I'd be
> happy to incorporate them.

Yes, it's better due to the single place of definition.
It made me to look around at some other filesystems from a random sample
(skewed towards ones with more options) and I see:
- many of them simply use the big switch/case in .parse_param,
- ext4 has its specialized ext4_mount_opts array whose order needn't
  match ext4_param_specs thanks to dynamic search.

All in all, I appreciate your effort, however, I'm not sure it's worth
to deviate from the custom of other FS implementations.

Michal

--d76e5fgmjnzoexjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTG1ixsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aja8wEA92KPOh8MxRwFAwpK9Dn4
E6Zs5kwMnRLIPJ02FGGysjUBAI+PE1AUiwQuFDn6Z9WRLhlIfV4Y4tfJx7RoKKXc
0dIJ
=1ETf
-----END PGP SIGNATURE-----

--d76e5fgmjnzoexjg--

