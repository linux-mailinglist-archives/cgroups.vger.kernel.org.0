Return-Path: <cgroups+bounces-5451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4359BDE93
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 07:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07519B23D4E
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C51922DC;
	Wed,  6 Nov 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ovgt2lzU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50697191F99;
	Wed,  6 Nov 2024 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873458; cv=none; b=TFqJiCUHhyE+w/ox3ttNLkvmWCFqTzodZHWk0YxKhS0SSUon9LX4TR0O3I6tTINRpqMcT1JGYGmFB5tfH9NhhUCjtNgGteO4eOsGCYkOVb2FTWtjXCmq7qImBpPN1eXI22hFml9VMho97G4Qbi74LonaAQZ33mZiuHy7Crdhzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873458; c=relaxed/simple;
	bh=ZIkhSG3SWSWDdb9gBg4UsYaD7jsdzVUXEoG0AgAwFSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SInMeccylVCHmAhVAzNkAhgFa4RETn9bAr24whGgk+4wIT4KV3YDdxVDCCjvnsT5NS7Bs5hOTyCVBr4fC+i1O3R3D7ZdcrKGuIqedpGydHaU9eRcDWGT3wJWCzkG9DaaaOrcGDrzZpNI84/3na1BBklOf3NkIH/3FeWNlaQbHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ovgt2lzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48340C4CECD;
	Wed,  6 Nov 2024 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730873457;
	bh=ZIkhSG3SWSWDdb9gBg4UsYaD7jsdzVUXEoG0AgAwFSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ovgt2lzUBOZfLk7pABtIhToyXGkdTqkJKx+TNiQeY6ezEdfO3b7xC91czETuNOpMB
	 y18w3iJ4nddoGe+2vGtUuaDePpLfPqI7yX7irQnJK/z17/blNFLDXyj+aF3cWdyT6l
	 Ro+sUpdmvGt/ahk0ofPJbvb0pS2ucMFF9aJZH7Vc=
Date: Wed, 6 Nov 2024 07:10:39 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Message-ID: <2024110612-lapping-rebate-ed25@gregkh>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>

On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> Hello maintainers,
> 
> On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > Thanks Fedor.
> > 
> > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa and
> > in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.19
> > also.
> > 
> > I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 and
> > 4.19 in the next email.
> 
> Please backport these changes to stable.
> 
> "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
> backported and bears CVE-2024-43853. As reported, we may already have
> introduced another problem due to the missing backport.

What exact commits are needed here?  Please submit backported and tested
commits and we will be glad to queue them up.

thanks,

greg k-h

