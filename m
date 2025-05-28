Return-Path: <cgroups+bounces-8373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D19AC6CC7
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84723AEA7B
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78328C2DA;
	Wed, 28 May 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rn7UjnIa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32B28C02E
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445838; cv=none; b=Y0Bj8/i2+IJM9D/U83SKQFQA3q6aPDiVNkkwfjOfTzFFnr5RQJUgelfMiKMAc7K92F7Js0i8KqbupehXE/cnVB5vjrRQnJp+IpnTqhEZIt3Lp4ST6R/DKj3CVyMGClLOqhD4aSUmp18cdllqb1iTo6+Npqick3rBd4QsjPSuXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445838; c=relaxed/simple;
	bh=OlIGNsrljXEWvdinSyO4J4xZYqnP3RN9MssjhHD6S0U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=lrRC2nJllKsKWmBxhmp2Cv4RTfBOg0WhkvuIvSVcCn9HLWE0fR7ERFA3bws/pj5MwgCdgFF3z3M2ABciDxCp9ZF3TKwij6LFlhyiC56d/UQ/ywpl0qTvakEicqM/Fm1S3U2tcll90eP6ANgRLias9tPgR3LRvZzQRsLMj/zE3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rn7UjnIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748445834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VptaC6vHWAhUvWn27KJmHAqHCa7LDR5CmGrJB91xBRs=;
	b=Rn7UjnIahdMPfZQS+TRSMa79rkqeUMClD7l9VcBlGMT7M89uF4M6uoAhdge33hq+neU18g
	g34+ArW6pwzJnthSi+3r9DD1NJrAATQfMhmQvix1zW/kVMmIYa7EX7XZ2rbpS9ppWl/E1o
	M6OH+LO5AaTHbmVsMk5cQ55TYEOU+IE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-P2fAx-sGOMyNW62FgT5kLQ-1; Wed, 28 May 2025 11:23:53 -0400
X-MC-Unique: P2fAx-sGOMyNW62FgT5kLQ-1
X-Mimecast-MFC-AGG-ID: P2fAx-sGOMyNW62FgT5kLQ_1748445833
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c579d37eeeso601276985a.0
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 08:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445833; x=1749050633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VptaC6vHWAhUvWn27KJmHAqHCa7LDR5CmGrJB91xBRs=;
        b=NJQmEtUHhnjy9N8uK4737tRBcE26CMmbiyNoznXvb3fvT4uk8N21dg2Q19YnlsjwUS
         n5n4QjMzQmD8qXrQ3dJNAb+MH+cgwM2tVCXvlooUw074Su2UlgkBEf8EQk0TaUtz9BoE
         9pO7F/BC98VL3LLiorL9GG0HkzlfEi8oXusiQ6enaH7ptqys1kOXktsyKKBg/dk66+pP
         QeHTIOJikHaCYf+nTOc6EOxJULt1iyKUnMLQTjvakFItBLzqooYmBzKgNhkOl5xDlNGt
         LsQX8lToOtjZkxdQ+r9pflSEEMoRIyMPXAm4qHcBbEtPaljQt8+ac9NMSD2pIR1LWIiN
         h5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0VqTx8aWWDl2JW8KQZF+/9ENNCNNiOuPWJoLOpFawljlf8NNWVPrBQKS07yEEXHEZ4TUT+JtR@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8mcyy+bUOjadGRl9uXX8n60bKjfhCQs6iKFJi+50kWnCgTIo
	oyVIraAiSo5+Y3R0HMVkdcb/hh5S7xjVKSb7LnNgKXdh7tBolEEIR3SmmYBDJejP3b2DvQvxY7J
	vELwRF1UlgC7cOqfpGwb1NpaJf8+MOhVjh9rSOFopK39r4WkXsWRZcyl24HU=
X-Gm-Gg: ASbGnctj8ZJHWv51k6EoXgdoHo1AB/wRgA06twNDN9NvHsTPYrR7MJDOaFK2nb0z9/E
	0va3QbCxGpgbY9YfAcY+24co2FyNtxS8sJPqRS09IpyQJpuqqF4tHbwKbdTKOSnENCyeeGm/EpF
	vLyrlPyNRqBKaEXhKn3dWsjD6oV7viFW7Sbyt0xLHpfqC7g9kvgVLD0x1c4IjNCjH2KDrgcj0+w
	1tnCgNIEMaXfXq9Qv6jGw3hoCvnLTsWpBwTm0ZYoXZ6qsPF8HJ9LvRI21UZbumv9N9P15xSnDBd
	cr1jmsJ+qoog
