Return-Path: <cgroups+bounces-12516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C2CCD15A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 19:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC51E30155D4
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919C3446CF;
	Thu, 18 Dec 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaOZjO8b"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E68355041;
	Thu, 18 Dec 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766081051; cv=none; b=G/0kuf9c3WjvhRaqnT08Wtzj3lSXvI35lmUom0aITe4EKqwzpVVVm02cKyAVfSPv0yPMRa0S2IQ3hZ+HkZhZHx6wS/Ee2ztasC4Dhd7DP0e/xqYUBE581CgSOcrj42NegOzXmtdw3A1/+TOexHYJcFnuaXvnKapN1veMCUzbgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766081051; c=relaxed/simple;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Q6O75RfoCbcVnFY8nuzeVv8ph/o7itsHnPAnq1UXEdB4jjHp3t2S0RLcVVZyQngqQ6iX+HOzj7TJLNbRWhhyNoGxwVhYBpBfO16u9cf6ACzJvO9cFiPy84zgcd8WJjwKyUlteSv0748VAEmkfbULped1jeMxOsbAJXrgNOTBi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaOZjO8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64588C113D0;
	Thu, 18 Dec 2025 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766081051;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QaOZjO8bb36bjwEDbjGH7aEghyRnvA2pWoUJzDq9hIVZ6sslswCJrH0rqYPq40G/5
	 uV4xg6tanMWmYBCJY+Q2swd61lgGmoaQ0T10vPvrdyNpDdVjp0rsLrUQhNbKBQ5syg
	 l5CdBwNbVDJpvSFBZ+sVbCWi+a7fo+ixydKHTLONksDJ+noAD/1qRiTtzZds7Nn6kO
	 NGt3X211xt9Q75lDrO1UFbrqNBblTnkG/Y1mdr/o6SvLSE7PAkLHZ6EfzGUwHpUNdJ
	 cqY11b2FRrUIe4AQnWMYJ/z5mJtc7WIC3gAHdJESSh7W8gP2cD4xQd7e+eVQ8fg3GA
	 vrJ/nMbKDRbTw==
Date: Thu, 18 Dec 2025 08:04:10 -1000
Message-ID: <1a685fbdba5ebe90c321e871ec2373da@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next v2] cpuset: fix warning when disabling remote
 partition
In-Reply-To: <20251218015950.2667813-1-chenridong@huaweicloud.com>
References: <20251218015950.2667813-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes.

Thanks.

--
tejun

