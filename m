Return-Path: <cgroups+bounces-14427-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGwXKcBOoGnvhwQAu9opvQ
	(envelope-from <cgroups+bounces-14427-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 14:46:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16D1A6E48
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 14:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250D730164A1
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D02DB79D;
	Thu, 26 Feb 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TUGBuzDP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA627A91D
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113447; cv=none; b=AqJO5dvut4Vdr5QSYxr4DQ7KPG8Mg5PD6NTjv8Qo1SHcYlS7d3/zT7WOSLVUcga2ZpO9ZV5Fv+rc9pAlfl9YVIXQjlzDgABRlvOXpihZPNsmM8GYrCwXKq49ZZeaYj6xjPM2cncbsJUlZcEl+ZqE3/cvZ/+yYENVjEC2txKhQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113447; c=relaxed/simple;
	bh=gYACJLn3/0GZSiDl9hZ0qOJ1DMoWtAfWBCr6MWFZTqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLMK1vHhLOZ1iTXAcYt/WB9qWMcSoBVth97nYfbArnDlR2gcwmq6AZNcQZu98lgzlFjKrvI8lADNHxAZgVEDpnhUwi7+e8MjCayeXDBtQxRmWRKY7+IRQQ/u2qVQDqXS/2zV0+ARo22w94oWSl0wx7vaX6E0ijVjIy390j/weRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TUGBuzDP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4830f029407so1641095e9.2
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 05:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772113444; x=1772718244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiW9GHemN6Ann66iA0XbJEcnWOl2O4mI5KnopxyGsJg=;
        b=TUGBuzDPnS5sqEqtfQ+EAnxTogsw/t+YZtVmDG/HrwWHCq7j+R4zYzBeTSb20KL9hT
         khffNIFWqnKzdHY9UAh13yCHtjA+u4+ymOejC6PFjDn5gLDX8zT2o+wmzgjmoZ/44EVK
         9tWzpHd074Q0wzOqwqe6r8tuWkQWmG37xHb6FfrwptotAyxC7eTVE4kISnP5E6Rb0V0D
         mVrfJ9KMRDHWp0/ghS/fx+SFacIzfFdXrdtF+3MQepvPeqPT/fxO7QvWlXylsZZ61k2G
         3sq5W63DVJYr//3s8n2Vea+nGm0vivOmyJfhCOeSTKdzcV1HSbI9AsO/+EoUaOEWPtb/
         SSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113444; x=1772718244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiW9GHemN6Ann66iA0XbJEcnWOl2O4mI5KnopxyGsJg=;
        b=JOfrSw/1Kf1b1ZQFauNwe5/M4j1dCgskZMd8bw2b7mBACjOefJkY6fcYEfc9s0MDRD
         BQ15XB45Jh3uBWDuPOkt/wi67mKVT8jOXwdIH2+zWXGIwncE8+anyBOvO0p/0Ph+zp3E
         lDLbugTfCsPcpzh06vMsitukGH7Lo7h4k8B/PRoXuu9Avu9zpWU0jTEki3XzJWpT7jVT
         UajKXHCm5I0XyEMTBaCdrubXThOxnYM/Oku8ynUUwfw7MZHkjwF60udPoU3jhlCUc7bM
         ipKaNgBBHgVo7ZyFDpZYP90jDzgIZDzEakS/lwiXC/S+qEby22rfbZGJVGNEqK/yFyI1
         9Cxg==
X-Forwarded-Encrypted: i=1; AJvYcCW+fLAKgJ4uJXuFks/I86UpINtlRTJS5JGN7KNqNeUsT9M0eROyqruHJCRaAKHxFYFA4jErpro/@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeYL8KitENxu2bzqeRTtbarDr3LOUyOw8H26314JJqZy9j6th
	u7knjAT5EhSXGok1HmVtJb1c4tvx+r70Fayoo/HGoB4n7oqtgGuSWJmDP+pnyQ/rPw0=
X-Gm-Gg: ATEYQzyr0bf9wqS3XSkgpw+P/ukN3Q77QQKkW55wCsQh4bDQ4PNrQw0Q57rDpeZhF0R
	RFiBZcM4t/mmUQeS4rkDkhuG5BViAFpsQOcjaqp34ilWJu1bdisfk20WCyqJlu9eDQAWkgdmPrQ
	AsxQY9mzAf5GXoPHkfuLqAePvLBDicNjwDYvL2vAZ+hWs5KzmdBjL+yH98UU73qRMSMTItJi/9p
	oGGbkpePtRx4YhmjoMbvx65SVfS8cxGgKavE8YGou45dWoL4lOXwaQ7xtLuGF5nVP8jPsuuxowP
	2mS70FA7bhiTQ1vxPuv3OFKfWlwDqkQyEsCJLrfytPxv6CHn5ZIP+OztGedC+qzgxNSM0sCMfCd
	hr2ZH/iaCWGaHXoFRfP4oVZKZdUvU3l6kWKoWq4T2hv6FhnQQi/siZ+VYrsyG7EKkw3hmXDxadQ
	4NyX2YwjRuJ9VRa70bAslfZy2qyr7Plg67wlSpmTTy7WK6O5swAnN1f02qDm7cZR929M4I
X-Received: by 2002:a05:600c:34cb:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-483a9555ad9mr192713905e9.0.1772113444133;
        Thu, 26 Feb 2026 05:44:04 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm141938035e9.1.2026.02.26.05.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:44:03 -0800 (PST)
Message-ID: <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
Date: Thu, 26 Feb 2026 14:44:02 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock
 path
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>, Hao Li <hao.li@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 vbabka@suse.cz, harry.yoo@oracle.com, muchun.song@linux.dev,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260226115145.62903-1-hao.li@linux.dev>
 <aaBM0fN8fqER7Avf@linux.dev>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <aaBM0fN8fqER7Avf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-14427-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B16D1A6E48
X-Rspamd-Action: no action

On 2/26/26 14:39, Shakeel Butt wrote:
> On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
>> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
>> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
>> than nr_bytes.
>> 
>> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Li <hao.li@linux.dev>
> 
> Thanks for the fix.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

What are the user-visible effects of the bug?

