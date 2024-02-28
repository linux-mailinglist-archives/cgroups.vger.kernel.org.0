Return-Path: <cgroups+bounces-1897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2B686B2BA
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A9B284BD9
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8A15B974;
	Wed, 28 Feb 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPnYLcCd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919112CCDF
	for <cgroups@vger.kernel.org>; Wed, 28 Feb 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132927; cv=none; b=oN4JnDTWgdTNhgaf6ya8DWAJXmnRnDA9Q/r33zG6//ljXRdT9Vxaz5C4MMHCdbImn7EudUXmRzUhSq6vupPTUEaS7GMikl1u9d3Capj7NJRomrCWKffSuFTY2pUEll+LCKmYxx1V8Ei35753jNwklYbPBkRjlrY/vjoo7BxUYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132927; c=relaxed/simple;
	bh=mGsmLiySu3b6hwyxlJDwZRPwYOAZoEhbmMNJ97RLBOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq/61wqtKz33pcV8OfWYP0sfcgQnm4jRwyphAwGfeEI3iqDoSZs8nzL9Iqy/SjppinS0UIv/ewash4QhGBtjWMwT5R4jUVR7tTV6kq1L+vveynomMOHQj/9cT+26A9Z9dNYzV/qNjzLcqkM50RKyZ5Sgz+dmYB+CtJ6Kp0be/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPnYLcCd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709132924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MsF2uBUKO3iYphfCuIrMXs+jyp1MSdF2qPxKEThSvU=;
	b=bPnYLcCdRfo8RfFbTHCuqxpeFSiX/YwIm8ybk9VL8tgU6/5KtL4UxR0VdXiUFeioxwG5Dd
	9F73cD5gDpAUOn5l8xzhpsEsz/xsHXANt0FqQ8RPo/WdZtuR7JNaZp9tLSU9C2G7H0mpgY
	GXigaRvwM9FutSOSi6HkDmo4N3Kr5/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-J8oCZPmwN7au00msv6yKQw-1; Wed, 28 Feb 2024 10:08:39 -0500
X-MC-Unique: J8oCZPmwN7au00msv6yKQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B77DB88D0C3;
	Wed, 28 Feb 2024 15:08:38 +0000 (UTC)
Received: from [10.22.9.68] (unknown [10.22.9.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8F3492BC8;
	Wed, 28 Feb 2024 15:08:38 +0000 (UTC)
Message-ID: <3ec14dfe-6d69-4c41-804d-3e4e67828ae1@redhat.com>
Date: Wed, 28 Feb 2024 10:08:37 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Fix a memory leak in
 update_exclusive_cpumask()
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228005801.429847-1-longman@redhat.com>
 <bc055871-9aa7-4165-bb54-39520349dc16@domac.alu.unizg.hr>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bc055871-9aa7-4165-bb54-39520349dc16@domac.alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 2/28/24 08:56, Mirsad Todorovac wrote:
> Hi,
>
> On 2/28/2024 1:58 AM, Waiman Long wrote:
>> Fix a possible memory leak in update_exclusive_cpumask() by moving the
>> alloc_cpumasks() down after the validate_change() check which can fail
>> and still before the temporary cpumasks are needed.
>>
>> Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
>> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.hr>
>> Closes: 
>> https://lore.kernel.org/lkml/14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index ba36c073304a..7260f095802a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2598,9 +2598,6 @@ static int update_exclusive_cpumask(struct 
>> cpuset *cs, struct cpuset *trialcs,
>>       if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
>>           return 0;
>>   -    if (alloc_cpumasks(NULL, &tmp))
>> -        return -ENOMEM;
>> -
>>       if (*buf)
>>           compute_effective_exclusive_cpumask(trialcs, NULL);
>>   @@ -2615,6 +2612,9 @@ static int update_exclusive_cpumask(struct 
>> cpuset *cs, struct cpuset *trialcs,
>>       if (retval)
>>           return retval;
>>   +    if (alloc_cpumasks(NULL, &tmp))
>> +        return -ENOMEM;
>> +
>>       if (old_prs) {
>>           if (cpumask_empty(trialcs->effective_xcpus)) {
>>               invalidate = true;Great work at such a short notice! (I 
>> failed to find the culprit myself.)
>
> The leak is no longer present.
>
> Please feel free to add:
>
> Tested-by: Mirsad Todorovac <mtodorov@alu.unizg.hr>
>
> Best regards, Mirsad Todorovac
>
> P.S. APologies for the previous email accidentally sent as HTML.

Thanks for verifying the fix.

Cheers,
Longman


