Return-Path: <cgroups+bounces-13058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D45D10C76
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F4D303B45D
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1D32937A;
	Mon, 12 Jan 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qorSIfnu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F332328623;
	Mon, 12 Jan 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201399; cv=none; b=f/LrFt1ObabvYoILpuSnywmt4zoq2ehFoLff0D1ZeQ+bWI9iYgY8rM4REI0UMHglMwlbZqqMeZsQEVpCovTsZtZnR8HN68kcmUXdjnttr225UTufSLRxqhRn7dFZAT5GfXcmmWrH6MWky6uRkcxjHCPAlYVyQBI4lk9smI5UX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201399; c=relaxed/simple;
	bh=RfFsZBzuSWssL2s7NlWhcUypVV2LABYDjS+kD/mgs4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmOBa1yt07niO/AUgKU3RnR7w+IxfZ7L9bAvIbUCUgEV4IaiASvEfL7psez+8xaEus2PTT84y50a2zuUzCyGIFiPIkbHdw2ff2hfcRumqS9HjpYxEUqykUMWHmlCCuegPNC2sNxPmFSVFiExe8vSDK7nRbQznUp06+njcxuZkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qorSIfnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF7C19422;
	Mon, 12 Jan 2026 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768201399;
	bh=RfFsZBzuSWssL2s7NlWhcUypVV2LABYDjS+kD/mgs4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qorSIfnulWAQtcMU72GnPvCxC9RWDNItJokU293s7NtFSudd5TcfKHPmqYKxCdMRP
	 JCaLgrWx5XNFIDKfAVgNY+Br7516EyuXfMQhA01/dmr2T3ULiPWp34O5DX2liU2WsB
	 Xr4Sp219cke4NPhf3UNy9yMjrHzAt+utBWGO1Fj4=
Date: Mon, 12 Jan 2026 08:03:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
	hannes@cmpxchg.org, cgroups@vger.kernel.org, stable@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH] cpuset: Treat cpusets in attaching as populated
Message-ID: <2026011258-raving-unlovable-5059@gregkh>
References: <20260109112140.992393920@linuxfoundation.org>
 <20260112024257.1073959-1-chenridong@huaweicloud.com>
 <2026011230-immovable-overripe-abfb@gregkh>
 <9d2cdae1-178f-454c-b45a-681d782c483c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2cdae1-178f-454c-b45a-681d782c483c@huaweicloud.com>

On Mon, Jan 12, 2026 at 02:55:53PM +0800, Chen Ridong wrote:
> 
> 
> On 2026/1/12 14:42, Greg KH wrote:
> > On Mon, Jan 12, 2026 at 02:42:57AM +0000, Chen Ridong wrote:
> >> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I did not send this :(
> > 
> >> 6.6-stable review patch.  If anyone has any objections, please let me know.
> > 
> > This is already in the 6.6.120 release.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I am sorry for the confusion.
> 
> I downloaded and modified the patch, and replied.
> 
> My point is that the patch intended for the 6.6.120 release should include an adaptation.
> Specifically, the following block:
> 
> [...]
>  	if (!excluded_child && !cs->nr_subparts_cpus)
>  		return cgroup_is_populated(cs->css.cgroup);
> [...]
> 
> Should be corrected to:
> 
>  	if (!excluded_child && !cs->nr_subparts_cpus)
> -		return cgroup_is_populated(cs->css.cgroup);
> +		return cpuset_is_populated(cs);
> 

Great, can you send a fixup patch for this that we can apply to the next
release?

thanks,

greg k-h

