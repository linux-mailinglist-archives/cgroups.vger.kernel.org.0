Return-Path: <cgroups+bounces-14159-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HuXMG6JnGlWJQQAu9opvQ
	(envelope-from <cgroups+bounces-14159-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 18:07:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85E17A5A0
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3573021E53
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98875328B63;
	Mon, 23 Feb 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J5oqhCaU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A5328B53
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866260; cv=none; b=KzMk9oTSqU9xl6u2ENd0m7xaCbhn0lcUXhvAbJVunz+1J9dE4f8dIyzX12IrQDZcX1XvLKph7zAWkfHJ9/KsDjxADXxmljndnmsbTDeGDwK9h8HvX67KjrJrbnAxWgjCYq16TppOZjA5WbsQdzQEOahxYZOQZUdmQHz4dc5JT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866260; c=relaxed/simple;
	bh=zRsKOJNOtZ32gDL5xBo/zPbKCRNyopfMz3fDVOLI8XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViYZ/Ad5To9TBXzdYo2QIHQXiLtcsdCAGoOURKTzomGP1jtNf/uwQW59sRPGUqy72QMTrSPynwyfU2ict7vbwpg4Rpb2EG3nBe4VhkLhkB1vrb+UQUem1H3cHJMDUZ2ATJEdvZeNenxBreZIFK38lsOGbUhbdb667eYvmHgH8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J5oqhCaU; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48371104ffdso6559385e9.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771866257; x=1772471057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3hVv3QCLGsJuEhotPXR1ko5+3s1oxPI+IoPnj0WO/I=;
        b=J5oqhCaUNDmHzqngZWnWV7SLsZmeg4E5RFZRZ7gIflMjncsH8YYXvj1UCgHEaJ2AOm
         NUfs2uVf5/PXk7b9BeoL0CRWiWOp5lQxR249VSXvk2Q6zfHNnvDT13tjY19jA8V+F6CB
         IqcHOZKiEyMvVd9ytJDRyMpt9d6NiFdIjAlSsapRoYX+5lyF8a/bYmwRAeRIMZV8L7SO
         Gdq48c/nOYqg8MLQjKEliEyzET4u9C4K7lHOmXK/7PEB/R6af/sBERCsgNjYqI1D5rIG
         ItuWC6eMwhTBrHER3OPqNIkEI5LzeOjmUFcTLyodtqfAjWl3CpWKTxctosUHfYaC2lcM
         yvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866257; x=1772471057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3hVv3QCLGsJuEhotPXR1ko5+3s1oxPI+IoPnj0WO/I=;
        b=REbGVfWX0MK9yg5HUFrvg/Fsgczr/Rdx6a6nxZieZ7I1lothDzdnQOuK8s8HbcFBfd
         PsSh8OnOKLQ3ekLpTPFiEHYyFtB88vCP3jmcsYKgEaM18JETLbCqSyvCllQu2qilo7Ef
         9EtsM7dlBjd0aZb1VkvEl5u9qm4HDza7tGAfxAdEl7jo/Nn2JrkVapggzcO29aTdCl4N
         hdix3rA4JBxfiegYG1cmr922q3HEPT2Roc2wbE6MYyrXDKkIvxG6ljo+rH2GXSk8ylMe
         YGwYTcO9KrtmnZUQTGKjwVeSBxXc7OK6rzAs6I9psKp/Ok+yc7r4UNWh2YEZ8TO7iady
         ilBw==
X-Forwarded-Encrypted: i=1; AJvYcCUdhr3BTbRiuwwUy3m1Ok00wKHK31nXOEa6GCk4m3gyE7IsGaAFHZfxxfpEm/z53zE7cLsl8YJW@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfRpQWbUpCPFOoKqtiHoOu4/Qic+YBif0wXmmBoMQeSKpOEV3
	FFaiPbshyT3j1sGhAA6SXYJF131qtidMIHyG97wKERZDASMA0Ox0BZfkoLmrkFY5w6g=
X-Gm-Gg: AZuq6aK/ty0+KOddXJvh+PlEmH/voUrUchdF1EfxeQ5T5HTa7t5jV9hklu+Kubki1cQ
	OCtCUv+bcU/tSPOw0QWyy6o0NexGeuMGUU1hEImlMCm5ZhZ1Hq1/inMC24Jh3Pws54KlbMgaUeS
	y6/5CxiB+oE4UGsbVWhOef8+iCM9PgK0F1VkKRyIyBRGK/hNs+bX+3WrfEvaspjq5EtqRuy4c64
	FFZqGOZZcPSOv2uF026GLR+qXuGtELn4hRM1F9G33QHGzI/eXxNJi3E0Ac80nuz+DQEa86ITjU8
	SCw5nA8SlzyV2RcL19L2cHycd/HW/MqdixRaVrU9s0l6/mL/Pg3fcTTrbCSTygOjnpT+q3wImIQ
	Xs0Kwe9ekRa+bDjFCAtRvBH5RF3Nab65G9gXQRfbSfOeuWGBZICkouMseMRjwGOMFOtTrJ7DdjO
	7l8mj/XKxtYRZbtogoIw==
X-Received: by 2002:a05:600c:8b12:b0:483:8f10:4bc5 with SMTP id 5b1f17b1804b1-483a962e47bmr82220545e9.4.1771866257122;
        Mon, 23 Feb 2026 09:04:17 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c0779sm440631645e9.6.2026.02.23.09.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:04:16 -0800 (PST)
Message-ID: <a0c9449a-26be-4afa-bef8-4b78315fc6d1@suse.com>
Date: Mon, 23 Feb 2026 18:04:15 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260223075809.19265-1-harry.yoo@oracle.com>
 <aZw9sIb5yyhwZKek@hyeyoo>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <aZw9sIb5yyhwZKek@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14159-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 2C85E17A5A0
X-Rspamd-Action: no action

On 2/23/26 12:44, Harry Yoo wrote:
> On Mon, Feb 23, 2026 at 04:58:09PM +0900, Harry Yoo wrote:
>> When alloc_slab_obj_exts() is called later in time (instead of at slab
>> allocation & initialization step), slab->stride and slab->obj_exts are
>> set when the slab is already accessible by multiple CPUs.
>> 
>> The current implementation does not enforce memory ordering between
>> slab->stride and slab->obj_exts. However, for correctness, slab->stride
>> must be visible before slab->obj_exts, otherwise concurrent readers
>> may observe slab->obj_exts as non-zero while stride is still stale,
>> leading to incorrect reference counting of object cgroups.
>> 
>> There has been a bug report [1] that showed symptoms of incorrect
>> reference counting of object cgroups, which could be triggered by
>> this memory ordering issue.
>> 
>> Fix this by unconditionally initializing slab->stride in
>> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
>> In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.
>> 
>> This ensures stride is set before the slab becomes visible to
>> other CPUs via the per-node partial slab list (protected by spinlock
>> with acquire/release semantics), preventing them from observing
>> inconsistent stride value.
>> 
>> Thanks to Shakeel Butt for pointing out this issue [2].
>> 
>> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
>> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [2]
>> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
> 
> Vlastimil, could you please update the changelog when applying this
> to the tree? I think this also explains [3] (thanks for raising it
> off-list, Vlastimil!):

Done, thanks! Added to slab/for-next-fixes

> When alloc_slab_obj_exts() is called later (instead of during slab
> allocation and initialization), slab->stride and slab->obj_exts are
> updated after the slab is already accessible by multiple CPUs.
> 
> The current implementation does not enforce memory ordering between
> slab->stride and slab->obj_exts. For correctness, slab->stride must be
> visible before slab->obj_exts. Otherwise, concurrent readers may observe
> slab->obj_exts as non-zero while stride is still stale.
> 
> With stale slab->stride, slab_obj_ext() could return the wrong obj_ext.
> This could cause two problems:
> 
>   - obj_cgroup_put() is called on the wrong objcg, leading to
>     a use-after-free due to incorrect reference counting [1] by
>     decrementing the reference count more than it was incremented.
> 
>   - refill_obj_stock() is called on the wrong objcg, leading to
>     a page_counter overflow [2] by uncharging more memory than charged.
> 
> Fix this by unconditionally initializing slab->stride in
> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
> In the case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the function.
> 
> This ensures updates to slab->stride become visible before the slab
> can be accessed by other CPUs via the per-node partial slab list
> (protected by spinlock with acquire/release semantics).
> 
> Thanks to Shakeel Butt for pointing out this issue [3].
> 
> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [3]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>





