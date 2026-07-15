Return-Path: <cgroups+bounces-17832-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oZ7GASBWV2olKAEAu9opvQ
	(envelope-from <cgroups+bounces-17832-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:42:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59C75CA23
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="QK4w1n/z";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17832-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17832-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127E830D63A8
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D043552D;
	Wed, 15 Jul 2026 09:36:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E61435AA3
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 09:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108203; cv=none; b=tzFLneHB/zOf82RYm9KcydbJSfhzF9RmW4GvqX9Qd7w5oVJeb7/d41UtMVxIYLT1BJfHi+5k/7sEZvOs2xOLco5ArSX799KlJvuvKvvMrrPNWhGGtM/zh5auAK8EXUYI4GGoRaejTN+WVsUvhYOfLCvuYC27RB1KTD5gcCj3A3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108203; c=relaxed/simple;
	bh=RbNCtiPz5Mwa5Td8hXh/+B4DFH6mFTZx9EuRAfA3MKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkiLffFdP7VenYl221EyvuJduOsbNcep1ivAFaKKdoJZYVP+HBmBpDpBpjTSwWvayrqllOPDsXe596WBqAdrEJC3namVgqDdJsPXSXl15d5GAdo2XOINliO2qGPhy+DZgY0hs5hxepz9RIAKBZ0ma1jZVqdgvzpox74mkRTx6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QK4w1n/z; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47dec32798aso5363133f8f.1
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784108197; x=1784712997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RbNCtiPz5Mwa5Td8hXh/+B4DFH6mFTZx9EuRAfA3MKM=;
        b=QK4w1n/z34eIYaU8kCpl4NfzDYIb7ErMJUXiTNqLdUF0pykqJBx1el++1WZHjhOYLO
         mFoVAe0FNwAAQEVVPUNuLZkqKwCLVh1mSuF3HzNsB3ewm7XS2/HMgzno7ix6zPhFLxsP
         DDd0DUg1Yw0BiblR66jOKQ6xEKvNV9A1PxaUXl8H2BFXRYnLRhre4WVU7XI0evIkQTJ9
         +hzogwEX0nZYn4Ju1k4aD2JdqIxQgn05Zmo9SLv9sbM9fW/yM/fN9KYmBHDazIURCjZh
         E+0+4Be+X24J9InYLe7undA+EU5mzf4y8W23P1ZlEA9Nshu6fk/OO0g/1goTrZ3TLPCS
         LWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108197; x=1784712997;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbNCtiPz5Mwa5Td8hXh/+B4DFH6mFTZx9EuRAfA3MKM=;
        b=m8i/O+STEhj+NYnGx/9L7U9cwfM46eo18O0JyGtklyOQVopzI5a57sCxYXPxML7rS1
         c3hihQz6wuqbTbo1rUb7Vvj61z96UoVlI8lqUQUxegQd3Jc+YFmcmpnQwL1whHjV+QdL
         Id8Ef7w5zvYL0PJBBW3n9V+hIvZZRVL5BUYuv3YKwe51RSdfRFpo4P8lo9ZSQK5pExCV
         aO4xrwq0dQzpUcuxrVykBcoCf6PsnHsiLd2Qrat4n/GeBdmEkCpO+NsqLnxcW0ZyX1rw
         gco3Z1P9tT5KeJuB8eYKxE8GbogMsNUyOirc5OQ273DdM9l4c3swI3ys5me/jNN1yI4w
         sYCw==
X-Forwarded-Encrypted: i=1; AHgh+Rpm2eIsJLS3ZJRRcmYEtBJQNOwBScH2zqdyYMxKcU1tp+ucSkvMdX3Ks3wWxKlpIqcaJvvvkm01@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iWlj0wPmvWe+2Ti6lvELOyWEb8qtmx1lpS1R9MPbWIKY9jO4
	WndQk2tfFpYfm2zYLZ2e7iFZWtTZ4aPqHvKqsljrm9emPcnelJXN4wgu2/Mc90y6xsg=
X-Gm-Gg: AfdE7cmnQwATVeB4MSohdVCZzKboOvBRb6bsUQry5G3QpLGoXx8YtImAK9y8x+DG4oK
	oUzodUX5VsDKJG8cotMNlb3z6e+hhCgUq0Rt4vXc0Dz603xwmF6Yo+KcRZB7PGJ5TIDxLO6N1Rb
	dGpSdEZZUgJSMz7WK9eusgf+nx++8S/wbeE8Nk8L2I10YZ4Juqe913mwqG0CyCsrCaqR3YSg8LO
	3eeRc/tKjEpLwgTQHjCpFZVNk3uHN7bIo9ITAKC4Kkl42ok1N8UJgD7KsRYdvJ+QjSF/EXBR5K+
	yPa8tC9OBB2CtBrMp7J7PiI0FLuWnRfB/a6eAU2AmZNG0A11Q2CbsrfId6f0h/9NIe0NK/85S8A
	nvVSKJJxjLcXaJSKiUVpC/S82ZkKqjLUuYT05KLPJzIc3mBime4Xg8Hr6a08PakERRmWaYFUbeC
	gCmceEScKZSUe/0QjM6K4o2iLqKZn59aY0cQXFDg==
X-Received: by 2002:a05:6000:461c:b0:473:506a:e47c with SMTP id ffacd0b85a97d-47f4886399amr7394061f8f.26.1784108197277;
        Wed, 15 Jul 2026 02:36:37 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c30a9sm14495687f8f.31.2026.07.15.02.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:36:36 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:36:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: Fix intermittent
 test_cgfreezer_ptrace test failures
Message-ID: <aldSsQAboD6g2Sso@localhost.localdomain>
References: <20260715035446.565625-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ueouq2lhiett7pq"
Content-Disposition: inline
In-Reply-To: <20260715035446.565625-1-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17832-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B59C75CA23


--5ueouq2lhiett7pq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: Fix intermittent
 test_cgfreezer_ptrace test failures
MIME-Version: 1.0

Hi.

On Tue, Jul 14, 2026 at 11:54:46PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> It is found that the test_cgfreezer_ptrace test of test_freezer can
> intermittently fail on some architectures like arm64 and ppc64.
>=20
> After further tracing of the mechanics of the test_cgfreezer_ptrace test,
> it is found that the ptrace(PTRACE_DETACH) call will spawn another process
> to perform the detach=20

I'm reading kernel/ptrace.c and cannot find a new task creation.
I'm curious what is this "another process"?

(Or is it referring to the child_fn() process from
test_cgfreezer_ptrace()? Then I'm suspicous about the transitional
unfreezing of it after PTRACE_DETACH. Wasn't it rightful expectation of
the test that the cgroup remains contiguously frozen?)

> by temporarily unfreezes the cgroup and then freezes
> it again afterward during the detaching process. The reading of the
> frozen flag from cgroup.events is done by the main test_freezer process
> running probably on a different CPU. As a result, racing is possible and
> the intermediate unfrozen state can be read leading to occasional test
> failures especially on architectures with a weak memory model like arm64.

What state would the task be in during this window?

Thanks,
Michal

--5ueouq2lhiett7pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaldUnRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgBiAEAtibykYvZC+3Kxm/NzjT1
GszMpvkJPqiA7qKlwDnJvMMA/09aHmm6drkw1dia2aCU7YAPAnNa8o0FUlrsoBBC
gs8E
=tW7/
-----END PGP SIGNATURE-----

--5ueouq2lhiett7pq--

