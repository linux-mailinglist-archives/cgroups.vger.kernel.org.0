Return-Path: <cgroups+bounces-6192-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F8A13B07
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ED03A21CA
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A522A80A;
	Thu, 16 Jan 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuNBNu48"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7E22A7EC
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034867; cv=none; b=mfXzTpUJVeeG39PAG+r7PiMPdCexKNCDha7GwmbuYHCsUVPbP1Y3ngFxn3zuZU3+Emhl2CsnrAD9QVKsnKDN6ZjRx1G0IAF4n+FEdB1GFpxSRs44a6S/2vaUxeVVLmO3K3HBHroZOKA0P7iva9zCCV+2EOdIaFbYnEqFoSPQtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034867; c=relaxed/simple;
	bh=RHFOBtWCmvV7lPztg0dWQrc6RBt+/NMmdmKKcaVtJYQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O5fCZ9SDzIsmK/RDdu3haLVK9iawDGXe1cCFuLBe6TFvBNfWroAYFYwBhgF5/3vKTAfY6086MDGEZhchM2ZXrDMFFN5WqfbDV8KHoIEKaz2NFjAb1stGnF5ReZ48VELN2g0qprT9fztwdj/IMHjD1CrWk9ISspb8ZHKWG6bS49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuNBNu48; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737034863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3VCOL0D78vqUW2184mv6wyBzLiBmr3jrjU49FJv374=;
	b=MuNBNu48v5CZhRCxnjV1Y2qlixQSsrqkmXeEDkAYj5C8GPgHmAzkj7e1C7uVUeMRmMNNJM
	3KjQRK3LIgjZ0CabMlk/1VNns70UwVFX5RwV8TbQEA55wRNXVRqwaqGtbhjw1R8mZGNDJ1
	ZQd63lJSAigDn9avJYb/4ABbvo2MIJA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Jt2pasPEOByPxOD7lSeT5g-1; Thu, 16 Jan 2025 08:41:00 -0500
X-MC-Unique: Jt2pasPEOByPxOD7lSeT5g-1
X-Mimecast-MFC-AGG-ID: Jt2pasPEOByPxOD7lSeT5g
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2178115051dso19558645ad.1
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 05:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737034859; x=1737639659;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3VCOL0D78vqUW2184mv6wyBzLiBmr3jrjU49FJv374=;
        b=gdqUdmUldsSxpM+Uv+yyQ4sKuFVsVghxI3V65N6SVyU/C0N8EymdTWypDjtXBrAxrV
         2KLoFxlg0T+6HLyYV9SPjAbo9PJEylg0uX0B9ZgG/Cm0JKRsxHwQTA5/Se/HLCsrm6Gh
         5OfGXiZL5OoRoSs9fvY5E6MbZ0c4h3KpkPHU3qJ5lpe9pMnM3dIniR+T1nTd6u1q+hBH
         zRyuA9TaGl9+wETKGWaaetzZHN5KG5h3sv2freVC4P6zdsrLi8OWvDBgIxbOKpCoYwGq
         UrGGKGTpCKFZ3k4/R6NVNSaK6siJ1vWhaGyNMsnIMT9a4ag3g3QByVv3YGiM/ZAEa7cX
         Y77Q==
X-Forwarded-Encrypted: i=1; AJvYcCVajYWJwngElQZF2uwijOhVZaGpTRSGq1qas9ZWLiEaozjLH84nd2wh5sc9BbNoQQp4GlEQsupS@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMYNEAhql2ICkFteKfF1jjSf15AWyDgpewcxcylA6zyqIGZsx
	gu4NrsNGzWqCslxwoGluP7IJorA9E2lCQ4MH8uAjZY9ZfxJB8CLdUXjNQhl8HR36B1tC4uhadxU
	5G9V6xFrnU1AygdcovzfH6E24g1UwkqIhSETjl1riVzZcx/mLHpToeFM=
X-Gm-Gg: ASbGnctNZzrp/MrDmvnbBfJIg2nbrkxCtrumXA5GFpxH6ciQSOA2/1nhuCm8U4FR06W
	CaedCw+HkGPTB5UFE5TqRBjiVUnQWEfnH0RuB1XvdKiHuJ6ryuVtiX+nuvOiakWMIKv8oA7eLw9
	qs6V6N48pI3O/CZEvw9Vsxm46Cv2EDvKoAimtYRiQC81EnMhj4ryrfex1nzAymRq5HY4WxxreY8
	WjcuYPaSfOxTy1HIO2tj+tF4kj92ap2xXNvz3mkYE2As25PuN4XgJBaVPhwiVdLU9vhfVCl4s42
	XQBGpHbr+50H/nbKxmh/lkXkGEQ=
X-Received: by 2002:a17:902:f551:b0:216:46f4:7e30 with SMTP id d9443c01a7336-21a83fc6d98mr536111305ad.43.1737034859288;
        Thu, 16 Jan 2025 05:40:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSXRMV2P6Rpc0zdlVDQcdVEqMlCGxhwufQY94QDMEqPWCar0YzrlSDhf6sPLgmUiQMoissrw==
X-Received: by 2002:a17:902:f551:b0:216:46f4:7e30 with SMTP id d9443c01a7336-21a83fc6d98mr536110935ad.43.1737034858898;
        Thu, 16 Jan 2025 05:40:58 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cd609aesm634605ad.0.2025.01.16.05.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 05:40:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
Date: Thu, 16 Jan 2025 08:40:56 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20250116095656.643976-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250116095656.643976-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/25 4:56 AM, Michal Koutný wrote:
> The cpuset file is a legacy attribute that is bound primarily to cpuset
> v1 (and it'd be equal to effective /proc/$pid/cgroup path on the unified
> hierarchy).
>
> Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
> cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
> Drop an obsolete comment too.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

I do have some reservation in taking out /proc/<pid>/cpuset by default 
as CPUSETS_V1 is off by default. This may break some existing user scripts.

Also the statement that the cpuset file is the same as the path in 
cgroup file in unified hierarchy is not true if that cgroup doesn't have 
cpuset enabled.

Cheers,
Longman


