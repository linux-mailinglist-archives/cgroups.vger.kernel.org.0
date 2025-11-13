Return-Path: <cgroups+bounces-11906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80089C5563B
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D3C3A64C9
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C129DB88;
	Thu, 13 Nov 2025 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQiDyARZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMfjxcBa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E01F181F
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999618; cv=none; b=gnmVuZ31V1sBCtS/MBWzql9Z8qWfsfmEACppa2ZgSoO/IuUzTBA6y6lRhcFy68TvXiTD8sC7rKkqXCQO0l9RCgHwcFE/V02HUwaOz/bhcMMvNAGgnSZSG5ZyGI84IOPcjYlh2jdqVHoykaTLvX9lYrpwrYqbQjBnpizIJiNpFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999618; c=relaxed/simple;
	bh=IahK6y5WaenF4MCU8w5zfMzE+ab1EnS1xLPbJ9kZCQM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gBWUV4Qo+XFzIn6okcA5p1A1STBxdMaa7+o2CQxsOTQQkZuaieCDXmgeQPaR5gkBHuqPA7fBZmlfBK2ntx6ZYBTX/ZuTAPJligQTJD0mPXHI9gnLfNkThASjJ21NUEl1xawU8tBRDFg1JcaNJ61RtfSNiW7rxssCVBjI0LPjLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQiDyARZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMfjxcBa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762999615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwLfxiEgNX9ofFATsdLOeVj72vW/st41Tfih7kYHKv8=;
	b=EQiDyARZWlIqPhW7ueb4QGxBKqcTicymEZCj9oiiYAdPVpVngMHYdfyQcBdAqG2ey4RK4b
	bUMeGKrQdwH68PUnr/peRssmU5knANxVQvwyyEl1OFsYY2c+9AFCBetpFs126BtLxInBjO
	ZiYzcCTugvqaQkVc19feywWSmF51INc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-H0pVoMnxNBauDtOX9r_7Jw-1; Wed, 12 Nov 2025 21:06:54 -0500
X-MC-Unique: H0pVoMnxNBauDtOX9r_7Jw-1
X-Mimecast-MFC-AGG-ID: H0pVoMnxNBauDtOX9r_7Jw_1762999613
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b12cde7f76so122576385a.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 18:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762999613; x=1763604413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwLfxiEgNX9ofFATsdLOeVj72vW/st41Tfih7kYHKv8=;
        b=ZMfjxcBaHKxZkT6EZxPErI+WuS4+Bv8BFzEtmOa9MT4yuAzlTL31+n9wypyDE5TIWU
         Wu0bhvQF1KbxALaKqkaoNw2FXfS/UInYCdyXd3xqrqJsE2Ec31hxIRXYvnx1+J4OvyDj
         bV0ZqR0e+WThyucyL6Zq1KeN1fsHKTqcNA1eoCGuBRPbBw4TwxrJx1ucqqrgKY6vx5qV
         CjqZjranVq1HvEEr7qIIKUgUBa7ft0pCxxEfFHhm95LGeisNJCG0d+5fJPB2ZfclrxM6
         dFS4KIpGMNNHqSb1zO9zscsyH+FabzfgcaRI4kxsYNcRWBVelGjmpjibVnbq3GEY+1aP
         FKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999613; x=1763604413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwLfxiEgNX9ofFATsdLOeVj72vW/st41Tfih7kYHKv8=;
        b=B9WaP+9ZbKfVEkHWvTj2kQP1lc7bWODyy0Y2iHyrYv8F/5ZsHhGZus3IDeZP7yF1g3
         PJG6sNMFcC8TZcRjRm5WMxnZjK9a+M+5MridBi33+r1J67KxhqC4lDCu3zTckvLCuPpX
         wgZ+7P0+BNVss1WUd+qEMpDOm/3qSYwIpHRu5IBrxmNQUIB2TpQeEt6kDmkH6/G004y+
         SKcIg1PaMlCzf+F7wlm1/w0eHu8DOt29dbu43Ewh42vc6AL0GcvqOVM02PTK4h1tVHzg
         jVQVE5LLK76IF725QEsWjeaF+D63BcNqBHSziVTBIF86OAVurpiNssqO4kzOKNTSx+JS
         R9LA==
X-Gm-Message-State: AOJu0YzVqgzZHVN5FHAIj1DhegZzzf96XwsabiG2m3zgXJpuRPOMPr5i
	K0Ptm9llW9UjwwZ5+k9B26x7VuuZEuMNUCR9HCXWFFrxu5d5Vwye98a9/hv741cxEfC1bWG3FtQ
	kblTuMWDgGmUpMDCCeYZShTjv8EsKV84JL+9ZOtamYph8raQJk0+Is4tnP0w=
X-Gm-Gg: ASbGncvGMRsQDWlZFIV0tSGJar0jDG6TZ0tQ0sW01NdNQ7Mq2wxCSDgibWRr+zua79o
	iD09kPGikwRo5nITE8L43MhJZydtjg4TektGRh/+32zSi/n4JpWhiQ53fCQyiHHha2lgWEiaequ
	xhjwnAkHkVB2MxeDuCwbUXSQ81I3dXqZHgzeHl+j+B9mdJrwb13N6gdOSblCRwduV9tAe+fahnL
	zar1+OxjGOs2MSYeUE3Lfx9vcBdp+u7wysb6hzOlck523uxC4EbQjPuLrHdeLMOZYk5DvBccQF2
	pR1xuOvGs58QC3FHglO0hmocjLCLC9jGLP9LLqanjWAtq0Q5i0iFIb7sH83jjXAvpWsRnR0Wyzb
	5Qm0FYx0GSUHPQvYonnnlOIg+kcV06bALAe9ir3NKPjMmqQ==
X-Received: by 2002:a05:620a:4692:b0:8ad:453f:8b19 with SMTP id af79cd13be357-8b2ac1ec6c3mr225518485a.32.1762999613623;
        Wed, 12 Nov 2025 18:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOI/YfNKWL0Jyv0zeQOmK7Xhyn4wG1lOa7dtDlEoeVUKwP9+WhvUSSS6dR5cS4lcK53Zyj5w==
X-Received: by 2002:a05:620a:4692:b0:8ad:453f:8b19 with SMTP id af79cd13be357-8b2ac1ec6c3mr225516585a.32.1762999613295;
        Wed, 12 Nov 2025 18:06:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aef2f9bbsm38251885a.31.2025.11.12.18.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:06:52 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3b3b49df-c215-4f7d-b2c6-628eac823134@redhat.com>
Date: Wed, 12 Nov 2025 21:06:51 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/22] cpuset: introduce local_partition_update()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-14-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-14-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The local_partition_update() function replaces the command partcmd_update
> previously handled within update_parent_effective_cpumask(). The update
> logic follows a state-based approach:
>
> 1. Validation check: First verify if the local partition is currently valid
> 2. Invalidation handling: If the partition is invalid, trigger invalidation
> 3. State transition: If an invalid partition has no errors, transition to
>     valid
> 4. cpumasks updates: For local partition that only cpu maks changes, use
"cpumask"
>     partition_update() to handle partition change.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 153 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 148 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 73a43ab58f72..49df38237c1d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1822,6 +1822,59 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   	remote_partition_disable(cs, tmp);
>   }
>   
> +static bool is_user_cpus_exclusive(struct cpuset *cs)

Should we name this "is_user_xcpus_exclusive"?

Cheers,
Longman


