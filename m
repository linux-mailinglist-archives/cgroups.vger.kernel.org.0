Return-Path: <cgroups+bounces-2770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B178BB1F8
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B5E1C21A5E
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FE1586C1;
	Fri,  3 May 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w3LHePTe"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4313B593
	for <cgroups@vger.kernel.org>; Fri,  3 May 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758887; cv=none; b=Q9MD3MpwPj1ciHrGDHI9kYvS0GTZxf+KrfM6HLfZdVqzEWQRAzT5zzeoFwC96yM4p27Mnw+PyylbbgFnKPjJJLJ229liVF8rioW9Ha7/dhNbzpH3JEvTTqjWNxPPTA0XipDaWVJ0fVOVmJnHTAKC+71c+nsEJ8Y9ew7sMZ0vDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758887; c=relaxed/simple;
	bh=lypo2M4qo87JGtdc3hDkTp3pEo6t7MvTelzTkGrBKlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUXxgIyvuDMoKXmEAJ0+yHDdj6prUI3LNsinc7svQC/CnvkcE6CVO2PjQwNOOEJlwBdDjJGyORhALPShdFLcYXEXIxw9wmTFGrEwRPOBLB/IzdGgA2tSD0sKeHhhcUw7sBOpKUEMcE1DD3FhiZJ7qDuSa1COL9hnwLM4N1gWz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w3LHePTe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 10:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714758882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viaLAewCzGtCTKetlsX4e8AVwuJyrmIUfGHPX1vb/sw=;
	b=w3LHePTeLz2K9FRYMUNxS0jF0kYOiNeduwQD8+4Y7GA9YHHWJydFV5bJtZBGuhwbEHjcGY
	NjvQKoPD+odFWT6rzgaNHNzKFO2j5VP/PsjME0UqhJMJEDtZLeAP+Am9BJ9V7/D4A3/68r
	rJOxx5DkCTOJOpWB87WtS80/G6IA2UA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 2/4] selftests/cgroup: fix clang warnings: uninitialized
 fd variable
Message-ID: <ZjUk3JxrKYQ1vgNv@P9FQF9L96D>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
 <20240503035105.93280-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503035105.93280-3-jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 02, 2024 at 08:51:03PM -0700, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...clang warns about fd being used uninitialized, in
> test_memcg_reclaim()'s error handling path.
> 
> Fix this by initializing fd to -1.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

