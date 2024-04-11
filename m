Return-Path: <cgroups+bounces-2440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B558E8A1593
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47A61C21E74
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AF14F9DC;
	Thu, 11 Apr 2024 13:33:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D914F9C4;
	Thu, 11 Apr 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842388; cv=none; b=kPVs2v2zHLbVM8d5iq/Oh+IwgTsheeneEzJkysY3wm1xs7yY+q2o/5migwcKvIsIdp+7eTcKKzIxeOrBbKY1Y+hcsNtxRoF7lvnmDChgPvSfuzck1GH1wDu5XK2OCB91nAQ35nVtfI1woDxab4ka/jUC+DK3xGtgMxlOeyTIkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842388; c=relaxed/simple;
	bh=Hu1xN2JiY9qMgKFHZgQq9iT0bgOzpOMrTuCFIleiTJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPWuSPXnqC29ZMS6bqTuWu2Gt8po9C7OUDZ0gCGtDHit64tsoDbz6DL3HEikCSxTuyjDQNbb6JFJ0bD0cUmTra10u3wtPsV6aFWVFbr6tlEVUPONxFYwG63OIQ0Mnz2p9Y7JnrZI925bzbIqLeo0TMwFfzAF1rqx5E93PFV0F9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d89346eb45so56129561fa.0;
        Thu, 11 Apr 2024 06:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842385; x=1713447185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoFgjJ32tsxlVGtTa5gGB28oxhJFPr7M0nD6tH1rarM=;
        b=PthL68uElizIUQwzTwjN6yt6Z+fgLYo2II/YyW9w9F7lZGndqBecamnVOqaAwcKrND
         xBOqBXSL241mDE2ugZXfCuHH4FZ9Ddxq+Q3mGT4rvnskW7of55e+W5KvcpQ1YPJnom1I
         0ssBBHGUf/zxrrrLGlnUJ/5qvPtwDL6tUQlEkGQw7zfqvefBcBlYLKROY/nVBMUJpmyv
         lKx2n26T0tuqSBt/Sy/ASaxBcgp02s7lyXAjtroA942eVaMHt/C9WgKsfYwtGMGRX5CN
         dpQ3QMQU46orcXTr5tMevtaJdlrj2InYYkBs421ZIEg76YtQpBhNJJpQ9whc46B1Dp03
         HObg==
X-Forwarded-Encrypted: i=1; AJvYcCXUAFWStBALYBLNHU3G4xfitcdID/AgO2mDiYUQnRCXrpLNe5SHC1XIIOPT9PEyzigLnKXaeTm5G3ZDRzsVlARN5ugcPCVsFrMCwjh8KQABSbPzouYU2Pr8K1mmdHId/u05jvkbzGNPqW6hS4KYOfSPG0q83+QXdg7a7ZU4DlZBpQ+1
X-Gm-Message-State: AOJu0YzUP/9fuTJSr3nvDR9kud+gnYG5VCHHOhgJgFVRtY+L6daVG5k8
	vvwzMfHkJUxsQSoX1ktQs0qKgxdTH3zv7fUOKTnPgTx4khWI9dRf
X-Google-Smtp-Source: AGHT+IFByJfC9hbYBeCLoTSUE6m3SAZ56TJRBSVxKGqApn7flbJoLNyy3Sp4kVZ3NmAPlJJgNRuidw==
X-Received: by 2002:a2e:a9a6:0:b0:2d8:8633:ff70 with SMTP id x38-20020a2ea9a6000000b002d88633ff70mr6469091ljq.30.1712842385060;
        Thu, 11 Apr 2024 06:33:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b00a51be2b75f3sm760606ejq.35.2024.04.11.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:33:04 -0700 (PDT)
Date: Thu, 11 Apr 2024 06:33:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	leit@meta.com,
	"open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-iocost: Fix shift-out-of-bounds in iocg_kick_delay()
Message-ID: <Zhfmjoa2l04fXIVr@gmail.com>
References: <20240410193642.1303741-1-leitao@debian.org>
 <ZhbuUKXQwBwye1_r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhbuUKXQwBwye1_r@slm.duckdns.org>

On Wed, Apr 10, 2024 at 09:53:52AM -1000, Tejun Heo wrote:
> Hello, Breno.
> 
> On Wed, Apr 10, 2024 at 12:36:41PM -0700, Breno Leitao wrote:
> > When running iocg_kick_delay(), iocg->delay_at could be way behind "now",
> > which causes a huge tdelta difference.
> > 
> > The tdelta value is used to shift some bits around, raising the
> > following UBSAN splat:
> > 
> > 	UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23
> > 
> > Debugging this, these are some values I got in my machine with 6.9-rc3.
> > 
> >  now = 3626064295
> >  iocg->delay_at = 3275794093
> > 
> > Fix this by validating that the shift if valid, otherwise bail out,
> > similarly to commit 2a427b49d029 ("blk-iocost: Fix an UBSAN
> > shift-out-of-bounds warning")
> 
> Rik alreaady sent a fix:
> 
>   http://lkml.kernel.org/r/20240404123253.0f58010f@imladris.surriel.com
> 
> which got commited as beaa51b36012fad5a4d3c18b88a617aea7a9b96d.

Even easier then. Thanks!

