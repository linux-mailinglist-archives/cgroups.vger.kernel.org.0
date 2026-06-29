Return-Path: <cgroups+bounces-17373-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a00+Fjd4Qmry7wkAu9opvQ
	(envelope-from <cgroups+bounces-17373-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:50:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67836DB8C5
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:50:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="WmpGh/m/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17373-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17373-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB1B830391E7
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9D331213;
	Mon, 29 Jun 2026 13:50:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACF2E1C7C
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 13:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741006; cv=none; b=tkr889dselN3qp8LIA2NG3Wh8iWyOC6ieZY1iW+I6LR1enxy6Eo/OAX94IRwSoO+DRDCv1vt0W84E8CwaMVKaswvGDPXMdD3QvjwyzwzoIDtXTc9UjKmhWddH3JqGGKfZL8HW6gz+5Jg9NX9RsO+HxkWC3pohkH/gUzh6PgBRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741006; c=relaxed/simple;
	bh=oZQ+GwMytrTPHNJ1MesQiy5LlutyAVV/lnrR2pnvp7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioh4vkLq8Yn4fnJvED421e0LG16LKrJtbtC4AAz84uZb9og85b/UmsI/PLjyvsIJ/XS7VqMeTDDDaofUBY+8GzRv/TFaOtiog4FKvRv5H3IckslhWm1uwxRv5aG4EbGHCawuAZIOj4TC5qbSQMWoHiqiq2KeaNDDI6s3uq6KuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmpGh/m/; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4924593f45dso43923955e9.1
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782741003; x=1783345803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAT8dl0QuouSJVL6hKIvFeb/VtDClMwNys/m3MOu4Hs=;
        b=WmpGh/m/qlu1CzaUnZjq5H4aJopLqJVftF01coZtKb91KHpquSR9y4pf+1GUUEizU+
         cV39FGgKF4xRCga8XyDpP6PjWzdaVOKpCpLQsphvOqhmTblcKp7h+ZnOIx8uH3naUJpe
         cOqe4dM2LKEMBANMa/LEUcYHytlVG6sBA3/d9K74YHqjP9n64bZNcnfnw3DRbnIgnLRo
         qPcu2LB2Y3oivPk5xWejkc5l9s/ERoackKSebA+kmp3oZSah5ruH4stLT0glQ4X0WqBY
         ZtagAiwkMG4eOUPfhubuUxxgOXzMLX0h8G+Gn/i2Pp+3EecfAVvQtIDv1RErj/ms0C+L
         7nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741003; x=1783345803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAT8dl0QuouSJVL6hKIvFeb/VtDClMwNys/m3MOu4Hs=;
        b=HxjJNOebpnJ+RIuGarnzlqT1CAzWGJ6KFHPDg17ccoj0IRUb4XnKr3syC2thWLyUXQ
         vb2KFjo+3YYmUiaKDkq2wUH2SbimS7oWk+3dW8b65Nyr6otpjYzr59YOHg6TE3z4kOr1
         rWis+CdztjfITZh5mUlWbOKVp1N/UwjdIqMThI5GPtDl3lZr/83RQVfS1vAxKZL2waoL
         GcmKpbcz9MPaFz/euW817cOx86sS8CZ0OzyngXzagwREbQ82aSySee7cMmQ5DEfE4Hdy
         BhAJSR1IV/fm7dhYjSNMOIKbDtuyi4fIbtS6rnAhGZIF+wS901u8/Lnhx7hITlGykaNB
         hD/A==
X-Gm-Message-State: AOJu0YzndwmmIiAV7nenmnVQMaoTyuKFlYtMTc068DoPyHnzYQAS7vwq
	0boCwEbceyuB3FU/RXyjrCLtfjBi9gsBLMhc1n51i6E0yolzCnj3Q7XvPxgtxJ0cAVor9izmTEC
	v5vvfsJU=
X-Gm-Gg: AfdE7cnz3/fwYgWG/+i9kvL4LG+f/Kf7daoOjehjy5amqWqr1hXtZwURb9dN0vGqqNc
	GLUz7Yt0Ovg9r6uzR0G1Q8jGwov1yWoSvF5blVcNd6frQy3rSDHHC2sHOGEzmDcALul03ozrfT8
	k1sLGI+4PKa712oHnraAUMmZC7o2T7qy4LmpX5oCXAmtX4bRXiuH+o/5EbGOp0S6zZU4Z/IbFN/
	RI5B1ahnSi7Qi5mzaRsPmJzFdCOoHf4ocgJI9596E4JNXnhK2/OrX3GGYuQx++4sM5SaBtP2/G0
	3szfjsDKV15+E9Qg3FoPNf4k0O7fPJw1U0JgqhPUQdNOT1ny/AkigGo0GyWcjnexY4ye0SJZIpo
	SIRevTXpuHHdV01GwuVz9tiepbwkCiUORlsEbsOVrI8/uiNS0gX/c7BCE/qs8NRgSwXTOfusw4Q
	4WjBplspC17YBzTcyYLU19jisF3U+f
X-Received: by 2002:a05:600c:4f8f:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-492668561cdmr258645505e9.13.1782741001997;
        Mon, 29 Jun 2026 06:50:01 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071e49sm323349855e9.10.2026.06.29.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:50:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 15:49:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, corbet@lwn.net, cui.tao@linux.dev, 
	hannes@cmpxchg.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, tj@kernel.org
Subject: Re: [PATCH v3] cgroup/cpu: document cpu.stat.local and clarify
 cpu.stat behavior
Message-ID: <akJ37sqf6nOTW9hW@localhost.localdomain>
References: <aj6PQPz4IDoVTnPL@localhost.localdomain>
 <20260629060636.200118-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hahg446l5ehwp2pu"
Content-Disposition: inline
In-Reply-To: <20260629060636.200118-1-sunshaojie@kylinos.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17373-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS(0.00)[m:sunshaojie@kylinos.cn,m:cgroups@vger.kernel.org,m:corbet@lwn.net,m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:tj@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C67836DB8C5


--hahg446l5ehwp2pu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/cpu: document cpu.stat.local and clarify
 cpu.stat behavior
MIME-Version: 1.0

On Mon, Jun 29, 2026 at 02:06:36PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> Add documentation for the cpu.stat.local interface file, which reports
> the throttled_usec stat -- the actual throttling time incurred by the
> cgroup's own runqueues, which may include throttling inherited from
> ancestor cgroup bandwidth limits. Unlike cpu.stat's throttled_usec
> which only accounts for throttling caused by the cgroup's own CFS
> bandwidth limit.
>=20
> When the controller is not enabled, the stat is not reported.
>=20
> Also clarify cpu.stat descriptions: note that the three base CPU usage
> stats (usage_usec, user_usec, system_usec) include descendant cgroups,
> and that the five CFS bandwidth stats are non-hierarchical -- they only
> account for throttling caused by the cgroup's own bandwidth limit.
>=20
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
> Changes in v3:
> - Clarify that the three base CPU usage stats include descendant
>   cgroups.
> - Add a note explaining that the five CFS bandwidth stats are
>   non-hierarchical.
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

Thanks!

--hahg446l5ehwp2pu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCakJ4AxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgkVwEAlNPhk0y07Lvgta96yMTx
CLPWHx/DdRQqT7zBtXFBPlMBAMnF/6AANVrGAHXQGdGxQWg6nqe2FYZ38zgQ+Kf4
jOsF
=6Q2U
-----END PGP SIGNATURE-----

--hahg446l5ehwp2pu--

