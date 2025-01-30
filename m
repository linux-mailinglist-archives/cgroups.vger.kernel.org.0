Return-Path: <cgroups+bounces-6383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F3A22A3B
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 10:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143211665C2
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2D1B4228;
	Thu, 30 Jan 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMPeESts"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D65139B
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229174; cv=none; b=i0HbjJ+fLK3MR+pobJ0d7YQNOcjaKhjGAsFnwJYQTrd3me6ScC6u6UjBzOwGeR+7qGc4ycYipTi3WFRrnkplNHrQRnfSDsdKG5GNKqFIc7RSuZUc/QrcNQYB7imsS0RhUx4JPEHv4vq5CcMH4eDIi909QwU40QNbb6O4snzE/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229174; c=relaxed/simple;
	bh=Ss6TAehgDwdSBX0Jn2SHJGPzwEuTlGrwn+sRf6KBoNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmupvvXBlKI5ITKZpski0GtRs2hq44T243eNeSykCNw0dmSn8wLcRkau7v3/yXzuy4/lAmaP5K+tkph1f2PAmIi4fHrkSja6LKOIppRvAfz5f8I/c/vCTSNDQOeNx/tlTZauO9b3Kb2JVB6G0eLCqxxpJD5t5+i8Ln8IJLxRqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JMPeESts; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso3815855e9.0
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738229171; x=1738833971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss6TAehgDwdSBX0Jn2SHJGPzwEuTlGrwn+sRf6KBoNw=;
        b=JMPeEStsaYzSVxdqKQh3WH2lGXj00DMgvaxwH6rqyOgBpbfw6JAEjaANjkKd+fYiuh
         IyvK8yEu8mBvLVR0XMRUs0Rc2Qh5dF5lYlNepHxd9cpH5pqbRhnqWfkj1f5vlnjcQXFd
         czFpYhH0WUQe0PS2fPC2xcNezt5zPa5X+fSUejogtNN/K6+LBZIcptsV46oHtTTxcVq2
         d10+CbT2Upd+z4bvej9eydizNJeeaUYcmCG/WXJlGTKpNmn+wejm6cOXOPioB9Z474JH
         4FDvDPcOnSVxa5mLDNyxqJPyZksfMCs4/6ZuDLFBIkhETpI0ogR49fQJsES9DYxI/rQa
         XJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229171; x=1738833971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss6TAehgDwdSBX0Jn2SHJGPzwEuTlGrwn+sRf6KBoNw=;
        b=Ai11RDniBqIexz+YFo0NW2E7SQ0lezc/cSQuJT4q/tAkL+bDSHFFsADUTnXlVqrl+x
         upkRCunjBZW9/GyjhU8lKj2H36YUpQU4v+TEvkkwNKVa59NtL98JJFzoZmRBsfN7D/Dp
         I9bIXcd1gzFVYXqKMzul+t52guLLI2GyXD3xWkNiPz+D4raeelo3YK8oUUiLDoluTdE2
         AbqqQoAEI/2X6p28Wb0aIzPZy5jSA7VGBuuNzG7ob6h9r/t6N8/mNOwP/4fBVdy3Kd/N
         WNSGjIOK3xA60rkK52nyqdcVfdSbJKCwZVx2vLi+OVSYZItMpSWCdcb11/a2nEfw2B2j
         c0XA==
X-Forwarded-Encrypted: i=1; AJvYcCW956oH9ptmbNtb+idWqLauUFjPKx+gZeOURyhoa8qI6gOSLCQ76b02HdPjkV9Y2YVKhp0kEyOa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2gAxXpGCa2zSsSSpFXumWjdgZUrCkp5nIMBVzQJbesuVF2YF
	wZJjStN05P+ns2duIE4MFbUoNaOm92298/aLRsO1d9a7FI/zttjyrXZenRa2Q+w=
X-Gm-Gg: ASbGnctU6QpKwUVjJaagpw/YWUCYPmhf5Gh/WnCJGMeaRtY/GzyCp/5CNnK+KoytLsb
	a0kK70LuAdzdU6Bn/4PmHsGYyfjKApsrAvZ6PUdunems0e+14Jeekc74XUGRzri9W6nUqCeuo1l
	OtRkXVZF799AtwMGtdZxBNeLiH3cUAOIDFDiJos32S4mSwcR+2OOo0j4k/brlI9XwB2IxRMyIw/
	QVlBQl4OhlhYDbyyuSoTyFSj9qVpW/N14GlzA0I3wVJzt/wqjZH/6L+Fe0xxn810e19b7uSabtA
	F8NmidxziKpDbGHC7w==
X-Google-Smtp-Source: AGHT+IHkDqyCG+kARtwYDnl8ujpUjmLNSstCP8Zea/ZsGKNuiwMSzYTLb4UWS5GXeWVnDZ5EjKjEjw==
X-Received: by 2002:a05:600c:34c9:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-438dc3aa58amr53861425e9.3.1738229171114;
        Thu, 30 Jan 2025 01:26:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81d74sm52205955e9.37.2025.01.30.01.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:26:10 -0800 (PST)
Date: Thu, 30 Jan 2025 10:26:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: Maybe a race window in cgroup.kill?
Message-ID: <wj3tqes2kd3tjsxpj62kqb6u56lht2pko3qnkjzulyqqoel2nj@apym47ae33gl>
References: <Z5QHE2Qn-QZ6M-KW@slm.duckdns.org>
 <lelekt53th2kq7dpz6r7gkifpnxwyk6hwhdko4elshj5qqik3e@cjlyam5ttaoe>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="766tojqhh27mn5bf"
Content-Disposition: inline
In-Reply-To: <lelekt53th2kq7dpz6r7gkifpnxwyk6hwhdko4elshj5qqik3e@cjlyam5ttaoe>


--766tojqhh27mn5bf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: Maybe a race window in cgroup.kill?
MIME-Version: 1.0

On Wed, Jan 29, 2025 at 11:08:41AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> I think this is indeed the race though small. One way to fix this is by
> taking cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the
> fork side takes it in read mode from cgroup_can_fork() to
> cgroup_post_fork().

I don't see that cgroup_mutex and css_set_lock alone ensure the ordering
neither. cgroup_threadgroup_rwsem would be certain but heavy as you
write.

As I'm looking at it now, freezing is similar but shouldn't allow such a
child escape if k3' came before c6 since the CGRP_FREEZE (or
~CGRP_FREEZE) is permanent (until next operation).
That is IIUC basis for Shakeel's sequence approach too.
(CLONE_INTO_CGROUP should be fine thanks to cgroup_mutex.)

Thanks,
Michal

--766tojqhh27mn5bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5tFrQAKCRAt3Wney77B
STYxAP4pSOBEcIT/PLNVDzaXwXF7D4T6JswOno6zSWfRL+zvGQD/cBVXyFiU7JQf
ry7jys6TH7VPhm7YQdzya9pF3XM5kQo=
=fM0O
-----END PGP SIGNATURE-----

--766tojqhh27mn5bf--

