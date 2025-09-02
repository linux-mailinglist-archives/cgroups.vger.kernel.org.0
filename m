Return-Path: <cgroups+bounces-9613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EEB3FB50
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 11:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF192C2C0E
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E672F1FFC;
	Tue,  2 Sep 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q38/ydlY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AA2ED865
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806719; cv=none; b=mc7Abi0iCPjlc3jNMKg7jEL8REmSkRMmmZEpAeWjpkiunglnn7P4gBq9nGU+vvgUVPcP3QVdx2qLxVh8hz44iAIkF4H/+XPFQKnTOsS6MZk6JUv4BfFagYf5Rc8kDYz1LDsqE+KDPXy/A3bishveAn9/UrEwLJApKs2dIEGlK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806719; c=relaxed/simple;
	bh=OPuQMxOUMKmtd74yhuH3+ZoGiXX/Ej1X/m4lb4FXzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvx2rxrKPaEqzlC6iOtbskhd9PzZRhGbEczNdhhqYFbpXwJuCL5MOM7QGYPXxorq3ngUUyxwbJ8g5Xwccnbm2RjkmEkCO0qWtN9JvxlmMBdKRvOkPgToXrDvahhnPTkZA3GnsuRol51BOekXbuJ8pGNF3hGoVS7z9UBwOd4uNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q38/ydlY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b7d485173so32273845e9.0
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756806715; x=1757411515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TFEg4KYcJYl/xMrj917lNsi+q1ru1ge+qdtty/yQZg=;
        b=Q38/ydlYzKPI84Xh7ggCDW4asKio8ouJrqHPCYErJ6gLYbkIfezrxwXpO5KCoMBQFb
         FXTdY0ZdYh7w4WzfIWJJuPomyjYoUuK0MSxav5kr7ZXZhnJC9FyndqnT8vKkGnlxserB
         TGY3A6LpFRBLqH5bu6k/WhDTKR7OG7OljYuS1feyhIP3SKLOELiAzmmaoJCOY8AEV8Ha
         gUDg4yK5VDuKqRAMFbaIQhGH1dfQ4lJ/FX0FkPVbgxrSWLEjtWN9M/DIj+dXZCY0iehU
         Job0s8C9bc6PWPvkw/l04LgfCXQx8iMj/mlM7lzaYcXUpeHes+yo+RpoLLsyxW96TO+b
         1Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806715; x=1757411515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TFEg4KYcJYl/xMrj917lNsi+q1ru1ge+qdtty/yQZg=;
        b=Mf+9uZCkjHLjvgdyxrU5rdtlgtlCv6yCMYl261MSCD4GeqL21WXydg27zeOmICmux5
         A5bMyt40xv3D5MUhVfcWNtc/o8ItVrEv8bnV792nNgghL6HK6fVbbbPYZdMfpkyaTldv
         9/iqI7Ag0OM+S9MT6q6mgcJPpsjGQ2QmRFwFsSOsHupPq0NVWaQPcmOldljLnbBrqyxO
         dYk6/Y9/dU/pwd7T0wvyQJXoo3USoDlWvyDWd9a9QXvML7IVh8zw42S8cUzrPZ52IeDL
         NwX0MiAblJGVMOJ+6pExKUd0xn0eMIA0HkXDof7WDwUiPSrINM6GMghEDe8Ti6ok66K0
         Q6sg==
X-Forwarded-Encrypted: i=1; AJvYcCU7hMvXD4eQAqq0aLYp5u4YZbX7T7wGrJVbk4MiubuT3LgZ7TThtOot2C7+rAaIgubCraCLNxTR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz197PIqDbR/l3+Zn5Q/QiOL4JP/G8Oq3AhujCEFCFuUP7Z6J4j
	N8y4akz1z/tUMgHnC4WQJyOUK+hdwEZglQG1cnL8eRUbAfOkN14JxUnVdxkpWFPGXMU=
X-Gm-Gg: ASbGncvohYszo9G2JSU0bmNioMErBT7NPef5xtn0v6pPJE5LukqVSUdG5cG6UxUXTfn
	Ph5bGsszT+NuCCN6XZqutt8l8Aes3JEbnE6hgduD8GGGet5ZaiveW2x2rN2tX+Q0nn5Kbr1JHRi
	7ktfvoy+V/o5gN4QUTPFiAejDGwdUxFfOauS7bCfRplwrgsGwPnxbBvAzVqBO+y2cf9Bn39nZ61
	ZFfKug4dRuCo6bh/GzwGSoPFeTycChap5xe5AIcKOPCCbBlvxf0x3P5YimsgqkAWSDyXYZ0cjZj
	WP9m4c4xa5MZVaiUjB9D+rgPQobf11EtNytwmjLa/lea910D5m2r9VnbJcBiA0uV+zX+7MK8A/O
	ny22zx1wIR151bJLPiF52wH9cn87w1ixQP/ndpymeucU=
X-Google-Smtp-Source: AGHT+IGL74M/gnuKC4FyY3FBT30oTjIIJaIupFLaAOJ2PpkyzBPc3t2EA4S/LVebXzK30uxba3n03Q==
X-Received: by 2002:a05:600c:c48f:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-45b85533650mr84695395e9.11.1756806714687;
        Tue, 02 Sep 2025 02:51:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm295101005e9.9.2025.09.02.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:51:53 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:51:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
Message-ID: <wndxi6qoq6bq6lsovlpfutgx7jfummvipx7hhuu4khrdm35ls2@65nymtjs2q7w>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5d55kat4d54zghq"
Content-Disposition: inline
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>


--z5d55kat4d54zghq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 09:56:17AM +0530, Ashay Jaiswal <quic_ashayj@quicin=
c.com> wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>=20
> Free the temporary cpumasks only when they were actually allocated.
>=20
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a=
5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>  	if (force_sd_rebuild)
>  		rebuild_sched_domains_cpuslocked();
> =20
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>  }

Can you do=20
	if (ptmp)
		free_tmpmasks(ptmp);

so that v2 check in concentrated in one place only?

Thanks,
Michal

--z5d55kat4d54zghq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLa+KBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah3/wD/d3gKmwBoKu8zYX6KDBEq
a2AnLu103Jhxtbr7ASDeO10BANTgH2wmfZE7r24LBPVJCATLBptAqRmzsnsxgRKf
/n4F
=zZFz
-----END PGP SIGNATURE-----

--z5d55kat4d54zghq--

