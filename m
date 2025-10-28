Return-Path: <cgroups+bounces-11295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA9C1666D
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E654F93C1
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD934D4F9;
	Tue, 28 Oct 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ub1SN/SJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB57199FAC
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674985; cv=none; b=L9uRMdoeRKh+VDI0OQIEdwizBl89a0QwgRlK5K6UIR1Reh2IBssXAvJvHtEaLkAOchjVZf1McONkwb+jxiWjTv8tROall0CqCYfBAaKLxkbapIcu3IVo5lxEHXnK3kYsCSv/etdyqEyTJOvYlfcw8JJVvrPQ5ZGqhpK6Qr2wSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674985; c=relaxed/simple;
	bh=qyPjfme0bAHk4BknKS0WkCzKt/nVeGKGxuV+yXg15z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvBRY+VgZwkfrKBxwIpX5tRPVqaBhNOxIA1ASzQdZOHOt2NrFeTof5wrTKHA4mi51n4L+ZmzJaSvypLk5ySET0C9cg3gD3r920jJ96fInosVC1x7Dl0neH4OBA1yDGV1q2zdihqcnukpHxvw7Q90mCFnc51BKh6jbpwt9QJ/Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ub1SN/SJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761674980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XpykUOb069QPLVeJZBbZFKflqnV60wvcTzlUbFCN+mA=;
	b=Ub1SN/SJ7bZTNkNA7Mkvwc3LqkUUsEhfF8JeXFibIJIaiIBhX9asAWfHtE1uuPJ2oPqr7Q
	Yu7c/Wy6sipgogjiJN5d6YT4oOnNFHX8T90X3ykir9AQyVjr/adaQh270IdhWWXzIgVaS1
	OhTFaT2XmNcW8sMgw2wYNnQNfgVGO+g=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 15/23] mm: introduce bpf_task_is_oom_victim() kfunc
In-Reply-To: <aQD-RvxrX8_7QtxT@slm.duckdns.org> (Tejun Heo's message of "Tue,
	28 Oct 2025 07:32:54 -1000")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-5-roman.gushchin@linux.dev>
	<aQD-RvxrX8_7QtxT@slm.duckdns.org>
Date: Tue, 28 Oct 2025 11:09:28 -0700
Message-ID: <877bwevqxz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> On Mon, Oct 27, 2025 at 04:21:58PM -0700, Roman Gushchin wrote:
>> Export tsk_is_oom_victim() helper as a BPF kfunc.
>> It's very useful to avoid redundant oom kills.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/oom_kill.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 72a346261c79..90bb86dee3cf 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -1397,11 +1397,25 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>>  	return ret;
>>  }
>>  
>> +/**
>> + * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
>> + * @task: task to check
>> + *
>> + * Returns true if the task has been previously selected by the OOM killer
>> + * to be killed. It's expected that the task will be destroyed soon and some
>> + * memory will be freed, so maybe no additional actions required.
>> + */
>> +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
>> +{
>> +	return tsk_is_oom_victim(task);
>> +}
>
> In general, I'm not sure it's a good idea to add kfuncs for things which are
> trivially accessible. Why can't things like this be provided as BPF
> helpers?

I agree that this one might be too trivial, but I added it based on the
request from Michal Hocko. But with other helpers (e.g. for accessing
memcg stats) the idea is to provide a relatively stable interface for
bpf programs, which is not dependent on the implementation details. This
will simplify the maintenance of bpf programs across multiple kernel
versions.

Thanks!

