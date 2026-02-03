Return-Path: <cgroups+bounces-13635-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNK2OhLUgWmnKQMAu9opvQ
	(envelope-from <cgroups+bounces-13635-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 11:55:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D063D7FD3
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3570E306DFE7
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AFB328623;
	Tue,  3 Feb 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VtmE+w4V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC332860C
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116087; cv=none; b=YgMUTP9O6J7bAOEYeHUn6fGvVXzZhAFYIhc8T0rzHJuoiLnEYVepQ/FELmBlsnLNvVWFWokQf91eqiTYxFaeWi+aP2e1q5PyQKDB0e1C66/eAM+8Bsu4tilzwtecYFcW92YeCTECr+wgN/8/WTmG8HvwiS3ZI74vJoJyYuYy6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116087; c=relaxed/simple;
	bh=0pdEn6J21KTzSHsLqmTTrb1qqaNoiv9imUMPnKtSpeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4qIHYlMA54VmNZSAXphK04L1c5kJ9dEbLyPsrR0uetXznh7cn2Vgd1afAObLejk8wx8dYUJmDoI3v4X5Yx/+Mflzdhit2KL9Kq+qMTp3i7pWKOKAKzy9bIacykgFEwwvD+++X0jqcNNoRn7WMknGn8J5utr7gKWQLo7qPITK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VtmE+w4V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432da746749so3117036f8f.0
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770116084; x=1770720884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPTAiMYWoGy4HuCPIOvAkAKBt9pkuD1N5ue77Vcr1hk=;
        b=VtmE+w4VZLNHqvqvdWxRbgCaMDmjdUpOYjxu+1RxVybge2TxWeLK7i70CA7aTnj7GH
         /vxx3MtWxt3GW04pNb6VMC1qGMwPbX4C2dUua7FsdB6snORpSiR2s7ssVGMIHDKTNCS9
         DdeO6lKgHzg+pfpXFkqI/o6sIWu63i/Fiypox2SCKnzPCdHLuE2laZUBHVeOTXZpxSYV
         5V4hGcNaPWNYqv3oWvfGTnClTMfEohpUy8Yh2zvfkdUowfVk+wC7sDrWSO7B6O+hus0E
         5oXCu1xvDTq/LwI5psnqVcR4/90GfDp6ETFm2De/IyUw2kNu6CJFmbeF5VZzDTSx+aiT
         AXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116084; x=1770720884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPTAiMYWoGy4HuCPIOvAkAKBt9pkuD1N5ue77Vcr1hk=;
        b=Mz754+vlIOSfdu0ouuyeEHscNkLT+EdJGIU4i0Yd3RRv2iAOpjYT647/AoNx43k329
         531uQDf6Zj0DDkuC/AwZxMmKBZ9tuIKwdwMU5dwSDxVXShDIOKsJ2kB/Md16V7hVK2GG
         2ohnK6rNmEH/iJ4w539STlHtI2MwkihD5dRH7HNQFuEq7ljSEEhg4sglpThNobsrt1cx
         5SaITf+SGf2dQsIA9UQIHC02/dTrkEETKq7FStC50490y0to5eWvtqsdx7QtvEg4hj3+
         K29pf1x7ZSsklg1DppzWicmhBriaCXFsHxyI/DjDorGYtnhTnJL+N5/Wb9GlAXJ2ZZTk
         F/2g==
X-Forwarded-Encrypted: i=1; AJvYcCXueb7qr2B3urF9IEtjbhZDgjQFen9hnvTvUceA+BoME93TtmTktavZAoqk/fQCT4Cvl9X0Aa2t@vger.kernel.org
X-Gm-Message-State: AOJu0YwClgfqpSyZmIwivvtbdDzX37cAc6GhHv/1ZIRfIyEBnLyVmnfK
	tQOM4FnMz3xDYtSUxpYzF6qJjX0ld/p4yRWZz4CxgKQz1xYFodvd1VxAd7yq1ngtzYQ=
X-Gm-Gg: AZuq6aKgSTffPaGB6WZ5omosJeql3xt4gv1p1QmZVnMC5jhlpQYYvkJgxBQLCwRZRva
	GPElYhU2IRYiIaRnezuTz/inGc/V2/kRrG1YPBfN4qNX1kiKMxGDAUNi2qii0SoIKso6f3ZWTiG
	mOA17jb8nkOJwsWz4srwh9gzuTcd/fgtdhLCS1X/R4yn5SCBjovg5miHpD9Gps5RePV3HC96ZMA
	iLyxx5m+xa33fTE03BCTd4LQr29UeB8Vu9bovv6IQW+DiQAFBjdu18SuUhKKDRRPqAcpaM6YTv5
	YHEQRuCHIcN32iCXxQ0dOv816dcMi/0XMgH/kgAUdF1Zg53bTDQy5w4+BQRZZSLwRraVUHaOQbG
	bLKBMZyG1PcH9OYojgaRd8WMnjJ2Ibzb6VL5sJw10p7yYrJdaz8rX1NE6C28FiWW3qzusfR76i0
	zd/+O5FFu6yqAQUn4viZlyu5+5s9FyLAo=
X-Received: by 2002:a05:6000:26ca:b0:435:e3c6:554d with SMTP id ffacd0b85a97d-435f3abb4e6mr23160424f8f.52.1770116083908;
        Tue, 03 Feb 2026 02:54:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm51485014f8f.36.2026.02.03.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:54:43 -0800 (PST)
Date: Tue, 3 Feb 2026 11:54:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com
Subject: Re: [RFC PATCH v3 3/5] mm: memcontrol: add interface for swap tier
 selection
Message-ID: <ixlef27mi6vm5pek775kyddai7rkzls6mjo434rvwwp5gulcp5@n3uzy35ta7me>
References: <20260131125454.3187546-1-youngjun.park@lge.com>
 <20260131125454.3187546-4-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2lpn6qjy63iilmq"
Content-Disposition: inline
In-Reply-To: <20260131125454.3187546-4-youngjun.park@lge.com>
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
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,vger.kernel.org,kvack.org,lge.com];
	TAGGED_FROM(0.00)[bounces-13635-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,lge.com:email]
