Return-Path: <cgroups+bounces-7598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F999A90AB3
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202E17ADCDE
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E021771B;
	Wed, 16 Apr 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLRFaM0H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017020E6EC
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826514; cv=none; b=dzKcSC9qpA82IqkJT2WC40mfHmd2q3ha1HvhR5t2pg4KGWb/KrWgZzDz0tpPYJqQfqr7QRnmQrpnVyW+V4A7PjxyYBOrjZYrB2HrRF0wYLCvg/IUgUb8mErEtlG86oxmVkaCG/csfkUHbVNIiufrEQbXdymKL+T40V+ZsWvXPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826514; c=relaxed/simple;
	bh=nnzix/mbkxFM3K6aL7nfmY3hyvLghSRivx/CuKFhAfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqUfQ/pFkyiIMkuZqZzVoupR/VHp/+OKKhpOgkGr617dAx8iFn41F0GjvnOjmMkCTfzhuJfmokfUvMgw0tsCBZCBLTS6UVaBqZQYiGIPKIyHohFkGb9e9yxqDxWuhwVd0odUgmp41XyQguxEd/+kOxkXOyQYPuUROS4sk6CX/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLRFaM0H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a720e806so60291661cf.0
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744826511; x=1745431311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ke1YrxQQmLR6ajJYMYuAIitTVymOTGcJs7MZD2ruDpU=;
        b=hLRFaM0HYrlrdck44ZQoxdpNfoGX1U1YJynUyJ9KJE9EMHZJ1mZvahQYz4KCfVznOU
         DdwvSXrviaVUzv5o21/S8rtA+ow0IojVwdrM1Hfvf6E3lisOFGpFIBCNRvjFPhYkbLRM
         Uc+swU2z9B/4Ci9Jx1fJWQY3UsUZn3UWqfAGb5gFirfbiW5UQr5wFKmfuCaomPQOw4xy
         rQt4uA1vt/PeE99aTpO9IBe8QIPwdLyj+mxrZ31IWo8DUAmdNzp3Q4aj0uh2GJBt5PGq
         WJ4JA2FdFvtbzdSo6dpJgj8dKRz1tTlDl+xT7NdAkCyf/zBecRSbJ/PJ8RMn1SXicfve
         qMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826511; x=1745431311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke1YrxQQmLR6ajJYMYuAIitTVymOTGcJs7MZD2ruDpU=;
        b=JI0xFq8yfSdBrc5j5Z7XSiLa8sIKvstSxHCQ9liynZ102ODgFxtG0VC+7hhJ302dE7
         ljCkiE4Gs2PESFsgM5WTLGMrizyV7dGxFwaZMC4Dl59wJsRBnKynoqxY7vdVw7tFBhio
         iv59zkv8D5i6enr+BIStE0lXPw3ZZ+1tzgvRxh04KiktTq7ZgEMPVdncFLGaXW1WSebt
         mShXPs8WmgmgPusYakWdmFxcPpmsK+HIlOwY9L1Z61O/irEfP6SvOPr7nqyqWYzquwGI
         Q9Zma0iE3JcS0PLUBFTmz/2QQ3bR9XVPlbzLw1hJ7wMvP8ZUtTLedBUvhMY5yVmd2f3f
         RKEA==
X-Forwarded-Encrypted: i=1; AJvYcCUXaioE7OdO7MT3cUxnrkjmLS7cwWB2BFwAanKfiYwyUWwwB/d+l2hjIxpOpj6iOGNTP9hdTx4R@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfx8Sd/qpIKueJEcQrpbeUJ51yHiVaWWRvJ2nxxVplsi6HRpk
	5Iu7SszqB3OWvkgEdq/y+XoD5b/tHuQfzzLmw6uHNYopwr9w4WM0
X-Gm-Gg: ASbGncu/QJ9yRiX8RIIWaLC28k7pJlRvPoiVtr+kLVxJRwU8y7adJELSH8LLTG40Bxt
	ZCn52scGfDIFDSnKsXv3KT/Hqr1OOvSbh2cYWvbat5394c/u8oC1OnBEL/j2wiXncPr1NmnxDbd
	kJnzJxZcQMG1nlDgn+AZtnuC11Yjoiy8TNj4PyB/KyQimAw0pZaLgwc2xbaUNZ8KFaPWtfgOfbC
	qc7PhZ3BPEmmlWZlFMKMM1NgNLKOKRTNmaYs3Y3gXZbc+oWSD95v6x9vw0TJZne4ZH4z41AnId0
	rvRAeN16EMj0cYfbQ+S7Ct8CyFr1q7eYC3+HhnfoXrU5o97e08G0hocLjj4iWxOkTGWBGkEc
X-Google-Smtp-Source: AGHT+IGhsO6K/MdxArhwu+UIFuP2aWlgtxAKLQqrnXCnrmpcCUGM9u/wAH1270OEw2RxBR4zOD7IjQ==
X-Received: by 2002:ac8:7fcf:0:b0:477:c04:b511 with SMTP id d75a77b69052e-47ad80d3836mr46787771cf.31.1744826511232;
        Wed, 16 Apr 2025 11:01:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:b31:ddc1:afa7:7c1e? ([2620:10d:c090:500::4:d585])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2bd8dsm111652001cf.35.2025.04.16.11.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:01:50 -0700 (PDT)
Message-ID: <bdc5d0b9-8427-4bcb-b434-3ffde8905a68@gmail.com>
Date: Wed, 16 Apr 2025 11:01:47 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/25 10:15 AM, Michal Koutný wrote:
> On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
> ...
>>   static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
>>   		int cpu_in_loop)
>> -	__acquires(&cgroup_rstat_lock)
>> +	__acquires(lock)
> 
> Maybe
> 	__acquires(ss_rstat_lock(css->ss))
> 
> It shouldn't matter anyway but that may be more specific than a
> generic 'lock' expression [1].

Thanks. I see what you mean in terms of improving the output.

> 
> Besides that this patch LGTM.
> 
> Michal
> 
> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#context-ctxt-entry-exit


