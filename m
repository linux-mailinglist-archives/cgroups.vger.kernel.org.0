Return-Path: <cgroups+bounces-5015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC998E219
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737FCB2203E
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877A1D1F60;
	Wed,  2 Oct 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBkhD/0b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B561D1F4A
	for <cgroups@vger.kernel.org>; Wed,  2 Oct 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892645; cv=none; b=QhdzS/PLILx7Zug1UIfmsP1hICaZaGUVcptZEvc9rZYPW6YUXA+wqtWDRGXFoYfRurSfqYB9ETL7bprhy8MzQrPWlyIxeSQu+YRDJ+oWmkY6NwAkFs2hroG0LyY38A1CHuCtXF6f83JUgr6GZbECmhTA0bscuNwuR3cCfP6XGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892645; c=relaxed/simple;
	bh=DK2MUVdAtluMDn/IwETewEanduQqhHxMYakPpg2sRc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK7cKPg2SIsaWZd7R9TLKHDS8ZcgXjSgyeWXAX5RwON2235IqZaS66zZZnCqFEHVFthoj3fWiahYEvh82M9sQodp9NKsSAJjiYQuhRwPpKKdi71MdM2a91zothOQKZmhd08dnkLtxjvHQyQL8CPWTsh/g05Of1qe4aX4myS3ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBkhD/0b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae102702so305655e9.0
        for <cgroups@vger.kernel.org>; Wed, 02 Oct 2024 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727892642; x=1728497442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=QBkhD/0bHd6wPrT0PPMh6ixOMyQJHb7CoaCfFFXFhHZueDdjLow9Jm+AalUtT1tPMS
         j5WUj/X+Cliq5zbPLdZRpryDQCmDpek7CFzroQsoaO7c2gj1nQ8e2fSKuXqVS1+l0xMl
         VCdN2PYBTbum0CEr7FvG/9iQZnh1SbPqAv4tdLnxo0rece6MX4Tu81HlWKEYpUiN7BdF
         IXCpgcD/6gbsJZQ80tfV55rg51TepV2VsM2Lxv7NrzRYFioKtSYGH/zioYgAsQ9WjIRQ
         Ge+IrGpybmhU4MQcSkGCFr6Cqbh0AgbrLoRISW9z/hAri1uPVSaFsYu2oZoWzfCtV+uG
         azXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892642; x=1728497442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=AeZso/n+z7UReSAlWVOwHCBq/H/bo6Pg7sYeBk4fRGaz5lsZ9iN+WJU/oiom9B8eBq
         4IXmv6JkMABjIwrQO1ulBy1RKKJQKrrD9dyOpnMX3gYDQB8ZFVKkI+pVMl7J3l/Ih0Pn
         GloncS/sHTy0rogNofvhF3gQh3g59vhNX9kA40BoIoo5E5uW2hSOZkMflgXFzcDdRlkq
         5PWwIDUuL++DAvadfL9yGu8N0sLC4pM3AmtLLzOcC+LB69oZ8Gnwi24RsA7iAbYYQaw1
         Qt2D1VkEZhCuPI9DWyxR+hdzZHvF+6H0x5xwjmWKUcOmeLad5BxKyjDg+tjYxAAQIjcg
         F8UA==
X-Forwarded-Encrypted: i=1; AJvYcCUnsEOpG9jD74X7Fdyf5KPXeh3O9YwaOXKTVKG6dO01lUfXffhzkRjQqi2U6zdWfKlAqNpWewVa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SR1QToSnQricXyP0jY8K3l2kBLzUe9Kvx3hTE2EaNv1iU8Z9
	bfZx6xZkz4KKFHAbq+9Teqfj+YPGclkynOEe3yTZ2t4yl5Ys2zqzNB+i4xzXWRA=
X-Google-Smtp-Source: AGHT+IG4L90gOtT2GIPiJck56b9/qGOnFxKwX8Omp1g3PHVDmm594jaN0gFUKmmSK7OJWNmzkks2bQ==
X-Received: by 2002:a7b:c384:0:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42f778f2bc8mr31431265e9.25.1727892641539;
        Wed, 02 Oct 2024 11:10:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7728b382sm19659855e9.1.2024.10.02.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:10:40 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:10:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waiman Long <longman@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>

On Wed, Oct 02, 2024 at 01:49:48PM -0400, Waiman Long wrote:
> > -	spin_unlock_irq(&ioc->lock);
> > +	spin_unlock(&ioc->lock);
> >   	return 0;
> >   }
> 
> I would suggest adding a "lockdep_assert_irqs_disabled()" call before
> spin_lock() to confirm that irq is indeed disabled just in case the callers
> are changed in the future.

It's really hard to predict future bugs.  I doubt we'll add new callers.
Outputting this information to a struct seq_file *sf is pretty specific.

If there were a bug related to this, then wouldn't it be caught by lockdep?

The other idea is that we could catch bugs like this using static analysis.
Like every time we take the &ioc->lock, either IRQs should already be disabled
or we disable it ourselves.  I could write a Smatch check like this.

KTODO: add Smatch check to ensure IRQs are disabled for &ioc->lock

regards,
dan carpenter

