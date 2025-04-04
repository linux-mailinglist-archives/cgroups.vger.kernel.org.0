Return-Path: <cgroups+bounces-7364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60CEA7C357
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0541771D2
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA321C9F9;
	Fri,  4 Apr 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcaHfCpm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCF1A5B8E
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792944; cv=none; b=FN9qg5BNAJ6I1emDpMeiTlZR9RiM2hN6d6M8UdxAGkEfpgqz8KckZFxoDdV3ZOfNbETI/ztfhM52R0uoKHfyEgDYZdoN3IuTwITeFT//GCvCTlgQxmzCxfrkqjtZCuO2JYXFUQpO5N0RNELerLIvwp7FW2VfPV63kI6H87MRuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792944; c=relaxed/simple;
	bh=XnDhVT1x83AsNY8OZJgr6vEU6u45rQkuQM30F7imBpU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t4zvPJ87jdBtAragv4UrbEL1ywal6uNC2S6mR/o4BAJLmlDFYn+QtPstRQ3AJnU0r8nMT2vmmxwjvE0ES6Vb4voHfLjnrrncCkCenBsk+B0f/a3+vJ51Eyv+XTwur26gw/KlgQNUMmbBoEEiVnLN73IlY2rKfypeQw/OV5AyK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcaHfCpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743792940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJ+WDACAsHxbVWot9DqTlvwAc/91z/vLEjznERJRGEA=;
	b=EcaHfCpmFRW57KFFtB7wsZusXmA3yW20Jf7FxtP/5VkugWq9ZuqoyUSTt0Cl8EKt8JOJfT
	DnWXVPCIxUhGrQqhknzPBRqEjc+XQlrrvh8oCNgRB6frYYothLf7+Xa8h2OL+6zs3LrbQ/
	xzfBayviSAIGa5UtYcn7nuD6l4aJ7QI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-KYmO-sIiPZ2OF9JIC2tF2A-1; Fri, 04 Apr 2025 14:55:38 -0400
X-MC-Unique: KYmO-sIiPZ2OF9JIC2tF2A-1
X-Mimecast-MFC-AGG-ID: KYmO-sIiPZ2OF9JIC2tF2A_1743792937
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0c1025adbso463947185a.1
        for <cgroups@vger.kernel.org>; Fri, 04 Apr 2025 11:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743792937; x=1744397737;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ+WDACAsHxbVWot9DqTlvwAc/91z/vLEjznERJRGEA=;
        b=jVqgbTVR5xm+d+siVhf7+XXmEEMCTtWsUQWiKK+R5w0yETRmHAcD+sQWeFuOk7JLiG
         HHKYLlemVrfppj4j7XOf+JOUkxC+5TVX4mZGnFrSjIP8zx1DNE4jdeYgOvLRHCw0SupB
         JoxdosV6r3T3hwx7YxBmnvJnlJDhiPbxYU4R6B3V1vpiOD7xrg94zMZ/D7nO93UQYtTR
         iSnqSxfcXNM5BQn+Hb/nO3tEH0gwpeAZYtYyRmAPKAqccHZ8At/ZDPMA6MVjIQ5a3Wkq
         KpPec7glguHzDfau1qYELQDxioRdy1To+U56/EBnFRQYj3aQkPxJ8R6bEx6i799WDy/8
         mRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgUS7IOIldWED/bKJeRKosRjtWPJExflX2ztbvU09UT+hCfWVmuKNhmx33/5vShAwTgkyVx+bj@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4AJwhTvARtKmV2l5tvrbaMCQXQgH7vSKVpnS3EN5SSVQGbiD
	VMJ+zrulefFVe+PqcY1uGlMvlS0VURVMI6qOKNyXqw860P3B5vr5SpI2geoio3EsPBOoofm1DTi
	mhb9qMEEQDw+jGCQfX/s3i9gD5zQtyk78GKuEl/Qv7h5CUwMssR0vdl8=
X-Gm-Gg: ASbGncuBw37MeQTNOoWzuZO3f1aampwru4pMuWpYrnDScez7v7A/r92DKnQgByFIvvn
	KMZbA+aAk3aKnovf79GAFFJr8RoqA/S6IlnzWOWvBMRgRjy4DqDsG/lG7d8tt9aJq6WzJcSOo17
	SPWkMlarT/ST30C946J1iQVw6kugw+M2acZepJe1Td+HMJGmGkXTjNcFzWj7s7n/R9CIh/JbQiB
	SwTRDjO2d953FSBES9m2OUTPR56bPm88O0Dzxhc9vALgFxNNOWDE7b8lzobVxzkZYKlwovwC/+u
	zmf4TS8KcxuHFV8DOzs1qbiyvBafI2cEyFTZU+6qodkCnOLk2frclNKIuapO8g==
X-Received: by 2002:a05:620a:d93:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c774d6fcd5mr576731085a.26.1743792937391;
        Fri, 04 Apr 2025 11:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1GWz7ZoZU1D4Cwc3QUuGir5Wj6Kdn7kWMfIbYb7f8OvFkQTHaKFBY0OhVoifakryu8wvgkg==
