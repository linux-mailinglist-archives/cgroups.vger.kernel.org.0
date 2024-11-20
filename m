Return-Path: <cgroups+bounces-5650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8EB9D3EE3
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF1DB36FEA
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6941C7281;
	Wed, 20 Nov 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z49uxsyk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D331B9B50;
	Wed, 20 Nov 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114742; cv=none; b=talgwYOC4KoKuUEV3iabw02861f39MLQ98JEDllWLaxidXE6RGK10Mrh0SUhbuOKfg/vMR+VdlxBl9DRLWVnHqSxSnjDfPCx3nB4CbigWOLKJHTu10syCI/i+DznUTy5YTGLEArZTpNimsFFWAJXB5C+Pc+W78gSTZ+K0TcHOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114742; c=relaxed/simple;
	bh=RPTB3KechpAl4PhGA4iJyVy8SRU9IhGNpYs5OQEcPNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnhEh0VsRuL408c9Pp/xt4u7UdJUGGcPMxaOVjFN3fjlH/VkGZWftRptwBGCG7aJygPB5ZaiUygs06xcIU8S2SLML+an4cOe6WNS/ZNo0tw/KdHmQPXyKr2y6xptXhWxopmSoFePyDBtO4HrKHyudvz9d6kdnUh97yM9f6REBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z49uxsyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF356C4CECD;
	Wed, 20 Nov 2024 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732114741;
	bh=RPTB3KechpAl4PhGA4iJyVy8SRU9IhGNpYs5OQEcPNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z49uxsykhLQB7sEOgYKjGs1sZMYD0MFU6xVt+IolhVmMwMfQs6EZN2UR5TEmfSkQd
	 RCO3ys2Ac4e11LboYxI+t79HACWj561UjP9kym0bObm4b7Ujpcpq+wNZDHIC6umrk0
	 vIYTu3NbVSZuKqjEWaufHTAlG0PXUuBBziOBOpK4=
Date: Wed, 20 Nov 2024 15:58:36 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Message-ID: <2024112022-staleness-caregiver-0707@gregkh>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
 <2024110612-lapping-rebate-ed25@gregkh>
 <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
 <c10d6cc49868dd3c471c53fc3c4aba61c33edead.camel@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10d6cc49868dd3c471c53fc3c4aba61c33edead.camel@oracle.com>

On Wed, Nov 20, 2024 at 02:46:32PM +0000, Siddh Raman Pant wrote:
> On Wed, Nov 06 2024 at 11:54:32 +0530, Siddh Raman Pant wrote:
> > On Wed, Nov 06 2024 at 11:40:39 +0530, gregkh@linuxfoundation.org
> > wrote:
> > > On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> > > > Hello maintainers,
> > > > 
> > > > On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > > > > Thanks Fedor.
> > > > > 
> > > > > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa and
> > > > > in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.19
> > > > > also.
> > > > > 
> > > > > I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 and
> > > > > 4.19 in the next email.
> > > > 
> > > > Please backport these changes to stable.
> > > > 
> > > > "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
> > > > backported and bears CVE-2024-43853. As reported, we may already have
> > > > introduced another problem due to the missing backport.
> > > 
> > > What exact commits are needed here?  Please submit backported and tested
> > > commits and we will be glad to queue them up.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Please see the following thread where Shivani posted the patches:
> > 
> > https://lore.kernel.org/all/20240920092803.101047-1-shivani.agarwal@broadcom.com/
> > 
> > Thanks,
> > Siddh
> 
> Ping...

I don't understand what you want here, sorry.

greg k-h

