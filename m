Return-Path: <cgroups+bounces-7110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABAA6643B
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A251897CF7
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46A35950;
	Tue, 18 Mar 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESTHhjxm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65622EE5
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259066; cv=none; b=u6DBhAH8vfwIsnotleJcoySkh4w5ccdQiqnotdQLsOErB1KHgzuJyNhn2PG27nTScP6s+0QG1C7OVkJfis1ngsG3Ncbs/kF1rba/NPmko1iGb89o9fZ/FOi6p8iNwgduHcaKspuAfiZZdtzKZe5W5U25EfaoE/zR27TfrM5QquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259066; c=relaxed/simple;
	bh=RwhuAq/c7qHy/rH0mzwICs/ltPd/pHx3+H40hrm603A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU/CfiWbklA42XHMX3ZEL/ziVdrDkZvqYTozxesEb0Iyp/R5uQzdUPPEIcr4vukFowOKy6cjKFiSRF7fzYLOnSL7PuraSE4/moQAsYV7g+utqnvOe7+QvFKjRMBAHzkM1oLu92kFeEALBy8cyUslM1njox7QMIGoD6nSkLu+PXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESTHhjxm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 00:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742259061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+S9ijBBuQefZIvauH3YzP1rEzc6s9swtHO60s8uN8=;
	b=ESTHhjxmk4yJHum91VRyK6GyODQ+fB6QDAnqhgJG/4vJo70QJVReC4QgZ/upcDODSQiaI/
	KDPdd8arnvTPORC8rxzA7nbozCIuGSlpV67/rMNroCPfe61Q4ZTK7Ne4T6lH+ZyYkZphXf
	fGW0wpmZ7VaEhwB2lIyFgVczytLeQTU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 3/9] memcg: introduce memcg_uncharge
Message-ID: <Z9jDcNVVncb_XWDF@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:24AM -0700, Shakeel Butt wrote:
> At multiple places in memcontrol.c, the memory and memsw page counters
> are being uncharged. This is error-prone. Let's move the functionality
> to a newly introduced memcg_uncharge and call it from all those places.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

This is a nice one!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

