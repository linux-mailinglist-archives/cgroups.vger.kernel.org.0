Return-Path: <cgroups+bounces-11928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F93C57E2E
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B6774EC8EB
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75260274B26;
	Thu, 13 Nov 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7mKf7+F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVqnS6Un"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E62727F3
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043254; cv=none; b=SHGSWl6TmOLtS7qigeGqQkrntHHzs99tdADRQwFOxUtYuDaa5BZ7WXk5vxYZlfpb6JzaB0s+7ep42FCgBMJld0kHFm48Cqw5lbtIipvZsVE8uPSWLTGSKEKgAOQJuHgz3PJ/KpSyhdyjGcxF9MzfelouYql/O6dLBl9v/yaEorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043254; c=relaxed/simple;
	bh=5YMqyaxTyMSIcPwhKOIZ/AmBV9RIYovBuIn2gvL78C4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rwKOQwIdkVDWQ2Jq5mZvICQT6EGy75c4q6kv2bqNdWT5HaBwjvyBHN5S31XOC8hOCfG+AuJVYusLB8/HLsAxtB8PKLNwFVzzKj/JviNbBMScYOXU7mR7T2NOaTSV3ISqLb4I0epL+USlNjMFIXzej5KfTEscHVgazOZtEUUtU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7mKf7+F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVqnS6Un; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763043250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH67x5Y7eqUU5v/14msuK1UvqHFCK7J6ghaBCVs9wdc=;
	b=Z7mKf7+FevWRF9FLnNwEn7K4N6I2jPsZpDawkpQ3Qf2XEhH9VBWN4YOXIE47zd4s2q6HU3
	87Ihnv3deXBR0roHHm3l1bzO9cWEz14g8YdOl0N1cZ1xGmKW3VaAaA9pujjCOGwL1eiYcd
	WSfDMV2mWJ0iaR4sq+dF3FGwhh1o0Tc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-BL5z_50XMvOnrKjT21bDGQ-1; Thu, 13 Nov 2025 09:14:09 -0500
X-MC-Unique: BL5z_50XMvOnrKjT21bDGQ-1
X-Mimecast-MFC-AGG-ID: BL5z_50XMvOnrKjT21bDGQ_1763043248
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e884663b25so19806871cf.0
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763043247; x=1763648047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fH67x5Y7eqUU5v/14msuK1UvqHFCK7J6ghaBCVs9wdc=;
        b=BVqnS6Un1UAJDhVbUNPNYExihKx02GMMsApsRgGpxj5MI94n4MtcjWpkOFcd11Occd
         713uarNQnJ07um1bcQoyuIrRqsZSxjPF12PC63T4k3Wc1q+lHC54xoo34zbV5t2poakP
         CljGQglEsCNEpZPl4fEQKy/J+GengHXslv4Wvut0fn9koS7blIFlhOlPlFdl3HNfU3Yr
         tB6Duo4D0KeIvi0nWEMy1ybZ5jt98T3ZassT7eK+dCM7rqL2puDIVLPDz9oy1UxRm5I+
         7TLdpWDKYxZ2XtFAJ88aolDdG545ADWzGTKTYcdbIHxIZrk9BhYBKeD4Lx/wsc2QdhdO
         3dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043247; x=1763648047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH67x5Y7eqUU5v/14msuK1UvqHFCK7J6ghaBCVs9wdc=;
        b=r503783oXYxnt5tcXoXb4tvKiB796dC1u6HZwNpGRgl5VBPq8bBJvgu7ZreiFPpds1
         tSzF9RDAKqrZziRpsKA4BScmx0a1KszTT7xNLLFkZpPZi4Z7CNI6k9fEgvCxc9jTlv4B
         S5epakIxw9tctJBi1KZ9ufczdqkeZF4j6hWpmslel3u1vguBbnPiV+QqO4lndQjojgL9
         163OFjuHvO3sqvrp2oaiFnfDp/8yEXL9QUP6wtpdyC5Hn0JLRrElIm6B+zyzuslgncwC
         ipqi/5yBPRYRJXPdxucGt+wn20GNHrz3+QPA+Q6IfIyHQRVd5A+kq3XMGnRc2naBdghN
         KOqg==
X-Gm-Message-State: AOJu0Yx3PJVb7m691T6khvz7dYh0YRnSSeriG858DFdT+z6Squb7WhS7
	f8FcLlSGUifnZzc3TcFBObLaL6lktFb5p0v2TxZaxyRKjZtukFI0aaq1Vo4CuWDzfA3mdwMKrKT
	L2O5Jc94y1kingCiS739EQqPFqueq7MOXcn6X0gMYzthcUE7uUgUUSigLCtY=
