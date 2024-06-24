Return-Path: <cgroups+bounces-3306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56BC9153EA
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370A31F2307F
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C819DF89;
	Mon, 24 Jun 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bb+Wql1u"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8D19D89D
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246820; cv=none; b=cPT08tHgT3+sbVPxRI5KZouXyZvKB01WWnUF/7gLdJ/IBgXnkEfybVkzSuFa+orZqGC8iRfaVf2yuRY9NOOaEdxnZH2BXVRELUANfXXkc+gWcZjq3N14IOAxSTyLq+vXmGU4eN7xuoMnGZftqXyq3JxbFLbRMJQm3KGiQ3c/4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246820; c=relaxed/simple;
	bh=4gqQAbOK79zS1uKAm/hj5eq4OIA6n71bJj1tEIJvkBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQo9IsEz31UtxsXl+/4ExvCfVVpRwUpBBAzpueAwxh/MwqjGbNHt8aXL8jEmTH+oHI9TNnQXFogAd1tG/h/U48p22kh5xWEhlpa6hRc3QqU5/UwqHBybI2l8Shv0pafdYQjhtwJmMUaVZ7tgDhpB5EHJuCpmnO+vwPjn5eJ46QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bb+Wql1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719246818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgN0dBgy6sR0oAWnnFjEXlGg9ErnyA+uGyeQrtdxBG8=;
	b=bb+Wql1uJarYltQOh74HayYoqmHzuyn1ofCBCvg4MdfYUPZ+K9m6WHNIAaMcNOql7e6PWa
	WikBkAYb2T2IEK0h3tp0IuvWm0uB2Jm7bnvsI2YPo3qVyqZYtIi8++VRPycoRW+HPQh07q
	YaxAktBB3AmhET91y1xENX5hdOApPOo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-hyTBx4oRNMyFE2NshUZ6sw-1; Mon,
 24 Jun 2024 12:33:34 -0400
X-MC-Unique: hyTBx4oRNMyFE2NshUZ6sw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA53F1955E82;
	Mon, 24 Jun 2024 16:33:31 +0000 (UTC)
Received: from [10.22.17.135] (unknown [10.22.17.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC0AB19560BF;
	Mon, 24 Jun 2024 16:33:28 +0000 (UTC)
Message-ID: <d97e2e8f-0abc-49a7-bead-0501c1226040@redhat.com>
Date: Mon, 24 Jun 2024 12:33:27 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Alex Kalenyuk <akalenyu@redhat.com>, Peter Hunt <pehunt@redhat.com>,
 linux-doc@vger.kernel.org
References: <20240623204514.1032662-1-longman@redhat.com>
 <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
 <ZnmO8izZPwYfiaRz@castle.lan>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZnmO8izZPwYfiaRz@castle.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 6/24/24 11:21, Roman Gushchin wrote:
> On Sun, Jun 23, 2024 at 04:52:00PM -0400, Waiman Long wrote:
>> Correct some email addresses.
>>
>> On 6/23/24 16:45, Waiman Long wrote:
>>> With memory cgroup v1, there is only a single "memory.limit_in_bytes"
>>> to be set to specify the maximum amount of memory that is allowed to
>>> be used. So a lot of memory cgroup using tools and applications allow
>>> users to specify a single memory limit. When they migrate to cgroup
>>> v2, they use the given memory limit to set memory.max and disregard
>>> memory.high for the time being.
>>>
>>> Without properly setting memory.high, these user space applications
>>> cannot make use of the memory cgroup v2 ability to further reduce the
>>> chance of OOM kills by throttling and early memory reclaim.
>>>
>>> This patch adds a new sysctl parameter "vm/memory_high_autoset_ratio"
>>> to enable setting "memory.high" automatically whenever "memory.max" is
>>> set as long as "memory.high" hasn't been explicitly set before. This
>>> will allow a system administrator or a middleware layer to greatly
>>> reduce the chance of memory cgroup OOM kills without worrying about
>>> how to properly set memory.high.
>>>
>>> The new sysctl parameter will allow a range of 0-100. The default value
>>> of 0 will disable memory.high auto setting. For any non-zero value "n",
>>> the actual ratio used will be "n/(n+1)". A user cannot set a fraction
>>> less than 1/2.
> Hi Waiman,
>
> I'm not sure that setting memory.high is always a good idea (it comes
> with a certain cost, e.g. can increase latency), but even if it is,
> why systemd or similar userspace tools can't do this?

We actually have a OOM problem with OpenShift which is based on 
Kubernetes. AFAIK, the setting of memory.high is still in alpha for 
Kubernetes. So a memory cgroup is set up just by setting memory.max at 
the moment.

I also trace back the OOM problem to commit 14aa8b2d5c2e ("mm/mglru: 
don't sync disk for each aging cycle") in the MGLRU code. So setting 
memory.high automatically is one way to avoid premature OOM. That is the 
motivation behind this patch.

>
> I wonder what's special about your case if you do see a lot of OOMs
> which can be avoided by setting memory.high? Do you have a bursty workload?

In our case, the OOM kill can be triggered by writing a large data file 
that exceeds memory.max to a NFS mounted filesystem as long as there is 
enough free pages that the dirty_bytes/dirty_background_bytes mechanism 
isn't triggered.

Regards,
Longman