X-Received: by 2002:a05:620a:d93:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c774d6fcd5mr576727485a.26.1743792936962;
        Fri, 04 Apr 2025 11:55:36 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f1393fdsm24772476d6.89.2025.04.04.11.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 11:55:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
Date: Fri, 4 Apr 2025 14:55:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250404181308.GA300138@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/25 2:13 PM, Johannes Weiner wrote:
> On Fri, Apr 04, 2025 at 01:25:33PM -0400, Waiman Long wrote:
>> On 4/4/25 1:12 PM, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
>>> ...
>>>> The simple and naive fix of changing the operator to ">", however,
>>>> changes the memory reclaim behavior which can lead to other failures
>>>> as low events are needed to facilitate memory reclaim.  So we can't do
>>>> that without some relatively riskier changes in memory reclaim.
>>> I'm doubtful using ">" would change reclaim behavior in a meaningful way and
>>> that'd be more straightforward. What do mm people think?
> The knob documentation uses "within low" and "above low" to
> distinguish whether you are protected or not, so at least from a code
> clarity pov, >= makes more sense to me: if your protection is N and
> you use exactly N, you're considered protected.
>
> That also means that by definition an empty cgroup is protected. It's
> not in excess of its protection. The test result isn't wrong.
>
> The real weirdness is issuing a "low reclaim" event when no reclaim is
> going to happen*.
>
> The patch effectively special cases "empty means in excess" to avoid
> the event and fall through to reclaim, which then does nothing as a
> result of its own scan target calculations. That seems convoluted.
>
> Why not skip empty cgroups before running inapplicable checks?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b620d74b0f66..260ab238ec22 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5963,6 +5963,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>   
>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>   
> +		if (!mem_cgroup_usage(memcg, false))
> +			continue;
> +
>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
>   			/*
>   			 * Hard protection.
Yes, that should take care of the memcg with no task case.
>
>> I haven't looked deeply into why that is the case, but
>> test_memcg_low/min tests had other failures when I made this change.
> It surprises me as well that it makes any practical difference.

I looked at it again and failure is the same expected memory.current 
check in test_memcontrol. If I remove the equal sign, I got errors like:

values_close: child 0 = 8339456, 29MB = 30408704
failed with err = 21
not ok 1 test_memcg_min

So the test is expecting memory.current to have around 29MB, but it got 
a lot less (~8MB) in this case. Before removing the equality sign, I 
usually got about 25 MB and above for child 0. That is a pretty big 
change in behavior, so I didn't make it.

>
> * Waiman points out that the weirdness is seeing low events without
>    having a low configured. Eh, this isn't really true with recursive
>    propagation; you may or may not have an elow depending on parental
>    configuration and sibling behavior.
>
Do you mind if we just don't update the low event count if low isn't 
set, but leave the rest the same like

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 91721c8862c3..48a8bfa7d337 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct 
mem_cgro>
  static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
                                         struct mem_cgroup *memcg)
  {
+       unsigned long elow;
+
         if (mem_cgroup_unprotected(target, memcg))
                 return false;

-       return READ_ONCE(memcg->memory.elow) >=
-               page_counter_read(&memcg->memory);
+       elow = READ_ONCE(memcg->memory.elow);
+       return elow && (page_counter_read(&memcg->memory) <= elow);
  }

  static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
                                         struct mem_cgroup *memcg)
  {
+       unsigned long emin;
+
         if (mem_cgroup_unprotected(target, memcg))
                 return false;

-       return READ_ONCE(memcg->memory.emin) >=
-               page_counter_read(&memcg->memory);
+       emin = READ_ONCE(memcg->memory.emin);
+       return emin && (page_counter_read(&memcg->memory) <= emin);
  }

  void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup 
*memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 77d015d5db0c..e8c1838c7962 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4827,7 +4827,8 @@ static int shrink_one(struct lruvec *lruvec, 
struct scan_>
                 if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
                         return MEMCG_LRU_TAIL;

-               memcg_memory_event(memcg, MEMCG_LOW);
+               if (memcg->memory.low)
+                       memcg_memory_event(memcg, MEMCG_LOW);
         }

         success = try_to_shrink_lruvec(lruvec, sc);
@@ -5902,6 +5903,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
struct s>

                 mem_cgroup_calculate_protection(target_memcg, memcg);

+               if (!mem_cgroup_usage(memcg, false))
+                       continue;
+
                 if (mem_cgroup_below_min(target_memcg, memcg)) {
                         /*
                          * Hard protection.
@@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
struct s>
                                 sc->memcg_low_skipped = 1;
                                 continue;
                         }
-                       memcg_memory_event(memcg, MEMCG_LOW);
+                       if (memcg->memory.low)
+                               memcg_memory_event(memcg, MEMCG_LOW);
                 }

                 reclaimed = sc->nr_reclaimed;

Cheers,
Longman


