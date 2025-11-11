Return-Path: <cgroups+bounces-11791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42057C4B773
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 05:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E011E348FFB
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180433859D;
	Tue, 11 Nov 2025 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azUjVt2T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="amQ7CydK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F0278161
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835845; cv=none; b=lsBjDByDbX/Oqr97hwj8nLJmD0qkQI91GC7Wkg5MWyi4t7V0k//50x6SrdlpX1fxrh2IDUTz4wOBJvFqa7hXzg5Thl4vXUtGyPOInnZ2LCXN80omW7BrvyLumdSsjwuvyAkSuRCNd+fRP8rOFGlMIc2d6aKXki66WceVuCEMMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835845; c=relaxed/simple;
	bh=4Ij8Kpzw53FTvwgkxB14QlL5wIlcFPKB+tSaSgu160E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b9tVQR//XQFi3rBnKVuGRUYRg1fLTrExWgFuleW0A5wi+lwjhrHcBkiR3IH+3X1poKkIvEb3NuV8vJ2jUuzu9ZaiSQ+g0jKotjit1apnD9dtys96NyWmcEF12V2q7jQtvY6NmugPgJXTQW76h3ia3bn+PY9vhI/XgS8qdmMPRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azUjVt2T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=amQ7CydK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762835842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
	b=azUjVt2TtaekSXXMf0xrc+KxZ0bwfaQq/GzwvsN+o4bq07qR6TULd/uA+FL8BPEC++ZNz5
	zmjAVjqDk0EwQACUj5sKNeSUE7B9YMiif4mTW5regekaOelsOAaTbKFhi934GKSqQ5jTNE
	SVSaiQuSgzo7CG9IXI9YjAyO2e52E98=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-taq7x0VYP7-OxrENEwBbUQ-1; Mon, 10 Nov 2025 23:37:19 -0500
X-MC-Unique: taq7x0VYP7-OxrENEwBbUQ-1
X-Mimecast-MFC-AGG-ID: taq7x0VYP7-OxrENEwBbUQ_1762835838
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88947a773so107985071cf.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 20:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762835838; x=1763440638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
        b=amQ7CydK65mTQIwvr6CjGgfX0KE5jH8dHTwAaMQM9aFWGBMKwy/zcSvR4kjmNm6xcF
         Xs9p9b3PiOhJmNLp1ofZ1H2/CeQdl1Wl40O8+D3iZ+O2IpGOPWjAD9sSJYy3xzi71A5o
         X0bEAbOjRFGHUX97DZItnPHK26Fc8xjXxINXSfKoUWf57g9xBdhQv25fmAEW41VK5+yA
         mn+mEDMkbwoADxjZd/bn3Z7KAvrAcNsmHpEPchhtlBR5MiGUhL7uh85HWl5XV2fEnu/J
         zN/t1WZpGuSJ4QRO5R08vb0SKbKOG2DQ9DWQQ2TZFhuvDKRSm6eMu/6Dv+NPSHDv0B0A
         KLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762835838; x=1763440638;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
        b=J/Mh6E7EndOaheJhoWhPB+i2L6vD/hR0SEV9AxVViDXvzIsBTXQ2BxL0yD/l/ZTE0N
         TlsOnJv9aU0cwvXLxgXc+mEwAmrgcfDktuojfsiCHmLPx44CUdWi9vZMYJMvczJSNtSY
         J6EBBlX2AcpVmUn5aQiN2VTlMMBQwjQ2ZyLqB3p8a+3OgQvROrUAjlE2EXO4rBwgWU6E
         zDKl9lQ6JGvHdDcYMdjWzGBzEF27TsqIat+YmafL116cuf3VJQVwRJE9b4vyINvoTYQv
         St/5g9q3Jhd6scgMFwUVdL7NmFejXXHfqHhxxSNLYf7/9zcJsuO+Y+spzAJzK3a5Be5A
         cRCQ==
X-Gm-Message-State: AOJu0Yw46gr7DbuFtSmimEd9tO93EHTIVgpWLrpAwtdd7UYS0L4UbTcp
	VhXPuUZKQK+2ESrhXefA5MEFX9/yZwcHRVtcZ58mQNw4yeYG/j2QJrDxtn/dwQW+5Hx+XvZNG7C
	DbIX27BbFA+FqfKg/sMF1dqYZMlC14HPUwQdy5ISJtJ9oHvnojZ45vCFrnvc=
X-Gm-Gg: ASbGncto97N9OvnHOaB2H8uBM/P2MqjBSTCGffIJ3PWY3GocM6gpczwbyO6Wb/FFt97
	r70hdm6jkKVQTux5i4iNO0Y40U4HqWDRTmCexKF5Ij8CHWZRnnNtPbqDS/6ZSqlNzGxsqNBxGbK
	4Q7pOKeBekYYp1fKwklPkvcqjMfKzpB994oqT/gPMi8icPdDkODOeeRvUuIRpBAYaxRRmxe/5Na
	G5pFrzNVCbhqVQMjzI74bikJwb9oxZA+gwgVx2fFTi3/qDi28xn9PZqyt0Am0UW2cQcxSCMOXfG
	X8qhKjAh9FWtsggaysbvXZ6W1ZoPdSzuTis0a2L++g27eFQmnbFtjHj9hdIssDQLNmxkINLEH8E
	5Xn09sY9Uq+OAKcgCu7JiIWI3vgwu0bPzJ7auYTQkK/4nRg==
X-Received: by 2002:ac8:59c3:0:b0:4ed:8264:919e with SMTP id d75a77b69052e-4eda4f99536mr125294591cf.44.1762835838438;
        Mon, 10 Nov 2025 20:37:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKIbjVumbhQ6UlTo32QTUXlZ/B0AGMGTqMqjVXCshP8q/ARwDZpWgxkIo7Vshy4zJl+b4h3A==
X-Received: by 2002:ac8:59c3:0:b0:4ed:8264:919e with SMTP id d75a77b69052e-4eda4f99536mr125294461cf.44.1762835838167;
        Mon, 10 Nov 2025 20:37:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb5a108a1sm41301131cf.24.2025.11.10.20.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 20:37:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e5a25c3d-cd81-48bc-bae0-b1b28778272b@redhat.com>
Date: Mon, 10 Nov 2025 23:37:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cpuset: remove need_rebuild_sched_domains
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251110015228.897736-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/9/25 8:52 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Previously, update_cpumasks_hier() used need_rebuild_sched_domains to
> decide whether to invoke rebuild_sched_domains_locked(). Now that
> rebuild_sched_domains_locked() only sets force_rebuild, the flag is
> redundant. Hence, remove it.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c357bfb69fe2..22084d8bdc3f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2184,7 +2184,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   {
>   	struct cpuset *cp;
>   	struct cgroup_subsys_state *pos_css;
> -	bool need_rebuild_sched_domains = false;
>   	int old_prs, new_prs;
>   
>   	rcu_read_lock();
> @@ -2348,15 +2347,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		if (!cpumask_empty(cp->cpus_allowed) &&
>   		    is_sched_load_balance(cp) &&
>   		   (!cpuset_v2() || is_partition_valid(cp)))
> -			need_rebuild_sched_domains = true;
> +			cpuset_force_rebuild();
>   
>   		rcu_read_lock();
>   		css_put(&cp->css);
>   	}
>   	rcu_read_unlock();
> -
> -	if (need_rebuild_sched_domains)
> -		cpuset_force_rebuild();
>   }
>   
>   /**
Reviewed-by: Waiman Long <longman@redhat.com>