X-Received: by 2002:a05:620a:424a:b0:7c5:55f9:4bc1 with SMTP id af79cd13be357-7ceecc27054mr2090624485a.42.1748445832841;
        Wed, 28 May 2025 08:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnQ/I5pD0hhQow2ppXrZml7+WUDRAt7CMy+wi3zoafLJfGV00yEjXt2imSZol2wlQaaiVzAw==
X-Received: by 2002:a05:620a:424a:b0:7c5:55f9:4bc1 with SMTP id af79cd13be357-7ceecc27054mr2090621085a.42.1748445832382;
        Wed, 28 May 2025 08:23:52 -0700 (PDT)
Received: from [172.20.4.10] ([50.234.147.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfc5d486c8sm81211485a.101.2025.05.28.08.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 08:23:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <99be9c8e-a5c4-4378-b03b-2af01608de9f@redhat.com>
Date: Wed, 28 May 2025 11:23:50 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
To: Vishal Chourasia <vishalc@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250527085335.256045-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 4:53 AM, Vishal Chourasia wrote:
> The documentation for cgroup controller management has been updated to
> be more consistent regarding following concepts:
>
> What does it mean to have controllers
> 1) available in a cgroup, vs.
> 2) enabled in a cgroup
>
> Which has been clearly defined below in the documentation.
>
> "Enabling a controller in a cgroup indicates that the distribution of
> the target resource across its immediate children will be controlled.
> Consider the following sub-hierarchy"
>
> As an example, consider
>
> /sys/fs/cgroup # cat cgroup.controllers
> cpuset cpu io memory hugetlb pids misc
> /sys/fs/cgroup # cat cgroup.subtree_control # No controllers by default
> /sys/fs/cgroup # echo +cpu +memory > cgroup.subtree_control
> /sys/fs/cgroup # cat cgroup.subtree_control
> cpu memory                   # cpu and memory enabled in /sys/fs/cgroup
> /sys/fs/cgroup # mkdir foo_cgrp
> /sys/fs/cgroup # cd foo_cgrp/
> /sys/fs/cgroup/foo_cgrp # cat cgroup.controllers
> cpu memory                   # cpu and memory available in 'foo_cgrp'
> /sys/fs/cgroup/foo_cgrp # cat cgroup.subtree_control  # empty by default
> /sys/fs/cgroup/foo_cgrp # ls
> cgroup.controllers      cpu.max.burst           memory.numa_stat
> cgroup.events           cpu.pressure            memory.oom.group
> cgroup.freeze           cpu.stat                memory.peak
> cgroup.kill             cpu.stat.local          memory.pressure
> cgroup.max.depth        cpu.weight              memory.reclaim
> cgroup.max.descendants  cpu.weight.nice         memory.stat
> cgroup.pressure         io.pressure             memory.swap.current
> cgroup.procs            memory.current          memory.swap.events
> cgroup.stat             memory.events           memory.swap.high
> cgroup.subtree_control  memory.events.local     memory.swap.max
> cgroup.threads          memory.high             memory.swap.peak
> cgroup.type             memory.low              memory.zswap.current
> cpu.idle                memory.max              memory.zswap.max
> cpu.max                 memory.min              memory.zswap.writeback
>
> Once a controller is available in a cgroup it can be used to resource
> control processes of the cgroup.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..0e1686511c45 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -438,8 +438,8 @@ Controlling Controllers
>   Enabling and Disabling
>   ~~~~~~~~~~~~~~~~~~~~~
>   
> -Each cgroup has a "cgroup.controllers" file which lists all
> -controllers available for the cgroup to enable::
> +Each cgroup has a cgroup.controllers file, which lists all the controllers
> +available for that cgroup and which can be enabled for its children.

I believe breaking the sentence into two separate components is actually 
making it less correct. There are implicit controllers that are always 
enabled and do not show up in cgroup.controllers. Prime examples are 
perf_event and freezer. IOW, only controllers that are available and 
need to be explicitly enabled will show up.

Cheers,
Longman


