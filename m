Return-Path: <cgroups+bounces-10899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446ABF297C
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 19:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AD461138
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72EF286D53;
	Mon, 20 Oct 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tryk6XYI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE5221FCA;
	Mon, 20 Oct 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979746; cv=none; b=E4PB7lIScy/1T+mTqjKg0c+0gVij6WeQ4O3ONR9fd1Gn2YHvUulGkUr1fywQ/K8O9o6ucj+uKLNwzKwxiiRR3bPP7cupeLFwNimtKZHwvjcr+269nsBA1YZDuyCIfMUcpbSdv9HHhL4h16z6mjqmdh2a/Sa/xpjI3JOdUqKqrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979746; c=relaxed/simple;
	bh=CZc7bLbAAaXtmvI4FA27UMlgky36yxvluZJsbxv4GO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLwE9UYxNZJjMsCdi4wTMT/ZsMUKu1Y1bcA0plWpiFlh6rU1v0gg5sy68vJc8HVTrOEa6JJGlJmimoUqX9PZpY9uouQpOmTjsnfhsoM27qFG4JrIUGAIAqc38rZ7VLDSH/4EtI+dxR0uqhO7SUpf9CDf9B5GQ2lHMXMnEnBPhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tryk6XYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF45C4CEF9;
	Mon, 20 Oct 2025 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979746;
	bh=CZc7bLbAAaXtmvI4FA27UMlgky36yxvluZJsbxv4GO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tryk6XYI/iB1bCmQaINS0LQ5+h3o/krykuixnRail7QIqUmz0MoUmY/QT0G+9yu2S
	 7sSNzCi2g7q71jWgE/pvEzCyjoRzr0FEy2ZpziwMd6sQjOga84AzdAY0Iv4W5iRmN/
	 T1/zEc5+6+DsA7JTsplg8ErYrDAvYlkThgJqYo7oK60/+CYNTupqnQ9jYiO42ac3EY
	 hj3OQc4aJjJmuzL1coKHe4M9bLhKcWMqSdGtRmKkQM0npJsnM0OivCrzNWsl5FrVfi
	 FO3IFYJnFPapxgC8b9nitbFVPlnJ2H9OrDFqDyPiWnpT0ZguyYT1y8PMa4XG3nzlnX
	 k/UHnW+W3NTGQ==
Date: Mon, 20 Oct 2025 07:02:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/2] cgroup/cpuset: Don't track # of local child
 partitions
Message-ID: <aPZrIV1Hhj9pIFqg@slm.duckdns.org>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020023207.177809-2-longman@redhat.com>

On Sun, Oct 19, 2025 at 10:32:06PM -0400, Waiman Long wrote:
> The cpuset structure has a nr_subparts field which tracks the number
> of child local partitions underneath a particular cpuset. Right now,
> nr_subparts is only used in partition_is_populated() to avoid iteration
> of child cpusets if the condition is right. So by always performing the
> child iteration, we can avoid tracking the number of child partitions
> and simplify the code a bit.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.19.

Thanks.

-- 
tejun

