Return-Path: <cgroups+bounces-7802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE82A9B4FD
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A8C1BA3969
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1628A1FC;
	Thu, 24 Apr 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNe65XAK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA32820B2
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514617; cv=none; b=HbT54Ua6KTQqgDG+RO8q9WkBc4Dzbn+VpDmgq7h2bQuczVn3Ko725RMQ+URpESrhsRehp2BxlhFhR3TKZr0e1sz1HT25QGogZBStFdVHOthxowQd1z933CgIByOcyb1JDL/9B9b3H8fei9t0UMI6PYqj0TWNcMayhyRZ2gheKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514617; c=relaxed/simple;
	bh=E7Or0G1S4tjQeC9miTrxPwGw41tdeJHKnz9LxZHgQqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSkYt+Y/yWNdVIFolt+l7PyI4al67DVWfA1TOuFtBHXKJC4WUW6EPh4EBNQRaANxZVJd46DkLYqLzT/Wpyp2Pbooi3IEtzePHtm+6sNexFg5yScaHAArrHkYAkX3gf68twp/iV5fhX4rmVdtMMGQDXX95WTK+4CmI7yI2yzUb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNe65XAK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7394945d37eso1126329b3a.3
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514615; x=1746119415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoAsMcihc1xMqVGN/kDHY7HQTkDLG+HfsxoiVJN/raU=;
        b=ZNe65XAK+4buw5sm4woa/keTB6ja9aJwTFdiEqHhk6GT3uG0ta4Q3UO+Josh9vPgfW
         XL61OAf5pivau53sdX1lS8zMmJvWde0p2DfyhSyPZLl4xuonulJPWSI813Ui/jY9RCfV
         49A31OZBYFUzJtr18kSnSvg3juipSU9TMYddoYyrhuDcMlZt48kJpK/UhVknSPnE0PPm
         b128TPp0nQMrHtg2G5Dw3ZZv0ummToU8TBvtOFbd8wQ9+dm1MjWKKWgBs0jpV9IfQYqn
         5MmYLd4JvcVBKAF7HByEaW6W5GpncL4HJjjsZTC9Kg+V+MUaVXHNe6nsMM7hPkiaw97J
         mT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514615; x=1746119415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoAsMcihc1xMqVGN/kDHY7HQTkDLG+HfsxoiVJN/raU=;
        b=hlt2yeboTzI2aCuxb5VrpjFzdtZCPfWBgg7Pm4CFxnnDGprXt0/F+mxsp1cdDVVDNa
         W4URXL6SFxoFYeQ6rGlUzOBZ+QB+IZdvvjH9i4ANj++yS37HskZKEhdBzWIZGQqkFJ8r
         6Oyl+6vTcVX8UUFNFVH2cgu/ebxvRWi/IAZY0FGYidjP5Yl4qmWZnRQ9urMxxEeyl3tJ
         CM6N7/utrl9TsUqC4wrObdf+UdyM6pKnEtyXu3oFPdGl/ulLvBKLnnkBC9L++OfJxpGd
         vWXWZvV007r7EvOLxa7upUjtdocRgasIaBf4YGX9WXn6koAF3/mkz2HUJYDeHZLC0kz2
         AE3g==
X-Forwarded-Encrypted: i=1; AJvYcCX13n11gZJq5hZu2pdv5z3A9pir9nRzrUBdUjJTVTL49uLZn9PmRkZ0yLkLE1y3PwxAD2klN0Le@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJOPsdyjNd3cM8BxrcwmFQ0dz16ktpAkW59Iq12ufA6i8SP3b
	ZMtaepkrDErGVbRDmpBRewQ7i+dRxXaW8TdCrpGJqq7xQfuZSbZq
X-Gm-Gg: ASbGnctJZf19E4BbXdrFmY+qCPrbCkh3GauaVWR+EYH0gm+V4lFkpscn0avHkRixkgn
	L1IGBoE5mdvwggTXXxXaMcQDYeXKwfqun8rZdx2ATO/AvYc6MN4Ldbw8BCOnhtUFqSyyc5S/Fzs
	F2gJf4/qHWruwAg+emWRo08MT8c6Wrii1Sd6dzaI+YueBY5unwgSD4fiQYG518p/bEn5cchi4rf
	CYSGeMFh51fQHUGimAOCN8hSpGrS4xcdaxEahBe9U6mS8JLk64hNE1Xmkn7WXTXUgOBZgr8cD1z
	dhoWQ5Y54eRtEXQoTTyOGJhGgVma+zx7GUI1COwb7fbOrfj2kjWRTKNTMOcjGiI/r4hwYEAK
