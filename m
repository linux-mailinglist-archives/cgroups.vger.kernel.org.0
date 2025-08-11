Return-Path: <cgroups+bounces-9089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971EB2177D
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 23:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA73B451C
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B182E2DDA;
	Mon, 11 Aug 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2I28ApE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7E28505F
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947939; cv=none; b=nYOsqTrpr0G6CXu6o0Zm9Hpl4xTHP7hzrW5RlH3y17YEokmrovwIK6wChGx5qEubYtLr8E/XBcqPyi0eP+evapl5lRpN7UEH3FTllPOxjnW5igXQ+wZucGuvHBdpNZ1NPbd5sLl4F7cSMo/8AzGyENQFVcWjuhSz2TMv94gw4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947939; c=relaxed/simple;
	bh=Wp2SaX8CG7tM/UQZ7ITcbfAUzMlUdJy5a17ix7IDRPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTs3x1fUJ0++kI2KszPOQtX/gGM/Vjh74I/12DzP0RrUCVeBWB/SE5Y6otzCpfONyE1RsGEWPxMcZXgy6pWSBQSQoMRn5a09Fl7tuPuHqcKmI5DfchlH9COFUlzTQ0bv52/qUzYf2gTIDnyZvBVWxk8BIjsQNQD1X5sKDdWodFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2I28ApE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af66d49daffso809501566b.1
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754947936; x=1755552736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nq/BuyAKv3pgMr4iqsCzwNSRSbvLzOuBXkj4nE74O0A=;
        b=H2I28ApEhCgfH5kAOBKRWZkuGDRBkQ9wH/XC2O9e3ldw8BmOEuBi3zFZ3kFbG+Z4yg
         M1aR/oUlPfskb63CwsuAP4OxyqGyNEnYzp+tT8l8U5AAuWs7/arlifwSNxoN/YOkJh1b
         /5bjhDinPe3fnKt5JMT/KXnNi/F1fFcFTUVFTIwQomlIMd/ngSe/sXigMjLsuSuS/k1R
         D6SG1Ww5qH6k+ppMBRLTQKMbinXW9u2MOVhpLnuOpXxOdXhsULBR4L5XJen9vEP2cJ9z
         rFgPgeDkTm+0mmuIqRfwmtvnTCgFnuDb/U7H5RLY32kPiksqh/MAOWOgb7CpcGI5yGnp
         TaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947936; x=1755552736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq/BuyAKv3pgMr4iqsCzwNSRSbvLzOuBXkj4nE74O0A=;
        b=XgFAzYcIShX+0r6J6XE+Fjt70TlYXXUXw+YifOvs//D7dmyep444JmNfUXZG6ALzX7
         Nq4PKUf7/mToC2lF8rUG+6r144U6P5w2/qPS3PgaEkjJABJQ/s9PK8E4zU8XYD2snh4x
         h0cnRaYHuU9+xv+7JjzJftWGK+rQ2fmOjxFOciXdUT1fwtQ262ACFLqX8kTHtV6ktqaZ
         ZiVEs8tHbjidbM61NeSIzDeloPDPiXWQ1JN9NlFlfNSWQxZRNUPSfMdW9XzbEEx9jySS
         IYBr4Si9yjAEa6e01wCYKNbguKeLaC86GiQywGwy1QgUnzXBUBxgbTaZ/TKpB8umkOt0
         h2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWgRbCjM/wRqtkbh0lMKUZXxdHBfZ2Uk6/BozygzjTa6IqFxzcNZ3dlKeX/2Z/WD4lTt253ssDO@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVaLLwgtYdXTOXKfaHG2R7yX+K2PsaT+iESq5ciyL3wlnJ4QS
	+rC7ZmFIUZNOiuvdFWkFG1s8yDca0xAhBtvNhz/WA/RLvOg1+2vUvaoC3vN9VZH5UnA=
