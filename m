Return-Path: <cgroups+bounces-11828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6511C4F8A4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFAB3B4C9D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA12E6CAF;
	Tue, 11 Nov 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcRQtim5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDS/+BTC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657E2E54DE
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888236; cv=none; b=SH7TpvJEOzKZ4BdcOhh5HMYboueIAKHnW2zzdN5MLDkOxPriY5Eq0KyLkX/rhKmZYTSGkwAi1o/cuOfamVsfFW3k8lx4dFG0n3JpYSN6MUO83+y8J7RKiXj1MDf+kNa3FO4gzOx3MenNqqUl9ygly6f3aWbAomQ5B7RCWA4VLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888236; c=relaxed/simple;
	bh=HKhk/loQ9vPwpn8PyfhKCherr2RQ10MGaP0NvMyegqo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mNX64ORHvJQJEZABITP3yP0mq8Ut15p3k39p/ZeeEvMsG7sVjeF0jqgw6J2zuKxs7HDU40sqCrZwTlyKeRTesU/9cMAsGBEywYf6+5k3kufpgKDK+EXAtc1mFVyZKI2RBXMnXUHE9vJUQK6zB2vnXyhqGWLujhPORZN2cbb0n0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcRQtim5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDS/+BTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762888234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPREi96HvVo+XQknT5Z9IHpnSaxHU5ijbJjsijiZbCE=;
	b=hcRQtim5n2lL7D2ks8nzYQwKq1ptpJmkjZGxsHPo0jZtqwbqRODLDmmPaeLnUU6n/jyEFO
	3ovkGp8RPlx3FEIE1YGuYvvQGpcX+08QIIwazZQEjDnK3Iv/Db/iBdPzW9rFr9iXp3KvnR
	5QnbvPpLRSPd8PbCcmlCLim02GtySNM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-q44M875iO6mRtdPveTFPUw-1; Tue, 11 Nov 2025 14:10:32 -0500
X-MC-Unique: q44M875iO6mRtdPveTFPUw-1
X-Mimecast-MFC-AGG-ID: q44M875iO6mRtdPveTFPUw_1762888231
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8804823b757so33730676d6.0
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762888231; x=1763493031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPREi96HvVo+XQknT5Z9IHpnSaxHU5ijbJjsijiZbCE=;
        b=jDS/+BTCKmF2eWeQhTZ9CYxpTK801fbZ+4GEWIntcUT8df1zcsTvTwkYyWC7Sc3pey
         ypSi1VuqnP8tvAClyot7sWe1qNiNiPx3eEgnRDW+/JqLn/MNwkRZEMxDYbt43u0q4BAX
         X153FSyyKDAiBNxUBD+KTjM1Aa5XMAt4Q9Y4+OiDVxg2A4qwZdErnf0UL9UeZnmdPVV2
         Efu7hjSd6f4jcwxHDImQRf70M3GG99r9BlasmIpNQ6XHDQh2cGeWilwEBgSQdpi5/M4P
         L3WoLKGZtlSiDBgV0BC89J1qnI2dmGRNeMPNBAAoobtbW2nXVfxxhLo64/PeqTNnSbZk
         EUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888231; x=1763493031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPREi96HvVo+XQknT5Z9IHpnSaxHU5ijbJjsijiZbCE=;
        b=W8bsp/SmtA2ScgdmHJXSpSRsH7MnnUff01ulpX1QK0RG+EdESJlLoIO/ewALkI2ntY
         Trc2Sn5cNrURvOy2SKfZeIHa+X28NF3uS5nsF5SlbfYGCWrkImPTnvEqKEUYhdKGDBTH
         MUEHiFwLNZRxs0Mon5iXukl/h2dLjOGW35Pl+P/S+HCim2fEOo8pfLRkERkfiNnkWmL6
         XByz0dn/VcUnQwD6sLLUTdxwL7xli4qsgfkFg0fVuhkkG2XjU/1YZGlCJFAVlJ7CVfju
         La8W0VgMRDc9CvSBxaI8pK8cEHWrTirna+mO83yIUoe77hGEoJqemy1Np7ti2ktWQFpI
         Rk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUSFanRPGK03qoGZ7GfAoK+kFuHXQOx83wmjB846QGxBVGxROBMLjUBEC1MzcICmc7RsgkZdySf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4U0uFaH6UbEZGXX01L7LEytixMGPAA2Q8/aPNzss+IpauWzkV
	fjYFEaXNHC8V7mga4q+2TFsP4k7YwJIxj3T2DsG+uYI1VATOfQFUzmMsecc1Go86PWuWIPqSS9r
	n7BBshhpe78WXApirOFI+6CNa+8ilszpStFFCXcaP0oLwOHtzAerWAMadWBw=
X-Gm-Gg: ASbGncuSpHGBI6uk9SDjydVcCttG9FmMxjEVCq+UIA5lQXUnrBSsf2mpQqDt0vqCpJE
	u5kq+GyJZ7yOfWqyFPGT821JYiAQKs/fikrQmBjw9Shj+dNi0D8nWUSJtsBW+qSKxSSFZpAPVQ7
	byjMqqXZXSh7ne9dx2UTnypqbZrGNKmZd41H3L8EoiyVnFIRBe9ZYpezpev72OPvCEjTxoAjPK0
	yOyE4X1eY5drJNvWoaAXvI1upFsPJ5pGgfwgT9GG5Qb9xGAWs8L+0a+4jqOqJ96+4TEgZuviutV
	desjGsMyppIbm9ytUCYTw8Of7zVV9qyx/MOC2dF47Q35ubtFOYHAVAi5pOw1b4OQY6F5bfjm8s8
	ZTVwnvfN6IU3FNqK4I9GsntO+yageHoyacthctwjN7XHc1A==
