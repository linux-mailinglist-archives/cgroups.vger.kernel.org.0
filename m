Return-Path: <cgroups+bounces-12222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC4C8BA94
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECE1A34ABE7
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444633F8DC;
	Wed, 26 Nov 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNwtqBGr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mGhvOINZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435662FFDEA
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186241; cv=none; b=mjbnn6yCb/OojJI5snX4EScXQN35ODj2F+7iB+WGZK8MI16jsE+yyRH3yuEMvTjtycCfuRsFLgzSRPzTPVWiFuUhDDHM+MH/PjZDDkGt+Xf6VXcgCKXjcOBTH5XNCsVn0P9e4DlkaTc0dGBO7ev+o8677RZBjqzFFLM/WCHH7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186241; c=relaxed/simple;
	bh=NC8uKdTuxmAzM0uXWA/yZNtxUA9kOoI7KiiXmK0aHrc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=llnW+9lRTpaiypODOL7yd4veBHQFNLuzCynGjULaYXf0kFlCROiEOpF0SqDX+qNLU+JuXwnVoAHrdnWtI0m+BqEkncLJoCIWDRkt9UwbxzCUuqBu2crXJv2954C6Ivwtl6dnFlvGXFQAeUenceIEfxzpru/6zN2JvwS0eqyB8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNwtqBGr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mGhvOINZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764186234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
	b=BNwtqBGrXUl+QYZy4ZraOwoZe11timEILgfGSyQw+PK3jFuXCBfflIkyrzzwHO8ogpE8kM
	k/tkrlZJ9yLKQwXTi4ep9M4fSQVq/ZK4xMQcibMCtmQPVERKa2MZiIgv3Ux+oaUTt9binI
	Aeca5JvJCGf5geYoZ/LdMUDrv+Fhf5Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-mKWrjuoNMkqObKgwgnrrbg-1; Wed, 26 Nov 2025 14:43:53 -0500
X-MC-Unique: mKWrjuoNMkqObKgwgnrrbg-1
X-Mimecast-MFC-AGG-ID: mKWrjuoNMkqObKgwgnrrbg_1764186232
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2217a9c60so21272485a.3
        for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764186232; x=1764791032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
        b=mGhvOINZ9GfjmxtGrg8fMoGG3rkYdO2h0t/G8/3GXIaHu5iBGUxG2OPsABvSP8J+Jp
         SPRJSFOpFagGfSnnCRXgSUkGbeeLFL9LehcegNOQj69XWaVUDghMQ5PjjVJhxibSXH+k
         mjU05p62aiV0VcNayOicdeKktrgxBzuXQtGQG0seULeeO98xg0svqEQq1UAdK/AM3Sd3
         LjnTwTGEHN21uAn+GQaTU22rtppyp1MI61VvDa7eYosc+BkvQhLzM4zvj3pEL98ASHcU
         3hCu9bV9TVPeRgAIKUDeUbAKBoLWM0A2EBgChv1VQCU0CB+sRx4TbFpbVbqpBMSoBaPq
         SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186232; x=1764791032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
        b=mNIxWJGn28bXKKOlbnG7qJpHIzdegOxba0ByLpji5LHzWuwiZozmowNs5fg5XQraal
         GLRdfnyDRZzJW0FWIERtQPr16yP0OVnQU2j3rHwLfTw8ldJ5Sp1vkEgukrSyRMBCiUVo
         yA5krDImAgv/xL8f+cMqQsmAwqgkZPUvnoeYTvI2r/dsk/9FUGgH0M3AbUo82yQczJ5H
         NibEHV4eqRxtVAhiNblzUqjuDo+zzyOg7fqZKL73PvMojlQMG34LNolXIPBHNwL7DZp3
         WAKB3Tl3Sx3M6k2k6ZXkloVN0wb/WZszYDLFLriUsIPjnjzs8xOgchm8aVtL3cuFDvM7
         Vm2w==
