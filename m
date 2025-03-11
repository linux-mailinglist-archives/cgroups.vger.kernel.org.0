Return-Path: <cgroups+bounces-6983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C9A5C55B
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED06189D8F4
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40925EF88;
	Tue, 11 Mar 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3NVfWbs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D325E808
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705849; cv=none; b=LP7ORHiocEYAWg7ef29gOKNPuuFPX0JpozKFcvynxdlZMWqXDbxm+7MbeYa3tHXwYheHECLZQMSEkQWamIqrvzHSw9t8SN5tf0UBNHehhDT1v2v7vhEc4mMBvBKomsfnlaRknS1ZeCP+++g7HmNPmHP391Vvg7TT+JfnZvoEkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705849; c=relaxed/simple;
	bh=lc3UTP0ZxyZIpkj9wcJGmsEjDsGWkzn+ParWIOHIXDE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C2iwq/YIbkGOASNAaEj8QaXD4wRgF4H+jP1XPcY5kSa5hmJWHdU7qRpc/R8ep9xxRtp0p9yBjZuXqz9SUGtqREdRMLUfEeQGh6eG7roNEM6GJocXjShOgMhCk7PBN+XnSV1REFlCpHOqjg5Fv2QihitdjmG0a4PyZQzpTgvNMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3NVfWbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNFxfNmAhYZ31S10OCFBpFK643stUwCJOknX62r8PZs=;
	b=S3NVfWbsR1uaui6PN88qeEnwvfH+Tq67bvkdw+qTKO3WBGGh2jXAOELz8onG4lG7TQripa
	YruaZY/bFntVDbwWE6jWkPqYOufwz4g37vR0G1/ArGd1K6VqBa+Fib6NnsRtpvT+0fE/lZ
	vShtPNiO6dAB0Luq19oiWzD837fVLuY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-gbod7i0-NRyWgWlBlh3KGQ-1; Tue, 11 Mar 2025 11:10:45 -0400
X-MC-Unique: gbod7i0-NRyWgWlBlh3KGQ-1
X-Mimecast-MFC-AGG-ID: gbod7i0-NRyWgWlBlh3KGQ_1741705842
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f9057432so28207016d6.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 08:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705841; x=1742310641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNFxfNmAhYZ31S10OCFBpFK643stUwCJOknX62r8PZs=;
        b=UM3pPq6j9Q7PMvwbko+mg6/CJM0P3ypbB6510RT+K2aIHq2o3FXnSyHjJYYBi3IpLi
         ziRlMcQQDG6sSaa+Q0+1lrqpT7FbGiJbtSjG5+yux7VEah/ipDCJ8lZOGgav2vRFD84G
         eJCVsFGr32AY7jRoNr6DH+YsLEIuFt3NII4dDQjiyMQxa7b42USChcG18jphM2hCUu5P
         /lC/YRY0w1JQaEbG1YPSojMKFnPybMhQkfauDCpyc8vJd8GjLnKngbOCV53/GOzP+NI1
         jMn30XVxVW8p87cnMqc8K6aQdHk6zWDh2j+QYG95MilSifiOBIor3Uv/0mLD3Hqs60Ya
         8K1A==
X-Forwarded-Encrypted: i=1; AJvYcCWkryN4TtvIP4VqVkadM/RTUic2ctBtACV5jb+Cu1NOw6uxHCc4/RDPVKM2qud6CRORn0sOklkx@vger.kernel.org
X-Gm-Message-State: AOJu0YxTArrqh/vyCfOtrBoZRTQ4nuJUEuqnP35wfZpmATTsHgq2oUzG
	n+pRND2j8OHwJhfmhCXVWAzARIfGjLjuWP9eKrWBYxADwF/rwhKz9fErYPttTDWjYXu8528Lvq0
	2t87ZW2YLn5OvMNgyGv7G+xl02sXEK8C/PG6jvKuPMwWH1L2vggDeETo=
X-Gm-Gg: ASbGncvcfQS6NZKenDh4TDI8EOSGtiqZVHEXEEsQ1uvVSiHu6UcNUQk2h5CJQxnetlW
	7NaB/kN9xj9yIMw/KET443h2ilJB7FqAEjqcWe0gYHzh6lenZ1qjefZgXZSECaFkY0F5ICda1Q3
	u09ydVGdpqIjrSF03rJVfjIMBSQKFbz1kcBLqNthZm79uvx4BHt/E1WolclJgtpe2De1kQHHfbt
	Jb6IQhel4XwrVwx9sTxOhD/eM8oge2UFnP4fIgIYzp2pC7owV60PTFjhTNtsPH8Fv9Vj7I+vS2V
	Ih6EHsl+tgsZ7D5lZvYqAhqfTjw+QqlRlcosFbhhoEFpBsQ1u/GgFvdiHnjhRQ==
X-Received: by 2002:ad4:5f85:0:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e90060978amr285486686d6.20.1741705841765;
        Tue, 11 Mar 2025 08:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENeUdJzLEPf5ux+cN6yT+ztM3rNavCrbq+PEZK5l2/3KSyFaBY3i/mWphwZI9wuuSn6zC4KA==
X-Received: by 2002:ad4:5f85:0:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e90060978amr285486166d6.20.1741705841402;
        Tue, 11 Mar 2025 08:10:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm73179216d6.64.2025.03.11.08.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:10:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b572a4b-a68b-4766-abb3-fb1e964c59b3@redhat.com>
Date: Tue, 11 Mar 2025 11:10:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] RFC cgroup/cpuset-v1: Add deprecation messages
 to sched_relax_domain_level
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-8-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-8-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> This is not a properly hierarchical resource, it might be better
> implemented based on a sched_attr.
>
> Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 7c37fabcf0ba8..5516df307d520 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   
>   	switch (type) {
>   	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = update_relax_domain_level(cs, val);
>   		break;
>   	default:
Acked-by: Waiman Long <longman@redhat.com>


