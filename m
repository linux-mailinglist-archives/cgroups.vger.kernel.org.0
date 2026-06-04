Return-Path: <cgroups+bounces-16640-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n20pBPB4IWpCHAEAu9opvQ
	(envelope-from <cgroups+bounces-16640-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 15:09:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4415640314
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 15:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J1ts5vak;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16640-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16640-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFE2430A6EA5
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B647DD56;
	Thu,  4 Jun 2026 13:06:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEA374739
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 13:06:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578417; cv=none; b=fLhGH5tkIvXXWlPPd4P6oRgweG8zouwK1/NskGchVh4vc2zcro24Lt8x5A3dyfbzZ1HbIBJJh5w1PqBc26/a5Vnt+nDJ2mW0MV085QlEjZURsjewVLndqseYsaKOPf8jwZCfEil7I0yBRwleTnm49BH7NM8c+NArURhD8j/nclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578417; c=relaxed/simple;
	bh=wRbCF69wlx67VwicjostQ42SihvIU2JiEg8O7U3Nwyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZ16/NFHFkmzbAMzYAOP7uN5LORAS5ltolao990GPwxrLoDiqbRxBuOkUawuYiBVLYuYI2S+M4FnEaI2ZmBfSLtKShUz7bj5YgnzuBSTJv8SfwfWgDs6zO4q3VMdWFOPcRaV5VI72+L529TKFTEJFkLfwXIz7uwtlXxuGUstenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1ts5vak; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so450632a91.3
        for <cgroups@vger.kernel.org>; Thu, 04 Jun 2026 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780578415; x=1781183215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/V6RPepsyqoQUt2D3lkrhZmC+vMiyf2WaK9hrkxCm4=;
        b=J1ts5vakIYSwW7lGar4RSiIYRA6yKQkJvTCaeGuiFHGWM235fn8ul3kNp/CpYx+Vh3
         DTNsJxgCvd7ub8MJAHC8884ys5ZSTzxbq/hv7RJTHMwPxNg3WlIsFjaw327KeykrL2+A
         Rq3tNntFtFR1ZFS5HaU+h8TvooTvkW0Y9jsYAcmiV2Fjb1mxM1XOesRCd/OW+dojaUne
         9MsTGgUiY5A6sEyRsprLph4EV8E9KEdmsSO/HwgdtyPo8Nqg4mR8V5D2tbsAq6fHFKH0
         uFTZnORdn3VMa+oFkPbfIqduKHf2yk5gFN83wjDV3cQpBXHhvN9QkTiH9xPD0gydXTQw
         w84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578415; x=1781183215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/V6RPepsyqoQUt2D3lkrhZmC+vMiyf2WaK9hrkxCm4=;
        b=fUm/Cbitgs9HMJIVgo1nKOftNR3VoUjw1E6h7al8Ga4ZGyPZOmEsc7Oq5m4H5YenJb
         85MqSfcYRSDgjMzOaLtmhPU5Dey096l+oMMlfRQSYg1+nSiQQb64vdBFMAiMr98igq++
         RDiVM3mV2FXFygeGO3oOJ9HJHJr5QnhtZnSbAVTDnQyKTRnEgsEnxtyVGLa7hzKJB3Ez
         +zeR12kfkCIv8d0xzy6GCQS6DsyFyhBNleP3fQ2BYYOtdML3roOzRry9FkCrLEHguNWf
         OGnW0G7Abvi53/1IFxQhzxmO4sRPnbgCejMCu95ayl2acUpf+RbYTYzY67XQMkjC3RKE
         FCgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rPdHpmdtJ7/DtGPBC7WblWJQ4lgEJG+JgM0RiANgW87vTM6a7ZOOyOM9wtWwUoEFAfuV4WEIA@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyTmGhx65dHF7UjBwPI+GipKhMm67KESzuWIlKDzTsSzfi3R1
	ij05m6YWj1Q7pGrfPeUo6YMBKhHg0+R/Pc6Uya0u8nbu5AJtQ7pgXApj
X-Gm-Gg: Acq92OEepw3+6xzT8z8d8HseMVucMEs0UQw5HehdQm/Rvf181ptF0IfBlWFCMUKlm+m
	f5P/G0kq+3aH366Np9YM/9GO3hc2+soLC+TQ3ZKMUBvwthgo/xe4rsBL7fQBejLCWauUvsWmTnO
	JM5Q7QYfRLIknw8VJ7t44Ew8LlmcT9lpDpPhjp6gK2dfwi5qgew/b8mzmOJk0uE2k5r4gOxIFLw
	tQ2gi33SIpu2U2PRLmdNOOvalU/LQJlxy5qlt3RsI4OukCMZEHiXKp4b/Kw5ICUsoAlP+IELY/E
	iwRkMy1Je34lqgLtrbrRFCJiaXiT3eMcjRARqWj5TuXM2zMqr7JLXoKTKzXC+2xkBoveFndaW2v
	NXKZ+Loo78jqDzXqlzTRVjyOqLMSQPM509fWHB1S8IBIhPPKgTmLaMsVTNfybd+oaL/Dh2y3+7I
	L52Q04uGTjX6IfGD5vvkJCDwn2eou2x5dkvhGFzlHRTPO9O/SXUkDZLA==
X-Received: by 2002:a17:90b:2d8d:b0:36d:ae6a:22fe with SMTP id 98e67ed59e1d1-36e32288dc4mr8152975a91.16.1780578415000;
        Thu, 04 Jun 2026 06:06:55 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf8284dsm3942710a91.4.2026.06.04.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:06:54 -0700 (PDT)
Message-ID: <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
Date: Thu, 4 Jun 2026 21:06:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
 <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
 <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16640-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4415640314



On 2026/6/4 13:34, Yosry Ahmed wrote:
>>>> For instance, suppose a parent memcg has two children, memcg1 and memcg2,
>>>> each with 200MB of zswap (100MB inactive). Triggering proactive writeback on
>>>> the parent memcg will exhaust memcg1's inactive zswap pages. After that,
>>>> even though memcg2 still has plenty of inactive zswap pages, it will
>>>> continue to write back memcg1's active zswap pages. Writing back active
>>>> zswap pages causes the user-space agent to prematurely abort the writeback
>>>> because it detects that certain memcg metrics have exceeded predefined
>>>> thresholds.
>>>
>>> This will only happen if the reclaim size is smaller than the batch
>>> size, right? Otherwise the kernel should reclaim more or less equally
>>> from both memcgs?
>>>
>>
>> I gave it some thought. Not using a cursor could lead to unfairness
>> issues with certain writeback sizes:
>>
>>    - If the writeback size is an odd multiple of WB_BATCH (e.g.,
>> triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the
>> writeback ratio might end up being 2:1.
>>    - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is
>> triggered, it might repeatedly write back from only the first 2 child
>> cgroups.
>>
>> Although setting a smaller WB_BATCH might mitigate this unfairness, it
>> could hurt writeback efficiency. Let's just use per-memcg cursors to
>> completely fix these corner cases.
> 
> Exactly, the batch size should be small enough that any unfairness is
> not a problem. I would honestly just do batching without a per-memcg
> cursor, unless we have numbers to prove that the efficiency is
> affected when we use a small batch size. Let's only introduce
> complexity when needed please.


If you prefer not to use per-cgroup cursors, do we still need to keep 
the global cursor (i.e., the root cgroup's cursor) zswap_next_shrink?
I found this part to be quite tricky when trying to reuse the main logic 
of shrink_worker() in zswap_proactive_writeback().

Of course, I think we could also keep zswap_next_shrink and write a 
small helper to check if it's the root cgroup, allowing us to use 
different memcg iteration methods.


Thanks，
Hao

