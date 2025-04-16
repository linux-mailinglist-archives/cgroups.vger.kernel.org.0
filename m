Return-Path: <cgroups+bounces-7594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C74A8B552
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134733BD1EA
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F239235355;
	Wed, 16 Apr 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fapwU1Ms"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69126146D65
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795752; cv=none; b=OtY/TBDs/wwt3lDcD7DoCnsJLD3YZn480k8dMtoA2j428f4bDw4FlPWDNcmC8mhAxZAsOiVQhYysF1vBw6bUgcnwj7pXvsjpZmOThTh134x9aWoaQCtuJCC5e9UU4/bXHBGX0w0EjFgvhpFW56L8z+YJufx2hIORdTbDMfpSyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795752; c=relaxed/simple;
	bh=o55GeMY7B+wVncPex3pi9DLfKpWbxRoRoFGIzfLKFO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA1rGfsn5Qk1Eys32nfPcaCEyDdth71Al5xlHOe+nLcP384aA7CIeAsu6I0afHZE9rWecNZVLmaNkAdkYajTfI0zJGdII8WzYPhuzwk+p2tzPXdfMAovMxRAOpCrQeQiFeTiUhOe1Us1TaKnL5URW3Gyj0+SS7sGHSckxbvuJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fapwU1Ms; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5685693f8f.0
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744795749; x=1745400549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwFMU/CIUfhwkOB23SUiFhp0ktZpZfT3Pn6auhe4gJE=;
        b=fapwU1MsfAEEj81+R76jC2w20mJDlmkAzf4VracvO5A+yRBGJYB6pSH9HH+Wgh7js8
         mjE7D6fzn2nqyR5DCJu+cVFDsE2fGMYEgTZ4P3lm44oXh+5hxESq/MYvU4k8WZ5MV/jI
         mzt3hFxOeQvSI7ZxDjqHMGhwDt0XnZ9+A55LWrizZMvE+fa1w7+IdWQrJwO0azZ1eX/L
         plvR9i0tK7+x62sqFgMDbZB+0T2jRSCuIYOpyuEh0OLAhO5r8il5DKA30ud8sUocn0wj
         PpbEbQISOGBs7cs329UGOtn3qMnPtPfSNnZ1RkEqF5N2SsqVoA6JXEoL+7qeWAPcx/QE
         aHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795749; x=1745400549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwFMU/CIUfhwkOB23SUiFhp0ktZpZfT3Pn6auhe4gJE=;
        b=sqfGfr3IMW7kRcTSo0P0fqHf7Q8JoT6JvatEI7HFBX1YrQAaZ6FdpCWeac5kl/oPtB
         JDRiIEWBIsw7Z6kvEcYCrsdVvOGsbpev0Zlp1v9CQVkHT4+C34W7Q5fKtEwGbHK0Cj5v
         +MtKouYdLLQ4h3BpT+VqZ+ohph1pRg/thzSz+K6kXSKzd33swtvJqf4w9CUcSanZ85gM
         MkgMDd0VnJz/YQP9LwXze06fM2w3oKtgJ7ACTnq1I8ix6ZsFDPlAB6souKuFsMcNfert
         ao6wQKQJlaEcVc/7iFgWt7obYAzN8IYYQ8oL6xaQ7q+srPsfa+KaSXaTfwjSUX/YqV2H
         8NRA==
X-Forwarded-Encrypted: i=1; AJvYcCWnNcl9Dp7Mrfz1DraMOxgVes5O8GhiCnEZXgBh/62VnKmJX0R3MYZmF4HzwDN0QdjRIKpaoGwz@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGImPAfYw7nrNyXz8DSRTyEOQpQ7bGe9Y2qJG9lAm4bdJDzs2
	o/AOMVrEvm8P/lpbWLYii89qvCU+rmulpbqeemXstlEA9q7/84qCBcY/lKSaUVs=
X-Gm-Gg: ASbGnctbo51ZEzuBhKdHY+9rWASRg8E4PABEVk+Jk0JcT6k2IbWWcVWxG8vBi0fDFZK
	PAlgkBiMe5PIMm3UGn+F2IzpWjvoeQUu+TnJFI5j9X6thJncFreAe2qC9xolX/+cUe0RmdfGRQ0
	VaOBzlGu6pwT5PUM76Jettdjx0WUYH7Phtg9zGy5FO8Fyy3VPYwp8SVLxUyHq0n93NakBqpmMMk
	7/mdIvxsR10FTjiHN3pJmMmugb7aq4KKPVpKVcB5o4jtqVdF1OIUTdshFDcIRif+IKWScweQmkd
	+QPHLpVd0WsVL3sbs5cxwI3FDHfb72KpI9HsvUQnQN0=
X-Google-Smtp-Source: AGHT+IHG24BI/s6GMoLVsPWuWiDfurxtiJ9IfZU2cz4E6a4f9Ru2A7MtNJxcyIrDsYjvapIyQSdlpg==
X-Received: by 2002:a5d:47ab:0:b0:391:4889:5045 with SMTP id ffacd0b85a97d-39ee5b8b916mr1140442f8f.36.1744795748587;
        Wed, 16 Apr 2025 02:29:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445315sm16542282f8f.82.2025.04.16.02.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:29:08 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:29:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
Message-ID: <575w7vjlpcvh4yfyvmiqnurenzhdcpdfwjwswb4kulbdimxtuy@pzgqw5aqhn3m>
References: <20250415235308.424643-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va3lsphxxw3lwntv"
Content-Disposition: inline
In-Reply-To: <20250415235308.424643-1-tjmercier@google.com>


--va3lsphxxw3lwntv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 11:53:07PM +0000, "T.J. Mercier" <tjmercier@google.=
com> wrote:
=2E..
>  kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--va3lsphxxw3lwntv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/94WQAKCRAt3Wney77B
SbSeAP9JkFLMSl4nksOMab6B62/csP+sac3doIRszWSDmJpZkwEAoCsPrJwLs2W8
otFloLpMdklEoCUND+I45f0k3ytzcAM=
=Kbk5
-----END PGP SIGNATURE-----

--va3lsphxxw3lwntv--

