Return-Path: <cgroups+bounces-13522-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GTVM6zBe2k9IQIAu9opvQ
	(envelope-from <cgroups+bounces-13522-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 21:23:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734AB436F
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 21:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0162D301C88B
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7A35292A;
	Thu, 29 Jan 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMJvP6WU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxYPTUSU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FB350A12
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718179; cv=none; b=n8+Oln68s6gUbGXoOuURpFOkGtvyEaX8zK8rLRhpQsUMItCuq1t32q+5i2focDDgcYm17QA4nZWVTp8Lp8ykjDKEueFkeCQVm3f+6UWR+dcymfEo0Mv8sNgRng8yqn6OuD74YiYPykIIIYBHAYzOtbI6+pgjDGCeOjh1tMtn6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718179; c=relaxed/simple;
	bh=XyFp0JOgCauvJ4z4Et8vDd+xecmpPRSgVTSGhfWz5/k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O3rOAiSH3tiU2ZyaHzfYvxz+hsaARz4U/+gj9sARkuFjCC5MVen2bWkxan11zLG1H5WcmJpjtBrudAiiNS2rw3Jbd9vb7Feqvw6Rqxd/9wROTsFqKwobdL09vHa/dy4dQuj4BmziQ4+mE0XOHAIQLbPcGJiWAI819LS3RMDGZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMJvP6WU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxYPTUSU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769718176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS6EZilLlV5QK39B4gmPpvc4B3zDHiCpNJOtvJ8YOrU=;
	b=KMJvP6WUaxrPMtFB2vdNT60eysytTjDxhUJp+B8dZK+xJXLwABU5u7cT5UiHjq6UVtHNoh
	7XmRH6jhJFKdDGhJRLpYY1oXBNZgABxBE8B40SqXrVR9TKB53zFjF7ueUVlWHfn1KgkPS6
	VPXMow2YEpS4RsJr6JiG+czuLRBBRaQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_4bRbFp9NnOUr33RwsmUWg-1; Thu, 29 Jan 2026 15:22:55 -0500
X-MC-Unique: _4bRbFp9NnOUr33RwsmUWg-1
X-Mimecast-MFC-AGG-ID: _4bRbFp9NnOUr33RwsmUWg_1769718175
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8946e21ad8cso21929306d6.2
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769718174; x=1770322974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mS6EZilLlV5QK39B4gmPpvc4B3zDHiCpNJOtvJ8YOrU=;
        b=XxYPTUSUH241BM/7O4dXHikrCOtTri673a/rQvXu+w5cO3p5SNSBCvXZOJdvTfBBXr
         +JnEIJ69vF0jjf6TueInHNHR4Y2B3HVIVGpG6pgphpWl8J/ZaU0cCvA069ijhKBxthns
         /P4L1hMdI7JE/947QaUJ2fOrII5VFfe9PA2lNZweXlKso5HYuT4Wm13CuCdHKJzFafF9
         0WFM2SwFDfI943Qh3q5JVvPyHrCR9XbizjQUzqKB4QBuXNo9Rp5ZsGtJNG/Y93DFWGKv
         34kyxqRKjaNZXrv2hBpUbAMLQJn/Q255Q6AX0ZX/shZqVdLwsFc38NXSiGeAQMWqlZqc
         TWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769718174; x=1770322974;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS6EZilLlV5QK39B4gmPpvc4B3zDHiCpNJOtvJ8YOrU=;
        b=cM1vSsQE/H+ZCAZG4QfWOJ2DvZpl5LlGUbDGVbYo1Qz9FLwHbGVcC2sAQ2KIhbHz+5
         5zg3DSHw0BrpxweiumTTh3URuGCo9007X8tTy5Tke4BoYDmMUKPHTgVBT6tl/uuyJOZr
         ckif8vixTYf7i78mpXAr8GKz/1bxhCzr57WQe2oS248S4RI4WilDplIrIms+3yhLOeRY
         cUL83v7iuerzKDZQbOHsSwEqcgsTKgmfB38B3cFlXVGFQ7wor1sLHurEpcI6AtZ3yhZw
         hsTU0VeALLcFSvnYtCk83wI9kHDTmcCCPRXhYzMFD3RAB90lEX7a8gwg/17jsE305Fka
         A2fw==
X-Gm-Message-State: AOJu0YxjdEDhHvSK16UhHStj8t2OskKYttJcTUZwg/xpgFe++0aZ/nyM
	YoDVGwQatmnCmilIxUoDomCoFUYxfFiFtZijDZOgF0iQ9Q9wkIxy7Jimq2IoeJpGzQ6LYOzxDwR
	XpOKClkCjlGbwIiBZ6CxEZXGRhNOdZ4wUzPJT0P+hVgo5D7ZtBlxWvs9KkwpjnjJJVgs=
X-Gm-Gg: AZuq6aKdsld/yxA/k1GcCPCrXzSzZy/Py8K+CjSQRAA42rd1mB6SZJgcKrsw7taF9wf
	io6aKufYFJTVyxYYlCA94HQus/J4LeIecm7jKhtSsJE/7xdEZtTuPGbW52G+UXzjvigP8VSAzcS
	JuWb33iIupDbcszr8h8qIIFzbCSeeivYU05uqm8uko91UNwP26lfxTZzq/p+PrsJv08uZcZXLZi
	lGOA+1CkLTsA3xm0V+ItNdycuqJ6u6vJZfwbKAoJcwYe9jViM7gIiyl7VU/rZgnT9W1YjlkEk7H
	fZuz1359Y9ze68T9zgFA8q43b4jHS3qj06s6DiK4vfR3IfogREWrFZuxIKF00NwNn6jVmRSKK5W
	5mpWNHD92MICNLs6DvYT+22ZIkRu+WJj4qfUvevpp7CThe3o958hGNVrj
X-Received: by 2002:a05:6214:2503:b0:894:8003:3853 with SMTP id 6a1803df08f44-894e9f41fd2mr11287606d6.7.1769718174328;
        Thu, 29 Jan 2026 12:22:54 -0800 (PST)
X-Received: by 2002:a05:6214:2503:b0:894:8003:3853 with SMTP id 6a1803df08f44-894e9f41fd2mr11287316d6.7.1769718173905;
        Thu, 29 Jan 2026 12:22:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a5fb1sm44556626d6.9.2026.01.29.12.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 12:22:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <184216d6-9fae-4e73-94b8-ed1d2746a5a5@redhat.com>
Date: Thu, 29 Jan 2026 15:22:52 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: fix overlap of partition effective CPUs
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260129064516.210203-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20260129064516.210203-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13522-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 7734AB436F
X-Rspamd-Action: no action

On 1/29/26 1:45 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A warning was detect:
>
>   WARNING: kernel/cgroup/cpuset.c:825 at rebuild_sched_domains_locked
>   Modules linked in:
>   CPU: 12 UID: 0 PID: 681 Comm: rmdir  6.19.0-rc6-next-20260121+
>   RIP: 0010:rebuild_sched_domains_locked+0x309/0x4b0
>   RSP: 0018:ffffc900019bbd28 EFLAGS: 00000202
>   RAX: ffff888104413508 RBX: 0000000000000008 RCX: ffff888104413510
>   RDX: ffff888109b5f400 RSI: 000000000000ffcf RDI: 0000000000000001
>   RBP: 0000000000000002 R08: ffff888104413508 R09: 0000000000000002
>   R10: ffff888104413508 R11: 0000000000000001 R12: ffff888104413500
>   R13: 0000000000000002 R14: ffffc900019bbd78 R15: 0000000000000000
>   FS:  00007fe274b8d740(0000) GS:ffff8881b6b3c000(0000) knlGS:
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007fe274c98b50 CR3: 00000001047a9000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    update_prstate+0x1c7/0x580
>    cpuset_css_killed+0x2f/0x50
>    kill_css+0x32/0x180
>    cgroup_destroy_locked+0xa7/0x200
>    cgroup_rmdir+0x28/0x100
>    kernfs_iop_rmdir+0x4c/0x80
>    vfs_rmdir+0x12c/0x280
>    filename_rmdir+0x19e/0x200
>    __x64_sys_rmdir+0x23/0x40
>    do_syscall_64+0x6b/0x390
>
> It can be reproduced by steps:
>
>    # cd /sys/fs/cgroup/
>    # mkdir A1
>    # mkdir B1
>    # mkdir C1
>    # echo 1-3 > A1/cpuset.cpus
>    # echo root > A1/cpuset.cpus.partition
>    # echo 3-5 > B1/cpuset.cpus
>    # echo root > B1/cpuset.cpus.partition
>    # echo 6 > C1/cpuset.cpus
>    # echo root > C1/cpuset.cpus.partition
>    # rmdir A1/
>    # rmdir C1/
>
> Both A1 and B1 were initially configured with CPU 3, which was exclusively
> assigned to A1's partition. When A1 was removed, CPU 3 was returned to the
> root pool. However, B1 incorrectly regained access to CPU 3 when
> update_cpumasks_hier was triggered during C1's removal, which also updated
> sibling configurations.
>
> The update_sibling_cpumasks function was called to synchronize siblings'
> effective CPUs due to changes in their parent's effective CPUs. However,
> parent effective CPU changes should not affect partition-effective CPUs.
>
> To fix this issue, update_cpumasks_hier should only be invoked when the
> sibling is not a valid partition in the update_sibling_cpumasks.
>
> Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index cf67d3524c75..31ba74044155 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2227,27 +2227,20 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   	 * It is possible a change in parent's effective_cpus
>   	 * due to a change in a child partition's effective_xcpus will impact
>   	 * its siblings even if they do not inherit parent's effective_cpus
> -	 * directly.
> +	 * directly. It should not impact valid partition.
>   	 *
>   	 * The update_cpumasks_hier() function may sleep. So we have to
>   	 * release the RCU read lock before calling it.
>   	 */
>   	rcu_read_lock();
>   	cpuset_for_each_child(sibling, pos_css, parent) {
> -		if (sibling == cs)
> +		if (sibling == cs || is_partition_valid(sibling))
>   			continue;
> -		if (!is_partition_valid(sibling)) {
> -			compute_effective_cpumask(tmp->new_cpus, sibling,
> -						  parent);
> -			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
> -				continue;
> -		} else if (is_remote_partition(sibling)) {
> -			/*
> -			 * Change in a sibling cpuset won't affect a remote
> -			 * partition root.
> -			 */
> +
> +		compute_effective_cpumask(tmp->new_cpus, sibling,
> +					  parent);
> +		if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
>   			continue;
> -		}
>   
>   		if (!css_tryget_online(&sibling->css))
>   			continue;

Thanks for fixing this.

Reviewed-by: Waiman Long <longman@redhat.com>


