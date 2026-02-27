Return-Path: <cgroups+bounces-14463-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIvtGNFLoWkKsAQAu9opvQ
	(envelope-from <cgroups+bounces-14463-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 08:46:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D471B4116
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69A783038725
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421653148C5;
	Fri, 27 Feb 2026 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fvk6pM9e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B061397
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178383; cv=none; b=BzOxME6eU9ns0ZK271AAx6LAO1dV0xYSQ1W4jCnWpeb2apH6jlprZdeGrr2qeHPYHT+LtVhU6NY8aIkbbKzglOrwGXBblZEMXExT0v8jgSCZPMt2xcqs7zMRpR8aRRQPe6A6fgguW+dusE3/yL9ltbg0WzKSriEfqJSZlwUcBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178383; c=relaxed/simple;
	bh=Bx+B5gjKJI/vlC7buqYj0K8xUC8oHqthHvN3Xe1DHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftNUrpEetCGGx9prXD2Q3R7+jXUnP3x6vCiLMbk1Qu3GDr01Io+6nqRFquAjfjBLRbubXgHqZEJVoHSb8WMvaEad6yZeTij/Ta8h91RORdH87/mkoGDdGnkkXjWaXo1R+rxu0tzOMz8tnAZLIhKpWRRzz/J2Qwp/+j6T624GQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fvk6pM9e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483ad568d68so2729025e9.2
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 23:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772178380; x=1772783180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPz8QjAwZvhtyd1YXSG1O5BxKJR3PUgfbJT3DkGnKNY=;
        b=fvk6pM9e2MRJDqOB1thCS9SZqnXo2PSsXaLS9IFIGgc7HaIz/8P/F5mG1bK6NGYS9O
         pemHaISBjWPzJEqZVLwdTAs6nVJQODBOlAerix9A6whuYRgSWaKwCG+pGhuIk55nult9
         DomU2y74/p2G4J1AFVsYb56NAQ3sQsn1RZ2h19J+vEHYMuripbOjygs0ixXmG6ZNuDmm
         ouKS4BvrPUD2Q2p67vJz0SdgSpIV94CevUy9wOz/OH31RSkAP3fgh6EDj0J6aNRTHguV
         oTa/5w9fJcPbkjrUMoEi60jgbH+ljovDkNzO2qIgihrE526su9wJ0aR38DB+0ai5DW1r
         xntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178380; x=1772783180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPz8QjAwZvhtyd1YXSG1O5BxKJR3PUgfbJT3DkGnKNY=;
        b=OWvsIvrszMdtfEX5EqKGLtonlKGdVlVDCiXTj4OLisOoMx8YOeTXdJY5Yb5jaxkC3B
         PZYzu1GV78AjkSABBvGnjQpYfCD95UUE8zknrnR5ywiUA5JRveBLFAe2xcYo6b8y163w
         Jo21dEHKD2KDFNFJyLNfkm0I0zgUUibCH/NmlX+Q1+ghHu5cW68ENvmB5mkAakIMDTGj
         KRomARRmPxp6pke+sGsOVKIZXDMBaxIrPEZX2+ybXtFMhLheV6Q9peS+iuW0+amKimIg
         VqCMoQxVo3BI5DwQuxng043utPOGXcT1PYlOaI1c2HDwwsK8ZZrfYlNts5gjQp9353Hg
         fJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCV+pf7uZAjc6rrzjyWITQn9vPoMamyxNwNXPL+3CrbnJ9XQRReaoyJFtqGHCrHQx7PQyvwazG/A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61YKN01kW9jGl5NRbgFnU9kJw0JE2hOU6PZ7vs1nrQg5+jY9E
	GeHHW7PmncPgYnqitv8Trzm7aMOH6fYyhkGA61/2VsRFOdIFXtrCwz5j+K64iMdiKY0=
X-Gm-Gg: ATEYQzxMTt9oVkVAbRmT4SjRTxO67RfH4Par1ginAy4aK7xBoIecmw4CC2jswszjfR6
	CzuTGf208JOEB10cFLNXgdyIRk9WdEbr8Nc2IU8mcsWYog/ZusAxasadbkk/QzMFtPPlLmUjRbr
	HdVdiQzT5PiL0DYeMvMTeL4iOLfi9Sa5EHU2ObLujDh/8uZ8Sv+RoRqNsWvCie9Bc0emeeiEPZa
	K307TuWohgSESfYx1hSRR3DGtS0dqRCkrb7notIhaAbRwCkQQXJx11KSHNxlqAKk+TioGIPEMoh
	+s5HDwCbqasTNI/ySiq204DFW/PmgWxEUaR1/vsblcU0g/k/inhJlL7coxlBdWxBdrntnfV5Zg8
	wgCxTWN5c+l5ynFVACzLNtiaIitFQl0IabtEWXSC0oWdaGVweX/49o1WdgchPOZSP9N8SMKaxXn
	AhtEW6XxLdv2+/XOibH+byjz9l2BVSbRiMTfEDm4yLpzXFB9PYiypDAVVArw==
X-Received: by 2002:a05:600c:4592:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-483c9b7fadcmr14391835e9.0.1772178380074;
        Thu, 26 Feb 2026 23:46:20 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm97998005e9.2.2026.02.26.23.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 23:46:19 -0800 (PST)
Message-ID: <25f6a18c-0600-4a21-977e-19b8b4b203b2@suse.com>
Date: Fri, 27 Feb 2026 08:46:18 +0100
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
To: Hao Li <hao.li@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, vbabka@suse.cz,
 harry.yoo@oracle.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226115145.62903-1-hao.li@linux.dev>
 <aaBM0fN8fqER7Avf@linux.dev> <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
 <siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-14463-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 08D471B4116
X-Rspamd-Action: no action

On 2/27/26 02:01, Hao Li wrote:
> On Thu, Feb 26, 2026 at 02:44:02PM +0100, Vlastimil Babka wrote:
>> On 2/26/26 14:39, Shakeel Butt wrote:
>> > On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
>> >> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
>> >> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
>> >> than nr_bytes.
>> >> 
>> >> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Hao Li <hao.li@linux.dev>
>> > 
>> > Thanks for the fix.
>> > 
>> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> 
>> What are the user-visible effects of the bug?
> 
> The user-visible impact is that the NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B stats can end up being incorrect.
> 
> For example, if a user allocates a 6144-byte object, then before this fix
> refill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=2048), even though it
> should account for 6144 bytes (i.e., nr_acct).
> 
> When the user later frees the same object with kfree(), refill_obj_stock() calls
> mod_objcg_mlstate(..., nr_bytes=6144). This ends up adding 6144 to the stats,
> but it should be applying -6144 (i.e., nr_acct) since the object is being
> freed.

Thanks, I'm sure Andrew will amend the changelog with those useful details.

Weird that we went since 6.16 with nobody noticing the stats were off - it
sounds they could get really way off?



