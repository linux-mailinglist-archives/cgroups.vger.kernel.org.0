Return-Path: <cgroups+bounces-7170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB64A6993C
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7397B482E59
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43B22135A1;
	Wed, 19 Mar 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmbagfGI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A39212FBD
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412459; cv=none; b=kdsflrWeTSe3+dpo5c4Ia2Eg0WykkewcZWteOPn2kZtTmDG7UtQ+Yfmhkp1uEUrSdxtioA2qwtoQhSGzDcJu7Isxjl7Z4hsLs2LhnMIxhozFtIZzvjnKvZ/gPb3AQrkNfVpH78dA8jKEzdQhjbRmREoFoB2fOxJKCMhCfi5L5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412459; c=relaxed/simple;
	bh=DTxzun+gUvrsEUiBL9zGZsTSEMdGP6mFnSJ9xN9HF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv7GxCTIDHyXT91So853eZslbfomZrNCFLKYJSmopyQ5xZvqqVdwg33QYOpxikIjNGcxVl0gsTo1xjDuWiOlK97hL/VICbxb6YCnDUwoBKQo4IQVvAvNZkYz/OhyoZYtvilVOLPb2/RIRsRfPfWPV/wZCjn7mZD3MR8jIPu9SSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmbagfGI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZiap64g8PWqaP9A/RNcdWpawC9YJsZVtom3gXzvjSo=;
	b=rmbagfGIAuUu6eOihLERaOUKIATp+xlfmTWTVvBsfFUpuEXsjxx+BoiXxnJkWczGGlDq/r
	mqmT22bz0OZPCklCCh/35FHhmRL1bkTELkFMYS2s30XzEzC+KtFZuQabYDXG4oDyPVnwYf
	gX5RdjdI82wbo0Y0uVj5sqBeW+1m5xE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <gkuatggv6jhbl32x7rpzlcifcno6hoirw43v35vtkfflqmepfw@wwyz7x6hc4id>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

+Tejun

Hi Zeng,

On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> memsw account is a very useful knob for container memory
> overcommitting: It's a great abstraction of the "expected total
> memory usage" of a container, so containers can't allocate too
> much memory using SWAP, but still be able to SWAP out.
> 
> For a simple example, with memsw.limit == memory.limit, containers
> can't exceed their original memory limit, even with SWAP enabled, they
> get OOM killed as how they used to, but the host is now able to
> offload cold pages.
> 
> Similar ability seems absent with V2: With memory.swap.max == 0, the
> host can't use SWAP to reclaim container memory at all. But with a
> value larger than that, containers are able to overuse memory, causing
> delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> out of balance, especially with compress SWAP backends.
> 
> This patch set adds two interfaces to control the behavior of the
> memory.swap.max/current in cgroupv2:
> 
> CONFIG_MEMSW_ACCOUNT_ON_DFL
> cgroup.memsw_account_on_dfl={0, 1}
> 
> When one of the interfaces is enabled: memory.swap.current and
> memory.swap.max represents the usage/limit of swap.
> When neither is enabled (default behavior),memory.swap.current and
> memory.swap.max represents the usage/limit of memory+swap.
> 
> As discussed in [1], this patch set can change the semantics of
> of memory.swap.max/current to the v1-like behavior.
> 
> Link:
> https://lore.kernel.org/all/Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car/ [1]

Overall I don't have objection but I would like to keep the changes
separate from v2 code as much as possible.

More specifically:

1. Keep CONFIG_MEMSW_ACCOUNT_ON_DFL dependent on CONFIG_MEMCG_V1 and
   disabled by default (as you already did).

2. Keep the changes in memcontrol-v1.[h|c] as much as possible.

I will go over the patches but let's see what others have to say.

