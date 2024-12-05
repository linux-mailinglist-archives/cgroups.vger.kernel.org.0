Return-Path: <cgroups+bounces-5765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E149E4C9F
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 04:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB77188188C
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BC18E37B;
	Thu,  5 Dec 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecisg8ge"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE018C332
	for <cgroups@vger.kernel.org>; Thu,  5 Dec 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369092; cv=none; b=CcVq3xC0ZmWRnvHgp88lkg3gFfWgeEtTh+DcK2hVQj37bT9vJw3jX95xwz2Vvo09k7acsYXV21lW3TEpVaqazRdMOS2I5+5If1jtibSWYZhUJeNI2CY4x9otaQ2oYFW6yivIR95o2W3LmggGDfpD4JnnDQ0W5LPTRl0er8j10iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369092; c=relaxed/simple;
	bh=RwkxEFFv8q3ISwP2l+RC1VYFZ/XHGfddE826DaC9HK0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=T80BsrvKhny128S5wybcSgy0csh7qpIuKghnYShr1YR0+8/JNIc39VvSO3LXz5ZckJXSg7cGwOAPA727V3NBpOx61BmOkEmMQOfmg4hN4iJXWlITX2WgNmhBFc5owJc2O2GZ2426pEEQ0c1G/t22yKzTqESu0fxZA+yp2IFsntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecisg8ge; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733369089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiW4fVWTfbek1lugR+wCShZlU6+zULbZMymUmbRO2/g=;
	b=ecisg8gev0a6+JFz3zQy12n7EaNcZwbKSyIJHkcjhpOniswgwhHHPgToIh1ORx1tEoxt/d
	g/1maOWMAYmPkFhKLy1KntJZyU6MC/1ixcADF83U+egdSq5FWJGlkkaRtSYVF3n3rXpnEi
	+duiN7SjPxfYVHSE76j2Im8GuYKS1kI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-XrREeTq0NS-qySxaSIGkMg-1; Wed, 04 Dec 2024 22:24:48 -0500
X-MC-Unique: XrREeTq0NS-qySxaSIGkMg-1
X-Mimecast-MFC-AGG-ID: XrREeTq0NS-qySxaSIGkMg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668e97e00eso9041531cf.3
        for <cgroups@vger.kernel.org>; Wed, 04 Dec 2024 19:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369087; x=1733973887;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiW4fVWTfbek1lugR+wCShZlU6+zULbZMymUmbRO2/g=;
        b=kwdv0c4ZpjpLrjQAaRB0eLNqPoK9hQ2MFpPGK5QuvuxzBEvefE3CeDqcjdKPc4ixOx
         NKvwm0atUChy3ZRw1Dd0zBpHl9uEzE/NMHV/5UDdLY+LhVvppTQvhKokir6I63d4VzdT
         6XYNgbhY8Np0KQcnDIEuRJ0+vbktdgjX3Ppq/RDtW/R1BgkG7OJLJCjdJeaivFM1l8wK
         FMw3347mTAZJ4C0ZROtLB6eP+PCLBlGxL/FKURU1ufGYcCe7Q3tXcLXiyskbvCQjATQk
         54jEvS50tdTmQjr/jCYe9osnmqy+1d1DgVlDnx90mjqw39l8EkeOvIOHc268U0QX5jo3
         wE7g==
X-Forwarded-Encrypted: i=1; AJvYcCVmTgdOD3P2U0x9wgYqJrcg/mdLZmXHNb7gSi1S+KFHTP3saozsQGXvwgrwa/QENxncVj+pTvAj@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPOvOtARxRC5xBBaryKAN0k/in7XVOJ5nuOaifU0oUPfSgVt5
	GYcjoxZAoI9+C8i5Bcy5NDNEyvJKUZuT9/sk7g6rTmTNIqg36NaeOppolsEzoMQLKbd2ez8Joi3
	cCwTJ6w0cb9SxK/6xXswSossKAt+a+ZNu/yq0O+h6A4s3s5Z51pohBAOhNOaZf2Q=
