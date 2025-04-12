Return-Path: <cgroups+bounces-7495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B90A869D9
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 02:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214191B62CF0
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA14481CD;
	Sat, 12 Apr 2025 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cp1WlN4I"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D3DDAB;
	Sat, 12 Apr 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418165; cv=none; b=tU7QRbovZXDJBsyf7OrQ2CIPMdJCRozouTRnrupsSYYOjEGzKQaiM9THJ/5u5/PO0336CanTItZMx7Kn2U27/m5YIscrWBbjAcglTn//k0aKILXhHQPTdVAYCUHHYes/eTlnSBM0hhmfjWjSagbUAN3CGGh3E7sq8GAd+JYEPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418165; c=relaxed/simple;
	bh=EkLf8qvRHKf7dLC410RjIq0LNgac4pWgB/KbmwaP/74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE9wTsLRar3ASR8h0tzpP/eCMXFnLtinvnDYdQkR93hrsSUCDaEXqR3n1qzP61Q0dYlMdaH9vmmBlElDxdSKUWgu03Yyio5/lbFzSEFf5BlwszMCFxU/Y43Qq9uYLczeg5p+Mktza/l6QBH6X1adtZlpRSs3/CK4R+wjc1+4cRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cp1WlN4I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jLcp1f7cOvcMEIXPWzRzzeb25u2ahPnJh9qFDKIguvo=; b=Cp1WlN4ISq7YsoEqphP6c04d4C
	15BcntTpC5JcklAwoYa9UcSYoepyO8BfZpy1wE+0g8AWtNz6h6OSxPDv/o3EPzTyQvNZ/WQHfaDhv
	7r3rjuFNTF08ZLTqTYy/a+JCI5l7iZCIUmB4xWCT0+3qH2dBdPlibHfpFg0QLnW/ho4FJKqhnGeyI
	x6z0qfH9/FmnXRRGMyJ8cZMdnxKNuEekEodSvO1ZyG/aluAJSQK5ZPZ66d7dkXtWooe2PFuFRe8mQ
	3IOJl9uDfZ+oH1GxJvBDurKZSZe5GVvmXvPoX1eejHdAMmY0oe37gbbwpadx/mBXfdPGK76PDnGRd
	Ak0iZi+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3Oqi-000000052MS-25TP;
	Sat, 12 Apr 2025 00:35:56 +0000
Date: Sat, 12 Apr 2025 01:35:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_m1bNEuhcVkwEE2@casper.infradead.org>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
 <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F>

On Fri, Apr 11, 2025 at 08:09:55PM -0400, Gregory Price wrote:
> On Sat, Apr 12, 2025 at 12:49:18AM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
> > > Unmapped page cache pages can be demoted to low-tier memory, but
> > 
> > No.  Page cache should never be demoted to low-tier memory.
> > NACK this patchset.
> 
> This wasn't a statement of approval page cache being on lower tiers,
> it's a statement of fact.  Enabling demotion causes this issue.

Then that's the bug that needs to be fixed.  Not adding 200+ lines
of code to recover from a situation that should never happen.

