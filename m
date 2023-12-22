Return-Path: <cgroups+bounces-998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3981C4F2
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 07:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987B71C220BF
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C896FC2;
	Fri, 22 Dec 2023 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPTYSxJ6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF45B664;
	Fri, 22 Dec 2023 06:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43C1C433C9;
	Fri, 22 Dec 2023 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703225720;
	bh=o34cTG3PLEzDraS+QQ0GYDod+AXopLJCVpOjWSq9VxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPTYSxJ6q/QYHzctslnCdQKQejYkiQIWnjTqwwogPxm+3mHkI6lj0PAJ1aLZ0gQZX
	 tLCs2apfhBf5tjvzzaY0hBF/zBXGfBegVBVAHfKnUKly4LZG+IXAzMvMyXpNWqlt+E
	 OTX4SkZiGE/i2GWPAAzsw/9esVagC+CDceyW1wOM=
Date: Fri, 22 Dec 2023 07:15:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <2023122207-faceless-despair-af43@gregkh>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
 <ZYSuR5cxkDh9Vrpt@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYSuR5cxkDh9Vrpt@mtj.duckdns.org>

On Fri, Dec 22, 2023 at 06:29:43AM +0900, Tejun Heo wrote:
> On Fri, Dec 08, 2023 at 10:33:09AM +0100, Max Kellermann wrote:
> > By passing the fsugid to kernfs_create_dir_ns(), we don't need
> > cgroup_kn_set_ugid() any longer.  That function was added for exactly
> > this purpose by commit 49957f8e2a43 ("cgroup: newly created dirs and
> > files should be owned by the creator").
> > 
> > Eliminating this piece of duplicate code means we benefit from future
> > improvements to kernfs_create_dir_ns(); for example, both are lacking
> > S_ISGID support currently, which my next patch will add to
> > kernfs_create_dir_ns().  It cannot (easily) be added to
> > cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
> > from there.
> > 
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Applied to cgroup/for-6.8. Greg, can you please take the second patch?

Both are already in my tree, thanks.

greg k-h

