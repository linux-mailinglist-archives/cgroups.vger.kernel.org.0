Return-Path: <cgroups+bounces-11961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC936C5E4D1
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 943AB3C7FC3
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579C3314C4;
	Fri, 14 Nov 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZXGHQB4Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38132A3CF
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136910; cv=none; b=ACODc4tuauS5gnFX7FGqF1ybh7YYff3B+1D1UL2xBT2esmCKC0EbdVpAjiGPglNWEVD2UIIX8kV71NtlviDqtlF0ArAeIOVCLC5iz0Lvv1DB6ILAM3HL4w0MUCRDYU8/WxWEM8PFFBtbO9Q28DeCOsiRpui0VgnibLQWpQGaJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136910; c=relaxed/simple;
	bh=ejBx6SWBDyqUnaXvs0hfExFMOttKr4WNz5/+Xw7vBS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThWcIFJTOeGj/jKx92MYgcD9ldRjFLMaq9bBxpPFzF+LmcFvqZXKTBOrTfn1nBeD0J2ORfFqyfk6bMZQZQOf+fk8X5zjhuEGDk5ZOQ4eZt5ifHuX/m2WEHrDscfalrBujDEd0YxlVgQPIwzFkDtnYd7bKq0mxPWhCVdIfQHU8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZXGHQB4Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47789cd2083so16552575e9.2
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763136907; x=1763741707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uve5aie6t2ot1LukeDq0Ajy09nejf8kSYUsScMpBm7E=;
        b=ZXGHQB4YWRdAFKFLpo+9mV3H/17F/V5UoeMvsLZghKobajfqV91M+VQ3j8NE7boPib
         LCf42tZ+23gUwh8ULnK1MtpgC9Jxkxlqyg+uVOmuALTJJSRaoyYcKw9p698uY60bwXIx
         1wfGtMMAZmtFLgRnpYEbpNqAsrw1+QnaXl/tH/oK+fXlRjp9pRoULIMHm3OaextaAfic
         XqOt4l5ueDIeIRX74O/aNgaZgDmO/zw/YSxhyOAtSiiriJXBoCP97YiXFW7VLFwvmYDY
         Z/JNUoTGPP32zWXJD7Jjq6TVKfeuPwDg3x/CkVGuoDNnuU8gb3I5Rbtv9TANWWICdzC1
         a/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136907; x=1763741707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uve5aie6t2ot1LukeDq0Ajy09nejf8kSYUsScMpBm7E=;
        b=CI2UuORRLLtK/wcDURYc5McTSwZe2tkSCb7jR4LPH9ZtrXUHIBUeWuUHIViEIbmtZN
         N3jqZ7cEUuPEu1h+oyBIITCMGYhZ71ysJb1Pq2RxRw+JEHVa+oNKlfOrnz1xORzgmp+u
         +4fZfmEyT/nT/MDE9mu8EPmAjFMRoz07rWlg0Tt40Kdi8paWGVXSP+d0UgYKirvwvUmB
         2Ext1xA5k2zJ/tc9VKB0tKGy2FaRbaCVYdBa3Le7KJgANB4krnKKse93Mce6AkLz4RdE
         ulZh6YNRcp4mVPZb+ush7FwwpvrlP3PpAqe7eDzbioEcStDE7zSpwoPBWHIZLr4s88Tc
         9xoA==
X-Forwarded-Encrypted: i=1; AJvYcCVHvnMxSTob6EpleZ3XxFAK//OYHSXfkKOF/Haba+npMBQH8FuI3Q2wUo6BqN4hVZBSSLqHwXSp@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUDZNZeGMT6zGbE0YpR3uTGcj6LudzmgczIApVl5VYw00Uocx
	EKLSwCka7vX1UV1SdJIZEm68KfAUA84/VYUZHOBWP+56CudPxsEFO5CU9I59jhNa9ug=
X-Gm-Gg: ASbGncubuL5BwD7yPVIVhv6P1PG+sjsAavZ+6lXs+JD7KB3mKgBalqiygPfJep9bfeg
	yzb1r+1A6CU9faw4gt6jfMIxBeoixvDoI9LKZEq+ESE2IjmzIhzH2Dzt4rkwf4CXVo+rf/E9ZXd
	ELtBx/yabnreXj3znfRnEKBhg85yY4yLHck/zHrynY6xXkWANtjvZW4D5Kv9rn29xWmFQ7BFHox
	sPPEFhQv3ANOL3d2dK8l9MOFnxn7OukfLDdpqeNS1Iwl5Rehtg4xLDDnjYwvfMPtWcGY3OMw+uH
	JOEI1oyyYOg6o6X4ktTGlL4axBN10PWWGvYZkUZLtHb8xNIk9N9v0X4pR+fy2q7n523sfCD/g0Z
	uRGn5TDxIAMMu0mrFOgQeSyeHwRWfGRmmpUugZeZIVKCYXcfsmSiItjjYL48SI4nKsf5Yd+Y3Oh
	RX3A7pUYtgFBnSm0rVc+jZ
X-Google-Smtp-Source: AGHT+IHAcvxQ0S1fd661evp/djtiAIG1J/y+QdRRpdijz3aPV7O2phZJh8S1qUXE6mzjepnqCMJsbQ==
X-Received: by 2002:a05:600c:8b4b:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-4778fe50df1mr37780715e9.2.1763136906924;
        Fri, 14 Nov 2025 08:15:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779524d2ffsm18049275e9.3.2025.11.14.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:15:06 -0800 (PST)
Date: Fri, 14 Nov 2025 17:15:05 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Message-ID: <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251114062448.685754-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fp75ulup33bonzwv"
Content-Disposition: inline
In-Reply-To: <20251114062448.685754-1-sunshaojie@kylinos.cn>


--fp75ulup33bonzwv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

On Fri, Nov 14, 2025 at 02:24:48PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> The desired outcome is that after step #5, although B1 writes "0-3" to=20
> cpuset.cpus, A1 can still remain as "root", and B1 ends up with effective=
=20
> CPUs of 2-3. In summary, We want to avoid A1's invalidation when B1=20
> changes its cpuset.cpus. Because cgroup v2 allows the effective CPU mask=
=20
> of a cpuset to differ from its requested mask.

So the new list of reasons why configured cpuset's cpus change are:
- hotplug,
- ancestor's config change,
- stealing by a sibling (new).

IIUC, the patch proposes this behavior:

  echo root >A1.cpuset.partition
  echo 0-1 >A1.cpuset.cpus
 =20
  echo root >B1.cpuset.partition
  echo 1-2 >B1.cpuset.cpus	# invalidates A1
 =20
  echo 0-1 >A1.cpuset.cpus	# invalidates B1
 =20
  ping-pong over CPU 1 ad libitum

I think the right (tm) behavior would be not to depend on the order in
which config is applied to siblings, i.e.

  echo root >A1.cpuset.partition
  echo 0-1 >A1.cpuset.cpus
 =20
  echo root >B1.cpuset.partition
  echo 1-2 >B1.cpuset.cpus	# invalidates both A1 and B1

  echo 0-1 >A1.cpuset.cpus	# no change anymore

(I hope my example sheds some light on my understanding of the situation
and desired behavior.)

Thanks,
Michal

--fp75ulup33bonzwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdVhBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgESgEAmMKb6G2aDqaIJVTnQ3DR
QMho7kNzp30rMBiabdQxgIABAI9U1dIVC5F2bompvihxej8MACnAJBhIXNU7OJsm
KiYJ
=ynnE
-----END PGP SIGNATURE-----

--fp75ulup33bonzwv--

