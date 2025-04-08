Return-Path: <cgroups+bounces-7437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C407EA814BB
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B328859B7
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C323E338;
	Tue,  8 Apr 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZqy8oHq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D67256D
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137386; cv=none; b=JEvJmyfJut67byyF0aCkIGfQlcGFy9P35KTOvI1mEGF9tMlE1fnO0GzN9nn3gF17EGl/ZhoXXWufT/R9NngFlg6KOREh+EeMMjzbCvOXLgntuBBf3XOQk0Qpv3ApFLUW+EwXz0kAbEJwd+RqizpNdiS7hsjMcYwXGi99frYftgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137386; c=relaxed/simple;
	bh=WfWzdxBkhf6dBcEkzQSrptAQ1l/B6nErMT45c4yWgA8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=blDFjVsl8BRQQJLNJTwynCPzkb3ylFKcq9dIDacBjk4Qxta//OeIDfmOKLCYjlC0GeW3YKVShqHcB8q9wkbtdR9U6X5TUtqYxrC6GernVk7cAw0T35s0hmHkpZReryl38UVYoSSNhE0+LsvCTJdtvR67Kusf9lz/u/60YiG6oDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZqy8oHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744137383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se1FHByXQ0bG9ZLAbgCVErfU/qkKL9uOy+5u+NBsYCA=;
	b=BZqy8oHqQORO1EjZdMaSKKPGVZV4tnOf/Sxfo0M7v+8Ysoq5rb3d/LWGKcP667G69xXoq8
	Sb7p7WnhlFn6hElh6y4d1U2yWrYC3uWlnMNoz7ex+kQPryNjyKrPFhKZRr/UdmZbChMNck
	Txb3SfvuCGy7XDbHSJN2jbRkC0Dzbcg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ZPtNeDjmOSGk1GG0woMTUQ-1; Tue, 08 Apr 2025 14:36:21 -0400
X-MC-Unique: ZPtNeDjmOSGk1GG0woMTUQ-1
X-Mimecast-MFC-AGG-ID: ZPtNeDjmOSGk1GG0woMTUQ_1744137381
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d6e10f4b85so107015435ab.0
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 11:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137380; x=1744742180;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se1FHByXQ0bG9ZLAbgCVErfU/qkKL9uOy+5u+NBsYCA=;
        b=lGF1eQ3yrZuLm5bVOChu445Cm4EqmofRhzX4JGQyDsCjG5j6v8nXvznaHXdza+SL2O
         FNDiewIJvmoyWn0at8P/aN2ux8OcRpUF3Tpe+GKO1uKlFLfEol93UxGIbFyQZaawAzL4
         +8KWRuiAU3MQuy1f1Gp5tmKwWMpcsSaSIhkRzlu0jrPwYc0W0wvWnv6z80leGyf3iSJC
         qw5kHpRNagvIHMnic6a7argko4apYfGnfJ/UXyITnRJcTn20gzO63Ulk8BV3ARAi6oEQ
         37yQfEOonq7UUKqNr9NHfuoV34zFqzT0uS15pSdGvyeUIZbQCjUd+25l+kMLGQQM0yjk
         65bQ==
X-Gm-Message-State: AOJu0YwDu5b8vSgfXWFUglrq0ATqH5wD5u6yqORSm1rLOvsbKthq/QeQ
	x9qo3NOWX8a4QH1+vMINof1UCXWjdOXsJ1OHEaB3DdsjtaodZaF//C2mL1kSDg1DiaYGjxICQ2u
	8HBp4vNZVpB0smuAjcNDWxtcPUapJh49ihF1JkG5At0G+9EW7R0y98ME=
X-Gm-Gg: ASbGncvrLyUCMIezoXXDEuuENk52dwPDvpfmJK93Tg1325ikXoCuO1aMQ953j2nfDOe
	qzWCVUrn0F9ML4MT7lJUUi4kOWS7FCsLF9l4yfKXJtx8iGeozibJktyOIK97+utPjySQLtHkWe+
	DtLAp/Wgw741cSjP6WPVrodn1/XtO3nybHp4lRnmTtiIKJd2g1UBw4agLbmY1CtSyhO9whO1PNR
	+iYhCruCqAYAwxKaGk6YpxasdvoFVtprWDVQ1e4JQIEeYh58RnVsQDCvgSRMDpis+mlbFnUcSvt
	CaK9B9WYf2V6lry5LCVI/lXCp18RCGnqcbq4/d8P+NjKadmY0mFcfdVfE+/kmw==
