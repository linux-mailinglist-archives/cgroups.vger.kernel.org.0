Return-Path: <cgroups+bounces-10484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3FBA7471
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD52188FEF8
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4578222A4D8;
	Sun, 28 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6zhNg0k"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393661C861E
	for <cgroups@vger.kernel.org>; Sun, 28 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075246; cv=none; b=NPIozKmzBc3hxvkrUeNeGeRjvic+8Vgjgt72c02WGzUk8pkhprIpZGy1blDnW6LyQ2HzssT+9l8Grj7qwMVzWiUBUYS04jXlS0r4BVmfjU5tk0j8qohD2YMl8cUd06tOicRmzQ9eplc0dWO712XqSbAmy32WOxyZti45p2JIwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075246; c=relaxed/simple;
	bh=9LrQVIBHMJJ9SOBDZ8aAkPl2odbwkgagrOP9lMew+n8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S6XM2p6TmVzBZDQiFYNVtP7+GNYhmEJbuGyc6zwYh7eURyqVq+sib1q+NTtgWxq4RTlITB9BHM5LAUxrxZ/W8UPc4+/af9beL5jcTYIj06XpCzW8WL9FFIr1oedmBdPj2EMywBV7GNGJ36TeBnd5WAu6B/aCHKkx4QEclYo70OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6zhNg0k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759075243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRFlrSNo+OKIG+sGNz6RYa1m/9yNjqMbQ2/tMAQzkUc=;
	b=F6zhNg0ktj79clhXdvX4NNsQZpmvCOSePYyU9Lm0kjt8iaZgdaZKYhgI9yvewyitVdp35m
	QxThh29xgcDtJVohBfzW42L69eit9enG84neGhuXZ6TdfM/AwvSWRbLn9fVLldJDewMJ//
	9lZqJAeb+ITHLNiUeq07cPKRlV2d8pQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-6uhDpK56M_6CaFCElpjKsQ-1; Sun, 28 Sep 2025 12:00:41 -0400
X-MC-Unique: 6uhDpK56M_6CaFCElpjKsQ-1
X-Mimecast-MFC-AGG-ID: 6uhDpK56M_6CaFCElpjKsQ_1759075241
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dd932741cfso64424231cf.1
        for <cgroups@vger.kernel.org>; Sun, 28 Sep 2025 09:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075240; x=1759680040;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRFlrSNo+OKIG+sGNz6RYa1m/9yNjqMbQ2/tMAQzkUc=;
        b=wcxnoeTQIW0QQhoG6WgEFJiNR+FJJG60sZPrE9sIQHZx7LEA2ofZoM9RoT5BuIvWIh
         e6XpAOR7LTZBCJhsCF1b2/fy4iOhlFDr/P2yuHODaDIQddQYR3XrfO1MdXYJwvagdRem
         faLnK9GL7gQSMqhswDF0+PxUarjycfwNOKzIj+7HVCkENB8pvpEGnQSL4NpRGTwN93uX
         eXni+okvG1MXOTTVAuHI5v9/wdTECmQIa/c7OkI90qL6RzqUCna8GuSfc+afImQQeobW
         F6hP8YdEOtAzMVai7aLKnYBC6Fyt6MrYLjSnR0UMvtw4wceW7SZ/EWeD5+utM2xUfU98
         5YDQ==
X-Gm-Message-State: AOJu0Yx+awqp3v0oKGn+5eJm2X7ns1G8ULINqx3gzEP2kmgfLdu8dFCp
	qVl1WvjSljTiYFwpo0xaXLCHyldLCnRigbOygg99PWRsgJvs/pNWPkA4KfMU/O2QC/RXeVhyCzf
	LZgvRLvNFa6FL45wH0aN0GHTY+gkGdT4nIHfgXSbv9dL0fYz3OdTpykccff0YN/jed0k=
