Return-Path: <cgroups+bounces-6843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FCA50193
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 15:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07B7171F6A
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895A1FE45C;
	Wed,  5 Mar 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPooP8QD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90143FB31
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184196; cv=none; b=oF7JHssjp54ajVbmSwUw+ddLwhKMOooBxbiKAdONmfGkWhaReeYVcDkhFofVEiILAemCIGJhw0OD6nsVHoC60Lo7fXdPVoS2wmkxV6kzW6R/UUgzuyGr+33CESxUgaaBczLRQBN9jka0oeB/USw+EvSUsjEbz4RMjQcucO6/Xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184196; c=relaxed/simple;
	bh=c5S7J2OYn+W4nZXQktdFwa61cTc7CLqDBEHPAvczxP0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wl2E+hpC1/6apc1qK7wlbKtQK9GBdf1pF9hMPzy3WJw7/Z0BAXm7YNlO/Riq0tnHUDhYVzx+jbgx7YXxII8hg/NmpAIxs/CwbWYxSKTiBZVKB6RPdsBZyIvqw3i85Eo4YK9/sCRnSzP6sE4Lc6URT4kUWFZ6y9Ho+m3eKIQS0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPooP8QD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741184193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFZHoZfRPZOBrtp2NMgzlZKzHBYfeJpoTJgjAjPn8dw=;
	b=RPooP8QD1D4MTuDhz5HRD4uRj+XhMhlS5DzFfAa6r2WXyQclNKy+AxZ+bE+SSi9Jh9Pk5W
	UxNChpYIPgbBa2JKdif+wlbGBCyFgMWEMU8iRgPhyJVj0xGk6xfM3jcTNKHkL+m56GBt21
	0H6ohMUUcuJ6lvTWu9mXwVEWOL9vbEI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-C5a6xfh_Oj6xfH_9vPujPg-1; Wed, 05 Mar 2025 09:16:17 -0500
X-MC-Unique: C5a6xfh_Oj6xfH_9vPujPg-1
X-Mimecast-MFC-AGG-ID: C5a6xfh_Oj6xfH_9vPujPg_1741184177
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-474f079562dso97723901cf.1
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 06:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184177; x=1741788977;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFZHoZfRPZOBrtp2NMgzlZKzHBYfeJpoTJgjAjPn8dw=;
        b=YgKgB5P8dmETHKP1SXq4y87JxuDsh/K4qbO632Admk6nzAA+OoNGlq0ShW+0eLb9g9
         jyk6ZCqwVYNVQAOel4n9+64KY0MaYmcRJ2pX2kFv+XxI72RLAj54UwTaMWpctvwRnzWi
         MtNfqpCYGl6QChw1uvK5ujeHncN8XP19KjW/2eOyJVr5PsF24Sod467k5wCl2bxmqff/
         4hdgYdelhv6WpmqL49QwzEHU+PCm0n+rUCPUQf3p/pUfmXMtDwKpqzx24wlazaw1RIZn
         03tp48pXYxxOKQNDWUoghmUjHRUkjMX7hXAiD74R0myJnClV8fB/LQT85v98lj30/pO/
         33lg==
X-Gm-Message-State: AOJu0Yz2STJIldfcaKl33zX7YrfbnALfM/GsYvZzeH0GPsjufkyxv/Pf
	BgxTB3ltpuYrO2bcUZJ4bJ0KeiNWuQNvSeJqalrEO3duHpDdxlFzMd3bJUAg2RDrEa4q6nrFMnf
	qsHqF8T2EQkoprG6LxrEsOfbc3VVlEio66cu8YuODWkeIP9FN26Weft51+d+r2JY=
