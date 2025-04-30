Return-Path: <cgroups+bounces-7966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2454AA58CC
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 01:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343321BC877B
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAD22A4DB;
	Wed, 30 Apr 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvCJrFA6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E4224FA
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056625; cv=none; b=Cqj5YWDDfYtg1HRYURsSA/1JjQQwXBhzjyuspdig2YdfFEgVqli1YsX0ZhmTr2EONAvrxU5/FzmlybtQdZknU67Au/ccfUrLq34+ZbTNuROektzUdcn7goj2MAMEtWXT3bUpP9gYCJbAsfvFBwKFtL/OqKIuFQcN0jacygr0rCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056625; c=relaxed/simple;
	bh=VkX209KwHNFTOBcPl2BmZWl3z2PcwO3G4gmEA2YreUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOjAnTQ+GYaEHppdWRTjgRtwX+OjhmJJtKx7nHmsAuMhv8b2tYgo7Z6vSz47FfIQpvrkKsU1BNze9cA64mTCfH+zIcB2b59RWBMbOKWqA8Sb1FxCrigqLjjtM1OyPgHjx/0dkY4igTsh3FhGD6D/HEtjNJvZn6ylPFtj2IeDuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvCJrFA6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33e5013aso4963405ad.0
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746056623; x=1746661423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trrg9W1nidtTS4DlfIahIOyZJBnc1zJhZ4QyQKNercU=;
        b=FvCJrFA6gRcisH58w89j3HrxhhkIaBOPAyDxuTTA5PscjLKm95RLmJxu0R3S9lkyaX
         B+dJELhrCAWfxGsE2BoURDHUjHmgJWO11AqyQ8vzvxisIxGXnmMPlYpC3Aa/tpDDVYYt
         lnz+N+Fkw5EXvW4w6geQ2DGUwsMKD2MW/hHmziSKD7DUKsUVLn6IVvYAvApnIntBUIEJ
         hdVyVdBn2K/68N9pYID1dyzX45rhZRPvzIT9lNLDmIIZfICOW/yK8HMCJHS2JSLwBixH
         hUvHaDbTz2FiH8phWaOhG81U9ItPpf7qYR0aODuc0HPok3xbO7599Fo1meUUPfXZZz86
         72Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746056623; x=1746661423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trrg9W1nidtTS4DlfIahIOyZJBnc1zJhZ4QyQKNercU=;
        b=otv2XX68c2F89Ax9TPHIQA1vojdtn1UQhVQy11iJx6upCQWTuLBp9YBwdYu74bG9Ro
         sgvXdm/fo7A0LIqdCrV9NW3J3V/mqB56PjLbMoKVRXMMUd04SoJxJPB2i0AWn7qPBwk3
         EAj4C1OaQkyr5c82bHG7KFsd4MBzeUmc3j6L4d0xeASuXfktXRrah5uBzIIZeSUEEPbO
         pvJvs2XEcRjV1CoqnEn/HbXczcnQ8BNtpaPSWJ4pOswvFtE0tvAml+Q4qJpmu+HcCjwU
         1DucayMFkAvTS8mEGVN0fkkS0An2Yq1UdA2ZnxD0vMMvsODiZh4pkhIPDLUYTXXg4ZvM
         xNLw==
X-Forwarded-Encrypted: i=1; AJvYcCVGVqTAOKxaMkJ8V8AQVy7ahhtxFhdr0dLZbToE2wNjjIkOkfTtQnx4zVq9wxeEb17XT+L1g5yr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JeFjhijNNmuaLVlvt+HhuOsrV57h9XR6swbzWSCLslMp8HAD
	iL1zHKASCuyFP6g31NlATsE4uJv2ZbVRou51OvEMaKD5BAh0DV2G
