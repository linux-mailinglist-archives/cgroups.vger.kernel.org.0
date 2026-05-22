Return-Path: <cgroups+bounces-16219-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNbUAkiKEGrEZQYAu9opvQ
	(envelope-from <cgroups+bounces-16219-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:54:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B95B7CBC
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5347A301A900
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9E477E4D;
	Fri, 22 May 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUxVu4JO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5363AEB35
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468519; cv=none; b=LGuvGNdmINQ0KiJeBvf1mdeQ4re88vGXP2Iu6wevs5gmRLVEvDJZra3ZfL4qOTMJCM9rQp1gwY2ZdBfhmxaPgpmXAOkM3zvJtoKp20mjyQEUM9MwvsY7lluztgxEJL2npiv1sxy/yBhXBJ8Oqv+t3Xa6Upjpm+nZAlh3dTGPl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468519; c=relaxed/simple;
	bh=suCtCBavrXUoNe3sv+YiS2FLcvPEDoDUlPhXLWb7rgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeCf85Urb/kYWoxxZ3AVTyw/I7gWRsOnzPAR8FOy54/3QG/+etSvt+A+TSA17XYldsw6oDdQKWn2fM5dZ0U1NynnNIWVCAYM3ZYGFkIY27Q/EANl/AZxHTO4Y+LdBHWa+pReLA2lzkEkW9fFiEHPD32if4zyZYkMGFsuxAtX364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UUxVu4JO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso4523212f8f.3
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779468516; x=1780073316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkkB0hffRR69qMLvhInPQn8c5SMOFLnLZE8s1HedbWk=;
        b=UUxVu4JO7lcnC3jau98SkjDJvQAL34n/r/ySMVSN2psUVDmiOp8kxuBCkbgKsSBthv
         NWHOnqLLhKmyro+ubhGc0rLno/U/4iTCLYB1OT6cjUiSykXcjxuBre0tCM06OI9H+O3X
         r/Dpu/Lq14iQvlXpnLhz/enndwK+VXPJpELWpFDoH99hJ9mY5yD0kp8ZaThhNFmYOyfU
         CdwNIjFOGQsgO7cDB7d5tiT+A3itikNTuGoUSnl7p60UmrwOmpIhS8A6TIf7vh1Wj1Ep
         I0V9Qqda5eR9Lnk1C5gWd1j8BOsSXwNewqfl6Sn5Yhyxbt5RhPHF0Wkh+ndEwVHvyJIZ
         40MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779468516; x=1780073316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkkB0hffRR69qMLvhInPQn8c5SMOFLnLZE8s1HedbWk=;
        b=MhEiHXTHFrfk/SHbOhpeQ07t0R3di+LWkC0HTqBX4iq6CsrPMQ1xPYk/C2XYgP4tx3
         pNWG1eGeSOwGiUFIE2sHnlbxnug7nMF7npPn3ijPOSei2b2EVvMGODKaCSLmr0MuvD2A
         rJkxgeyKILJw3JHmVGhru2KTd23h9T/AfydzoGwx7uTU9r7WZehXmDrpi0OyEwah+kZG
         N8v7tmzZ4CW8x9qNOXsEEdB+k8OkhTJBM/5L9UX0If4d/5wBfYvuqI4yAdKycJ94hwx2
         9Pw75R389fxOZDG2oOkg5UAKWWXyP2umVYKx6zxl9pkNGS8Th1r6FPEYXDYFJhhlYhJS
         fU1w==
X-Forwarded-Encrypted: i=1; AFNElJ8+/v6kELtoaWakz0EAfU9V/4EntavCoMM1VBZdfUqQRV+ly4uzM6pOL1wavkSBwlCMNH8G3t4C@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1EJif+/SvGT5tZOLR3GBE47K9TbvLzYyI43sc3EQcUC3145f
	7lDjHHVdSzzCb47YfarzjJeWsz/uLjoG/J/fMgRmtVVK6modciOeeNVAvgAbFdcxJOI=
X-Gm-Gg: Acq92OH7DQ+pSkXUvEVNxHVqSBYKPVS7gH6nilbgeCkrJuyba5XSIg3Fl0zX7CQCQxV
	pPJbX0nslPj4AL2RIVCa8i8hNFKip2izQv+88DAQ06ctlvcysrv0Ja/o4eTfyvNJrkXNYoaWxUP
	EkUzrEuTrmSk9QyDH0UQNpT7fxG0gMFaCqgC5mDxSuDk6Uwg2NndybwXvUD7aHV8mRij8r06+tF
	F60UkFIajPTH5VMhqLKapnOY+082SVnjlscaExB5Nk7z+TBf0QzRtGOk+x6Nw9PQbt8UrhtquCu
	uAY/WdT/vlaYKa5Kfluz6XIIZuwXjxaVFd6YxXBTutB3pRnefyQAG7D5R5njWRrAU72NzKMUQ9B
	QouyhcKutbBycIpFL9lolNkI05jF3tJgcqZad34QCvm+J+/3f4nqw+57AvpzVucDI5mBSgch7ny
	R3WTEVXlQ0aW3j1y4YpiUThJ5XrE/N2stCxm4yPVXe5/d2jBCs
X-Received: by 2002:a05:6000:4283:b0:45d:8c16:5566 with SMTP id ffacd0b85a97d-45eb38baadbmr7082103f8f.18.1779468516497;
        Fri, 22 May 2026 09:48:36 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d70d89sm5769908f8f.37.2026.05.22.09.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:48:35 -0700 (PDT)
Date: Fri, 22 May 2026 18:48:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
Message-ID: <ahCISfTlN10gD8e6@localhost.localdomain>
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27zcqpjzhteuelt3"
Content-Disposition: inline
In-Reply-To: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16219-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:email,suse.com:email,suse.com:dkim,msgid.link:url,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 5F1B95B7CBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--27zcqpjzhteuelt3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Thu, May 14, 2026 at 02:36:08PM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> Just like we have memory.peak, introduce a dmem.peak, which uses the
> page_counter support for that.
>=20
> For now, make it read-only.
>=20
> This allows for memory usage monitoring without polling dmem.current when
> the information needed is the maximum device memory used. That can be used
> for capacity planning, such that dmem.max can be properly setup for a giv=
en
> workload. It can also be used for debugging to determine whether a given
> workload would have caused eviction or system memory use.
>=20
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> Changes in v3:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v2: https://patch.msgid.link/20260513-dmem_peak-v2-1-dac06999db=
9e@igalia.com
>=20
> Changes in v2:
> - Make it read-only for now and adjust documentation accordingly.
> - Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb344=
9c@igalia.com
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>  kernel/cgroup/dmem.c                    | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed99..d103623b2be4 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2808,6 +2808,12 @@ DMEM Interface Files
>  	The semantics are the same as for the memory cgroup controller, and are
>  	calculated in the same way.
> =20
> +  dmem.peak
> +	A read-only nested-keyed file that exists on non-root cgroups.

s/nested-keyed/flat-keyed/


With that

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--27zcqpjzhteuelt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahCI3RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah3WAEA8jNoGbM+jfh2AQM8AaCh
AP+xdJvR4lj+FHVIyhs6qukA/0scDz7iwckNV/NU40VipKTbHw6vIv1Uo6Y97PJu
d5kF
=dGdF
-----END PGP SIGNATURE-----

--27zcqpjzhteuelt3--