X-Gm-Gg: ASbGncvqQXxBzVKBZ6tizg09HyCdzOSdljtZWkg+HCoq/TA3enbo9A8O9u4hC+D62Zm
	2cYxrgZduRq2f17YOD6/fIj39BOFmY6IbXVWZNmgOdhrBkkJ/kiNaQxIYf5S7isaALjYFECUjrz
	3i4l4RTfjON9GteR0/6L771pv+Jr+bdRJtAjRPSvroTLL7urOOX+UxH+JiX9WpGPLV3LCk2pbOJ
	VWHg3tX/CPtnnh1QmNW52GCWIJpBBNX9UuPJLlnpt+2GO08zwtUg5ZYE2CAYJ0Nz4doNq8FSCi0
	xB1GnpBgA5Qam6xl9g==
X-Received: by 2002:ac8:57ce:0:b0:466:886f:3774 with SMTP id d75a77b69052e-4670c06e83dmr154847781cf.8.1733369087332;
        Wed, 04 Dec 2024 19:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWtUXxytWVON4jfgw8C4Dr74OEBtaexKT/xIm04jm+Elc+DONnLu38y3+rhOG+Ezdamtl+8w==
X-Received: by 2002:ac8:57ce:0:b0:466:886f:3774 with SMTP id d75a77b69052e-4670c06e83dmr154847591cf.8.1733369086990;
        Wed, 04 Dec 2024 19:24:46 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296a4930sm3288371cf.18.2024.12.04.19.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:24:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <92427cf8-782c-4681-b0e5-a7ebee79dd63@redhat.com>
Date: Wed, 4 Dec 2024 22:24:44 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Remove stale text
To: Costa Shulyupin <costa.shul@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204110442.348402-1-costa.shul@redhat.com>
Content-Language: en-US
In-Reply-To: <20241204110442.348402-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/24 6:04 AM, Costa Shulyupin wrote:
> Task's cpuset pointer was removed by
> commit 8793d854edbc ("Task Control Groups: make cpusets a client of cgroups")
>
> Paragraph "The task_lock() exception ...." was removed by
> commit 2df167a300d7 ("cgroups: update comments in cpuset.c")
>
> Remove stale text:
>
>   We also require taking task_lock() when dereferencing a
>   task's cpuset pointer. See "The task_lock() exception", at the end of this
>   comment.
>
>   Accessing a task's cpuset should be done in accordance with the
>   guidelines for accessing subsystem state in kernel/cgroup.c
>
> and reformat.
>
> Co-developed-by: Michal Koutný <mkoutny@suse.com>
> Co-developed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
> v2: Address comments
>
> ---
>   kernel/cgroup/cpuset.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d5d2b4036314..ee62207fee9f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -207,10 +207,8 @@ static struct cpuset top_cpuset = {
>   
>   /*
>    * There are two global locks guarding cpuset structures - cpuset_mutex and
> - * callback_lock. We also require taking task_lock() when dereferencing a
> - * task's cpuset pointer. See "The task_lock() exception", at the end of this
> - * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> - * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> + * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
> + * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
>    * structures. Note that cpuset_mutex needs to be a mutex as it is used in
>    * paths that rely on priority inheritance (e.g. scheduler - on RT) for
>    * correctness.
> @@ -239,9 +237,6 @@ static struct cpuset top_cpuset = {
>    * The cpuset_common_seq_show() handlers only hold callback_lock across
>    * small pieces of code, such as when reading out possibly multi-word
>    * cpumasks and nodemasks.
> - *
> - * Accessing a task's cpuset should be done in accordance with the
> - * guidelines for accessing subsystem state in kernel/cgroup.c
>    */
>   
>   static DEFINE_MUTEX(cpuset_mutex);

LGTM

Acked-by: Waiman Long <longman@redhat.com>


