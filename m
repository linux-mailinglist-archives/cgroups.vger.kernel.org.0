Return-Path: <cgroups+bounces-6628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D15A3E328
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5FE3A4DE7
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC4213E60;
	Thu, 20 Feb 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUJCV6zP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D11FECCD
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074025; cv=none; b=mpO9cBUPbg+huNwibwPGnZSf6DufAPKb8Ekveuuz3OLfIKLFXJ1KGWhhdC4SW4nw4Sc5Wi1gLOvEBtKKxT9UqAMTTE0VDw3AR3bbKRactw45SK6jSxTmqKZSNVDIsNY6l3xZyY710nTe7hnGN1WFkurEv+E9SGvXBypT8lo4I1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074025; c=relaxed/simple;
	bh=AQzG4ngPwGFgmMqcAIl58i80nycpF9Ggq7m2Pbn4KHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4G06dojHMbBa63qUBUZJotmSNY8Yqkk6CSrm1zHwBghwYa4TFFO6ZIRH6v48yZ36LxoaX4YsYpLwf0MhE3ZroT+c81wATxXBo3Z7NqRCp5K/S+17fgBuYeu+lkI2rDViJPXlDx8tl8VJ3oqgSJsfGo/lDOECFfykRiQt5ODfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUJCV6zP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 09:53:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740074021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLqDQnzQ92pb0Injt6R0LOoKa6jtIKj2J5l3jYyTfjA=;
	b=NUJCV6zP7Rzj4uKV1k+ylA+J0wanOUE58RiyHBAIxQ19zizh6WndIAIJi8SBeClHpnZidS
	H3pTjH3YMbFndpgQ4N1UsDouUjoxBpSuCZoXxG5LZ7bY4WPfJi0Kx4IdZRoiiBPm4flJvz
	7WSCw+jgox04PThjLjvDChELyl+b76Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dlrEI-dNPajxik@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
> 
> Another question is, does it make sense to keep BPF flushing in the
> "self" css with base stats flushing for now? IIUC BPF flushing is not
> very popular now anyway, and doing so will remove the need to support
> flushing and updating things that are not css's. Just food for thought.
> 

Oh if this simplifies the code, I would say go for it.

