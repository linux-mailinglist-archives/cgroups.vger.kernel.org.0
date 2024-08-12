Return-Path: <cgroups+bounces-4208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1A94F56F
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74046283604
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E4187571;
	Mon, 12 Aug 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EXPsSksu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EE18950A
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481838; cv=none; b=Jq0FBNdiDMxQp92ixw3H6+CQgUGXk2hj3fnNNKQgFCDI6GbtQ7pHo/CYlQjWN5+0gy/HlwFFE/5/Z4fHdu7xlRNl8SOGY3hlewRVw73CkEtd5RT+sFWpNRMzHpF1h7L84fkWHU4OV6YRBtsh4MS5DL8UcWjlPFoL7+to7xtXoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481838; c=relaxed/simple;
	bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlr/ZO2VmetA+7Ok37rPDeFBOVidcERTSYkyyJdcNffVhilv1ubaI+ibKm7ZoHH+fWvZblp2s7tu4jMv6l+/PQEulrl2pb9Dv9iXMimYtiSpFklF7pOwfBz/yzQuKiUcridqLhd3B3uTXO3n3yCI3Q04agqtWv+1Gkf1XGgEw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EXPsSksu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso358489466b.1
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723481835; x=1724086635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
        b=EXPsSksulhbu14+eyHeEEuTIuu3w4K7i756tPidsMd3NbXQcyAYLlAyyYtPsz+WY7Y
         OhMuw5t/G1FI2KjPtdjNrczewmFQHP8ZxpIOX6/wb2eBbX48dXmaU4vxEfUQshtnBBpw
         /GCDGm/QOWfGczOJM52ws0vAbfen8YyaZ7X+F1/p8CizS9pBIRrA4m+KR1fsxGu4pmp2
         5bmxOPacewTFQvqCaYlBSg14tSvmvkhgasKktyjUCeLTyy7rqQFimFs1iGPtEwuYv44t
         StBA3ZyhNLqWQY7z1Bve48G/TQM8prkqq20pbDOiROVEap40y1m/wodYjd0x4VD8AHTT
         JnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481835; x=1724086635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
        b=RU/L3bRjS7sjnzS6HjRPT48B8TRIvKEF7IqURD1CxfivgjfYWwjfrOjHP782iUjrg+
         YPyTJxB7b5Wggp2/5kATaJ5CRoRKPs8Os95rBKtfD1oZqMqvLLwPfo70SXOS7gucUZoN
         9DfdizfyaIeAVwVBPufJODJJDAqDfRu004+Oyu8+Rmtf/EQ+gTvhQRPRfNB/SDxPKJOV
         7tIBCLTE+M0W2aKDKCAP9X8CEUoLRsTsh+Vu9f6o5TScBSOr1tZ4DrXTtrhsxU+rpX0w
         2phkxscZmc/ovNelUTD0NZZNJH1YlsVCq8velQXls+C3zE21sGVvsCo3kWuvf+2gQpj0
         aypw==
X-Forwarded-Encrypted: i=1; AJvYcCWqgOOQcsDlbjv03mGfueQm8RFKAkLha+uKQAwKcqPgXy7gbggxIBnjH57+j5DpiE4OCWnZXt/4Hn6feLdcaC/Bmj4unsisZg==
X-Gm-Message-State: AOJu0Yxv+aloDqB6ucFgHTNJsDM0/vptbZluszx79oQhqqtEYTebw/rl
	KtW9Z3XO1UKqBgF94TtFNULHY2hMFZeHH95RqZfHY0P1mQxehm6m4dZZD71baXs=
X-Google-Smtp-Source: AGHT+IG8DI/8ApiuNEjifMrK4rBjseINuAZz4OESjCkxUQKd+mruXpNXcSB3i9JLyRHHNcr+bNoYiQ==
X-Received: by 2002:a17:907:d841:b0:a7a:acae:3420 with SMTP id a640c23a62f3a-a80ed2c4d3emr67882666b.49.1723481834870;
        Mon, 12 Aug 2024 09:57:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08f6b8sm243602566b.20.2024.08.12.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:57:14 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:57:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] cgroup: update comment about delegation
Message-ID: <qk63o7tqgwt246tmjhvpnzd5ojuuhbndn44tdc54newzws3i5x@igea5nmzcoz5>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="is5odoxrqipkobog"
Content-Disposition: inline
In-Reply-To: <20240812073746.3070616-2-chenridong@huawei.com>


--is5odoxrqipkobog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2024 at 07:37:45AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> There are three interfaces that delegatee was not allowed to write.

Actually, the right way is to query
/sys/kernel/cgroup/delegate

> However, cgroup.threads was missed at some place, just add it.

When you're at it, could you change the docs to refer to the generic
definition of set set of delegatable files where it makes sense.

Thanks,
Michal

--is5odoxrqipkobog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZro+5gAKCRAt3Wney77B
SbJ9AP9qJuDZGebJ0/ukBJ5kkcdviUeldQJlj4sv6mz0BpetkgEA4p2fTqTxn3I4
h4lm0fR7jVm1mHsw1OmVLtv0TPHczg4=
=IYjR
-----END PGP SIGNATURE-----

--is5odoxrqipkobog--

