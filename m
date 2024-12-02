Return-Path: <cgroups+bounces-5725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB29DFD81
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505F4B22846
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5D1FBEBC;
	Mon,  2 Dec 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TI85l/MA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0D1FBC9B;
	Mon,  2 Dec 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132721; cv=none; b=M71QHHXKvzxFPVqUENfulE7V5osAM1Rg6WdK4UwA5F2UQsAWGGN3qQmcYxv+G4ruvqwCl72uln3rnJsiugLUToN+y+8h55U2vMSK0rPB2HwLHbfAiNhqHnh9BUIQPQB9AKE1EhYh4yN98KN1pawXYS7e7VpJccOd3JwBJ7cfaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132721; c=relaxed/simple;
	bh=5Zafu1CVVxBBjmaBRtdRdWwlT8bxSaY26er8YOulc1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htk7014pwGQqvLxfxuqroBDoDvstg1XMqqzZYlkbSLw11Eya3PzjOWzYKMwCAObXk/pi7lubU6xI8KvcrazGPFZuFmux8YD+Iup+TC237vPt29OB75r//r+hRfVcrWofvfu43+cLSQjgic8dcfQERxwfO2c8/y7CV7c/HLVQYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TI85l/MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9ECC4CEDA;
	Mon,  2 Dec 2024 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733132720;
	bh=5Zafu1CVVxBBjmaBRtdRdWwlT8bxSaY26er8YOulc1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TI85l/MAWf3cnShwzI1jEK+X29PVZq7UOLLcNwQ6pH9awCzHoxIvx99qWckR3btfP
	 xRUohpmDHyQzg+W2P7VoqOiMFoIXSh6h40XudqomVHy1Y0hr90jYG4FSdYjToaaQJM
	 SEd0D7M36NrL/kyHBRe20YhJ7aSZAnqOyYpx4lHs=
Date: Mon, 2 Dec 2024 10:45:17 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Message-ID: <2024120252-abdominal-reimburse-d670@gregkh>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
 <2024110612-lapping-rebate-ed25@gregkh>
 <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
 <c10d6cc49868dd3c471c53fc3c4aba61c33edead.camel@oracle.com>
 <2024112022-staleness-caregiver-0707@gregkh>
 <2bb366f53aa7650e551dc2a5f5ec3b3bec832512.camel@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb366f53aa7650e551dc2a5f5ec3b3bec832512.camel@oracle.com>

On Wed, Nov 20, 2024 at 05:47:36PM +0000, Siddh Raman Pant wrote:
> On Wed, Nov 20 2024 at 20:28:36 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Wed, Nov 20, 2024 at 02:46:32PM +0000, Siddh Raman Pant wrote:
> > > On Wed, Nov 06 2024 at 11:54:32 +0530, Siddh Raman Pant wrote:
> > > > On Wed, Nov 06 2024 at 11:40:39 +0530, gregkh@linuxfoundation.org
> > > > wrote:
> > > > > On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> > > > > > Hello maintainers,
> > > > > > 
> > > > > > On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > > > > > > Thanks Fedor.
> > > > > > > 
> > > > > > > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa and
> > > > > > > in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.19
> > > > > > > also.
> > > > > > > 
> > > > > > > I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 and
> > > > > > > 4.19 in the next email.
> > > > > > 
> > > > > > Please backport these changes to stable.
> > > > > > 
> > > > > > "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
> > > > > > backported and bears CVE-2024-43853. As reported, we may already have
> > > > > > introduced another problem due to the missing backport.
> > > > > 
> > > > > What exact commits are needed here?  Please submit backported and tested
> > > > > commits and we will be glad to queue them up.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Please see the following thread where Shivani posted the patches:
> > > > 
> > > > https://lore.kernel.org/all/20240920092803.101047-1-shivani.agarwal@broadcom.com/ 
> > > > 
> > > > Thanks,
> > > > Siddh
> > > 
> > > Ping...
> > 
> > I don't understand what you want here, sorry.
> 
> Please find attached the patch emails for 5.4 with this email. They
> apply cleanly to the linux-5.4.y branch.

Please resend these as patches, in the correct order, not as attachments
as it's hard to review and handle them this way.

thanks,

greg k-h

