Return-Path: <cgroups+bounces-5036-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE29901A6
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2024 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E17728277B
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0A156C78;
	Fri,  4 Oct 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2R7lRzx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14665146D6F
	for <cgroups@vger.kernel.org>; Fri,  4 Oct 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039213; cv=none; b=RpZH5vgW2bUq6WpPSnN1l1TNIc5aN7jBQjQ32jaOzZIxPoF47G8qLeeJeRbHkn5aF4DG5IKfb4VVhvSBkFZTjDFa6T27kghF5WHK0p9+84twoJthuKx1KTf6lrhH8zUu7FNtQCihODxBPkZYFm7AjKr0IaC9NNAsavYMCT9RWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039213; c=relaxed/simple;
	bh=PzKdKo+6viG8ybT5p4aenEuVziOs5E1Eia4x/Wj74Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqlHQ1bvXi5uLCDrg4Bs/zqCadEz7kSNZGhbr/d1NU8IGjkztmCTtmSu+zVg4WkSQl4zG6TJDGfNPn/6ypxG+em7aEpN7CIOGncX/n4jEDegrgzmB87ZRKMeR0O+egWT+iDWjVFbOv4sJod4EFsRh6Mq9TRU6A33cEaK20K0tRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2R7lRzx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cc810ce73so1188341f8f.1
        for <cgroups@vger.kernel.org>; Fri, 04 Oct 2024 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728039209; x=1728644009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABWVEZnDfVLeVPAj/zUum6wdsVi6WG7u6OOY9X43WV4=;
        b=y2R7lRzxr8Pw023GiX61Nv6KGlyPVEFGabjNDBVcVXNC1KuY4y0UUXdoeG95g8TpKm
         0N/x3T37m5409q5ympbbfaADRHtgmgKbbEDR8CuDR/EBU1ScoyHnxif2PquzmMdcGCdP
         sqTCRh1np/KXb3MmWkNUlFpPlT+gHZLtzojKIccD2CynlurUXDJGAmOGl5XCnYpfFYG7
         uTNXrORyx3k4azi2rkpy2m26j1u2Tg5s63URCbFINfeKKCKcZrGvquRIFEVRKajPyN0N
         yf/itP2XmoWDI1jdylicpkkpJROT4IwQtOTpM6m5+xjow4KPbCfr6bkN0Ig8PL11lfeB
         Bx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039209; x=1728644009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABWVEZnDfVLeVPAj/zUum6wdsVi6WG7u6OOY9X43WV4=;
        b=aiduV2J+DOlGsjMaDiPZpokuU7in6kSulH45m7Gr5cLDcjlLivF5aOetAr/Tes/Cg0
         ztO3i/NHMYFiwTTPq3DRj8RnIRb+yhcLX7Wp2vO2M+q3NURiY2yrOT2GJY2QWH4o7J4d
         U+KU9yasplug5rlvSIdYOdu5Qzt+nwlqHubozyEqQXV8pDyQQCmGNFHMwlwlrGAWYkKZ
         91uuEhZsCOMkgltuCnK7P92iUNAYsph9ELfAh2JyA85D+84bqA27roPC95LVHckP7REE
         JL69+ZrvgQvbdizvLw+vVE/gOgaTwaWukyH/1dMXaipw5WUzLjDxceGFAbOGOphUpt4h
         Q0aw==
X-Forwarded-Encrypted: i=1; AJvYcCUDhT++gcUPUx0wvKx4a2e9B9gB0lsWx2+MxcD65wyVrp6ISTdOcEcw4xlrLirBeyVCwCsX0dvG@vger.kernel.org
X-Gm-Message-State: AOJu0YyteTJqOcL5g+HqRqeJdfa50IPrTknY2h1CBXfDxFHAjNtMLf9Z
	mlqIZ0ucPf1SGQp2G6+nQRi8jU0Pz4Oz0S7YHrxfq+Jq0u57KzOgQsiMO9TF1qg=
X-Google-Smtp-Source: AGHT+IEkdLbehk6VGRk0CI7zwvonPN6LVZnevW4vIzHsEFitfQTuqEF+iuYKEYiJ2wMybm3F0oINLA==
X-Received: by 2002:adf:ce8f:0:b0:371:8a3a:680a with SMTP id ffacd0b85a97d-37d0e782737mr1354874f8f.32.1728039209176;
        Fri, 04 Oct 2024 03:53:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0826240csm2993941f8f.65.2024.10.04.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:53:28 -0700 (PDT)
Date: Fri, 4 Oct 2024 13:53:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Waiman Long <longman@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>, Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <43245907-0b08-4e18-b58c-a36ab0f804de@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
 <Zv8LAaeuJQkvscWF@slm.duckdns.org>
 <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8NBM4mOVoMoBQS@slm.duckdns.org>

On Thu, Oct 03, 2024 at 11:30:44AM -1000, Tejun Heo wrote:
> On Thu, Oct 03, 2024 at 11:22:09AM -1000, Tejun Heo wrote:
> > Yeah, that should be spin_lock_irq() for consistency but at the same time it
> > doesn't look like anything is actually grabbing that lock (or blkcg->lock
> > nesting outside of it) from an IRQ context, so no actual deadlock scenario
> > exists and lockdep doesn't trigger.
> 
> Oh, wait, it's not that. blkg_conf_prep() implies queue_lock, so the IRQ is
> disabled around it and adding _irq will trigger lockdep.
> 

Ugh...  Yeah.  Sorry for the noise on this.  I've fixed my checker to not
print this warning any more.

regards,
dan carpenter