X-Forwarded-Encrypted: i=1; AJvYcCXktfvDGhTV6vs7GVAsyqr+ICtqx2M52yQZNlhaxWudovO9/k+9zwg5K8Bgmv3tMC4F7Od/J0P9@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBeok8eDtMrI7mjT/O+hBN65tZKqjSUAiJA66vcCHxs0zPye7
	Ym36daugRtbHZVI/EqW+UEvqx0m1hJ3mzdFYfiHTmlBBFLSE4+M/KeMgbm8NDlvjUnhQcO2hdAf
	JBlIKjym5srJAwhS584oLUIC/ub5sXM41nDYXiJ78PQw+swntuRvbwQFxxqA=
X-Gm-Gg: ASbGncvRqY7PYLYxRUunoQoRsl1rm/J9ObLTgPKwvxXLeXqXCexbtPoL3m5dKXhmOqq
	Zt+yVBIQ1AOZdvKPCtqCt8PJVpKtJwQPlF2gSTo9kKOVGMC3xxkuX5bAkPFwPC0ucre8ohxNLmC
	P+dcUaaRL/eD8kY0eGIdIoOmrb+xXzwyS13xJ3XasipBIiM/gPLJZSbGVr+wGursutlTeQ566/7
	DOjsAG4ByddfKPcn9wEU8+vMTfu5nUE3oocqLe/LZBZKvuZRwbiWUiutZEQNlTZPCGjmkCffEjd
	IKNvSTej4/YDRdE5vLSMaSm5js/FPRs2cWYKYkU8uthKphDJbIwIon6xKMkisYtFo7NnoHOQAuY
	IIbWvycEM/vdoNGlUmYxiUGgWpgFzu169ljkwLsGDVKmHzlz0Rl7jjk+r
X-Received: by 2002:a05:620a:1786:b0:8b2:d30c:a30d with SMTP id af79cd13be357-8b33d1dd234mr2486904985a.13.1764186232560;
        Wed, 26 Nov 2025 11:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvM8RJdQKemYz8tabC1M/q2/hFazMCd8hSekJljf5/VfwsxdywRUQN6M+fkgNnaPbolxQTQg==
X-Received: by 2002:a05:620a:1786:b0:8b2:d30c:a30d with SMTP id af79cd13be357-8b33d1dd234mr2486902285a.13.1764186232157;
        Wed, 26 Nov 2025 11:43:52 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm1436745785a.24.2025.11.26.11.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:43:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
Date: Wed, 26 Nov 2025 14:43:50 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
Content-Language: en-US
In-Reply-To: <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/25 9:13 AM, Michal Koutný wrote:
> On Mon, Nov 24, 2025 at 05:30:47PM -0500, Waiman Long <llong@redhat.com> wrote:
>> In the example above, the final configuration is A1:0-1 & B1:1-2. As the cpu
>> lists overlap, we can't have both of them as valid partition roots. So
>> either one of A1 or B1 is valid or they are both invalid. The current code
>> makes them both invalid no matter the operation ordering.  This patch will
>> make one of them valid given the operation ordering above. To minimize
>> partition invalidation, we will have to live with the fact that it will be
>> first-come first-serve as noted by Michal. I am not against this, we just
>> have to document it. However, the following operation order will still make
>> both of them invalid:
> I'm skeptical of the FCFS behavior since I'm afraid it may be subject to
> race conditions in practice.
> BTW should cpuset.cpus and cpuset.cpus.exclusive have different behavior
> in this regard?

Modification to cpumasks are all serialized by the cpuset_mutex. If you 
are referring to 2 or more tasks doing parallel updates to various 
cpuset control files of sibling cpusets, the results can actually vary 
depending on the actual serialization results of those operations.

One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact 
that operations on cpuset.cpus.exclusive can fail if the result is not 
exclusive WRT sibling cpusets, but becoming a valid partition is 
guaranteed unless none of the exclusive CPUs are passed down from the 
parent. The use of cpuset.cpus.exclusive is required for creating remote 
partition.

OTOH, changes to cpuset.cpus will never fail, but becoming a valid 
partition root is not guaranteed and is limited to the creation of local 
partition only.

Does that answer your question?

Cheers,
Longman


