Return-Path: <cgroups+bounces-15939-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGSXNTCGBWqiXwIAu9opvQ
	(envelope-from <cgroups+bounces-15939-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 10:22:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D304A53F35C
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF657301B4DF
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3883D6CBE;
	Thu, 14 May 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOfz7pAZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5893A75A9
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746920; cv=none; b=WxPNNcKXDP4v4YXnwVUUDnIL9peiXEgweVlsHZeOU0wq2GvSbcHG9Vp26qKiTJMfW26oYNc/VRnUx1eEeCPWuEi1Jg3ITIt0Qodl1+FPra2HG67VxMNQKLRSMDWkqjYT0AInJNAPNcj5Gft/bdVdLQtQkqDUYqgCI+lnOdp/Rn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746920; c=relaxed/simple;
	bh=07Y/lkJkc1NqyJU8Q9kOlXnWNjntrNfFsId/nM9O38s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IipadTI7MRcZwdtEu7BIsSexYA6Lho9BbRbBw9ETz//ed3M6a40JOfiejIxRP/mSX+ZN6sqDQpBlxlpJ/DRdyGwXTvUBlLXOFJQHq/JMgK06eYdruK3SNeupJWhWwvNua213LduOUGbAtMtqk9gCBncgtkp8E7wpCvnCh0zIdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOfz7pAZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so4007633b3a.1
        for <cgroups@vger.kernel.org>; Thu, 14 May 2026 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746919; x=1779351719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYXEDQETkSsL5D7C5JReu+GaAzOCViwf5QXVSoBOuE0=;
        b=nOfz7pAZCrokzB1f5KihG8/R+Gx7t3Yi2Enqsqm6vFey4AXggvt+/l/8OM/bn1Xcq/
         jWadVBRW6mEoTkOG/IlM4KqJtDI04q+CSIBT28tvn2HrAtOKKZcp/dy6mbCjqy8OwR+w
         mmJWu4rLvVj2siBNJvjW9X7ms/MxT5R0VXU2yICwjIID75boOPqdIGkeymEbjzmayn+5
         e1qglovgiXtdhmZDuxCUXHa/zrWPnlFpGJ1cQhc9cW2q6v0NGhieBrS9WIvZXtkSrM1V
         4Qqb2YwfbuDZ1uXccHRoMkPs5N25a7cw4PTZKmMrC7TXOPrpoWg6ZUWAwhF6okxd7FbV
         fMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746919; x=1779351719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYXEDQETkSsL5D7C5JReu+GaAzOCViwf5QXVSoBOuE0=;
        b=qwVieKN+3kQeSHNIXBVyXcwXSVlMVOmEKptZfU1UkgLIJAGMjG5wbWYFa7uIvbbLgb
         DdT+ARsSsqDk+cHW1gLBoj6zhlhqg8jbbmKTmNmHwsTNZ3dUOjLLx1G2Q2j2pMRZEdNr
         NUpIYI3TRtNA0rEHlAAZ2A6sw4SmySw5mdnmCpeiDnPTV5+BOmnWXtBwO/ycAEbL9lM4
         RmCMwbb9Xe2TSVU6nBkjY4Xm0gnDmWAzubSrwjM50RXbrJskmlKnYh8rjohldliAOm89
         /o6WJxr9ezXRMnvTnnKULJ0Wz0GekhXBjZ9xwzwyjzV/ejpjey00vZS6f6BAo0GBbWR6
         LOrg==
X-Forwarded-Encrypted: i=1; AFNElJ8V1c61Ow+DA2bG0np3BFcOnfkY8PCWED6XXlb4bt9638YLSyftuq4HM71xxPtxVTfBrtOyWETQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoj41XVwbHaQj0fXGHQo3+Q5PkN/wwBjl5P+/HS+B9i1cNU7PC
	mgODhKLdEwHtmYn/YJYnapeWz2P4NySl7ktY9XW4+KO/5DUnW2XzHzes
X-Gm-Gg: Acq92OGWroQC3V6muC/4i4a+SUBD+98n4QHyuKy5zaGiLTUtR31ZoOJVAgiLd83RHga
	TItTrDGTGdkBezf3uI9qKn6sG6j+X0tgC1vuk6NMrXBMgSwx0PxEUgJJqcPXirtQaPKQljMAI5j
	l610EFy2u92eXJFwBZx0vHd67Koq7niK8/ZnnWMf8H9rAgxwWrn+sNVSVYIzf9VUslLGEIRbBYM
	8z7+3b13wY267DgJmlOjOYrwktcugyodp0Sn5EccqcMRCxPvm7ScAbd3MzYlfPie1FSw10cZE79
	DufMk40zQZrOUyriWlttuD4VBsD/rylysZ6h2dCcpGXrMB4aQGpwj7ELzjarV6PX1Kj4IMscalY
	Q+Lplro/lEZk/5eZJ71HDyWwT06RjSCoB43S+sFXxabn9FCsA8NCw1CMHtMdSMfAR/2i0Gecjm4
	sPP2KI+6LoBJZHglTFILmm+5wWk2gW1jbIcbuNDqeeeMJKbJBTsSBQ6Q==
X-Received: by 2002:a05:6a00:10cf:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-83f18e6700dmr2504897b3a.18.1778746918343;
        Thu, 14 May 2026 01:21:58 -0700 (PDT)
Received: from [10.125.192.65] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977a570sm1804344b3a.20.2026.05.14.01.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:21:57 -0700 (PDT)
Message-ID: <59a55147-b2c6-c5ff-64ae-07da4792958a@gmail.com>
Date: Thu, 14 May 2026 16:21:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] mm/zswap: Add per-memcg stat for proactive writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-4-jiahao.kernel@gmail.com>
 <CAKEwX=OigngmcNo1OU-apCFG2hebt5yZwXQxZQHqgC7SwH_HAQ@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=OigngmcNo1OU-apCFG2hebt5yZwXQxZQHqgC7SwH_HAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D304A53F35C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15939-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email]
