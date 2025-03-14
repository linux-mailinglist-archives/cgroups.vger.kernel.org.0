Return-Path: <cgroups+bounces-7076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC8A614CE
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B6C1B61A56
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3B20298F;
	Fri, 14 Mar 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NMptf53W"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7720125F;
	Fri, 14 Mar 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965920; cv=none; b=lJID5Sb3SgnXtROYXVS1e5x0LjkUV2Jk0bcmynO+PMZu+c+LNc0BAaFoMrWXfVN48dXe5lak/SBdP50xqvKlUepbCAtAcUgbSDNf0LXwAF+sCGrFABY8HQ4jBLR9rsjHspVEowfwgA0KBDNwCnQGiAF0c/adjjVdrym6yxgL/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965920; c=relaxed/simple;
	bh=ttfHvGjFPNT8a847marGdgc/cqlZkvi7C3hk9IguScM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6iuyGz4qwuxKFbmEqpvSsdWOn9/gtQBDbRkcy5BxM5TadOUvb/Q+5Fp83fmv9/fmS38FP6btTggLBhvXR0YcLGAeqmyAWXluaYREUjQucyjtbtJYoCWoygjfMrpXlqtDC2ULhs41C/ULecXGkkTXEtT5oH/GXoy5KGdToo/kdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NMptf53W; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741965915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxlRek5piQEOqJgTgUW73cEStZDjS6tHAoz6Zpz+OY0=;
	b=NMptf53W6V7UzUIOvVx4QrFJjyUz3uT6qHJp7SoOKAyL/8wDqb03/VSR2iR6x4IQC3zCh1
	YPOwrtAJFAlLPLOh7p646kyd6orl48+O4yP8IJCfz11amr55tRcZig6/pe3S/osHVJm/1i
	JzF8Jj8MPPw/EoI3jxCLxJ0QVLN63XU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 05/10] memcg: no refilling stock from
 obj_cgroup_release
Message-ID: <pjfrevsiu6gyyrvncbel5upglwu3lgcxdccrm26b3rlqwcmnx6@di3hjzxyl6ar>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-6-shakeel.butt@linux.dev>
 <20250314112627.dPKeawXj@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314112627.dPKeawXj@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:26:27PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-13 23:15:06 [-0700], Shakeel Butt wrote:
> > obj_cgroup_release is called when all the references to the objcg has
> 
> "references to the objcg have"
> 
> > been released i.e. no more memory objects are pointing to it. Most
> > probably objcg->memcg will be pointing to some ancestor memcg and at the
> > moment, in obj_cgroup_release, the kernel call
> > obj_cgroup_uncharge_pages() to uncharge last remaining memory.
> 
> This sounds somehow funny. I think the point is to uncharge the pages
> without tampering memcg_stock because it is unnecessary.
> 

Thanks, I will see to make the point more clean in the next version.

