Return-Path: <cgroups+bounces-2139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670E88667B
	for <lists+cgroups@lfdr.de>; Fri, 22 Mar 2024 06:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC5D1F231F8
	for <lists+cgroups@lfdr.de>; Fri, 22 Mar 2024 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826548C11;
	Fri, 22 Mar 2024 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="1jW1VcZw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF924BA5E
	for <cgroups@vger.kernel.org>; Fri, 22 Mar 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086854; cv=none; b=JT1FIQAtAhHj1ZotGP5AoeQp1SB6vdGoAyTyQtBIX4bMOxiI7vffBisvBhuLP2zWhvS9Xa1OUi4uo+R59I17xZe43BR+OqqXQuKH8wSROK1RF2DLnQdAnr4SmpkgqLzMpI2RYWjX4t/JOHreDQZsJOvybzJnb6UzT0Jp6vvaNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086854; c=relaxed/simple;
	bh=Tlg/ax6+UCfI/wdZ+8azjtrXMjef13MZJZF4ZY/MCes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plmCrjp3po+jOBhyFCQoijncQDUU2PnbeFyV1nXILdC1tBW0ZaZ5u9aubnOyoPriP1rPNJNTl+m1gX3q7bV6dcb0QbJ4uDGHdilDcV7/DmRP29ydvrI7PTHa3KdIjhfFYTFM1MHBZZ+odTy1mpD1TwVGCKxfiAyGM5oEx9YAo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=1jW1VcZw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a471f77bf8eso110971766b.2
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1711086849; x=1711691649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4M3LBQCCMnfIADqywuj2yDe+oiXe7FbERtAdGWqA/g=;
        b=1jW1VcZwc56accSYLPj4AbJ1IIUCeaRBUfFwvcO7fTBhlGLneTzuOX8AjbSrQZvSS3
         yBaxAYoynajx2GxqLYBrMdhpRCVi1S1VlCUdLuqMUnOePnZgC+wYQqaSd4Odp+q9PRSm
         KFyaIXW9aZfMD8TaLRs0HKYQOfpyyN90dGvp4pmnOw4Kla5wEPl0n6sJQjEgz551NPYL
         lq5PWUCxyZ9FvS6RAogQpuufRLkruYFrqMrsmv5PYUyKoBK/ExSdrgOtFkuL9KKLp2R/
         +NbN0nf7xR2oDQHM81uR9XY837aHz8mBSceEixWMykm2dHhaJvKRCa5m8kGJ3peV1qSQ
         fBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086849; x=1711691649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4M3LBQCCMnfIADqywuj2yDe+oiXe7FbERtAdGWqA/g=;
        b=lz0XVA8hobkRl9Uk26jpmKjDysnk6ZznloSLcevVNFYkyZvZbzqwVbhhwaRPMjWNNK
         1n4igMoHt2B2mL0OtlMRcJAB9EUmGvQU1Qeste5t4l/mAKnDG9eQzv+Ippi8OMJK2GM3
         yD29xUqNaVAa8BHwFCwLSOWBoWLkUtQNpPXrOdAjsSd8vRPQMWd0+CVoeQre2SxkSEIe
         Es1W1mDDvSr9F7GRLvjGjmKqQJRY+ih8j3idPaLtfsMLjJ0hvB83h8Rl3qPg4A1vWdJt
         r6VXtNAkVC+wq3ux/M2V/9NKigJ08GPkCoesA3z3FM1zd+AfqLZtRYA5HkZceqEIWQcl
         9Uqw==
X-Gm-Message-State: AOJu0YzvQJPwy8axA9vwnKaQLIWgqZViq77amm9iGLEAB68mPlcXuBiz
	4vSrlc8TDziI2QposTumH+9fDST5zjci/G7/2FPj4L4u/ciE0toWayIen1P0KRAgC8Pp9wB2PvH
	XZw==
X-Google-Smtp-Source: AGHT+IGBZeRTxEMMu0S8AQIUuXoQYuDTpAcGdCOjQJmg0cuN1mo7tVD+CuCR08t16IocnBULsjPa8w==
X-Received: by 2002:a17:906:a452:b0:a46:7ee2:f834 with SMTP id cb18-20020a170906a45200b00a467ee2f834mr916760ejb.11.1711086848914;
        Thu, 21 Mar 2024 22:54:08 -0700 (PDT)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906548d00b00a466af74ef2sm648327ejo.2.2024.03.21.22.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:54:08 -0700 (PDT)
Date: Fri, 22 Mar 2024 06:54:08 +0100
From: Petr Malat <oss@malat.biz>
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, tj@kernel.org
Subject: Re: [RFC/POC]: Make cpuset.cpus.effective independent of cpuset.cpus
Message-ID: <Zf0dAAJ1BH469Oea@ntb.petris.klfree.czf>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <7b932090-5513-478e-90ff-62832d8acefb@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b932090-5513-478e-90ff-62832d8acefb@redhat.com>

Hi,
On Thu, Mar 21, 2024 at 09:41:43PM -0400, Waiman Long wrote:
> On 3/21/24 17:33, Petr Malat wrote:
> > Hi!
> > I have tried to use the new remote cgroup feature and I find the
> > interface unfriendly - requiring cpuset.cpus.exclusive to be a subset
> > of cpuset.cpus requires the program, which wants to isolate a CPU for
> > some RT activity, to know what CPUs all ancestor cgroups want to use.
> > 
> > For example consider cgroup hierarchy c1/c2/c3 where my program is
> > running and wants to isolate CPU N, so
> >   - It creates new c1/c2/c3/rt cgroup
> >   - It adds N to cpuset.cpus.exclusive of rt, c3 and c2 cgroup
> >     (cpuset.cpus.exclusive |= N)
> >   - Now it should do the same with cpuset.cpus, but that's not possible
> >     if ancestors cpuset.cpus is empty, which is common configuration and
> >     there is no good way how to set it in that case.
> > 
> > My proposal is to
> >   - Not require cpuset.cpus.exclusive to be a subset of cpuset.cpus
> >   - Create remote cgroup if cpuset.cpus is empty and local cgroup if it's
> >     set, to give the user explicit control on what cgroup is created.
> 
> I think we can make cpuset.cpus.exclusive independent of cpuset.cpus as a
> separate hierarchy to make creation of remote partitions easier. I need some
> more time to think through it. I don't think your test patch is enough for
> making this change. BTW, you confuse cpuset.cpus.exclusive with
> cpuset.cpus.effective which are two completely different things.

The exclusive/effective confusion is a copy and paste mistake in the
description, the code should make cpuset.cpus.exclusive independent on
cpuset.cpus, how is described in the initial mail. I have pasted it
from my clipboard history and apparently haven't read the whole string.
  P.

