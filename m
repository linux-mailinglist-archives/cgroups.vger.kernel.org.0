Return-Path: <cgroups+bounces-14612-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBqtFW5pqGnYuQAAu9opvQ
	(envelope-from <cgroups+bounces-14612-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:18:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC52050D3
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A52309E742
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AD737AA76;
	Wed,  4 Mar 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JKKfEgUZ"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADE37AA7D;
	Wed,  4 Mar 2026 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644318; cv=none; b=Wi4tO+gr0pecBaT1wZRSlQ2eBKzTpcHTBbl+jOMG6T/rHDTq6VXN4Z/u6o7j1DlrWFRK7VjmdfVhAuhwgqYShLf97pzVLjco6vXHAG0K8LEiGDRJm4EZwS+JpD2srMmZiaQFjtqX1SFmLSsHdgaIOWH2PdBtuGJHDEI8aohGwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644318; c=relaxed/simple;
	bh=x4tz9vFRAP/YOoPPsErBc9IWQH29swIXd36WC4msMUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioClbgWYYsLXIj6cavV4lfPTF+aXPVqdaBFEIDtPP7BcKN88DgFt1+o5aPU51L6YEAlXwxsvqYPJygKns47klflfYXS7YATJaFQ39nuq9GcLjziOXXUy11vmMtTnE5Z7lzj6U2l+mRUoY3Bsy8e5nFaAZSADatfaA5fLi70/mm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JKKfEgUZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tvA96IjOfOC0GRpSXcpU87EML3AFbDJvdGEAaLf/CmA=; b=JKKfEgUZWwBE6yJlcj9R2VkZbP
	ZdCVytRnrOwCG+irDKCxYLE7EQsOPlsKEfa3G9IiySsFdVz1CGT0M4EakFW5A8GIzi0uDKsvxkTek
	a8fQO85NuFd5FcxvvYUxiJsoIKTskMX18KWysThdPvJ1s/wXQxhQfQr9+SRyAOfu0qwJhGo6G+LlM
	c5rUQ8OHiSNCHcSdLvdLqHzDIGWd4g4Ex2q0DVC8YYOV4qwtCPI1h8rO3sbZlfJmh/UltLYgqn7sF
	9Yqei2qnWHoVAU2d3OrxbyfRVLHQXAuc541AMbej5mvtFGPTEdU/FYe8FgZxSwEKMtLzqoZ7nsniz
	/DBHzF/g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxplI-00G6h9-Hb; Wed, 04 Mar 2026 17:11:52 +0000
Date: Wed, 4 Mar 2026 09:11:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	thevlad@meta.com, kernel-team@meta.com, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aahnjjOP_5Qzfa0K@gmail.com>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
 <aaf98kejfRuMvIu3@gmail.com>
 <aahiUfIRh84tpqrw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahiUfIRh84tpqrw@slm.duckdns.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: D5DC52050D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-14612-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:48:17AM -1000, Tejun Heo wrote:
> Hello, Breno.
> 
> On Wed, Mar 04, 2026 at 01:56:43AM -0800, Breno Leitao wrote:
> > > Given that they haven't changed for a long time, maybe it's okay to expose
> > > them by default, but why? This is something which can be toggled on easily
> > > at any time.
> > 
> > My goal is to ship a kernel that exposes these detailed io stats by
> > default, without requiring any runtime configuration. The stats should
> > simply be available out of the box.
> 
> This is a pretty trivial patch to carry, right? Or just do it as a part of
> boot system config?

Yes, a very trivial one, but, which requires some work to be done at
every rebase. Mainly when trying to use pristine stable trees.

> > > What's the benefit of exposing these extra numbers which
> > > probably don't mean much for most people?
> > 
> > My original plan was to introduce a Kconfig option for this. In v1 (about a
> > month ago), Michal suggested removing the toggle entirely and always exposing
> > the stats, which seemed reasonable to me and received no objections, so I
> > went ahead with that approach.
> > 
> > To be clear: is your position that we should not support building a kernel
> > that always exposes the detailed stats in io.stat?
> 
> As a debug option maybe but I'd prefer if vendors (including us) that want
> to permanently enable these debug stats carried the patch in their trees.

That is fair, thanks for the direction!
--breno


