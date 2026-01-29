Return-Path: <cgroups+bounces-13507-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNlRBAUne2nXBgIAu9opvQ
	(envelope-from <cgroups+bounces-13507-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 10:23:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64AAE175
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9732C30157F1
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96F37F756;
	Thu, 29 Jan 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cKvxPK4F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C837754A
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678592; cv=none; b=J8JtJFB315oLIyJqxCq2o/Uhba/dt7q5/PQhOLv4raQWjToEHr68ITcHBLCLKFkwhETUfIahNz+gPDczMZ38TSlkSB5K8aMJLvsaJx6xW5+Wr9pSTuOhasKM8CZ4RYiGFjat6YZn7yI6HOBcQqk0asFKUQkgjF6WaWc2n0evlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678592; c=relaxed/simple;
	bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXgkc6jJFSLs+/3fFIvFiHJnvaHJy7dTW1Xp7FwBZEv1eHMYBLT7Jq3wIwRAHvI1tYCqB0BUMRq96oUs5c0ohyge856FVnWTXwVyE1Smc1oFgY2VSe21xMkG84hMoCz0W/FwjgfqMknKA3luGRVuuvaVa8ElrcBqRf0QFnYx46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cKvxPK4F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so5766105e9.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 01:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769678589; x=1770283389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
        b=cKvxPK4FDF8GKRCcvzgSA6qomlDhEgTNwp/e0OQQwTzwAkyp/JQ2W51GWAnH1tYhpO
         MVNcJtCB8arPeYhWREK1NNGngG2rSFl3eFrzTOc4hCCvybuVMjQYj7gsR3ChPBDGQOjo
         AN12Tx0QoD4Ut37+9kYosMHAVjKMsfso6OEbbxFD4fa1xMELzw1hwAEMsOxCIsnlY5Fd
         tkihPH4mFcjhoQcPAF/F63EZFSLiw1XSqYUIgkvjAC50lO0T2V3sNSUlu3pBmudXI0dI
         hBLD37ommN/NmnJVwHFVmyy8IORh16frKSseIP13ugRGTe0QDn02xL8U+cTVgoW9+qfx
         RCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769678589; x=1770283389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
        b=i1YRLAeghmf+7Kxt8BdYF0VextwWiQNbsdiARTUSPm2IhqQ0uRRCeX2C9KkG0xEmJq
         gZvNP7MC3Mj1G27WBYK7/hGv3Lo5haYJApQE9hWM/Ta7/QDF1UJjyldyf60IVaRLKp58
         0YF0d08GwV9zWA3opW2gXe9c6gwQroLSU2L3mSX/HNDxEILkvnzOl5Idx/DmUDdJyuj2
         dY0VV1kt29sUdZffgone9HcBvBulcA3orUp0V7Ya0tWa6GTIRdKT6YBsMbWVTxxjeiTX
         zKQ27eEzo45cn/yG6TlY7fEsk0jqUrp2/inQb0mTlY9vZK2PFqzCxLHHYj53LY1xAW/n
         SfXw==
X-Forwarded-Encrypted: i=1; AJvYcCVE1bnYOx42GpTifMTyTqLA0Vw7DXkS7Jo/QmNvjdDFOwdezNKSJ1LLNtHJtk+Btdo4Qh3LSrsp@vger.kernel.org
X-Gm-Message-State: AOJu0YwHF6MccCfEF4QJ0I1uCQXYI+um7mgoZNwk2XObxywDhJAzKvLW
	3D9nW0fTTM8VMY8YWQKBv+oAyugNaQjmWDGghD7ZD82SayWih1jMoUSUhI45Nw2qamA=
X-Gm-Gg: AZuq6aLaE8wjQLE2NicjEvedYOoP9k0qCvmZm2X5SIcy0ACcwyD+0gPVpw3a8ILClEB
	1DUkZW2YyB7GgDqkWSFzK/u7CrxvxuOHXaJz+G3mz7BCJhhfCaZboFKIAahRAtfPMAK+XKuDWiy
	cMrNoEPfV4I4MZ2DzykCDeS4a74zJRiD9DRMFFqQrdZoYywfhDRR5gTfjezgmvQFo9C9tru0fo7
	B0J4qH6fcxQIjUIKYhxig+Vdfv7E4dMpZp+t8ccuo75Gy6EqwD6WW+HPOQEPnn3uruPfJ6qawIV
	IURC5BfrEWAHsJnkKlXHe/TRrJaosFxj3sRS5oFB3Xn/bXlKcVCAhIIfnBaM2jIc6M9aXyykhc4
	N2nM0SBxL1O4NmRLUZSG9pGLZro76xCMgpwsFkAak5q1YT7yaKFx6NV8n0+W6BYVfoW6S8IKpis
	1vojlCw4f0EeHbOUwTNB+9P2MeaP7qlcM=
X-Received: by 2002:a05:600c:1d16:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-48069c9ec08mr116607785e9.35.1769678589240;
        Thu, 29 Jan 2026 01:23:09 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm118657505e9.3.2026.01.29.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 01:23:08 -0800 (PST)
Date: Thu, 29 Jan 2026 10:23:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
Message-ID: <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6fk4azqrf6lix7c"
Content-Disposition: inline
In-Reply-To: <20260129063133.209874-1-chenridong@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13507-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 9B64AAE175
X-Rspamd-Action: no action


--t6fk4azqrf6lix7c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The current cgroup subsystem limit of 16 is insufficient, as the number of
> subsystems has already reached this maximum.

Indeed. But some of them are legacy (and some novel). Do you really need
one kernel image with every subsys config enabled?

> Attempting to add new subsystems beyond this limit results in boot
> failures.

That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
during build for you. Is the macro broken?

> This patch increases the maximum number of supported cgroup subsystems fr=
om
> 16 to 32, providing adequate headroom for future subsystem additions.

It may be needed one day but I'd suggest binding this change with
introduction of actual new controller.


(As we have some CONFIG_*_V1 options that default to N, I'm thinking
about switching config's default to N as well (like:
CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
pinnacle of freshness :-/)


Thanks,
Michal

--t6fk4azqrf6lix7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXsm2xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgrCwEA64lWaPMJqVPfz3lW0yM8
oLTj7UBAylF/bNzMNZhWzNYA/0gnAST31yIA8yujaEqUnPi4bptZCIayMmkgaupI
BPcL
=GgdH
-----END PGP SIGNATURE-----

--t6fk4azqrf6lix7c--

