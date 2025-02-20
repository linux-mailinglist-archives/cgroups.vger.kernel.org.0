Return-Path: <cgroups+bounces-6624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFEAA3E215
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E671423947
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1F213E8E;
	Thu, 20 Feb 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DWQOPa1p"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF721323F
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071320; cv=none; b=EZroacf3vTQH4Z70Vg2OzR2ySC1QoVeM8XItA5mDB/NklUV4TyE9dyrA9Y4pmpwiuess+M4sawN82B2fsKdYaCbvVfpq8yCl/duxOVbtuk3Ku4Frn1/lOaduwxm6G/IPtQM70fck4CMUGhGyrlD1bDVLYKh6jFkhjGvpycqIZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071320; c=relaxed/simple;
	bh=oEOdvH2WOCO1j1BshNhA8Bbotypz5Rw69IdLsbWHO38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIWdNWrt97AdOZaXdwdH2fMc7aB/83LBqQ58c/NUnxeQ3B0nqWykr6F4HgZ7J6WAcxRXHjnZxId4ASDiUQ/HJzyF02rIQ5qnwpISIb0OA0zgMol237dcQ8PCQaMNtY33KWyFPBlUoJL75ik/a8IwxdfX6g/wPnRHXha2vrsCOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DWQOPa1p; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740071316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7RaaYPBvyR2i2/MPdBiVOheE81YWx6KyA9NN+p4Lg8=;
	b=DWQOPa1p7AEsqCPS5YnozITOMxq5rIQHz5affWSsOgswOsqAFl8XO7tSo2dFZoYh10ExIU
	ojdjF+m3JqHZqwCwiiRvyM8Op3iiXayVZ35qByYogsAWuo7rD2MNetOqsksvm1NjgsHaoV
	bjXQFKdFkiMD1ML+M1KJ3VOdaSv9QT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 02/11] cgroup: add level of indirection for cgroup_rstat
 struct
Message-ID: <Z7dhjBB8NJmxWg0F@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-3-inwardvessel@gmail.com>
 <xl2xxrfpixx66hbywv3njmdj6cckawtjiwri5nxcbc2gtz2ahu@5axlmmuzplzz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xl2xxrfpixx66hbywv3njmdj6cckawtjiwri5nxcbc2gtz2ahu@5axlmmuzplzz>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 18, 2025 at 06:26:07PM -0800, Shakeel Butt wrote:
> On Mon, Feb 17, 2025 at 07:14:39PM -0800, JP Kobryn wrote:
> > Change the type of rstat node from cgroup to the new cgroup_rstat
> > struct. Then for the rstat updated/flush api calls, add double under
> > versions that accept references to the cgroup_rstat struct. This new
> > level of indirection will allow for extending the public api further.
> > i.e. the cgroup_rstat struct can be embedded in a new type of object and
> > a public api can be added for that new type.
> > 
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> I think the code looks good here but the commit message needs some
> massaging. From what I understand, you are trying to decouple struct
> cgroup_rstat from struct cgroup, so later you can move struct
> cgroup_rstat in different structure (and maybe later some new structure
> can all include cgroup_rstat to take advantage of rstat infra). I am not
> sure I would call this "add level of indirection". 

+1 here and probably in other patches too. "Add level of indirection"
sounds like we are dereferencing one more pointer, which is not the case
here.

