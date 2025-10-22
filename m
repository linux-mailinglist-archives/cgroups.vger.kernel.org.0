Return-Path: <cgroups+bounces-11053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B714DBFDC6D
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 20:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58FA4E8D0E
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D02EA732;
	Wed, 22 Oct 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ewT9VmjD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B812EAB9F
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156632; cv=none; b=BfASvd2R06MdIU0XhjWgmTlXYdqVC49y8YlQB2aoQ+snPshMUNRgaVY0MIltLcMb6VwDFG3YymqecYgaq6JL8Cs8kGxDwmuE2XA/TswUAmXQVrPBvxbXXb0ig/CPUyJZDy/RVSNxubMOAMcHC+vRgWeD86UAJNuL7cAL4WMM2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156632; c=relaxed/simple;
	bh=EY76L4CGdRUn2iTq3A8LXWqtQ45P62GbtJbmIsCh5cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=di1ixeVWZQXz4iNAS1aPd5L6EASeKW9UnffChUz5MsFi3uyYBOtz77UcLLJno60B5GC1vAi6uiNjAtpOSg/b7Xf9tgx81xV1KUoqAtku/VtHVi/TeTXn5Zrilt23G5t3u24+uzfvAgnLerupqiZQO4aVkQ/FFNKsFUl+pwOrn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ewT9VmjD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761156628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oguebMI32HO2qu+qTFZ3a4OfXPITAp8SRQtXmR8DU0=;
	b=ewT9VmjD7fTQPe1Npsb/bC39b2Tzxw6BCjJHe1M8WUB/Q2xBU9/d7L11V6Vb5wHFwQkqr8
	oSNvVeGhpWgBJ7R7fiHC0RpiHou+2eQte79hbL/RqkaC5+9NPXswBassBgdxbSf1mH/NRJ
	b772Rg8EO0Wab8lYZl/nE8lHfRnMQoI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
In-Reply-To: <3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
	(Shakeel Butt's message of "Tue, 21 Oct 2025 18:28:02 -0700")
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
	<20251022005801.120250-1-sj@kernel.org>
	<3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
Date: Wed, 22 Oct 2025 11:10:22 -0700
Message-ID: <87v7k67qpd.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Tue, Oct 21, 2025 at 05:58:00PM -0700, SeongJae Park wrote:
>> On Tue, 21 Oct 2025 16:44:25 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> 
>> > The function __memcg_memory_event has been unnecessarily marked inline
>> > even when it is not really performance critical. It is usually called
>> > to track extreme conditions. Over the time, it has evolved to include
>> > more functionality and inlining it is causing more harm.
>> > 
>> > Before the patch:
>> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>> >    text    data     bss     dec     hex filename
>> >   35645   10574    4192   50411    c4eb mm/memcontrol.o
>> >   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
>> >   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
>> > 
>> > After the patch:
>> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>> >    text    data     bss     dec     hex filename
>> >   35137   10446    4192   49775    c26f mm/memcontrol.o
>> >   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
>> >   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
>> > 
>> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