X-Received: by 2002:a05:6214:dcc:b0:880:4f25:588f with SMTP id 6a1803df08f44-8825e77bb91mr57855136d6.2.1762888231332;
        Tue, 11 Nov 2025 11:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERrfZKlHqSH+9nPVlyhu9zwA9R8Rh1ZQplboV+7tsbpDRXGv41OROdDsYHxXClbz2KGfbjZA==
X-Received: by 2002:a05:6214:dcc:b0:880:4f25:588f with SMTP id 6a1803df08f44-8825e77bb91mr57854706d6.2.1762888230834;
        Tue, 11 Nov 2025 11:10:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b7528csm76619596d6.46.2025.11.11.11.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 11:10:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
Date: Tue, 11 Nov 2025 14:10:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
To: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
 laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
 corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
Content-Language: en-US
In-Reply-To: <20251110101948.19277-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 5:19 AM, Leon Huang Fu wrote:
> Memory cgroup statistics are updated asynchronously with periodic
> flushing to reduce overhead. The current implementation uses a flush
> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> determining when to aggregate per-CPU memory cgroup statistics. On
> systems with high core counts, this threshold can become very large
> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> statistics when userspace reads memory.stat files.
>
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data
> that is thousands of updates out of date.
>
> Introduce a new write-only file, memory.stat_refresh, that allows
> userspace to explicitly trigger an immediate flush of memory statistics.
> Writing any value to this file forces a synchronous flush via
> __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> descendants, ensuring that subsequent reads of memory.stat and
> memory.numa_stat reflect current data.
>
> This approach follows the pattern established by /proc/sys/vm/stat_refresh
> and memory.peak, where the written value is ignored, keeping the
> interface simple and consistent with existing kernel APIs.
>
> Usage example:
>    echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
>    cat /sys/fs/cgroup/mygroup/memory.stat
>
> The feature is available in both cgroup v1 and v2 for consistency.
>
> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
> ---
> v2 -> v3:
>    - Flush stats by memory.stat_refresh (per Michal)
>    - https://lore.kernel.org/linux-mm/20251105074917.94531-1-leon.huangfu@shopee.com/
>
> v1 -> v2:
>    - Flush stats when write the file (per Michal).
>    - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/
>
>   Documentation/admin-guide/cgroup-v2.rst | 21 +++++++++++++++++--
>   mm/memcontrol-v1.c                      |  4 ++++
>   mm/memcontrol-v1.h                      |  2 ++
>   mm/memcontrol.c                         | 27 ++++++++++++++++++-------
>   4 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3345961c30ac..ca079932f957 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
>   	cgroup is within its effective low boundary, the cgroup's
>   	memory won't be reclaimed unless there is no reclaimable
>   	memory available in unprotected cgroups.
> -	Above the effective low	boundary (or
> +	Above the effective low	boundary (or
>   	effective min boundary if it is higher), pages are reclaimed
>   	proportionally to the overage, reducing reclaim pressure for
>   	smaller overages.
> @@ -1785,6 +1785,23 @@ The following nested keys are defined.
>   		up if hugetlb usage is accounted for in memory.current (i.e.
>   		cgroup is mounted with the memory_hugetlb_accounting option).
>
> +  memory.stat_refresh
> +	A write-only file which exists on non-root cgroups.
> +
> +	Writing any value to this file forces an immediate flush of
> +	memory statistics for this cgroup and its descendants. This
> +	ensures subsequent reads of memory.stat and memory.numa_stat
> +	reflect the most current data.
> +
> +	This is useful on high-core count systems where per-CPU caching
> +	can lead to stale statistics, or when precise memory usage
> +	information is needed for monitoring or debugging purposes.
> +
> +	Example::
> +
> +	  echo 1 > memory.stat_refresh
> +	  cat memory.stat
> +
>     memory.numa_stat
>   	A read-only nested-keyed file which exists on non-root cgroups.
>
> @@ -2173,7 +2190,7 @@ of the two is enforced.
>
>   cgroup writeback requires explicit support from the underlying
>   filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
> -btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
> +btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
>   attributed to the root cgroup.
>
>   There are inherent differences in memory and writeback management
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6eed14bff742..c3eac9b1f1be 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2041,6 +2041,10 @@ struct cftype mem_cgroup_legacy_files[] = {
>   		.name = "stat",
>   		.seq_show = memory_stat_show,
>   	},
> +	{
> +		.name = "stat_refresh",
> +		.write = memory_stat_refresh_write,
> +	},
>   	{
>   		.name = "force_empty",
>   		.write = mem_cgroup_force_empty_write,
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..a14d4d74c9aa 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -29,6 +29,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg);
>   unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>   unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>   int memory_stat_show(struct seq_file *m, void *v);
> +ssize_t memory_stat_refresh_write(struct kernfs_open_file *of, char *buf,
> +				  size_t nbytes, loff_t off);
>
>   void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
>   struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bfc986da3289..19ef4b971d8d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -610,6 +610,15 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
>   	css_rstat_flush(&memcg->css);
>   }
>
> +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	memcg = memcg ?: root_mem_cgroup;
> +	__mem_cgroup_flush_stats(memcg, force);
> +}

Shouldn't we impose a limit in term of how frequently this 
memcg_flush_stats() function can be called like at most a few times per 
second to prevent abuse from user space as stat flushing is expensive? 
We should prevent some kind of user space DoS attack by using this new 
API if we decide to implement it.

Cheers,
Longman


