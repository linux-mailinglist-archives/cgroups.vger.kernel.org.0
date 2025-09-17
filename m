Return-Path: <cgroups+bounces-10221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD25B8225C
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7321C80375
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA92EC08E;
	Wed, 17 Sep 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oReXAf6E"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130FA55
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147717; cv=none; b=GXh8vtp7eveueDYhvyiRwBlh0WTNb8h090ksoByglsvOzT4QRC2GxvyFdQIVqB8yBDqUtjt98uHh673hfwT6Sv2LAk6Pdi58AGZB08bVX/HT6xcKglxQ9814hFTcbPmlEOD4JKGE1rMb06GFwwaPeSrMALaCp92VzMzwkLubJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147717; c=relaxed/simple;
	bh=d/I3F+SuENOGih+oN2UVEhi35uxE/59IR/7jTobGBAo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TV2/D4DeZkWS6NARYKyoOvwSWjyD3UVDePIyERgJZ8NunPVtFh84QjO31ER/zbnf7wAzpknRIlMlDqVRtolcCU8p7y5dEkZ7XafXXoXhbuF5cIWaYSaZ851NMkNKc7t5Uh42G6OHE5Ztn3YfCQOl9Sv7pnLhzFe+EHvOjIYHGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oReXAf6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C461C4CEE7;
	Wed, 17 Sep 2025 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758147717;
	bh=d/I3F+SuENOGih+oN2UVEhi35uxE/59IR/7jTobGBAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oReXAf6EmxNcQZWKaO7t+7pSa5yMM6yptNscf4mqfORdLrgSUCzidDzZDoR3ky8k5
	 N2PIHnKVw/AQONA3R4TF56W77cO4xyJFsi/i9DsQVMqM8YOwWvQs9ixvxNuey3WrSA
	 fwIuB3wx9d9gaza+5Ag52wG4vAP30CwSbBNYIt4s=
Date: Wed, 17 Sep 2025 15:21:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
 tj@kernel.org, muchun.song@linux.dev, venkat88@linux.ibm.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH v6] memcg: Don't wait writeback completion when release
 memcg.
Message-Id: <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
In-Reply-To: <20250917212959.355656-1-sunjunchao@bytedance.com>
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 05:29:59 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:

> Recently, we encountered the following hung task:
> 
> INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
> [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
>
> ...
> 
> The direct cause is that memcg spends a long time waiting for dirty page
> writeback of foreign memcgs during release.
> 
> The root causes are:
>     a. The wb may have multiple writeback tasks, containing millions
>        of dirty pages, as shown below:
> 
> >>> for work in list_for_each_entry("struct wb_writeback_work", \
> 				    wb.work_list.address_of_(), "list"):
> ...     print(work.nr_pages, work.reason, hex(work))
> ...
> 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
> 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
>
> ...
>

I don't think it's particularly harmful that a dedicated worker thread
has to wait for a long time in this fashion.  It doesn't have anything
else to do (does it?) and a blocked kernel thread is cheap.

> 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
> 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
> 
>     b. The writeback might severely throttled by wbt, with a speed
>        possibly less than 100kb/s, leading to a very long writeback time.
>
> ...
> 
>  include/linux/memcontrol.h | 14 +++++++++-
>  mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
>  2 files changed, 62 insertions(+), 9 deletions(-)

Seems we're adding a bunch of tricky code to fix a non-problem which
the hung-task detector undesirably reports.

Would a better fix be to simply suppress the warning?

I don't think we presently have a touch_hung_task_detector() (do we?)
but it's presumably pretty simple.  And maybe
touch_softlockup_watchdog) should be taught to call that
touch_hung_task_dectector().

Another approach might be to set some flag in the task_struct
instructing the hung task detector to ignore this thread.



