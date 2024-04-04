Return-Path: <cgroups+bounces-2312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3750897E39
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 06:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3822D1F22722
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 04:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69F1AAC4;
	Thu,  4 Apr 2024 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="n1p/xyaj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411018AF4
	for <cgroups@vger.kernel.org>; Thu,  4 Apr 2024 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205566; cv=none; b=tX2YQcKdKxW8YYaxJ4+x3Bs3LGlfHFaAdTdjIfL1N6xwiHvaZJrXQkdC8BXWP011kOBVzYXTeSeqtcWFJNbPUHLs2d69K2beNEb7tofoT2O5cx8VQAH1p6fpUjaa07STT5PB5X7iFSR3aPBK2AAITR1uPBfSzRINHwMrgqBzMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205566; c=relaxed/simple;
	bh=pgTYXvTl3Q/soSKsqLecxYeXRL0lBO2ia7kP+I7D0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv18zeG2nj6H+TV/NlyzhRUdnKHQ+rxmUVQGP8XtvR6Fo5PoF+/55YqSfOPiYx5vyUBsjFB3+6ZOOG5PAbt3CQKOCq6K5Jw8Z8Wy5owfByXistVTrMQ9qEpK7FXVI9b9Wn4gLjug2usxIMNk5K/DvauBjmRXbSYoHG0Hd0vgMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=n1p/xyaj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d485886545so7987441fa.2
        for <cgroups@vger.kernel.org>; Wed, 03 Apr 2024 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1712205562; x=1712810362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEOAYQ++eOSF99LMPQNDnxVmDipaoC5YscAs01CyzFM=;
        b=n1p/xyaj6VdRmZS8dITK4+/NhoLTy+CV6YvmudmNgWtO4lahRo9Rp7q0rkMiULHVaB
         3Y/b/GumarXkdk49b7AlP0zzQeA9sFukLJwTD19cHtEJfsTVYxyS1/GlmPcpZdanXiuj
         F0ReA4/iV/wHbCMtedYpktM7hzZe4xCbeuQLT1Jpoe+qoleRNMci27A3v9W6i2YN3kNQ
         XAh7nvdrd2vkNu6S3oKsUNSEByzC/qsa5rfKqJLiXFn/NyNEm8LFUaLQwrP45HmgLTG7
         CY9OErpObOjR24lPVXOjFIITUhJVgL5o62+GQ9LsopKyLR6z9n8ImO9j37KaoY9xpznN
         dFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712205562; x=1712810362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEOAYQ++eOSF99LMPQNDnxVmDipaoC5YscAs01CyzFM=;
        b=jqjyDf0WUG6taNNIUhhPx4Zfhs9eMJg0bUgxU/8DtUAK/D7wZtkgHiQ7nPvGpu1VDW
         2QlQ2Xgl3ehpA7AtVCv5lBJkeb0jxAkjU71e7eva1C8gS/3HNIIH4+2QvItdVy/8Vf6N
         OXDAwUyACkqIpPwN7OLkFswbHtnnVvGfR6OQ9vYjaAf/rhG5hQ3nLNVEHRB1q+Yp68N2
         B1+wJ9+299lHIgFxN5R6OU/jskDTyo1/borqDQNig9adFF16hEwflN8ONIwfKZQTEOzS
         +sw3LWfNO2e3Ex5MwqPgM0N5ZCE2+bzG+H2Sc9rk7cmAZrLzG9uNRlwr4V9x1LJ+rWBm
         BJhw==
X-Gm-Message-State: AOJu0YytTPrkSJ5+R75RO6gyRFL8E8eLsGREhnsXDI76/0xG9avsGcpM
	zR9i2NdgUa4keqLfPINPPFUpjJhW40fHORHUP4+qZYQ1/V2dLbGFwJvJs5TKHg==
X-Google-Smtp-Source: AGHT+IHNQnPdluTnSGnpuQ3YA9d/CR35BqWjLtSvE6AgGNek8cMUz+3MTjkyyMflq2jJIW22esbdzA==
X-Received: by 2002:a2e:8457:0:b0:2d4:5c03:5ccb with SMTP id u23-20020a2e8457000000b002d45c035ccbmr1147905ljh.10.1712205561541;
        Wed, 03 Apr 2024 21:39:21 -0700 (PDT)
Received: from ntb.petris.klfree.czf (178.165.201.129.wireless.dyn.drei.com. [178.165.201.129])
        by smtp.gmail.com with ESMTPSA id js19-20020a170906ca9300b00a4e8353be19sm3034485ejb.224.2024.04.03.21.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 21:39:20 -0700 (PDT)
Date: Thu, 4 Apr 2024 06:36:56 +0200
From: Petr Malat <oss@malat.biz>
To: Michal Koutn?? <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, tj@kernel.org, longman@redhat.com
Subject: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of
 cpuset.cpus
Message-ID: <Zg4uaCep1Sg6Ynkl@ntb.petris.klfree.czf>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz>
 <xdx55wvvss44viwmszsss2tohyslirqu3jrrexroyc5knamful@2sdajjhw45sj>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xdx55wvvss44viwmszsss2tohyslirqu3jrrexroyc5knamful@2sdajjhw45sj>

Hi,
On Tue, Apr 02, 2024 at 07:04:58PM +0200, Michal Koutn?? wrote:
> Hello.
> 
> On Thu, Mar 21, 2024 at 10:39:45PM +0100, Petr Malat <oss@malat.biz> wrote:
> > Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
> > hard to use as one is forced to configure cpuset.cpus of current and all
> > ancestor cgroups, which requires a knowledge about all other units
> > sharing the same cgroup subtree.
> 
> > Also, it doesn't allow using empty cpuset.cpus.
>                                ^^^^^^^^^^^^^^^^^
>                           _this_ is what cpuset has been missing IMO
> 
> I think cpuset v2 should allow empty value in cpuset.cpus (not only
> default but also as a reset (to the default)) which would implicitely
> mean using whatever CPUs were passed from parent(s).
> 
> Does that make sense to you too?
> 
> Thus the patch(es) seems to need to be extended to handle a case when
> empty cpuset.cpus is assigned but no cpuset.cpus.exclusive are
> specified neither.

I don't see how this could be useful - consider hierarchy A/B, where A
configures the cpuset.cpus and B doesn't and inherits if from A.

If B is then made root partition it will use exactly the same CPUs as
A, thus these CPUs will not be available in A. Also, there can't be
a sibling of B, because there are no CPUs left for it. As B is then
the only working child of A, no resource distribution can happen on A.

So there is no point in creating B and one could use A directly.
  Petr

