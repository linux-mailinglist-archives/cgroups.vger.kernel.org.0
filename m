Return-Path: <cgroups+bounces-7713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88AA968AB
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059AA16D9D7
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3927C841;
	Tue, 22 Apr 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O715COAL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977421481B
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324049; cv=none; b=QLajhcudH1/WiR6WUVyBx8puv2FG1gAu4y/DM3u/oErs//tCtzw3Gwgdyo3HSM/ykvK9Gr1g7u/D7a0pw+gZmCiisryVemEyLaTKfXfo7Oi0QHeIFuKfalFBmPvpo8MssTZUXeZA8qznW1OcMu5whstNConqk73ntjwgiaf+R64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324049; c=relaxed/simple;
	bh=jFegx/A4HLcu1aOJE58pk98gPRwBbRV/P1aYUgmVmaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHjGJHSYX6j0NfrMndRbY/w4pwbI1gyw2m/2We41txpMc7vP3uDpp/DMYgOq8gLltgrxlSh61KNrOaiUoK3zmBYVht2+vNz6A7k25lS1wwXjnCSVR/EGQHKLha2mHS2RNX/4n6xvl7qboztmA8cd77yjLLkn1wgXSGobzo0+zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O715COAL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 05:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745324044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsgsuiDl6yNL7CcpFW9U5jdCE7K00yNVVhC4h3Ewig8=;
	b=O715COALotWAPIYZxS6G6xu7LjevqZhmQRPS77lt7eCX8EdWbdHCI5Qwc+cRCqZWuKU9Eu
	65BtbEnC/iEieGzzCFYLCVbywYSGFCqKAhaycOW3HBrzEsZzdmtIm3xmYGB5Raz24E4/U2
	uvJ6bMe1Z/70zT6FHGf/nWjJQixHxKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] cgroup: move rstat base stat objects into their
 own struct
Message-ID: <aAeIBysbD6Zb_iTr@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:46PM -0700, JP Kobryn wrote:
> This non-functional change serves as preparation for moving to
> subsystem-based rstat trees. The base stats are not an actual subsystem,
> but in future commits they will have exclusive rstat trees just as other
> subsystems will.
> 
> Moving the base stat objects into a new struct allows the cgroup_rstat_cpu
> struct to become more compact since it now only contains the minimum amount
> of pointers needed for rstat participation. Subsystems will (in future
> commits) make use of the compact cgroup_rstat_cpu struct while avoiding the
> memory overhead of the base stat objects which they will not use.
> 
> An instance of the new struct cgroup_rstat_base_cpu was placed on the
> cgroup struct so it can retain ownership of these base stats common to all
> cgroups. A helper function was added for looking up the cpu-specific base
> stats of a given cgroup. Finally, initialization and variable names were
> adjusted where applicable.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