X-Gm-Gg: ASbGncs+0Q+K4xEKlnSBW8m0OQZcJ79X4EwsJ8Rm2EaXy4uq/3x1ldoAe3naES2btVJ
	Lfac0y2SCo5ZjPxO5z1hRXxR/iIQ7awYqX8zqFEZvh3TFOYaR6Cc6nVGCDH3op718pL/PH6MsIa
	GxLgGKloLsuaNYt74xr7ClkXW5oxr0e8g8g0la2Ns1moGyAJgSGTDTmeDXQTwQIc+NyhGPjOCPo
	OyK4IRHIu/c/QsIrunoQVrbRGPXEdiEIj3kQAqZhPlCS6vkJj0OBomrn4dbOP/fuqW+ap4IXZkp
	SrIxkdYP6tvYhRM1ftHcbdxHR8khzB/f93opzb20G12KJNAf2p323mcHPbOhcSGa/nHTsmZ0Yb/
	AFUzPRC/uKUw=
X-Received: by 2002:a05:622a:4a87:b0:4b2:d865:3e5b with SMTP id d75a77b69052e-4da4c9666cfmr178206631cf.68.1759075239747;
        Sun, 28 Sep 2025 09:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1hINZSe24nntpK+BqyGEpQ7rcyf8UCeVwRKAVOUGc5zCrNOVJqPmei1m/A3TJr+fANHcmSw==
X-Received: by 2002:a05:622a:4a87:b0:4b2:d865:3e5b with SMTP id d75a77b69052e-4da4c9666cfmr178206101cf.68.1759075239286;
        Sun, 28 Sep 2025 09:00:39 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c29ae247fsm603456685a.30.2025.09.28.09.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 09:00:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8a6a99e8-f171-4f1a-86db-21ecd3cd2287@redhat.com>
Date: Sun, 28 Sep 2025 12:00:37 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 00/16] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The current local partition implementation consolidates all operations
> (enable, disable, invalidate, and update) within the large
> update_parent_effective_cpumask() function, which exceeds 300 lines.
> This monolithic approach has become increasingly difficult to understand
> and maintain. Additionally, partition-related fields are updated in
> multiple locations, leading to redundant code and potential corner case
> oversights.
>
> This patch series refactors the local partition logic by separating
> operations into dedicated functions: local_partition_enable(),
> local_partition_disable(), and local_partition_update(), creating
> symmetry with the existing remote partition infrastructure.
>
> The series is organized as follows:
>
> 1. Infrastructure Preparation (Patches 1-2):
>     - Code cleanup and preparation for the refactoring work
>
> 2. Core Partition Operations (Patches 3-5):
>     - Factor out partition_enable(), partition_disable(), and
>       partition_update() functions from remote partition operations
>
> 3. Local Partition Implementation (Patches 6-9):
>     - Separate update_parent_effective_cpumask() into dedicated functions:
>       * local_partition_enable()
>       * local_partition_disable()
>       * local_partition_invalidate()
>       * local_partition_update()
>
> 4. Optimization and Cleanup (Patches 10-16):
>     - Remove redundant partition-related operations
>     - Additional optimizations based on the new architecture
>
> Key improvements:
> - Centralized management of partition-related fields (partition_root_state,
>    prs_err, nr_subparts, remote_sibling, effective_xcpus) within the
>    partition_enable/disable/update functions
> - Consistent operation patterns for both local and remote partitions
>    with type-specific validation checks
> - Fixed bug where isolcpus remained in root partition after isolated
>    partition transitioned to root

You are really active in restructuring the cpuset code. However, the 
next merge window for v6.18 is going to open later today or tomorrow. I 
will start reviewing this patch series once the merge window closes 2 
weeks later.

Cheers,
Longman

> Chen Ridong (16):
>    cpuset: use update_partition_sd_lb in update_cpumasks_hier
>    cpuset: generalize validate_partition() interface
>    cpuset: factor out partition_enable() function
>    cpuset: factor out partition_disable() function
>    cpuset: factor out partition_update() function
>    cpuset: introduce local_partition_enable()
>    cpuset: introduce local_partition_disable()
>    cpuset: introduce local_partition_invalidate()
>    cpuset: introduce local_partition_update()
>    cpuset: remove redundant partition field updates
>    cpuset: simplify partition update logic for hotplug tasks
>    cpuset: unify local partition disable and invalidate
>    cpuset: use partition_disable for compute_partition_effective_cpumask
>    cpuset: fix isolcpus stay in root when isolated partition changes to
>      root
>    cpuset: use partition_disable for update_prstate
>    cpuset: remove prs_err clear when notify_partition_change
>
>   kernel/cgroup/cpuset.c | 907 ++++++++++++++++++-----------------------
>   1 file changed, 408 insertions(+), 499 deletions(-)
>


