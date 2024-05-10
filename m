Return-Path: <cgroups+bounces-2849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A948C1CED
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786821F22357
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46A148FED;
	Fri, 10 May 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JahM9Gxa"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D533CD1;
	Fri, 10 May 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311122; cv=none; b=qapqURuMdyvd+/Zlv6ggWNMxASLtf6XwekPYnXotBAhoz1EP4dqlj7wLi2+e/CorUsFYwOmgPQYFp9XZvrC8hw8gZaVOhHtRTr9w8/bTc0ATW7G4vRNfeaxDLQdBFCfO2sGsT9ugJnqvJL+XmNbrN99ApocSlYfPWPtfgvqaBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311122; c=relaxed/simple;
	bh=foVyNGlbXIYrxPutsdsOkKH+iikzAmbsemiAiJGyawg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJuroIIFrnukH7eB1CFepQNEhPkbj6dN631NTRLw8NII46PUItRMS/eMcSrhd3dORijSWDIfMAiBgkoiODsiT7Qnfj2F/AV6+/wwPV6euPuMSRhJNLxoz/K6IbsMRyMAG09utih7SxOloeSSqx8F4UzsMevBZJ340Hw2+hQ4yr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JahM9Gxa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3fHRsZcdj/tgFnGrPHUfac5A7YiWSFy0VDkIhuxQvAY=; b=JahM9GxavFkcw1GiYwoFbeXZo7
	hcFNrP15sZGp+j0vhmRQ0G6ZfKgP9dPPg5G5l0K/IDzIuSD6+IfKkPzZqiIV9pMRybFuy/1XSpjFU
	Qx60+DMZCAP/zLSQ7HilZ/jnUvLLmCXs9FnvdPd2KRQC4EY2nT/Q2bMA/uxgsypurem2mODz7kCiH
	2vtMDgsB/2uHmynZbK1izGb+ni5nMu+FvFSQQdtFSiK1ZJiRCI1GqRpOE1jI22vOCDCTstvWgEHM6
	hGYHAHhCnkMzIbsq+Nf9QMw6hO503eLiFNengNrvlafcNlzHgWNEUlfQzvPtQcFaC7G6FywWLgQ0T
	gAEtjbYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Gm5-000000027Oc-3RIv;
	Fri, 10 May 2024 03:18:22 +0000
Date: Fri, 10 May 2024 04:18:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <Zj2R_UH0JMspexp5@casper.infradead.org>
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com>
 <Zjw_0UPKvGkPfKFO@casper.infradead.org>
 <CAGWkznGZP3KUBN2M6syrjTmVOdSM0zx23hcJ6+hqE8Drgz2f-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGZP3KUBN2M6syrjTmVOdSM0zx23hcJ6+hqE8Drgz2f-A@mail.gmail.com>

On Fri, May 10, 2024 at 10:43:20AM +0800, Zhaoyang Huang wrote:
> Thanks for the prompt. I did some basic research on soft RAID and
> wonder if applying the bps limit on /dev/md0 like below could make
> this work.

No.  Look at btrfs' raid support, for example.  it doesn't use md0.

> I didn't find information about 'RAID internally'. Could we set the
> limit on the root device(the one used for mount) to manage the whole
> partition without caring about where the bio finally goes? Or ask the
> user to decide if to use by making sure the device they apply will not
> do RAID?

No.

