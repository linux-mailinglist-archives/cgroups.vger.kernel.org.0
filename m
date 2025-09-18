Return-Path: <cgroups+bounces-10224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C181B82AC3
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 04:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7571C05B93
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC5225416;
	Thu, 18 Sep 2025 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VJFqxKmm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D118176ADE
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163431; cv=none; b=KmDsudC37ALbGUASxdwTKuKhC4fxK9YDHPl3e0u1kKMVztQSGcr0Ns45C1NntIYcDlT5EVW5P0pP4jMvZllX8OzhBg1icgufGIHj9ewUJafmLDJsWiRuKvwjmp7zS8GUgETjwnUxmzXQJKOUcGfOK46GupY8szd7hB9qdiWPeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163431; c=relaxed/simple;
	bh=EMa6CEGCXpCvdW6Jta4rJnO5jnALQMnZhsy/k4AU6f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aW/b4/IAnL/bZJxruh6yVJGzHSkYfay9Tgz3r0luDs7Og1bUJbycf0oH29aHgUb60UHUixJBI7XB1gOPcpOfpA+vLeGNdUL1cTuVBhGJoqYX5GEwOpvZVpTW+qImBV+pjLAwjWIeLxOODE4AVkOiDw4Rg8EU2Te6pnrRUCEhnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VJFqxKmm; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71d3ec0b-1b91-49f7-b973-6ec8882dd02d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758163426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI0IJw0Wjez1WxyWFmZyWVXd+7wN4CQqoOTQh/J70mY=;
	b=VJFqxKmmVe5s2Sd6wvuQStIArfzjFaX0aJ9uz2TPSqjmPYK85oIrR5TYnsew7H/TWnWJFz
	hk2rvyO9jXKgEahh9gc8MnooUUUHIY/HVVPpVPvreJDvCy4n6vZ2U4scbHimXkZIXVW1BN
	fLIuQIgqE6ZEdvKOFWvFPWeXcK72Wns=
Date: Thu, 18 Sep 2025 10:43:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6] memcg: Don't wait writeback completion when release
 memcg.
Content-Language: en-US
To: Julian Sun <sunjunchao@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, tj@kernel.org,
 muchun.song@linux.dev, venkat88@linux.ibm.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
 <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hey Julian,

On 2025/9/18 06:21, Andrew Morton wrote:
> On Thu, 18 Sep 2025 05:29:59 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> 
>> Recently, we encountered the following hung task:
>>
>> INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
>> [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
>>
>> ...
>>
>> The direct cause is that memcg spends a long time waiting for dirty page
>> writeback of foreign memcgs during release.
>>
>> The root causes are:
>>      a. The wb may have multiple writeback tasks, containing millions
>>         of dirty pages, as shown below:
>>
>>>>> for work in list_for_each_entry("struct wb_writeback_work", \
>> 				    wb.work_list.address_of_(), "list"):
>> ...     print(work.nr_pages, work.reason, hex(work))
>> ...
>> 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
>> 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
>>
>> ...
>>
> 
> I don't think it's particularly harmful that a dedicated worker thread
> has to wait for a long time in this fashion.  It doesn't have anything
> else to do (does it?) and a blocked kernel thread is cheap.

Looking at wb_wait_for_completion(), one could introduce a new helper that
internally uses wait_event_timeout() in a loop. Something like:

void wb_wait_for_completion_with_timeout(struct wb_completion *done)
{
	atomic_dec(&done->cnt);
	while (atomic_read(&done->cnt))
         	wait_event_timeout(*done->waitq, !atomic_read(&done->cnt), 
timeout);
}

With this, the detector should no longer complain for that specific case :)

> 
>> 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
>> 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
>>
>>      b. The writeback might severely throttled by wbt, with a speed
>>         possibly less than 100kb/s, leading to a very long writeback time.
>>
>> ...
>>
>>   include/linux/memcontrol.h | 14 +++++++++-
>>   mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
>>   2 files changed, 62 insertions(+), 9 deletions(-)
> 
> Seems we're adding a bunch of tricky code to fix a non-problem which
> the hung-task detector undesirably reports.
> 
> Would a better fix be to simply suppress the warning?
> 
> I don't think we presently have a touch_hung_task_detector() (do we?)
> but it's presumably pretty simple.  And maybe
> touch_softlockup_watchdog) should be taught to call that
> touch_hung_task_dectector().

Yes, introducing a touch_hung_task_detector() and having other tasks
periodically call it for the blocked worker seems like a much cleaner
approach to suppress the warning, IMHO.

> 
> Another approach might be to set some flag in the task_struct
> instructing the hung task detector to ignore this thread.

Alternatively, the idea of setting a flag for the worker to explicitly
ignore certain tasks by the detector is also interesting, especially if the
worker's blocked state is expected and benign ;)

Well, happy to help explore either of these paths if you'd like to go 
further
with them ;P

Cheers,
Lance