X-Gm-Gg: ASbGnctfUqL07jQ67KgbntUWOJzEGD7iC92fa4jm9Hy04BRu9pikcbwxE6zLbPWYNt3
	aUZoMcfsk4q2sHH13vhVW6GOF7Tc5I4cucmiadySmJwgwMVmfb6r1t1MQ7q2YLdBmQEZMJrA1W9
	Lr/tQj3fJAPCcpRcOB6yX1BkaKzfxAXTF8LSq6cXuyTduI5oktGvq/dnMBPqGwHxJxFrtPRmusn
	g3XoBOAMq25RVP4z+Yy4ZZISlBEz8jOljK7gZjo7YowVbYVmqV/BNS08D6gYmZBnq1vh9pYzE6g
	gDHVRLGn51Lj9OcHNe6ZuQyqnH/McXdoKZayk7cyTtPMCWXDUfpoeYHEFFcpbMQE/TPDsyX0ww=
	=
X-Google-Smtp-Source: AGHT+IHuiRYYQi9vmblq0Qh1SJ7ySSma5yx29+dgQfBF4xpvGJlIP7kbk/Z9xi99THgw1a8tjzZ+SQ==
X-Received: by 2002:a17:902:ecc3:b0:224:76f:9e59 with SMTP id d9443c01a7336-22e040b0136mr15620515ad.10.1746056623178;
        Wed, 30 Apr 2025 16:43:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:661a:2fad:77ee:b1ad? ([2620:10d:c090:500::5:69e5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec1faasm9350159a12.29.2025.04.30.16.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 16:43:42 -0700 (PDT)
Message-ID: <e8de82fe-feea-4be2-93eb-620b8ece6748@gmail.com>
Date: Wed, 30 Apr 2025 16:43:41 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <68079aa7.df0a0220.30a1a0.cbb2SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <68079aa7.df0a0220.30a1a0.cbb2SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 6:33 AM, Yosry Ahmed wrote:
> On Thu, Apr 03, 2025 at 06:10:49PM -0700, JP Kobryn wrote:
[..]
>> @@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *work)
>>   		struct cgroup_subsys_state *parent = css->parent;
>>   		int id = css->id;
>>   
>> +		if (ss->css_rstat_flush)
>> +			css_rstat_exit(css);
>> +
> 
> This call now exists in both branches (self css or not), so it's
> probably best to pull it outside. We should probably also pull the call
> in cgroup_destroy_root() outside into css_free_rwork_fn() so that we end
> up with a single call to css_rstat_exit() (apart from failure paths).

This can be done if css_rstat_exit() is modified to guard against
invalid css's like being a subsystem css and not having implemented
css_rstat_flush.

> 
> We can probably also use css_is_cgroup() here instead of 'if (ss)' for
> consistency.
> 
>>   		ss->css_free(css);
>>   		cgroup_idr_remove(&ss->css_idr, id);
>>   		cgroup_put(cgrp);
> [..]
>> @@ -5659,6 +5647,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>>   		goto err_free_css;
>>   	css->id = err;
>>   
>> +	if (ss->css_rstat_flush) {
>> +		err = css_rstat_init(css);
>> +		if (err)
>> +			goto err_free_css;
>> +	}
>> +
>>   	/* @css is ready to be brought online now, make it visible */
>>   	list_add_tail_rcu(&css->sibling, &parent_css->children);
>>   	cgroup_idr_replace(&ss->css_idr, css, css->id);
>> @@ -5672,7 +5666,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>>   err_list_del:
>>   	list_del_rcu(&css->sibling);
>>   err_free_css:
>> -	list_del_rcu(&css->rstat_css_node);
>>   	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
>>   	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
>>   	return ERR_PTR(err);
>> @@ -6104,11 +6097,17 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>>   	css->flags |= CSS_NO_REF;
>>   
>>   	if (early) {
>> -		/* allocation can't be done safely during early init */
>> +		/*
>> +		 * Allocation can't be done safely during early init.
>> +		 * Defer IDR and rstat allocations until cgroup_init().
>> +		 */
>>   		css->id = 1;
>>   	} else {
>>   		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
>>   		BUG_ON(css->id < 0);
>> +
>> +		if (ss->css_rstat_flush)
>> +			BUG_ON(css_rstat_init(css));
>>   	}
>>   
>>   	/* Update the init_css_set to contain a subsys
>> @@ -6207,9 +6206,17 @@ int __init cgroup_init(void)
>>   			struct cgroup_subsys_state *css =
>>   				init_css_set.subsys[ss->id];
>>   
>> +			/*
>> +			 * It is now safe to perform allocations.
>> +			 * Finish setting up subsystems that previously
>> +			 * deferred IDR and rstat allocations.
>> +			 */
>>   			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
>>   						   GFP_KERNEL);
>>   			BUG_ON(css->id < 0);
>> +
>> +			if (ss->css_rstat_flush)
>> +				BUG_ON(css_rstat_init(css));
> 
> The calls to css_rstat_init() are really difficult to track. Let's
> recap, before this change we had two calls:
> - In cgroup_setup_root(), for root cgroups.
> - In cgroup_create(), for non-root cgroups.
> 
> This patch adds 3 more, so we end up with 5 calls as follows:
> - In cgroup_setup_root(), for root self css's.
> - In cgroup_create(), for non-root self css's.
> - In cgroup_subsys_init(), for root subsys css's without early
>    initialization.
> - In cgroup_init(), for root subsys css's with early
>    initialization, as we cannot call it from cgroup_subsys_init() early
>    as allocations are not allowed during early init.
> - In css_create(), for non-root non-self css's.
> 
> We should try to consolidate as much as possible. For example:
> - Can we always make the call for root subsys css's in cgroup_init(),
>    regardless of early initialization status? Is there a need to make the
>    call early for subsystems that use early in cgroup_subsys_init()
>    initialization?
> 
> - Can we always make the call for root css's in cgroup_init(),
>    regardless of whether the css is a self css or a subsys css? I imagine
>    we'd still need two separate calls, one outside the loop for the self
>    css's, and one in the loop for subsys css's, but having them in the
>    same place should make things easier.

