Return-Path: <cgroups+bounces-1513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C5853A8E
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B743B1C25EF4
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BD1CAA3;
	Tue, 13 Feb 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MunuWHrW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1E11712
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851332; cv=none; b=cMO3ouI6SAdUUeKPqqAKS0ihb1q9uc2LbY3ATgvly2k58QDBHy8iamX30LeZBaY0OY4PaoPUEg+BV1x3O3jy6RdnscfZJCuoeFfEQnklL+ThJ934uvQqXSC4dDLmeIZQ1vvTIw+KPlHQzWWn5U+aIfOdvBxewplSZlqBpabYTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851332; c=relaxed/simple;
	bh=/xs67GjoWjNpppH4ZqnqiXX+eRRoA8e7888FZZETit0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nxMfYXg9t0t+ESiLbE52aEOUkBOxsDmGUTASceMfo3dBI5NV4FiNrKX2kWTHw4pwWkdOV2Dxz5C913LSrydYPM5eAjFbh/8ncd04u3mtgnaYnuYMBb/bcgRtds78kRmwbx28CTHU0JKtE/5MsjPXXElC4kncIrI0EXyQJx30AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MunuWHrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707851329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG0EcQlsaL04DAVBIoEXlOU2Qc1NYUIqNKPW84nzM6w=;
	b=MunuWHrWusxcJmdVr11kltfj0V6gxFvIsKiLfaOuUTbRoSK2F7pcyHF1Xyk1Ck7dEvbfJV
	4Qb+JX5NKGPqh4qIdq6VUHydpaPopXgDbLiqDtgJTT8OOo+vI2sZ30Mqe3y6FAJh2ugg/F
	SW+D5lFdHJa+eyTfFfLHfyDvvAaRwjk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-tEanHhmTM4umRUxhV5WVcg-1; Tue,
 13 Feb 2024 14:08:47 -0500
X-MC-Unique: tEanHhmTM4umRUxhV5WVcg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E6041C09836;
	Tue, 13 Feb 2024 19:08:47 +0000 (UTC)
Received: from [10.22.10.18] (unknown [10.22.10.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CFEE2492BC6;
	Tue, 13 Feb 2024 19:08:46 +0000 (UTC)
Message-ID: <e3a7daa9-d690-4ef2-8f6a-0641a14a6cb9@redhat.com>
Date: Tue, 13 Feb 2024 14:08:46 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup2: New memory.max.effective like cgroup1
 hierarchical_memory_limit
Content-Language: en-US
To: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Koutny <mkoutny@suse.com>
References: <ZctiM5RintD_D0Lt@host1.jankratochvil.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZctiM5RintD_D0Lt@host1.jankratochvil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 2/13/24 07:36, Jan Kratochvil (Azul) wrote:
> Hello,
>
> cgroup1 (by function memcg1_stat_format) contains two lines
> 	hierarchical_memory_limit %llu
> 	hierarchical_memsw_limit %llu
>
> which are useful for userland to easily and performance-wise find out the
> effective cgroup limits being applied. Otherwise userland has to
> open+read+close the file "memory.max" and/or "memory.swap.max" in multiple
> parent directories of a nested cgroup.
>
> For cgroup1 it was implemented by:
> 	memcg: show real limit under hierarchy mode
> 	https://github.com/torvalds/linux/commit/fee7b548e6f2bd4bfd03a1a45d3afd593de7d5e9
> 	Date:   Wed Jan 7 18:08:26 2009 -0800
>
> But for cgroup2 it has been missing so far. Based on Michal Koutny's idea this
> patch now implements "memory.max.effective" and "memory.swap.max.effective"
> files similar to existing "cpuset.cpus.effective".
>
>
> Jan Kratochvil
>
>
> v3:
> memory.stat fields -> *.max.effective separate files suggested by Michal Koutny
> v2:
> hierarchical_memsw_limit -> hierarchical_swap_limit fix found by Waiman Long
> v1:
> hierarchical_memory_limit && hierarchical_memsw_limit in memory.stat
>
>
> Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>

The code changes look good to me. However, your commit log isn't of the 
right format. We don't start the commit log with "Hello". See

https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

You can also do a "git log" of a linux git tree and see how other people 
write their commit logs.

Cheers,
Longman

>
>   mm/memcontrol.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ed40f9d3..8c4cb5f60 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6845,6 +6845,19 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>   	return nbytes;
>   }
>   
> +static int memory_max_effective_show(struct seq_file *m, void *v)
> +{
> +	unsigned long memory;
> +	struct mem_cgroup *mi;
> +
> +	/* Hierarchical information */
> +	memory = PAGE_COUNTER_MAX;
> +	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
> +		memory = min(memory, READ_ONCE(mi->memory.max));
> +
> +	return seq_puts_memcg_tunable(m, memory);
> +}
> +
>   /*
>    * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
>    * if any new events become available.
> @@ -7038,6 +7051,11 @@ static struct cftype memory_files[] = {
>   		.seq_show = memory_max_show,
>   		.write = memory_max_write,
>   	},
> +	{
> +		.name = "max.effective",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = memory_max_effective_show,
> +	},
>   	{
>   		.name = "events",
>   		.flags = CFTYPE_NOT_ON_ROOT,
> @@ -8040,6 +8058,19 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
>   	return nbytes;
>   }
>   
> +static int swap_max_effective_show(struct seq_file *m, void *v)
> +{
> +	unsigned long swap;
> +	struct mem_cgroup *mi;
> +
> +	/* Hierarchical information */
> +	swap = PAGE_COUNTER_MAX;
> +	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
> +		swap = min(swap, READ_ONCE(mi->swap.max));
> +
> +	return seq_puts_memcg_tunable(m, swap);
> +}
> +
>   static int swap_events_show(struct seq_file *m, void *v)
>   {
>   	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> @@ -8072,6 +8103,11 @@ static struct cftype swap_files[] = {
>   		.seq_show = swap_max_show,
>   		.write = swap_max_write,
>   	},
> +	{
> +		.name = "swap.max.effective",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = swap_max_effective_show,
> +	},
>   	{
>   		.name = "swap.peak",
>   		.flags = CFTYPE_NOT_ON_ROOT,
>


