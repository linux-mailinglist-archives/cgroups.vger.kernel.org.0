Return-Path: <cgroups+bounces-8443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCFEACF36B
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3FC176833
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020D1E1DEE;
	Thu,  5 Jun 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hvn1lwir"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B485139D1B
	for <cgroups@vger.kernel.org>; Thu,  5 Jun 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138629; cv=none; b=sUJdbXCEt5lT3Hq5A5jzIe6x6N9Wjv6qCjzRwchuIfnqadCAMEpop0k7mGPfDu/eP3Y7LzLINsv2VAeiFpY0u1EL/zF+z5TyAa0gJbAXy+DJH5P8yaUqID6OX5rGgMR45e2Dji48B5VQwyBzi3awY1hhAypdcsYymfb7K10g+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138629; c=relaxed/simple;
	bh=PH2gg5/25bWwXBMWyv5HpO0mhwg5KYPWfIuk4bNNBPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGH0sIi92egazZz1P07bqWNIVSYYIaDQOBK38OBeOMB828TXSxmOqGEytCo0p32Wa5qEm23W5WwMQBTC9WF0yrwR7sAI24MCuP/oXp/iszw5+oTSulqQ1BZVXWP1SLE3KlNn2gAHKSZWXnjqD/QU6in6NL1bryFsC+1oGjozTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hvn1lwir; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1093672f8f.1
        for <cgroups@vger.kernel.org>; Thu, 05 Jun 2025 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749138624; x=1749743424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRCqLN5L4Rr3WE8pJIILtJZPUbBl7/a5g9L3/1Mvsfo=;
        b=Hvn1lwirJd9qggJQ5xoWI5LFYst7HV5ityrA7rsdjNxzkAPIBpTjqfjY1KWxr4wV79
         gE+ihtJ+FXEgQI6WUk5AC6rRnQlOGnqqKkasmxFkTdQr4M1dNCGeA00K9U9/KW7Lud1J
         MMJk8PYLCJ16TAK9mTM7LPfMKnAobWv4tUKSgv0uNbwGkva/je25pwKoCH0tem1KH4wi
         TnB/xLzpi3g0H1Sf76oXX0MH9vJrF5CxKe/Kc5X6vHJnPergEeaBjWJEPku2xw/pTeiz
         7IHhtNu7tczRUn0spjpWAa7hUPa7BsbDxTWbkUOy81a3rm2j13Ek5XLxF3uwfVuY6jTq
         /Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749138624; x=1749743424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRCqLN5L4Rr3WE8pJIILtJZPUbBl7/a5g9L3/1Mvsfo=;
        b=F4w4qwa+bcZStNBUPoHJX7rVaxs4Lvqvbzifsj+ypPYlTEJZZYSVvCr6Pd04sUQizp
         O1Xb6zMeeXPDIp4X19gUgXPdXnql63SFfvSVRj0pGVeBQk4PaGbbNZa8IoexqpQSv+bC
         hy9V+CREkTOFLrANi/7h2a1y/03FPJop+zJW2vl8fUQre0aoFSRO3uwONFr5ESFxFyAI
         fuBixX4cjLzWg2E/T9vlaAH79XfYsIotDrb4fI530TZ5SSjlK7mtcVdpK/O1rgnXVS8N
         5TvDMQpldVu9JcutZD10oQ8TtJiux/En311mM3/uMUF0jcSlfEEL3UQgm6BmJw6M/DV5
         Xt7g==
X-Forwarded-Encrypted: i=1; AJvYcCXKqYuncC3Vb+X8Yv+iyN3ZK4XYevx81nD06QVAtbW8LgX179l8juQAepFqptJP+92cOPooppAy@vger.kernel.org
X-Gm-Message-State: AOJu0Yybdpbj+QQ4VtpPVy+KsN+Ng9Ufe1mIlGvEHrLuhmsS7h55YSDd
	HCcFyXksCFp5oNrSBFzKOeT3VHiTXkU5uOxEXcdciOuZ6NkRfGz06zduypDlEcxR9P8=
X-Gm-Gg: ASbGncsZSyZkMVJtVg5qUpd9BUSISRK3sEaPqBCh0j+GYBByOXOkY9S5teLxyrKda50
	iWjFVXAMhtfYqZ5Y2mdg9uTHjozcPd798ed4h7McyWmiLoCpwqAOLjAWt1boOkr/lOQcJcHQ8Vm
	gMiZSZkPAbTk5YyY7pRO4yloETFvW7sWN0ZGqFH/CDiS4lkzJwzR667hoOzlY2HmtGodJoxlKEW
	Xt74K6P6WENL2Y3Z3F/Al9WQ3R5sQDkcvNqMtiZLdtWgItyVH1tJUqdiswbi01WJQLyTJLojk1H
	M4HanTrMIUlVSQmj5JsiU59ez9fm6exDUccn0YariQABd8Tajn+i9A==
X-Google-Smtp-Source: AGHT+IELoMlwsCu+FjoJVCzoFEowpMUAlbq++KbjZI5GGOu59FebaVIM2y+qSY8qYZiSkvqrwc1U4A==
X-Received: by 2002:a05:6000:220d:b0:3a4:eed7:15f2 with SMTP id ffacd0b85a97d-3a51d96ae39mr6337955f8f.43.1749138624495;
        Thu, 05 Jun 2025 08:50:24 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe7414fsm25349729f8f.55.2025.06.05.08.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:50:24 -0700 (PDT)
Date: Thu, 5 Jun 2025 17:50:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llong@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v2] Documentation: cgroup: add section explaining
 controller availability
Message-ID: <xn2sq6byy2qvylmnhzgzhjuac44t5qnndq5eo2rp23xjndbhlg@oymknwf3cxw5>
References: <20250605145421.193189-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bayaay3n4q7jtjk7"
Content-Disposition: inline
In-Reply-To: <20250605145421.193189-2-vishalc@linux.ibm.com>


--bayaay3n4q7jtjk7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] Documentation: cgroup: add section explaining
 controller availability
MIME-Version: 1.0

On Thu, Jun 05, 2025 at 08:24:22PM +0530, Vishal Chourasia <vishalc@linux.i=
bm.com> wrote:
=2E..
>=20
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--bayaay3n4q7jtjk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaEG8vAAKCRAt3Wney77B
SXmRAQDPQPSQbPWaqiXwU4vsbDRInrcwQad8DauYGFYkN3J/UQD/RsuAsYUG7+pd
13hnOACyQdZK9AGRKldC1S4PUT8p6ws=
=Vr5j
-----END PGP SIGNATURE-----

--bayaay3n4q7jtjk7--

