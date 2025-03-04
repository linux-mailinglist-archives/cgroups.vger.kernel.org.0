Return-Path: <cgroups+bounces-6828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA25A4EA34
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85DA8E279B
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436829CB40;
	Tue,  4 Mar 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLaoZ0YZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02A29AB1E;
	Tue,  4 Mar 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107163; cv=none; b=OvHdNegOxR5uAmItHQJg1BHXeZFZ69BaaKyqTrDKn88tIQVTM9uFUfxveYr8izuG2Nraxp9w5PBZa/YR/2wsQQ5GfHYO523whEw69/pmsqs4d5ksUU2ckT6si5uJtCha/2zqq2RKCGNJnSrf/PqD60Q8556o67JNIT7JbC0CosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107163; c=relaxed/simple;
	bh=p6k6TIcPxOn8qxI+yl0ark5cHOmqk34y2qGvsoBd9fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktAs8yzV+7vY2e+KZ8Pi+SAC8jM+dYRkyuHQCtnsTmz8wkGFy40DDw8uMYqsoAfNf1mwrnKjAAkO+ik4ukR8xfP+oOvqKhS/Mx9B+mUKVef1KzI6E2LFSV109gC9wQmeFPrDZC1Ze1jIv4sg1ZgR/wpPTe09D95BbSDjxyibj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLaoZ0YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B651C4CEE7;
	Tue,  4 Mar 2025 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107162;
	bh=p6k6TIcPxOn8qxI+yl0ark5cHOmqk34y2qGvsoBd9fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLaoZ0YZj3JXbH6zRYGoa13OlLiJe8h2qk0Vclz15mh47XPs5IfZOQKSCqIb1D7qK
	 xbK/pWKqu3tDxHbQh+BGyNvry985MRwC6nrL8dP7HOdvZ/xS5JethFIzHIOlCozuCE
	 yDDM1VV8rQb1CnBgL1kz81Ht7c4EdO0Nbb0N3iUwDS2aQHuKVOnPpT460lCg1hgJ41
	 D3ScfzecFFkyRbR+VjoDWWUc+8J1d4KJTPIo5Od6h4rqLcvgAGV1Njx6018oZo6QmA
	 AXSZzyDIoIPpbxChG0xyAMTWEbR9f6jmHZpgNHBpEvHA5rP70nTbGsvqlgABn/4lOa
	 1GWT2NiwQTazw==
Date: Tue, 4 Mar 2025 06:52:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>

On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
...
> I do have some concern with the use of pr_warn*() because some users may
> attempt to use the panic_on_warn command line option.

Yeah, let's print these as info.

Thanks.

-- 
tejun

