Return-Path: <cgroups+bounces-4465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BF95F906
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B20C1F24A59
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487018A95E;
	Mon, 26 Aug 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9kNKGik"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D92C1AC;
	Mon, 26 Aug 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697305; cv=none; b=A3oc1UkJFLAjwa/cPgl4lkwTeeRiTghvEQcDUvOP+jyChq0Xsb06s27P1PhAUDhU5LhKYi6BMZVEjG/wyYYsVylNVsoraYjF6sg8owMhnY+60vN9SDgQirhVSJaIB1flYCgI+62oLqE+W0PzBmn/KGeLmuv582+8qz9sOSO8wMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697305; c=relaxed/simple;
	bh=WJUAZ2Dnc20rY85yKNE4tfrmUEmCUGOXJQaQKBPAr9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPOUZJTjANCej56hPA9IceaD5QyJKDsn3DdIFtg7FrSb99w+UcXVl1aSvHVNph2Nvmh6ioLs8zrUdFszb/e13TNgMbSsnmRAVApaeoUyyiwH0/EklB9yifBZPu6l2BaBw8/5g1QIDrnAAfe2CQwSr0/uF2WGztE8Mx0qh+0br6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9kNKGik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED00C4DDF5;
	Mon, 26 Aug 2024 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724697304;
	bh=WJUAZ2Dnc20rY85yKNE4tfrmUEmCUGOXJQaQKBPAr9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9kNKGikqxa2n8dwiS0KYPv3mxnWfzvEtamLt2bCcvBMrVu0riREh5f9h7nO+MnOy
	 EgJp6E6VI9dLYmWYOYwv1fx7J23oOqWmFbbG81eMF5JCe56UUH18cmd3e/pKPkD+zI
	 kfYj0NE5LJ79JFD63oED2A8g32ucuPF6imZ57daUJJf8I/OKzeL+FNCOaKw9lDBr6b
	 IJfRdLn/p4mgr0e4/toMcTlfJodHPAi/bKVnD0yXH/wa9hAo+FFWrIElsY33vmbJi7
	 +Hzzp60KT6vyImJDzxyLFx2o8Sq6a8Hnf3EU/Cz9hPNropubo5BYFDwdG9cr6dMvPL
	 ediOM5/42em0A==
Date: Mon, 26 Aug 2024 08:35:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: void@manifault.com, peterz@infradead.org, mingo@redhat.com,
	cgroups@vger.kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>
Subject: Re: [PATCH 1/7] cgroup: Implement cgroup_show_cftypes()
Message-ID: <ZszK1zQJSjuEO4r5@slm.duckdns.org>
References: <20240808002550.731248-1-tj@kernel.org>
 <20240808002550.731248-2-tj@kernel.org>
 <qsdgtsunxgbxb6lf7x7m5777jxmumddomsofuuimqenoyliabx@assdbc6zj2ag>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qsdgtsunxgbxb6lf7x7m5777jxmumddomsofuuimqenoyliabx@assdbc6zj2ag>

Hello, Michal.

On Tue, Aug 20, 2024 at 04:38:40PM +0200, Michal Koutný wrote:
> On Wed, Aug 07, 2024 at 02:25:23PM GMT, Tejun Heo <tj@kernel.org> wrote:
> > +void cgroup_show_cftype(struct cftype *cft, bool show)
> > +{
> > +	struct cgroup_subsys *ss = cft->ss;
> > +	struct cgroup *root = ss ? &ss->root->cgrp : &cgrp_dfl_root.cgrp;
> 
> Strictly speaking, this (v1) cgroup_root dereference should be guarded
> with cgroup_mutex too (should be the root destroy concurrently).

Ah, right. I think I might just drop this patch. Hiding and showing the
interface files dynamically doesn't seem to work that well in practive (ie.
it causes more production problems than it solves). Something a bit more
boring like triggering a warning when a unimplemented feature is used is
probably better here.

Thanks.

-- 
tejun

