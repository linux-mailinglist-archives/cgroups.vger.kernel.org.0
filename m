Return-Path: <cgroups+bounces-8687-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B36AF8EEC
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D678C16D414
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544C2E8E03;
	Fri,  4 Jul 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g3P1jk+B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884DA2D
	for <cgroups@vger.kernel.org>; Fri,  4 Jul 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622107; cv=none; b=RNsTPc8m+zmOmMe9gp7OKrFUFQCw/Wrbn+kNTToDk8fQFxzEh4dZ560DGLtr/5crCZrKk++KOP+8PxnXk8mGAtetNfxYAL9Ntnixjjx34QnRxeSx1rAo40a66MLRGm5wIjUl8U7+Ygf5iF5lnO7XV13nxj+x+qqW4Hh0rCvGZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622107; c=relaxed/simple;
	bh=f8KJwsnNMzDSXCcr+Avb2AwztgI5qoTLwLOR6IeBS/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+Y1y2FD/EHoMZBrAjmZILmjZo4hfEo3Tpq7ezKb0QeeiqbJB/ZSqHqb0QBWLKAA7Q5xwPypT8R6LFuVwJSK8bJIUFEI0Aazol0LqFiTbi+Rf66vm2YzEvNMJoGd8Bb848T6mZvxUXY/2TxUX6ofRtaWuL/Bug7zjktn8neGyEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g3P1jk+B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so3780555e9.3
        for <cgroups@vger.kernel.org>; Fri, 04 Jul 2025 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751622104; x=1752226904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8KJwsnNMzDSXCcr+Avb2AwztgI5qoTLwLOR6IeBS/c=;
        b=g3P1jk+BlfXibf9qbAcB0lx+KlcwRFQhHefsB1vY4n68GFZ4oD9LovXHi+BObnB4ao
         mSAqepJ/qHOCWnisdOXorGRyj+zBFt06cZlccbaigWfpHSFgPSNp1qXlXW9kTzdLnEe0
         c1gl5F19Srx5tBldA1QtG4qQ3SPub/6xFzvTjcman8Mi8MiNevthyfUq+rfeMlCJhtQ6
         QdV3GU72brhtOJBH9yP2W2VLRSQ7ohbifKSNvegnLlMxweo18tudG/M5G1eg6jhCElzi
         T5K81oRAO0OOT8PwT9N/bvY2X21md4TqciP8lGXBKoWay6/ajYJZ6uhjpyyxf7G+IttA
         UP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751622104; x=1752226904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8KJwsnNMzDSXCcr+Avb2AwztgI5qoTLwLOR6IeBS/c=;
        b=g7P4HO5xZmzwQs5L5+RoKnFRNTE/wbrYLcF5tAUk6Mo6kLlQfmn5bkbMQqWQ9a+CvT
         S/SyQ1JmLRT21JpaB+ImAIbEDN4yiJOCRX3eyAQrlKx/Nic/7xUlwGrH8LO/BbTl9v47
         /p2bQYbLAAYqfjgomdrTWKFmPPGPMJagvfXnxab4K/OfJJ0VJsV8fCtTgjPqU2KezMAX
         VRlZpAhFLkUpXB2aaKQOfGpYsVWcPleSVXHxKhBPmObh6//0pY8FWYWvAjBhXZdoqKHX
         TLRMfPnIousPteiMD09Rc0FU333S/ag02OLcFyMG5S5Y33AtW6QMn14EBEYGj0MZ1Ubd
         lM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAOf/40T3RvlyUGON5fzAUo+tjoI39NK18qugWElFt1hvinisBTwXEofSiJ8EsYIfMRWLjQuZu@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/QbyL1FXCPr9TdgwhQZZAcOE+hRaUvrwS3Byrn+/Aqu2CSSm
	uIFd3LcaQsDs8XTpcsmDmTMEqav4y2DfTfWRn8ZnUvTGG/P6yB4gQQQsvHVcNpYcHSY=
X-Gm-Gg: ASbGncuYtL3yIBhjh25oPwshZJYLJ1wrp6c254Yceoada0wIf8hwRRC1NC0gWvbO9lm
	6jx9amUaAa2D6xhuLM2RgqqTL6RmbWnVx+zUuI5XQUe8nBd30XioDqXs936Qi/GPH2EfSUxSc3m
	2NYxGriTn/HJ96bnXXS0Vk4VggpypDX4A+4tIvewv+9J8+2usVwpE5y0lqKeOcCWJtzw07Z95un
	G73i97GrcbkkMRulLphzaiyGHbX0A6/WVzLsWmfpx+ilcanswWhSxilolpsGnODkA3UEN1VXnNx
	VHUa3gAQviRHinIq6D6cOAROD0B6wB6d6s9GcX5NinTwz52vyl1ghshtfD4tcT6YYZJ8uTdAHO0
	=
X-Google-Smtp-Source: AGHT+IGUjYMUD08GoD1AoiKFpUXCYjS+U0f2xn5DR+TvetLvteDx1zxFn8QzKiN0Fr5rObhFCHiOcg==
X-Received: by 2002:a05:600c:19c9:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-454b305fcb1mr20498375e9.0.1751622103886;
        Fri, 04 Jul 2025 02:41:43 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454adc71aadsm38629065e9.25.2025.07.04.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 02:41:43 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:41:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <bc2igjpyzuzkxjrbdhixsuldxatnqqwm666enqkbrm5x2hj7u7@uhe6xouufklc>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
 <aGcf0Prl-hVX2j4Q@JPC00244420>
 <aGd5lrUvm9Bhh-b8@JPC00244420>
 <wnoymxwdikh6iawrcvhewq6er4si75oqzjdbibhl6n57swq3ff@glkzfmbaots7>
 <aGeZwLAuysAmyX-q@JPC00244420>
 <aGebynaCuASn3t4s@JPC00244420>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctjxpi437gfzjwsr"
Content-Disposition: inline
In-Reply-To: <aGebynaCuASn3t4s@JPC00244420>


--ctjxpi437gfzjwsr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 06:15:54PM +0900, Shashank Balaji <shashank.mahadas=
yam@sony.com> wrote:
> I forgot to add the fixes tags:
> Fixes: a79906570f9646ae17 ("cgroup: Add test_cpucg_max_nested() testcase")
> Fixes: 889ab8113ef1386c57 ("cgroup: Add test_cpucg_max() testcase")
>=20
> Should I send a v3 with your ack and the tags?

Yeah, I think it'd be simpler to apply.

Thanks,
Michal

--ctjxpi437gfzjwsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGeh0wAKCRB+PQLnlNv4
CFu8AP9oYIVYY2GTEEdyLaoXHQ4+JBuGrYba76X7wg8t7IV/YAD9GvS9tVBxg9Lj
QT/cJhIuyDcmy+TdsQbo5gmsAgMQ7wY=
=aScy
-----END PGP SIGNATURE-----

--ctjxpi437gfzjwsr--

