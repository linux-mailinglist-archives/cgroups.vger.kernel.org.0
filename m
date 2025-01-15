Return-Path: <cgroups+bounces-6167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98412A127A6
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 16:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3191E3A5DA7
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82EA1487DD;
	Wed, 15 Jan 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgshwJJk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD878F4C
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955488; cv=none; b=Hviaizy6+rML/aHECheXfEsU9gxLkV5iBOC3bXkGkHBsYp7s/y2J4m20X2Yh18Ys6aZhhNylAHM6jMIUUHHBqpX+owakvy3Npa99rn0jZBoU281xhsd1eEZD+/fLr0i5ZkgbhVpKujYhqZ+0Ak9G8DD89UGn06Wy2v+CFc0o46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955488; c=relaxed/simple;
	bh=MaVBmfrDLMSSL7stgMqnf6r/mR1SJkUtN0Cu8gxvMoI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=tw1dWEuZ5CDEyY/7Ab70lIbc5tWrh1bXCVorZzKnvyhNB1wEg9TlRmfTqWQtQ7/J4SxaU3r0bWaehMT9FylQeFGTim0kcglMT2pbzp2YtgfHy1Hr5xcUQCRG2jdABd/05OKgFDEaksqzxQNQ9TATA8pjj7QpQZDSyetrDZQcXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgshwJJk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736955485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0I7Om+ETQILs6hUFqJrm+0SzhU/+dIzjjDRCCwQdBPg=;
	b=PgshwJJkhfs68LtZSNrhUc/Lvgn3o2sBB5bvNiUmK9EwlevqbisfduLkrchCgT25DWUQjO
	vmI9shLKfIxh/QGLLYpet3XLuNtu/W3PJiPQ6qfu/dG2BfJdhVuVy9c81Z7lUADwkFCFxJ
	/FkrL21enBUOXyXGqEBhQ1OaXdf/fUk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-FXuDxmEFN8qpttBp016c-g-1; Wed, 15 Jan 2025 10:38:04 -0500
X-MC-Unique: FXuDxmEFN8qpttBp016c-g-1
X-Mimecast-MFC-AGG-ID: FXuDxmEFN8qpttBp016c-g
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e7f0735aso1070561985a.1
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 07:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736955484; x=1737560284;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0I7Om+ETQILs6hUFqJrm+0SzhU/+dIzjjDRCCwQdBPg=;
        b=HBQUbb/iW8Qk2tax9xxAHrbRlwCiCV6tG63PTEfTWZnuF99qXJT5B/lGDwbM5SkSs/
         hvX5ZeRf/kKUmWUbs+U4z3dGYBhwxyhIUMtr/QENAw2gzjUrXZXGSJfO0sOW/s7DdIsL
         b+7u7qr5JdjgZiLF0zA++iPILqNxsOLEjAfyGx2JCIkI2974vhGHPOhH3WhzRXGNMH9L
         Be+DsK4MMcQxGoojFLLKFzhsVrs3zeyS7mObeLzeaXU3X0owhjRy5tLpW2gq/2pob0gS
         Dy61ikHW1cArUnL9d3/1k2qZBY7w59Qm5DbJUwMxygJYWZ82fq3HJiMG04MeyHxQ6CCf
         o7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP6Odp8eoJX6PMJQL5XYb+e5yu94/16UX1kmFaxzxo9mQX26BuyY8LxyrzzdUYsFHJporXQpac@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqDqLKzuG2MdRLsfDXsz02qZG0OP3lI8vQbwO6lgDKrzhgbwj
	i5zeVADfadnjKug6lC5cKvsoeQDksq97ZwlKyTbMpiNtvlOaRFgkyfa0xh/0j3+vaqpmsNuvz7O
	dv71KD24wB+N3yS+cobclnSzZhc1/Fm9bQ/ojIfV/wW05jcEqAV58tcI=
X-Gm-Gg: ASbGncvvnqdZ/0+8BQQnANuAikwpLKSx8Bg1MxTi73gFyByxra2YDwu2beLBeIB/r82
	Y8M19q/1RWGaEBw8psNOdU+VN9xEpRIrDY6KtyuFO0JKnf1AWnuhVCUo8ts8JK1qzTuptjRsgzc
	DpxaW0z13PZ2nmL+KlhpiOq0FsFg6hjIuQbT5+21VrfvKa1VQ597n9AQYtaXP/B4zuxL7x0J8J2
	vgRF0LnBFDDaNwRJk/+mih/f0Ja0SdOD7zIyY1UfUS8MJWv4SCD9l2PAaoOGvalecvElf9cDg41
	K3qK/PRG5e8AUR7myVWah4jH
