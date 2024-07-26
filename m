Return-Path: <cgroups+bounces-3915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9F93D275
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BE1C20C62
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC317A937;
	Fri, 26 Jul 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bSj/g0AY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627313C83D
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993875; cv=none; b=CtgnNeQ6Hr1Ffa7cJQCJpJvoRcRawIGbURqJsJy1WHzUiJaGaS5bcENg8DA9UVNJWgC1et+L3ONkeJ5cgRSIlY/TNwSAwMXYbnySkFYx4dczuTkGmIDVeLNiHvE5IJh+hLNje5Qq0yYPjHfVoJEQ9YvItK0NEsyQBmk+5LYJW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993875; c=relaxed/simple;
	bh=ExfHMLI2TgNPOYKj5cXqTFRcFOTs5IC9WGRu70w5g9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI4fglCxnSG9dFvMgiwU1vf2c/6oc6qEE41gYKGdDG/yPp7bBPb1RH4pLtLTB3e7kCzhidccjXIe4bfGflLaPzbGxXLVsFzM7e61jjz839JK/LLU8omh7M/ksb/HpUWZbgpx2/U/X+v+7/p4sVv3nmhKgvRdHF7Ot3TTzICvJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bSj/g0AY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3687ea0521cso1384169f8f.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721993872; x=1722598672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExfHMLI2TgNPOYKj5cXqTFRcFOTs5IC9WGRu70w5g9E=;
        b=bSj/g0AYnhVVvYelDVrBnPQMMaTGfhacpstVTSk/np6q/Jt5Yde1F1Q/CioU5Br/ej
         sL3EW/7uYnSqRlNqCx1LrUy+1a6Em1Y2emb+nolXJ9e8WOtfdnfBa5vjR64qpzOOXznw
         HnzYLcGILgBrffChEwLAXatQWBil50SCxMJt+j3DV7kflkh8+2buj1caf15fpwLKkWTU
         tdW6PRc/tbvvyl/zF0U89HzOYpY9TYiYMOusCErCPJbLgoxpgtO3hztgsggNOydEskGT
         /7d9NuPlmmoJl4KKsepR+JVBblpjYtWgl2ReFrzmRa/+N6kE60zkrAyXj3/lmqIoXDeu
         tsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721993872; x=1722598672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExfHMLI2TgNPOYKj5cXqTFRcFOTs5IC9WGRu70w5g9E=;
        b=wloNMX0U8hqUbxw1bWC74sPgTQJORljcKd/d5r2z2fdRkigWGzxlpGiUSHFsbX4VHr
         ieWZnGksSSuH24ho5Im9Aip+gzXQY7t6qWPkdaEV03TxyAmRiwqH6AOkKO1y8TTfAiw/
         YL/DAIbctVmOJT88VwYiK/dNvyjZGrpeClAmwdXG4v6XFVnPHt+C+goGFRnNvBG3u0CM
         r+c8L3cQDFnKK0KCL2ICwghX6WxtJzLK9pmABrw20D2NFIvb0O104C/CksWOKpSb2cX8
         HBsxAWbfklXsAyNgRo5rfvdOzI3e7pXdwsymhN8k6U+jJ4qTQujfQfO8IrpjwqtIZuBl
         O8NA==
X-Forwarded-Encrypted: i=1; AJvYcCVX83dPwF31XVqMHr0kmAFmJk3JdYMGNK9mAJuRcXVFrRTX0rvfDllMW9GyFYFDLSIVR4qwYl5ozqYsipZMKKp+Ov6F8x1B0g==
X-Gm-Message-State: AOJu0Yxxr2NUJLbE3RGLImDQR5Cp7gCmtlToCVMBaa/mux7rWmyLri1B
	cI9tBjVa61+fxTgX6oJABEC2UO4zIxQXkhDN8s0towtKYk6J6PHVh6dgs+expP8=
X-Google-Smtp-Source: AGHT+IHdWw2pVQH8kASCXAATrmJ7gIo8btdjDdqr/6bnqXkZzgw4ckBkodg21ePi4f48pqReEEeT5A==
X-Received: by 2002:a5d:4ac8:0:b0:368:65c7:5ffc with SMTP id ffacd0b85a97d-36b36746978mr4013560f8f.60.1721993871556;
        Fri, 26 Jul 2024 04:37:51 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8b0b16sm2511568b3a.214.2024.07.26.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:37:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 13:37:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: reduce redundant comparisons for
 generating shecd domains
Message-ID: <cfpvrcplrjeb7r4zscfjnmeahpi5c5c3kxtql2jyrj4hdp2l2x@25sfleq3wjph>
References: <20240726085946.2243526-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ghhowve2r26dtea"
Content-Disposition: inline
In-Reply-To: <20240726085946.2243526-1-chenridong@huawei.com>


--6ghhowve2r26dtea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Fri, Jul 26, 2024 at 08:59:46AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> In the generate_sched_domains function, it's unnecessary to start the
> second for loop with zero, which leads redundant comparisons.
> Simply start with i+1, as that is sufficient.

Please see
https://lore.kernel.org/r/20240704062444.262211-1-xavier_qy@163.com

Your patch is likely obsoleted with that.

Michal

--6ghhowve2r26dtea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqOKgwAKCRAt3Wney77B
SRWBAQC+A+Q9nPwvco9Ln6s8LxO+3tSjDhjSEOsaWoonrtA7PQD9He75pJCfM8xd
ec+QLkkFF9X0yjt37k3pEKPCxm/Tbgw=
=YliG
-----END PGP SIGNATURE-----

--6ghhowve2r26dtea--

