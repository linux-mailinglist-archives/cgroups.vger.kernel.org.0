Return-Path: <cgroups+bounces-10322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EBB8F56E
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624BA189AD08
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870872F6184;
	Mon, 22 Sep 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TQ81andO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D42749CF
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527518; cv=none; b=PCi4Qu3xXhWHF+PbUqmS4fmJiapfKLKLY7B12FbFo2OGuLdyUAbUuAgI3PQ4pdLtI2MwXIWcp07Zg3sOE0ejMu8Iyhw9oWkGgeWTD/vk6qFSgxe3C5I5QQy/KpikVeORYbp45MEmByvK8FYNfwNT1cHuGZz8R7fWb+BRgJEloNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527518; c=relaxed/simple;
	bh=AigsWdrV8U413sLiWYn0DWOfNdAi83yiRHcmu2AqNU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8Z+rjwG3iJxr8DV3RzLMo3ud3iIDAIRz5ns2Zzq0EX5ItWeiOUkflT+b6KPI7htIzC1ntEbDcC89ITOrjbKpZVgvog2WA+Re5EylzC9z3gHz7IwL41GWnLG1MIDSk9VYY9Q9IeHxOSxhr0ZIg3TxCVPZuLbap/4D+hlImF3CGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TQ81andO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f3580ab80so828022b3a.2
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758527516; x=1759132316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDel7pcF11Oq6yCh9tIpX43vHF5ddtSDLUzVljmeUyU=;
        b=TQ81andOj0RiDNXpmRhHleqRETx/wj6FE5qD80u74ywpg4erqzE3GJWURBe9q7wGgB
         Fp8Ulz8CKqCOoXVzdriotZqXQk66usBlVZNxoZIK1MrELuW/PmS3akxqc7vOgAJm+K1L
         YIeQW2WSKiTrC3D/87h2ZdhNYtv9tlNZBLqpMcnXuhAOZ+PGYlqIpVTb29koKkwaNGGL
         tqm9kFzih/OtIKIbmvBFgI417+R88rjrs5XROctZY0AS9dwh/kgRjU8EP36JkJfUTLR5
         54o8ghh7dEowtFKPW4AX83qMprbBRpIVGktb2eZ2wCJhwOgOV6LhtyS6xn6njvyvoxlm
         BPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527516; x=1759132316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDel7pcF11Oq6yCh9tIpX43vHF5ddtSDLUzVljmeUyU=;
        b=pQwidNJM/pT15QA7eDvdacaN5KjUGlU0awIa6Gc32Fq1Pll89fZ15Pv7uSPCNccvyU
         BptSvbN/T830k4FqlD5pLveaGDoV7GUkGcJuL8gSJbi24u557ikayQ4cIsZcFYB00D65
         Wyvy+B6V06mHG1r537Y+ao1KlRkjc7jnLnyB/Ie1F3zprdOshD1kSHSwqk9RwnheOY14
         x4YrGMaNKxReFxxB3EyWCLphQWSHMpT6y58ZNlOoXyWvV81kv8LPsspTjk2xwImhUMib
         fTGGtHqAEIgrTYffWYz/ekzC7RTMe/bk0sVrMmrciDctEocHn9bwNSgy30LxKYGEVBVo
         XgMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4fxYU0CB5gjw/9XuIPHNBCqfHfTAr9Dh5kMpZ9JCnnHwhIXzsDDdiQjm0hDg2lK4/u9ckuzzF@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlHiDHVkUeWpYM9TgnFJ/ULm47lYk0qcTyCOW3m0+iu6SOTBv
	/TwDzMLUzheaBGznuKsKzpchQ7nLTJSIy8u2YKL4W2ib6Nx+KJLzThPO+E0nitJJETw=
X-Gm-Gg: ASbGncvy7i391t7+Xm7KC2L4eX1sE7FnNBXvX5ZSv+PYZjelLf+qC6Px8ZLZWCMqbZn
	wt0oPMxyMEwh0hUEN3hkLIE1qz2QT3GTfWhLVtHXkferpA9osv7/j7ke6/K39Lr02DwlirRKizN
	ObLNVCUjJd58pGvUtPOG5T0gEjz28vrDOYpcUqKu3GzxC87nisrEiAukiGmM3qIWBunAWaAL1a0
	5LmiPqKzYlsplMEz9creyIFY0kCvfS00S5+EBdcpGKvlLn4e3S0iqS3LkTCHl4+O+MgtgUyJMvA
	IFM0CKq+5HmvWitHgR3H87lqOWHDbKpo79pYKwLLxCIcow9Y24bXpUSadSYmZpSpWcK7RKUGQ0f
	Xq7lHoeg7yJuimKaxLQ26sRLZIUSKYrPOvBykdiztfQbcF1RdkpQ=
X-Google-Smtp-Source: AGHT+IFvNwMFCIWEKmfCSKTgy3OoaxHXYVww5vD36PPLuuFVpvLur2RM9yIrNxaf8MVuw+PgrnqE8Q==
X-Received: by 2002:a05:6a00:114e:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-77e4d31e124mr13772451b3a.8.1758527516015;
        Mon, 22 Sep 2025 00:51:56 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315029c0sm3020093b3a.47.2025.09.22.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:51:55 -0700 (PDT)
Message-ID: <7d76e5ce-22c7-4b9c-bb23-d0ccbe22b745@bytedance.com>
Date: Mon, 22 Sep 2025 15:51:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] reparent the THP split queue
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shakeel,

On 9/20/25 5:33 AM, Shakeel Butt wrote:
> Hi Qi,
> 
> On Fri, Sep 19, 2025 at 11:46:31AM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> In the future, we will reparent LRU folios during memcg offline to eliminate
>> dying memory cgroups,
> 
> Will you be driving this reparent LRU effort or will Muchun be driving
> it? I think it is really important work and I would really like to get
> this upstreamed sooner than later.

I will work with Muchun to drive it. And we are also discussing some
solutions for adapting MGLRU with Harry Yoo (private email).

Oh, I forgot to cc Harry in this series.

+cc Harry Yoo.

Thanks,
Qi

> 
> thanks,
> Shakeel


