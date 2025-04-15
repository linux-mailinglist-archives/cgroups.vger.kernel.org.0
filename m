Return-Path: <cgroups+bounces-7545-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E1A890D7
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2159417D689
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 00:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CD8F58;
	Tue, 15 Apr 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umPjU/w9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABA23CB;
	Tue, 15 Apr 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677949; cv=none; b=YLaSNGt7jT6QQo8AAxKldXdfj0DCQ0IHjk376xvVxUhEfzbvRq5y7aJL6uulAKhe6n5cmZXnIu5YyIoF5nVPNF0b2eOuN59mJSP5eeIpj9TfSd1zvECoBUOgnGik+ygk2rVix9eKsOYv8D4TSdBNadtg9Cu89UqD0lASpe2zoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677949; c=relaxed/simple;
	bh=WKSZ9P4DIHoVsccjrV42uB5sUQZKjrJNYr1+QUfW9JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOohbyj5FUkwl7PBCROtx4cO6URnz7RZZExt4eAytZrPKOoZInobo/AChvpquqXuwDjtEiD78vvPG+6Sg4B2MmuAQvXjy4tVkAtfcpqA50o9F0Non5XA1MhEUBXqMIS9PLeKELpznqb2GNK66x6Omk030rXIRW1heSRvSKcwWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umPjU/w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ACEC4CEE2;
	Tue, 15 Apr 2025 00:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677948;
	bh=WKSZ9P4DIHoVsccjrV42uB5sUQZKjrJNYr1+QUfW9JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umPjU/w9Rvom1YvLze6XEeUX4etDIO0Icz+q3/HNKovi7UmoXQ3JeAok2TpPTKypS
	 SAxP9Rkt5FEQ0o90Qv8SR0Jh7QvR9D8gjkwZqXlQ8ffGX+7Ouv609HMl04G5O9TXyI
	 WqMT3NKf2e/8DR/5GH+WJlMZ23cJHW1QPLJIR9G/YRFlbZ3Mz84DaGMXe4GG0rQA5w
	 pamcouc5TzFrzn2b6/6dYMRyRQ4QtNHwbdeswnReCTNeq/7YipNerchtoVIy8R9O9N
	 51T0bh26DEMeryrtTK+0HJ0NVZjOyyPCD71+tQSmBgoGv1CreYnoJFW9QGGTyUcbC5
	 NOzFq1540Rc4w==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>,
	Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Date: Mon, 14 Apr 2025 17:45:46 -0700
Message-Id: <20250415004546.121566-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gregory,


Thank you for continuing and sharing this nice work.  Adding some comments
based on my humble and DAMON-biased perspective below.

On Fri, 11 Apr 2025 18:11:05 -0400 Gregory Price <gourry@gourry.net> wrote:

> Unmapped page cache pages can be demoted to low-tier memory, but
> they can presently only be promoted in two conditions:
>     1) The page is fully swapped out and re-faulted
>     2) The page becomes mapped (and exposed to NUMA hint faults)

Yet another way is running DAMOS with DAMOS_MIGRATE_HOT action and unmapped
pages DAMOS filter.  Or, without unmapped pages DAMOS filter, if you want to
promote both mapped and unmapped pages.

It is easy to tell, but I anticiapte it will show many limitations on your use
case.  I anyway only very recently shared[1] my version of experimental
prototype and its evaluation results.  I also understand this patch series is
the simple and well working solution for your use case, and I have no special
blocker for this work.  Nevertheless, I was just thinking it would be nice if
your anticipated or expected limitations and opportunities of other approaches
including DAMON-based one can be put here together.

[...]
> 
> Development History and Notes
> =======================================
> During development, we explored the following proposals:

This is very informative and helpful for getting the context.  Thank you for
sharing.

[...]
> 4) Adding a separate kthread - suggested by many

DAMON-based approach might also be categorized here since DAMON does access
monitoring and monitoring results-based system operations (migration in this
context) in a separate thread.

> 
>    This is - to an extent - a more general version of the LRU proposal.
>    We still have to track the folios - which likely requires the
>    addition of a page flag.

In case of DAMON-based approach, this is not technically true, since it uses
its own abstraction called DAMON region.  Of course, DAMON region abstraction
is not a panacea.  There were concerns around the accuracy of the region
abstraction.  We found unoptimum DAMON intervals tuning could be one of the
source of the poor accuracy and recently made an automation[2] of the tuning.

I remeber you previously mentioned it might make sense to utilize DAMON as a
way to save such additional information.  It has been one of the motivations
for my recent suggestion of a new DAMON API[3], namely damon_report_access().
It will allow any kernel code reports their access finding to DAMON with
controlled overhead.  The aimed usage is to make page faults handler,
folio_mark_accessed(), and AMD IBS sample handers like code path passes the
information to DAMON via the API function.

>    Additionally, this method would actually
>    contend pretty heavily with LRU behavior - i.e. we'd want to
>    throttle addition to the promotion candidate list in some scenarios.

DAMON-based approach could use DAMOS quota feature for this kind of purpose.

> 
> 
> 5) Doing it in task work
> 
>    This seemed to be the most realistic after considering the above.
> 
>    We observe the following:
>     - FMA is an ideal hook for this and isolation is safe here

My one concern is that users can ask DAMON to call folio_mark_accessed() for
non unmapped page cache folios, via DAMOS_LRU_PRIO.  Promoting the folio could
be understood as a sort of LRU-prioritizing, so I'm not really concerned about
DAMON's behavioral change that this patch series could introduce.  Rather than
that, I'm concerned if vmstat change of this patch series could be confused by
such DAMON users.

>     - the new promotion_candidate function is an ideal hook for new
>       filter logic (throttling, fairness, etc).

Agreed.  DAMON's target filtering and aim-based aggressiveness self-tuning
features could be such logic.  I suggested[3] damos_add_folio() as a potential
future DAMON API for such use cases.

With this patch series, nevertheless, only folio_mark_accessed() called folios
could get such opportunity.  Do you have future plans to integrate faults-based
promotion logic with this function, and extend for other access information
source?

[1] https://lore.kernel.org/20250320053937.57734-1-sj@kernel.org
[2] https://lkml.kernel.org/r/20250303221726.484227-1-sj@kernel.org
[3] https://lwn.net/Articles/1016525/


Thanks,
SJ

[...]

