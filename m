Return-Path: <cgroups+bounces-17341-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WZ9CJGsPmpFKAkAu9opvQ
	(envelope-from <cgroups+bounces-17341-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:45:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF166CF369
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:45:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=TECVmPGk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17341-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17341-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68C5A3028EA4
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA213FC5A2;
	Fri, 26 Jun 2026 16:44:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A801481B1
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 16:44:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492291; cv=none; b=S6uWfbMVo0/zDZ7ZXQ30e2pkgFzGG9TsboswAX6eL3OVmxdPdazvhmOqb/aAngNvEd5Q+8njyAifGNaWhGgUhAi8cJFgwuvHr6XtYLX5mivFZOBG2IZV9FGRdvQzQLqgld1ypy/lifWzVIEqMm3xP2NNUnhvoYWsQUDWBAo7CRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492291; c=relaxed/simple;
	bh=m7F5wb38djwjdU4PCT+nH0ihnwGgVV3yXMzvQ77WA+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqCKZeESxQnRPolOiuHnIIrWnBK1fog4ZI/qsMp/9m6i4+4VnfuUragmC4uCLiV16vcT+pnepxYR2IlJf9E/opxoKg4vFeiUTur/QLHcxgUpcSbrR5Y37WCMQEYdO7JHZnks225EX15IC/rsZiz+b0fjNY5RaN6UcRVwa/J7DCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TECVmPGk; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4926d6b177eso4231685e9.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782492289; x=1783097089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiWBrutmWIAfCPXVB/qlhLvNu7kR/O5EnS7WLLWLfPA=;
        b=TECVmPGkq0DaeiaNUl23gL3Wb4fhb619kgYRgs/l/tsrnW8IM81fqybkFcEldIy0yX
         n3UInS9NnojoXAYsWuY+lDUjQbhMPr4gW4v/DKxoeJ/vZ21BtTE9MDnmX1wdiVsrwwPt
         bW8UT01KcgXbHBPIKbHyWHG5/X0EK9Pbn682eqHPA0XTW+Ry06jsRsO9fx6Q7fz+ZNs7
         Pj+tQuSZu3iCToo7DzMWcVoqQoLXfqUwvOcThlHMhz3uJc9LSiIO3NJV7emdkzVvSSO8
         oqyuwj5XsE0U1PyBPkjcpV+USn1im6dg/xb4ZwF1fQ4w1I4rjScVEuFHy4jQQihDrQTC
         8QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492289; x=1783097089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiWBrutmWIAfCPXVB/qlhLvNu7kR/O5EnS7WLLWLfPA=;
        b=r1jo+NSVUg9YXimslnaxQdHu/T2mjlftcADLN4ChZ3NKGE0ti1gHnis2hV5HjEmps4
         jxGc76dc/nBHhVRnsnrq1hZi9vhKZnrIiHyoHla9YnFC+L2ScFPuKaQI7jvxYOjfBHln
         w5G1Mzh7PYlE2MGDa/sxvCoNjyNBL2LxnNhuPJITk1PXtr9LS0+XOYn62tmnLpX12+4x
         4zs6F8bTbvgOvsAYCF5bMtVrfYA6Ewjpss2kEWyixXD2aSqbb0nMOVwVb4rePmiIwrew
         LgIB72CPPPNAoWCrmZ89BpGvUfIrpGvZzzKadIOokQminix/TP/qLnLO1QnLT3NGA6Fb
         cq6A==
X-Forwarded-Encrypted: i=1; AFNElJ9u+0Q0Q52K2NpRH5cv3rhdsOfdwtFXE48/XIljiblyWBtX4Nv7JSYL09HTFAwxUr7Tx21YFTWc@vger.kernel.org
X-Gm-Message-State: AOJu0YwePGfI4h/JeAJY3mH0CuSHOzSJwYXgYmaLbWkAp7Po8JUrbU9V
	VfPugBi4Nri00VrbVpShVXj0btz53rualMQIQnHt8H3NfVAjlTm1VKgOXjgIsittckk=
X-Gm-Gg: AfdE7cmwilattoS1Yvv473qbXTdCOLv7Jd1/2mRd42Tc0SqCfFK/xigc5t6kQnc7996
	fILl1kC4SUXZLnikCLN52+fompd1+YCopTRHci+T+5zQPyf5X1ywGtkp5GFCJ1Cv/XxlRcydX5D
	KvFDV+NlCTUaS3Iq0Sy5OkOW9UD/NTnPCynFfEdXm2qPLAwL5aPe1A7JnU3gckfhvlfpNSi4qqJ
	sRU3k1sernBfW5Gn8e45rlIgbByP8qOfBtKtLbnbT3dsaAUonfMZl4xeW65NRswGtOFFMr4Bff+
	h9bZLQjDSrjb+Gr9Ilt6xa7RG4sxRE9LtuggA2/MEjugkInm4z5lYJ8NnSivIJGTFmlhllJySJ/
	SeO14FQFhqfpi14VW/zqGy5stcTv3T4iqPwX9QyoACgWixY1TQ2ulAW4Ckg65qyStjozk4+K57K
	3Rq1LrUW2epdTGTLWgNw==
X-Received: by 2002:a05:600c:c118:b0:492:6881:1114 with SMTP id 5b1f17b1804b1-49268811131mr76135445e9.0.1782492289053;
        Fri, 26 Jun 2026 09:44:49 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c02088dsm53200365e9.0.2026.06.26.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:44:48 -0700 (PDT)
Date: Fri, 26 Jun 2026 18:44:46 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joe Simmons-Talbott <joest@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cui.tao@linux.dev, Li Wang <li.wang@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Sebastian Chlad <sebastianchlad@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v4] selftests/cgroup: Adjust cpu test duration
 based on HZ
