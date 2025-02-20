Return-Path: <cgroups+bounces-6627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E5A3E309
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5021898B3A
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035292139B0;
	Thu, 20 Feb 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OcGyZc8b"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C792B9AA
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073844; cv=none; b=gnsYEWvl3gpjpvIOO/WBJXAPD3zum/6V/umbFpW8+eNGsLOe1UyUSGibiszbEdT6j0GeYKiwRmHRWVXwJ5ab9oSR/ZQtAzxO2QzJcXTe3Qj5g+eAuQyS3a4q9IjNyki1bFUNI9oQBPKw/GbbeC0fyCo4F7TlTembLyTYWXiaLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073844; c=relaxed/simple;
	bh=q3hNmWXaYqJ7DNShWqhafehExg8veM1WntvF4qk2DYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMPA1NixX7UvnZPDiJJh2SUSyx630krBPrFEfSSUSRBnNW/XmMdDY0cWSQF/wv2kd2Qe7nHsHdGJ3D3pPkQut7Tb0NHRU7xXQbEYWW4ofj5PVLyDoLzn+dU551C5jLTZ6+IGpkgbMsf4CVEtL1b/Wn8S74SlAj9qnCHclKWFD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OcGyZc8b; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 09:50:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740073840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3hNmWXaYqJ7DNShWqhafehExg8veM1WntvF4qk2DYc=;
	b=OcGyZc8bNh1odFKW/O6xskh1aVp4KMre9lMHAlYzUzLbbYlqq0YY+FEWMRr1ziayt4xld0
	Tuu//lASiV11DJP5pmlXU3i9OY6cMnIV6MjqKu7yfvkkE88XbBlMJCIMyzL+9zDJ+fIQdv
	bNsnXlVeha7MrBOPn0q0yLfSgv/exLc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/11] cgroup: introduce cgroup_rstat_ops
Message-ID: <wbudtsctzxwladhvhe5ex65yik2aqi3olb56k5m5j3qs2fmtpe@h2lwcydd2ef4>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-5-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:41PM -0800, JP Kobryn wrote:
> The cgroup_rstat_ops interface provides a way for type-specific
> operations to be hidden from the common rstat operations. Use it to
> decouple the cgroup_subsys_type from within the internal rstat
> updated/flush routines. The new ops interface allows for greater
> extensibility in terms of future changes. i.e. public updated/flush

Here you might need to be explicit what future changes. Will all
controllers using rstat require this ops interface or some of them?