The answer might be the same for the two questions above. I think at
best, we can eliminate the single call below to css_rstat_init():

cgroup_init()
	for_each_subsys(ss, ssid)
		if (ss->early_init)
			css_rstat_init(css) /* remove */

I'm not sure if it's by design and also an undocumented constraint but I
find that it is not possible to have a cgroup subsystem that is
designated for "early init" participate in rstat at the same time. The
necessary ordering of actions should be:

init_and_link_css(css, ss, ...)
css_rstat_init(css)
css_online(css)

This sequence occurs within cgroup_init_subsys() when ss->early_init is
false. However, when early_init is true, the last two calls are
effectively inverted:

css_online(css)
css_rstat_init(css) /* too late */

This needs to be avoided or else failures will occur during boot.

Note that even before this series, this constraint seems to have
existed. Using branch for-6.16 as a base, I experimented with a minimal
custom test cgroup in which I implement css_rstat_flush while early_init
is on. The system fails during boot because online_css() is called
before cgroup_rstat_init().

cgroup_init_early()
	for_each_subsys(ss, ssid)
		if (ss->early)
			cgroup_init_subsys(ss, true)
				css = ss->css_alloc()
				online_css(css)
cgroup_init()
	cgroup_setup_root()
		cgroup_rstat_init(root_cgrp) /* too late */

Unless I"m missing something, do you think this constraint is worthy of
a separate patch? Something like this that prevents the combination of
rstat with early_init:

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6130,7 +6130,8 @@ int __init cgroup_init_early(void)
     for_each_subsys(ss, i) {
-       WARN(!ss->css_alloc || !ss->css_free || ss->name || ss->id,
+       WARN(!ss->css_alloc || !ss->css_free || ss->name || ss->id ||
+           (ss->early_init && ss->css_rstat_flush),

> 
> Ideally if we can do both the above, we'd end up with 3 calling
> functions only:
> - cgroup_init() -> for all root css's.
> - cgroup_create() -> for non-root self css's.
> - css_create() -> for non-root subsys css's.
> 
> Also, we should probably document all the different call paths for
> css_rstat_init() and css_rstat_exit() somewhere.

Will do.

