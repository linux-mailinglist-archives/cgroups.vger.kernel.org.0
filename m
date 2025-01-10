Return-Path: <cgroups+bounces-6088-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AFEA095CC
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088463A229E
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8621129F;
	Fri, 10 Jan 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMHZGONB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4D19AA63
	for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523317; cv=none; b=UXouZORRGZ91FlfXBXKqacFK/LqSHPPPVJo23N/D/FKfT1CXTU20OASXkdd0ITqZjuKOmg4dX23GJV/ZKqpRM4lEdRw1/8yl/g6rVOJzOhiny7fdkP4IEtntagli59+2M9tVKW9r0dm1FCajzRzerjAh29S2t+55X2vASM1SNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523317; c=relaxed/simple;
	bh=d5Sw7dBjPFZKUxDbI6GyHLqIDgVlaRFY7ylsIvSUQHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqvTJCKpk4xK9dGqMYoAfNN6a7M8F4FjpsxNqu/HRMmZKIfaHXKbtpa0bNjs6C/vF/dT84BpJ8IbvJrFEN2M22Ywhnwkjn55qqStk+McBmN0e1fqxONs1sAjXvqLsjC/uuRavxYYpbvUv55i477pVxvUTALvBIjk2ojmaFIol4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JMHZGONB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso23549755e9.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736523313; x=1737128113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzALuTeGsxrz2Ujv8VfVqM+kWyzyAjXVBbotfhCob1I=;
        b=JMHZGONB7jeXGuWb6XanYWOGxnuBwuzm7IfsDf8wv31352q0Sde5ynA/XDAGETFn6+
         HOdZeU031qQfXxGAQ8s6WDnSYMiSRfV9XTma3TlO2XRgaM+NE7kpyZLzBcH7iChjao8N
         iVVtkM4wBSyProMvyqLvt3V/X92GLrCdZlCHM9el9LnfcXcrXMqioAzgDnecLl4K0zly
         SRNgC/DvfHiLc+Zr4BUDPKfBpL5JYL/chBSvwFD0TQRH5VbvAa+ebAgRoAIGeTn69P9o
         3n+efToQYyGJlzRD1ksLkS7orDIx8ihW14i/2CMBknh8W+TWTfHMiBNu1SrblgFJsUST
         InJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523313; x=1737128113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzALuTeGsxrz2Ujv8VfVqM+kWyzyAjXVBbotfhCob1I=;
        b=Hdif43E90pUerdglpJFp9IwsC9ddZAzCtv92emTkjVoWrRHWkfqstEgiytiKxaCxV7
         ku7PcVa5yEFR0BlVKN0CSn4S/tZHeo3lwCXEwiIprW8dQTTd1fJXpsVvh7yjyTyGW4l2
         VCZ3XG+Ojs6h1tiCCkEX15yf9enYgctNBAlc5vs97s95jTT/EN3/Av8Od7cwEaWCYd2a
         dQ3wbdVUo8oHJiajmmh9H/82xZfDUkHdpNtF4D+MI1gpOlxKkstyiXE0/k2djhF85Py1
         h6IOPccq1lAN/cl8Ilbyhf6RCfRivBaCPzCmKWb2Hpiab06f3c74qhGGZHelR+79SOTF
         o6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVAFHxzqQaRY1gaaNvR6FwOOCiD8/sRezrQTVsFYDwGnD2+zkdxsM1MHGuRPVJ3ykoZRageK6Qd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14S/K57ziFXiWGCRH9hfJPNC5ykPgG6MuoEaplj5lD3q30Hm8
	EqlxXMqVrlLjZAS1wWZ7VLMfZ6AWUzG7MdndEluYaIpLASCmhNeaHhq2PL1V3lE=
X-Gm-Gg: ASbGncsCj5ELFe5h7J2oUJpxKnIZdAzCcOpXMd+u87KBCKtxpsUvY6lLZnIkbYMAbo7
	YRRduogGdgZ1Gzy5Wyyjpf7fNyp8VaS27U1q23KJ/Py2K7w+OnCcY/SeK9yMwiKQOIcHu4uAf/H
	O+WO/NngToPcEWv48U0Kias5unUchwtwGNs2F1K9OPxgEYR1StChLFZlMRsj7osXmgfw1yLcaR6
	+e9it6qaAti0VCpOBXdXuEUPnVYyfsYZtEb7P9DCv6rVi2H0wSaFkG+9co=
X-Google-Smtp-Source: AGHT+IHQELDGjlEtVs1OouSf4OZtyUs/61z6YsUdiHktml3cGrNJbR8ZCZW5j57nJeAB18w3daTKJQ==
X-Received: by 2002:a05:600c:4455:b0:434:f623:a004 with SMTP id 5b1f17b1804b1-436e26adfd7mr26396275e9.16.1736523313395;
        Fri, 10 Jan 2025 07:35:13 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da7768sm91710555e9.5.2025.01.10.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:35:13 -0800 (PST)
Date: Fri, 10 Jan 2025 16:35:10 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat
 description to reflect possible units
Message-ID: <2piu6sz3vkjl3scu6puo45ewu5ffuzv6ikeetgt6rizpswkcec@2uezwhes37io>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <a8d5ded2-6921-4c6b-890d-17227147c28d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3oon2oaiqfe67wkw"
Content-Disposition: inline
In-Reply-To: <a8d5ded2-6921-4c6b-890d-17227147c28d@redhat.com>


--3oon2oaiqfe67wkw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat
 description to reflect possible units
MIME-Version: 1.0

On Fri, Jan 10, 2025 at 10:26:40AM -0500, Waiman Long <llong@redhat.com> wr=
ote:
> > -	All memory amounts are in bytes.
> > +	All memory amounts are in bytes or bytes.
>=20
> You mean "bytes or pages". Right?

Despite both variant are logically correct, the docs should better say:
+	All memory amounts are in bytes unless said otherwise.
(so that it points to respective explainers).

HTH,
Michal

--3oon2oaiqfe67wkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4E+KAAKCRAt3Wney77B
SZFUAP9hLFjYqd3/wr4uFM4W9vQFUjRXegr01fomOrtEJf8s9wEAmzHh5AOwn5F1
klsrKNloo7jlKJuiIi955hnrZUEhpQc=
=couS
-----END PGP SIGNATURE-----

--3oon2oaiqfe67wkw--

