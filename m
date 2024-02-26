Return-Path: <cgroups+bounces-1831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E695C866A8D
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876831F230D0
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67A1BDD6;
	Mon, 26 Feb 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1rcZf1X"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D9175BE;
	Mon, 26 Feb 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931779; cv=none; b=LVcL3oiqr8jfU0m7BH4wpi45ADAx4D6fNXkCycOWwrJqxB5+Jt4U4+ujZmxLM54ke66pV0EqHe3+V5HEs8K/Y/Kz/K/sRvsGF0j0VrgLuepVpaqqXacTjaiLlvIuXq31WSK4T+k5qanoiqmJDmVa/pmlerwPZ9UuTLt9Fp9YYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931779; c=relaxed/simple;
	bh=2RlYg33BiX3NtOsnhjj8RG35wYd23faEZA9/J7KHbxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snIQ4VNmGA0Ag7I7+LlzwsutMARbsR1Pp2JaHMMG0QWZ8T6vwgz6NxdmuxFIPtCFNEqGoIl0uXYQU7fTukHCWh+gO3Xg1RCyrcvh7RUOZ1CUEYa0sMELVzapfFVgeiuZxzE+khbLJnTy+s+ZIf+z8VgadLiw4Ysb0OM/IW5/PQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1rcZf1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE762C433F1;
	Mon, 26 Feb 2024 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708931778;
	bh=2RlYg33BiX3NtOsnhjj8RG35wYd23faEZA9/J7KHbxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1rcZf1XGpMfTaBMYLeAoV171MgKE7m65z3JRw0SEcLJ55iYD094dU3ftd7qu+Agr
	 4VwA93Kx7VlL7e5sNXNEyCO093O3vbnt+ry+xgxcxSMqRjCJIlZ/Oqx6V40OD+orGJ
	 kz+zTkP1eGflBYXA22cnP2SsmKicWPey+bHi6ag8=
Date: Mon, 26 Feb 2024 08:16:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable 4.19] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <2024022601-flavorful-gerbil-da52@gregkh>
References: <20240226030140.129822-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226030140.129822-1-gongruiqi1@huawei.com>

On Mon, Feb 26, 2024 at 11:01:40AM +0800, GONG, Ruiqi wrote:
> From: Roman Gushchin <guro@fb.com>
> 
> commit e1a366be5cb4f849ec4de170d50eebc08bb0af20 upstream.
> 
> Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> introduced css_tryget()/css_put() calls in drain_all_stock(), which are
> supposed to protect the target memory cgroup from being released during
> the mem_cgroup_is_descendant() call.
> 
> However, it's not completely safe.  In theory, memcg can go away between
> reading stock->cached pointer and calling css_tryget().
> 
> This can happen if drain_all_stock() races with drain_local_stock()
> performed on the remote cpu as a result of a work, scheduled by the
> previous invocation of drain_all_stock().
> 
> The race is a bit theoretical and there are few chances to trigger it, but
> the current code looks a bit confusing, so it makes sense to fix it
> anyway.  The code looks like as if css_tryget() and css_put() are used to
> protect stocks drainage.  It's not necessary because stocked pages are
> holding references to the cached cgroup.  And it obviously won't work for
> works, scheduled on other cpus.
> 
> So, let's read the stock->cached pointer and evaluate the memory cgroup
> inside a rcu read section, and get rid of css_tryget()/css_put() calls.
> 
> Link: http://lkml.kernel.org/r/20190802192241.3253165-1-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org  # 4.19
> Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> This patch [1] fixed a UAF problem in drain_all_stock() existed prior to
> 5.9, and following discussions [2] mentioned that the fix depends on an
> RCU read protection to stock->cached (introduced in 5.4), which doesn't
> existed in 4.19. So backport this part to 4.19 as well.

Now queued up, thanks.

greg k-h

