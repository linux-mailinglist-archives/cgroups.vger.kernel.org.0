Return-Path: <cgroups+bounces-5837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DCA9ED959
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36EE166B67
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3645E1E9B16;
	Wed, 11 Dec 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qv5X/xPv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F11F03E4
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954784; cv=none; b=gEIV7Xuivz+d5r1W//TwN95B1u9Q2MLxBr3O0m1GDbEzte+dj1bIXZjhjVOeNgKGnHCOpN/au8RapykypxwEL5MTzJQ+9oRZShsP/FYlW3e57O3fwqKGaGusco8p98tbRiHZCz32+WtOonW3pioujMtFMowjjiqAiwzIr2Juz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954784; c=relaxed/simple;
	bh=4Y3BkeZQ8i8Lo7CakpEfxhL7Ipz+fw24L2kNf5tu4mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIvD03cZsZg/IwnUDW07XRlZVmXpW+sObgKQBbn6Ugky0mL2sCsQzMUCn6ebPxOvFaJLHNjouI8adiU3yu7VePTWJwZrBgx7P1X67uWPoQYrc1KVzNlhy+vLaTifKevcq11i8wMCB/nU8sGgyBQ6DZTjAd/xsbMbmYK5l4qYRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qv5X/xPv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 14:06:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733954780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VOfl11aVQjjQ03B4nJjzJwNXXBd1opTt5mcv9gYqzc=;
	b=qv5X/xPvFcNThlC4whgtE5EK7P/ICRK4K9ngyzwR/+55o2KfZZv+DejqlzqwCMHPg5gn1a
	CWuw9DDMMvxLNQGUjCwOxR/yf6OpRmXKiQFjVoKjzIgYpvm5/20GkeNKPrel56IAUrmNJv
	m7iakyyuA9HPbe785cfT4HR4bJZ1+pA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, sj@kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [v3 PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <bjsf7brb3i5fc4druf6k5bctmolii3af5bvhcyshjbx7zgwxcx@oa2gsqcyaacl>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
 <20241211203951.764733-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211203951.764733-3-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 12:39:50PM -0800, Joshua Hahn wrote:
> This patch introduces mem_cgroup_charge_hugetlb which combines the logic
> of mem_cgroup_hugetlb_try_charge / mem_cgroup_hugetlb_commit_charge and
> removes the need for mem_cgroup_hugetlb_cancel_charge. It also reduces
> the footprint of memcg in hugetlb code and consolidates all memcg
> related error paths into one.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

