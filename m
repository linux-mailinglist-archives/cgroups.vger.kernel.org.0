Return-Path: <cgroups+bounces-5931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03369F4940
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 11:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE367A5E2B
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E61F1EC00F;
	Tue, 17 Dec 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RuEIcyqL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9A1E885A
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432813; cv=none; b=V889OKTHqGVzW1uaWKKyiJxGNz7oOX2cJ/sErd/FFqVJpn/UgFbC8MVOgLtgbtha8J2q5pZxVkkCLFy7ulwx3B+3DkTRssGZLkHxAsbJWtzAzDIjzT93/nqjlrwP5mKFs1tNHxvzAmiPbxGGCDO2D57acS5pDHnNI/pUOx526Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432813; c=relaxed/simple;
	bh=A/aM+u9cBp0KR4NFJb/LlpGJ+AOLbCqCZ9EikrcXiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOClWZjxrm4ZfrH9sQcGfmF0pB20MTE8I06Rjj8SW1fdeHXnOco8pvXdBwRiySadfK0J5SijUB7W/FULhjkbp0SG+45wPoCn+/RxQ8LU7AJgpQQg7tEedd/5S3CL4vnXhCtaBZQAjNzYIJEnfSMcn2elf+8B4H5al8BlPmgymcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RuEIcyqL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436345cc17bso25438765e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 02:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734432808; x=1735037608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akvBumgmgr5EIX4fsmxm3FaGCKKx1kkyhh6tnIk6jL0=;
        b=RuEIcyqLtXGY0Wia1+4OIYR4i6LOWGRFTaeKSVoZkVd7xBH/+zd0Qxd3IT7QuLo4rl
         IJmelTW4mz/jLrYgwmTM8SNrchjJHvuJg8kGPcLojkpmAYbJQZyYogOnnxJxIYb9XAMv
         5Jaqf2hU//XJs2uoDADybpCef7N4v0zDNeXhsbc5TADdwx122vjoP2VfsyOYue/5dxF+
         Yt/bXYoXiopqFOE799RCVtcbsWkUGqjMaKdHO7IrGfWeOWP5j8auRh6GqzOsyVfrhjZq
         6PGVh0jXKBJY9qFEqJz6A2cPOWviaIMNDX5wvmDYSfqOjr3Cb/aUqi8lqV1gnlTZ7kNu
         44XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432808; x=1735037608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akvBumgmgr5EIX4fsmxm3FaGCKKx1kkyhh6tnIk6jL0=;
        b=gIuR9D9+xR+ENOxXWv3JM4mfzXBPLawS6CHpj22S9vWM2rtlOQv4OfLqXGkjuDdOXo
         dkDoD/M9/OVJvJW7BKrbCaGHfiog+8kL1ld8y51iJNfV9rlhpAVcL0CuvvbEs+bu95EV
         ZNqo9TZctPW3Tr17+VK4/RHNYDygQURmv2PFYMlnF7Q3RLYIjcqQULHL8hPaz01vEuqA
         HP2EEvrjdWvc50DnF+yZltBJ9Ntpk9QUvUJ6q3rAuuE8lA50Axsr7J8hs4SIQwGADdSP
         8uQ22/F82vR0fW506mUpCZLMyQzNg6Alm+eUidm5e8hbWnqziFFGy4JTdIhfeeymRP+x
         TnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQY8SiZPRn96RW0Khi5naDJuhQh//Br4m+SKcAJ6R24/pxjez6LUKzzPR0VkgES2vUcQsKw7ye@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyQPvAGiqyGFnlnskrVpa+SidPG612N0H03b1CF7ADf6LSyFt
	/QZCBznVYPDNq3p5/wiauzJSpNdDYezBmVRt846xciOOYm63Q2MysnoSGEWBXsI=
X-Gm-Gg: ASbGncuV3AxztCpvPv3HhRDz5Z1tMNBZ7r0+rBEGwwoXkRGqbCZyaKWWEnsnp7lg9KD
	T+OVLUIhUuAAARFjz6SD81zk35o9qv0bilcmYqz+A9iREGstFnAhYS3xs2SKaOao9pi/EKQrvY5
	lUEKgXv7qfzXWCxLu57jvkxnhLBTzfitj1rAqNX3CzopKeWURRmGdjEq24rALoLUP0wYscUf//e
	tXHjXNBEDrcnP675vAZViSkM/NRGjBInITOK4AdrQiYuxGh6WzvkeDg9cc=
X-Google-Smtp-Source: AGHT+IGp92CezacwNyyBgdqfZsg/E3xcoJ1kubOcalO3L3TCWN+rSaASKAUrZ56PuWjll0XGl+cLFg==
X-Received: by 2002:a05:600c:1c95:b0:434:f2bf:1708 with SMTP id 5b1f17b1804b1-4364767f07cmr27712575e9.7.1734432808447;
        Tue, 17 Dec 2024 02:53:28 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602cd11sm113466875e9.14.2024.12.17.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:53:28 -0800 (PST)
Date: Tue, 17 Dec 2024 11:53:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Message-ID: <xsq3bdzz2tbz64rlvmqrbjkjddiguvveuqo7rrozyyl6srrrsb@aclt6fr2qxvc>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-2-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="civnhrgjz2qrd32h"
Content-Disposition: inline
In-Reply-To: <20241212-class_fix-v3-2-04e20c4f0971@quicinc.com>


--civnhrgjz2qrd32h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 09:38:38PM GMT, Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>  block/blk-cgroup.c | 1 +
>  1 file changed, 1 insertion(+)

Well caught,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--civnhrgjz2qrd32h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FYJAAKCRAt3Wney77B
SY6qAPwOR82VBxA4fcXuVjjlE50/+vko8njeFm9ZpNrkqTGBXgEAhl3ipTTb7Auy
jtbygdF076YfrTkoHALOll+fPhlPtQI=
=AXzW
-----END PGP SIGNATURE-----

--civnhrgjz2qrd32h--

