Return-Path: <cgroups+bounces-5078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4CD99682D
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9AAB21011
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1518E028;
	Wed,  9 Oct 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBKUnqj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72158222;
	Wed,  9 Oct 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472531; cv=none; b=ZcMwoCg6vFSLtbP5Qx6uFGK/6ZxkkRFWS3sDtyZXAfDPZjvTAZca+F0h5bky+wBgIjN0b/xzplxEuibdgpTEprcvCwrXZTdcwpOq3ZtA4hwwHCuWNwhqegeDSjw3BjRXLQtRl5+M9vukvzVo/q6FsMzKk54MxwyDplXtgRc+DmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472531; c=relaxed/simple;
	bh=+ndYs/GIOfiTFGO8209QpVgl17FKbYr2AVIwnExhgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da4YP6PhkuOTAePO9s83MlQeFMqOP7tRUsb/0npKrMgMl6pxSM2YNAvoO/SQruyUuIvImDvz9eWtF1onnYSKwsc1AfO3Ymo9a6sSgVr/Wu9r/01jebED3fxUCcJP5PMCap2lUsl91gTQgvXgt1s3oXnDZc11+dsTMo6OMPLO57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGBKUnqj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71df67c6881so3594982b3a.3;
        Wed, 09 Oct 2024 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728472529; x=1729077329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNRXWjT5yyGkbVZzg8vCqVrNkFA1vXRBzuHn7xu3dxU=;
        b=YGBKUnqjAN1/Qo67tNeBMLcspt6QnS5PlSEKuYd+V4lGt6ChwmmCR/scxM5ryOfOeb
         ayEuflrelWCqfFapgI7jlJd7w3bWubGrrUD+MRzD/BSwb4kwBL2bVo217+TZ3Sz+WCQy
         IwLHP6KsTo+HNVbYWRN4s/qKJvo0FzNnY6dNiuN/viGAg9J4BNHUL2auN8TqdempIqu3
         GNmlMv+NwpAiiKaqokjZMhaJ9S52c9uBvGWpVhnpDFRWYH9A/owANynFGf+a2gx9lgQI
         nGL7hzaO/lmX+N9p+MUeXABcoaVsqG/WTtbtlpEozFhxpxlmwkhbaXizBVzcqC11N9wZ
         Sw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472529; x=1729077329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNRXWjT5yyGkbVZzg8vCqVrNkFA1vXRBzuHn7xu3dxU=;
        b=Eyx9jEr0IM0H2ZAvtowxbSHUk/hJNb17CbxX5et1lZxlT7b5qkufB1mtuyRdjZ5f/7
         fjyUy17HeJmp1DAxDSuzsye6j5g0nVMW/gobl9+FjEr604N+3obQpQCYkSLTzMBK6SIv
         Y2LXniqYWF6Wgvm4+2uECDP0gVfD2fs3iU+oMtK8kVPBZqtzR4SkeA5tnLNQ040T/cET
         HFzrPa+JSwvaLb4iY1H+NIbMZxf7Vyq3rbjW6qEPeDriWiHlBIBdir4eCUB+S4momUQo
         ppvM1htIrzMr35c4p7jc/WhQQC/TjFCU76rz4BLAQ8cguNEgQOVXYxvtTyyanAFIOZZx
         zLJg==
X-Forwarded-Encrypted: i=1; AJvYcCUrCRF5eFQGZY5GP8J2wKkOr0Qopl4al4wHFokUTQ1fwSslC/dX1Lot4fR1661IWV1efG9qxawzbsbCcOy9@vger.kernel.org, AJvYcCVIaroMCOtpYLxyrrDE5C4+bKHbrPA3cA0Ben12+VOyjZJCra3gTjSmtX5EkBIjpJ/yJpbY/PL2@vger.kernel.org
X-Gm-Message-State: AOJu0YxOICH/gAuszRqizoCMML+MTTdboL1m2l+W7YztP9tV70b/1D5p
	FC1L14mlXQZG8Cbb1W51wIQCHoNVLsJyDC1Trajt+TVqpmCdwdcC
X-Google-Smtp-Source: AGHT+IEZgeD96GOr1+VhBWPl7N/ZiMaajRTx1va/y66MfVIjDBP0viFH2puWEB49ZYmYIsLrS/m0WQ==
X-Received: by 2002:a05:6a00:230b:b0:71d:f0dc:ce94 with SMTP id d2e1a72fcca58-71e1dbc21d4mr3042999b3a.20.1728472529522;
        Wed, 09 Oct 2024 04:15:29 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a283sm7555913b3a.112.2024.10.09.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:15:29 -0700 (PDT)
Date: Wed, 9 Oct 2024 19:15:24 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: xavier_qy@163.com, longman@redhat.com, lizefan.x@bytedance.com,
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwZlzF7NsNF5jz5Q@visitorckw-System-Product-Name>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwZIXxQLyJUL_nOW@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZIXxQLyJUL_nOW@infradead.org>

On Wed, Oct 09, 2024 at 02:09:51AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > This patch series adds KUnit tests for the union-find implementation
> > and optimizes the path compression in the uf_find() function to achieve
> > a lower tree height and improved efficiency. Additionally, it modifies
> > uf_union() to return a boolean value indicating whether a merge
> > occurred, enhancing the process of calculating the number of groups in
> > the cgroup cpuset.
> 
> Given that this fairly special union find code is obly used in the
> cpuset code, please move the code there rather adding more exports.
> Even as-is it is bloating every kernel build even without cgroups
> for no good reason.
>
I agree that moving the union-find code to cpuset is a reasonable approach
until we have more users. I could submit a v3 to do that.

Regards,
Kuan-Wei

