Return-Path: <cgroups+bounces-17340-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L/CMMdOnPmoFJwkAu9opvQ
	(envelope-from <cgroups+bounces-17340-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:24:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997F6CEFE7
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:24:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=fGPDYMfL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17340-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17340-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3CA3302AF5D
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601363F9F2D;
	Fri, 26 Jun 2026 16:24:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C13F99E5
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 16:24:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491086; cv=none; b=bP7AhtuaLogj5mWPJ8NsVjQlLoFgevPsIHBj1pCnTRBm64aEVhQ9A9EaMscY5aQDM0QYkfUCHcWsOd9yeIZ9flP6oALBGiKUHvcrmgipCC4SOG9+KldFKeqXVJxEzoLIydT9eqmnbVq3SZNdnPvtuAKwPn+YPS4AWhiTpKBAu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491086; c=relaxed/simple;
	bh=ZDpTKXUJtSOCn0iOJVPzDGA8hH0ROrYolCqzrG/2UN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7qhdRIrjx+MLUXeawbt6Fg+GLeGVPHH+ECcwfC48mkox2PbPUZvcIETQj8lUMaCFfDdV/6cnxbV28/X4wIBpNPo0LXzr7/5hb4SB5A+Ow2GhVs0Ndt0X1Rc+LJ8vpKP5JYeeZLxdhITyI7TbJgjPe7o0Rekw+uwDqHJLCePjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fGPDYMfL; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c0bce8840b6so116110066b.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782491083; x=1783095883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzLgbGGQbfhbvqh4cQgksDurGIAgQkr1YelLIUbVC08=;
        b=fGPDYMfL1bzfulPPFs02OXkeK34Wlo1+I1jEZUOk5RndOXBGGc+4vTo9H/6RPPs8PT
         sNANVZWHb8xK2S4+TAX2c1bnnRpf62IvNLXrXvpRcxEdpEgPvDvmVY61K7MaB/Do9+FN
         LKuFtGCgHu5/ckRSNaohDqElBmUyHv5rUXLctjE6EChd4rgY+NHHUnL2ApSmNP39pHlK
         MrL2t8B2kPS1PujnMjr8UIEr1wZ9z5LGtnkCIusItvsPZY8pylHM2w0RfGWQz+P+16Td
         f0X4kWPvrAPdmdNkQUzkukdphK4ByrpR/yftwMfPRICIzjl4y5WtFMsGPuYI3LJm9Ctb
         3RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491083; x=1783095883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzLgbGGQbfhbvqh4cQgksDurGIAgQkr1YelLIUbVC08=;
        b=E6ulj3T4+mK3Vw4HB2OTzf2obbuhZCUSiHNmKwUDRsab0SN6KGaCk8Pgwz4S9pJAyC
         jYkMTS5HxKfqxUmdRYnTpqNqi+SFub2RMVGxZz+eKSXZBU1VI5xX8+wHe6Ed7yLIFGxx
         /UIgTM1ZvjSKtrvFTej8YXE+3pk87xUOU35t9gmCqilY24PZJVAjbn3SCiSXVkbaVDcW
         lzvNk+Z6hq/5c7FSJOkT3R71XlRoplJWsfXMZB7X9oTwc1EAxCxLvvkltQtp6M3y+mqB
         Itfq450yhcv657/BYBZwNY9u4p0nituyOiDXFrqanyO+X+0N2VQRouXHdy/TQh6Ks8Tz
         InnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVltVjzFs56ZL9fJEXvtpSVKpm57qVPjbKXG/OK0Gz4yRNVypOfV0gkoS9H5CPGarahapEhiOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1I0SxlaSRKo6/gg+ZdpNdDpkyuhSckRIe1vAvDeUd7hnIMba8
	boX93UfHoBBzOL/hTZ/EXVIWi2z7eHDzJCTU+e1xLJ6LDCmV98HxDXkXxweNnO5XvVw7dRLOInz
	UgKWe5+w=
X-Gm-Gg: AfdE7ckqy1+l+Kb5l4PZpUUKP+hs4fKVj1LV5l41eBdavQSF8KhSjOVWL5A8cIz7hwa
	b+ubkT+a2sNUKUkyxNOdA+Evd9rGZYZpGUCSMcoiFNEG3q+Mv/AbBMTEDoyiZwcStWiXUU8SELD
	hmXVqrTsdYnbSOxFnIfWmdzH4rXXl2j4774Y5mj4ojaJaX4HlO1i70uGzLPOsVKfvbi0TInIXwf
	4wz/7xQAqylVgm6TJRMcU+x0VoyvAh5skStda7c1BDWBJV8RWQUyEoBHWwpodFcKell+UjPLJNz
	3YX1t3j6jlO1gCrsW/XxHuyxxgj0xn8CWA28jTGwFVVVFRRRwfQBLIpSlnUv3KbdxORzGqrfF0W
	GGvgmVgqFWGj3Bib9lvxkID+AhCdt4xjOWyA/eSt10hTZtfRE+6KkixpqkL3qWUYl40SDoBcVr0
	UbT90TkgAmbDR0UaKcEA==
X-Received: by 2002:a17:907:9308:b0:c08:713e:d8b2 with SMTP id a640c23a62f3a-c1205eb8b71mr494966966b.25.1782491083080;
        Fri, 26 Jun 2026 09:24:43 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbaa46asm365418766b.10.2026.06.26.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:24:42 -0700 (PDT)
Date: Fri, 26 Jun 2026 18:24:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cui.tao@linux.dev, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpu: document cpu.stat.local
Message-ID: <aj6PQPz4IDoVTnPL@localhost.localdomain>
References: <d9ada3a3-6978-4602-a11d-689e0fa4171a@linux.dev>
 <20260626010914.1154495-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opqipnw7zmxxqkyc"
Content-Disposition: inline
In-Reply-To: <20260626010914.1154495-1-sunshaojie@kylinos.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17340-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS(0.00)[m:sunshaojie@kylinos.cn,m:cui.tao@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,localhost.localdomain:mid,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5997F6CEFE7


--opqipnw7zmxxqkyc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup/cpu: document cpu.stat.local
MIME-Version: 1.0

Hi.

On Fri, Jun 26, 2026 at 09:09:14AM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
> +  cpu.stat.local
> +	A read-only flat-keyed file.
> +	This file exists whether the controller is enabled or not.
> +
> +	It reports the following stat when the controller is enabled:
> +
> +	- throttled_usec
> +
> +	Unlike the ``throttled_usec`` reported by ``cpu.stat`` which
> +	accounts for throttling caused by this cgroup's own CFS
> +	bandwidth limit, ``cpu.stat.local`` reports the actual
> +	throttling time incurred by this cgroup's own runqueues,
> +	which may include throttling inherited from ancestor
> +	cgroup bandwidth limits.
> +
> +	When the controller is not enabled, this stat is not reported.

I like that you contrast this to regular cpu.stat and implicitly explain
that cpu.stat is not hierarchical.
Here I think it's been such so long that it's not worth changing (also
it's less useful than existing metrics for diagnostics).
Hence would you also update the cpu.stat paragraph about the
non-hierarchical values?

Thanks,
Michal

--opqipnw7zmxxqkyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaj6nwxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhFgAD/XEcVugLyyou/TK3tUc5F
ZkEPGtRFL0h0sCS/DI9icUkBAJ6LorKFQRUDq3uwRK3WH0mlxofp3zGNicQgdouy
18kK
=iDl8
-----END PGP SIGNATURE-----

--opqipnw7zmxxqkyc--

