Return-Path: <cgroups+bounces-6166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C14A121DD
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1065D16B0ED
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A631E9916;
	Wed, 15 Jan 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dxo3LWYM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B717248BAF
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938890; cv=none; b=IZBYT3pqUTWvEa+CWU4QtxQEIRwdUhcflxqC1ns20SDvfyhcKN0+C8qfieEykSc3YYuIb6y5GT5vtbdUiYzDw51ggcp2T341UJUap2tn6ORvUultgn19DS/zaN37tfSId/YIoAx4xhFaSi5R1ZyH8USOB+NqFIJqHF9MAF+ICCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938890; c=relaxed/simple;
	bh=Aio+jhP07ubc0B7cWeE+XcVTaF8hSeglHWcwH6fxe8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXxYjYIWgAq3nuWyXcX8Oyeix7X2ud92UF4jC5HKhWhYPacLTu+3BJaHP95/5mTVK5v9MFm37DmSoRJHCcxbvF6n+7TOxkkWoNBJPE+afT0UZAefkI3TZWPBJi306a13yKV+Kt1mYMcF0u1l5zeUze2ttd8tz6FtIbog2kPGxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dxo3LWYM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436202dd730so46704915e9.2
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 03:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736938886; x=1737543686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/8ejqBWYNx8WTB4er9SvAtnD33eD/LwD2WFdKdmjZY=;
        b=dxo3LWYMMb1cY5ToayfzIrvgWHBCfic50igqqXGtfSJ1FlfClL05wmJqg9/c+oShyE
         KIqtHDkOz8J0n6ITTEqOHm6y6hb4SglLwilfFNLMaADW2yq9N/pziIqsdyFyfzm3Lro2
         pemK3Yh9FK3sheRGtO2DBCyFcSBldFeGiv150G4qHaPmmRmYYAI5OB36x/kLZX1FHz/S
         Sl8s9tnSFG7Hkx3dQWzte37iI5UwlgulXKLvPw9pTMngWzvQPAFsZVoPn0n02SaWPq/q
         /0Bld9KcY+96BWOA+utY1X02IhT74g150Nq8n5fpNKWNHD6h+8cRdn3auTig27J1k96d
         /NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736938886; x=1737543686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/8ejqBWYNx8WTB4er9SvAtnD33eD/LwD2WFdKdmjZY=;
        b=mi391j2GfvQQ2mW+T455qmJVlotDCsGKN+nhsmHnIPPIYWyxbU3VKRPlEAPHPDm7Ok
         SP8QonfZ0WInzX4x/kArBwXk7NjPPEyJ5G0UjbIALIFXR7Y9emV8om6yPh8pYH9yMBgu
         l9lYhOL+BIDu7sBZBLffHCzC+wGDyizMCYuhjWZXaxh3y4C9utqZoyrJXLvSLoqhET6F
         Z3kBsmTv0XJ+B4rWvduDQDkafSzonLTRvnQVI6FIo+/942L7Xmsbs9vZKv+0iNcuYgqB
         b8GmqSB0nsixJ2rHLa8Noc44mPDx6hgZG42c4Nm5T9wrh/Xujk7uH8qg1o/f/hfpcjFu
         lggg==
X-Forwarded-Encrypted: i=1; AJvYcCUNnuYPxCQ4EsjVF7C5taGw8MKp6qXKWlOIg+70kQgf8wXSxk05ZrhLdgJnuVLp4xaFyaHpJikt@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQq00OjJN4o/4hHmUwZF1XLsSjuCHqRiBxy5vv/PoY+Tc4wnP
	ReRViy+c8kq2MJRONJy/6AkzK7Zl0R+p2fwvakQ1wK/NabCbc9PH5/8jhOASjhs=
X-Gm-Gg: ASbGncsLAeO0A9+4LlH5RCZXyAkNwCVcl+GVRN3iv5UXQvCXmf7Nq2s7i5vl1iu175I
	QmxXfAm3U3nXq7gdMzP7J8CDEkIlGD3U21kBFW97Xa/yw/D6vrwrOIf3NxWvnbQbfm88vWsr3ZM
	Ce6kopYCAFQbjDZISB5AqH0x7DFnyWUhyrQpR0i7GG6exApKNb7kaR80G1gj7WJUBTBvHGkNA51
	GZcFnxDBVRZ6W61+Gxi+qRRv158GE70Lcyf1AIf8Cx1ebZTa4F+XWXA9Ww=
X-Google-Smtp-Source: AGHT+IEKpakxq6bntN0ljbJeDjIiYpvskLsbpEV1U4a23eulDVLlrmNdX0h5F2FjG2SkgsccEkjBYw==
X-Received: by 2002:a05:600c:198c:b0:435:306:e5dd with SMTP id 5b1f17b1804b1-436e26f47e0mr232141575e9.22.1736938886329;
        Wed, 15 Jan 2025 03:01:26 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d090sm17116629f8f.2.2025.01.15.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:01:26 -0800 (PST)
Date: Wed, 15 Jan 2025 12:01:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
Message-ID: <pl23stfp4qgojauntrgbfutmrstky3azcoiweddseii52vgns4@6446nbhq2zl6>
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gregbb5jw52pudnj"
Content-Disposition: inline
In-Reply-To: <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>


--gregbb5jw52pudnj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
MIME-Version: 1.0

On Wed, Jan 15, 2025 at 01:05:21PM +0800, Jin Guojie <guojie.jin@gmail.com> wrote:
> V2:
> * call fmeter_init() when writing 0 to the memory_pressure_enabled

Thanks for taking into account the feedback.

I'm still curious -- is this:
	a) a new LTP test,
	b) a new failure,
	c) an old failure, new look
or anything else?

Michal

--gregbb5jw52pudnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4eVggAKCRAt3Wney77B
SbQXAQDP2tQoy0CJUDC/ok9ua7CeJ8VMWlEw04X3KC7jtbS5SAD/d+Al14Pt3Qcm
KUDcOuflREGyTNDso3uWUptgMYXM4AM=
=mB0Q
-----END PGP SIGNATURE-----

--gregbb5jw52pudnj--

