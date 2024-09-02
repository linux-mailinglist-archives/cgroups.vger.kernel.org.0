Return-Path: <cgroups+bounces-4666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C7A967DB5
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F3C1F222F9
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1037703;
	Mon,  2 Sep 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iHXcd6l2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88925374C4
	for <cgroups@vger.kernel.org>; Mon,  2 Sep 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243174; cv=none; b=AGOsdEMpOg8lvc8NMtTRbohLQSimbVaUbyaaqldY9CCnrEXQLb9a3Rx6qD5pLt5tIbL1fc46q3S1EJs2nZ0L5LhGbDQPB9Qy5ZDOJDI3bG1DCh0oyHVIgegSDPrsAPqQ+sflaxX36yyXvST/+LUiNpmLzyxn25/xU/FaYI/ODNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243174; c=relaxed/simple;
	bh=TGkTZJhTwl5mY2becvoVQ6aOd92XQ3M+sfi0H2VFSX8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JA+CyMS8QAFp4xFVqcQslg/EHBa5pIBtBIZ0yJitqSQqneo+IXJ0gFab1sklV+QKbDLhmeM+Tqyka8QUgO2wNnDmn+fwp8ezoss1pbw7w8uh5TcF3UE/IYIxOGypJUbybTOHeqPhqhiH8MdFXAYlr550GsQCD4mVpS0D5+XImiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iHXcd6l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D4C4CEC3;
	Mon,  2 Sep 2024 02:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725243174;
	bh=TGkTZJhTwl5mY2becvoVQ6aOd92XQ3M+sfi0H2VFSX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iHXcd6l2JAT0E6e187ejYsjH9c55zsCkSzkkBdqnmSHpmkHG3qSbkq45mH99N9BF2
	 AIgneUjjvDFEphAHQnT/3yNh6DezE1rqnIKTS1pKl41yT6N9bpCQlBG2qeUKFTLNoA
	 5BftfcNFHqeQlnfj+azClHiKKeYMZcTHd6DDbbaY=
Date: Sun, 1 Sep 2024 19:12:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, mhocko@kernel.org,
 nehagholkar@meta.com, abhishekd@meta.com, hannes@cmpxchg.org,
 weixugc@google.com, rientjes@google.com
Subject: Re: [PATCH v4] mm,memcg: provide per-cgroup counters for NUMA
 balancing operations
Message-Id: <20240901191253.404e7a1824fe7ef1933882e3@linux-foundation.org>
In-Reply-To: <20240814235122.252309-1-kaiyang2@cs.cmu.edu>
References: <20240814235122.252309-1-kaiyang2@cs.cmu.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 23:51:22 +0000 kaiyang2@cs.cmu.edu wrote:

> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> 
> The ability to observe the demotion and promotion decisions made by the
> kernel on a per-cgroup basis is important for monitoring and tuning
> containerized workloads on machines equipped with tiered memory.
> 
> Different containers in the system may experience drastically different
> memory tiering actions that cannot be distinguished from the global
> counters alone.
> 
> For example, a container running a workload that has a much hotter
> memory accesses will likely see more promotions and fewer demotions,
> potentially depriving a colocated container of top tier memory to such
> an extent that its performance degrades unacceptably.
> 
> For another example, some containers may exhibit longer periods between
> data reuse, causing much more numa_hint_faults than numa_pages_migrated.
> In this case, tuning hot_threshold_ms may be appropriate, but the signal
> can easily be lost if only global counters are available.
> 
> In the long term, we hope to introduce per-cgroup control of promotion
> and demotion actions to implement memory placement policies in tiering.
> 
> This patch set adds seven counters to memory.stat in a cgroup:
> numa_pages_migrated, numa_pte_updates, numa_hint_faults, pgdemote_kswapd,
> pgdemote_khugepaged, pgdemote_direct and pgpromote_success. pgdemote_*
> and pgpromote_success are also available in memory.numa_stat.
> 
> count_memcg_events_mm() is added to count multiple event occurrences at
> once, and get_mem_cgroup_from_folio() is added because we need to get a
> reference to the memcg of a folio before it's migrated to track
> numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
> shrink_inactive_list() before being changed to per-cgroup.

There appears to have been little reviewer interest in this one?

