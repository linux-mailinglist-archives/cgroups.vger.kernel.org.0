Return-Path: <cgroups+bounces-8696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2EAFB095
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D4C7A6CA6
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828428A1CE;
	Mon,  7 Jul 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eYWwkCgf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85928935C
	for <cgroups@vger.kernel.org>; Mon,  7 Jul 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882396; cv=none; b=t/Cena324vNYyn/Vzh4qDJ7fMm+v75rW1JygT5n+mvscQPpxiAj3zr4Ai/e8brLRhpqp2YqqISv4kNgmU8dWsMnkDifQu3FRykXNNAGN9izvAnmnK7acN3B2i45QrjKnskFLNyiOV2+Tp8XAWBwpfRIyF1NbYvDZtVGv0CJmFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882396; c=relaxed/simple;
	bh=7Yz0bjI0WWqTDd5wMmn0BB46jE5RLxxJUDmNLhFW3Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz7Jwq+NGfODLdrTqvnxjkbJdJCsxfVzUPMNvx9qghwBWfI8R7OkWpkJt+rs8V+k7ciOw+n/kcxOkuDcya4440MzWChk3M3flNRvAh7bEXqt4M7mpZgAI5HgSvdY8WeSHng04j0Clw+snmWBDzHjh01W8S7XeBgWuMTxU3onQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eYWwkCgf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so18766005e9.1
        for <cgroups@vger.kernel.org>; Mon, 07 Jul 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751882392; x=1752487192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d82/2ial6v9ccHeZaghL3hLg/dzpt/+BNJIXRihD9fE=;
        b=eYWwkCgf1Y/w6vxyp+NoMkTUdyBmohRGRfP67QIPZ/bEQRMOVJNmmkJV4uBf5Ze4Yh
         y2Mx8WDVMAzwwiz3ndyChiSga+RGBDQIVVjRTPCZ7QoXWWLFjd3KVaXmJSghr3NMaEH+
         99eEbKkNekpPUQI0zGDrc1N3pZNuVmlnNm/ndJd15QihssI97tUVB24T7drju25z85pA
         sPjWsKjEOaMhxwXVuQo4Tj4gkddxl+xNTMDtYDccw+KwTK5qQ2xkCzNGRqfg26NYf0f6
         iNWrb5tg5B05IhwKJ34MNQiHOAnS3jNXy0joGLg668meOYfnmtblaJSryT7OgWd6bO+0
         95Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751882392; x=1752487192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d82/2ial6v9ccHeZaghL3hLg/dzpt/+BNJIXRihD9fE=;
        b=e7s4x4eiRNwR0umHPNBN7Ps6ZHGo+yfyZEB9f0LzR4y/NfJtsLV/GIpMWaGTK1Pqat
         1cjM+rNTThnxyw4cGopY0OOMGqiAkHWGr7aseO71r3m5X1byWce9yoUCrUaEWGyMCMgS
         4ttyVd50+UFlUvClzWg3uyZ0FUrSXOax+jcq0E8uRsgLis1xeXgyD+zMHK2sRhVjgrEd
         Sd7OTpYtMf6JiJqFWeovk9Xhy3Y6j0o2B6lEAo/C8+tjMTrgGV405cXYTWmAfvRfvq5O
         B0OLl8EP9nUgZqlthU35ArXCVFzYjvJ7htROSZpWJLHnR2h4VNBpmgepNB2Jid7dqlES
         EPsg==
X-Forwarded-Encrypted: i=1; AJvYcCVbzoLiWV0TPTmRKAJ39jQSrblR8cxV5MrE4giQukMYWyRX7ly+YI4mLNAMjjJFvTVwhckuyX1H@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkBtPi/Su6My6EuqNtjHN7wFH3yMIzGeh7O0dRhI7doHtpWe6
	uirPixjUmvt+PoewVbNdNVqpcqEMHS2DYEveOjueySUUHELxx+gBWKc4bWG8La+oh0N66AiuMfu
	FDn8z
