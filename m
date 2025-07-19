Return-Path: <cgroups+bounces-8783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B4B0B0E1
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56724AA3BD0
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA023814D;
	Sat, 19 Jul 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWHfN6sZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E91A8F97;
	Sat, 19 Jul 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941930; cv=none; b=FyKwZ8GViOt6IUJspwIZClROQRlPvJS6k5ta6siNoMrZ8kSp17fnY4hw84+WSE1rV6hMPmSIPvHGtW0wVhknfPEZ/7itc3BqRbFY8BNlDpO8Fz6f1OacmpV55kSvQ0sMfyc6nhjAClMimbJWrZECftf4HpTOSlIsD9mwQavv4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941930; c=relaxed/simple;
	bh=aADY7+3tkziPCEq2NHNLsmMeENfFcbzEoNIUNUuj/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP8qeNnz34LTekWvToeq1jHR5HI2sI1eueGoKJBHktCQSx/YvpzGx/9z2YP52c5Byplwv2y0aiia9yK61VkoWgSk1MQv7V8zi0VcmCGwfV9bIwq6QUMow1393NkPSh9CqjPICOWq2A9WRJX12JOHzUD5Z0qwHCp+tLuWmKNHbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWHfN6sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5128C4CEE3;
	Sat, 19 Jul 2025 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752941930;
	bh=aADY7+3tkziPCEq2NHNLsmMeENfFcbzEoNIUNUuj/zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWHfN6sZ4I/IFdbxgUMDIi1ZsXpD6lo5RKB9Asc7gBYUpffn7mj/hMe1QiMo1nZPi
	 BTFmc5g2XPj+sJ4zBgbi8mo088EUEM0hd4z2oDGSGfT7yedN2NC60vsDRsfOJFHEX4
	 h+sXrfhpL3OdA6P8R+QfCrmPZgw9uRBwcVdwfyiqlJW1b0oCBK8jHAADoCf4U/XKLV
	 6yqIy1ABBfGrhNFlHR51sfhJGYVQp1bx+wvvEmseglnQT1LzcV4xFHckU0OJHvyIB8
	 ZfSENUetO1gNmIBXtqatNymJ2zU3McgW/yzyBzXMoicmGfzfvati/ictoZqEimj2o5
	 yVI87RgFYODsg==
Date: Sat, 19 Jul 2025 06:18:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>, 1108294@bugs.debian.org
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <aHvFaAtLUVAaPq6D@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
 <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
 <aHGM6_WOTWLiUdpU@slm.duckdns.org>
 <7sbzasggfk3elhvxsd5mtuzd4yo3c64wuzkaulr7yqybpfxwuh@g6dcatriw7hx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7sbzasggfk3elhvxsd5mtuzd4yo3c64wuzkaulr7yqybpfxwuh@g6dcatriw7hx>

On Fri, Jul 18, 2025 at 11:18:54AM +0200, Michal Koutný wrote:
> From ace88e9e3a77ff3fe86aee4b7a5866b3bfd2df58 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
> Date: Thu, 17 Jul 2025 17:38:47 +0200
> Subject: [PATCH] cgroup: Add compatibility option for content of /proc/cgroups
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> /proc/cgroups lists only v1 controllers by default, however, this is
> only enforced since the commit af000ce85293b ("cgroup: Do not report
> unavailable v1 controllers in /proc/cgroups") and there is software in
> the wild that uses content of /proc/cgroups to decide on availability of
> v2 (sic) controllers.
> 
> Add a boottime param that can bring back the previous behavior for
> setups where the check in the software cannot be changed and it causes
> e.g. unintended OOMs.
> 
> Also, this patch takes out cgrp_v1_visible from cgroup1_subsys_absent()
> guard since it's only important to check which hierarchy (v1 vs v2) the
> subsys is attached to. This has no effect on the printed message but
> the code is cleaner since cgrp_v1_visible is really about mounted
> hierarchies, not the content of /proc/cgroups.
> 
> Link: https://lore.kernel.org/r/b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk
> Fixes: af000ce85293b ("cgroup: Do not report unavailable v1 controllers in /proc/cgroups")
> Fixes: a0ab1453226d8 ("cgroup: Print message when /proc/cgroups is read on v2-only system")
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

