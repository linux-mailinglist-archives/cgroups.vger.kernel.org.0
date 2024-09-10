Return-Path: <cgroups+bounces-4797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE25972DBF
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E729F1F256BD
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1F188CC9;
	Tue, 10 Sep 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TipdhiDB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F214F12C
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960923; cv=none; b=qr+oivhzF7sHuwVqI4dRkpJw2snLCoWU/eTQ43cR3yhU/lPdzyg72NkAfDPIYy3+/z46XC2kbFQwdBOtVXcSl6eE8PqivoVJsEYeRuSAI/PsUOj8DFKa0Fuwgk5VMKosE+sVIvO/L1KlMVxxYYMq6Rmh1Dk7SgEg3b8rpB5HNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960923; c=relaxed/simple;
	bh=XNJJ3mHKNptpNG3Nl27UzTbSVvpy2ePe+ZhtX+KoZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0a8WHq0lltGe9RqLQ1FIv89AhL76QaNTFkH/etFm1lEtAJNjvG3Y/U5d/oBH5ZwYDi4WovL2VU8zfE/UEpMg77dOGBNRdTzDxqzetX3+2rSBRL1HBMUWWaZZmgktCGPj/CHwuxTGGCUqCOCJo3nPMYG3rgVT8FbxRgrGv2H3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TipdhiDB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so31627741fa.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725960920; x=1726565720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSAqDYPbQePoYyU/zqFPQ8g0B1IkyNHpQhriOaJbTlY=;
        b=TipdhiDBz3USRsobgfOXH3HH8/988By3/HXKlMLA8tfdt+CLzkhWTjqmlutPI+OLQE
         qmLcvuz7K2uT7496/hStDuBuWBPU6g0HVC7nqGcvpnRzftsmSkY8D6Wxs/YeoEhIT5TW
         1ZsFvsDCZ8qetqMuyvmzM6/M0f28aEw4LXdE6UHUlsoYrH2lAZ9oSknmfgeFrMOTSitR
         LTt7M5TwJ8H+KK1iHXRffZtXEPwkuKU/Yrkj28WTSdTlZkOvXF4SVLpa6ECRE6PftQPk
         PLoxAKAbFXAkkhmz9ngKKIBYUPynP1nLnK0gA6Jk6363PJaa3D28iATfAkPdpYth3oB0
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960920; x=1726565720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSAqDYPbQePoYyU/zqFPQ8g0B1IkyNHpQhriOaJbTlY=;
        b=bIux6xTIBcWAUrd/vBDvw0cmXYbzEOhEahoiC7ZVcdaKYhHSQnV14wJOrlVc+lluTa
         jXKe8dwPM2MhnRKMI66VWoQUJ6GjIdZhAG1Zf/2UqlIAAsrXZJbnbh5A5PYhMNGmfAqX
         KvYForlplGxALwV9QqkrsCMQFrjdtEXj69ceN4eYXbZ6/FPJ0MUUZ5ZR50InLzyBIXB0
         ipHThK8LukGkuzeIXbC9WRG2BR6t316LU9Wxc5lST1XUxYNgNj+JxBFWFdqphgIHtzEp
         tp3RNENbKsdSdhIkX/+H7rbmBzxFBT7edczd63X4LumT+jm29I6BMpCvd40uBOOYeMez
         /RVw==
X-Forwarded-Encrypted: i=1; AJvYcCWRflB4/nwakOueeZjUNkKnDTY9I4FFfQ4XEVgZIYoem3Hwy60euVPzhXvvYUUrNMXyyuXn/2r9@vger.kernel.org
X-Gm-Message-State: AOJu0YySV/519gk4Am1JaFU/YFxrdIt1a9Y72bE1hNvA3/Ss9Xaf3Lkm
	JJw2yXCBJs7c7ZYStgEZj/MLfmbeAW/8bq41JwTybrqcoAKdK+G8L+u0JADL484=
X-Google-Smtp-Source: AGHT+IE1hXLrCS22kk5lupmDOywOYGlrbDvzsi3wjSQiAIoaKbjPCBcHNXQ3b0UVb6vJJahfpT6NTg==
X-Received: by 2002:a05:6512:1599:b0:52c:d645:eda7 with SMTP id 2adb3069b0e04-536587ac1cbmr6693958e87.18.1725960919519;
        Tue, 10 Sep 2024 02:35:19 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddbbbsm8230804f8f.93.2024.09.10.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:35:19 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:35:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Liu Song <liusong@linux.alibaba.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
Message-ID: <t5x3lxz2au5caw33redslk6vmak4nc7kmuxzflhd7tr2x4d7ma@ssdb2g4nkdlq>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54py6dw7gyowvoqy"
Content-Disposition: inline
In-Reply-To: <20240910074832.62536-1-liusong@linux.alibaba.com>


--54py6dw7gyowvoqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Sep 10, 2024 at 03:48:32PM GMT, Liu Song <liusong@linux.alibaba.com> wrote:
> For the handling logic of child_quota, there is no need to distinguish
> between cgroup1 and cgroup2, so unify the handling logic here.

IIUC, v1 check prevents quota overcommit while v2 doesn't.  So this
isn't user invisible change (i.e. there may be a need to distinguish the
two).

Regards,
Michal

--54py6dw7gyowvoqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZuAS0wAKCRAt3Wney77B
SaZZAQDkFGG+k2VhqjCbKuJOPzh/hD6Zunijo6SpKsQlUXnZlQEAxBqVMOGdD2Lv
w66v2crcxbF9HK7dqXSHlhXynaRdgw0=
=u97Y
-----END PGP SIGNATURE-----

--54py6dw7gyowvoqy--

