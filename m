Return-Path: <cgroups+bounces-8770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7CB0A484
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755947B05F4
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471522D979C;
	Fri, 18 Jul 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOUiR3YF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33750295DB8
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843320; cv=none; b=D8kQ8iJ7fxMPfObGjtMTBNw4UXbrk1/BSRH3CEFKe8OCcYmmdoZVHMu9pJCRmHY49KTeuH/1xMd1Fi2Q+wFNNzK/l8cqg1Mxz3eMk7VK8LDZqTQ756bzJloyPn74lTTvqfk9tvMGy7W/F5CwKa0LhByHt8fxk6/1FSosbW3/PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843320; c=relaxed/simple;
	bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW2OkoKDA/a8fCm/CRr8Fr5qmKsXkHKNpVWFFXdFpA3KeOJUiARbS/VuYuZuoBgU+h4t7tQRjtqFmBEwzDXIVp8Zj1+ezc6aMwy500qk+1X3mVVqSMmmGwAYCAYimZfQxtxsCtP+sF30cFtOxap6s3AAvr82tginictNtaI6UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOUiR3YF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0df6f5758so333358666b.0
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752843316; x=1753448116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
        b=aOUiR3YFVdOPa6YEXFvhZLE9iTJLvxPOhjE4aqtLsgeR/5von0zcJscAlQvj6anHZo
         1D4etNHE4xPdVVIYH6Fy9VULI/BQ8Amqzq987ZnL2X9wcfzehsa6OsFoWhhKn0jpp1U6
         iIC7kHq+Lgyh6f2nS3K6DCci3pSfL9pt8Ymj6xGg4R2fvsmvsT5WDFQvtq6+wQMfAtWh
         7XIoCvbQBMoPb9dReqGBtBetX+rel3IOW+3WoVaVUQdcseJJppM/XRzzdd0g3gYorBnP
         j0ZLZcyFvwKfXynMaXWycNIGA6PfcpCMRJYWAGBd9qg7ozyLqzmRScJPLZUohEEQMQUz
         nfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843316; x=1753448116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
        b=QFOabIVqE951Z77/yszIO2Bhf9AhqiVWQ+ARBffohEepy2AR3IYZTpSn9rgjnr+JE2
         HB6Aeq/Vij1bHTYMJDaMgzaACp33jfq2g4Z+6w24tpaPkZP/m7JyuZ48vQXCw6jir1s+
         Rx2rt+TsX4Tls+shyMfgk0GactneFIqPi9kpXwcrWJquGUVwWyni9ij5IRq3ivoLvCpK
         ZyQOfRkJWNBPo1aqpIy0CW0zTfqaIDqVTQlGRJCnn6Qp/BO+N+3xzlBy2G04W5gwuw74
         0HShmjAS3NdJ+38IkKu6qFR9kFqz02PMEkEI3E6ll+BgcqFpMRV36VjLBnAemB9OlA52
         0dpg==
X-Forwarded-Encrypted: i=1; AJvYcCXfEiL5sQD7HYUQUIxkbrUo+f1PCpUTAnRHGfGp1i8a59QFNXO+s9g3qrbXBu+OaXRHNuFJHHp9@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ88NMW7Z50VXpV27p4mJk/7jKOV+yHDPdT/mG20PIG/LqJM0o
	FYrYYNEfOu06q5BNnUCruMhgBsMk5kdkliEWxTuRVv8WZcJHEhureHi9JCL7wfmzLRI=
X-Gm-Gg: ASbGncvhCqPpXSu6fsV1BII+L8ySpafCqug6gOgzeSEarRg+Xgyh7y2w7l2xE/9HQG6
	9Ie9Lr/SLpl0vpzopVU4W6SezRJJ/b/H4B3TzpUruPt6YOvRg8EAgz9I559UyF60zz4lrlLwmGM
	EuRzbNXhBmxFCzNbpz+NWUng++1Elr5udKz9KdkIgFi05ApHwvelnPesQ9dT4mld8bDChujrgtl
	WiJQZZ3FNQVgPeJ/a0Rkx/wW9tfO5MYoiRe3a5Pj9jD9xEVD6+7KFOKTd/o7rQujuagzn910yX5
	GJJmTnzB/3gJ4ND/V6XRaKrqeaAl8ISe1jhdyxjXOrULB2pgvvSpa7IpbfdNsXOfvp6tX6GqwRB
	dmUQgdIew/pCoTDGSoqWWNc7yF1XMQCeeLkD5os9E63SLCqNap8CK
X-Google-Smtp-Source: AGHT+IEDd8o5qENEV8z7wOzGgV76OAd6eyt4G/o3gZdjbTKFnZihnkfwJCXrzidGiE+3z1dLAXqMig==
X-Received: by 2002:a17:906:d257:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-ae9cddea78emr1022205266b.14.1752843316310;
        Fri, 18 Jul 2025 05:55:16 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca817acsm116348766b.131.2025.07.18.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:55:15 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:55:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijiang Huang <huangzjsmile@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijiang Huang <kerayhuang@tencent.com>, 
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
Message-ID: <mqzlqupbzt4zlsphipac4qz75uzzhcbiuxez2bupmcatp32hkw@y4ltledez5y2>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkznbscjeqxbsktm"
Content-Disposition: inline
In-Reply-To: <20250718115409.878122-1-kerayhuang@tencent.com>


--kkznbscjeqxbsktm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 07:54:08PM +0800, Zijiang Huang <huangzjsmile@gmail.com> wrote:
> In the function, after acquiring the mutex with mutex_lock, multiple return
> paths (such as returning ERR_PTR, NULL, or normal pointers)fail to call
> mutex_unlock to release the lock, which could lead to deadlock risks.

You've almost convinced me that you've found a case for the scoped
locks. However, this patch doesn't look correct -- the lock is released
in cgroup_pidlist_stop() + the comment in fs/kernfs/file.c:

 * As kernfs_seq_stop() is also called after kernfs_seq_start() or
 * kernfs_seq_next() failure,

Or have you found a path where the pairing is unmatched?

Thanks,
Michal

--kkznbscjeqxbsktm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHpEKQAKCRB+PQLnlNv4
CI4+APwOU4L//IIlbdg31+dRLygCkDW7N3RBdJrIuJJaCtmxGwD/XilJ674QgJUF
btY3IGq540HVGmD8ej3GV8x1dFdRTQc=
=yyIz
-----END PGP SIGNATURE-----

--kkznbscjeqxbsktm--

