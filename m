Return-Path: <cgroups+bounces-4988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0598A373
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 14:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA5F1F2404E
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073218E023;
	Mon, 30 Sep 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dd9OB9uA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9ADB65C
	for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700622; cv=none; b=gRIHDLZ5S3ok4fJ6zDcZ93tiemvE62D8M9nV5j7lu0U9PBC5hcBQN4ZwehfXsAr6u2LAOk4fEQHp56/nJRy51mtsavqX0CbSOuLBorxeuZVyluc9BPHO2hQ6R6wvW+RF2JLdBTOxW32aV/77poB5zG9teMIym3OUJYJv0w4Np60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700622; c=relaxed/simple;
	bh=Ae6fHVmCIfVJ4+AzMERz/YbJyUGo91QW663NFmx0Lvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f37XcXgCT0x5f+ulx+HZWrWt33g6HJIRvoxRMeoFtwesceRyw0Fb6YYI2OgiK9Vj/0iyMZG5lvTZR0BCZzvSCpCWjClAYLXO9kz4oP/pCuKOHCAXHZ/YRSlcMGUbNEJj1mNaZFCzsosr3WIs3Lu9XLb/Fh3zdT5yCQD8OMnlf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dd9OB9uA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53991d05416so1447530e87.2
        for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727700618; x=1728305418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae6fHVmCIfVJ4+AzMERz/YbJyUGo91QW663NFmx0Lvg=;
        b=dd9OB9uAvlzsCCff0RQAQt8XL6cZzRfUBdVwxxKOoQm7eQqf3BTO7iBSmYWOSF139T
         ddebyQbRTuf8Mokq08VTI/NYt7mC+70GFJZLvvwxRqEuCM35OcAkljKJYpamso7epN/S
         0CbQwngZgRzYaV/CE9V9dIkfsL4uDwhB4HPOmLPXfYh6zPujHlvYdrgYJg/9G1RNmzwk
         qi9ErysU/9Niyv40urbwHYx6FD7zlLHMbmmylnVWhcn6szbYIrwi+MdjcbvMlh4ElauD
         kxz9t/UbnEiY2/zyjitdOv2w4sPCxjkOz55KGrvgCR90Umr9mQP2oRxcEkfN5o0SI3Vo
         Q6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700618; x=1728305418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae6fHVmCIfVJ4+AzMERz/YbJyUGo91QW663NFmx0Lvg=;
        b=xJDZPDJ/mMyAufIyBVGCH8M4MiRbakeuZI6SoxRJZi+9+hCLPtB02qd8DLn0ZHejsv
         OKUz2Ebh5wvz0E/ywHa7q5V1RB9xxLv8c52I2urjz5qaKq+G/j1qDjoZZx69A+D4fiWZ
         2/aJK5OvKQdFNaUyYoaG6CXdHJVSewxi4kiDDaWK2ga/yABT3PhbHlU7aQ5EVCkgKFNC
         tNSoiIle82kBO3MSGT6atiAPucxU8ess1Fc0F/pD3mFXiDIQwUueACxubfRYufQpE8oj
         qhlZXeifRTu2s/tyeGekPyoKIImyF/XaBPGSYNpgPqTMv6yNJtztBRfXdG1E6Gn7CVIM
         s+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW22eqFcKW9Zz5b/SH6AckWKbeCZCJKJQqBI1/VX8i9p7koS7crr8tvxV6fvwMma9CWURuftsE7@vger.kernel.org
X-Gm-Message-State: AOJu0YwePpijBZ/1dLO/qJTPQ6BHtrbLP4DovFxnB8KpkJ7S2/Pmz/zn
	8qjbuqw3oUnVMlTgdmEkb3JOvLJ6xwY6C1OuKVEa1taRQjZLy/wfhpCgXDUlOaQ=
X-Google-Smtp-Source: AGHT+IHNtGIRXS8i7sXXHufH8mFkbMkr6KqSwOLz+zsKlUefPFDs4E7VjtiNBZAlfADWmkKM/c304A==
X-Received: by 2002:a05:6512:238f:b0:538:9e36:7b6a with SMTP id 2adb3069b0e04-5389fc4b91bmr8103339e87.32.1727700618292;
        Mon, 30 Sep 2024 05:50:18 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bc88sm535044166b.177.2024.09.30.05.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:50:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:50:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] workqueue: doc: Add a note saturating the
 system_wq is not permitted
Message-ID: <hk4gfwg7cua6rbcly7qzpqah7bfxbzgndgwasmsqqzsim5uxzu@ofpo4e6koms2>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-3-chenridong@huaweicloud.com>
 <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
 <6a2f4e01-c9f5-4fb5-953e-2999e00a4b37@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3msq2pqsn4nl45u"
Content-Disposition: inline
In-Reply-To: <6a2f4e01-c9f5-4fb5-953e-2999e00a4b37@huaweicloud.com>


--u3msq2pqsn4nl45u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Fri, Sep 27, 2024 at 04:08:26PM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> How about:
> Note: If something may generate works frequently, it may saturate the
> system_wq and potentially lead to deadlock. It should utilize its own
> dedicated workqueue rather than system wq.

It doesn't depend only on generating frequency (in Tetsuo's example with
slow works, the "high" would only be 256/s) and accurate information is
likely only empirical, thus I'd refine it further:

> Note: If something may generate more than @max_active outstanding
> work items (do stress test your producers), it may saturate a system
> wq and potentially lead to deadlock. It should utilize its own
> dedicated workqueue rather than the system wq.

(besides @max_active reference, I also changed generic system_wq to
system wq as the surrounding text seems to refer to any of the
system_*wq)

Michal

--u3msq2pqsn4nl45u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvqehQAKCRAt3Wney77B
SR3xAP9PHT1jJtEbsiuiwo1WgbhnDVHPXZDXJhr8SjF3wOi6EwD/ZWIJTwmm3xwT
R0QOL4IXDsaTHR3ZsKwx8/LBEtmwqgM=
=h7W7
-----END PGP SIGNATURE-----

--u3msq2pqsn4nl45u--

