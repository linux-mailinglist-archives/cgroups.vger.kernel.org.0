Return-Path: <cgroups+bounces-13295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5087D39239
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 03:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87BB83016713
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C321C862E;
	Sun, 18 Jan 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="alEnM+zJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1562030A
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703504; cv=none; b=q8qiPpRcb8jvBkGsyq1+gByth8PRMBNUuk9uI9xXP6O8hDmhLzP9oXWiwqGDDuVMGsIPSuQ+uTMAG0TWYjt+DplPbguHsiWZKEsXmREglNga7iU9RmZUzealuht6xD1Ij/rrGdnNLN/AcHCTgEESklPqGW7r86ULKbhdbU7IcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703504; c=relaxed/simple;
	bh=z+5ReD/NsroQ5hfJpiBe/k3IdPvKI5oUQRfmLIdlXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blCjn2I5XrBQCOsRXMCiJvVgqlGE3OlOPr/ARAlzVWgP9xWxCKQGR50YvjylXUa5vChZiAfWA89IbCJzG/W9Gm9d0X3Mo14dri2AskPbqnk49+WTtoIkF+q7YxTEvLxCGAPxwlUITCQD9iLMxfSwXYKffAzK0GPKHdLGR2TDUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=alEnM+zJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 18:31:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768703490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVyrnUL8zuFDrB2yKHZ5XxjKgpBYjM8YXHosymhizjo=;
	b=alEnM+zJduTMngpocxLdYSYNEc9ZNL1G28Wafkqo9SGq0U0J0dBta03kWy/eI497f77MwY
	PYny9KNxs8pvp7CGAs8BUt5gDOf80wx93mTyrB8JOocTCbPoqgwee+p8M925dvlyE1NPts
	iI2lITI4Y2mtuAZHqDIeLVi/i7scHUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 27/30] mm: memcontrol: refactor memcg_reparent_objcgs()
Message-ID: <2xkuf2k4wex6esebked3ic75gxqgqduxoy2ujdouyd6neppp4n@srl4nhxvxvlk>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <843e9537bf6b99cc7f19744a6f53b92338c96bfe.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843e9537bf6b99cc7f19744a6f53b92338c96bfe.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:54PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
> LRU folios here.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