X-Rspamd-Action: no action



On 2026/5/14 05:21, Nhat Pham wrote:
> On Mon, May 11, 2026 at 3:52 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Currently, zswap writeback can be triggered by either the pool limit
>> being hit or by the proactive writeback mechanism. However, the
>> existing 'zswpwb' metric in memory.stat and /proc/vmstat counts all
>> written back pages, making it difficult to distinguish between pages
>> written back due to the pool limit and those written back proactively.
>>
>> Add a new statistic 'zswpwb_proactive' to memory.stat and /proc/vmstat.
>> This counter tracks the number of pages written back due to proactive
>> writeback. This allows users to better monitor and tune the proactive
>> writeback mechanism.
>>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  4 ++++
>>   include/linux/vm_event_item.h           |  1 +
>>   mm/memcontrol.c                         |  1 +
>>   mm/vmstat.c                             |  1 +
>>   mm/zswap.c                              | 11 +++++++++--
>>   5 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 05b664b3b3e8..29a189b18efc 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1734,6 +1734,10 @@ The following nested keys are defined.
>>            zswpwb
>>                  Number of pages written from zswap to swap.
>>
>> +         zswpwb_proactive
>> +               Number of pages written from zswap to swap by proactive
>> +               writeback. This is a subset of zswpwb.
>> +
>>            zswap_incomp
>>                  Number of incompressible pages currently stored in zswap
>>                  without compression. These pages could not be compressed to
> 
> nit: once we have reached consensus on an interface, can you add
> documentation for the new knob in cgroup v2 doc and zswap doc too, and
> how it interacts with the other interface (memory.zswap.writeback,
> shrinker_enabled sysfs knob).
> 
> A kselftest would be very much appreciated too :)

Thanks, will do in v2

Thanks,
Hao

