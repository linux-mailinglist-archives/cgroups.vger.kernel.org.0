Return-Path: <cgroups+bounces-9162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8DB26AA7
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533127AAE57
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F6221571;
	Thu, 14 Aug 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KyrQDlp8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457621ABA4
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184666; cv=none; b=s71081/uRt9Nvbqf2GtvWpTszQqZ94qpUa6O6/R3yYdRal89Qm2kbr3uv4oMBvBhjKj/i6oYIwJU4jv1tv8yJTPkO7hiaroO0r1+dJEKIniDb431/0aGVciMdEAVLZ6mGfiZLNAUKSsIbE6/p0UQ+PuMDf0gaCg5JcgoBQDhE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184666; c=relaxed/simple;
	bh=jebkRezHI9tnuDesgjFDZKdyprU+i58WH5cbBdDaPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4ZCeXdIlnTIjWksQcAU/0RM/YAp0hx8qqnXeIwnY/EGJp/sT/5osTFeetoe6yYWUxzysuBrMYkIWAgvEUo+dwGenTvJNlT23no/bnmzruQLcks/OkuAq6Jilchk1gsa/uIlU+o82BuI/2dSKnz8MiUeTnGvRZDJXdL0zNFUT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KyrQDlp8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e4193083so913851f8f.3
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755184660; x=1755789460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bPCyFEVFb9QBBc46MlBjvus9sTU3F14kHpN5YVA+9Y=;
        b=KyrQDlp8x99YWrksEidXMTV7K7LIIYgqnGS7tCf78uwdjONAM4g/oxaOGmxHsQ9H7s
         JFL15sPdfCpnBaNvsdroT9JD0Wo5KntWGveNatjl3/Ewa3mld0Y46ELSCDTY978GR5Aw
         K5vORtFZuBuNOjFC3NPgqggcP98CS3eTr23Ff5tOCIezJg1QwBwFZ73AkGjKGlNjM4Z3
         +u2EsViWn04YHpSm1RV51++MPMMKaJ7Sv5wWtcdsvSS3kSvsXMZ3Or5usW6b4xuzrfDJ
         hB5lpV3ZXx7L8Plhd7rAe4IfOzuCUqB0WP9zEtK85KWyJsbjhnl5PnSVOyeCsa+59kq6
         JdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184660; x=1755789460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bPCyFEVFb9QBBc46MlBjvus9sTU3F14kHpN5YVA+9Y=;
        b=khg2HTAXKPU0idD7KGcpc3QXwyBKnT3ApyFZn2Up0/BdzVFP/WlFxIAH8D9NAQPCJ9
         nQKK6IZkKHFuahohoUQSu9eNDZjv5CbbxaFzYBY/UxhL2cK9JfHvyshm4cpuLV2JD/Tj
         H36RrQevXcsuxMu40Ewir/+MBU2gZHvYs2xUC7OVeUPOErLjrX2GWIkTVvuvKX3u93wd
         RrxwC/CnPFgUM1KZoE8LRd6j1WxyG7JXYjy3O77GFsar/ZChFCvqOV3M/ZhWQlDT6YWa
         bizAOoiTAqK4te0t9RUNrnkSMYSi9EIAQvlIgSgLu9XlQMn1eJL4HaaAPhMbqMJD022G
         TGYw==
X-Forwarded-Encrypted: i=1; AJvYcCWt0Gw6PPUaOEPd62OKx7LlhTRs1fw3bBx4ZgxEaQJ1Q897Gjuq0a+OErBWJr5/At2EpD1QN5Kk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JjSQRaFV5BvizlNI/VvsOkq7KyTcUcNtv8Z7JSFtF1WbwS9M
	IVU3IIJvzlfagPadAdKsRaOXu7Yg9omO7toUsGKGkMzPlfCDHTgvasMwlNV8q3tDAHQ=
X-Gm-Gg: ASbGncskZgz7sR/KmUcet4TrhUYxDUeAYUSkggV5/TKlkqJw8hwy/Agm9qUL5SAOcBQ
	xj8m65flTfqhFAJzThLh2Z/xEKRDc8biazWqaXF7Nm0tZTSTaukb5vNIQ33v1ZDuMMDBBkV6+ao
	nll6dotSAQ6RIVad0b7kl5WkcIf6KI2X8TgJZNMffVW494DtxSy+X9J27QO6ptZiqUh9hSbG/gk
	5/UTV2W+PPexcr8xuLFeLlHVAzTg1uGFP5De74YrQhUk2hONDGux47AKBiss5UwLm+1dk4Bcvu/
	1WfUSMsFY8iJhu9iAdHFVG1Hf2Xa0+ZZUxCSX1SBg5ecjg722VjyLwX9JXVCRmLO5oznIQn0Kqz
	WcFvlouJh7PPUU8ujNhOmvMQaXGd1PkHpw5w4s20OiA==
X-Google-Smtp-Source: AGHT+IE7suJ0obZmqoydTK2uVUrVJqQaX40zbLZtTWthO0PNMSN/7U4TL/K+YmLBz0Tutg25pJxQ4w==
X-Received: by 2002:a05:6000:230a:b0:3b8:d79a:6a53 with SMTP id ffacd0b85a97d-3b9e4170942mr2609226f8f.23.1755184660517;
        Thu, 14 Aug 2025 08:17:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5f2sm353353755ad.125.2025.08.14.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:17:39 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:17:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com, gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
Message-ID: <btaaerpdl3bolxbysbqcig6kiccdgsoo32td64sk6yo4m5l5zy@nds6s35p6e6w>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
 <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nm367fmo4a37tcui"
Content-Disposition: inline
In-Reply-To: <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>


--nm367fmo4a37tcui
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
MIME-Version: 1.0

Hi Ridong.

On Thu, Jul 31, 2025 at 07:53:02PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> Have you come up with a better solution for this?
> Would appreciate your thoughts when you have time.

Sorry for taking so long. (Also expect my next response here may be
slow.)
I tried reproducing it with the described LTP tests [1] (to get a better
idea about what and why needs to be offlined) but I cannot bring it to a
hang nor lockdep report. How do you launch the particular LTP tests to
trigger this?

Thanks,
Michal

[1]
while true ; do
	/opt/ltp/testcases/bin/cgroup_fj_function.sh net_cls $pp
	/opt/ltp/testcases/bin/cgroup_fj_function.sh perf_event
done
(with pp both `;` or `&` for concurrent runs, two vCPUs)

--nm367fmo4a37tcui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ3+BgAKCRB+PQLnlNv4
CIdXAP4gJKLPertpfmLD61YAP9Wa1M2wVwhki3vo6TMN3x/24AD+OgODyIBF9VOm
9CJVX35w3E51XyIGiitdzxsuttlz7Aw=
=PZvf
-----END PGP SIGNATURE-----

--nm367fmo4a37tcui--

