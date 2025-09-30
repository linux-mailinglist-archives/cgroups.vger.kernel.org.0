Return-Path: <cgroups+bounces-10502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E413ABAD201
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F619276A1
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F139303A0B;
	Tue, 30 Sep 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu9B6NJV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A12FD1DD
	for <cgroups@vger.kernel.org>; Tue, 30 Sep 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240649; cv=none; b=UC84GYORx8luzhTWEap/wbNP5KJ6BQUj3TpKIuEaobAMo+aFbvORBELQIxPvRCzHyg5m235pLz+Z08LhNI0AUjlYKlQIaqZ1XUHLtvmSzmKSbR69nj+WQxKxqGv8JBo9ECc8osqoGSqT1eQEaBBsQ+b8YpsnpIIYTMFJfFauG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240649; c=relaxed/simple;
	bh=BjipmKiYqvOMqy6wFOLf2B1TFV/73W3I8z7alN1lxDM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ViaQZM8QKsy+LEwqY0uyWxGqXikA5c/Ah5E59rQ+nlE2OdnNs1T/pi3XTeRk7fSg8D0RGK3nIhAm+tSOVghVFluXKEwVpDTRcReJmemtN144CBdtix4Fzi9g1HvfLjaCTuQ/hNtxol3cfWxgbmJJef5qGAEPIjPgVbxKvDk2few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lu9B6NJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759240646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StT/fwa4hIsTlxaXA0cy/bjyM8J68OtRfbRwReR7TO4=;
	b=Lu9B6NJVNc+5wttGty/gX9eTaD1XVuJxSaLY1bWN/jNsjp4ek5fbwR2muH+Za2eZ3u3FMg
	+GS+DZ8+YsvhHDPeWpacUe/tTse/FFnqy4mr5bKoCzKUu3HGvqEn+AbCYtZloaiOh4GDwh
	0M3JiBdhc8nXoNzS79e2GIhpQGpoglk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-rewMwUngMbe7A0OmD-b3FA-1; Tue, 30 Sep 2025 09:57:24 -0400
X-MC-Unique: rewMwUngMbe7A0OmD-b3FA-1
X-Mimecast-MFC-AGG-ID: rewMwUngMbe7A0OmD-b3FA_1759240644
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df10fb4a4cso120676091cf.1
        for <cgroups@vger.kernel.org>; Tue, 30 Sep 2025 06:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240644; x=1759845444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StT/fwa4hIsTlxaXA0cy/bjyM8J68OtRfbRwReR7TO4=;
        b=V6JVD8WroHw0nXoneQtv09ZGzyarpOv7DjtW9FrNP8XxulRvrw0MFY+NBiMrSEG4lL
         q7A9wkAkaFbmulz84HcU11gBRWBjun98OVpAeCswJCP2+uKxz+6ZdX8cmJyq2IjUn0+9
         +DOxtxrpBy9xouKxnp+0Ib1tD/dkOZuDmw3hvSRPrkF2bQ98ge4grU3JYSoZg+2Je3Qt
         Lq//dZ6kFh0efxP2hM6rS9YP6PI2lJIQ/cKOcFbIsz6dW3YPIWFBXYEuBoAcVUa0Yu0Y
         614MFt6MsHH8RFqDN3o6+xNJpy2cGALd7dFOoaM8GZWMztsxwp9Y8MfIaPwVO0/qPoQ6
         bgQg==
X-Gm-Message-State: AOJu0Yy/XqalPk707ty173arsrMx5ok3vuqR2PgM9hbH6LglvpZoQeu9
	vnm83qw8f/s80noVPydwA0Wo4nFORJBS98njZsvWir3Da9i2+X4i+CUFSH4vitO4YHI+HQyJJdn
	ZN2EIpVCis0hJAI6VMl6Otu+z3D089VRM/Abh7yp5j+qcPALLFI8chxIpRhk=
