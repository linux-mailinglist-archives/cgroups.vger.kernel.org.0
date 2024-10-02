Return-Path: <cgroups+bounces-5011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D798D183
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF94D28468A
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD41E7665;
	Wed,  2 Oct 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxS7cprL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219831E764C
	for <cgroups@vger.kernel.org>; Wed,  2 Oct 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865968; cv=none; b=JAYKY/BCrd5bOjyF/UBHkIzzxeT7DdLOLiS/wmwWt2To5EZm5bUlIn8RWSL5FajpsTQSH9zveLAymJ7ghs1YkES0DjS185cn0HkolNjf2kNFALxt5r9g+rmJNDtSsP0wQQNd7tkPX7x/QlRc3ptiOZ3kZObUMfX6SkQGogiFVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865968; c=relaxed/simple;
	bh=j1jipKhBpX/FlRTd/1TIChevsQmJqofboK5tmbX95yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qauZIS0egcVMptRFFuu7xTKlTfXFy/q8ncEZTc6mnr+Id267EMssIahR31mXpLhCG2wXrbtF0Mzv9LuO833Xif5Mo7t5jal7J+1ALTMAIwzhEFZVc7r7mM7B895ksmiKPNfvvYfNZuyG1lKgfAW/F3WOLLtQGXxfGLlvdZaSRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxS7cprL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso3372845f8f.2
        for <cgroups@vger.kernel.org>; Wed, 02 Oct 2024 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727865965; x=1728470765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=zxS7cprLvBQqL3tgqg7e0S+2wKvbGTQEfS9z9nNGe2Tc3IizJEbNAEnVNV1BlQhLSz
         RzcYh04yDi87YUbNQrQdgPB/hN3BYsIlQdX0270iJXOAO3+DTIkRHEC5VrVKAaZfcSnl
         ZeHwu8vVY1abgPLG0XT2rpOdiK+x8PlmiLJKONsdnjBDBg7gC6H3AApIkigiBxg1sLZX
         q3rxSdJWExV4PaR7hOqY8bjdNpB/2BQ6IhyFM/1EEeNyOPeCPJSmOByi60JatiPKt+24
         vZXCHgG0j4F2I/I8S9uW87H8AqH98d2luVrGd0sP5gmFmDQFibnI4Av8Mumkl7zd/2re
         ohbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865965; x=1728470765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=BMsr07BRoXqCJwuILZ9K6A96P8J+ASpI3dWMI3HYFGIWyOw0t629briV+TAtjJ6x/q
         KfE7IpldxHCrJ36QNEX5AdT4IAZbmniNxRU3mkPkpGeCaP6FMdaSoHJodCA5fF2ENOA8
         MTWQ04t5+KfphavN5GHEXYpcA1HEMjP/pj8lnRGU4IYQWOQaGyJZ/yf13gpH1y4BWMoc
         UYuHy5hZWyjZ0Tmepm7zrMZuRgksFl/OJ/0r+tQSaBGKd9u1NbWx7HpVn+ziInz2+F13
         MXef1x3jVWQhssrNM6OO8TsAjeJpPcicLukTNcZ0ANDAIZM+X6GadhLk1vlwMyQ3i52/
         rSZw==
X-Forwarded-Encrypted: i=1; AJvYcCUgPzvf7nXI8utojgaWgu7y6vdDbvLpO7dxdNKhwtmDrtoX6r5tR+o1gZNplnmlkJ8sIEPlpabO@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBbj3Uah0gKZaq43KCsCb3j4SqVXteRTT4mkqEa3CQk7m52rN
	o9C276+Uuf28Gk5byxLfdOfTP+ux54SByeHDTOB5OJBRaAXBkbBFpFf0mzUJ1Kg=
X-Google-Smtp-Source: AGHT+IF/EJDPE+HOPHXbRDSTkeiUO+hzHFC+iz5emuBJaiUOpXAfIJKgswRfUyuHfngLDtPziZdOUA==
X-Received: by 2002:adf:ec08:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-37cfba0a6cbmr2320172f8f.36.1727865965374;
        Wed, 02 Oct 2024 03:46:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a00bcb0sm15117345e9.43.2024.10.02.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:45:55 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <7962c626-87d3-4c6e-8fac-16653cd2868d@stanley.mountain>
References: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
 <Zv0MtvYFTHlff_zT@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv0MtvYFTHlff_zT@infradead.org>

On Wed, Oct 02, 2024 at 02:04:54AM -0700, Christoph Hellwig wrote:
> s/dupicate/duplicate/ in the subject.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.  Let me fix that typo quickly in a v2.

regards,
dan carpenter

