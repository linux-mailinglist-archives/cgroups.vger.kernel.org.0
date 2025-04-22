Return-Path: <cgroups+bounces-7736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E386CA9764F
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 21:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8911703DC
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9C298CD5;
	Tue, 22 Apr 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flt1wpCr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E0298CA1
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351886; cv=none; b=h/MdD3iQN6VCfWtkQZzRjP9vfkFBiAfnDa58PopTBiOCEQz0sWZFO2gAf+xhR35xcYoc4gafE+auiXAuYGgbFA+aiV2YZE/3jiHWJT9Uhvdz26Fobav1cmlRzVvig2Fgb3nJZq4+mmdTZfpHCtZjYuAa8jD43ZnJfShIRA2S11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351886; c=relaxed/simple;
	bh=wsFk7SmZMk84qBZqNh0ZMgVjRpY1xXUEU2RlfQzOwNw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BECGUDtj0GlNkB+hrPaJjxPiH+1qOE6vZNn6xSaMZt4p59OX48X2qDMxNIJP2sbnThwL1CeAIJ/7/5oCUpkJ0l7CZDR1kShaULyAU1u6adXbkT6PkFaXUo2ioD4Weh3WIzAzKGPYJEO9RRGgHOrGT+2sWMS381WU8wtxFeWkooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flt1wpCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745351881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUY+s/OQUXFXP8L09NRnyD2RvAyHXBwWpTAF7YObAcU=;
	b=flt1wpCreU/nfuCTeT8r6yQXfMXRBGqyMY7V852o6OW+j6QpivClvZ+9+tIK2PmDW+VCEH
	IdoMyxf2W1woeyDaNdx+VRoRRvIyZtTxyvOiIOjME8XwsBzH3iVdDuAXkuLmAobB8RQC5g
	R7HkKpuKz8GSPaK4bjefRT5i2pX1CrQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-prnXvqPtOG2JNgDecfk-jg-1; Tue, 22 Apr 2025 15:58:00 -0400
X-MC-Unique: prnXvqPtOG2JNgDecfk-jg-1
X-Mimecast-MFC-AGG-ID: prnXvqPtOG2JNgDecfk-jg_1745351880
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-476753132a8so40393221cf.3
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351880; x=1745956680;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUY+s/OQUXFXP8L09NRnyD2RvAyHXBwWpTAF7YObAcU=;
        b=HoTbUv+onkyVTlujmLjU9rWWhSOaR0eCt7aBLKe6fYuwzQoH8gLMIymIEqMA7HrI1l
         cfxVA+Wm7d9edDjztogGoFMhXMS3VbUW97T7nFEzD5Z/o9k5jWnKpwNthGKOOlqQ2yx5
         rWO5rzBPFMYwNl/mjA+P+CmQmfJzo862O+qAtDAfVzCGCF0/qZ1k4Jc/4jy/9YusKWkL
         YWGNcnHrZuX15zam96crkxyXIjjCN7dBCPKIIyOfGlah8O4ywZJLP11jo/opXu/TZXCm
         8eDPgSyn3zZS8pJVcSgyqD4ZGcFfO3EIBQrOuXiN/49SwJWoU1Ixb0kkKCGIoAk1ioqG
         EZRg==
X-Gm-Message-State: AOJu0YzQS/mnGoLv8qbt1TPLmo8PF+rpQpNY6IW54VRIvnmsfnyaezUa
	quBr7i2eexytisid2YeRQl0BqScgccXx5HqSrJP0NnyvCOQ7xOgEVf3EJBS6P3p+dqOZaAbcmTs
	lcK28FwOUkfDs+5lya/vPAkLUAr+b7YNRE3rS8OfyS6RRbFSn23J/oXE=
X-Gm-Gg: ASbGnctv+2hAbtzgojP8LIzWbKIOlKWfJTaErw9zcgnmJ1NDhcEhGej64/qSdwKFM+1
	qvtd4mNFEhfLqNcf/AHnkKp78Bm5V20Ny229gi07Ny0UF0nB+JWpfBKWlKSKrTfZLn4yydjIisM
	NnISZUZdTin2g1OGSWODvrc1JHYEGuxlEXZ1Xw4MlSiUD4aeqd8Y6S20a9hnqsiqukDWHNp0FfF
	eBp08cE4T5755G9je+ksBNiqQ0KcTryaNzwXGuJD3ah3usOYhSeYUgUuIf4I82zE9+9Zyy/iGkL
	zgqy4gzxnQ72Ko82vvwFIvznvlEtpnM7RFaqbclxM1L34dUJ/LtYNbrmPw==
X-Received: by 2002:a05:622a:3c7:b0:476:8ee8:d8a0 with SMTP id d75a77b69052e-47aec39232bmr307223331cf.2.1745351879756;
        Tue, 22 Apr 2025 12:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd7hAQKx+/wNns5UwdTf6osByvR4cMbQCvwsh66hbH0j+pw3ra8yVAyn4cmmasa59/fdUmHQ==
X-Received: by 2002:a05:622a:3c7:b0:476:8ee8:d8a0 with SMTP id d75a77b69052e-47aec39232bmr307223011cf.2.1745351879485;
        Tue, 22 Apr 2025 12:57:59 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9ce265esm59111901cf.61.2025.04.22.12.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 12:57:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ded4c23a-fecf-40ff-94ac-0d121a421297@redhat.com>
Date: Tue, 22 Apr 2025 15:57:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: relax locking on cpuset_node_allowed
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
References: <20250422012616.1883287-3-gourry@gourry.net>
 <20250422043055.1932434-1-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250422043055.1932434-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 12:30 AM, Gregory Price wrote:
> The cgroup_get_e_css reference protects the css->effective_mems, and
> calls of this interface would be subject to the same race conditions
> associated with a non-atomic access to cs->effective_mems.
>
> So while this interface cannot make strong guarantees of correctness,
> it can therefore avoid taking a global or rcu_read_lock for performance.
>
> Drop the rcu_read_lock from cpuset_node_allowed.
>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   kernel/cgroup/cpuset.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c52348bfd5db..1dc41758c62c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4181,10 +4181,20 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>   	if (!css)
>   		return true;
>   
> +	/*
> +	 * Normally, accessing effective_mems would require the cpuset_mutex
> +	 * or RCU read lock - but node_isset is atomic and the reference
> +	 * taken via cgroup_get_e_css is sufficient to protect css.
> +	 *
> +	 * Since this interface is intended for use by migration paths, we
> +	 * relax locking here to avoid taking global locks - while accepting
> +	 * there may be rare scenarios where the result may be innaccurate.
> +	 *
> +	 * Reclaim and migration are subject to these same race conditions, and
> +	 * cannot make strong isolation guarantees, so this is acceptable.
> +	 */
>   	cs = container_of(css, struct cpuset, css);
> -	rcu_read_lock();
>   	allowed = node_isset(nid, cs->effective_mems);
> -	rcu_read_unlock();
>   	css_put(css);
>   	return allowed;
>   }

Except for mislabeling RCU read lock instead of callback_lock as pointed 
out by Johannes, the change looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>


