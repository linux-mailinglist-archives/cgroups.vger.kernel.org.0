Return-Path: <cgroups+bounces-12517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A35FCCD343
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 19:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B233056691
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F92E22B5;
	Thu, 18 Dec 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5o/F+9J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D3218ACC;
	Thu, 18 Dec 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083164; cv=none; b=eVPdysOqCJyzlUwu5r8OK0Lf3U10Me1QCFtbKHxprtAO8F5IjFlNBQ2RVWvz/ZDphmsouWll1h8V/slvdhk1zM4hMag3s8dS7B/TSUgRPADk0pYaL9EHjX4MYVEiGEjSLA19K6gqP7gfKBeiAwCblnOzqbz6eB81ulxX88Uqd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083164; c=relaxed/simple;
	bh=eR81AWsp7QsWabM6Lj0A181uRQSN99KlCYYj7vb19ak=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sg1i+iD+d+VUW2DogYN4+dE1D/fRkOAVieKLzmQQiuAyK/RTHkyyJhp5bs0o390hqo0H8GZjt/Lm/tfum6T4UjPOl3Wot/0Pp+oNBkKcUXUArX/4yM4IYx67f2hXRRxlK2sMGUi3oVZKitbLQfchNzT7h2v7g7s8Ew02uSu2rz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5o/F+9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8657C4CEFB;
	Thu, 18 Dec 2025 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766083163;
	bh=eR81AWsp7QsWabM6Lj0A181uRQSN99KlCYYj7vb19ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5o/F+9J74OlmMVDcrdnYTSjcUF8vZ5S/o+vvpUfkNcQv5nW4y6iIjlKlKE7l+OpL
	 qcjQ152MQcO9Rm6WbeXfaQ419Oc7Vrwablh1QhB019N0kmikX6NDnQ8nKEZlvYRTKR
	 /yI5ZPi8S2xS99zjpAJL5Sj3CnEnPfSjrZbco4Z696PC8/sj8sFq1x9uAqNAsKFmY7
	 pwiPqIm37cF2Di2jvak3duAHsANle+EBix6RP0+79CDdCf5EeqcYC8Ocj55L/E67sL
	 cVqlv9mok/eNTVa0Uluxp03CuW6aniJkWFQDrfQQvNGqqWM7ZlIDMk6hGEtVD6xqa0
	 f1V2qfgBkJc3w==
Date: Thu, 18 Dec 2025 08:39:22 -1000
Message-ID: <199daf7b81a301a7709e586ed3ffe49e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next v2 0/6] cpuset: further separate v1 and v2
 implementations
In-Reply-To: <20251218093141.2687291-1-chenridong@huaweicloud.com>
References: <20251218093141.2687291-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Chen Ridong (6):
>   cpuset: add lockdep_assert_cpuset_lock_held helper
>   cpuset: add cpuset1_online_css helper for v1-specific operations
>   cpuset: add cpuset1_init helper for v1 initialization
>   cpuset: move update_domain_attr_tree to cpuset_v1.c
>   cpuset: separate generate_sched_domains for v1 and v2
>   cpuset: remove v1-specific code from generate_sched_domains

Applied 1-6 to cgroup/for-6.20.

Thanks.

-- 
tejun

