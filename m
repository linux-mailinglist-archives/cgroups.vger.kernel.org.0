Return-Path: <cgroups+bounces-10294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36031B8A731
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD801B24326
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3131A559;
	Fri, 19 Sep 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqwCD4i9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936F23741
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297406; cv=none; b=DLlXZvVts5jXVSdvUxhsTkyiFUhhliL8/GwQAI+cuQSquJ3L6cOh1UqeZHd0RO4FM5Bu8WqSJ6YWt/2GCsw5bZWI9w4OPoZtlJ7qDPKQWDcDYV7xzGGhc1veSla4Pzs8euR/hEeRoycNyNFlBO3/j9eXpw1Qk+KDmMwmz/GODGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297406; c=relaxed/simple;
	bh=D0R5kVCxPQIDn/il8Ta4k7mCVYofZw2cjllgDPoACfM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZGhmtiMTAdtAucP0E3BG1ElWJRFWp/7ltFeMyHhA4NacJhd3jTQQYCAlihLyUxRMCIMP808y3jrA+21UQazEtQ2wZ98wWktcMEOFSNyZXN5GX2rqXEMo8O2n6p8CQ5NbJnW2sRHmOTgdVHh4SRAAbeojL33tDuiokQln3a0bGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqwCD4i9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sHkXx4w+OoPaSwn+jcuJrB3W8WiBrbLAHFAMNdkKp8=;
	b=JqwCD4i9QawR1r2JY8gxtpgtJch3FZ/HFFroajf4aY8ZlLRrcSdo88Y2dviVPd9wv3NK7T
	Bp4TpLfcRnqz3dopremIXbCG5DArF57kD43V1k9iP1kaS80VVCi9Jt6ukP6/awqxnZE6bc
	ZUQ9lORkb5WvN8BIzVJ7QSjcz9Qps2E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-3KtM_rRpPZCYRrffuRdklg-1; Fri, 19 Sep 2025 11:56:42 -0400
X-MC-Unique: 3KtM_rRpPZCYRrffuRdklg-1
X-Mimecast-MFC-AGG-ID: 3KtM_rRpPZCYRrffuRdklg_1758297402
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7a5595a05so48682601cf.3
        for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 08:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297402; x=1758902202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sHkXx4w+OoPaSwn+jcuJrB3W8WiBrbLAHFAMNdkKp8=;
        b=ctD90yikLelDjjAWJTBZ0AVFS3W4FPR6/SJxFt4SzafAtD8VnNV7eAcy+eSc5kOgcR
         83HJfN27biuCxm4MhwpZZqERe0NlS5QpRcXizUKax2oTUJqs+kJTb7IG1orKTLlCjH56
         1u79XoK5gCwNrB+oKnMk1/hUb+G6eIRKwqBwHwq5X/YKwZiyqszuZ3jWqFmUJ859Z8jH
         C0AcHJsC//IGV+gGTdUuc/mBFCxroUUoG4bSVM+DUi3iZLf5ey/BzOuaDZhZlHP6POud
         yB1ZaFlpL4GsNGDxbLjqRjBkCE19fRsjJKcaMJHr9h97Q074OI3U8E1oSPWlZL/3NRR5
         BLtw==
X-Gm-Message-State: AOJu0YwyNXcPLXtf5bkgXvqu0giI7Z38ywLtHKOvtj9qxVDzEEURQ/Bx
	jUszOUv4ore0DU4ERoBxsdtdUtBWomIpqZ1HRcMKNqjrgud2VuuHe642UedRpXVvmGgAiMtfajl
	nr7Dc9l6FOQIsyPQXnrpbLtCC5L0uUbv7R2Adsq1wYaTn4fbbpAVVPjeIgGU=
X-Gm-Gg: ASbGnctrKCu5eKMjPmG43XwM6WeWVsgsm8n0ngHzYMm46uhNVVDNqYgGQuUwPup0W9T
	wklczbhTQxdsvqFx2R/axJid9hkUolMXfSVxdav/GOYb7dq/uu98sgkPxEjtHxq64+oK9RkBbno
	JKT4BgfCDbwdqMipt/yPM94ekAaKqd7mVQHn34tc4P5BnBTCtQDtMwnDH9eTQ1vlM1Ye4L1b8gP
	+aRA9X+XphGbCs1++3Sg3PFWy4Svofst/lAcKhupdr0Jzf9+KzaoxZ8G9ofE/h/ssoNhfDmCEjd
	sMXfvPcm3dWIsyr5CRYX6D+4P6ZZ8RzhGXbgQl9I
X-Received: by 2002:a05:622a:1f85:b0:4b7:a80c:8862 with SMTP id d75a77b69052e-4c074b098a0mr46911201cf.69.1758297402202;
        Fri, 19 Sep 2025 08:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh71Li8WLeUmgSV4Dl+4mfO+VS0fxYClCgrplm39AM+j63r2SJnEhs5cDod2uOJst3FG4CPg==
X-Received: by 2002:a05:622a:1f85:b0:4b7:a80c:8862 with SMTP id d75a77b69052e-4c074b098a0mr46910821cf.69.1758297401714;
        Fri, 19 Sep 2025 08:56:41 -0700 (PDT)
Received: from [10.192.63.20] ([204.8.158.106])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda9bf16f1sm30439431cf.44.2025.09.19.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:56:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0d6a0288-33a9-4dec-8dae-1e9dc3f75185@redhat.com>
Date: Fri, 19 Sep 2025 11:56:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next v2 1/2] cpuset: fix failure to enable
 isolated partition when containing isolcpus
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250919011227.2991696-1-chenridong@huaweicloud.com>
 <20250919011227.2991696-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250919011227.2991696-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:12 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'isolcpus' parameter specified at boot time can be assigned to an
> isolated partition. While it is valid put the 'isolcpus' in an isolated
> partition, attempting to change a member cpuset to an isolated partition
> will fail if the cpuset contains any 'isolcpus'.
>
> For example, the system boots with 'isolcpus=9', and the following
> configuration works correctly:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 1 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated
>    # echo 9 > test/cpuset.cpus
>    # cat test/cpuset.cpus.partition
>    isolated
>    # cat test/cpuset.cpus
>    9
>
> However, the following steps to convert a member cpuset to an isolated
> partition will fail:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 9 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated invalid (partition config conflicts with housekeeping setup)
>
> The issue occurs because the new partition state (new_prs) is used for
> validation against housekeeping constraints before it has been properly
> updated. To resolve this, move the assignment of new_prs before the
> housekeeping validation check when enabling a root partition.
>
> Fixes: 4a74e418881f ("cgroup/cpuset: Check partition conflict with housekeeping setup")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 44231cb1d83f..2b7e2f17577e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1806,6 +1806,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		xcpus = tmp->delmask;
>   		if (compute_excpus(cs, xcpus))
>   			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
> +		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   
>   		/*
>   		 * Enabling partition root is not allowed if its
> @@ -1838,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   		deleting = true;
>   		subparts_delta++;
> -		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   	} else if (cmd == partcmd_disable) {
>   		/*
>   		 * May need to add cpus back to parent's effective_cpus
Reviewed-by: Waiman Long <longman@redhat.com>


