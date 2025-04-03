Return-Path: <cgroups+bounces-7330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDCA7A3E6
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908657A7085
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC624EF63;
	Thu,  3 Apr 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Me140abe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8C24EF65
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687251; cv=none; b=mk9DECv2wc5DML4AP+nWf0w/qnV0RGQvG5LwgDR5cfJAFgKtinIhMCF0yxGpet0W60ygDR8NirnOPgyDf9usFdX+Yoj7f/02p3if8XDNtwNbLjMGRfNrmU+OVKS++AI/eLioKwoNVwaLALkpiUpBhi4CM+ZiuseBEo/sAc8GLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687251; c=relaxed/simple;
	bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwlNc/TQv3a9BITW3IK/3I+IvcEYLDCuRlZqb2/0hjVBsxwWYJEkTkjMy/U+KMY88Dmcuw+lfrNqsDDqBQiCtqEFS07ffwtt63wZMNHuwGtdS3ielbjZojE2u4k4HJYD5VDW/x+oyo+wBOwyGzGLUBA6zxObwIyLxIMPQ0DZ5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Me140abe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso4143175e9.3
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743687247; x=1744292047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
        b=Me140abeGqz+krODLLr2VPPxSqzreDTcOK6fbCInh9C9gS1jrylRb1GKX/TzI1kguq
         P7o1bEIRm8l95dmdr/VzopwtIA+dFnWG3gRABWKeHfNboEq3+Gtbz5hfe3o5LkHUbVa2
         LCiVUpUtNJFqfyTUX18/MC1wM84x43w0LCMCVBFr+vEnUWspAhGmCpmFf69SfMPjApCN
         VUSKe06cGX94zv3Vkg9vdtfIpAVqea7yD4OXYLjkg6ak3EKkbT9CbRh4R/nl4sIUUU90
         PsPmO1++sHH57//E+SkXMcN4u0Wh9TOpWSXRoolphHoIqtUTYT6sGeHdAT77S71Ss9Eu
         EINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743687247; x=1744292047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
        b=MZ2ll9cb7T6r0oxUFxguYFPSCye5ErLNF3JME1Uax1aFgyDBoVTG37aIdDVuTNgh/d
         8Mgnn/I4/FjOtUIX9WDrOHcbwCkeccLzWcsGMiNQzosHHLfskRQMAxBpmT+gG6MH3/zs
         d/4MSbxPz9/jar89RYhbz3Z8xhonyftcb4EkFF0IUrwlCes+/mzcB0VBOp+4tGs+0FLl
         Unfm3E6G/QEdI2Rihr0+4daEsDlSo6AFsOCuaP/wfKF4bgwfoHebabp4Ga4koTvaMkJv
         aqz4JNK3kf+2eGNUtchhvgg2EWx54ozoZ1cKvICc8eaMs/BkXs/crznqWzpI27nnyKFo
         OBHg==
X-Forwarded-Encrypted: i=1; AJvYcCWVEeZ438BvlyIuGM1dVl6CSUcIxigivoThK4LF6CdOIrYFjwISrmTeYuX1efqctMn97tcRIPyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UHPqTmeFvGCc/woeN99r2eDlCHkkvH0+C6jk4/uwFS9Yj32/
	DAQQdw8tu6HIl8kTs+HVHNFW5sEk4oQ8kUZV6YlBjm+Agree4S79vwGD9E/Mx6A=
X-Gm-Gg: ASbGncsqBNiX9wCAXWDQwpOaEZByPs+/4W+PQGOTv5brQS1s9ij0QPAeUJFgd9OmXB/
	mUSBck76C9CtY5KiqIR3VCIsSSMhNrJaZa1YIsdI9d4vylCnE7xH5T+qRJUDNgcWZe6BdERFrc9
	qdmvEiczfVCbej0cWtKd8pe5TFO03A1ruZfleJvLrTwffvKCtGgMzFceG9eD/nt5HWHrysGtjKq
	O722HyuE1FkMg09hatdS9NBh33taOtV5cqCPdqIzyuwJNQimyZhB5qls3BDj8jjyhU1mh/DHekG
	D+8AGDikHnxHqzBsjgBmHOUc/5DcOT2rYjvDVFtUcrjSpOg=
X-Google-Smtp-Source: AGHT+IGP0oRY34V+cSf6iFZovfs1LwN6DYRliDiIlWREW6dwmZHpdy7zI1duz9gTK1+/IwIvLvwRsQ==
X-Received: by 2002:a05:600c:b89:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43ec153677cmr30397905e9.32.1743687247482;
        Thu, 03 Apr 2025 06:34:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364a0c7sm18497875e9.29.2025.04.03.06.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:34:07 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:34:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <hsbn4pcb6gpipjfacn7tbutheolot6rfia2j6nyit3bpf4adys@mpaop37aps55>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-zsGazxeHK9uaA6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4fu4hgrvs64iwmt"
Content-Disposition: inline
In-Reply-To: <Z-zsGazxeHK9uaA6@slm.duckdns.org>


--t4fu4hgrvs64iwmt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
MIME-Version: 1.0

On Tue, Apr 01, 2025 at 09:49:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
=2E..
> > Add a new cpuset_css_killed() function to reset the partition state of
> > a valid partition root if it is being killed.
=2E..
>=20
> Applied to cgroup/for-6.15-fixes.

To be on the same page -- Tejun, this is a mistaken message, right?
css_killed callback is unoptimal way to go.

Michal

--t4fu4hgrvs64iwmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+6OSwAKCRAt3Wney77B
SSclAP4gqtAuLackFi5Nlj57z7Muu5PrIFLfK4zkKKF/gZ5yYQEA/gVGnVQa8Dcq
dIb6mJ6FOINsexbxmLhptB0vDt+lFAQ=
=eHQo
-----END PGP SIGNATURE-----

--t4fu4hgrvs64iwmt--

