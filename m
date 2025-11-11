Return-Path: <cgroups+bounces-11819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C651C4F1A9
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C107834C8A1
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1B3730C9;
	Tue, 11 Nov 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F9eTogNq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05C36998F
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879572; cv=none; b=K6AFdQQDsHh46tzkWMiiV3E8nw+3sn+n6heGj0t9R1RyyrFMuXuO9UBqXk2p/e5AOx5/M5Y87pi29G/Au5vIDoqDx1uOcmOS45Fh5SfTQFXeX5bZMjilhxDUdtG+LwrvHiFYjiYl9C7elZTZdFKqLjDTP5geDHciY3hNPcSitDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879572; c=relaxed/simple;
	bh=6asq6D0YWk1clzZ0WCtlMvMA5lEjdT6pWxHqsmk527s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwTUPxIg77tX6qytOrq8FKv0Bw9B8mIPVUD5NDgkYXCF4+B3UsOBhLXKkfVay0RGKAOjL4rAchKUWcQQfGXg1PlQ9S7+/qfYpxRZ7fBa2JM5huLdEjtiVNdy431w+f+tc4DGDRk3ZAPJRjpp0E2hREj8SySncvMBTo6q+UkGqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F9eTogNq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Nov 2025 08:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762879554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwOueIDR7iQLq0yktgbr0XMz1VzOnqj2R/QpQ9bY1ZU=;
	b=F9eTogNqMIrPlvSuExmQ7EbcOmA1oJ69tHiAS8UUnOhVS46t4pAhkZk06/DWTS/NIUIpNb
	+/DQ/LxknjCDPtzBy6dEgLfsIALH8ubWqhQMCDNWkTDOMj881YgTFWO1j7vJ0gKl+Up/1a
	D1/ypSEWvsjRVuIdcvJ94kIBOg8oezU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <xjwmyqdjynpeuqtgxiz3igynjl4ywopdc33lteidgmp5yez2ed@pbdfsekytezn>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 04:36:14PM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 11/11/25 7:20 AM, Shakeel Butt wrote:
> > The memcg stats are safe against irq (and nmi) context and thus does not
> > require disabling irqs. However for some stats which are also maintained
> > at node level, it is using irq unsafe interface and thus requiring the
> > users to still disables irqs or use interfaces which explicitly disables
> > irqs. Let's move memcg code to use irq safe node level stats function
> > which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> > (all major ones), so there will not be any performance penalty for its
> > usage.
> 
> Generally, places that call __mod_lruvec_state() also call
> __mod_zone_page_state(), and it also has the corresponding optimized
> version (mod_zone_page_state()). It seems necessary to clean that up
> as well, so that those disabling-IRQs that are only used for updating
> vmstat can be removed.

I agree, please take a stab at that.

