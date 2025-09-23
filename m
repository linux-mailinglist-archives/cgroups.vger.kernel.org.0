Return-Path: <cgroups+bounces-10385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD486B94FD8
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9138F4E1344
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0431BCA3;
	Tue, 23 Sep 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVyxyaSt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8563AC15
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616102; cv=none; b=MQATDYLBHztCmo3D2c/VBIXrX7ZbFIC8GJHmHV6Frudm/UwUcPgoeYH3KYbjNP0cC23EoEdcldlzwR+r5PaMhqBrcG/kGvZpdYlkBTE/GdnzKBvKl9uwSdZHhJ5CwBXfTm+nAcQLFVlSBVdiFQFTewJm4KDlrrboembDoqTpg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616102; c=relaxed/simple;
	bh=injOZqgHS4KB4CyARpgVAoOe/mChWEdXtR1Ikxu6gVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6ylHjiurVzjtt4qkn7zu+k6f60oEuzf0kGXHeF/tP/Tb60buX0p3x0HY1F22U8lf271UjCWy6/QoVGhBT+NGzHRqAtyDiMLOeCfVinRMjH6ukxb6ttwjxijvHTYXQAPqvHP17x7qmxP6aM69+NXOYGw1G0UL8ibhLe/MmFRkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVyxyaSt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GS+tvOnybnp3O6O0X53XpAdOzzoNNJS6PxgRaybOU24=;
	b=bVyxyaStH2sC/zPw2mMdEVNhB9kYxq1gO+YsPi2w2bHXEgIE55y/xU4LwSU+kkJE7rl8q4
	YEMnBrEqKZopCniVbEFMeGNP2a8noeCgRvws1euuzzNd3DP0zmDxKbRNceeQz/+aO13vL+
	vDRMURmow+mDyPi8ynVIlh+Subesurw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-E0TiFaSsPvOAQbIQABJ9uA-1; Tue, 23 Sep 2025 04:28:18 -0400
X-MC-Unique: E0TiFaSsPvOAQbIQABJ9uA-1
X-Mimecast-MFC-AGG-ID: E0TiFaSsPvOAQbIQABJ9uA_1758616097
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso3583963f8f.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 01:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616097; x=1759220897;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GS+tvOnybnp3O6O0X53XpAdOzzoNNJS6PxgRaybOU24=;
        b=QaO5Bqtw9GEqDHJbqAFTyZ6CTsB4hxusXZoYxES0MiqAbufdZU5ma4/ZyQsPykcDTX
         mQtmPtkTjG0dp/t3Xg8ndehlydUpMZA1eWEVyqWRhyQa0pB/nBhr1qdtL4kP1Wtk6w/8
         f+oEM4onKTO8vKIXTayFDzOgtQ3buTf83AeIWWdYzdIFZf42xWPlUPl+q4gWjDJhOAz3
         nGqiZNrxqiOLsdsIPwfVWdPFTg51o1E8XbDFrChOjlHSceh9GIQpeD2xHfX4H7rebc0P
         Yp054PYI2kKIASXmqcXOg4SeHd0QtaCvmUTn3RA3Wn7X51Dpqqk8zxonhJRPjIMwiMh/
         Zv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXz8JJZOihkX7pTK1wtE4SC/VJlTGA8oT5834VvC+22OE4pPlCTECoAHa4wFds+e/rTu5SN+rcu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8W2LnKrbHUKcZqWVh+tivEZtmB7SGc4QBZ9JXfIn43qVBleI
	b7o4M2HqyRMWASaazBpZ0wRYkSQB2hHT67mcpzTh9OETBC+kEuFE7x0OBbKL1jbB89sTs3kG9Ic
	kS0VGS/9bPZg/w2yAidhkJ+g2t/UKJGPCI0NsPhMsmSeFyj6/i9+7sDWyprA=
X-Gm-Gg: ASbGncsbkPexxd8puZyQcXAIF8A2qRZ+9m0m8LCvCO1o/bffqoThTHC1JIqnFrD3GEX
	fJ322GZ25QCO1rGC2zj1khTR6ENRNBFgaMxKVX9VUqbVywZ6BWt8vfNAvD7l+p013QzGuPafRX6
	hndRyV/RDCK/SBVVfa61W3aeo0kl8gZ+/xrKkeVp5iyZ2TBujHd5d5iz9qu6CTwTVEIPmngaUc1
	WumcHeaUC5ODmOmct5+8E703dneBU67atVA82nm/BbJu/zC2ePmDJ+dZrwDdevk50/3pQWOkstP
	as7TDqT1sVPpJwafLCQwpgXxUKKByL99Al/A/vMqs6pCKTXpktJV5CP04qH7tfiYhOv2faBMtFw
	zlyCcm9TOJbmUkNJHTgGZb4jekh3YJvwagblzFrkBZ3CZCGnCiPgDVZUijmh3qad7wQ==
X-Received: by 2002:a05:6000:3106:b0:3f8:e016:41b5 with SMTP id ffacd0b85a97d-405c505241fmr1306399f8f.14.1758616097160;
        Tue, 23 Sep 2025 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHziPBDuhBDVi+ICJTxoEgNM/8e+/JtcJ6oteLK0rvVQF1Gr6+D5gkrvEqoxdsbVysMEgvnkg==
X-Received: by 2002:a05:6000:3106:b0:3f8:e016:41b5 with SMTP id ffacd0b85a97d-405c505241fmr1306375f8f.14.1758616096637;
        Tue, 23 Sep 2025 01:28:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7107sm24037069f8f.30.2025.09.23.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:28:16 -0700 (PDT)
Message-ID: <accb281c-3c2a-4162-ab14-38e883d1ff72@redhat.com>
Date: Tue, 23 Sep 2025 10:28:15 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 1/6] memcg: add per-memcg ksm_rmap_items
 stat
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, chengming.zhou@linux.dev, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20250921230854496C6rkj7YZAYi39dNV3t6Fp@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250921230854496C6rkj7YZAYi39dNV3t6Fp@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +
> +/* Show the ksm statistic count at memory.stat under cgroup mountpoint */
> +void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
> +{
> +	struct memcg_ksm_stat ksm_stat;
> +
> +	if (mem_cgroup_is_root(memcg)) {
> +		/* Just use the global counters when root memcg */
> +		ksm_stat.ksm_rmap_items = ksm_rmap_items;
> +	} else {
> +		/* Initialization */
> +		ksm_stat.ksm_rmap_items = 0;
> +		/* Summing all processes'ksm statistic items */
> +		mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);

What happens here if you have to tasks that share the same MM? (CLONE_VM 
without CLONE_THREAD)?

Wouldn't we end up counting the same MM multiple times?

-- 
Cheers

David / dhildenb


