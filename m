Return-Path: <cgroups+bounces-6680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103AA42918
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C4441D16
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD0263F31;
	Mon, 24 Feb 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYkmWSUU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C625485D
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416787; cv=none; b=J14qDH1wx2DLXyYfxvH2P99soAqmO27am8Dcs+hOk9YtYPku/PGgtL5zCOQuCsd8yQ02Y4nIBwPExVD/8B/CP5qDaJJkIf1Oe0M9NGBfKKqk1z5/TrZcpS0oj8V3XmyHTKO1+dOtOhTPhw+le9TiO/aVIjFEvkTZ0dflm/lSlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416787; c=relaxed/simple;
	bh=8XO4EngEYbHrlhslbR1fKot9+qgneBerrlkHW0mNYZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PajrIN4cvn0HcouIKuyBexbDuGhDLE7AHdP7FIte3ZENAs4JaE6mQ4cTfNWyMna17z5ujk0xvy/jasRFlAjgkbShfc9b3IC7WUGEpPj+nB63aG1YXKJSzcNzVu6lJOj0jbpFS5IwR/fQNxAa13rN3Kq3wSXrLdIQt0pLhHTSn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYkmWSUU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ec47991aso63631825ad.1
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740416784; x=1741021584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTHS8iK3FsKYm/QQs//Dbn45NKszSJWQZPTjnfB9t0g=;
        b=kYkmWSUU8oQNiJd3Hrbp3yujeY2mZQ8iY1FsCpJBTMjGevplVvd+TKxSsZw2j383w9
         +5N2Pq0x9DgIH3RP7TEbXkGpWrspZZD1YbkW2GtsD1/IYM7f4yKn1K1KUF5d4yEe1uj7
         wjxGB+TD/NBIIoLCzTsWUblLFm7wycvPX5NN2GG3swR4a2C2McdGqPMh+aYVIc8HCDYO
         +FH4eVQFl6woJIqaUCVIOYvIHdZf7R7W8P6fmXAD09DJMa/nt7CppxKdFBHz5nz1ajzJ
         NMqU4vQZle+7FjXgX2nfKpukci/f2JFsglwdr7fc586pFoSzH9gIUex/Hji1LMlWK/OV
         EgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416784; x=1741021584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTHS8iK3FsKYm/QQs//Dbn45NKszSJWQZPTjnfB9t0g=;
        b=Cx35loQEeeEO/pQpH3RrpAF6N7jzl1ptzt2SHgKyH/2qvrzKurx1XIsC+fWTjNKgGt
         bAV1ao9SH/n02K0QRiMWa1i86R435Hi9kY91gw6F2TwNoLTW73AfyttMjUv5asJFHs0t
         3xL3P8tnNFqf4/8C2qz0h+zV0m8HBRVBrrcXte0x729vbL0IVQgMQvh5LTFfauwlLfRn
         g17vetiDwiONAAv1H0aeqSmKCox6sDp/yd0bW94eY0npLDNwFaQPyxU1OUBcQAkwgwfQ
         CLFwc9jRkqD7K0qJmcaZxXhB6GHExUzFr/f67zXfc1iCyIsWICcrsVGqHsCPr2UcMsCH
         CH0g==
X-Forwarded-Encrypted: i=1; AJvYcCXxzP1IcjDFVCIpIFFz+3aRZu46/x/58AU0cZyoVvGAxqQSwzKXOvSK/yBDfpDpQoJW42hDFeMw@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFVVwsIkXWtxbX8UnM9tUQod1AHAs92ERt8n2t9p/ghez9qXK
	NiHf5escB/A9Yf3mtO+TKxo/jOmfe4crhgW4eYp/Db4l7wMlAzMq
X-Gm-Gg: ASbGncsUcv5XIuBCkxLobbs2p/SybMQfLZGfQMQWEHJf+91Wy6FF16xVA5hFyDVzEkA
	0p6ZB/ilz2DuCBH6Be7KYRwZ7R4varOwYhYx+s/lqxiHo5JY+q3qbAEYVdLKxNfSD9dArw8rB49
	tDQzDtya/tRGPzsss4tRR2RCfreZuywuhjwLH/s7mYghwAvw12NvHZvaWkhXHC7vbpYStXFyRT+
	hklQyAM70GbtZ09v5RUnDOFvmDloggKAVaePYSib1UeEW7chkKrroHA+4XeE8ysf4SUlYFUNR9I
	9AA//J68bJQ6ckRer30y94SG2QfmMs2x0G4Yjq2K8h18m7x5jAM2BqprBw==
