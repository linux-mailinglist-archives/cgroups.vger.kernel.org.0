Return-Path: <cgroups+bounces-12752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9615ECDEE18
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 19:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CD3D3006AB6
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B51F5842;
	Fri, 26 Dec 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/IHzxXH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C5155322;
	Fri, 26 Dec 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766773410; cv=none; b=CzaTRczMSvjg8oIG7m73ZiwdIrYUzlVFRCVZYIX7N7W/S25B2IK6srueF2H8io2SmAnZkU5gWU3YOIK6c7ilgJSyIt4EazCVaztgTk32w0YUdvH0diA4p0uuwX8e4THd2qz4DIFwZxfMX/5mo3/FOLdssVlQf+8eHBxvwBPQgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766773410; c=relaxed/simple;
	bh=HKcf/FrOo4r2cMlrWajIA+xBQq8QQv76rSIhHCh2EJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI+v03ehTZ0KDKF6A2aw9I01fQIbYVaoHiMhtgItbHcc9ce8Eayl45ikjOH1mz3IHICaY/2VBFedc8XnWvu3GrfL7xh8fMMngvSVktO4X0mPYbG6U/Z4xuhOpLCTl9oYSndYsR8ceTGNeleuW/+dRiD4uQrdZP6m6ClIEt5z9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/IHzxXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D31C4CEF7;
	Fri, 26 Dec 2025 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766773410;
	bh=HKcf/FrOo4r2cMlrWajIA+xBQq8QQv76rSIhHCh2EJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/IHzxXH0B7ux0EIk0mXpM6cPMguYKa7IUt+jRIU4GIz0LS+Qw8urBxuTDlTpU54T
	 BU7UYOmb5ZoWgCrmRBIQ1tcMS+8rF7DVUvE2rhqXVZMae/nwsULIzmufuF1bopu3kb
	 goVEpP/+rLAysWLn3VeeBdogwLdn00a99eRbg5UV/lz6TUqaxwn1cvIGHBk6d742kH
	 FPMhP9GP7G/bRk95d9WnAyAgSKtJIlHuneBWPucQq543kS9Psyt2FgYz0S+4FGJzY4
	 2cbNep2RrbxwwYOb1HCntZcMHlYLK+mWfQXGDcY2icILBgXktEooQdfLrgnXqUe21c
	 GT5CbpYsGtTQQ==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] mm/damon: use cgroup ID instead of private memcg ID
Date: Fri, 26 Dec 2025 10:23:16 -0800
Message-ID: <20251226182320.254424-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225232116.294540-6-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 15:21:13 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> DAMON was using the internal private memcg ID which is meant for
> tracking kernel objects that outlive their cgroup. Switch to using the
> public cgroup ID instead.

Thank you for catching and fixing this!

> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

