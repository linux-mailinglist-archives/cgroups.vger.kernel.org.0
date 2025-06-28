Return-Path: <cgroups+bounces-8650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D5EAEC5C8
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134F07ACB3D
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24E223716;
	Sat, 28 Jun 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YrISKfHu"
X-Original-To: cgroups@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C122370F;
	Sat, 28 Jun 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751099031; cv=none; b=rcrzQ3onVvqIGxyBf3M+/UcsLKBI/gbXr+a1Nk+YgMi5x3xNrbYkfob6sOgM64Qwcxcj4qfNZN8SSVFzodKEdWOwqFfnTjPGczH6FnCFHxLv4TXorZaGEsK5wIF8QERw0BtFTlTsDlsYOqh1aHNaYRzypTxXbdPwGuyv5KLTG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751099031; c=relaxed/simple;
	bh=eqTiPcdvxpKkytUdjM7KlZsZp+DvFgX/PFLwskukbeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxgUQwhCOkpQsGJG4fPKGFqbC4sBQ/bRfp58LLF/f5tEo47G7DrOwXXDzYaLxz0hljlML5KyJhFmMG3bSaNcoAp8/8+2mQWSACYjrLy9qfU5b9so1/K0jOnkY0PYZ8Cu1tk4E+6eFnuO7lAG081TOvRVHC01PcHErTW7UywPb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YrISKfHu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t3QriktKYw5bEAqOwOcdjwsunvx2BAPD637QxTwxarw=; b=YrISKfHueD60LnInTjLm1DYZtW
	x5T9mWwliVRYN3Q7FovR6H86M6hWAVrAN2/MHcrXBKQpcurTR2gZY8zdEbRCXO7au4Jsi+O9V0fct
	qYbEjnG/wTGdjsmASfa7VYSidTX/K+75c66a/c/4KfdhzUJFzvj9CdCbJFxnQtUiQF4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVQqc-00HDtx-1Z; Sat, 28 Jun 2025 10:23:42 +0200
Date: Sat, 28 Jun 2025 10:23:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, allison.henderson@oracle.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs
 (and ELF)
Message-ID: <69ea515b-bc6c-473a-a02f-d126d906784a@lunn.ch>
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
 <20250623155305.3075686-2-konrad.wilk@oracle.com>
 <20250625163009.7b3a9ae1@kernel.org>
 <aF87ATSJH3Q9rkju@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF87ATSJH3Q9rkju@char.us.oracle.com>

On Fri, Jun 27, 2025 at 08:44:49PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 25, 2025 at 04:30:09PM -0700, Jakub Kicinski wrote:
> > On Mon, 23 Jun 2025 11:51:36 -0400 Konrad Rzeszutek Wilk wrote:
> > > With the value of 'supported' in them. In the future this value
> > > could change to say 'deprecated' or have other values (for example
> > > different versions) or can be runtime changed.
> > 
> > I'm curious how this theoretical 'deprecated' value would work
> > in context of uAPI which can never regress..
> 
> Kind of sad considering there are some APIs that should really
> be fixed. Perhaps more of 'it-is-busted-use-this-other-API'?

I expect any attempt to actually use 'deprecated' is going to draw a
lot of close review and push back. ABI is ABI, even if it is broken.

> > $ git log --oneline --since='6 months ago' -- net/rds/ 
> > 433dce0692a0 rds: Correct spelling
> > 6e307a873d30 rds: Correct endian annotation of port and addr assignments
> > 5bccdc51f90c replace strncpy with strscpy_pad
> > c50d295c37f2 rds: Use nested-BH locking for rds_page_remainder
> > 0af5928f358c rds: Acquire per-CPU pointer within BH disabled section
> > aaaaa6639cf5 rds: Disable only bottom halves in rds_page_remainder_alloc()
> > 357660d7596b Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > 5c70eb5c593d net: better track kernel sockets lifetime
> > c451715d78e3 net/rds: Replace deprecated strncpy() with strscpy_pad()
> > 7f5611cbc487 rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
> > $
> > 
> > IOW applying this patch is a bit of a leap of faith that RDS
> > upstreaming will restart. I don't have anything against the patch
> 
> It has to. We have to make the RDS TCP be bug-free as there are
> customers demanding that. 

Maybe we should hold off on this patch until there is a real need for
it? Make it part of a patch series which adds new functionality to the
ABI. It is only when the ABI changes does it make any sense to have
this API.

	Andrew

