Return-Path: <cgroups+bounces-7212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B302A6C141
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39C0189CE89
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106B222D7AD;
	Fri, 21 Mar 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPESro2E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A322AE59
	for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577770; cv=none; b=Gb6bEjkz/XygUAkvWmZOTugq8Z9ojaHm7eAXtAZCct2QROADdM2c/RHZffhVIvJCJJtD4x1G6BMCTDkn+xLtOr4G1D+jh0p2iBeDFc5BSWHJ/ErjXOAxcqQk0zu4KcQ1RGLd5N+D8E/FB2/wKSLy9ENu6bCNAxxYmJudJoPpNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577770; c=relaxed/simple;
	bh=2n1t1dmeKVAiPixFBzcgnOwZ1LWOHbEuChIPItxaLj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgaLfVHjeoyIIh/UgnML2LyAEMQUBcCqKjCHAhmcbBsS1s397H9zEeqpGGNUq2rmjOzacPs7XoCbSvfllZ/r3ztdwuPn8rlH9221r/bjkDmT9ViDRRwzzCAFBpiYwEr6SIwhRsmGaw0l77meqF/fgyCBW20AwzPDJhJj3WTa7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPESro2E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso50344535ad.2
        for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742577768; x=1743182568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfP6U3mgV85kFoAvAm6siMg5qzkBJgkN5hQA1TPZNs4=;
        b=gPESro2EXCU1MeTQEKLMK71GMG6MnAiDtW442WoW9m9uwQX2+T9xh3HekwHWkfpD2Q
         EtO+wN/IHl7jlsWAwM2pupoqiMuHzsn6G4PQ4N+0PkSBYk5LLQ+lQ1uPR5XVeEKjj5f4
         uPEvBnIHfTznQVmOpmRShmn9BMb844dF77+6OX7qH3z/VF5Z8ejPiL3EC00Xvh3CBH+k
         YDP4VmL2g4rI9CJFJTwqvpYOLgPNKAPst5sDrAm+dqVQS+SMn03c7QaiS0oF+7XZsV5N
         eu3lwg1OnDideKWcBgTPeQclQkvyMO80Fp7kTGqjD/dm+D5ZYL/nLJPpOZN4yeMgM4Bo
         /saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577768; x=1743182568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfP6U3mgV85kFoAvAm6siMg5qzkBJgkN5hQA1TPZNs4=;
        b=GIzbsCIVLDgCQ++K+pl6UExXql0dREZREXqPHXhfotN4AEnUnISi7dyYqenDHQKCp3
         1QJEw2tLWa0VKJBGdVA912HWUgt7RyAlZlyLBI264JwlwKDoW1ilHwq0i4NINfdYuucR
         Gv7rBeEUNol8b+N0KVxw67HB9Uw+a8O2c8t75a5i8J1phj+SPCMftahiE8D9aS+9tLgj
         jkDvNl6d+wrYehv9KroRoEopCDyO+tKS9N4L4OlBfrrfALLvzn5naehajLOBAA+p/QTU
         2F5gmzeIsLU/8PjlSpTyLjd6dfl0el+8TUqZl8yBUi82VSWxwLxEeLTTOMeK0w/cyuNH
         xDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXkF5ASrI9QIuf9iXWrTq43sDZjYn4P0dyke5Xx9NTk2+yEHW0jemD6PPjLuMIqYDYuWubUpMml@vger.kernel.org
X-Gm-Message-State: AOJu0YzyobTy/YPMTTYediF6+IxHP7Nq0BtBrcKxFWYTT1sAs690YzXt
	Ddd4gGQRCQyU7Y2no4Ov2GjE9df/0y/6GXqPo3KBYReuGfOt7kqH
