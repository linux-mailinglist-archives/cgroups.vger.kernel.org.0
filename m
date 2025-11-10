Return-Path: <cgroups+bounces-11736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F797C472C8
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C081881960
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA9312813;
	Mon, 10 Nov 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRYkGJix"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9D13C3F2
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784858; cv=none; b=hB3ZhEbgw87RFCR82YKnD+bnXaQvYeRviO7THv+Zpb+cvBxQg8v6Sv2jdBhAGbKtIRajzVtsXFYEYp2N5Z75e5b5Mla6hrAsmW8LTFb6pYSlWSi5lKZGeHY3btUwSqmYt1mEoiL6FDvVmHa9IE3/WWVZVmdQnUVe7ink2BUdMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784858; c=relaxed/simple;
	bh=ihoIGUSl5KG1eENwxR/j5csfH6FTtQ5eoSNs9oJA6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLLwLPASxSVacfaMg31hxC4x4uOojhUAaEVaKrN1sg/k40hFQpKYcxVrrMUJCR5ouVCylDTLsFxRjp73T+5gQ3Vg+fDGzZsJ3Ndbhiuw57p9Si2tthmk+zCHHmE5WFFk2vpiBdLLIU0ERTdtbY3pFlUA7pFltxWJqHi4wiVdzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRYkGJix; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632d9326so23781095e9.1
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762784855; x=1763389655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kg3vBr5eIV1bhiU84P8YOC4pYEYEClLlaacpCw0wZo=;
        b=SRYkGJixCHOd9/Arbun0EwNmU+4bb5C90UQJ1GDHKLanUCCs81mj/owXVdVjpomwxp
         Mc3My3CUwSe3B94SJciG2Rc5peVIFORE21gU3zUGbMuwK7wBNaVd5mf0cD2DhWoRDTOp
         htAHD0cYaQgQOFAkK4j+wi3pMFc/H5oLrd0RoVZto7GV4HYF8GfuvVPm7juMLxUfYyvB
         2VeVtM+rmvpm1n9gAtzavK6F0ejRMkSW7UWdl384HFeCPP+XRQRVJCZzfTPdoL4NT08j
         e3PkJjEOSHR6GNp2+Cjzajx3rH5Si7yPXOKH9efJ4K/lMd3lIsQ2zY32mU9yJ6OIV4Qz
         f3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784855; x=1763389655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kg3vBr5eIV1bhiU84P8YOC4pYEYEClLlaacpCw0wZo=;
        b=qugmXKsTNudoO4Z6/Yum43Ag+vypSTR+rzHng9AntmEu9X6sXOhbrIR8kX21Kf9zeE
         54s3IHbXppeADJE8tp0msf0Uukxj/gnDPHcso3fJb5xA8wtl0N6WObHuCPno4mLwYJEI
         uHOje7V9uz2Z4W7clnr9tgHSZdRUYrtUEwRVK1tbS8/QO+6JW8jqV5M1t8/jFDQ4zm7/
         gFXJZiMs1OPgpLJ6uFCl0hmZP7HcG6/BB3ftAdI9D2+65AZzcMsu4746xbwtk4HHvNDk
         gi+Z5PXvqZC1eExHApbnzZ891uET91+Wp8myjPWhhQ6rcg7e9jaQDPOgAzMPwI/ARK/4
         LiGA==
X-Forwarded-Encrypted: i=1; AJvYcCWzWOiq+9e33cYLL1dMw5rDFHTjKa+q/F3GdihT4JZJacR9eJ/oKU/7pB0UI4ei40YtNuXKlqac@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCJnMTUmB9C5mux4gnnMmHktnVzlgUHbPjokvQZy7TKxCISjx
	s0qoXzRuSlUgDmCm+UDSFcfcKHT0SzK7RUhoFEsiUEw372D7I81oePHYPoJy8ijrd/w=
X-Gm-Gg: ASbGnculn9isJ653eHN136pbqNSdlzgzutZQn1A3g1B965yJ1bff4zGCrGQ3T6Kc3dB
	JTVri585DxyYKqMRx92HeWcqUhtYoc1n0PP9EZSrjoYXsay8joTpWvKEIACfKVl5q7HFUvHEQcN
	TFzsGlRHN2HEs4fY5HtNu0AHFK2+L04Qx3gMJZAvfaY/R+2KqA8NY4dvI/tUWguh6LPKrhTgdBk
	c+OlZ/qxkBtQC9e4nc2SDqT2igNCDmVe6g/ooKCzw3fWaICM7EsiJL8Do0gXz/yYquqN03Cgupv
	xnZ/M+3yYdDAFVb0y1oDXra4L0yttegNZ/m7ljZvm/hXbGn8PrT2gRINkEaLa8BbgVDSnx/8cQT
	P9EP3uwpUkST1r6MqWJ3WQRunS+cidnGrtJ3gbckPpNH3ZhgVSePxGIybAUBEOvb/QMWtNO/hbM
	YjoA4sOr8kI7jDu3PED3qN
X-Google-Smtp-Source: AGHT+IHML8MOqcOYXtiQH3128zZ7cQFznn5BzWZ/x/UpuzVV3JHCT24/iF1D8qaKQPfZa4W9/kkUDg==
X-Received: by 2002:a05:600c:4f4c:b0:477:7f4a:44a8 with SMTP id 5b1f17b1804b1-4777f4a4945mr17710055e9.29.1762784854868;
        Mon, 10 Nov 2025 06:27:34 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm116549665e9.3.2025.11.10.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:27:34 -0800 (PST)
Date: Mon, 10 Nov 2025 15:27:32 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
Message-ID: <o3daj3fasq66buthgl3rherobjqwkemjge5xlrgfzfyvcjxyme@anbppjgrj77h>
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncajuq6cdkyono22"
Content-Disposition: inline
In-Reply-To: <20251110015228.897736-2-chenridong@huaweicloud.com>


--ncajuq6cdkyono22
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
MIME-Version: 1.0

On Mon, Nov 10, 2025 at 01:52:26AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> There is no need to jump to the 'done' label upon failure, as no cleanup
> is required. Return the error code directly instead.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ncajuq6cdkyono22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRH2UhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjC9wEA3+kvpJFNdj+cvbVOFOqf
Mdoc4b5dv+sH20VJyQfNcTQBAI6c/7vhNcZfsC3tkOPJETcbP9dC+sU+F8uUm7aq
jcII
=MKFE
-----END PGP SIGNATURE-----

--ncajuq6cdkyono22--

