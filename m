Return-Path: <cgroups+bounces-9699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D3B432D2
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 08:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB2D682555
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E928541F;
	Thu,  4 Sep 2025 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flQx09cW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751C2857E0;
	Thu,  4 Sep 2025 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968727; cv=none; b=pLIMMaUJRpvRFhMrA2JK0KYDRPV3g39A4AW9N50fkYkVYkAG/JXSw5pG9Pi4e9bTnpCYdvyAvO9AMtf5IJyEB6vXt6vl7JEGwZaDeZzt/K0G7PDwTg+vzFjyhzJZROwT/Cqj71JQxx6okU60n9fFC8AStK/1+TmC5UY/UpIFdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968727; c=relaxed/simple;
	bh=HJ0yoW190s9pNjkNB8sld0ql5LrKJW/Ikwpd42F0UZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryYdYK+6OuWvdV+an8R4MnMqHHJ3cGYxr/Q/3eHpOTmJUPHWT2yut9QBDq4h+bCZ9uSsondnwHyM4aPq8PXWLXxEATxRT+6RpnM67+bxdpNhypi65kywIyeOUmcoLlLe9TQAAk3UF2Kd5FRATx0WnxVA26bXFMMgOQMe6Kw6/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flQx09cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF24CC4CEF1;
	Thu,  4 Sep 2025 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756968727;
	bh=HJ0yoW190s9pNjkNB8sld0ql5LrKJW/Ikwpd42F0UZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flQx09cWfSfC+dEt40N5TJfMMFO3Y+0J+hyxFtsDaN5tZ6Pr9yJm031HirT6xFZ/8
	 yJe/Ly9+rv4MU92NVAcnwWTDchTQD8S6lr2qE7V5A+mWe6jRadKgzZNyL9Lh2Vjotz
	 fvIzT9hVecZrLfuG6lU7AU/zoXnodEzKr+lQR5MBdtr6axZxFzBuUuTw9fba8CYdgp
	 aIb9yD4t+IF9hYPuWUuUS0oxMkg1HaQOEal3YgsgFGPHL8/Y30GbvxkW/ugL9yh1AU
	 cMEtB9G3KTe3ao5soN2qAoYNjesluQlBwlaMxuKmH+LpA2pjJ2pG0AAkFoVLf9W8XA
	 8u1dT3GLuxXoQ==
Date: Wed, 3 Sep 2025 20:52:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Yi Tao <escape@linux.alibaba.com>, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLk3Fftch9lUMJTv@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
 <aLio7Z6YolSZ2lPo@slm.duckdns.org>
 <7e05b179-90ec-449b-86a8-796f4a12180a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e05b179-90ec-449b-86a8-796f4a12180a@huaweicloud.com>

Hello,

On Thu, Sep 04, 2025 at 09:40:12AM +0800, Chen Ridong wrote:
...
> > Sorry, I was confused. We no longer need to write lock threadgroup rwsem
> > when CLONE_INTO_CGROUP'ing into an empty cgroup. We do still need
> > cgroup_mutex.
> > 
> >   671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree")
> > 
> > Thanks.
> > 
> 
> I'm still a bit confused. Commit 671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when
> updating csses on an empty subtree") only applies to CSS updates. However, cloning with
> CLONE_INTO_CGROUP still requires acquiring the threadgroup_rwsem.
> 
> cgroup_can_fork
>   cgroup_css_set_fork
>     	if (kargs->flags & CLONE_INTO_CGROUP)
> 		cgroup_lock();
> 	cgroup_threadgroup_change_begin(current);

Ah, yeah, I'm misremembering things, sorry. What got elided in that commit
is down_write of threadgroup_rwsem when enabling controllers on empty
cgroups, which was the only operation which still needed to down_write the
rwsem. Here's an excerpt from the commit message:

    After this optimization, the usage pattern of creating a cgroup, enabling
    the necessary controllers, and then seeding it with CLONE_INTO_CGROUP and
    then removing the cgroup after it becomes empty doesn't need to write-lock
    threadgroup_rwsem at all.

It's true that cgroup_threadgroup_change_begin() down_reads the
threadgroup_rwsem but that is a percpu_rwsem whose read operations are
percpu inc/dec. This doesn't add any noticeable overhead or has any
scalability concerns.

So, if you follow the "recommended" workflow, the only remaining possible
scalability bottleneck is cgroup_mutex.

Thanks.

-- 
tejun

