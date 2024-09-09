Return-Path: <cgroups+bounces-4777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DB97224A
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6B91C21EC2
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5418990E;
	Mon,  9 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjRqqasi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6131898E0
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908600; cv=none; b=ReDcAALCnYvxVLoY2ZOe3RqYK4yi5hk8cxbx2xkdrkFVRNS2MMi4AA0HYXyzre3j2sNt27UZmRCGROgrQMyfXg3ONNhBu/KuvoSIZIzCtA1WZOH+ujTRO1jSTdiXOvXDXK4vgO0A2chMbOhU5TRFJm/FD0//1arA315kj9m8ieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908600; c=relaxed/simple;
	bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXlVptuKIe9I+bp0TDsbm/T8yHeC0/ymRMgnaEpq3PhU9mzDHaEv9LOz/dol3HCJOVQVsoHu6UEzN6ORnfVOASEhkZkD6itYumVPdq+l4nM4+jawlXWi1Evm+24zUrLbomUcnNo7A0awcF2lo9489gZCK0K7WBsj/PWWssuccXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjRqqasi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2774539f8f.0
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908597; x=1726513397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
        b=KjRqqasiAZMa/wOQu6mORUQqJtYoS28qFZYNdDUEawk3xynAVDAh+5MC6z8XpeItQ8
         2f9Hl3T4u95GpXRMf6QnyicFrBCP+ov/lXOAMx/rcm/7+5Nw11Qm6eIPe2iHql134NVw
         v1HTBurTIoCkC+l9IxBvUdRpAu1RE9nJvqGum8c9tx7CZJkxBjI3X4+igiX/TzngOv+c
         asbnqi7OGEVz3ce+vzOAUEn5xXFf6Lg7m4DXbU8qZk5uWwGnDK8RHZkSICIb/murFpmv
         LTlTV8w0HZLBkKZSlVG58IKxrf5vBOA31XUlMuEoPiDvNY/0svBB/JnFTjzGKGZEOkkh
         dAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908597; x=1726513397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
        b=AepZfNQUF0i/B359Gj2dQYyTw3aakzH0BmdGLJL8gR5yCwfuBeJyLzf7ahFUqG1U41
         ehiGd1DgleEv7RXcYHqTg97aIFnsgs5VnfhszWZkh84z3PEER5HKgnqmDdPe9/aMqM90
         p3NHpKlgz+dtF6byBeA/WqVLB/El2p0BW8s2ICVcskVRQ8N3thDRus74VU+/65TFSK6N
         nOxRusotwQ4v+cgVUNagHi60EQCjvifE2c//MHDiYGDzKTOxxa06iCfkEpLG/PqdCaTX
         YHiDqDKolTIRQJLkMEpsHB/QDoVxJe76LexIa8IQ/i3Hr7AtRMOwt4LwcSAg6AroroII
         UChA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSbAtOVCRHdQrfrx6wT2jBNsklLzzFybUY8Kfvwd5o7p+wD3ju+EM97SAFBTah3Bshq5pGOwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3irGKDknDpwjDDrZdN5tsN7iWUzxcfo7+OgyprUZw5tR9Ms4D
	E/GCuanng+nw9roTEJS1/3fYdyEUq2Yh4v9svlR35n3lao5u62lJCU7Eln4uXpU=
X-Google-Smtp-Source: AGHT+IFgDuNms106IsvN4bAkuQCSTPRrsurnBAbeIx3Io5N8P59fF8F4Fy8vtiPNhfwOEGgrANDPBQ==
X-Received: by 2002:adf:ee8d:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-378a8a83a66mr306475f8f.24.1725908596752;
        Mon, 09 Sep 2024 12:03:16 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0600651sm118226135e9.32.2024.09.09.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:03:16 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:03:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 3/3] cgroup/freezer: Add freeze selftest
Message-ID: <woqtbusaxdxgolhjylrvsdnmlspwg4tlzgynhse3mgqva2cepv@yzminbmkfyvm>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-4-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jciukgq53d57kpvt"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-4-chenridong@huawei.com>


--jciukgq53d57kpvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 01:41:30PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> Add selftest to test cgroup.freeze and check cgroup.events state.

There is already tools/testing/selftests/cgroup/test_freezer.c
Would you consider adding this as a new test for hierarchies there?
So that all freezer tests can be run at once and maintained in same style?

(There are already some creation/removal/event helpers so it shouldn't
be more difficult than the bash code.)

Thanks,
Michal


--jciukgq53d57kpvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GcAAKCRAt3Wney77B
SRHUAP4jSQ6yAGBfCoHmzxy60HCPZ1MNP8j2Q+NUb+tmRlH4KQEA3OHraHpihHSL
1GCz1Ct+VE0X5O9berdlWBEtGuRMcwQ=
=jy/Y
-----END PGP SIGNATURE-----

--jciukgq53d57kpvt--