X-Gm-Gg: ASbGncuV+1UHmrK6mzpuI/FXevBJNlcjn7/gzQi5A5H5uY6ZfKMhHzSNAyB70RVJdvK
	s7N17w7S9s88Tzmv9rY2ezecsOpEz8Zzpscy9n7Vi03iEZhqdKE7+qzgJZOuonI+30f0EQSbxAM
	eXFf4dK1uN9ERQT9Okc3BAzblApapQxQ8wVMtDI4plrcv/sEJtN2n1+KXoiQUPdxFphvswuZ4+J
	xg/kZ3/QFg+htpJkXGvF4sq/cjMIPsMaugsbcsf8dtWQAfF0nd+uhd8y1rWcRDCmu5rdD9+BIsG
	cd3beYHb3PhcSucYwCD0lRrNwZ4SC4h7TJU1ER6Zdf/cTk68seCgIGhCkkYvK2GBz/lGbxzVYsw
	=
X-Google-Smtp-Source: AGHT+IHRjy82W3krhF0E3ljOItCoie8HVrp+8y0T7w/WP5rEf/zip2ygctxQu9zwoA/kbRgg/9MwOA==
X-Received: by 2002:a05:600c:548e:b0:442:ccfa:18c with SMTP id 5b1f17b1804b1-454b318d9c0mr86326645e9.32.1751882392003;
        Mon, 07 Jul 2025 02:59:52 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969058sm137832675e9.3.2025.07.07.02.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:59:51 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:59:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <nyzhn5e5jxk2jscf7rrsrcpgoblppdrbi7odgkwl5elgkln4bq@mdhevtbwp7co>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
 <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
 <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>
 <aGPd3hIuEVF2Ykoy@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdwglhs4zrm53st4"
Content-Disposition: inline
In-Reply-To: <aGPd3hIuEVF2Ykoy@yjaykim-PowerEdge-T330>


--wdwglhs4zrm53st4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
MIME-Version: 1.0

Hello.

On Tue, Jul 01, 2025 at 10:08:46PM +0900, YoungJun Park <youngjun.park@lge.=
com> wrote:
>   memory.swap.priority
=2E..

>         To assign priorities to swap devices in the current cgroup,
>         write one or more lines in the following format:
>=20
>           <swap_device_unique_id> <priority>

How would the user know this unique_id? (I don't see it in /proc/swaps.)

>         Note:
>           A special value of -1 means the swap device is completely
>           excluded from use by this cgroup. Unlike the global swap
>           priority, where negative values simply lower the priority,
>           setting -1 here disables allocation from that device for the
>           current cgroup only.

The divergence from the global semantics is little bit confusing.
There should better be a special value (like 'disabled') in the interface.
And possible second special value like 'none' that denotes the default
(for new (unconfigured) cgroups or when a new swap device is activated).

>   memory.swap.priority.effective
>         A read-only file showing the effective swap priority ordering
>         actually applied to this cgroup, after resolving inheritance
>         from ancestors.

Yes, this'd be definitely useful for troubleshooting and understanding
the configurations.

=2E..
>         In this case:
>           - If no cgroup sets any configuration, the output matches the
>             global `swapon` priority.
>           - If an ancestor has a configuration, the child inherits it
>             and ignores its own setting.

The child's priority could be capped by ancestors' instead of wholy
overwritten? (So that remains some effect both.)

Thanks,
Michal

--wdwglhs4zrm53st4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGuakwAKCRB+PQLnlNv4
CPFYAP4ydDKYFygLh14WYhl6pOkLrwj8JkhclU3yKqmmebJVTQD/W+JB5AMQ7qu3
RqhHDUL/M9s2yFNaz+QmdaSUTCcsNgk=
=X9yq
-----END PGP SIGNATURE-----

--wdwglhs4zrm53st4--

