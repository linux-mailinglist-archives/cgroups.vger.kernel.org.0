Return-Path: <cgroups+bounces-2801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8F8BD4AB
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C92837DD
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F4156C66;
	Mon,  6 May 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJoocT5+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AE1DFF3
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020547; cv=none; b=bk+pDuopHzgOG6lYDOXSWUcF8BCyEemTfZFf8p4VDN00yO2j+57vwGX/ZqAXpEbNyWN6GVEBfA/e2AcTwVBs+8jM9lGyLbQ8uSwUwXuqd9kPrMDmwTzwG/ewQEUCMmnrqGkx0Xu0XO0eKi2P73VS/QYq3b9iC2ZT3FgeDV1CM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020547; c=relaxed/simple;
	bh=w1Ok1PZtcA0Wz3v3m7VLI1e7DxHoMqFMBoqnyqSlDIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICe4IGcE6JxNhPDstpMddPZ5QAZng4inRbDBXzlczzaHG60yPCZM7tGyJHPJdteUmqrZsYDeDsks+GWmflSvO5QDaUlBfIo6gP2zZZ5wq8qKrOchp73r1pUqdBWzLP5wnOYh1naoXJyaAf5Ghr4TYeqJMxqVrf2IkbfkSyigOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJoocT5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715020544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+39y8W7bsu1hCnW4m16/3q+glmJjCJshByFNqIk6Vk=;
	b=PJoocT5+JYoDIEKXImmIGTXQ9O71Gaak51lPtR01qM5kDhZD49USNK46XhS5jAEI9d5AfW
	72+H+jtLudizT62y/H6GpjHul3mZJpxmIzMe/kuScwbHC1z8J9QOLlKjs7lQfWZxEtAsow
	GxiEsr0kb+2GPNlcp/W8+tmGuMy8+xE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-X0QlVIydPHyCo2BGjHWSQA-1; Mon, 06 May 2024 14:35:43 -0400
X-MC-Unique: X0QlVIydPHyCo2BGjHWSQA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so12532365e9.0
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 11:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715020541; x=1715625341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+39y8W7bsu1hCnW4m16/3q+glmJjCJshByFNqIk6Vk=;
        b=Hr9yTuknklZzTWtQ2XdXN4nbgQOCoLSfM9zzIQlQNziVEFmEsyXu/gwbIBFnSYl0X1
         ew+xufz6PxjEpIWdNlKAAlo5gwUR7dDYt5Sxfw4pvnRdX0c8loulHPFbTowMBaKTXiJ7
         lS+j7NwMPL9C5eindq0B1VjEKP5YDno0mZhvTzl7Qi4hFyCi5dQNxUg4bs/rPyTM15Pi
         LYaE8KPiUG1fnYAnlBRHIsprpZVU0SMyTO6ic8AxQwfBIU1BhY8gi7y/LYuI/jrsidR3
         nBNsAj827MRXnfa7EGoI6xiLqgl/j7cFJpIaQMlQaRCPu42IveyHuYSUGJnyQ68YPuO7
         vTyw==
X-Forwarded-Encrypted: i=1; AJvYcCV1QivqTV/5qzsZsTssTq5AuQFk2F2GCW5zfSBiAv2sjyPO2z4utCvnaAql4ihDwuGNtFgAylxVKi8MU0q9IyOSGvV0rHjs8w==
X-Gm-Message-State: AOJu0Yy9QqF87Wbwtb13bty974e/BtsFilmaRLnc8k1jk1AWP+wN64tG
	vR98xj1dr+ETELrXJnzdFZbWjIWU3k8PcmhkB8f1kEgI1cHBq3hTVDcx68FwCHHYBujFkpDk9Nh
	W+ux07Nz2qRPB5kz/GRWCL9RbcKL3qJXaCJuEL2pL5nCd/LNPFfjr4XGdksZeA7Q=
X-Received: by 2002:a05:600c:5128:b0:418:3ea8:46c0 with SMTP id 5b1f17b1804b1-41f2da2d4bcmr4054845e9.13.1715020541371;
        Mon, 06 May 2024 11:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2E7Ba0oxJpZZi2hopWvMu8kafXg3cs2sCZQKS4ImBu+OW4F3n5S7V9fMwBMfDy8QCe49/QA==
X-Received: by 2002:a05:600c:5128:b0:418:3ea8:46c0 with SMTP id 5b1f17b1804b1-41f2da2d4bcmr4054605e9.13.1715020540974;
        Mon, 06 May 2024 11:35:40 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6c2e.dip0.t-ipconnect.de. [91.12.108.46])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b0041bab13cd74sm16901414wms.17.2024.05.06.11.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 11:35:40 -0700 (PDT)
Message-ID: <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
Date: Mon, 6 May 2024 20:35:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
References: <20240506170024.202111-1-yosryahmed@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240506170024.202111-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.05.24 19:00, Yosry Ahmed wrote:
> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> __mod_node_page_state() instead, which updates the global per-node stats
> only.

What's the effect of this? IIUC, it's been that way forever, no?

Fixes: ?

Do we want to CC stable?


-- 
Cheers,

David / dhildenb