X-Google-Smtp-Source: AGHT+IGMqhrUZAxEQJWkNDLXJrTxLwT4UhOoRT1uPGC+2lcRJOsdoKA540ITjl1yDP8hW2ZlJQlBRQ==
X-Received: by 2002:a17:90b:1c90:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2fce769a8a3mr21389387a91.1.1740416784161;
        Mon, 24 Feb 2025 09:06:24 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:19f:cf94:a905:e7ab? ([2620:10d:c090:500::6:77f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb0a6902sm6852591a91.48.2025.02.24.09.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:06:23 -0800 (PST)
Message-ID: <e0ff8143-c6fd-4185-b953-d543ffd58535@gmail.com>
Date: Mon, 24 Feb 2025 09:06:21 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] cgroup: move rstat pointers into struct of their
 own
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: shakeel.butt@linux.dev, tj@kernel.org, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-2-inwardvessel@gmail.com> <Z7deFViKJYXWj8nf@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z7deFViKJYXWj8nf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 8:53 AM, Yosry Ahmed wrote:
> On Mon, Feb 17, 2025 at 07:14:38PM -0800, JP Kobryn wrote:
>> The rstat infrastructure makes use of pointers for list management.
>> These pointers only exist as fields in the cgroup struct, so moving them
>> into their own struct will allow them to be used elsewhere. The base
>> stat entities are included with them for now.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   include/linux/cgroup-defs.h                   | 90 +-----------------
>>   include/linux/cgroup_rstat.h                  | 92 +++++++++++++++++++
>>   kernel/cgroup/cgroup.c                        |  3 +-
>>   kernel/cgroup/rstat.c                         | 27 +++---
>>   .../selftests/bpf/progs/btf_type_tag_percpu.c |  4 +-
>>   5 files changed, 112 insertions(+), 104 deletions(-)
>>   create mode 100644 include/linux/cgroup_rstat.h
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 1b20d2d8ef7c..6b6cc027fe70 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -17,7 +17,7 @@
>>   #include <linux/refcount.h>
>>   #include <linux/percpu-refcount.h>
>>   #include <linux/percpu-rwsem.h>
>> -#include <linux/u64_stats_sync.h>
>> +#include <linux/cgroup_rstat.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/bpf-cgroup-defs.h>
>>   #include <linux/psi_types.h>
>> @@ -321,78 +321,6 @@ struct css_set {
>>   	struct rcu_head rcu_head;
>>   };
>>   
>> -struct cgroup_base_stat {
>> -	struct task_cputime cputime;
>> -
>> -#ifdef CONFIG_SCHED_CORE
>> -	u64 forceidle_sum;
>> -#endif
>> -	u64 ntime;
>> -};
>> -
>> -/*
>> - * rstat - cgroup scalable recursive statistics.  Accounting is done
>> - * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
>> - * hierarchy on reads.
>> - *
>> - * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
>> - * linked into the updated tree.  On the following read, propagation only
>> - * considers and consumes the updated tree.  This makes reading O(the
>> - * number of descendants which have been active since last read) instead of
>> - * O(the total number of descendants).
>> - *
>> - * This is important because there can be a lot of (draining) cgroups which
>> - * aren't active and stat may be read frequently.  The combination can
>> - * become very expensive.  By propagating selectively, increasing reading
>> - * frequency decreases the cost of each read.
>> - *
>> - * This struct hosts both the fields which implement the above -
>> - * updated_children and updated_next - and the fields which track basic
>> - * resource statistics on top of it - bsync, bstat and last_bstat.
>> - */
>> -struct cgroup_rstat_cpu {
>> -	/*
>> -	 * ->bsync protects ->bstat.  These are the only fields which get
>> -	 * updated in the hot path.
>> -	 */
>> -	struct u64_stats_sync bsync;
>> -	struct cgroup_base_stat bstat;
>> -
>> -	/*
>> -	 * Snapshots at the last reading.  These are used to calculate the
>> -	 * deltas to propagate to the global counters.
>> -	 */
>> -	struct cgroup_base_stat last_bstat;
>> -
>> -	/*
>> -	 * This field is used to record the cumulative per-cpu time of
>> -	 * the cgroup and its descendants. Currently it can be read via
>> -	 * eBPF/drgn etc, and we are still trying to determine how to
>> -	 * expose it in the cgroupfs interface.
>> -	 */
>> -	struct cgroup_base_stat subtree_bstat;
>> -
>> -	/*
>> -	 * Snapshots at the last reading. These are used to calculate the
>> -	 * deltas to propagate to the per-cpu subtree_bstat.
>> -	 */
>> -	struct cgroup_base_stat last_subtree_bstat;
>> -
>> -	/*
>> -	 * Child cgroups with stat updates on this cpu since the last read
>> -	 * are linked on the parent's ->updated_children through
>> -	 * ->updated_next.
>> -	 *
>> -	 * In addition to being more compact, singly-linked list pointing
>> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
>> -	 * point back to the associated cgroup.
>> -	 *
>> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
>> -	 */
>> -	struct cgroup *updated_children;	/* terminated by self cgroup */
>> -	struct cgroup *updated_next;		/* NULL iff not on the list */
>> -};
>> -
>>   struct cgroup_freezer_state {
>>   	/* Should the cgroup and its descendants be frozen. */
>>   	bool freeze;
>> @@ -517,23 +445,9 @@ struct cgroup {
>>   	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>>   
>>   	/* per-cpu recursive resource statistics */
>> -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
>> +	struct cgroup_rstat rstat;
>>   	struct list_head rstat_css_list;
>>   
>> -	/*
>> -	 * Add padding to separate the read mostly rstat_cpu and
>> -	 * rstat_css_list into a different cacheline from the following
>> -	 * rstat_flush_next and *bstat fields which can have frequent updates.
>> -	 */
>> -	CACHELINE_PADDING(_pad_);
>> -
>> -	/*
>> -	 * A singly-linked list of cgroup structures to be rstat flushed.
>> -	 * This is a scratch field to be used exclusively by
>> -	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
>> -	 */
>> -	struct cgroup	*rstat_flush_next;
>> -
>>   	/* cgroup basic resource statistics */
>>   	struct cgroup_base_stat last_bstat;
>>   	struct cgroup_base_stat bstat;
>> diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
>> new file mode 100644
>> index 000000000000..f95474d6f8ab
>> --- /dev/null
>> +++ b/include/linux/cgroup_rstat.h
>> @@ -0,0 +1,92 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_RSTAT_H
>> +#define _LINUX_RSTAT_H
>> +
>> +#include <linux/u64_stats_sync.h>
>> +
>> +struct cgroup_rstat_cpu;
> 
> Why do we need the forward declaration instead of just defining struct
> cgroup_rstat_cpu first? Also, why do we need a new header for these
> definitions rather than just adding struct cgroup_rstat to
> cgroup-defs.h?

The new header was added so the cgroup_rstat type can be used in bpf
cgroup-defs.h. As for the forward declaration, this was done so that
updated_next and updated children fields of the cgroup_rstat_cpu can
change type from from cgroup to cgroup_rstat.

Regardless, based on the direction we are moving with bpf sharing the
"self" tree, this new header will NOT be needed in v2.

> 
>> +
>> +/*
>> + * rstat - cgroup scalable recursive statistics.  Accounting is done
>> + * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
>> + * hierarchy on reads.
>> + *
>> + * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
>> + * linked into the updated tree.  On the following read, propagation only
>> + * considers and consumes the updated tree.  This makes reading O(the
>> + * number of descendants which have been active since last read) instead of
>> + * O(the total number of descendants).
>> + *
>> + * This is important because there can be a lot of (draining) cgroups which
>> + * aren't active and stat may be read frequently.  The combination can
>> + * become very expensive.  By propagating selectively, increasing reading
>> + * frequency decreases the cost of each read.
>> + *
>> + * This struct hosts both the fields which implement the above -
>> + * updated_children and updated_next - and the fields which track basic
>> + * resource statistics on top of it - bsync, bstat and last_bstat.
>> + */
>> +struct cgroup_rstat {
>> +	struct cgroup_rstat_cpu __percpu *rstat_cpu;
>> +
>> +	/*
>> +	 * Add padding to separate the read mostly rstat_cpu and
>> +	 * rstat_css_list into a different cacheline from the following
>> +	 * rstat_flush_next and containing struct fields which can have
>> +	 * frequent updates.
>> +	 */
>> +	CACHELINE_PADDING(_pad_);
>> +	struct cgroup *rstat_flush_next;
>> +};
>> +
>> +struct cgroup_base_stat {
>> +	struct task_cputime cputime;
>> +
>> +#ifdef CONFIG_SCHED_CORE
>> +	u64 forceidle_sum;
>> +#endif
>> +	u64 ntime;
>> +};
>> +
>> +struct cgroup_rstat_cpu {
>> +	/*
>> +	 * Child cgroups with stat updates on this cpu since the last read
>> +	 * are linked on the parent's ->updated_children through
>> +	 * ->updated_next.
>> +	 *
>> +	 * In addition to being more compact, singly-linked list pointing
>> +	 * to the cgroup makes it unnecessary for each per-cpu struct to
>> +	 * point back to the associated cgroup.
>> +	 */
>> +	struct cgroup *updated_children;	/* terminated by self */
>> +	struct cgroup *updated_next;		/* NULL if not on the list */
>> +
>> +	/*
>> +	 * ->bsync protects ->bstat.  These are the only fields which get
>> +	 * updated in the hot path.
>> +	 */
>> +	struct u64_stats_sync bsync;
>> +	struct cgroup_base_stat bstat;
>> +
>> +	/*
>> +	 * Snapshots at the last reading.  These are used to calculate the
>> +	 * deltas to propagate to the global counters.
>> +	 */
>> +	struct cgroup_base_stat last_bstat;
>> +
>> +	/*
>> +	 * This field is used to record the cumulative per-cpu time of
>> +	 * the cgroup and its descendants. Currently it can be read via
>> +	 * eBPF/drgn etc, and we are still trying to determine how to
>> +	 * expose it in the cgroupfs interface.
>> +	 */
>> +	struct cgroup_base_stat subtree_bstat;
>> +
>> +	/*
>> +	 * Snapshots at the last reading. These are used to calculate the
>> +	 * deltas to propagate to the per-cpu subtree_bstat.
>> +	 */
>> +	struct cgroup_base_stat last_subtree_bstat;
>> +};
>> +
>> +#endif	/* _LINUX_RSTAT_H */


