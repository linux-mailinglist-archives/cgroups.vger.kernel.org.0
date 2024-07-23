Return-Path: <cgroups+bounces-3859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2E939D48
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E325D2833F5
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578814D2A0;
	Tue, 23 Jul 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vln6SOKs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E713B2AF
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725900; cv=none; b=RE0ZJF6alVa6/yZYkUZcpNpmDnBx93yTPs2YPgtzlmbSpffVMYEz6QLPkYkcW3hPAUINXMzGqZ85UwFo0GQj7v5augI4CzNtEX181AyF0EjZKnmczo+/cj8q65oy6wQOb8178h0xajVzwaPNDUDlzgfgr6cEQhb4JHlCyChLnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725900; c=relaxed/simple;
	bh=wGwRA2efJxAMoIWoFALwD32rwrbzj0+/i4ryaIKcrSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUNlDi5Av601cqg8N0MiMzXdCdWu6ofKf2SlmOLaryFzzIItp3AEqrAqC0QWzd4Bo06W7kKlgiEZEYPiUTmpfiUPsuvVNcw9qvTeZq67CaBg/4XD41ZUhFd6AeWIIKE9/5rXT9SM8ny3WRJ7logxhvI18RMvkevSJpAt2zMJlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vln6SOKs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a797c62565aso512161866b.2
        for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721725897; x=1722330697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4m22+VsjFo5GUsw5jkKQPA0xLnML1JF907YjM4GD2Y=;
        b=Vln6SOKsUMXcGrjogTHSCkJwf4th31ezK2mTPJSxqqluwZpLy3dbYDr+rHlk/Gm54q
         +mgQiKwlbl/wKpqJJcVcBm3HjbL8b2dj54NGZTRlnL+cMxng7YIWX/RnwsdfTWnPfj2+
         tRxVaF0Kzsu1OC08ifTHhlNGfbArO1eN8r+ZKspPdy+sPstuuukqK7CVY4E9GqVErWX5
         iQePkfcStfSv7IgKA7pVquzsut/Z0jl7OQqZnrvwuNxvXmF3uvuQ/Eje6Cx8AgJtG1y7
         dJeuy9odyuEMgqFLKg/OLtA2+goURAse0H0LXflxxx/UB/EWOLMkw3YFaoYnDEXXG+lf
         6OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725897; x=1722330697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4m22+VsjFo5GUsw5jkKQPA0xLnML1JF907YjM4GD2Y=;
        b=gljq0ga6cGjYLPi0WXwikRbFQlM7kqE/A0ygWpDhTm5+cwJTKZEP9H+DCGngU8/jsS
         J+RQ4my9n0TE1qJgt4XDNrDs1hvAyaj1D19twyuE+ytT4M8stj8QRNLDYanHk8PMVmnN
         3Rn3saKQltnx8f0HkqzOn+IMyC40b/w4w2zReIrdz3hDvAiMBM0QDQbAu/Wj5iQv3JAj
         pfo/Ep0tYI4NTtfYvGWcxgXfVsp8QOX3SGChuxaxxv3UwcqjOpfHHUCdRsPs80oUl6Mw
         gdyDvCJLSiHJqWc29V1mV/Ce5k13zsrVPvvfNzTZk7NzraPFeqyUXBIhMa/bdpSdKM4+
         rLAg==
X-Gm-Message-State: AOJu0YwMqOJJaM27Xr7BlibY7zsfmEmk0YGdUvzcX+lWPQdaU/iU20fI
	1Nwq5Xa93Mkq/3Vq/SIb8iTfJMCiYCCkhu2JbpPrprJzc39FS5+dcMhX95UdmZCyxCwGOouvEI0
	M
X-Google-Smtp-Source: AGHT+IEIbekmGmiqBQAtRd3srRNk09NBRXsaVymPp5qO3RcRYT9XX8yD/Pdx22XxjAo3rKZNsm68YQ==
X-Received: by 2002:a17:907:8693:b0:a77:a630:cf89 with SMTP id a640c23a62f3a-a7a87a9899emr160683366b.0.1721725897091;
        Tue, 23 Jul 2024 02:11:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78611asm519859466b.45.2024.07.23.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:11:36 -0700 (PDT)
Date: Tue, 23 Jul 2024 11:11:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cgroups@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Use seq_putc() in three functions
Message-ID: <mbv6jl67qw43ruzf55yzgdo7zrusvuod2c3b7cfgliypyh7pgf@mqneyza5cffr>
References: <8ff2d1aa-4c48-4cb1-b5d5-675adb90ae81@web.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ya2no36zmermubjy"
Content-Disposition: inline
In-Reply-To: <8ff2d1aa-4c48-4cb1-b5d5-675adb90ae81@web.de>


--ya2no36zmermubjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, Jul 14, 2024 at 11:33:18AM GMT, Markus Elfring <Markus.Elfring@web.=
de> wrote:
> Single characters should be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

seq_puts() handles internally the single char strings already and
calling one function uniformly seems less error prone in general.  I see
only marginal benefit of the change in this context .

> This issue was transformed by using the Coccinelle software.

Maybe that would better fit under scripts/coccinelle/misc for optional
checking.

Thanks,
Michal

--ya2no36zmermubjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZp9zvgAKCRAt3Wney77B
SbvtAQC3YXOpxBGMUUAQ9XE0rXBM7qtx9UV6TuNAybCrb0oorwD/d0DjyrSqcRDq
f+jviqBNoiFwprsSeg3L6J6yKbWaQwM=
=74Y9
-----END PGP SIGNATURE-----

--ya2no36zmermubjy--

