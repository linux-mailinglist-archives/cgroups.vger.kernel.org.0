Return-Path: <cgroups+bounces-6596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0BA3AED4
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2443AB3FC
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD075809;
	Wed, 19 Feb 2025 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrskDb0e"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B246447
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928218; cv=none; b=ddWN5sX2nF5XNBMtRrlq2mIg6bP8NomFwGm1fOxhUIm63Vfa/g4W/pbqm66GzDrzh1l5g1BVZxYzdWlq3BspeTljwJgt/+UJM599orgwn3h1LnQpLPMw/iBkApd5++XLwZiByC1KgY+Xanbq5oj+5aCqYnbpYp+VZnRJz11H24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928218; c=relaxed/simple;
	bh=WJgQKYcF4RgyKxMIVF/Ih+rO65Sk0nmlJi+sIP6vKBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAbZn07JhDZJLeH0+qyTDBvUySnJv6mFTzO3NhDZIK/bff9mci8ukRCaNabD6fx2BSWEKsUuGYcMuDRhH/h33CHmxAcoz55NsZZy/3ynCrITh1kKBnPrmyEMAt+e8flONl27dcOj1fQ884jNKKsEcH1I8WAvrvfB/s7fmyqz6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrskDb0e; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Feb 2025 17:23:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739928214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke++idLqL9qhaVRbOQX4Mzv3IAedX2ae7RUwDB45D/4=;
	b=xrskDb0e38jba9ec+udSrYS35C7C74ESeuoRRWr9qT+48qimSAgnHxCvgSiy3jq0LloRJ8
	Ydq3CHWRnnXZZpi6OHqGB/LmVhHdjeARil+nSojWmSossn+YwTWCMyoDyFKzOqNMdRJu4H
	rEg/kvig7A4py/S2Jna7yXZJFmw7HnU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 01/11] cgroup: move rstat pointers into struct of their
 own
Message-ID: <p7z5du2quppfw55urh7emjccokv4kmomliaqnvee2p3h3a4x5w@4nrmajq3u4az>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-2-inwardvessel@gmail.com>
 <v56w5fmzw7ugztktnupdzkthedtm6k7u4o7k2tro4ignqkpt4p@3qekpprnmmgr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v56w5fmzw7ugztktnupdzkthedtm6k7u4o7k2tro4ignqkpt4p@3qekpprnmmgr>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 18, 2025 at 05:05:52PM -0800, Shakeel Butt wrote:
> Thanks JP for awesome work. I am doing a quick first iteration and later
> will do the deep review.
> 
> On Mon, Feb 17, 2025 at 07:14:38PM -0800, JP Kobryn wrote:
> >  struct cgroup_freezer_state {
> >  	/* Should the cgroup and its descendants be frozen. */
> >  	bool freeze;
> > @@ -517,23 +445,9 @@ struct cgroup {
> >  	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
> >  
> >  	/* per-cpu recursive resource statistics */
> > -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> > +	struct cgroup_rstat rstat;
> >  	struct list_head rstat_css_list;
> 
> You might want to place rstat after rstat_css_list just to keep
> (hopefully) on the same cacheline as before other this will put
> rstat_css_list with rstat_flush_next which the current padding is trying
> to avoid. This is just to be safe. Later we might want to reevaluate the
> padding and right cacheline alignments of the fields of struct cgroup.
> 

Ah I see later you can removed rstat_css_list as you moved the rstat
state from cgroup to css and you don't need rstat_css_list anymore.


