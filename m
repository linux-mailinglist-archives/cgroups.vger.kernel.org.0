Return-Path: <cgroups+bounces-9775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15155B47B7D
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C109F4E05A8
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2726B749;
	Sun,  7 Sep 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dph8UJdu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91022217716;
	Sun,  7 Sep 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757250606; cv=none; b=EFMojJU+i1YJp7qdALJVJ2Xnyq4/YMXU8GubEDbGljMIlUui4UjD+dWQZEooGUMQbDf1rWBhiE1MnyBksFwk9fHE79679wBuroU/sL3eENMwIWaXsIhPSvMXMXl1y7UrBIKw6mV0+10xyKR38MPW2uvEhY93TZJWGB9i97vn9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757250606; c=relaxed/simple;
	bh=hzoFaHAIdZp2haJZbagmxAgkiZGTROGPUGuinQ8WjrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP/mLV99gvPYMW30mTANE9VJo7+kklu5JUp2eISXcHfMeW0v3hoBgYTt0UomaXGxK0ODtlOkwFcL8jOUGWF0vPTH0rj/RwqckUenpDtsKwuOkRYswmGsoRFx5Qc4qQCyYUqKxHlooAI2fjg0ZIxyX5hUDVJmdig7lEiFI0mWs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dph8UJdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E05C4CEF0;
	Sun,  7 Sep 2025 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757250606;
	bh=hzoFaHAIdZp2haJZbagmxAgkiZGTROGPUGuinQ8WjrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dph8UJduGjbCAOusaVKDWVM0Nbup/WEtW2XPVYZyxABS6fnmFsoMr73WpsXRlussQ
	 HxY2rKJit6AUd3+Osf46yikDJKhoOHijn52a49QXH1e9jJEph4b5+zVKg0QsAfKqPL
	 RHEp+t/rxhvcm/EDfDvWIWH0yMtLyIW/lra9m5iQ=
Date: Sun, 7 Sep 2025 15:10:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Guerrero <ajgja@amazon.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	vdavydov.dev@gmail.com, akpm@linux-foundation.org,
	shakeelb@google.com, guro@fb.com, gunnarku@amazon.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Message-ID: <2025090735-glade-paralegal-cdd1@gregkh>
References: <20250906032108.30539-1-ajgja@amazon.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906032108.30539-1-ajgja@amazon.com>

On Sat, Sep 06, 2025 at 03:21:08AM +0000, Andrew Guerrero wrote:
> A filesystem writeback performance issue was discovered by repeatedly
> running CPU hotplug operations while a process in a cgroup with memory
> and io controllers enabled wrote to an ext4 file in a loop.
> 
> When a CPU is offlined, the memcg_hotplug_cpu_dead() callback function
> flushes per-cpu vmstats counters. However, instead of applying a per-cpu
> counter once to each cgroup in the heirarchy, the per-cpu counter is
> applied repeatedly just to the nested cgroup. Under certain conditions,
> the per-cpu NR_FILE_DIRTY counter is routinely positive during hotplug
> events and the dirty file count artifically inflates. Once the dirty
> file count grows past the dirty_freerun_ceiling(), balance_dirty_pages()
> starts a backgroup writeback each time a file page is marked dirty
> within the nested cgroup.
> 
> This change fixes memcg_hotplug_cpu_dead() so that the per-cpu vmstats
> and vmevents counters are applied once to each cgroup in the heirarchy,
> similar to __mod_memcg_state() and __count_memcg_events().
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> Signed-off-by: Andrew Guerrero <ajgja@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
> Hey all,
> 
> This patch is intended for the 5.10 longterm release branch. It will not apply
> cleanly to mainline and is inadvertantly fixed by a larger series of changes in 
> later release branches:
> a3d4c05a4474 ("mm: memcontrol: fix cpuhotplug statistics flushing").

Why can't we take those instead?

> In 5.15, the counter flushing code is completely removed. This may be another
> viable option here too, though it's a larger change.

If it's not needed anymore, why not just remove it with the upstream
commits as well?

thanks,

greg k-h

