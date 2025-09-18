Return-Path: <cgroups+bounces-10267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F4B865A9
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEDD566B91
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC7288C35;
	Thu, 18 Sep 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShfeIOze"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31C28980F
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218584; cv=none; b=akxyi7dXWvoTZTQj4u5DVtcbzT/so2vzvZk3DsU6jPmzkFJxklq8FET9Zeq6D9Cozl/L8+FJf+pu6xvXSyLeuCYIg1nrrEmPqUUBRZ1+mu9A+lOGVWlSJeUWaVpjTeqKkMazoRN7VNSzZFu0ysqMoe7sVyb2+7+6j9zVqouECJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218584; c=relaxed/simple;
	bh=XxT8u+iK4N3ZpVfpPSQQoQWhS32vuHHe7lGiDofR79Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sVqe7vbey62DQJmXf/OhWrI1+AIXmIo5i4yHKwpmHOkLGWID1k2lpgEpsKHB07vdZ49v8OS6mMeQX9Rr2gWB7Fb9BIonibeJt3XYl3FMJ8J02vyuqzxoZXeMF9FZXbO6WuasFuAPfTBidyr0iKF+Yu+5LK3i3qCIpfSGWkC2AwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShfeIOze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758218581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U51adZP9xD5bx6ycPY2nmgjODkxA3ugTRauNjPXu8AU=;
	b=ShfeIOzesslcoYLVIpw8dymHYxfZ6co0dZa7tkGIilkUydKt85hLfLRYYCS0zI14VlPqAM
	s2ID0ibQXWjv79NO+k3ow/lRLgxKlexj4vuicRNb3LhlVk1vNMl+7yZnabf15uxhkpwgo2
	UL5YmolocSu7YJzHyrNCDFUsIoulNRM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-FWwSwDkMPG68NKrs5PB4bA-1; Thu, 18 Sep 2025 14:03:00 -0400
X-MC-Unique: FWwSwDkMPG68NKrs5PB4bA-1
X-Mimecast-MFC-AGG-ID: FWwSwDkMPG68NKrs5PB4bA_1758218580
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b31bea5896so12027791cf.2
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 11:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218579; x=1758823379;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U51adZP9xD5bx6ycPY2nmgjODkxA3ugTRauNjPXu8AU=;
        b=QfJ3eZiy+GoGHB9jYF8diVFJ/uj36SELunmJ5f0GhOIGS2eTAfAj0Q2aa9Y6xmgiH6
         bxs5jRWoTlim6XJ7On2ThbSSdvJ/ZhG81lQyRDL6uDA+a4vGWDLW6lmpW5ZwMXjeBW0f
         F3MZXKhBi5gqL7e/rQJ230jdsKT00JEtdmmhjeUeVzNnIg3gcESForU8kx9uiNEj+LBo
         gVjRfd23oz9JopjjywV8b00TSbRuyIC8NlY7g4Q+B3FshiMODLqqNysN4OPEm7LFfpYp
         zrUYPzyVmiv8r7OOjpbQRHm7N8g2qqsQtymloc+CZTirZCK6OvisRowWtTBDzcgZ3iL/
         uTpg==
X-Gm-Message-State: AOJu0YwPklthQs/tLgYzaKQPNiuXznQsi1nldHe6aWNUVqNHXTv6iYee
	hrpJMdQtTiHIX8eozgYKe43qqmCwxULipe7PLuG2A8DrL4T3U6PsMFC1PF/gjhkCvI8PnvpFXWJ
	tWhXzOaZApbV8tHXiBnPeudrEBvCxJsodkJHFIRMNCnKf1tv5K2JImUqAFS+FylKOgYY=
X-Gm-Gg: ASbGncsXcWyvgE5LuAdS3Xx/f/q69IjPnChzY9rndPZWHB/5t4cHgC1e5hj4s7iIZV1
	GpeBxAjjzoMrnreBLKp/qV0mKLboGuEtZdR4p6CuJiWMt171lii8bWWP9JmNCnPJOPjvHavOn7o
	w0MWChhiX9eNUuqR0ABSJ4uy3bHeEctgQ5+VykIVdC3CtBE8212bJEovwGdpBG7pxztvpjD2Xud
	3rcWMl9RbIyC2/Ch1RFilN6k7LbhE1CheRaiXsNiTlNdGnFpuplNDSC+IsoTc4pXy1T0lCqVjSw
	Jo76O6KsyYa7dA164tkMknVOYhDPZlziW1rtDaQCFlUldYPUAGqo4LvhlES6pbKWhlNdhEWbhgq
	e6ElMBybPpQ==
X-Received: by 2002:a05:622a:1ba5:b0:4b7:af5c:f554 with SMTP id d75a77b69052e-4c06e3fa8dcmr3985331cf.13.1758218578395;
        Thu, 18 Sep 2025 11:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1uJWgAJ0tJ6qHmhpoAo3yX1E5D9G4wvKoCFxjNHgqEo3pZwa9UX4QI3dTDyzBKZOJAjWdIA==
X-Received: by 2002:a05:622a:1ba5:b0:4b7:af5c:f554 with SMTP id d75a77b69052e-4c06e3fa8dcmr3984421cf.13.1758218577850;
        Thu, 18 Sep 2025 11:02:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b67bcsm16984421cf.25.2025.09.18.11.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:02:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0ee6288f-c621-4c18-bd42-22dd4aa2d826@redhat.com>
Date: Thu, 18 Sep 2025 14:02:56 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 1/2] cpuset: fix failure to enable
 isolated partition when containing isolcpus
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
 <20250918122532.2981503-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250918122532.2981503-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 8:25 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'isolcpus' parameter specified at boot time can be assigned to an
> isolated partition. While it is valid put the 'isolcpus' in an isolated
> partition, attempting to change a member cpuset to an isolated partition
> will fail if the cpuset contains any 'isolcpus'.
>
> For example, the system boots with 'isolcpus=9', and the following
> configuration works correctly:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 1 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated
>    # echo 9 > test/cpuset.cpus
>    # cat test/cpuset.cpus.partition
>    isolated
>    # cat test/cpuset.cpus
>    9
>
> However, the following steps to convert a member cpuset to an isolated
> partition will fail:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 9 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated invalid (partition config conflicts with housekeeping setup)
>
> The issue occurs because the new partition state (new_prs) is used for
> validation against housekeeping constraints before it has been properly
> updated. To resolve this, move the assignment of new_prs before the
> housekeeping validation check when enabling a root partition.
>
> Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Thanks for finding the bug. However, I think the commit to be fixed 
should be 4a74e418881f ("cgroup/cpuset: Check partition conflict with 
housekeeping setup"), not the one you listed above.

Cheers,
Longman


> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 44231cb1d83f..2b7e2f17577e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1806,6 +1806,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		xcpus = tmp->delmask;
>   		if (compute_excpus(cs, xcpus))
>   			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
> +		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   
>   		/*
>   		 * Enabling partition root is not allowed if its
> @@ -1838,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   		deleting = true;
>   		subparts_delta++;
> -		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   	} else if (cmd == partcmd_disable) {
>   		/*
>   		 * May need to add cpus back to parent's effective_cpus


