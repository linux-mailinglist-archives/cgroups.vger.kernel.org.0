Return-Path: <cgroups+bounces-3630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E092EDF7
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70ADB2170B
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843816DEA8;
	Thu, 11 Jul 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB+deM4k"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CF16DC27
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719596; cv=none; b=HAEvh5d1Op8F3BjW4W4hi5LadIWpBGkk1R6Fmw7p175MJa4PIFziCwputvxs8hKwJMkbqyNrfIfSHPM2uf3SofyWUDr4r8ktP4iK2E/xYG0aU/rorCcVHV29VwpTD1KqE71CmeKZlCV8IlLx3ZMwAjBRO0D7dwDOV5ydfZrMqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719596; c=relaxed/simple;
	bh=GGNdZmFRFBz6EaOq4XOW+ceRx/DPUWKVqohHaWzsrxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USaGIkJ9zRvT/sHXn3TKdhF/Gs4mJprmyK3nJJwBRXjinH0NLNP8dFAGzXuhnaOUQd+pJqmUN9UEmj4XtPMHb3+t/K7dF9iO2V0ztocAi8gSJ9EaQyrBkbIl48Aj8otyloazEx5lcZfWbTO9Z25AmMG9nHIqrWHX4mYqH2m7uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB+deM4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720719594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9jBDSWTVfESQnrltmAdAwRr7rLlVt6HaSz0exzsPXg=;
	b=JB+deM4ksHNGjgE50jUIIHUv1yENuAP0BgAu19+0/x/KgqHe0FWvGjEbTaXpI8LruET7Ag
	lYa/5zQl1UfuGedC90hlbx532pF+Zijo7EnXQ3jkdVHOYXOK1Xhjyf6TmWbANe0bvPl6MO
	nky2wWBxOD1p6+y9lVC2PPwh0l1+8hc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-E3hYc5UjPuKko9-vw5Gu-A-1; Thu,
 11 Jul 2024 13:39:44 -0400
X-MC-Unique: E3hYc5UjPuKko9-vw5Gu-A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90EF319560B1;
	Thu, 11 Jul 2024 17:39:41 +0000 (UTC)
Received: from [10.22.64.119] (unknown [10.22.64.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75F0D19560AE;
	Thu, 11 Jul 2024 17:39:39 +0000 (UTC)
Message-ID: <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
Date: Thu, 11 Jul 2024 13:39:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 7/11/24 13:18, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 11, 2024 at 10:05:22AM -0400, Waiman Long wrote:
>> Given the fact that for_each_css() iteration is filtering out csses that are
>> absent, the dying counts follow the same logic of skipping it if there is no
>> dying css. That also makes it easier to identify cgroups with dying
>> descendant csses as we don't need filter out entries with a 0 dying count.
>> It also makes the output less verbose and let user focus more on what are
>> significant.
>>
>> I do understand that it makes it inconsistent with the ways nr_descendants
>> and nr_dying_descendants are being handled as entries with 0 count are also
>> displayed. I can update the patch to display those entries with 0 dying
>> subsys count if other people also think that is the better way forward.
> I think it'd be better to have all the keys. There are some dynamic keys in
> stat files but those are mostly for things which can come and go (e.g. block
> and misc devices), so yeah, I think it'd be better to show all the keys even
> when they're zero.
Currently, I use the for_each_css() macro for iteration. If you mean 
displaying all the possible cgroup subsystems even if they are not 
enabled for the current cgroup, I will have to manually do the iteration.
>
> Also, I personally would much prefer if the same prefixes are collected
> together - ie. totals first and then dying. It's just a lot easier on the
> eyes that way.
>
> 	nr_subsys_cpu
> 	nr_subsys_memory
> 	nr_subsys_io
> 	...
> 	nr_dying_subsys_cpu
> 	nr_dying_subsys_memory
> 	nr_dying_subsys_io
> 	...

That is fine. I can group entries with the same prefix together.

Cheers,
Longman


