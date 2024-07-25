Return-Path: <cgroups+bounces-3901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071493C89A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 21:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11CD1F23C3A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB74D8CB;
	Thu, 25 Jul 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL0Y1rO3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E036AFE
	for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721934493; cv=none; b=RX0AppGgBNtjwQid7JMvRGRTchfzbwj+HPqeKTGYXowG1JBTJF/WHUM/ikBCGe81aO08SHl7kgvpRK2JNjTcVF5m7tizwTBR7F8yJKM2S+MOaYGJinllo1m1W7Pi8ZdvL+JZnQkMzyogMDB9MhWKYUht/wRc7kaidXpTyNioCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721934493; c=relaxed/simple;
	bh=kSttdvFfGUyyYoHoZCW5LJkXQf4weGf5yS33OSA1WYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABNPwnn7I3VKAbgPiIIT0vWCCJPzJqq8xiHrubd9T5hNjsWtm55RM6WAJi7UgW1X3tS/Vy//3JGAmpdwpzpSqzBiIofANYUkQbEFRgGoWG8ciLJc3hyU1gxjJtX/HBXz70oqUW3hyF8wMpV7ejHpJg9FB4cgySL5BaNcabevy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL0Y1rO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721934488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AofTLwe2CDTumu2oM3peD/cu5gWmuIeEi3JZIBTIQxM=;
	b=BL0Y1rO3AoUOIzRe1+n3C+JFUmT2ffRkZEkJ2Oiy1ho+j9IBxaGygijWyuxY/3/pLITTTT
	AhRLL6ktKd9DJhZPkmKruR7muPMHgbBfahKCR7cQZJrQuQCacsUE58QfB9/dFoepGiReJC
	BlqKZnAyZ2gXgGl6XRU1EetYgafP8B4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-saHPERMgOu2UC_-lq3-56w-1; Thu,
 25 Jul 2024 15:08:03 -0400
X-MC-Unique: saHPERMgOu2UC_-lq3-56w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AAFA1955F42;
	Thu, 25 Jul 2024 19:08:01 +0000 (UTC)
Received: from [10.2.16.78] (unknown [10.2.16.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52CD11955F40;
	Thu, 25 Jul 2024 19:07:57 +0000 (UTC)
Message-ID: <b45c24d2-98ee-4ecc-8d7d-6ac5dfa65c17@redhat.com>
Date: Thu, 25 Jul 2024 15:07:56 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: add dec_attach_in_progress helper
To: chenridong <chenridong@huawei.com>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725015551.2221867-1-chenridong@huawei.com>
 <e5c92f54-d767-4e71-9f57-9352923bd3e7@oracle.com>
 <de6958aa-27f8-4baa-b76d-88266d009f81@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <de6958aa-27f8-4baa-b76d-88266d009f81@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 7/25/24 07:40, chenridong wrote:
>
>
> On 2024/7/25 19:01, Kamalesh Babulal wrote:
>>
>>
>> On 7/25/24 7:25 AM, Chen Ridong wrote:
>>> There are several functions to decrease attach_in_progress, and they
>>> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
>>> add a helper to make it concise.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 28 +++++++++++++++-------------
>>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index d4322619e59a..c241845694ac 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -490,6 +490,17 @@ static inline void 
>>> check_insane_mems_config(nodemask_t *nodes)
>>>       }
>>>   }
>>>   +/*
>>> + * decrease cs->attach_in_progress.
>>> + * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
>>
>> In the description, adding locking constraint of cpuset_mutex would 
>> be helpful.
>> Something like "cpuset_mutex must be held by the caller."
>>
> Thank you, I will to that.
>>> + */
>>> +static inline void dec_attach_in_progress(struct cpuset *cs)
>>> +{
>>> +    cs->attach_in_progress--;
>>> +    if (!cs->attach_in_progress)
>>> +        wake_up(&cpuset_attach_wq);
>>> +}
>>> +

I would suggested a dec_attach_in_progress_locked() and a 
dec_attach_in_progress() helpers. The dec_attach_in_progress() helper 
acquires the cpuset_mutex and call dec_attach_in_progress_locked(). 
Inside the dec_attach_in_progress_locked(), you can either add a comment 
about requiring cpuset_mutex held or add a 
lockdep_assert_held(&cpuset_mutex).

Cheers,
Longman



