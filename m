Return-Path: <cgroups+bounces-17667-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jUnNDeb1UmrsVgMAu9opvQ
	(envelope-from <cgroups+bounces-17667-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 04:03:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE987437A8
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 04:03:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lWmuiV2p;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17667-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17667-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F1030166F5
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 02:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E1346A0B;
	Sun, 12 Jul 2026 02:03:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E319A2A3
	for <cgroups@vger.kernel.org>; Sun, 12 Jul 2026 02:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783821794; cv=none; b=reh0L4boVUjsvd35iUGQOtKejbEfCLaqO7kEuXL2zCSxARC5jsCnEDDFCmW1KwPbeah24BQkw7HHKRj5Wy1har0J+DssHy+kSbbNGVbAZARSU9YLPnk5IEgLPSGbhfLM5gULirJzt8eCQ0khSvS1F0hUyWWGuSmtCyhHx9H7WlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783821794; c=relaxed/simple;
	bh=gIrRZGFvpVg+UI8MnfnRXQS4xGe7DQbe0oX3Iu9S+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfOwN9pWKtek92UHJyCh1ezrQ72WnpLLF1ktGX/t2xdUltHDzcwbPMYMwvWReM0eVtbcd8EAvAPV5H9/L57peNiQ/YloS2Wziw0auA4mXYzZ07iFodEUnBITndWY5+rqu/sU3/8lteTwUswvLKVPRIrxaeKT8N9A34s2Ob2jzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWmuiV2p; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caa0551d8bso7131695ad.2
        for <cgroups@vger.kernel.org>; Sat, 11 Jul 2026 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783821793; x=1784426593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8AEc8nE6deo8T6dPEpOX1aaF1DO5pjrQkwlE8uC4Jqs=;
        b=lWmuiV2pB6MX4xElQoR1oE2nG9A7+QSFnoIxcL6oCahmMMVRL3E0O+swaI7AcMai3D
         sfaZCFbWEVpg/f2ytekAfQCzzFP6+JHDdN2i3rVuguCpECzISXiWhGMop8vKUNj5KaI9
         UWItKKuN+rYQ/IG0aWXmmvLanLyhTh0PMPKThPOLJc2YrljvH0Hkdq4ZHU8J5OAkLcZR
         GYCZf6F29xSu8ITWSuG8YDKpxAZgRHV27aJkR0abOu252Sfredd0zG8iTkHfb38ZKXvq
         ibMPbF5jbuyiLPKlkeHKBjWps5F6qD/knGgSq3GNmoa8FNt3mL5ab+SxDQYsdTpj2ZCR
         pz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783821793; x=1784426593;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8AEc8nE6deo8T6dPEpOX1aaF1DO5pjrQkwlE8uC4Jqs=;
        b=se8zVILOxP927NBe8J3Ya3GLwCLUpjebdzsOcrJ23r4P+/Rn36jeLZu2kMtgb+3PGg
         1rujWxeKwr5V5YL0PFpvWBszTT4ThEMNhPBhjVmPcmeAK6rIhA1D2VVkTJmiGs6isndV
         663lTcYYq/OLUTSytw2mdaWixxgYpNjKEeBFHD4wzjgeQHQFoIyrdeR2cdFfmFgNkOPB
         zA78u++CCOM6FjpdmymhmkYIb7cAOPnoLD6BSBAtQxsMJpMl9DH6J6kR2yq8iHZ8pZCe
         D4Ks5KyLti38zDOUEOicN5AJAF+GH6q4nkZCF7WgLCouNgIuw6sPgv7y8VcpY5NEvCF+
         rhUg==
X-Forwarded-Encrypted: i=1; AHgh+RoI/KbViHDiQvh0Dj0FqaYP7wIbxyiKx14yHMR6GbzW0lgzoNfSTbYdAxhgu0Ia4Xm7h9mtvrr5@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+kwpZq5tliG6CWoGqwgw8mZpx026Aw2dR/5EqsWlifgT/dAy
	bTTVqKeiDVq8u+JsqmylUH30kE6vRzyp1bDLb1zrToasgRDlbz7j+HaC
X-Gm-Gg: AfdE7ckHpIgiPS52ZYEIJuuK+qPafFHzqPI6t4k90bqQ7/AzcRLYUO/KwGu6RJGodax
	01WOatEpLWvVShgvBxJwWeDprj+L7SfKOGlsCpp13u6sxTzxrG1uvN0BRyO14ZXcpUVs2xFYl+J
	jGVDN+XGOIZTRpvoCL7+MzoatjRWjUzS1d0773iEzrt9P7Gq2CfJMTgWXpRr/Rx7ezgTjiTaLV5
	0WbcqjpnCnDR5SogTUVZjcgUrJvsApRCqD4mTK4aXOHKoC/EakZO6STjG8AnU+kYxLG2S2/nrqx
	Qo4eo9BpHgQ9FQm+DBGCNT+shfZaPoziEexg4KS01MGRGTKLBaZEZIvI4pWu4pYgOIl+iwXRtn0
	41G+ftgDu/xG956i+cH8ZslbAE/bUtqBdnyn8UKcWnhmpl4l+CVoaVQ3shqLxAmEXR0zYYAeS2n
	LRWP6NPS0JmHPCNrFEv47Sk6wzeEF3su7AkpxKZPe1v54OPTcYv90qs+ZylJMfoxFFJTUA0Ha7D
	sZd
X-Received: by 2002:a17:902:ebc8:b0:2cc:9d9:b8df with SMTP id d9443c01a7336-2ce9f187200mr35725535ad.5.1783821792749;
        Sat, 11 Jul 2026 19:03:12 -0700 (PDT)
Received: from debian.lan ([60.177.121.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm80691555ad.15.2026.07.11.19.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:03:12 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: xueyuan.chen21@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	baohua@kernel.org,
	zhaonanzhe@xiaomi.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com
Subject: Re: [RFC PATCH v2 3/3] mm/vmscan: avoid pointless large folio splits without swap
Date: Sun, 12 Jul 2026 10:03:03 +0800
Message-ID: <20260712020303.326384-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7ec7533f-e1dc-4236-99cc-6848d651976e@linux.alibaba.com>
References: <7ec7533f-e1dc-4236-99cc-6848d651976e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kvack.org,vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,redhat.com,lge.com,infradead.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17667-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:baolin.wang@linux.alibaba.com,m:xueyuan.chen21@gmail.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EE987437A8


On Fri, Jul 10, 2026 at 03:21:44PM +0800, Baolin Wang wrote:
>
>
>On 7/9/26 10:51 PM, Xueyuan Chen wrote:
>> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
>> 
>> When swap is disabled, exhausted, or unavailable due to memcg swap
>> limits, splitting a large anonymous folio cannot make swapout progress.
>> The fallback only destroys the large folio and inflates split statistics.
>> 
>> Use -E2BIG from folio_alloc_swap() as the explicit signal that splitting
>> the folio might allow swapout of smaller pieces. For other allocation
>> failures, keep the existing activation path and avoid the split.
>> 
>> This preserves the split fallback for fragmented or partially available
>> swap, while avoiding it when there is no backing space for any part of the
>> folio.
>> 
>> Reported-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
>> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
>> ---
>>   mm/vmscan.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index bd1b1aa12581..40340a88f78e 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1260,6 +1260,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   		 */
>>   		if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>>   				!folio_test_swapcache(folio)) {
>> +			int ret;
>> +
>>   			if (!(sc->gfp_mask & __GFP_IO))
>>   				goto keep_locked;
>>   			if (folio_maybe_dma_pinned(folio))
>> @@ -1278,10 +1280,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   				    split_folio_to_list(folio, folio_list))
>>   					goto activate_locked;
>>   			}
>> -			if (folio_alloc_swap(folio)) {
>> +			ret = folio_alloc_swap(folio);
>> +			if (ret) {
>>   				int __maybe_unused order = folio_order(folio);
>>   
>> -				if (!folio_test_large(folio))
>> +				if (!folio_test_large(folio) || ret != -E2BIG)
>>   					goto activate_locked_split;
>
>Like I said in v1 [1], please apply the same change to shmem swap as well.
>
>[1] 
>https://lore.kernel.org/all/6e89f868-ca7a-484f-aeea-5d8d029714f2@linux.alibaba.com/
>

Hi Baolin,

Thanks for pointing this out, and sorry for missing your v1 comment.

I'll apply the same folio_alloc_swap() error handling to the shmem swap
path in the next version.

Thanks,
Xueyuan