X-Received: by 2002:a05:6e02:3712:b0:3a7:88f2:cfa9 with SMTP id e9e14a558f8ab-3d77c281bfemr116835ab.11.1744137380661;
        Tue, 08 Apr 2025 11:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE7yFZdGQ6awpFHZ0/pUXwSjXgM/x9GR8AYdv0kxsLsofBNsZ3deO5hBmn+DaHXlnkd8lByA==
X-Received: by 2002:a05:6e02:3712:b0:3a7:88f2:cfa9 with SMTP id e9e14a558f8ab-3d77c281bfemr116395ab.11.1744137380146;
        Tue, 08 Apr 2025 11:36:20 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d703b6bb26sm5893725ab.7.2025.04.08.11.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:36:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b978ec91-306f-45d5-8d88-91febebb8e48@redhat.com>
Date: Tue, 8 Apr 2025 14:36:16 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 akpm@linux-foundation.org
References: <20250320210919.439964-1-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250320210919.439964-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 5:09 PM, Gregory Price wrote:
> It is possible for a reclaimer to cause demotions of an lruvec belonging
> to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
> this limitation based on the lruvec's memcg and prevent demotion.
>
> Notably, this may still allow demotion of shared libraries or any memory
> first instantiated in another cgroup. This means cpusets still cannot
> cannot guarantee complete isolation when demotion is enabled, and the
> docs have been updated to reflect this.
>
>
> Note: This is a fairly hacked up method that probably overlooks some
>        cgroup/cpuset controls or designs. RFCing now for some discussion
>        at LSFMM '25.
>
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   .../ABI/testing/sysfs-kernel-mm-numa          | 14 +++++---
>   include/linux/cpuset.h                        |  2 ++
>   kernel/cgroup/cpuset.c                        | 10 ++++++
>   mm/vmscan.c                                   | 32 ++++++++++++-------
>   4 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..27cdcab901f7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> @@ -16,9 +16,13 @@ Description:	Enable/disable demoting pages during reclaim
>   		Allowing page migration during reclaim enables these
>   		systems to migrate pages from fast tiers to slow tiers
>   		when the fast tier is under pressure.  This migration
> -		is performed before swap.  It may move data to a NUMA
> -		node that does not fall into the cpuset of the
> -		allocating process which might be construed to violate
> -		the guarantees of cpusets.  This should not be enabled
> -		on systems which need strict cpuset location
> +		is performed before swap if an eligible numa node is
> +		present in cpuset.mems for the cgroup. If cpusets.mems
> +		changes at runtime, it may move data to a NUMA node that
> +		does not fall into the cpuset of the new cpusets.mems,
> +		which might be construed to violate the guarantees of
> +		cpusets.  Shared memory, such as libraries, owned by
> +		another cgroup may still be demoted and result in memory
> +		use on a node not present in cpusets.mem. This should not
> +		be enabled on systems which need strict cpuset location
>   		guarantees.
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 835e7b793f6a..d4169f1b1719 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>   
> +bool memcg_mems_allowed(struct mem_cgroup *memcg, int nid);
> +
>   #else /* !CONFIG_CPUSETS */
>   
You should also define an inline function for the !CONFIG_CPUSETS case.
>   static inline bool cpusets_enabled(void) { return false; }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..bb9669cc105d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4296,3 +4296,13 @@ void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
>   	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
>   		   nodemask_pr_args(&task->mems_allowed));
>   }
> +
> +bool memcg_mems_allowed(struct mem_cgroup *memcg, int nid)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +
> +	css = cgroup_get_e_css(memcg->css.cgroup, &cpuset_cgrp_subsys);
> +	cs = css ? container_of(css, struct cpuset, css) : NULL;
> +	return cs ? node_isset(nid, cs->effective_mems) : true;

As said by Johannes, you will need to take the callback_lock to ensure 
the stability of effective_mems. I also second his suggestion of 
defining a cgroup_mems_allowed() here and do the the memcg to cgroup 
translation outside of cpuset.c.

Cheers,
Longman