Message-ID: <aj6r_tUrPH8eTuQw@localhost.localdomain>
References: <20260625203307.1114538-1-joest@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnagmfluecnp3bhm"
Content-Disposition: inline
In-Reply-To: <20260625203307.1114538-1-joest@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,gmail.com,kylinos.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17341-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shuah@kernel.org,m:cui.tao@linux.dev,m:li.wang@linux.dev,m:shakeel.butt@linux.dev,m:nphamcs@gmail.com,m:zhangguopeng@kylinos.cn,m:sebastianchlad@gmail.com,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FF166CF369


--hnagmfluecnp3bhm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v4] selftests/cgroup: Adjust cpu test duration
 based on HZ
MIME-Version: 1.0

On Thu, Jun 25, 2026 at 04:33:04PM -0400, Joe Simmons-Talbott <joest@redhat=
=2Ecom> wrote:
>  static int test_cpucg_max_nested(const char *root)
>  {
>  	int ret =3D KSFT_FAIL;
> +	long hz =3D get_config_hz();
>  	long quota_usec =3D 1000;
>  	long default_period_usec =3D 100000; /* cpu.max's default period */
>  	long duration_seconds =3D 1;
> =20
> -	long duration_usec =3D duration_seconds * USEC_PER_SEC;
> +	long duration_usec, duration_sec, duration_nsec;
>  	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
>  	char *parent, *child;
>  	char quota_buf[32];
> =20
> +	duration_usec =3D duration_seconds * USEC_PER_SEC * 1000 / hz;
> +	duration_sec =3D duration_usec / USEC_PER_SEC;
> +	duration_nsec =3D duration_usec % USEC_PER_SEC * NSEC_PER_USEC;

Oh, that's duration in so many units and the seconds is there twice. (I
understand why you did that for the rescale but) could you pick more
descriptive/distinctive names then and ideally keep it simple :-p

Thanks,
Michal

--hnagmfluecnp3bhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaj6sexsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjcsgD+PahM0s+YmXEN2Ui9pVtE
FMgDbmDnWk4anoBQVxTF6ZoA/0jjiW78vkltqLj1imUmdkfUdTjr7GhBD+a+VHwV
lTQC
=j+J0
-----END PGP SIGNATURE-----

--hnagmfluecnp3bhm--

