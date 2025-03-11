Return-Path: <cgroups+bounces-6976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181AA5C32F
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D983B31FE
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577525BAA8;
	Tue, 11 Mar 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNdkTVLH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD525B666
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701741; cv=none; b=Et9pnAbTcuxrBGQuzSgNVJ6vzhaTHFsCY1bUungI3zHBYpYfogS1J+ROiQERuFtHsNJMI0DH1H/vpFWzRCGwsVsYMOQejOLSlvZ2foO3wJvRTu6sp+t+5ACdMvZigzax42QALmDdX0T2dHLd06b776ZMAnyXue7h1QR7/3Hbi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701741; c=relaxed/simple;
	bh=w4/4MsuywTM8dKIEtT8CwRyGelvllPmBbieFzdzBLJI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=trJxHT9IRtUATfSqSCad1nTJT/uE4TqExvnja/WS8VNZUDk9omer529UVrsCQ45O6H9E5Tw6xGtQMslhJyFigZ7vFH1iywFQuO/tgap+tU1NKaQez20nd4S8eObO1uwZ6iIqfRtIHjDG4/hmgDrWjtVMdWrLhBQVOFfX3ts4bTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNdkTVLH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741701738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srjZEoMcmsNF1ucfOw62TWPMYLcdnIdIH/Ek8tx9FZo=;
	b=UNdkTVLHpWoHhs0Zky3u9Q2F+ZjF+d72JdOZ7cXJPe0whjaQv/qWZ92wCO7uFstKus1P74
	y0Ha5u99WTeJG+Q/bBDMEsTR2fXt3pGrc5gg7BKLD2NV56zRhXPSZXk4YtVgCajfF+hmjD
	4g9/rYMkUF8EMyP6d4fg/FL8WecOGa8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-B9ESvihmP-6QszD6qEpwxg-1; Tue, 11 Mar 2025 10:02:17 -0400
X-MC-Unique: B9ESvihmP-6QszD6qEpwxg-1
X-Mimecast-MFC-AGG-ID: B9ESvihmP-6QszD6qEpwxg_1741701737
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a8583e60so1065507185a.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 07:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701736; x=1742306536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srjZEoMcmsNF1ucfOw62TWPMYLcdnIdIH/Ek8tx9FZo=;
        b=j9XiKHFbVNRxDdiTpTPdwUAIC6VOTU2gWfG9ok/3Z4wjf5P8QaATYnXhB06v9zgCHW
         C218yYAttPXfc2LRl2IpnRYZmaJVLPGT01V2pq3Vm9tw9FjCROiYp9RSODPWvg7ZYrUl
         dkkUBjRMKOKiDQ6j5ubvQJwq8cJW7bshCK82leg5RihVA3tvzDEh5B3aBo4jtciZEf9r
         CuyR9GtHVhShBZ/mcW34S5C9RYKaGkcaEVCUVR3Rmb85QlzeG8sn9mJxi9tor7TWSEpD
         t8F0E4t6sOR2JZsqA9Z1zLUIAI0MwsJQXxcRyWaaaYw0EjRN2SxwGDHrXCZUYM0g0oKs
         mJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVGaI6b4a4Fii0Id1/Zt8QNPjkRYGhXDTTg/AudkRhdCYj5B06BeZ0su3m9/Bd0n4T+ndoyAPr1@vger.kernel.org
X-Gm-Message-State: AOJu0YyezxZscqUJpk/zRuOll+xgBW0/H27ngdzpjXskE5ebOd7zUyvr
	vH0rySXmGC+pDfac2Ul0tSeo/VeCz8FSD1sLCtPg53al3+FJ/3iGYu4Rg0sGW5BfMsOATqAAdkJ
	UtuePHU+rPV80/R9RNutvhmD6Y3VmnXUGM3KzDoh/qljDTLEq8C3DRVGENUlNAqI=
X-Gm-Gg: ASbGncvp6NOFO7HiwgBXHL1iuujTCVAoMyPOcig1j345AgoOcDsyQL5ugQWQ5XQ8/Xv
	ngrtMsKa9soctWbUU4FpA4z0fLauUqg3pIYnvKmSbjSCH/kBHBsNkNEcB9YCgm6ocaCYZ6KoJcw
	uMX+kK4fwP4JxDhW+5UkAXl0gOOzlCD+5uM/2qumXSOHuXj8PqSYYLjtE3nYGuG+uMKDJjrTx+p
	P6R3XEp9BeGEb7b2F6yvB5W0zqIw3wFYhpF5LQfkHKKJp/MGZz8CteHlCNfRc3/ckjwuqrOJYfS
	3y4zPHraitgTqeweFcP3/ARm5LrUBjfdk2nboPouFVG7QdM3ZZiYL5E5tTDIAg==
X-Received: by 2002:a05:620a:8707:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7c55670c019mr929100885a.46.1741701736055;
        Tue, 11 Mar 2025 07:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRg+L8adczL3Foi2AAcnsKmOHEJwYXqihA5sf9EJSRouLY4pSX3Hx4mbey3OW2QQT9tXALaQ==
X-Received: by 2002:a05:620a:8707:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7c55670c019mr929097085a.46.1741701735738;
        Tue, 11 Mar 2025 07:02:15 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c558a2f92asm248542785a.33.2025.03.11.07.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:02:15 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1959b178-5c3d-4564-beb3-f411cb9efe77@redhat.com>
Date: Tue, 11 Mar 2025 10:02:14 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] cgroup/cpuset-v1: Add deprecation messages to
 sched_load_balance and memory_pressure_enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-2-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 8:36 AM, Michal Koutný wrote:
> These two v1 feature have analogues in cgroup v2.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f2..9d47b20c03c4b 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
> +		pr_info_once("cpuset.%s is deprecated, use cpuset.cpus.partition instead\n", cft->name);
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
> +		pr_info_once("cpuset.%s is deprecated, use memory.pressure with CONFIG_PSI instead\n", cft->name);
>   		cpuset_memory_pressure_enabled = !!val;
>   		break;
>   	case FILE_SPREAD_PAGE:
Acked-by: Waiman Long <longman@redhat.com>