X-Gm-Gg: ASbGncvfmGeV0PZHLPvOT9YQgbrLZO12+6wlgovuzm7SECqeSbTv/ZNl5leVsBqJtHm
	aDiFBBUsKL/Gp9I4XpMhSgU98i7PQmX6+ylwNzBeHM8mwMn2cv8ikj50riq9YJD6qgwNDxBvInp
	vWFfOaQJ7Bz+okD2rtpfOBD94QL6SJ2ssg6VVkKPDDhuSnXmKGukYwwWTzuAKv0L8jb/4CrPln7
	tVyueQkRupntV6DykdPyyyk9QcR1N6nIagjs5jzv0kPIO6j3WPZVIcJg3asrKUXM1PNtZhjLof8
	ZilgiT0Kwn8nSSqMxiwS4fxRcyfqJmvZbD05zjBFP2PogmR5x03FGdTQ/2DhwZsC1IdpAfCcwYW
	vYwO31jmLUfAvNiwWkbbKb1narTU+MIxaclz2VLYjQneLMQ==
X-Received: by 2002:ac8:5f08:0:b0:4eb:7574:65f6 with SMTP id d75a77b69052e-4eddbc94eabmr87933911cf.7.1763043247374;
        Thu, 13 Nov 2025 06:14:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt/AWPn2B51uh2ijra0YCPH4UgWGFe9XZrzJKTQbv8P0dMc60pIMimwRID0WE3IIyCCDlcJA==
X-Received: by 2002:ac8:5f08:0:b0:4eb:7574:65f6 with SMTP id d75a77b69052e-4eddbc94eabmr87933341cf.7.1763043246751;
        Thu, 13 Nov 2025 06:14:06 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b33c4sm12435551cf.3.2025.11.13.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:14:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b161acba-2e0b-4d00-9bf1-3930b307653d@redhat.com>
Date: Thu, 13 Nov 2025 09:14:05 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] cpuset: Treat cpusets in attaching as populated
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251113132833.1036960-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251113132833.1036960-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 8:28 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Currently, the check for whether a partition is populated does not
> account for tasks in the cpuset of attaching. This is a corner case
> that can leave a task stuck in a partition with no effective CPUs.
>
> The race condition occurs as follows:
>
> cpu0				cpu1
> 				//cpuset A  with cpu N
> migrate task p to A
> cpuset_can_attach
> // with effective cpus
> // check ok
>
> // cpuset_mutex is not held	// clear cpuset.cpus.exclusive
> 				// making effective cpus empty
> 				update_exclusive_cpumask
> 				// tasks_nocpu_error check ok
> 				// empty effective cpus, partition valid
> cpuset_attach
> ...
> // task p stays in A, with non-effective cpus.
>
> To fix this issue, this patch introduces cs_is_populated, which considers
> tasks in the attaching cpuset. This new helper is used in validate_change
> and partition_is_populated.
>
> Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index daf813386260..bd273b1e09b0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -356,6 +356,15 @@ static inline bool is_in_v2_mode(void)
>   	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>   }
>   
> +static inline bool cs_is_populated(struct cpuset *cs)
Could you name it as "cpuset_is_populated()" as it is a cpuset specific 
version of cgroup_is_populated()?
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +
> +	/* Cpusets in the process of attaching should be considered as populated */
> +	return cgroup_is_populated(cs->css.cgroup) ||
> +		cs->attach_in_progress;
> +}
> +
>   /**
>    * partition_is_populated - check if partition has tasks
>    * @cs: partition root to be checked
> @@ -373,19 +382,25 @@ static inline bool is_in_v2_mode(void)
>   static inline bool partition_is_populated(struct cpuset *cs,
>   					  struct cpuset *excluded_child)
>   {
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *child;
> +	struct cpuset *cp;
> +	struct cgroup_subsys_state *pos_css;
>   
> -	if (cs->css.cgroup->nr_populated_csets)
> +	/*
> +	 * We cannot call cs_is_populated(cs) directly, as
> +	 * nr_populated_domain_children may include populated
> +	 * csets from descendants that are partitions.
> +	 */
> +	if (cs->css.cgroup->nr_populated_csets ||
> +	    cs->attach_in_progress)
>   		return true;
>   
>   	rcu_read_lock();
> -	cpuset_for_each_child(child, css, cs) {
> -		if (child == excluded_child)
> +	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> +		if (cp == cs || cp == excluded_child)
>   			continue;
> -		if (is_partition_valid(child))
> +		if (is_partition_valid(cp))

You should add " pos_css = css_rightmost_descendant(pos_css);" to skip 
the whole subtree.

Cheers,
Longman


>   			continue;
> -		if (cgroup_is_populated(child->css.cgroup)) {
> +		if (cs_is_populated(cp)) {
>   			rcu_read_unlock();
>   			return true;
>   		}
> @@ -670,7 +685,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>   	 * be changed to have empty cpus_allowed or mems_allowed.
>   	 */
>   	ret = -ENOSPC;
> -	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
> +	if (cs_is_populated(cur)) {
>   		if (!cpumask_empty(cur->cpus_allowed) &&
>   		    cpumask_empty(trial->cpus_allowed))
>   			goto out;


