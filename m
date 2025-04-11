Return-Path: <cgroups+bounces-7465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66437A85064
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 02:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758111B85308
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B44195;
	Fri, 11 Apr 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HC1zfhPJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E9184
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329805; cv=none; b=ej06vfKoyTMvqTN8Poq7Ko73d47FofLsWuvmuBgEhZlg7QmWz+4jfsEJlD1E95XpGA1YtYcSS+mgutRCcDc7VA2/S6+i1x4v/g0dEDgjp2OFiPXGMmJARb/PoWRGidF05MkicNC8SzsAFXKXmtyaz5xgrCc4VshLILerKZBTeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329805; c=relaxed/simple;
	bh=+lIX9/v11+BoYiEBQHEK4lg4jIirIDoOfwf7R8IM3SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suVWt//o0sNCByih4UIK0LukCSGX+hm6ZnZYltYjOWWhc9zx50LyYFFul98dde+X8ajP6t6nuUKEkdOz7l2rq0dKnbsJppgEd1BLF3AYJCspDlE6orDFU2y3fBioOamsrH/ZxPZH33OGnmNWEgFbEuJiiTk4rSW7Fpa0gbjuyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HC1zfhPJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744329800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lIX9/v11+BoYiEBQHEK4lg4jIirIDoOfwf7R8IM3SU=;
	b=HC1zfhPJZ/60exfVRt4XF6oPqJKIMImvaMvaCfL/G24AYsjDxLyxM9Rq3G9ERmU9rvDaE6
	8wxjT+1vp/Pxqt5PX6jG3BLY5s0yvpZ05cWa8bdCCrxlhu5kR3t9wjjLZPQxS7UoEKk2eE
	B5GRUu7+54OJO+Y9/2aKgXqzufiWv2o=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Yosry Ahmed <yosry.ahmed@linux.dev>,  Waiman
 Long <llong@redhat.com>,  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: optimize memcg_rstat_updated
In-Reply-To: <20250410025752.92159-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Wed, 9 Apr 2025 19:57:52 -0700")
References: <20250410025752.92159-1-shakeel.butt@linux.dev>
Date: Fri, 11 Apr 2025 00:03:14 +0000
Message-ID: <7ia4semfzhrx.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> Currently the kernel maintains the stats updates per-memcg which is
> needed to implement stats flushing threshold. On the update side, the
> update is added to the per-cpu per-memcg update of the given memcg and
> all of its ancestors. However when the given memcg has passed the
> flushing threshold, all of its ancestors should have passed the
> threshold as well. There is no need to traverse up the memcg tree to
> maintain the stats updates.
>
> Perf profile collected from our fleet shows that memcg_rstat_updated is
> one of the most expensive memcg function i.e. a lot of cumulative CPU
> is being spent on it. So, even small micro optimizations matter a lot.
> This patch is microbenchmarked with multiple instances of netperf on a
> single machine with locally running netserver and we see couple of
> percentage of improvement.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

