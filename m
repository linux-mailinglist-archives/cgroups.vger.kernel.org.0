Return-Path: <cgroups+bounces-13516-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tZryHh2oe2m1HgIAu9opvQ
	(envelope-from <cgroups+bounces-13516-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:34:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA33DB39A8
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83808301572F
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137013959D;
	Thu, 29 Jan 2026 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEOJNTjf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtRll92L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370C2F3618
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711642; cv=none; b=eLiyujY4f59PYYsMR8Fuq5hAKgipQg9c2Sx2juilsaDLE8rfOtheSiNfSrq+HKiYg08XS+H+pQeWhiNzqoN5I1u7wvlga/HwNX5D7fdGbnlAnmzZYJ5wvTmFPC/mgVnBGDkzJgA+TfEggrPUZu968MXBQTeRzJ5abj6xNlUOW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711642; c=relaxed/simple;
	bh=A52a0n6mXX/vpDsPDw1aYNuXCv9EMo1cdZdHaWNhQXE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oqBd+DylPmpn1b4bJqJ75aVP330ru6nbDxx0DtbKflkvP0SVpKjuwDWf1QRwFImVd14LyzZ6iJAEcYWxUG/qZFte5tbaJ4Qk/7zuJ8qFRkuSCl+jGjv1vGh7NrzLyIJ9pnElm0mfY5u7UKYG1vF0UmAnwgOifsh/K74/w6FKaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEOJNTjf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtRll92L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769711640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1KTQVsHamBVnOnmhCi9myxR4ebuO1ZMb0FARjaKcqs=;
	b=cEOJNTjfEVBiTzTPF4YUBlUGSjMHxd12eBQW9bLJW1Zd8BjdTRWPkxTXbUdwk87NMXqRGw
	AqebLern3UihMOYDPdcuBeZSzM0sSNBdKK7DDcDL7GztZspv8/kb7mP7wPXKIb//9ydffJ
	7dYhyqgzz5Fts+V/OKYdVi8EcdGQhMk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-vj6PFfvLPI-M-YqkPe7NlQ-1; Thu, 29 Jan 2026 13:33:59 -0500
X-MC-Unique: vj6PFfvLPI-M-YqkPe7NlQ-1
X-Mimecast-MFC-AGG-ID: vj6PFfvLPI-M-YqkPe7NlQ_1769711638
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894727de401so45450976d6.1
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769711638; x=1770316438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1KTQVsHamBVnOnmhCi9myxR4ebuO1ZMb0FARjaKcqs=;
        b=dtRll92LeyiLtlBurKKGf2etDQtxbPsyt0WBmr89g7zYORvVi+KAgIdZdzckTluUNT
         H/GL+EwPzE21Kf3Uu0XPoJ+d6e0z0rLN+s0mBaJ+FdpdL4hffZQPOKoM6k2bUzuo0wdK
         vOOr0tv6j8gl3C4AAR27C9rE3LpdOgrr0l2M3+106+JnVbNEXG7nXMgUnwObgCXBp2YJ
         Qd4+T4M0Q/O0OdGX0HA8uNbPEyCcwqGsH+2A61vIXvpF75iesCeTdjaW1QwOOsjDVhok
         T+fsTb1MbgaKRMOxEbCubFXsETb5GsU2ZVsTo+am1eg/kf+7w/D0CKfCfA9AFb4D4G9Y
         eqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711638; x=1770316438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1KTQVsHamBVnOnmhCi9myxR4ebuO1ZMb0FARjaKcqs=;
        b=Vic1RX0XlC7kLDu5e/qpwYDolId4IeEhAzfEi3VljCfC35pfkwhKJHgZwf2vLvVQJO
         Nfhl8INJfnA7WxPxIgG/5OUjLObppsx6MdDbIPOJBUtslx86nHbWR3UN0Rz80QU2kGVB
         E0xEuJIeIxlxMJCJYZ/MVFt3QDtjU2dzIRIX3K97IJEQPbbCNT3Rr79OV0n7PnqhdaYM
         1D1WbM36V5HiE8AES+WeKjFWnUuBzrLJkUo67vQYJh1CnP1Y5J3AY3xTWTJVz0nzisPb
         4Lq8/xcsSkpY9+kUBDgPOlQSTtI4Qzoj2fmjANNFBQpsNHrCp8ZywmSs0e0iDnvlOVYE
         p6ew==
X-Forwarded-Encrypted: i=1; AJvYcCWIcP7biqBpLE7w0BZno/K63q93Zpnksqt+izoNNNQLgEbI6NjvcTDf+NlMSVuIfLhucbcfbsdO@vger.kernel.org
X-Gm-Message-State: AOJu0YwszccUaYMtdOei0OrOcLRQ7HLE4SvvT3dFNBgzNCSTUTOOCaoq
	m5aVkAgfokQ2+rlzFy87aYf95ib/x1nW35CPBidLSAealDsTTB2lAttOdgh00oNCSAMqaXyhz1X
	VLJ/VDbTmaOyTQc2nRegEux/0/NssDalOOBOs6RP7VDS8SvgGo30J0G81R1E=
X-Gm-Gg: AZuq6aJOLgFpSE7jdMAwjA7+MtnFpnbZRi43mpMB7PfeNDuOtIZ5OsU6lJBkS7U1gqO
	ii7lZaPowONqdIT9PjJ2ZqtVOrB2zqDoMFQaBLBwyHJ3XQJnPLV1REAM+D2N+aw2ZghI+OHuYlf
	1LW3w5ZtZgO7Qbq0WtbdRsLB3STjmE4MgYplDJ5v485pEGMRiolz8jBnEk2syREAmtnSh8vOYtv
	DJS0zVzFlYW5/1SnZvJ2UABC24/x6PhFdPj1RfnxlEsAtaHlnOSCWdEsuls7oXMwWktl5JNFLJr
	RTQj6r9kxMM4CC6mdg9fmFdCoCZmMEArijlyt+wJ3bSzrA0WMADg5Kazp/P8W77XPrqti6Dge/6
	7i7wmKp8/X/oxg8jkAxcPIoCZlLwpSfstxfCliC65+Mluq0N2ZyyEEakO
X-Received: by 2002:a05:6214:1304:b0:894:74cf:d2fe with SMTP id 6a1803df08f44-894ea8c1941mr2388046d6.1.1769711638490;
        Thu, 29 Jan 2026 10:33:58 -0800 (PST)
X-Received: by 2002:a05:6214:1304:b0:894:74cf:d2fe with SMTP id 6a1803df08f44-894ea8c1941mr2387736d6.1.1769711638134;
        Thu, 29 Jan 2026 10:33:58 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm42775696d6.45.2026.01.29.10.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 10:33:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6fc1fb93-7010-4381-a9a9-68a9b81acf88@redhat.com>
Date: Thu, 29 Jan 2026 13:33:56 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: Chen Ridong <chenridong@huaweicloud.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com,
 shakeel.butt@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13516-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA33DB39A8
X-Rspamd-Action: no action

On 1/29/26 4:51 AM, Chen Ridong wrote:
>
> On 2026/1/29 17:23, Michal Koutný wrote:
>> On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The current cgroup subsystem limit of 16 is insufficient, as the number of
>>> subsystems has already reached this maximum.
>> Indeed. But some of them are legacy (and some novel). Do you really need
>> one kernel image with every subsys config enabled?
>>
> We compiled with 'make allmodconfig'.
>
>>> Attempting to add new subsystems beyond this limit results in boot
>>> failures.
>> That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
>> during build for you. Is the macro broken?
>>
> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly. However, I
> only modified the code to allow compilation to pass, and the system subsequently
> failed to boot.
>
>>> This patch increases the maximum number of supported cgroup subsystems from
>>> 16 to 32, providing adequate headroom for future subsystem additions.
>> It may be needed one day but I'd suggest binding this change with
>> introduction of actual new controller.
>> (As we have some CONFIG_*_V1 options that default to N, I'm thinking
>> about switching config's default to N as well (like:
>> CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
>> CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
>> pinnacle of freshness :-/)
>>
>>
> Can I propose increasing the maximum number now? If we switch certain configs to
> default N and then a new subsystem is added later, the default configuration may
> work fine, but it will become a problem under allmodconfig — which some users
> actually rely on.
>
> Besides, this shouldn't be a major change, right?

Yes, I agreed that it is not a major change. I count the number of 
SUBSYS() in include/linux/cgroup_subsys.h and there are exactly 16 of 
them. So introduction of a new cgroup subsystem will break the current 
limit. I remember that there was talk about adding scheduling cgroup on 
the GPU side. One day, a new cgroup subsystem may be added without the 
awareness that the subsystem limit has to be extended causing issue down 
the line. So I support the idea of extending it now so that there is one 
less thing to worry about when a new cgroup subsystem is added in the 
future.

Acked-by: Waiman Long <longman@redhat.com>


