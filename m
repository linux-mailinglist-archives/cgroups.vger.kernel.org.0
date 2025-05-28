Return-Path: <cgroups+bounces-8372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81810AC6C99
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0086174DA1
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23E28B7EC;
	Wed, 28 May 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8wf563y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451B28B7E0
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445016; cv=none; b=C1/wL4ygo2mzVelVtgvQq/u93MFUpwhLjgfnbc69Px61zU/8oAB2Tn0Qig6Aw5nzQ5KpaUi/6ANEHy6ANRNLeHjynu6bL3hYIjEVPDh/QVsuwkabw4FNJiK1RbeB+RzxvxPFZ8eU5MPBaiDmBN40kfmyE/cDM8HazD4bW6i21V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445016; c=relaxed/simple;
	bh=YX3cbfI3UDZr05QJ6sediK/4QgiEC77b2/6I38IoHJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+IjL4W/b6Fon5hy1eEpC7VPCZEQLUDtdsVje3n24QvMB0ZYsxHJRSkkP0Bdqx2iqV+KzpISeIzMVKvD9b5OXelzSB/kMwSx+D4cG8371omlGQM/0qLq9EiS6NmXUd89AW9fPfB7T4aiiBQP8oHfgvzj2vyPY1qyimIKLuOgM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8wf563y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231e8553248so36840495ad.1
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748445015; x=1749049815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lS+IITXVYbwmEt57Wt8xR3wd9E3w38pAQjroCrxWsXo=;
        b=B8wf563y5kyRSLafkYLhaTf1HLIwQeVLZRJbpuzyDAcB1EnfYgesV3JdpiRXeqtiCg
         YSHMgrYeeGAD/L84gapTypiJ/zIQRSz2mQprtmVnEYKu/qAeVrum/V4wojr+SWAfmiJX
         loljj6VPlrwljeJUu1wkbZU7eWvHcAeRj+np14DTjqfr0e7QUrokEdrLJs+9NJmR6EJH
         v2lTXEH31ppk50p9r7wENxcXWgbN9qPQP5qupL+tEvYzAqDLSA/cGFTU0oQhSpfjeuUl
         tq49YPXXRvMWs6jIf3LCXiEj1MCxIZwlxuD9Ih7ubzDruksxjMiPenUX4MjnlsuFJqtN
         lRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445015; x=1749049815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lS+IITXVYbwmEt57Wt8xR3wd9E3w38pAQjroCrxWsXo=;
        b=GksT4siO2EyeXTFqznEFAUeP4E7ePj+4mo3bqKA5X1x1PQ+XF8mNy6/v586byzEzkD
         gI1bMmfE9RL8erE/xHSgsiv4QFzupH2Nojb6XYm2o2Cbx30laglE1O9gwaqft5ocVL7P
         dqgv9SEDS8DIcypKQaaGOQT3/AKAe7bEdooVAlo1vqQC9bW3vz00k9h2/VXMvSwqLeY6
         dnuLiHskYlQid01Fz2B+n1biMWGtcAGeUu2UsGt7MIt0oW+rk9ZOnfAL5aS+qjCRaedP
         +KzxFGLmzoPRoOVs0WXs0Nev7WilSh+0hqHiQi16lYbDDxpTRw3GFKMOMwYIG0wocmXu
         DWlg==
X-Forwarded-Encrypted: i=1; AJvYcCWZlP/Hs7ULgRwXrIbJPdTdfKC/2Fa3VZAkIGZ602eqY8rU9MAA/BRUKSe/dojl6hDK/Q6UgRxx@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5br7gtTHqxUBCCtqiAPISWWCX9xWp28C1ERTYB3FfzyRNs5F
	Ho0lyMvrzJcY7YIKyx+a4TMvu+O2mu357pnTgJJAT0zrogrQrnLXGQ/Q
X-Gm-Gg: ASbGncu/Rvq8XJVhdeqb5wRzkgoVNqyol3qbKM5v1o5fcIDlbV2cb3fQtz9jS9oKyDm
	CmjQQDAU/5PVHf+3cE5lHAQnmn2iOe6QOElGK5/Ar41Pxz6pb5QHA4mxux40Yy2U1Ngb8rhfbHK
	Nfdh4J/V6ssM46RoBwBXbphKVV3htY0cPy9NlZBoPunEjkMlyiXaQqYaDPdhSbvFrqHptc7KvM7
	TQrfHoIkQ6wTlVZQ9NjNr2ocBeiRx94RuNZ0oFWEeJ+Y1rDDTKGS/XlR5FQ3Dwuf4Ey+99jJAS4
	6kE59kyaCYhYj2EJ90UMAaDkJLvz9Ck4eHWWc6WGqeUINS0iQD1HafWjC2VoZHIdmOZKsD3nwGs
	dYXFndyKuUeOynWWj5PVGkg==
X-Google-Smtp-Source: AGHT+IHDvzhWFGQ+EFsXZRgQfe3AKYf5iaLGg7mBUcY1L5P73eY06qAvwxkN4N5nJyglu8nMyieo7A==
X-Received: by 2002:a17:903:24d:b0:234:c549:da0e with SMTP id d9443c01a7336-234c549dce2mr61838205ad.47.1748445014597;
        Wed, 28 May 2025 08:10:14 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd2313sm13065915ad.8.2025.05.28.08.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 08:10:14 -0700 (PDT)
Message-ID: <9b500a3d-296b-4643-85d3-78d7bd6ec66b@gmail.com>
Date: Wed, 28 May 2025 08:10:12 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [cgroup] 731bdd9746:
 BUG:kernel_NULL_pointer_dereference,address
To: Waiman Long <llong@redhat.com>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Tejun Heo <tj@kernel.org>,
 Klara Modin <klarasmodin@gmail.com>, cgroups@vger.kernel.org
References: <202505281034.7ae1668d-lkp@intel.com>
 <15942ff6-a2d8-4f97-9818-1ff1b269428c@redhat.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <15942ff6-a2d8-4f97-9818-1ff1b269428c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 11:25 PM, Waiman Long wrote:
> On 5/28/25 1:00 AM, kernel test robot wrote:
>> Hello,
>>
>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>>
>> commit: 731bdd97466a280d6bdd8eceeb13d9fab6f26cbd ("cgroup: avoid per-cpu allocation of size zero rstat cpu locks")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [test failed on linux-next/master 176e917e010cb7dcc605f11d2bc33f304292482b]
>>
>> in testcase: boot
>>
>> config: x86_64-randconfig-123-20250522
>> compiler: clang-20
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> It is true that sizeof(arch_spinlock_t) is 0 for UP config. However, 
> sizeof(raw_spinlock_t) can be > sizeof(arch_spinlock_t) if some of the 
> lock debugging configs (like LOCKDEP or DEBUG_SPINLOCK) are enabled. So 
> commit 731bdd97466a2 should either be reverted or sizeof(raw_spinlock_t) 
> should be explicitly checked to see if alloc_percpu() should be called.

Good point on the non-zero state when debugging is enabled. I'll send a
patch today that changes from checking smp to checking size instead.

