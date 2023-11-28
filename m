Return-Path: <cgroups+bounces-610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F317FC34D
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C3DB21131
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7B3526F;
	Tue, 28 Nov 2023 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfxMuX5Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4F19AD
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701196379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLioCArnr0IJqhFqguaq4z/iJ7qIOy5O8bw1FPJnvLM=;
	b=bfxMuX5YEGidN6IDBqRXcfU14n+q4Iby4STsXoRlqR/nSeEd27AhSOJWbF4NZKvqdgO2Jd
	f00JbJQK9GOmcNeI3NXPI/+xvDmlKKuK/cgaU4CvF4vUWzIqp0aggZXw2xORy33OR6hT2a
	/K8nJPpgHcEZ/H9gxG8pI5fVgfCcot4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Tle2EXXqM5CbNcW1fP27HA-1; Tue,
 28 Nov 2023 13:32:54 -0500
X-MC-Unique: Tle2EXXqM5CbNcW1fP27HA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3067F1C05135;
	Tue, 28 Nov 2023 18:32:54 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48FDE40C6EB9;
	Tue, 28 Nov 2023 18:32:53 +0000 (UTC)
Message-ID: <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
Date: Tue, 28 Nov 2023 13:32:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
 Ryan Phillips <rphillips@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Peter Hunt <pehunt@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYbqNnnt6gQOssK@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 11/28/23 11:56, Tejun Heo wrote:
> Hello,
>
> On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
>> +bool cpuset_cpu_is_isolated(int cpu)
>> +{
>> +	unsigned int seq;
>> +	bool ret;
>> +
>> +	do {
>> +		seq = read_seqcount_begin(&isolcpus_seq);
>> +		ret = cpumask_test_cpu(cpu, isolated_cpus);
>> +	} while (read_seqcount_retry(&isolcpus_seq, seq));
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
> We're testing a bit in a bitmask. I don't think we need to worry about value
> integrity from RMW updates being broken up. ie. We can just test the bit
> without seqlock and drop the first patch?

My concern is that if we have an isolated partition with a set of 
isolated CPUs (say 2-4), I don't want any addition, deletion of changes 
made to another isolated partition affects the test of the pre-existing 
one. Testing result of the partition being change is fair game.

Depending on how the cpumask operators are implemented, we may not have 
a guarantee that testing CPU 2, for instance, will always return true. 
That is why I am adding some synchronization primitive to prevent 
racing. My original plan was to take the callback_lock. However, that 
can be somewhat costly if this API is used rather frequently, especially 
on systems with large # of CPUs. So I change it to use seqcount for read 
protection which has a much lower cost.

Regarding patch 1 on converting callback_lock to raw_spinlock_t, I can 
drop it if you have concern about that change. I just need to surround 
the write_seqcount_begin()/write_seqcount_end() calls with 
preempt_disabled()/preempt_enabled().

Cheers,
Longman


