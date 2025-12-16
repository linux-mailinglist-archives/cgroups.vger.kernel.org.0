Return-Path: <cgroups+bounces-12379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1FCC37D5
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 15:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24923068CFA
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D622FDE6;
	Tue, 16 Dec 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXjRiFKb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68F3A1E67
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893844; cv=none; b=a/mgbzm7R+S/Yp3D9rWF6fZxPHFPV+umW1T+lVfojvp1f2zgfiIkoGUIozOtOe3gzfcGuhGvMzhZRyk6kLq4sqWyny0sx0UqdRxeWdHrJrir3v/szzg9IfSHwUOtlcZSCHEBQj48BmT0k8iqG6yDjw+svo9OXDdlmdtWzUC63zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893844; c=relaxed/simple;
	bh=8wmmq5rICPsf+KC+ivW/7P9QRqR6QdMkhGWGI9qEIcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvtFG9fbjd8/1WW9dUAGzSSWqFBSGpQhaWzZeBAVGfprd0gTQQ2YEqUL1G6pAEYTuoPd5KzoLiP+4h9XO1A/DmPRZ76hpAycmT+sX9EQe3SUs4hFJLxoHUVVfo6fCD9N6sOga2U9d4ieqHRjQzdG673yU2Y1OqDMcqDSSBuR4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXjRiFKb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so1069771f8f.0
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765893841; x=1766498641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wmmq5rICPsf+KC+ivW/7P9QRqR6QdMkhGWGI9qEIcU=;
        b=IXjRiFKbNIulfM6cVeOypnvV5/DB1qG2WpBy7loPLUIOCK1K93spaj67ZCEJCjH004
         INQ8t2pAtjUy6GyEmyLlczH9tZbwbWZPdPLY0WMa6cCn52GaeFn4cczdEYZDjLIcuBAt
         aMtRqcusT2V3Ugu83XrzFU2bFRvwrW+tIsq47GoHquUu7LBMRjq0I+eMkMkoOjFHgQdb
         ZAgiS0nCyUv0NVIqUsXmkG/5JeyymMIHuTbSMy4PlIE3qJMFg/0faqZcHOZsD9b4fBi7
         x6q4hRNuull92VvWa3CTRhxTfpZ1N1ChBqShXtU8dIQrLW9jFmntN12j3nHg9wL/zOxq
         McGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765893841; x=1766498641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wmmq5rICPsf+KC+ivW/7P9QRqR6QdMkhGWGI9qEIcU=;
        b=luhl8JMCv2z6IvUuORXNFRKxYTSohSLLavLowK5zGow4eIrgLABl9rAc+mS/APTjl3
         RVMOGtNxeAAvbdN77ZcC1rC8wuOJ+X/WHPShru5kw8Hv1ECswUfYvBsHn/VTSqJef66m
         daghWK8q4ijlRAnXE7SsxOi/l9yuB9prWV5YHU9I3BKkK8BDrHg7gkylGv+uvjJjzED0
         9Pvk7yWtFGxdMAqZbzQMMnXaOALNYGqkwL4dOywB9WNEG3r+DL0OVlzjguX5aEyPQDpe
         0gpE0cMqV1PSpfBC9sTzsqXFZlOattSf+CmQOfJsseDmjp1ecz8NZRwLxoAW8cTnTnth
         87ww==
X-Forwarded-Encrypted: i=1; AJvYcCWB9eZcBQhLmAvYbIZJLWIDYNQ+Xf45+4/xdYoIZeT/C83aICNmIZTJhkeKfosBaIVZ/3n0Zptj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcvr5NUQA36Lis7D0actyO0IU64NIdbQXDuroARBy2oCqXUKcx
	qre0Opl7G3KuVRo8jpXzkgTTHqKq/EIQ8Yh9WHzcR6QLzN2+ptkOZH567w+kQ9L+ql23inkWl8V
	YEkxr
X-Gm-Gg: AY/fxX7cmPZmSvWV4Hp0VI3QeD9QnYtNLih3z12CdCmQvg+lTIlnfmKXK655gGoV1m8
	dz7P//+Sa6KJtEJZqPgp3nDABhqNZVru3dfpFWJw1bOPPzsrVT48LdRlh771ite6FMG0YeHHpP+
	RnP63WGj+tikrYYEy8iWiodySadFabTfktolkuNtCkln5Zb9q0ILIckDvM49Hglh3OiRD21KrN+
	tkf/YFOLv7atinXEQUxpUOPWnqE6uGgRm/dYfobCDnnbJoqxklNJVIGH9B5PeH4f8n2Q+BQhHMg
	xkIhBekLEvPs+3jvhJAtzgDsuV+oBsGZAQEc7KOu5vYaELiD37RJt/IwyfIuqzQd5VY/rMkJtZF
	bT9ZWhje6Kb9CHS66PDqO9BZiHsZCm1/S4kMsHhiPTc+mxp5Y0nIRXYhooT5DN9n9/++CnnT4uf
	w96L/UeQ++sTf6u6KtLm/+StLNTT34pcQDtW/hmk5Zvg==
X-Google-Smtp-Source: AGHT+IHIAULc/96DBBffzROjvpfWOLq16ZBFWeLw78obe5RogpfmsWvaGcQ/6KyEc6+RrigHPsuUnA==
X-Received: by 2002:a5d:5f43:0:b0:431:397:4c2b with SMTP id ffacd0b85a97d-43103974e7dmr3948864f8f.11.1765893840581;
        Tue, 16 Dec 2025 06:04:00 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm35810083f8f.0.2025.12.16.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:04:00 -0800 (PST)
Date: Tue, 16 Dec 2025 15:03:58 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
Message-ID: <vprpzrc6g4ad4m2pwj6j5xp3do7pd7djivhgeoutp6z2qmeq22@ttgkqpew7uo4>
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
 <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
 <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5s5bo3nzqutt6q2w"
Content-Disposition: inline
In-Reply-To: <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>


--5s5bo3nzqutt6q2w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
MIME-Version: 1.0

On Tue, Dec 16, 2025 at 08:13:53PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> Regarding the lock assertions: cpuset_mutex is defined in cpuset.c and is=
 not visible in
> cpuset-v1.c. Given that cpuset v1 is deprecated, would you prefer that we=
 add a helper to assert
> cpuset_mutex is locked? Is that worth?

It could be un-static'd and defined in cpuset-internal.h. (Hopefully, we
should not end up with random callers of the helper but it's IMO worth
it for docs and greater safety.)

> Should we guard with !cpuset_v2() or !is_in_v2mode()?
>=20
> In cgroup v1, if the cpuset is operating in v2 mode, are these flags stil=
l valid?

I have no experience with this transitional option so that made me look
at the docs and there we specify it only affects behaviors of CPU masks,
not the extra flags. So I wanted to suggest !cpuset_v2(), correct?

Thanks,
Michal

--5s5bo3nzqutt6q2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUFmzBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjkrgEAow27iwbiOnsHih8FRa3X
hA+fbgyYPH05D3yJl1CAexcA/0vYswztHrOxNdgoN82jkKTJqHOmXlFb31fa93uB
lt4J
=+Dbi
-----END PGP SIGNATURE-----

--5s5bo3nzqutt6q2w--

