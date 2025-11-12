Return-Path: <cgroups+bounces-11872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D544BC53CB8
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A94484F2675
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630D25D527;
	Wed, 12 Nov 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vz/yo2FU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B128338F20
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965927; cv=none; b=RFcceziDDqvNlcR/PH9pWSNj3Y92ZPe3OGf3NfLHtKeBGOH+iw+azTkehcCbQNvVhl2JsKbLO+qejp523GJYqt/Fz0coH3HZjNyqMJub1M+KMsyjkBAxHGBPdKITiSUNcDJG54H8sq93xUSwy2kQZgLZMz9O8bcC6zrr+OQ0feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965927; c=relaxed/simple;
	bh=dFbiDA3pYjVFZelrxDptU2jBYsGVu3nCkoMVvfG/W7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=japvyiZiUPG9uqLovd9Cs+0olUpvr6s+XN9rxBduMcNTXCuJoYXL6oN10dqLrVlAf5Ghfy6jzV8o9MA+lvlLOtr05HOr3A6yK1xEyiwMzr35+KnYC27lN6tvx7Q4JThLqZ9Q5C7MwlXxNcTlZPXoGqq/Wpz2NLAIOXd6G20pngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vz/yo2FU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso8017995e9.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762965923; x=1763570723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVR4IiqTQuPFw1gx/6u/ZkbW0A0NLJp/x9HKli2NYpM=;
        b=Vz/yo2FU5k8pNVJ1NHPI7PSauBEnZjqFXuQXzEhoMX0a2mmze3UFhbH8yPj5XU7uR6
         W3mEma6zRhEBvUSWSMYvaVdSMhmQOfyB85oqBroC/EEzGwvOSgQFkXs+xeA8Phv31+LJ
         J3xzFwzNZal8ahKWMO1OHsMH7ZxeNHTHb4jXiv1/g4zNFRH04JJpB2awTECFCCjEMpem
         9ecBLJjlwt1SvchcKAShXX3TUp3dLNbyTDf2F4p6MGHpiVBEgsPApjpVbefZ8yNFYE72
         i612kVbHIqDyJJUk1O9W8DkQ+XuKCuzDEUhraymSbcVS8QP8Wou6f7NNX4lMfraBSKbd
         j4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965923; x=1763570723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVR4IiqTQuPFw1gx/6u/ZkbW0A0NLJp/x9HKli2NYpM=;
        b=SncYAzIzm7TfQAdItiGXvMsFQE+2mn2uga0lFaHQpg1/4ALVSwCljCjoIF3FZceBp8
         a0ratXD8Tu4/AyfASO6ip/Dk7anM97KUNhb3U0HLZsgl5z0llJRjsGV2M6R0OWHFDYx5
         5VadjoMUWqYqORjV6VbdYbEmHlkaucu5FHh7Fn2qihHtdgeCOqE/ZJbJGTFo0keDWvOU
         7IYHrzDz5jLxvTrxVs1oMcfEczw+htGfM8JyUKVE0VHNedg5Sb3w8NWc1G14GbiHB9aj
         tdrDvRM4ZEeKznSdobpwGESH/Xuo8H8IKI+ZqIBFJ1BAXAzdWsNxupjQFm2KVfsnJwFZ
         E2Yw==
X-Gm-Message-State: AOJu0YxY1HjUlCHJgn0r/cmHAi0zM12VJ0mUKDdtJ0lPkBBK4c2mIemK
	kkXThJ5VdhtehhdZtZHbfIn2FQ1B/wD3UmVE+4PBPNA/y3D9m2aqzeGoyc0T1aQaPpI=
X-Gm-Gg: ASbGncs2bvcbdnOXB6mO+PMHR7aIsbbKFm4qwuxC2VUiurhwv4XAYeh3PmiybPoyHRb
	s1WGYfuv8yVRk/iWv+gQ+qbfIaMQkREege7mDl0SZm2q4WtRpm/TAnawHjpYoNW9SiMO8yTSYn6
	0c6ZGn1SD7P5bk/e86wmHQjXLxNkRodSy8ghSe8cxAnKRIOc2DnrCS2OQDfHHLUciQdiYqAVrFN
	nyByVdvYNvVpG9s3q3/aAIPhuPayEUON3BheRL/qMpbmj3jPPdD0InGb1vIG0oZFmw4B2pnh4Ji
	jcoTR1oVZPCkOmpIO7dfWbBmld7bM07twXSOFO3IbIVRrUlyp4oqWAVDXmjns+DXJJnzn2O8/X8
	66h5LOBW2xRtgokY0sXzCBScrcVAQNMJrkSJPz92XTs2ZKzI4HR4FlkaJM2dhb52V7dW/zuOV5J
	LxE0TUbPRXO7JAh2B0P93I
X-Google-Smtp-Source: AGHT+IEkfOcLYs4eeq3dPKCYkjyXyaX/Wb2v779w4QV8RFNwiwGCMNiAp0FQjFkEw0ukfrFwl/AiIA==
X-Received: by 2002:a05:600c:a43:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-47787046949mr34271965e9.10.1762965922776;
        Wed, 12 Nov 2025 08:45:22 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2b835sm44788005e9.2.2025.11.12.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:45:22 -0800 (PST)
Date: Wed, 12 Nov 2025 17:45:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 0/5] selftests/cgroup: add metrics mode and detailed CPU
 test diagnostics
Message-ID: <7tegnvfpx52y4szfzddj7ab5h3uzbcoksfdya5elgcnurffw76@jgg4abij4edy>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yh4m726ve4rqccgf"
Content-Disposition: inline
In-Reply-To: <20251022064601.15945-1-sebastian.chlad@suse.com>


--yh4m726ve4rqccgf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5] selftests/cgroup: add metrics mode and detailed CPU
 test diagnostics
MIME-Version: 1.0

Hi Sebastian.

Quick responses to the series + some more details in respective patches.

On Wed, Oct 22, 2025 at 08:45:56AM +0200, Sebastian Chlad <sebastianchlad@gmail.com> wrote:

> Sebastian Chlad (5):
>   selftests/cgroup: move utils functions to .c file

OK

>   selftests/cgroup: add metrics mode for detailed test reporting

Yes, this may be useful.

>   selftests/cgroup: rename values_close() to check_tolerance()

That seems gratuitous churn.

>   selftests/cgroup: rename values_close_report() to report_metrics()

Again :)
But this is not only rename but IMO the substantial change of reporting
the values always (not only for fails).

>   selftests/cgroup: add aggregated CPU test metrics report

Why would we need to track this file in this repo?
(I can imagine such output would be useful as a reasoning in commit
messages that somehow modify any of the tests.)

Thanks,
Michal

--yh4m726ve4rqccgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRS5nhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Agv5AD/XceTUV+adySN7Ucxau3H
acGaIPcMnv4LQxTYpEwglrkBAODJUqRp2WP1eZykvdHnABVgcZYjyIuRUCkC1HEV
Q0kJ
=TUm6
-----END PGP SIGNATURE-----

--yh4m726ve4rqccgf--