X-Gm-Gg: ASbGncsdqB5LevR+XzaSNqxy6BXVwhrLucXJZJpOt8+cepApWtTEVgxw+xZ2iSxyWi1
	qNiVNPe1iL+iFJ8V5DzaMgCrHvTCuEpqIFRR8AHBAX1BG4X20YFRwfVaK3/WSUKqSnbLnPj5EDc
	x76DPnmY++jd3Qmw2jD95pj/ZwJgf7R7xLzYHuMdzW09dONzO3aVArkeK1DcopjhOaxcGFGIP/2
	jP+tUvxAA6v+0kPSy4f9L7qgIC1D4kugHP+3JqHTEE6ygX+tjVzSgoBhowU/vyNdmPg3ZAvu9Rz
	cbyKr3wqdoayQ5ldtC4Y9Aikw/HVVDUaHIynxCz06peq9rKSogFWHdyiH/Y7kIQ5w5LTsPdryTJ
	jjKf1mpWSYU5FnMLg
X-Received: by 2002:a05:622a:6109:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4da47c057e2mr219780601cf.15.1759240643908;
        Tue, 30 Sep 2025 06:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ERJkEqmQ7ePM8VRv3iVEwz8JDqKErLEOLUqEtBj8xKLCAQv4aJ0I8B9MMJsvQOQqPyV4aA==
X-Received: by 2002:a05:622a:6109:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4da47c057e2mr219779651cf.15.1759240642510;
        Tue, 30 Sep 2025 06:57:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80175168d7dsm95307126d6.68.2025.09.30.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:57:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4d49ad5a-878a-44a1-a4d0-459e56924581@redhat.com>
Date: Tue, 30 Sep 2025 09:57:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
To: Cai Xinchen <caixinchen1@huawei.com>, llong@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Content-Language: en-US
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/25 5:35 AM, Cai Xinchen wrote:
> I encountered a scenario where a machine with 1.5TB of memory,
> while testing the Spark TPCDS 3TB dataset, experienced a significant
> concentration of page cache usage on one of the NUMA nodes.
> I discovered that the DataNode process had requested a large amount
> of page cache. most of the page cache was concentrated in one NUMA node,
> ultimately leading to the exhaustion of memory in that NUMA node.
> At this point, all other processes in that NUMA node have to alloc
> memory across NUMA nodes, or even across sockets. This eventually
> caused a degradation in the end-to-end performance of the Spark test.
>
> I do not want to restart the Spark DataNode service during business
> operations. This issue can be resolved by migrating the DataNode into
> a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
> allow it to evenly request memory. The core business threads could still
> allocate local numa memory. After using cpuset.memory_spread_page, the
> performance in the tpcds-99 test is improved by 2%.
>
> The key point is that the even distribution of page cache within the
> DataNode process (rather than the current NUMA distribution) does not
> significantly affect end-to-end performance. However, the allocation
> of core business processes, such as Executors, to the same NUMA node
> does have a noticeable impact on end-to-end performance.
>
> However, I found that cgroup v2 does not provide this interface. I
> believe this interface still holds value in addressing issues caused
> by uneven distribution of page cache allocation among process groups.
>
> Thus I add cpuset.mems.spread_page to cpuset v2 interface.
>
> Cai Xinchen (2):
>    cpuset: Move cpuset1_update_spread_flag to cpuset
>    cpuset: Add spread_page interface to cpuset v2
>
>   kernel/cgroup/cpuset-internal.h |  6 ++--
>   kernel/cgroup/cpuset-v1.c       | 25 +----------------
>   kernel/cgroup/cpuset.c          | 49 ++++++++++++++++++++++++++++++++-
>   3 files changed, 51 insertions(+), 29 deletions(-)
>
The spread_page flag is only used in filemap_alloc_folio_noprof() of 
mm/filemap.c. By setting it, the code will attempt to spread the 
folio/page allocation across different nodes. As noted by Michal,  it is 
more or less equivalent to setting a MPOL_INTERLEAVE memory policy with 
set_mempolicy(2) with the node mask of cpuset.mems. Using 
set_mempolicy(2) has a finer task granularity instead of all the tasks 
within a cpuset. Of course, this requires making changes to the 
application instead of making change to external cgroup control file.

cpusets.mems.spread_page is a legacy interface, we need good 
justification if we want to enable it in cgroup v2.

Cheers,
Longman


