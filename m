Return-Path: <cgroups+bounces-9951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C9BB51E12
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C826418902F5
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA91E520A;
	Wed, 10 Sep 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S544noVN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D861274B35;
	Wed, 10 Sep 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522664; cv=none; b=Ebi/552qfxqUfiWGd+YCVZecZo06qPVUJzH3STnhrGHRbSnPTIDCbwoPi+h8VFxI+A0HR9W+UWc9v6nfK/J3IseYFq5atrobRhYyi2N7DbpN46Nt2a4n0D2fhL7qIofL6aa3v+H4nwKmRPYamak2ZsOiYtgtE3AVgdWe1OB6VJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522664; c=relaxed/simple;
	bh=duKjujbgky8HcxNtbyBBgLnGw3VqC6OpenSzO2VXTLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us7CjD2k0i/8XMjnoFuCuLaFyDa8LnSyYgS8YqjFuQoAwcYpWNFpziNVYwaPCoP2+hPH6eIuzsiQkY6j5jKW0Pc250Hh3NvPLUUqBImReHPZVwNSg2c/F9w+Wh3fenuBoaLksNS0po7xhYPfa1safToBGT5y4iphhUXye+aSbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S544noVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D47C4CEEB;
	Wed, 10 Sep 2025 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522663;
	bh=duKjujbgky8HcxNtbyBBgLnGw3VqC6OpenSzO2VXTLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S544noVNsxNsc/7MpbSw0QQVzf35R4J6OOKFThqRLJfnktPg0GfvXL+6yLP74OFm5
	 I4eZNHsCDuDSxWzrcmIsziyifNqpqCQxYHSplq26uBKDbvNjX4fnIFBuEvvxBU9d2L
	 F6W2BNbREM59whxBT1YJtqme80X597KzObXr9p+ryedCCMNgeb8Dx5NNCLAP+gMveb
	 Uew9qXSjQENMhK6rHXmHbwo+LRbU2QZ+ycH+bQrP9oPHEk7qh92Vf8Y2B2AJ5tcXXA
	 nB2Qe6mx910+UpvDO6EB13I69FG9uyvmMcsDzG1JQwXXwFF7ZkICdiaM3kHPkkTBEa
	 pvneNH2NDHguA==
Date: Wed, 10 Sep 2025 06:44:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMGq5tNNAk5DsJWo@slm.duckdns.org>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
 <875xdqtp7m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xdqtp7m.fsf@trenco.lwn.net>

Hello,

On Wed, Sep 10, 2025 at 07:24:45AM -0600, Jonathan Corbet wrote:
...
> I fairly routinely get patches fixing manual TOCs that are not updated
> to match changes elsewhere.  We have a nice system that can manage the
> TOC automatically for us, it seems best to me to use it.
> 
> That said, if having the TOC in the plain-text version of the document
> is deemed to be important, then it needs to be kept and manually
> maintained.

Wouldn't it be better to have some automated script which triggers on
mismatching TOC so that these get fixed up. I think people (including me) do
read the plain text version, so it'd be a shame if we lose TOC in the source
file.

Thanks.

-- 
tejun

