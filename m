Return-Path: <cgroups+bounces-12333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E44CB4E3D
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 07:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB03300BBAE
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2D296BC3;
	Thu, 11 Dec 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PVm2Ovmy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399E296BAB
	for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435287; cv=none; b=H/EeC7q64fVh/KzlkEovmpD8Q8UStmlHiQ4roNE4SIWlsMdfulDWp5URK8YzcJhB3Gal03Fwq6afevNnmwXv6yWPNXvEKpZbkaEvYzHmVYP/I4F+OwBer5vbZngGeokkBB8Pb0Rn5e/EzF4y9RMMfTDQcE4Wyr56td4OZPrn6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435287; c=relaxed/simple;
	bh=19FOWqt0fjZkf4ZiZyOPLC4hOzFhZxxDvDjxd/ML1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD276TKU1f9xBxXsHwYi1iO2Pb0jYidmQypJEB/xFapDEgeDr98fJ+iIZZUD2ERAIPR6YcW+PFLyT9LdNGqVRnP5q7MLvPZDjhZxPKCTTeCPfIs4eL/6aqVt37RMUSiJx++n/UHBaJUpd/fjBa+ITb7LSd/VLOnUCKIdZ9Cc0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PVm2Ovmy; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Dec 2025 06:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765435270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/jPsKfeO0D+5qsv+PXL7ya2LAsONenY167Q1JLuy3w=;
	b=PVm2OvmyiPRuk6NVjfUWFRFPVaVXEjOBDMp1Om9zewhwbqJ6L1+VNe/VOetrK9/wtLyYdp
	httjUu831I0U1nS0LG9hHslo2hN8SGKwRojMXfP1lKiHHTLzPnthFQGrODDFkayQMijHTq
	waWCitCrRoV3kIYJHo2fPjMEpHQ4+hg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: rename mem_cgroup_from_slab_obj()
Message-ID: <aTpngVxmYDv7huFF@google.com>
References: <20251210154301.720133-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210154301.720133-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 10, 2025 at 10:43:01AM -0500, Johannes Weiner wrote:
> In addition to slab objects, this function is used for resolving
> non-slab kernel pointers. This has caused confusion in recent
> refactoring work. Rename it to mem_cgroup_from_virt(), sticking with
> terminology established by the virt_to_<foo>() converters.
> 
> Link: https://lore.kernel.org/linux-mm/20251113161424.GB3465062@cmpxchg.org/
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

