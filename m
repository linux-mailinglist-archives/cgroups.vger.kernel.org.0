Return-Path: <cgroups+bounces-6980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3615DA5C520
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 16:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B1B18889F0
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C025E82D;
	Tue, 11 Mar 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/AeY/bG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737F25DD00
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705735; cv=none; b=X4JOWcGtcRxKSx3jpKs/7Uy3CG35DGEyUn24jKQ/gp069FGOUG6mvL7eJSuZBdqDZYoo6uYi17oKUJxcYN2bgjBfPiKy75gx20GR7X9E3qYtLDePFKmUOtxkdqQriiBxsMTIBeA3O2A1eSsMRbJbhqoDzP4fTYhFANY06vfxwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705735; c=relaxed/simple;
	bh=Rn265ygkkN+2iuftadXyt+dK+wEgVPQ1nkSFXLpUNS4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qR6jTucRNz+QH3qD4ff/29uEmDl3LJKtbveU/ZXmhwCTt2wNDbrw059KszBpepPbTpuaJoCPN8DE4+pmDhvImAfwYQ/ZEsFxLSMKIDJsWEsuTGA0GPt2MnC/ujgMD/ItIMMI1JzZxJJEW6ricmkZvCbTRMDyTdz6Fq2eq5+u4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/AeY/bG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lq8Rh0gX8/DY3brLdpGabT9QXg7lPk4cEtKLUbOwV70=;
	b=e/AeY/bG+PdZtzzJ767DumELJTRFaIpgKXvmu5VAE3Waxh2IG5S15zGJQ/eLhiFzrx584R
	SeLyKhopKpuvafbsz+lH9rn2Bsa57qJc+qZaUTV/3JrRSVSMEgVUDZoe5fEj+TPlWx2j/S
	KabcxlfO03WGKwp/0FMln1r0aHBUGh8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-WWXh2_ldMgyv1gQ3l1hw9A-1; Tue, 11 Mar 2025 11:08:50 -0400
X-MC-Unique: WWXh2_ldMgyv1gQ3l1hw9A-1
X-Mimecast-MFC-AGG-ID: WWXh2_ldMgyv1gQ3l1hw9A_1741705730
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b3cd4cbcso625404485a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 08:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705730; x=1742310530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq8Rh0gX8/DY3brLdpGabT9QXg7lPk4cEtKLUbOwV70=;
        b=Zl/dq7mXMTR/N10LkpZIqWIHekF2YUdxiuuvuG1JDnFa9i0rUl0RigwEYkWIf04S0j
         KTh0J/yu9ZSsv7eT7YCcsKw1427RMd+ZD+qHK2QVI99DCl/7cYL28BZ4hS/zExsEovEM
         R9fM26CJiKxydHTuAOoV1kE1lqdChHM8+jibUHcW3mda7doIJ2sJwVk6u3MrBO/02uI4
         6tIHa5OBJnTovVmB12eWNReJFxIhbkmeW8HISMxw9EbdjXE3rz1MguVPrrFk6gX+NNKG
         68YFbg/lY1zXHtSdFWp+WLMkpyAFWani1ebwMbemBrwXEDiT35a0ECJN1anWo7O0SSSa
         eHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Fs1V69+3zqYP2cv29zRVtxcGPSy/DcVb/vuc1tOUM2CUfKB3ZxoDzlnrcNq0OeNU9lXk9nL+@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJRv/IkZNBt1Z4U+7ZPPutfVc9dgQ04JRNs01zdGa7ASmETIZ
	IvOmz/5E0DU7b3zqJJWjKtYM6l4fbqMWc5x2gsOXOx5A3lBxfg+b4i+ib+DdvVdp6VSmDoLYGZN
	z1wEzHyUr44vCKyNt62IJDMfQ7qoYc8q/SvKE0ZVUnUnNR56mcElnMYE=
X-Gm-Gg: ASbGncup691ZdGBBIWvo1mjGEPCqABlNFyzPEDaFf8wHud/LBaOuaPC4m7DLhSeBpyy
	7JHzvfDcJ9ZWVYT3/hyyN747kT94kAwVA5mediPz6DHqVwMhbSaJQp2KNrrJvdMsEcRSmMgNS/l
	o402pdl9ue1j2iM1dbccYa3VoUrSKXzsI2s9rUw9LGrRXIS7bzopTjlwCLHn+oz4EAJ2lcPQh0d
	23Qlc9J5JMlK8ZjKbyHrPIm0g1gYnmL/1LRqvZ9jdauAlwWX3yKxaOpxmv4pXPDmJK80O+sSSM0
	8DlaCLpk7B8wSgIhvopf3NcdnhFTkEF+d2zDaIXjbcssFGRv1q9ktmOiXtK7Ew==
X-Received: by 2002:a05:620a:27c6:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c54b37b078mr1475834085a.48.1741705730051;
        Tue, 11 Mar 2025 08:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZpXwTz3aonaP+NP1Ws4RaI/fF9Qw0N6b4g6rosPBjPZA2B5suuDkHjzezbTIXIIiVSllDA==
X-Received: by 2002:a05:620a:27c6:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c54b37b078mr1475830685a.48.1741705729750;
        Tue, 11 Mar 2025 08:08:49 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54bb78fe2sm426862885a.94.2025.03.11.08.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:08:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <130b167a-7fc7-499d-bb5f-a06638c3c1db@redhat.com>
Date: Tue, 11 Mar 2025 11:08:48 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] cgroup/cpuset-v1: Add deprecation messages to
 mem_exclusive and mem_hardwall
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-6-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-6-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> The concept of exclusive memory affinity may require complex approaches
> like with cpuset v2 cpu partitions. There is so far no implementation in
> cpuset v2.
> Specific kernel memory affinity may cause unintended (global)
> bottlenecks like kmem limits.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index fea8a0cb7ae1d..b243bdd952d78 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -424,9 +424,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
>   		break;
>   	case FILE_MEM_EXCLUSIVE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
>   		break;
>   	case FILE_MEM_HARDWALL:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
Acked-by: Waiman Long <longman@redhat.com>


