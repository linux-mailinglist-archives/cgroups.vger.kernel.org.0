Return-Path: <cgroups+bounces-13652-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCWTNnzPgmk8cAMAu9opvQ
	(envelope-from <cgroups+bounces-13652-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:47:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42303E199F
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368C6305E9A9
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 04:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF434E74B;
	Wed,  4 Feb 2026 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4npHxxH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7TMnUtl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF83358D4
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180427; cv=none; b=oDyCxLHs7CJw1O0eVoVfYyglgcxyi8gkoBqPG+6Z0CU60ru5bSWaii4DcGrdE0ATE6jmoXyikpnJfsaL5HZ7FFrl7Et/wqCugMQger2cF/SqYKrccRnB3owlm1L5Y9VOUmjf2kxtdHOKQubIDDI6uWbP1uKLOIH0WRc7uQe4Wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180427; c=relaxed/simple;
	bh=rLaRsKu7CREx5s6WYnmkbwSOEU+GT9F+qtG079ipLls=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lGVkMU0PrTNZNztZ0DlOk9coRsgeijr5CI5k2hemyDymVAAs0RuabVQBRu1Wsl4SXUmBOcYzz6NhI8YfFfDea4tlr2t0M5+ZI00F32N94zgZ1IrbYLqIRn22qF3k3HG7+qZwdSp9RaKosIjw1atPyn4yW2KebK/6r+dRmQGt/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4npHxxH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7TMnUtl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770180426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y69ODIoURgASqSeV5hS5rWlgMMnpQL1tFExn4zKMhQ=;
	b=H4npHxxHt1//mEeJ4NpmonyREjSg9qWws+IFXvBIdR5h6PNVl9q8CLE4HZGVV6kI4syge7
	j9oSxvq/vxHghbvo+NvP71jBEVqI5NiEa1CDGgvk9corY1qoyE6Nk27u1+gqeaMkAwcPyw
	HvjGXOB6MibJG3AI/GsIdXheYtPJ9Ww=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-55UZMnKkP3K1-ph97DAIMw-1; Tue, 03 Feb 2026 23:47:03 -0500
X-MC-Unique: 55UZMnKkP3K1-ph97DAIMw-1
X-Mimecast-MFC-AGG-ID: 55UZMnKkP3K1-ph97DAIMw_1770180423
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a5bc8c43so158054385a.2
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 20:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770180423; x=1770785223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Y69ODIoURgASqSeV5hS5rWlgMMnpQL1tFExn4zKMhQ=;
        b=q7TMnUtlLpR71OVK5RBkXvhVFslYIer3Xjk6uD94PVju8pZsHHDJK3aZR17nir5LfF
         cL0vI6BZK0giaecQla+3OcyXvy+lAQJg0ngGa1EtaAG5w+42Ia30CKZPltc4DqhGYs5a
         /plzFsLGqbSdsCTcGqK4DquF9NQv0HPErfUCSIuOjWA9ZslXetgjxALYykIt/Zc9RhoH
         ne2MDXncSiNInnHq3OQAumAaDxEVmOLTCeFjSqdqWER6U8MQTqApO0u1rSoUt1poV4Vb
         UhM0rwKQvGRfVLtzopFcht1ho1lS9hgVJgj7x1Er6UbkDN3USsX3BzTgFMupHOUxZ5lL
         GNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770180423; x=1770785223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y69ODIoURgASqSeV5hS5rWlgMMnpQL1tFExn4zKMhQ=;
        b=DDPs1yVmaLCugdtz/OkvpMq+UF0XQ5MfIqEO4rVGpkVpD6K1CFYsjqmgI3JV6bdME+
         k9g8KTMWUhtINkdliUcklu4m5WJhzuwV16h6bqD7JzUsNn+sIVYb7W+XNgjXBZ2J6j+q
         Ew3uRyKZCdlqrDwJIcD6fpuYgiTs8kmi4d4hkIuxHkLS9ys2KCZzz4jOBcy1ZXHkKVt/
         3JA66JPxFED47M6NGgCOnyZqzvOhROiNTEf8jE3GAVhg583RRTW7YLFWxvjLgW1G3Cbr
         OcqrBwI+4s8vTD33cDvSMvUP8aTz6bfGicf7zZDie11RDiYadq2bKA4HHJNzxd/aCUOA
         KmVQ==
X-Gm-Message-State: AOJu0YwTR8Kx5NFhUUSTSnMcexsf07gnTqm6R7T4Njo9/PPpsVdtcySp
	/o8NMjF1v6S80pHVGRK1fDM0Y4P3/5eAkGLUk754r6X7/wl2UzlScboZtVIBuO80OJIIWL8SfJC
	0RCKXJbJPH4m+rpPBuvtyjvgNs2S+5FWXz2uWZIFIrW0GC3zi4OK1eam5qWg=
X-Gm-Gg: AZuq6aIHhC36KMWv0NkLk0Sh35ga1MA+sSlIGqb4uV1WjV3rW4FnPk72pYbGBgPweT6
	83X9SuBmFs1tjymYajgJ5f3x8ZWgACY1R2edJv6PT/Of1XjJN4VBEX7pIq9kBD/a87cDusaJmMD
	3//1lPFCNzuzr7vQClxb9C8Yb9f6Ck3xwpksf+VPw1pvDeUbsOGWydJT2hAvrbGywUjR0B5XZ6R
	80pcahxejtJgPgXGdMAFHzaCOIc7aUmP+2/k4j+gd9YWha9ZFwfVJwzwXEoAxHqkdR0m9rl93q4
	UjXmmnhutbo3K7k7I6cJqwE8Ll/3Z5UxanM0byRnT6OteVUfOkRlj9qEqNer0K4BFvtDtu77Jsp
	CH9R5bLQIVSzyLBiGUVr4UPGZ7J19T+B8SyS74aRebWxEe8i9YvX1S4kj
X-Received: by 2002:a05:620a:4805:b0:8c5:38ee:2fad with SMTP id af79cd13be357-8ca2fa5ea0amr230627385a.84.1770180423170;
        Tue, 03 Feb 2026 20:47:03 -0800 (PST)
X-Received: by 2002:a05:620a:4805:b0:8c5:38ee:2fad with SMTP id af79cd13be357-8ca2fa5ea0amr230625685a.84.1770180422748;
        Tue, 03 Feb 2026 20:47:02 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d2788asm11831606d6.47.2026.02.03.20.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 20:47:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <83d0426d-92ea-4e2b-83bc-62998218b212@redhat.com>
Date: Tue, 3 Feb 2026 23:47:00 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 3/3] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-4-longman@redhat.com>
 <1fff6bd2-b62a-48d9-9408-af3b5552815e@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <1fff6bd2-b62a-48d9-9408-af3b5552815e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13652-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42303E199F
X-Rspamd-Action: no action

On 2/3/26 9:51 PM, Chen Ridong wrote:
>
> On 2026/2/3 4:11, Waiman Long wrote:
>> --- a/kernel/time/timer_migration.c
>> +++ b/kernel/time/timer_migration.c
>> @@ -1559,8 +1559,6 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>>   	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>>   	int cpu;
>>   
>> -	lockdep_assert_cpus_held();
>> -
>>   	if (!works)
>>   		return -ENOMEM;
>>   	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
>> @@ -1570,6 +1568,7 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>>   	 * First set previously isolated CPUs as available (unisolate).
>>   	 * This cpumask contains only CPUs that switched to available now.
>>   	 */
>> +	guard(cpus_read_lock)();
>>   	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
>>   	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
>>   
> It may lead to lockdep issue.
>
> tmigr_init_isolation
> 	guard(cpus_read_lock)()
> 	tmigr_isolated_exclude_cpumask(cpumask)
> 		guard(cpus_read_lock)()
>
Good catch. I haven't set up "isolcpus" in my test environment. That is 
why this lockdep splat didn't get triggered. I will fix that in the next 
version.

Cheers,
Longman