X-Google-Smtp-Source: AGHT+IEyiYe2D0MV4Icd5xkf3+nsK9hIVYlp8alPoA4Fvjuv9WE7h0WKiI4D69ihGnNN9rlEzVQ2Aw==
X-Received: by 2002:a05:6a21:6b82:b0:1f5:5903:edd3 with SMTP id adf61e73a8af0-204565f453emr136078637.11.1745514614992;
        Thu, 24 Apr 2025 10:10:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:fd6c:bb6:36da:5926? ([2620:10d:c090:500::5:5d68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912fb9sm1673830b3a.34.2025.04.24.10.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 10:10:14 -0700 (PDT)
Message-ID: <baf92595-2837-497c-b7a7-b099fafa1f9a@gmail.com>
Date: Thu, 24 Apr 2025 10:10:13 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
 <68078d3c.050a0220.3d37e.6d82SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <68078d3c.050a0220.3d37e.6d82SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 AM, Yosry Ahmed wrote:
> On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
>> This non-functional change serves as preparation for moving to
>> subsystem-based rstat trees. To simplify future commits, change the
>> signatures of existing cgroup-based rstat functions to become css-based and
>> rename them to reflect that.
>>
>> Though the signatures have changed, the implementations have not. Within
>> these functions use the css->cgroup pointer to obtain the associated cgroup
>> and allow code to function the same just as it did before this patch. At
>> applicable call sites, pass the subsystem-specific css pointer as an
>> argument or pass a pointer to cgroup::self if not in subsystem context.
>>
>> Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
>> are not altered yet since there would be a larger amount of css to
>> cgroup conversions which may overcomplicate the code at this
>> intermediate phase.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> [..]
>> @@ -5720,6 +5716,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>>   	cgrp->root = root;
>>   	cgrp->level = level;
>>   
>> +	/*
>> +	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
>> +	 * is setup, it is safe to perform rstat initialization on it.
>> +	 */
>> +	ret = css_rstat_init(&cgrp->self);
>> +	if (ret)
>> +		goto out_stat_exit;
>> +
> 
> Sorry for the late review, but this looks wrong to me. I think this
> should goto out_kernfs_remove..
> 
>>   	ret = psi_cgroup_alloc(cgrp);
>>   	if (ret)
>>   		goto out_kernfs_remove;
> 
> ..and this should goto out_stat_exit.

Thanks, will invert in separate patch.
> 
>> @@ -5790,10 +5794,10 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>>   
>>   out_psi_free:
>>   	psi_cgroup_free(cgrp);
>> +out_stat_exit:
>> +	css_rstat_exit(&cgrp->self);
>>   out_kernfs_remove:
>>   	kernfs_remove(cgrp->kn);
>> -out_stat_exit:
>> -	cgroup_rstat_exit(cgrp);
>>   out_cancel_ref:
>>   	percpu_ref_exit(&cgrp->self.refcnt);
>>   out_free_cgrp:
> [..]
>> @@ -298,36 +304,41 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
>>   	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>>   }
>>   
>> -static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>> +static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
>> +		int cpu_in_loop)
>>   	__releases(&cgroup_rstat_lock)
>>   {
>> +	struct cgroup *cgrp = css->cgroup;
>> +
>>   	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
>>   	spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>   
>>   /**
>> - * cgroup_rstat_flush - flush stats in @cgrp's subtree
>> - * @cgrp: target cgroup
>> + * css_rstat_flush - flush stats in @css->cgroup's subtree
>> + * @css: target cgroup subsystem state
>>    *
>> - * Collect all per-cpu stats in @cgrp's subtree into the global counters
>> + * Collect all per-cpu stats in @css->cgroup's subtree into the global counters
>>    * and propagate them upwards.  After this function returns, all cgroups in
>>    * the subtree have up-to-date ->stat.
>>    *
>> - * This also gets all cgroups in the subtree including @cgrp off the
>> + * This also gets all cgroups in the subtree including @css->cgroup off the
>>    * ->updated_children lists.
>>    *
>>    * This function may block.
>>    */
>> -__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>> +__bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>>   {
>> +	struct cgroup *cgrp = css->cgroup;
>>   	int cpu;
>>   
>>   	might_sleep();
>>   	for_each_possible_cpu(cpu) {
>> -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
>> +		struct cgroup *pos;
>>   
>>   		/* Reacquire for each CPU to avoid disabling IRQs too long */
>> -		__cgroup_rstat_lock(cgrp, cpu);
>> +		__css_rstat_lock(css, cpu);
>> +		pos = cgroup_rstat_updated_list(cgrp, cpu);
> 
> Moving this call under the lock is an unrelated bug fix that was already
> done by Shakeel in commit 7d6c63c31914 ("cgroup: rstat: call
> cgroup_rstat_updated_list with cgroup_rstat_lock").

Right. I had been working off of a tree that did not yet receive the
patch. Moving forward I will be using the tj/cgroup tree.

> 
> Otherwise this LGTM.

Thanks for reviewing.

