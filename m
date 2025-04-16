Return-Path: <cgroups+bounces-7606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CDA90DF0
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE574443077
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758E233144;
	Wed, 16 Apr 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3RqOE7W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9F28E3F
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839842; cv=none; b=fSC4zehdffNMC7FSK4ZQF1PbepOyhFg5Fa1v2eZPUttcthnbkGcF3XBHKOQVIgfHVBpRi96zeeb+kIJ9yc6d4i37m+8zQIEb5erhatbuFyvQUqgYnPeCrfSCVwn7pM3xfrYpVw/kpw7qn5qiX0UUy2ylPtPeCYoblVx4KFTqiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839842; c=relaxed/simple;
	bh=4bBSsEDD51tFLVuay510tPdlbzNbehM3HBNNSELWLpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/Xm/B5SHNyy9dYzi5USf8g0euAOKc+QXXVcM5IkNueT9oF6LLFYFLUOTen0y1cC7pswelEFJBiLy9CqtyWUHq9KT2lpSmePwsfdzFrvnkz0ACfuG2lcg6TMKKbpo8mEik8a9VzY3VFghfqzk64W1QagUmuskAFfaIEFZT7EcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3RqOE7W; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c58974ed57so7241185a.2
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744839840; x=1745444640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OIyk1ZENdNQZu/9TYzK311bLdd6xKD/ifEusl7LbEA=;
        b=W3RqOE7WeIlF+Exlw2YeSuFwMZDss+F1BQ3hx7C4nVHypD43zs3Q0F+FfEsoMYdnOl
         ZOu5kl0yD3V1vR2U/lNcR1L/I24zch7hW3B7x9OiOhlUr+lMn/i7aPCYoTKA5hv/fbG/
         9KZ1xaSLAmShJJt75+5g5AXG64dEyrESeCQ4vstWX384wFU22As2IQWBRSVt83R6zI6u
         k7x7eRi69rBHSw/qWLMFntAEnKm2Dchtn7XHM/hQGB2RlMtXcQaC4I6yUvv8kas/goij
         ACknTEeWFSP8LT9XVGqU4rMw2ouZHdt7H/vvTrIqknRj9j340CG57u5+OZ/PeGyHniii
         boPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744839840; x=1745444640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OIyk1ZENdNQZu/9TYzK311bLdd6xKD/ifEusl7LbEA=;
        b=gzNm/AUfomGNEIMlA8eFxRAPPTEYLVPB4eeGRY+IJezhk1g5bnaR6rZ6qjl+exFCK9
         eQTtPrzE15+9u9eDWLCzOHf4H7L3xBckQitPuSYx1/59Vn1Cr5LZpcc+Q5dXAAXxyVX+
         TOz9D452GvpWgj/1pQkgn+MSSOYOoqHNrPbqHXqphnGwDVxSv/mOA6I0y2WsH/exfaM2
         8LLFcaeKHXNY+AtTbfXwqjaVTSivwIoR+upjgTgrDpilgBCu62WgV8UNvqi7QPW/SAoE
         oVpM0QAKdmXgLLU6i68wTaQj0Cq57TwLp2V3uv8DqpkUEuaStkC/YSOJQAQFBEGcPjul
         dE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe88SqPZN/B1MiYc/Bx+0Zv05KBtaJtHsNE9QIvA4u6Az9RqEzHU3PP+/UoeXcvMARKhIUzZTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gbWWUeo4ZAmv1SroKf/UU9tn65EcH7O7XoUyjd4/iykO0zFw
	Pupi/ulz09ko3QvqmXrI6batPMwKv+wV9RA6voT/Kfuy0JLW9l4Q
X-Gm-Gg: ASbGnct8kkOmrSsX/qg53J/UmJeWynZxX0qBCj0hS+L/YeGhLEBZc4N0DpPmhnVzu22
	uHAL5laIu15gxEFi8WbbPFBl5cH/kbIMr/4Z0OPVlglUyDTH2laoN02a/jCBuShGcr6jAf0Axkd
	obWy8/Diq+hxFfqSCIdXfheiR7Dxn7dUq4nkS3QYnbCbYx/VCAD570bFkdyZojQJDv3RfNG4QTJ
	t4Vum7o4YT9c7nKkzzEI5umkccL8igIkokanI25s03b9eoJrHh8qc4P1QiYEsl6wZ6O8LFb5dae
	BUbszuCMMfIupcqx4e433lmrJCvj8PsHVSVw0oDCQBVqLOl4i1dlC0nD6nQLvTRcU4FZbHC4
X-Google-Smtp-Source: AGHT+IHU21QnA2LHSogdD/CErEVvhghGtE3hBs14ZAZayn0m+D+RKDdHjiJDnwlqMDn1XIlARkcCVA==
X-Received: by 2002:a05:620a:1988:b0:7c5:94b2:99da with SMTP id af79cd13be357-7c9190022bamr499544485a.28.1744839840158;
        Wed, 16 Apr 2025 14:44:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:b31:ddc1:afa7:7c1e? ([2620:10d:c090:500::4:d585])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de11sm1099335485a.101.2025.04.16.14.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 14:43:59 -0700 (PDT)
Message-ID: <88f07e01-ef0e-4e7d-933a-906c308f6ab4@gmail.com>
Date: Wed, 16 Apr 2025 14:43:57 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/25 10:15 AM, Michal Koutný wrote:
> On Thu, Apr 03, 2025 at 06:10:49PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
> ...
>> @@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *work)
>>   		struct cgroup_subsys_state *parent = css->parent;
>>   		int id = css->id;
>>   
>> +		if (ss->css_rstat_flush)
>> +			css_rstat_exit(css);
>> +
> 
> It should be safe to call this unguarded (see also my comment below at
> css_rstat_flush()).

Hmmm I checked my initial assumptions. I'm still finding that css's from
any subsystem regardless of rstat usage can reach this call to exit.
Without the guard there will be undefined behavior.

> 
>>   		ss->css_free(css);
>>   		cgroup_idr_remove(&ss->css_idr, id);
>>   		cgroup_put(cgrp);
>> @@ -5477,11 +5472,8 @@ static void css_release_work_fn(struct work_struct *work)
>>   	if (ss) {
>>   		struct cgroup *parent_cgrp;
>>   
>> -		/* css release path */
>> -		if (!list_empty(&css->rstat_css_node)) {
>> +		if (ss->css_rstat_flush)
>>   			css_rstat_flush(css);
>> -			list_del_rcu(&css->rstat_css_node);
>> -		}
> 
> Ditto.

Same as mentioned above, there are cases where some css's belonging to a
subsystem like "cpu" (via CONFIG_CGROUP_SCHED) can reach this code.

> 
> These conditions -- css_is_cgroup(pos) and pos->ss->css_rstat_flush
> should be invariant wrt pos in the split tree, right?

It's a good point. Yes, I would say so.

> It's a μoptimization but may be worth checking only once before
> processing the update tree?

Let me do that that in the next rev.