X-Rspamd-Queue-Id: 8D063D7FD3
X-Rspamd-Action: no action


--u2lpn6qjy63iilmq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 3/5] mm: memcontrol: add interface for swap tier
 selection
MIME-Version: 1.0

Hi.

This is merely the API feedback.

(Feedback to the propsed form, I'm not sure whether/how this should
interact with memory.swap.max (formally cf io.weight).)

On Sat, Jan 31, 2026 at 09:54:52PM +0900, Youngjun Park <youngjun.park@lge.=
com> wrote:
> This patch integrates the swap tier infrastructure with cgroup,
> enabling the selection of specific swap devices per cgroup by
> configuring allowed swap tiers.
>=20
> The new `memory.swap.tiers` interface controls allowed swap tiers via a m=
ask.
> By default, the mask is set to include all tiers, allowing specific tiers=
 to
> be excluded or restored. Note that effective tiers are calculated separat=
ely
> using a dedicated mask to respect the cgroup hierarchy. Consequently,
> configured tiers may differ from effective ones, as they must be a subset
> of the parent's.
>=20
> Note that cgroups do not pin swap tiers. This is similar to the
> `cpuset` controller, which does not prevent CPU hotplug. This
> approach ensures flexibility by allowing tier configuration changes
> regardless of cgroup usage.
>=20
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 27 ++++++++
>  include/linux/memcontrol.h              |  3 +-
>  mm/memcontrol.c                         | 85 +++++++++++++++++++++++
>  mm/swap_state.c                         |  6 +-
>  mm/swap_tier.c                          | 89 ++++++++++++++++++++++++-
>  mm/swap_tier.h                          | 39 ++++++++++-
>  mm/swapfile.c                           |  4 ++
>  7 files changed, 246 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 7f5b59d95fce..776a908ce1b9 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1848,6 +1848,33 @@ The following nested keys are defined.
>  	Swap usage hard limit.  If a cgroup's swap usage reaches this
>  	limit, anonymous memory of the cgroup will not be swapped out.
> =20
> +  memory.swap.tiers
> +        A read-write nested-keyed file which exists on non-root

"nested-keyed" format is something else in this document's lingo, see
e.g. io.stat.

I think you wanted to make this resemble cgroup.subtree_control (which
is fine).

> +        cgroups. The default is to enable all tiers.
> +
> +        This interface allows selecting which swap tiers a cgroup can
> +        use for swapping out memory.
> +
> +        The effective tiers are inherited from the parent. Only tiers
> +        effective in the parent can be effective in the child. However,
> +        the child can explicitly disable tiers allowed by the parent.
> +
> +        When read, the file shows two lines:
> +          - The first line shows the operation string that was
> +            written to this file.
> +          - The second line shows the effective operation after
> +            merging with parent settings.

The convention (in cpuset) is to split it in two files like
memory.swap.tiers and memory.swap.tiers.effective.

> +
> +        When writing, the format is:
> +          (+/-)(TIER_NAME) (+/-)(TIER_NAME) ...
> +
> +        Valid tier names are those configured in
> +        /sys/kernel/mm/swap/tiers.
> +
> +        Each tier can be prefixed with:
> +          +    Enable this tier
> +          -    Disable this tier
> +

I believe these are only superficial adjustments not affecting the
implementation.

Thanks,
Michal

--u2lpn6qjy63iilmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYHT7RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiOUgEArOxA7KvQUyKrjkyrhpBw
jndtkluc5AzqznoK265PLMcBAPJIbhRuoYV4anAZsx5HC88458Xzsij7tu2+xXO5
sf4L
=PfDt
-----END PGP SIGNATURE-----

--u2lpn6qjy63iilmq--

