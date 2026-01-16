Return-Path: <cgroups+bounces-13268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B56D2DA7A
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F84300E035
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4121FF47;
	Fri, 16 Jan 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aESshZcc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8363FFD;
	Fri, 16 Jan 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550389; cv=none; b=mB0Mhb5Dc+bLehocv6OSce6ErMQmCUDTA+ZqBnW1v7IlIjnJ83ZVZs9JJjinMb45MJFrc8cBaySJsXbj+FfGRvWKoNO/uOk/EMraGf3KF1huGi560OeYxKi/3w086cC0JQQNBnXNi/5yCPDfuB+4SGCPztAv10I5hLDG3lXAluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550389; c=relaxed/simple;
	bh=L+y6jRHplfRtYsjc5T172/xkJ1SxXn11VcmlD4pgIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUEJHltbEszjINQp6It/ufI79P+BO/RlP659BmG73KQJxfjGORKEt1XHCP5lTNJqIUMDlTBFEsJAF3lJIZ8IO5j52tMsDvMoujDpmJdd9I+qGdpVjBzNsJzE7u2HgW41rfWuKlkOqtQfj2b4Rbp2WP/h9tMN1wuq6T1V3fCTLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aESshZcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA65C116C6;
	Fri, 16 Jan 2026 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550389;
	bh=L+y6jRHplfRtYsjc5T172/xkJ1SxXn11VcmlD4pgIQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aESshZccndDY41NnlA9q5yPG4LaNj79dJ5mXbpEwuhodmzeq3bDfg7GI8WprivmzK
	 laWzczeVqszUUwgOvOxgp2c7e3OdoQupx5UoJ1ZrHXzS3fTu6uWWuri6XibM58ufnr
	 M3f3PNJ4/wOOkOtW7gfdaWVnBS+OQ4FUKCgV+VtGkTQEKBFNUr37k8xLrtVtMTF1JL
	 JLBe/CAvxw2IODrMj9Vrredzqvgt98Ni9Rt8T/gtf9COE/J5LGDrkuqfFS2Jqfd0jO
	 5193b9DhXQK6zgu1QnV3pv3AwlGc6Sf70Hnu512ygyWORyXdzbsRknIw9sVkhVpNK8
	 J2AFcbLnudAiA==
Date: Thu, 15 Jan 2026 21:59:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cgroup: use nodes_and() output where appropriate
Message-ID: <aWnv9H2Vn6Gqmp5C@slm.duckdns.org>
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-4-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114172217.861204-4-ynorov@nvidia.com>

On Wed, Jan 14, 2026 at 12:22:15PM -0500, Yury Norov wrote:
> Now that nodes_and() returns true if the result nodemask is not empty,
> drop useless nodes_intersects() in guarantee_online_mems() and
> nodes_empty() in update_nodemasks_hier(), which both are O(N).
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route together with the prerequisite patches.

Thanks.

-- 
tejun