X-Gm-Gg: ASbGncvSjVMVr2DZEenlxb48TSZKS1LrmSG8XfWBKConRn+NgtBssyTltBiH37Ql+3I
	BQIHx+1d+CSepSJVetJmJPETL+UveSEglzqVyRogv203JCerVAq8byp/DUf564cydC2YG3wYsp2
	+wlAew2VZBkMka+50QSHvOjO8edZKMWd/Lal21awOcvHsqxwb+AV+A4BEhNB1MjjCGpqVd0TjH8
	JQDQKbt/rvOXwJgUm04r86a5nGWESN0Sej8o9vX9x4EPnERHuUSinKFQiqVDyqVMrIHtTLsVtyw
	EDA1TFNMR0LEcvMVzN2e+/2/rkLgqE1DV0Mv/irR3rZYKMOzxpBlM7EVyA+GLQfuVohRaa4zUZZ
	QGT9B3CF335H2Ig==
X-Google-Smtp-Source: AGHT+IHdDvQCOplIOOZk2IKKjSOEAGx+zJFtXl2LyOAG2LXi/zHVe98h9cBlK1UbjthAaNMpAVmR0g==
X-Received: by 2002:a05:6a21:6e03:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-1fe434371cfmr8434769637.38.1742577768209;
        Fri, 21 Mar 2025 10:22:48 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4e5d5sm2035615a12.67.2025.03.21.10.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:22:47 -0700 (PDT)
Message-ID: <b60a5444-6a8a-40d7-a22a-1f362c34a584@gmail.com>
Date: Fri, 21 Mar 2025 10:22:46 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v3] cgroup: use separate rstat trees for each
 subsystem
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-3-inwardvessel@gmail.com>
 <Z9yJJXdWdZ_1fmrR@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z9yJJXdWdZ_1fmrR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 2:31 PM, Tejun Heo wrote:
> Hello,
>
> On Wed, Mar 19, 2025 at 03:21:48PM -0700, JP Kobryn wrote:
>> Different subsystems may call cgroup_rstat_updated() within the same
>> cgroup, resulting in a tree of pending updates from multiple subsystems.
>> When one of these subsystems is flushed via cgroup_rstat_flushed(), all
>> other subsystems with pending updates on the tree will also be flushed.
>>
>> Change the paradigm of having a single rstat tree for all subsystems to
>> having separate trees for each subsystem. This separation allows for
>> subsystems to perform flushes without the side effects of other subsystems.
>> As an example, flushing the cpu stats will no longer cause the memory stats
>> to be flushed and vice versa.
>>
>> In order to achieve subsystem-specific trees, change the tree node type
>> from cgroup to cgroup_subsys_state pointer. Then remove those pointers from
>> the cgroup and instead place them on the css. Finally, change the
>> updated/flush API's to accept a reference to a css instead of a cgroup.
>> This allows a specific subsystem to be associated with an update or flush.
>> Separate rstat trees will now exist for each unique subsystem.
>>
>> Since updating/flushing will now be done at the subsystem level, there is
>> no longer a need to keep track of updated css nodes at the cgroup level.
>> The list management of these nodes done within the cgroup (rstat_css_list
>> and related) has been removed accordingly. There was also padding in the
>> cgroup to keep rstat_css_list on a cacheline different from
>> rstat_flush_next and the base stats. This padding has also been removed.
> Overall, this looks okay but I think the patch should be split further.
> There's too much cgroup -> css renames mixed with actual changes which makes
> it difficult to understand what the actual changes are. Can you please
> separate it into a patch which makes everything css based but the actual
> queueing and flushing is still only on the cgroup css and then the next
> patch to actually split out linking and flushing to each css?

Sure, no problem. I did something similar in the RFC series so I'll 
apply again here.

>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 13fd82a4336d..4e71ae9858d3 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -346,6 +346,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>>   	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
>>   }
>>   
>> +static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
>> +{
>> +	return css->ss == NULL;
>> +}
> Maybe introduce this in a prep patch and replace existing users?
Makes sense, will do.
> ...
>> @@ -6082,11 +6077,16 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>>   	css->flags |= CSS_NO_REF;
>>   
>>   	if (early) {
>> -		/* allocation can't be done safely during early init */
>> +		/* allocation can't be done safely during early init.
>> +		 * defer idr and rstat allocations until cgroup_init().
>> +		 */
> Nit: Please use fully winged comment blocks for multilines with
> captalizations.
>
> Thanks.
>