X-Gm-Gg: ASbGncvPPVh+5lnXNvFXHPe/pRhdO/UjEj5lv9PxroHS4ubPqdEVJAwD9HaTbsLBLL3
	XS/8eMsZymrKNXSjgIvD/3nd96xukjFWTTwYL/Zxftcti8voSIU7slJR3bs5KOI7ZnObnzGG+pO
	Sz7Q05+NMfr7vuBqjbza7Tjc5HgU4BgYapndYwSgknBWqykiSRAFA2q7EEYZp/HOceTkTwFk+9E
	kYFZfTCtnqZB4TXf3buTEsyGmWeJQBaB5Nm8u1frTKQrcfHVAp2JTW9PJdxW29YDLH2wVoBHiOz
	ykijVEjwdibYYwKiaUum5oZqjbx6bjcIJubT66/hiQGSvN5EWEk2Xc3QclI=
X-Received: by 2002:a05:622a:13c6:b0:475:946:9af9 with SMTP id d75a77b69052e-4750b45e28emr32102801cf.24.1741184176947;
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2i6+NphVWLPKdROQD50Ji33QODfr+ufF7lxzb8Gx6bZBnBo6QU8mu8fpca6ltBNDLR/ASYw==
X-Received: by 2002:a05:622a:13c6:b0:475:946:9af9 with SMTP id d75a77b69052e-4750b45e28emr32102521cf.24.1741184176589;
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm389412085a.1.2025.03.05.06.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d259ba35-a4a5-4e01-b539-85f2080fdd33@redhat.com>
Date: Wed, 5 Mar 2025 09:16:15 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
To: shashank.mahadasyam@sony.com, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
Content-Language: en-US
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/4/25 11:12 PM, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>
> If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED
> disabled setting, cpu.stat and cpu.pressure account for realtime
> processes, and cpu.uclamp.{min, max} affect realtime processes as well.
> None of the other interface files are affected by or affect realtime
> processes.
>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f293a13b42ed69e7c6bf5e974cb86e228411af4e..2c267f42e5fef9c4e2c3530ce73330d680b9b2dc 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1095,7 +1095,9 @@ realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
>   CPU Interface Files
>   ~~~~~~~~~~~~~~~~~~~
>   
> -All time durations are in microseconds.
> +All time durations are in microseconds. Only cpu.stat and cpu.pressure account
> +for realtime processes, and only cpu.uclamp.min and cpu.uclamp.max
> +affect realtime processes.
>   
>     cpu.stat
>   	A read-only flat-keyed file.
> @@ -1115,6 +1117,9 @@ All time durations are in microseconds.
>   	- nr_bursts
>   	- burst_usec
>   
> +    The runtime of realtime processes is accounted for only by the usage_usec,
> +	user_usec, and system_usec fields.
> +

Alignment problem!

Anyway, I am not familiar enough with these cpu control files to give a 
review yet.

Cheers,
Longman

>     cpu.weight
>   	A read-write single value file which exists on non-root
>   	cgroups.  The default is "100".
> @@ -1158,8 +1163,9 @@ All time durations are in microseconds.
>     cpu.pressure
>   	A read-write nested-keyed file.
>   
> -	Shows pressure stall information for CPU. See
> -	:ref:`Documentation/accounting/psi.rst <psi>` for details.
> +	Shows pressure stall information for CPU, including the contribution of
> +	realtime processes. See :ref:`Documentation/accounting/psi.rst <psi>`
> +	for details.
>   
>     cpu.uclamp.min
>           A read-write single value file which exists on non-root cgroups.
> @@ -1170,7 +1176,8 @@ All time durations are in microseconds.
>   
>           This interface allows reading and setting minimum utilization clamp
>           values similar to the sched_setattr(2). This minimum utilization
> -        value is used to clamp the task specific minimum utilization clamp.
> +        value is used to clamp the task specific minimum utilization clamp,
> +        including those of realtime processes.
>   
>           The requested minimum utilization (protection) is always capped by
>           the current value for the maximum utilization (limit), i.e.
> @@ -1185,7 +1192,8 @@ All time durations are in microseconds.
>   
>           This interface allows reading and setting maximum utilization clamp
>           values similar to the sched_setattr(2). This maximum utilization
> -        value is used to clamp the task specific maximum utilization clamp.
> +        value is used to clamp the task specific maximum utilization clamp,
> +        including those of realtime processes.
>   
>     cpu.idle
>   	A read-write single value file which exists on non-root cgroups.
>