X-Gm-Gg: ASbGncsIPDVCfTRoGpnV9uBiM1vqsvqc9chSYBAbaAoFZ5M2Q3EYjGBPWb1Z/ekXnJ4
	nNaDKMn+V3DgDINkbPXF/sVo0HLdDALvGxxlN6NaZIV7PZRe5b64fFhN29cBpJil0fWyWpT+N/k
	zI2ThAqwNOHi/0YBqydJx98keoAbHS5xlasYL8jpPqYo81Qpejbg8OhS79XNjsic3rqj5zd2F80
	m2rUVTKInINet4UrXbNmNEPwq3D29BJCsmDEuq/Wap+GZMQfHY9Q+TpauG9D9SqKgi/38f9lB24
	iMoKSwr2rZb1ol06qJpwlH3VQvPEb6k1CbmWOOvzpTwWlqGKguQuFgZPlRcqBHG7N+ANRK4pLO/
	TYL8LzQDL46mp
X-Google-Smtp-Source: AGHT+IEpI2h9lIY/AO/fTtYcOoO4khM0ZEAiZvU2fi3EuMjQtsrWd8CdH2Opy3n0PnI33xPN+ZeMCQ==
X-Received: by 2002:a17:907:7247:b0:af9:6813:892e with SMTP id a640c23a62f3a-af9c653ab3dmr1329549066b.51.1754947935930;
        Mon, 11 Aug 2025 14:32:15 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3981sm2069766266b.35.2025.08.11.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:32:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 23:32:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	cgroups@vger.kernel.org
Subject: Re: [linus:master] [selftests/cgroup]  954bacce36:
 kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
Message-ID: <lsnebzejrxrpulxxmyvkfdrsplbi2ft2n5zuux3dl3ewt5ihrs@j3umrzndddsb>
References: <202508070722.46239e7c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35rdoq4zxkxl7xa4"
Content-Disposition: inline
In-Reply-To: <202508070722.46239e7c-lkp@intel.com>


--35rdoq4zxkxl7xa4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [selftests/cgroup]  954bacce36:
 kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
MIME-Version: 1.0

Hello.

On Thu, Aug 07, 2025 at 01:52:31PM +0800, kernel test robot <oliver.sang@in=
tel.com> wrote:
> dfe25fbaedfc2a07 954bacce36d976fe472090b5598
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           100%          6:6     kernel-selftests.cgroup.tes=
t_cpu.test_cpucg_max.fail
>            :6           100%          6:6     kernel-selftests.cgroup.tes=
t_cpu.test_cpucg_max_nested.fail
>=20
>=20
> not sure if there are any necessary env setting? thanks

The selftest commit essentially changed the tolerance margin from
ridiculously large to something that looked statistically appropriate
[1].
However, when I run the test (30x) on the 954bacce36 I get:

quantile([D1 D2 D8])  # 1 2 and 8 vCPUs respectively
ans =3D

   1.3086e+04   1.1559e+04   1.1177e+04 # min
   1.5109e+04   1.2936e+04   1.2989e+04
   1.5791e+04   1.3938e+04   1.3788e+04 # median
   1.6159e+04   1.5385e+04   1.4980e+04
   1.8757e+04   1.8699e+04   1.9494e+04 # max

I obtain similar values also on v6.15 (the kernel + 954bacce36
selftest). So it's not anything in throtlling implementation affecting
this.

The tests above were with HZ=3D250, for HZ=3D1000, I get slightly smaller
results with D2:
   1.1753e+04 # min
   1.2634e+04
   1.3208e+04 # median
   1.4010e+04
   1.6937e+04 # max

But still nowhere the 20% margin (i.e. values_close(...10%)), these
values would demand up to 100% (values_close(..., 50%)). Or add a bias
derived from sched_cfs_bandwidth_slice_us or increase the tested quota
=66rom 1% to 5%, that'd be an improvement:

   48882 # min
   52450
   52941 # median
   54284 # 75th percentile
   73186 # max (limit would be 60000)

I'm not sure how big overrun we want to accept as a pass.

Michal

[1] lore.kernel.org/r/20250701-kselftest-cgroup-fix-cpu-max-v1-2-049507ad68=
32@sony.com

--35rdoq4zxkxl7xa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJphRAAKCRB+PQLnlNv4
CDorAP4j+gBfzJ9mjsTBBUy9uD3wIzoL2opwDNhFmTuGsKuCuQEA3ayfCV8VdA6/
OKdE1A/l6w776aNK35BBRJ+Oz9FgxAE=
=A67z
-----END PGP SIGNATURE-----

--35rdoq4zxkxl7xa4--

