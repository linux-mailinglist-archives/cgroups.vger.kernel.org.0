Return-Path: <cgroups+bounces-14148-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH0NBPJ2nGmwHwQAu9opvQ
	(envelope-from <cgroups+bounces-14148-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:49:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A275617908B
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DD69303E68F
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52185304BDF;
	Mon, 23 Feb 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/oOi0Rq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAE3016E1
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861637; cv=none; b=rCnF5P+uEk+CJuGq+hU8eyXQDkXCupA/Ngp4RsgUgB7pld/7aZMlMvYeDx2MXlXp0TeEsnu+sZhZwVS/qAG1zS5OZ3FEn+noPrGGmivJc3ayggm/bE2nq09/f3QzVuT5e6MDxVot+xjylZL7MJoVF9JWgTbUepLU7KWw3eCWMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861637; c=relaxed/simple;
	bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klcm1S9OJKcOo9TkLT3ozW6sIPJWj0AukHg1yX83sz45wqvd9iQml2HdxTwXBOXsVAiZmBeNCaq8PXlrMJ8Bop4QL8WZQ3v5W7hiDL1/4ABdrcptajdFDbxg1XIc42sJpNRxprSRxk/hMYdCm11+8jtww8b9NY/pBS4Cg2rB3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/oOi0Rq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4834826e555so43565165e9.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771861633; x=1772466433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
        b=g/oOi0RqoAlO3Z46H3kTAU97REQETAqZMSHBBPNZGCyxrWXXX3JW4R1xlP8mnkftAT
         b1Pj1IIU/TpoxpKumpDuDGc+o8DygE9ULAGQ8Zba3J8+mLqgsox9+KG3AsZ6IqedG8Mf
         qEB3CUIMZuWmsdOK3ihGFi3+vFA/4E5P0DW56QktJp3PdEWVCdorrts1zHoHGGHawVpr
         kgUFM8zY+oXqwJJt9PzHhA/obyYcMlgdzwjWI4Zheimwoq07FaUahA2NSqeuBkte4nOL
         tIbhVGdh8o/72L6AeS/rJzTZaR4B9mY3VZaYScL09lXLG/UD7BCbCJmwo4NBJKqS/HXm
         Bz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861633; x=1772466433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
        b=GtSd/yZRxOzME2bM9GJeV4HNsHlYRRRJYL/l81UMlvvMwZHpTOTFJkOZHwm1bFHDJF
         D66wyZAyw7s98tkoRQlGKr5oYt6OLmJiHUd9zLw6oU7KU4nJIb5XsEioLQhZ3QHXr8E4
         gFMRTuMpoAci0LStGSxCQt47LhYRSh5UrfGduPW6wxLWdrGARsfsPcSU/Mrau/FZzTcJ
         ZagHZx1r8gAaVmVwyyW3DVu+VDduYg1hJxvdrpj5wSDjilmcckGUIk5q9MHaEmctfLSO
         vKQoAjDDb6+KofoqNNcU4K/kuE972gMWu6UeRewOAMq9e37IK/P1iOJxh0qlj3LQLG5H
         oICw==
X-Forwarded-Encrypted: i=1; AJvYcCVBLrbiUFEMezmT0lB+qMMESEXT6b3Wo0VeS5nvVCWIC33Dnqi6XwImc7Gy3tQdMXXfeUQ5eTNc@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjqJG7D7hM8scs8d3WGAYUwBHuqRpBc6WO6diCjFvqCLBYvBj
	OSDDA9nTGHRpsl6OCj22zN9uvmeM34lkVAzz/pRYP8oUzPMI4RnFePHBKXY9SxeRC38=
X-Gm-Gg: AZuq6aImAxJBclLmWDQgafjCaOW32bcuT7sanZdHysTxHfR05MXlHQb/RfviCRnpqrk
	qWyQjqWW5Azem/VE8ZA5ctbuj7jIQUTRfCgAIzYS3ny5dsdXY3u0yTY7ehwQHoGATUAlRnIHfEi
	mOpMdcK+nKsP2aT2lZQl3aA0nSXlHaAE/VmefkAHnWGZkEaLXMoNI2TqEqmIYtS+xeXHXSwhMNW
	badG9Bq3NIugqzxZ7527iGM0ckmYmk7YuutZ8F4Bog3teD3MygVBPYCWvFdeFUKjqq8/K0VKZIH
	keEaLDa1j1VcFpy6OVmqJ9X8lm42NHyium0/68vqA5AMUr+v7O0oaqwM6kQXoGi3QKJS0R2hyIc
	vXaQyffDF2QBvdmE94YqD03OCUWBLroDQxI4acaM6rhgbuGNjgXYAzELpe38zMdoCBRQfCy5ck+
	Zrt+YOwK1ZFFM2PsM32s/UKuvaH8S0bL2JVXk4lA2vkDg=
X-Received: by 2002:a05:600c:3150:b0:483:b3d7:2e87 with SMTP id 5b1f17b1804b1-483b3d72f25mr43253175e9.10.1771861633331;
        Mon, 23 Feb 2026 07:47:13 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm223479215e9.13.2026.02.23.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:47:12 -0800 (PST)
Date: Mon, 23 Feb 2026 16:47:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
Message-ID: <tmihfspwvvxv6sle27br4dgsbvepacnqj74zfscndkz722ssby@244dku2izea7>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ticusy7dzjxckmp"
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14148-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A275617908B
X-Rspamd-Action: no action


--6ticusy7dzjxckmp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
MIME-Version: 1.0

Hi.

On Fri, Feb 20, 2026 at 01:38:30AM +0100, Christian Brauner <brauner@kernel=
=2Eorg> wrote:
> Add a hook to manage attaching tasks to cgroup. I'm in the process of
> adding various "universal truth" bpf programs to systemd that will make
> use of this.
>=20
> This has been a long-standing request (cf. [1] and [2]). It will allow us=
 to
> enforce cgroup migrations and ensure that services can never escape their
> cgroups. This is just one of many use-cases.
>=20
> Link: https://github.com/systemd/systemd/issues/6356 [1]
> Link: https://github.com/systemd/systemd/issues/22874 [2]

These two issues are misconfigured/misunderstood PAM configs. I don't
think those warrant introduction of another permissions mechanism,
furthermore they're relatively old and I estimate many of such configs
must have been fixed in the course of time.

As for services escaping their cgroups -- they needn't run as root, do
they? And if you seek a mechanism how to prevent even root from
migrations, there are cgroupnses for that. (BTW what would prevent a
root detaching/disabling these hook progs anyway?)

I think that the cgroup file permissions are sufficient for many use
cases and this BPF hook is too tempting in unnecessary cases (like
masking other issues).
Could you please expand more about some other reasonable use cases not
covered by those?

(BTW I notice there's already a very similar BPF hook in sched_ext's
cgroup_prep_move. It'd be nicer to have only one generic approach to
these checks.)

Regards,
Michal

--6ticusy7dzjxckmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaZx2exsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhAeAEA8Aq7m0kUaH8/11aeQCi2
Kcf9qiMNA7emVmbHom+CgsIA/ArQMUoO726+PLAGwdRfAUfSOtGMOCgl3iEeMphP
OqYP
=fksS
-----END PGP SIGNATURE-----

--6ticusy7dzjxckmp--

