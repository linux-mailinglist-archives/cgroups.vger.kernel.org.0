Return-Path: <cgroups+bounces-8389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1DAAC8007
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE87A51CC
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ABD22B8CF;
	Thu, 29 May 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI4plPle"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5321D6DC5
	for <cgroups@vger.kernel.org>; Thu, 29 May 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531666; cv=none; b=rPtturJGgLzwGkKaZDTyUxldJWE7YZdSX1PfSXnMLQKt0UC/Mq+Ne3yt3/W8NUBycK+q+n1XDHsbLDrKckqj5m+NmVu78aX12+pE4eNoE+FD/FcWYyEcHGh8vUtiBAfYQdcbJd3G0XHvokr59q49kKRo0vRgw3EVRvFoFMABcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531666; c=relaxed/simple;
	bh=cwNm1GmWt5ikXZTBZbIp98sZUDsmtxl3/qB1q6q04FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0RJBD/ahkMCKb+5TndCN0HPbgT9y3koRQqYddHPCeqa8Ka322mwsihrKvWXZJGJG3ScFRUHRrWmakRimTLHE8/1IBAjY2QtDKk04mE7+KIwS0KRJZpkvJ8GeWisGNbE8vosjrAF10RKtVg0oCV930raWS8bmGZgEia73eK+pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI4plPle; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c9907967so1060616b3a.1
        for <cgroups@vger.kernel.org>; Thu, 29 May 2025 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748531663; x=1749136463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fYynU+ZUdZc93Qsg3tbeRmn765wH2o6oGD/ACQ9L1E=;
        b=aI4plPleXyglguRMV3V8df6eT9fTcq9nFQmskbvErB8rbqolW4hVD32q+USsN345yf
         F1G1H8r9BQ9EuDrJRhu58RHCww90timkbZgXDnHHS1lb41pQ5SCa8v7bArfVKOfiVXiF
         ZIUWDIT/kb6LyJyOqOARaozMqCM8GWVbHUOli8ZqTXS91w1WbArnbJq6HaSDdyKTNlmP
         FnpF4k6PEDvQru7Nusy6Y14fIbTApb+AfJWPbXdcgZMxvnG6754ONmOiVft2RQ/RSJl2
         CGHw9KqH+VAPTElrzZMH/QxcbxZQWtdIPjAqOD+gYfk8k0mafCkcr5fmTm8BRM1npD24
         FYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748531663; x=1749136463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fYynU+ZUdZc93Qsg3tbeRmn765wH2o6oGD/ACQ9L1E=;
        b=sy9E+kb8UBhJZ3yLivvVSDiHwb05ARl5HU3RblmqLCpJaueoIKU7RVbumQyOaRv6kO
         7E+FUlWgGpA9ZxumX8D1TGoFKoDycwrX6usNWEfjsykHO0GpJ2pt/XgK+JS4ZDrApaQP
         MqHYYyNgaJqizeEVCkySpvEceK9jvdKzF//U7GzQfu1Z4GzIpH596GvlkzMpA8Jamu+s
         9zjEJWrkrSSKbqLaAuKssbb7ckotlatv1SyC6mhOVFGvlPFPRmvtL/PxRGMFq7LmUVAW
         LoNztdZYQzRstkBem6F8p9a4DGpunjGW3uDNNBnensj8RWob4fUFhatmisXX2ZzvqxNv
         U1AQ==
X-Gm-Message-State: AOJu0YytQf3F23CIEz6+7JVQuhMLWKro1s6i4j40vXryhxVo6M7vktOY
	FrtwXpiikAfNLwCtYX2nzgiZ1R3LelCyZ3Zia++3ZisoMxjlJzqmn4nl
X-Gm-Gg: ASbGnctEI0/92TiMjfHIgk+UOClRrVjtkKOlYWmKo0RSpopCqKTU9doLWqEvXmJc1mc
	dOlcZC5hIJvrm82O0GDBRP0g8ip2V2OAUvrD/myLD1sK7PGAjoo4d1g0id7kTepQ7UX7g45c1/j
	3H0lshCll+L/ukdqdxcf/Hjep8CJd5PRIuV0yi+TeDeyYrGPemCFIuHGU2BJXw7MAY0P2sOMwDB
	rxpVpt0gOD9Q1D4x8kdDbK5DqjxWUuTTm0T3WLgF/F5IY/4TenSxNHDghSQ1B4XDcQBrYq2PTnV
	l421YItYGdy9xCJljbZq3GiULpXQkzQPuTOLq9iJukV+RlmlKFfGeX78izz40hFY6K0BO+nrCVE
	zW2znH+nI1yRe/azZ5ZNppw==
X-Google-Smtp-Source: AGHT+IFyl6gYTui/Z21Z7qpsg2WqLRNbIyPov8bV+gRNOOV0UDFZx+ZuFPkD3p5UagZSamZkk0DIsQ==
X-Received: by 2002:a05:6a00:1747:b0:736:73ad:365b with SMTP id d2e1a72fcca58-745fdf513admr30346396b3a.14.1748531663078;
        Thu, 29 May 2025 08:14:23 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff72bcsm1458224b3a.166.2025.05.29.08.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:14:22 -0700 (PDT)
Message-ID: <563a7062-0530-4202-abd5-95380fb621ca@gmail.com>
Date: Thu, 29 May 2025 08:14:20 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
To: Waiman Long <llong@redhat.com>, tj@kernel.org, klarasmodin@gmail.com,
 shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250528235130.200966-1-inwardvessel@gmail.com>
 <35bd4722-cd02-4999-9049-41ba1a54cade@redhat.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <35bd4722-cd02-4999-9049-41ba1a54cade@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 10:23 PM, Waiman Long wrote:
> On 5/28/25 7:51 PM, JP Kobryn wrote:
>> Previously it was found that on uniprocessor machines the size of
>> raw_spinlock_t could be zero so a pre-processor conditional was used to
>> avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did not 
>> take
>> into account cases where lock debugging features were enabled. Cover 
>> these
>> cases along with the original non-smp case by explicitly using the 
>> size of
>> size of the lock type as criteria for allocation/access where applicable.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to 
>> avoid contention"
> 
> Should the commit to be fixed 731bdd97466a ("cgroup: avoid per-cpu 
> allocation of size zero rstat cpu locks")?

I chose 748922dcfabd because that is where the underlying issue
originated from, and 731bdd97466a was only a partial fix.

> 
> Other than that, the patch looks good to me.

Thanks for taking a look.

