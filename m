Return-Path: <cgroups+bounces-9144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96FB2544B
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DF7B455A
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8312FD7C7;
	Wed, 13 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayX0ijin"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE22FD7AC
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115764; cv=none; b=uj8CThKMmLiiDyGchTRL1YGIGscZPQcFO8AnGuKCoxb3UO0wILWDl8/T7zOj6VXHnzE6uTR71hKzRxxpc0XnFDmY8g29EKoXKH4Z0DqcxC78VEUSY+ghlskRyEfoxel4QOnDjcefImeeZEJzaVlLf/MijIe4A9l8ERlK/wk7HMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115764; c=relaxed/simple;
	bh=2n4wZwTwJAQn+2kkdeSV5czAJtaQGGR+E9aS+hCH9Lk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T/Gw6bE46Hwn//4jhb/bJjAZFrDYx2YPgcwFOGQStNrBAn3oPmgyNtA100Bdkwvg9b9J9NjSnuppyVBQd9N1TYHr5GNU8HuRiA9+r7LiplON7OfoaNUO3YatNOep9f/o9Xfhvf2RCwdGl1Sysu7QlR9SvsOCuibuunFZl/UlETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayX0ijin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Id7hIB1jKShzLzzptFHUZAPK8H5+qbzZTzK312LljXM=;
	b=ayX0ijino+gqACB+sg3RnZ2w6o91AXlTkVPqIdCi6jWTf2sFVSSeQY3B1lpZS+RMQ0/anF
	m9pSoJeeF81V1P07DjArMwPZLR6M89K45mjxL8jBmidDdbLYyUETKppGgNLPekHp/KUHku
	QR4DCWVi+pdP/7/5TVF1z20yU+zXtRw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-J3PxQJSAM3CZfj-cuGIjNw-1; Wed, 13 Aug 2025 16:09:19 -0400
X-MC-Unique: J3PxQJSAM3CZfj-cuGIjNw-1
X-Mimecast-MFC-AGG-ID: J3PxQJSAM3CZfj-cuGIjNw_1755115759
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e931cca771eso392875276.3
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 13:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115759; x=1755720559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id7hIB1jKShzLzzptFHUZAPK8H5+qbzZTzK312LljXM=;
        b=mSGIK8yiUXjWskUbj4u0HUXAmwGDmZEag7RtcOGY8Wnm7sCO+Jh4W/fckh/smCB2J8
         GT/wmlRVLRPwdCFHDXEIz53KR6jFQlMQzxdpro9+QKxjMi0e6IqJ5og6o2eetBVJkTYn
         2SSKKsWnOQp9ZcvUKtVigTfA1FooWXh+0q0d/EF9lKEcaV6a4dU5Y+V5vIjDfGqM+VY3
         TxPEb0XloF8KITZbQbdJaZ0NMM6JDK0CEQl1Wc5S1RIxxuNKD/SFCCTGsb0Xoaob3X8t
         O7CcQf8ZWTufNNPIiOy2Rq3+l2UK5+KsE9uoxL5Q1gEExnqrkgzXio3AUtfPjvmEBzJr
         95gg==
X-Gm-Message-State: AOJu0YxaSBd0duheZ5GWJIh9LFr7DQ2ZvNS6TFaGi9hez36Cbv1005Ib
	Ff8sJVDZy7YrhCxJO+QTwI/geY8fd/f99FujQiJVD5EIi1McFit8Xrv+PjOjJC+xan3yN4aOJCd
	CId3Z1Z4/8W+0OgNwjiH9KIKGQroluQXwQxN0RNXDJ49XFSitfdsl1aDT7fA=
X-Gm-Gg: ASbGncvECqfOcMykPS2aZa7IYC/kAqdm6TQZu3hQZtjebv24WaLKStI0RfuyH/VlijL
	jr6Bif1TVGA/nlZFl3yKqNpjuOd7eszAMiDSovkRDLywukANSml6JVYvrsU+NIp4GZH5SRpDwkg
	LjUlYa8KMFbwhfkvMdp3G3yXyGxDwBsw9iPJULRciRvRC4hKgpf+dkpTMv8AQ+BwKkshZCAzuJK
	xYtB1AxVDJQXtUNyDEpwn8N2BTiOqK8ieAwjFZSGFFYKvW+YEvcUxU0bqOQXHuKBjL96i6zV0TO
	b3gb994vJZ73YDp8SAlsXUaY4+GNPunWyhq534zT1dAiGwEhJP+mn3eusc3pgBEWJGuBfUfBYAn
	2+axRWsx/EA==
X-Received: by 2002:a05:6902:6b05:b0:e90:7383:cc7d with SMTP id 3f1490d57ef6-e931e191b93mr570934276.21.1755115759197;
        Wed, 13 Aug 2025 13:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpwtZpmV8u1pxNPLlWMiYmxOFFQKXKvZEYc1RrYFUSBfDMMIM6iARj11h42NsnC/JdPE9Gkg==
X-Received: by 2002:a05:6902:6b05:b0:e90:7383:cc7d with SMTP id 3f1490d57ef6-e931e191b93mr570888276.21.1755115758702;
        Wed, 13 Aug 2025 13:09:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e931d56ed53sm128685276.21.2025.08.13.13.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 13:09:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
Date: Wed, 13 Aug 2025 16:09:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250813082904.1091651-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 4:29 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>
> Replace repetitive locking patterns with new helpers:
> - cpus_read_cpuset_lock()
> - cpus_read_cpuset_unlock()
>
> This makes the code cleaner and ensures consistent lock ordering.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  2 ++
>   kernel/cgroup/cpuset-v1.c       | 12 +++------
>   kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>   3 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 75b3aef39231..6fb00c96044d 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off);
>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
> +void cpus_read_cpuset_lock(void);
> +void cpus_read_cpuset_unlock(void);

The names are not intuitive. I would prefer just extend the 
cpuset_lock/unlock to include cpus_read_lock/unlock and we use 
cpuset_lock/unlock consistently in the cpuset code. Also, there is now 
no external user of cpuset_lock/unlock, we may as well remove them from 
include/linux/cpuset.h.

Cheers,
Longman


