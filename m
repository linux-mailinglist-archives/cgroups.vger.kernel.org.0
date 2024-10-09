Return-Path: <cgroups+bounces-5084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F2996ECA
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033FAB239EA
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9319DF9E;
	Wed,  9 Oct 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv3COOX3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD31A2564
	for <cgroups@vger.kernel.org>; Wed,  9 Oct 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485595; cv=none; b=RP/kW8iW/uK3VRc5eucfptHMMpfpniKhiKc8mshcCJIqBq2EHWoVotsDHUTuKzitBb67GOIXF0YLXZ5xTq4cFlBXBVl21xQprTtqma07M0knUTy+KbQqGup89A+b15zDvKz7zT2OuFH0uQ6vlsNmLmAF4N3Pu1f01MFZwr+xN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485595; c=relaxed/simple;
	bh=UBFEi1ZanyCIFF8STF3JBKUeL6Ye2vx3cesN3MY37M8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A/oBwsXYBh3hHDAosivLfgYo9PmlNggW6DyWGZh5JMCUqwZPOrux3a376H8z50ry24XYQfH361wez1tfg7mpR0A6J54kv+xBhpsDCRZkEmDWrBqnbA8odEDELVjkyYQqETDdVnC79orYtFfYiz4c2bQNAb7ACsZCGxX//AsFREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv3COOX3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728485592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsdC7C06B7k23BEVtNiQKiVWI2syGR/GUAuS5PTFvrw=;
	b=Uv3COOX3SlcLXAYeOIn+PRBwx81wRB2hk9h3ccBzCmwmSUOQaraGzWkmv6uMBH0Z6ZhcDI
	UqSZ36VVn3LKhqMTGoGu6ZaxImXWC1ubbmRobhJLfxxzvmvwPxn3dzq4TBYol9H3/r4XpN
	SiESOxope82SCHnwm1Cu3di5f70nA+4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-uX7kadcbOZSbzrHOIlVOTA-1; Wed, 09 Oct 2024 10:53:11 -0400
X-MC-Unique: uX7kadcbOZSbzrHOIlVOTA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b10dafb779so127313485a.0
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2024 07:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485591; x=1729090391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsdC7C06B7k23BEVtNiQKiVWI2syGR/GUAuS5PTFvrw=;
        b=mqthmsLl8eTgr5zJmJKeocefVKKp5Uh8T0CtoZKXhgBm3Jnrbami+7UCL+TvItPbN0
         7TA1D7nE6VYoUSwTY3MKRK9EfpFoeTwniswQZHVZ0cUEXtMklTn9EF/p0J42r/kXKOoj
         XVCaPcEYWrmWxo4b54laYq1+YgMBc8Hqvwd39oi/IgpoBTombbba8zPLfbr0aRXMVvD+
         FrCk2MELmsrzOjoZhyMUrKavWkBKOO5I5OiEJM0NoQ4fzvP5INjVDX/WWQYLR505/3M/
         tmjwZlJODBT6u0hcq/CpkvNSNFgdVYhAr0Y94RHM8xil/pnuzmuQQEGwjfoN4ZzZvcp/
         P2SA==
X-Forwarded-Encrypted: i=1; AJvYcCWqfl8T9iORieU+D0qSxeP69M6YM8X+dIjr85C/VaNeCFsWmqiBMP/e5Yl0wnJtPLZMafz8p95T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2uXTn4859EpPTxTGyO2JJNlsZAa7UsLVDZiX9DDGy4miBHlcR
	osHhu1bTEKl3Wf3izQuLgpzYRNB/MINldsiLYuLj88Juizz2iLoyUgsis7eqHLyOrNsm8uMFDbq
	W3V1BAJNaRYUIOWDM9DsZo0CsZy5R0qJ7IwupRmmN9+0BSS9EXdZ2XGfxlnaKwZuEmQ==
X-Received: by 2002:a05:620a:49e:b0:7b1:e0f:bf80 with SMTP id af79cd13be357-7b10e0fc34emr256701885a.42.1728485590915;
        Wed, 09 Oct 2024 07:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAlBvIZWz9PJb1pjw8gqt7q7KhU5Ab+Omw9uNCFTuXhTPuyOntGqUouutFwxlsNlJRpXcpA==
X-Received: by 2002:a05:620a:49e:b0:7b1:e0f:bf80 with SMTP id af79cd13be357-7b10e0fc34emr256699585a.42.1728485590513;
        Wed, 09 Oct 2024 07:53:10 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcd34d20fsm138713985a.114.2024.10.09.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:53:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com>
Date: Wed, 9 Oct 2024 10:53:08 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
To: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
 jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwZIXxQLyJUL_nOW@infradead.org>
 <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
Content-Language: en-US
In-Reply-To: <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/24 10:13 AM, Kuan-Wei Chiu wrote:
> On Wed, Oct 09, 2024 at 02:09:51AM -0700, Christoph Hellwig wrote:
>> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
>>> This patch series adds KUnit tests for the union-find implementation
>>> and optimizes the path compression in the uf_find() function to achieve
>>> a lower tree height and improved efficiency. Additionally, it modifies
>>> uf_union() to return a boolean value indicating whether a merge
>>> occurred, enhancing the process of calculating the number of groups in
>>> the cgroup cpuset.
>> Given that this fairly special union find code is obly used in the
>> cpuset code, please move the code there rather adding more exports.
>> Even as-is it is bloating every kernel build even without cgroups
>> for no good reason.
>>
> I noticed that it was Michal who originally suggested putting the
> union-find code to lib/ in an earlier email thread [1]. Before I send a v3
> patch moving it to cpuset, I'd like to hear Michal, Tejun, and Waiman’s
> thoughts on this change.
>
> [1]: https://lore.kernel.org/lkml/wu4m2m5igc752s5vrmtsnd7ekaq6opeqdtrzegs7oxlwgypdcx@qhcnow5txxiv/
>
> Regards,
> Kuan-Wei

The current union_find code is pretty small. Putting it there in lib 
allows it to be used by other kernel subsystems when needed. I believe 
it should stay in lib. If a slight increase in kernel size is a concern, 
we can update the Makefile to make its build depend on CONFIG_CPUSETS 
which can be taken out when it is being used by another kernel subsystem.

Cheers,
Longman


