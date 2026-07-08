Return-Path: <cgroups+bounces-17587-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYetBoSeTmpGQwIAu9opvQ
	(envelope-from <cgroups+bounces-17587-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 21:01:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB6729C25
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 21:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="Oo3BT/bv";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17587-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17587-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1191D305881B
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202463D16FB;
	Wed,  8 Jul 2026 19:01:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA03CF963
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 19:00:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537263; cv=none; b=PIvQq3Q1uAWWMK/5vaZx8bMZycMfAZITxqfhWEFnUqZUosEvm4ynTndpg4Tiy9hMO/WHiDf20pJuLOP6Uwl9wUFCOx9lpG8cRq7UeQd9Q/qZ7v6sA40Gr3nGVHEcwXnR+ve6/KtPin2n/YiwoYQ+EybInODRmeyZrMdTx+DAn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537263; c=relaxed/simple;
	bh=k3eMYQ2fgWM9eul1MhvdVNq2qZnIJPst3WSiSXllEgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuiuLg2kVYUre9jq4JSkz4aIbPc0Xszb+ZFGYKCPPlT1U/COq1gncL62SAFRqmHZTU/Lwq5gjmlY6xNCbmyv6tzDuIDdixr4DrHF4lsDtZBGYooyJerl/JAQ3lEQOtn2iwET2mmPiViZ2OQseKOOmSGdx7r39rU+7CopwhopOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oo3BT/bv; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c19bad03so10184865e9.2
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783537256; x=1784142056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3eMYQ2fgWM9eul1MhvdVNq2qZnIJPst3WSiSXllEgI=;
        b=Oo3BT/bvj/qIG5mtfWfiQM3aeUvzunXLkokRypDNrXYrVFgWl8KpL9+zFOpdo0dPYT
         yI7/mUEWcuc7Chk0NvyyCZXcXQ9CtL9Jd0xmjgogqapx71ybuogyUFCypb+y8w7z5wkt
         UaXwwTxZ+EZnKS18+rVzyQXsX0fiJqo9Vyn1Ov/rn3ZTH1JlorNCzErGIQ3NF6NnJisd
         h2o1t4ZBr+8HdQVwVlLmmVBWRatxoUzUzQWETcrwYKIOA9luh+R393ozJjoW6dS+n73d
         YUKU0DSM6He72hA8nEmp3/cZl3vtu547tA0K1lDuC+j3/4P5hbnf/sgV70j2ZLZ1NEli
         hBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783537256; x=1784142056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3eMYQ2fgWM9eul1MhvdVNq2qZnIJPst3WSiSXllEgI=;
        b=RrXQ69E+EooSZZSvmuYU88FRPeDteKqgzPO8p2QmJXk+10Y0QzXpfItcLbthL8qEZM
         9U8AKo9ka7scErq3yYUA0WPSQE0QJ1d2gtQ2AFf1fVhPuQt86jQe3Zi81P/ubU1pm579
         w1idkbkGezMod0A2LPzPPuOlYYgCYq1/sx1FqbLpolRWAaCBLESBV/fdbJQj1KPp9v3M
         gjCt8cRZhS/81m9nyDG8XzwyEjwbDID0jHUb5isp2yrWL1iEe2IBmBgJrnYJiIODJucF
         CbsJvMtXD3dTpddoAYX52j9D61tzTjDWc7PJqWguz66v2QBKwzhRCoRkXghvp3ckLiD9
         O+zw==
X-Forwarded-Encrypted: i=1; AHgh+RqBEusbSFIfvzY52IpG8Ky8uk6fXFnFkB4/60Ub00TfCDH81dx60emcZsvAGg0kRJ10JSud2alV@vger.kernel.org
X-Gm-Message-State: AOJu0YxD369mxN3nmKSWknVwgmRzMYfkJ3zXa/1sgnUYH+vkrRlTEJCn
	eD3Ir+2BUUM6SokpxoYz9umKCpIHOT40vBz/nrwcQNBX+uwRRInAx1oKhG0+vcFVMI4=
X-Gm-Gg: AfdE7cnubbl77op/jLefmY/bdR0D75gWDnWDzzkvzd8q/tu77atzCcYXzOlRiQLAy/q
	KQfRdqIy8jUkYMxjnZHU7h6u4DL3yVx7WtXVFL4fVy8L76JOBSnGBecLajckg5Q3xr0nTJ8rhy+
	oXiNDJFWxDO6ludSjwc+wFCufeYrV9FKjyU43E42HL9U6RJQrz1fg0MdlJKWmDNi5Zq+czjt6eV
	vpxd6eIiv/Ww12qLSbL+ibqbPXJ0irCtoSJXhBwzGZvaHUKuPLVdJEnFoZsVXD8k1iqmqR34wqo
	VBXSVC0IizUwQC9HBPgxG12yL54aOUCdxfUZUWbhqahJZ/0zag+o/I2K7kPmzeawV4wlQmJq8EW
	tpTddSaY1ZuUjOiN9UhA8Ut6zs1115N30xtoDIDhmPP011JjZKt6tOg/ByQ79ddHX9R6jwgjshH
	/W4aQZeY/Kmg8oN/mqEcW0TX6LuX1H9fyZ0W4xqg==
X-Received: by 2002:a05:600c:6091:b0:493:c83b:50d7 with SMTP id 5b1f17b1804b1-493e6831575mr37343485e9.6.1783537256247;
        Wed, 08 Jul 2026 12:00:56 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm51255578f8f.17.2026.07.08.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:00:55 -0700 (PDT)
Date: Wed, 8 Jul 2026 21:00:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, tj@kernel.org, 
	Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
Message-ID: <ak6c2TaOlcGxZ2Ih@localhost.localdomain>
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
 <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
 <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
 <CAO9r8zO-nAys0PJfXVRwLgAzwJLa9KxpMXKQKXJR7cnYKgmhRQ@mail.gmail.com>
 <CAKEwX=M7axSs2FJDq0KF3GBDpd6G0J=gP_2boUJraNf8M2n3Bw@mail.gmail.com>
 <CAO9r8zM8qk9g6+B6GiCV3oytjViMTEhbr0KjrccU+bF4+PMfTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="65f7eg5vudklrash"
Content-Disposition: inline
In-Reply-To: <CAO9r8zM8qk9g6+B6GiCV3oytjViMTEhbr0KjrccU+bF4+PMfTA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kvack.org,vger.kernel.org,cmpxchg.org,kernel.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-17587-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:nphamcs@gmail.com,m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65BB6729C25


--65f7eg5vudklrash
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
MIME-Version: 1.0

On Tue, Jul 07, 2026 at 02:49:56PM -0700, Yosry Ahmed <yosry@kernel.org> wr=
ote:
> I would honestly rather use more memory. I think there might be cases
> where the flusher is delayed. The flush being slightly delayed is not
> technically a bug that we want to see a failure for, but if a large
> stats change is not visible that's a user-noticeable behavior that we
> want a failure for.
>=20
> WDYT?

There's already the (recent) page size-based scaling, so the idea with
nr_cpus scaling could make the selftest useful on wider range of setups
(even page size can be considered as a slight implementation detail
leak, thus the justification of nr_cpus dependency).

Also, I still think that internally the threshold should be changed to
the "harmonic" formula [1] but the selftest can go with the linear
dependency for more pronounced effects.

Thanks,
Michal

[1] https://lore.kernel.org/lkml/n6mhkjsxsami3qmczkdh57eep4lmcgbtyl7ox3ajzv=
eke44yf6@m4bjevvsr47k/

--65f7eg5vudklrash
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6eYRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjWUgD+NXLAQPqFouL0lAEWSdLH
Q1TGxjtThGe45suKK7NoiLIBAM7klcnhnOTcn3O4JeLz/eHwfK1JWXaF9nVzAX65
8KEK
=2aDV
-----END PGP SIGNATURE-----

--65f7eg5vudklrash--

