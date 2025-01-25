Return-Path: <cgroups+bounces-6313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEBA1C036
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBAA7A068C
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31721E9B08;
	Sat, 25 Jan 2025 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mC0WT3ei"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B81DE4EA
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768431; cv=none; b=jhVlvEPf15LO2KrElS/6NVdgx9kip2ut8tn4GTdd6xkWwAPqDb9ncMPrtw0WsGJUClDQotR0HwBZHO/VapGmEjGDqclXX4V/bZ+Tb2aUECLbdarucZZQvlZ5DcmkLM15tqMEJ9hgMlxCSozPwbsZXl7VfBy6tOwF5fE0a3VoSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768431; c=relaxed/simple;
	bh=DI9dSDfEP458+RdKlohDY69EJsG2PjOCk2h0wAwY0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2C0UmtPEfAaCD4tz5HSWzlhvi2P3aeCE03u4jM2iASeUX4agietWG5MJwo55kof9pzxLSlzM1fKMEX0pq/bhTXCnKx3G2C1ULNDlF+BaPLrqWBFlYW0ZgD8bZKRWtmDDXW3iIIhd/bGcYcfFb4nSKVsIUxM0hKQRL1ND5lkyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mC0WT3ei; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:26:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aLRD+6kIFwpJ4z+BGBom22edY43u8KKJK3E6CuwG+Y=;
	b=mC0WT3ei47Pjm7+qV9j03rHKrk8xc73amxVEwkRCd7C0fow5vOUPjDHXm0U+s8kSmdSSb0
	HovLr6bR+AO/+pyD/eyFqiQBeukGEV6iaX0H0m0og5ZmT7q0I49idD0m/nCGVWz+L6pnCs
	WpHMPMQpNWodWuIEQMLedEO8h+w1XzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: move stray ratelimit bits to v1
Message-ID: <Z5Q92eYEAFwNcef6@google.com>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
 <20250124043859.18808-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-2-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 11:38:59PM -0500, Johannes Weiner wrote:
> 41213dd0f816 ("memcg: move mem_cgroup_event_ratelimit to v1 code")
> left this one behind. There are no v2 references.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

