Return-Path: <cgroups+bounces-2856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BF8C20EA
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 11:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9A5B21C7F
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC9161319;
	Fri, 10 May 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P51B6Dt/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57701581E3;
	Fri, 10 May 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333322; cv=none; b=bMiILUf6h/uRfzrLqN/GztgNr6OH8BzYNrq92A+bjsGuWmTzOweqczuC82Yd5wfWCOaPFWSrI93hplfXeIh0pu7vSHQhY22BtkMKZ6OFYpBxOEiBTbwNZAf07Et0IuJe8ick6vTLD7JojCnG6UU2+lsj5nWLtAyEWBfFoSxAVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333322; c=relaxed/simple;
	bh=oxjnBw0YNQFYA5GB81I1XJ33OzLdua4xr2AApp9Wiss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgAG1KrrGNFumj4w0+wUskOLF+SUmT+OM7bREoEiLLxmeLkxEOFhG5qLYYlpXV5kuuTTJoShE8m/+DjglN3PMsTe4WHr6CXi9KWKDkCdR5/kLudt5t6BV9gLZMi636O0L8TynPkAX+fNCwTYdLDWkbM77RDJrDrvnFi0Yk8WUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P51B6Dt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D30C113CC;
	Fri, 10 May 2024 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715333322;
	bh=oxjnBw0YNQFYA5GB81I1XJ33OzLdua4xr2AApp9Wiss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P51B6Dt/bsfnrvqsI3zczK2l8toNlYkKJm+ymZrDnfP/5zfTTVeAJP1bWS+KRvDPv
	 BwMBAyWnRXmiG8MFxuBdcE0olUh2h+jFtlgi536ih7nxZgkREY49J6yuiFbFMZpjk9
	 ZwmUlo4Yy0Z/OgjuU5xeuYR2yiwsYvMT6eCacI+S2BcEdK4vGGjdMXC0Hi4rvh9sfF
	 se6PKSPQDAndTxlk8PdLcurOktGrFCsqAx8O1iJUDk/Hky8+++vXDPIc+q37VEqeyM
	 FxlNxqIoRX9UQ6A3fkjaHWCQ0UedVPkppTaKH591xNggb8qjSpztBBcnvjs0oQbOzm
	 KXoWaeixRiZsg==
Date: Fri, 10 May 2024 11:28:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
Subject: Re: [PATCH v3 1/3] block: track per-node I/O latency
Message-ID: <Zj3oxKCGQYQ7xpjt@ryzen.lan>
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-2-jmeneghi@redhat.com>
 <fcda2351-9ba7-4121-a993-184a4c02f9a6@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcda2351-9ba7-4121-a993-184a4c02f9a6@kernel.org>

On Fri, May 10, 2024 at 04:11:10PM +0900, Damien Le Moal wrote:
> On 5/10/24 05:43, John Meneghini wrote:
> > From: Hannes Reinecke <hare@kernel.org>
> > 
> > Add a new option 'BLK_NODE_LATENCY' to track per-node I/O latency.
> > This can be used by I/O schedulers to determine the 'best' queue
> > to send I/O to.
> > 
> > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> > 
> > Cleaned up checkpatch warnings and updated MAINTAINERS.
> 
> This note should be before Hannes SoB. E.g:
> 
> [John] Fixed checkpatch warnings and updated MAINTAINERS.

Not before, it shoud be after Hannes SoB.
(Between Hannes' Signed-off-by and John's Signed-off-by)

See this example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a37e12bcab22efa05802f87baa0692365ae0ab4d


Kind regards,
Niklas