X-Received: by 2002:a05:620a:3953:b0:7b6:f996:c507 with SMTP id af79cd13be357-7bcd97a14ebmr4874956185a.40.1736955483904;
        Wed, 15 Jan 2025 07:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt3gZxlkqNty2pp049LaJYIbUlNaLN6AOhS/nDpOGpXD4r/GviOokZDosW1GIloKoghphMnw==
X-Received: by 2002:a05:620a:3953:b0:7b6:f996:c507 with SMTP id af79cd13be357-7bcd97a14ebmr4874952785a.40.1736955483544;
        Wed, 15 Jan 2025 07:38:03 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm723104385a.100.2025.01.15.07.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:38:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <006c1475-b45f-4339-ab53-0e7be51514af@redhat.com>
Date: Wed, 15 Jan 2025 10:38:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/25 12:05 AM, Jin Guojie wrote:
> When running LTP's cpuset_memory_pressure program, the following error occurs:
>
> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> then set cpuset_memory_pressure to 1
> (2) In this cgroup, create a process to allocate a large amount of
> memory and generate pressure counts
> (3) Set cpuset_memory_pressure to 0
> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> current kernel returns a value of 1, so LTP determines it as FAIL
>
> V2:
> * call fmeter_init() when writing 0 to the memory_pressure_enabled
>
> Compared with patch v1 [1], this version implements clearer logic.
>
> [1] https://lore.kernel.org/cgroups/CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep36ZHe6HMQ@mail.gmail.com/T/#u
>
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Suggested-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 4 +++-
>   kernel/cgroup/cpuset.c    | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..7520eb31598a 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -66,7 +66,6 @@ void fmeter_init(struct fmeter *fmp)
>          fmp->cnt = 0;
>          fmp->val = 0;
>          fmp->time = 0;
> -       spin_lock_init(&fmp->lock);
>   }
>
>   /* Internal meter update - process cnt events and update value */
> @@ -437,6 +436,9 @@ static int cpuset_write_u64(struct
> cgroup_subsys_state *css, struct cftype *cft,
>                  break;
>          case FILE_MEMORY_PRESSURE_ENABLED:
>                  cpuset_memory_pressure_enabled = !!val;
> +               if (cpuset_memory_pressure_enabled == 0) {
> +                       fmeter_init(&cs->fmeter);
> +               }
Nit: you don't need parentheses when there is only one statement 
underneath "if".
>                  break;
>          case FILE_SPREAD_PAGE:
>                  retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..3583c898ff77 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3378,6 +3378,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>
>          __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>          fmeter_init(&cs->fmeter);
> +       spin_lock_init(&cs->fmeter.lock);
>          cs->relax_domain_level = -1;
>          INIT_LIST_HEAD(&cs->remote_sibling);
>
> @@ -3650,6 +3651,7 @@ int __init cpuset_init(void)
>          nodes_setall(top_cpuset.effective_mems);
>
>          fmeter_init(&top_cpuset.fmeter);
> +       spin_lock_init(&top_cpuset.fmeter.lock);
>          INIT_LIST_HEAD(&remote_children);
>
>          BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
> --
> 2.34.1
>
I just realize that cpuset.memory_pressure_enabled is on root cgroup 
only and affect a global flag that impact the behavior of all the 
existing cpusets. Your current patch will clear the memory pressure data 
in the root cgroup only. The other child cpusets will not be affected 
and will still show existing data. This inconsistency isn't good.

OTOH, I also don't think iterating the whole cpuset hierarchy and 
clearing all the fmeter data is worth the effort given that cgroup v1 is 
in maintenance mode. Perhaps just a simple check to return 0 if 
cpuset.memory_pressure_enabled isn't set like in the v1 patch. I also 
don't think we need to clear the fmeter data in that case as it will 
lead to data clearing only on cpusets where cpuset.memory_pressure is 
read while cpuset.memory_pressure_enabled has been cleared.

Cheers,
Longman



