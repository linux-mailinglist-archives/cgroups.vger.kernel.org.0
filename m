Return-Path: <cgroups+bounces-14767-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPUTDhyssWmzEQAAu9opvQ
	(envelope-from <cgroups+bounces-14767-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 18:53:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F21126846A
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4538D3067407
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8693644DD;
	Wed, 11 Mar 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tg25/I+Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4E2DCF7D
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251609; cv=none; b=KRTcWSUKhQ7Cql2VR2wZiNORq1iN7O9qEmuo074KNopDmjYZwbxMwPNGhWv/I58c26qME8p8r++bRzxy0dahymZvtd845RtqhMUNu9VC6jtqubJT7VFTu/x6p8nWd+gjCXUpPBj44bU5BLcZDpunt4ymKfkmZB8GpdsBgPZLT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251609; c=relaxed/simple;
	bh=5C/GHCkx7PfExstI0Zdlb9KDTCHEgIUHVzYux1yEnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTQg3MlFduK+DKOUJkLnPtj6gMzb9LDLsLjt+8QyFtK1Owo5Ic3vDTY2FjOR/3AI4rwu68REGEDdqp+8d+EB3C7Iz1uQ81kd/BTB9dXXEwYDi8BXuJyrS1g7qR267eyYaIaLjxGJ7C7DOyakkMPjJee6IGpHjvwGMvxmvd1UiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tg25/I+Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c4bde55cso110654f8f.1
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773251606; x=1773856406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5C/GHCkx7PfExstI0Zdlb9KDTCHEgIUHVzYux1yEnro=;
        b=Tg25/I+Yue97o52CdzD2nIx04FiW9HwTFkY5+A1sVlxBrXKC5l526soVuGmn5VBc/x
         54/z1ZNGGm3AqQqPEUY4w1qpU115e8VIyzXedqSDPX08DOaN21ludldMjVMvecs+U5wm
         XLb8m5GLEuEpDF+hZP2iUSr+jDaL5V6HoZG8Ik2zXEm29bHs9FN1aLM2Gjk6n5rG3Hsr
         ju8MD9OWrWuNM9JfoXQKvmFRmdwAvpb6rT8ll+b6GG7bd8vfx3h0SVHjFwwt+/WxfIB3
         zbmAn8v9iGfRJ08S3m5uypwFUU/b7Qw0498Sr5WnvAETy164lBi+SzPVhW7Gs0IWUIF0
         FYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251606; x=1773856406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C/GHCkx7PfExstI0Zdlb9KDTCHEgIUHVzYux1yEnro=;
        b=oZafiK64F0ifvoVezw9KuXZO10Ov5t1r+B1e9v9KCRqjcE1IeOBT0vBoQmZ9Bwtijh
         AE8yKQCF2Zg7t/CTWUubY7MZ9c/vR9o0/oQJqcsIBv+NE/yESCvJ1iapR0YT/VsvARsH
         XGQt9KTPevY0GtZg1sAQk3RtIx/SyiOSqwHcQEkhNQ5WSkf35gRFk8u+Y56HIDRwQgmC
         IvItDl0UHeOgUTEaKnW7v+s/J6B8L4gKjgrrOMnVrGdxMDTRAIyjLbfssi5R5zHPHPiZ
         Ib4Ew7VNSZ5afxMYgjmd8P2b0OVgDxsmSNlSo8jGTOTXIx5hJCjTuHF40q83BrEczFWc
         UrwA==
X-Forwarded-Encrypted: i=1; AJvYcCUlH7haqeLoC+8IhoFA62qfYwwa3SsGoj1rueJcT5JKQTvP/N0EiYDjxO7JDn6VvpqEGvVYyqEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90RBrDr54oUoDPmi2Jo8T8roudkCQHJuL0XnNCCKu7QyRU0fT
	1JWW8Yj7lUS71Lw+lB6KGSCoHbdcvHOC3QX/CSz4SdfbgatwZh2m+uBEAj8y6YWazAc=
X-Gm-Gg: ATEYQzzrd+iATTZOILxFQAAYNqYn7wkTpUlErxdBmOO59Vljk8qOAsJzXLMq8XiXaMl
	XeHZDI+t39sGoq2s8Kv8N4chsuoc3xEK70ojZMAiilKYlIhIrxVSvj5z/sYXxGHKG0ljGDJ0ePE
	8x9CgImCDuVlznx8d7V9ujTz3r23dJecQvpMl0p2raXuKGDucvhuxzXt+DDq95fEIm5XGjG3b59
	WpfPR+Or7lvjs3NHXWpXks7/FDEOvAmOMoA2eY2BoyumeXcAQBSVg6eJKS1ATh68IU8JkKdQJ12
	MLJOWPovCsHLVxYqtoD9uL71KDKfwulQtcvzTpwE4QBnhOjHXhe0ZAvJI3rkLWfkvqWgtC6Q+py
	lFuwtbbpnBxYgeipfTom/MokTUNclsFrqxCM7HTi94HWkNFRRQdIkmMiq3OT3xIJ+cGe8jHpVlT
	9tbdukZk/rKbcC13fcXxjolDzxp7NeH8pJYOq2Mfhk+jM=
X-Received: by 2002:a05:6000:400a:b0:439:8f32:8674 with SMTP id ffacd0b85a97d-439f8440784mr6381591f8f.53.1773251605922;
        Wed, 11 Mar 2026 10:53:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm775236f8f.21.2026.03.11.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:53:25 -0700 (PDT)
Date: Wed, 11 Mar 2026 18:53:23 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <qtws2f6xpnkrg2kab6mdu6ipfuaect5atsfs3hlkcn6vgun4tl@kavlcfn2vta5>
References: <20260122112951.1854124-1-mjguzik@gmail.com>
 <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
 <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
 <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
 <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com>
 <eu7erwjzoflxb7wzm7j3iitrwjoukajixasel2s3isfav4i3rv@ko2c2dtmnj2l>
 <CAGudoHFBN1seqAb3_=Ja+9jXP3EDjfkGfvGT6eqSBhB5_mrBWg@mail.gmail.com>
 <CAGudoHFYCY4m0r6RPTFCgFC4xPp_h3yvk6=xaX1MudoLcCi7-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gotto3dzlwfqy4jw"
Content-Disposition: inline
In-Reply-To: <CAGudoHFYCY4m0r6RPTFCgFC4xPp_h3yvk6=xaX1MudoLcCi7-Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14767-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 8F21126846A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--gotto3dzlwfqy4jw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

On Wed, Mar 11, 2026 at 03:41:56PM +0100, Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> So I booted up a vm with 80 hw threads and the cgroup lock is still
> top of the profile for me when rolling with ./threadspawn1_processes
> -t 80
>=20
> While I prefer my patch on the grounds it reduces overhead to begin
> with (fewer locking trips), I wont argue against yours. My primary
> goal here is to get cgroups out of the way.

I filed this under -- there are still other locks above css_set_lock.
Has this changed with current mainline?

Furthermore, there's still: a) css_set_lock in post_fork and b) tasklist
lock which is much harder problem.

>=20
> or to put it differently, can you either ack my patch or push yours?

Without a convincing measurement, I'd say either are making
synchronization more complex for nothing.

What contention numbers do you see before and after the patch (on what
base)?
(Sorry, I dismantled my measuring environment meanwhile (and I wouldn't
know what other non-mainline patches would I need).)

Thanks,
Michal

--gotto3dzlwfqy4jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabGsEBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhRWAD/YdGTHXyfkcH3Vo9LycRt
Oe6kMOuXODxdFilPR8TJqEMBAIpdZMKmKMrnu+/UCsUUtHBjgb6ErlPg7f3bQSnJ
y6IM
=Zlbm
-----END PGP SIGNATURE-----

--gotto3dzlwfqy4jw--

