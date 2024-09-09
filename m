Return-Path: <cgroups+bounces-4771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07A972001
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6241F24202
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2116F907;
	Mon,  9 Sep 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etOEbhiF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8116DECB
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901679; cv=none; b=HxY3TLYmqJTNiXaVZq52SLinmRSsSkqKRXAQZsLx2d6fRWEEUglfDhcuUebgVborcj6mHlOrPl9hxdfkS9pNIpQNUwL2FqXbNENXb4DGn8506PZPqgVAsqqCmNXPo/eM2mxGkRuqZX3MBMfz/tFMF3npMymXydeIS/L68+6jh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901679; c=relaxed/simple;
	bh=GNkqEFi+I5tZLNi7WyurAexVg1eNtWfNKKjfgTnWPVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOlOXPnKsgusFb6PD/6ArO27gxbOclH0UvKQt30ki9MrN5skLSPvw337+TPvmkT68cfKgqU088bwQTDoH6UAf38NGBIOvxzp7Av3paqFVyUgX/8UHjORS4k67QrOxZbxqKX8Jep4GhvMKNsRa/DbzaerVXQ5jw8mibccjK/bGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etOEbhiF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725901677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRF3dxirgHcKfvRlk9CHgM9zM7W8NPKg7f5/zk/dLNA=;
	b=etOEbhiFAvF6fPZQCBxZGjgFmV570AXy3RR6IPF0KwxvO//r+4TiTfRS7hEkkuKnKyTl9x
	BdtcvaAy6vy85TERNDxFqJHtqzZHJxyPHHa3DfDddifT6PmVm4UCAPohx2iyuG5OMMN5Kn
	T+xAcgnT8+XTq+waJs2L+bQ8j1r8U0Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-SZjt_tFaM1aIKD8SJ-_gpA-1; Mon,
 09 Sep 2024 13:07:53 -0400
X-MC-Unique: SZjt_tFaM1aIKD8SJ-_gpA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68AB11953950;
	Mon,  9 Sep 2024 17:07:49 +0000 (UTC)
Received: from [10.2.16.126] (unknown [10.2.16.126])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F8D71956086;
	Mon,  9 Sep 2024 17:07:45 +0000 (UTC)
Message-ID: <953607c5-8ba6-4438-bee2-17593ce5be54@redhat.com>
Date: Mon, 9 Sep 2024 13:07:45 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cgroup/cpuset: Expose cpuset filesystem with cpuset
 v1 only
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-3-mkoutny@suse.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240909163223.3693529-3-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 9/9/24 12:32, Michal Koutný wrote:
> The cpuset filesystem is a legacy interface to cpuset controller with
> (pre-)v1 features. It makes little sense to co-mount it on systems
> without cpuset v1, so do no build it when cpuset v1 is not built
> neither.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cgroup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c72e18ffbfd82..90e50d6d3cf39 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2331,7 +2331,7 @@ static struct file_system_type cgroup2_fs_type = {
>   	.fs_flags		= FS_USERNS_MOUNT,
>   };
>   
> -#ifdef CONFIG_CPUSETS
> +#ifdef CONFIG_CPUSETS_V1
>   static const struct fs_context_operations cpuset_fs_context_ops = {
>   	.get_tree	= cgroup1_get_tree,
>   	.free		= cgroup_fs_context_free,
> @@ -6236,7 +6236,7 @@ int __init cgroup_init(void)
>   	WARN_ON(register_filesystem(&cgroup_fs_type));
>   	WARN_ON(register_filesystem(&cgroup2_fs_type));
>   	WARN_ON(!proc_create_single("cgroups", 0, NULL, proc_cgroupstats_show));
> -#ifdef CONFIG_CPUSETS
> +#ifdef CONFIG_CPUSETS_V1
>   	WARN_ON(register_filesystem(&cpuset_fs_type));
>   #endif
>   
Reviewed-by: Waiman Long <longman@redhat.com>


