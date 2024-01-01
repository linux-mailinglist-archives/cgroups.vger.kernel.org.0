Return-Path: <cgroups+bounces-1050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E33821473
	for <lists+cgroups@lfdr.de>; Mon,  1 Jan 2024 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CFB281ECB
	for <lists+cgroups@lfdr.de>; Mon,  1 Jan 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD329464;
	Mon,  1 Jan 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrCyt+Ka"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727488F6A
	for <cgroups@vger.kernel.org>; Mon,  1 Jan 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704126422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHJuaOOoMITcmaF/jJKQveH0rmkD/J9cEtpvvbiUPHE=;
	b=WrCyt+KaLMhLINXSSsr9+Fo6jtUe0HuJ/E0siYguvUL+mEgdGBEk24Xb8lyWFNxr9YVgMu
	AGy15SxMfyYXHgLvqbg0IaAbeLyTJvc7bEZn8TmM2Rd7TusyRpiTV8ER5Uvo5NZOnTCJAh
	3FxYbYSvkBjBcDWL9yHsshTzxG9gk6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-EbaG0ZwFMgeB8Eg_Jyl7kA-1; Mon, 01 Jan 2024 11:26:59 -0500
X-MC-Unique: EbaG0ZwFMgeB8Eg_Jyl7kA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9E8B83FC22;
	Mon,  1 Jan 2024 16:26:58 +0000 (UTC)
Received: from [10.22.32.137] (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11B96492BF0;
	Mon,  1 Jan 2024 16:26:58 +0000 (UTC)
Message-ID: <86fa9afa-21c0-42fb-926d-5ffc69695d30@redhat.com>
Date: Mon, 1 Jan 2024 11:26:57 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Adjust exception handling in
 generate_sched_domains()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, cgroups@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
 <9cd1ce1d-15c7-427c-9929-f3c75b97b49c@redhat.com>
 <b441f304-a3cc-4ebe-91cb-84caf55cbfe2@web.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <b441f304-a3cc-4ebe-91cb-84caf55cbfe2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 1/1/24 03:56, Markus Elfring wrote:
>>> Two resource allocation failures triggered further actions
>>> over the label “done” so far.
>>>
>>> * Jump to the statement “ndoms = 1;” in three cases directly
>>>     by using the label “set_ndoms” instead.
>>>
>>> * Delete an assignment for the variable “ndoms” in one if branch.
> …
>>> ---
>>>    kernel/cgroup/cpuset.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> …
>>> @@ -973,10 +973,9 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>
>>>        /* Special case for the 99% of systems with one, full, sched domain */
>>>        if (root_load_balance && !top_cpuset.nr_subparts) {
>>> -        ndoms = 1;
>>>            doms = alloc_sched_domains(ndoms);
>>>            if (!doms)
>>> -            goto done;
>>> +            goto set_ndoms;
>>>
>>>            dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>>>            if (dattr) {
> …
>>> @@ -1123,6 +1122,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>         * See comments in partition_sched_domains().
>>>         */
>>>        if (doms == NULL)
>>> +set_ndoms:
>>>            ndoms = 1;
>>>
>>>        *domains    = doms;
> …
>> Please clarify what this patch is for. Is it just a cleanup with no functional changes or is there a bug that is being fixed?
> The development opinions might vary for the presented transformation.
> I suggest to reconsider the number of relevant variable assignments here.
> Would you categorise an extra statement still as a desirable implementation detail?

My understanding of the patch is just to avoid an unnecessary call to 
kfree() as kfree(NULL) is basically a NOP. By jumping inside the "if" 
part of the conditional statement, however, it makes it a bit harder to 
read. As generate_sched_domains() is not in the fast path, I would 
rather have a patch that can simplify the logic than to make it harder 
to understand.

Cheers,
Longman


