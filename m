Return-Path: <cgroups+bounces-7987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F462AA7455
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA91894A31
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C6254876;
	Fri,  2 May 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWIqJ38B"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847982D98
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194501; cv=none; b=LdPjZA9UdkergmAefZRlEQgyXZINFe5EU/jGl5VtqEDzcWi5w8gDasCJ1ic2oLmAC9Ei3uZfWt5BI8Xr8p9fRL5glQPnyYHakJwe+KOv2CGqVG1tniYi4qWDsM8wXezkeAwAHx86YBKISIknCsqulttYvIQQPqapLRydAV2BjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194501; c=relaxed/simple;
	bh=5JRuXxauXmvsWMsNDl/SoefN28RPc3kbGDYuGtJiaCA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FgmGAP7yEYqLr6BQudLcywNKSjtz33LzcHpGIS+/8IG4IXYh2kzLtKY/X07VsIPZnmBA3PPYyHaibnaMDYbXangdEGTD3WTPNlQ8goPBrAYlCbGDQet41461W/VUDByNuKi6lUBmRqncifQ3DbRTyARovQY+VLskeBKaHdhd0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWIqJ38B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746194498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QZz4S4cWzt2EIgPINY74wc3mL272EL4YYNP4eiS6Ss=;
	b=UWIqJ38BsjdFaG6pArNUc30CSegZHYqpPPVgeeZrPK4taIiI2QxNMGimPeeWIcisvf2988
	KnS1H5ba0hdjy0qzQ7H2u5W8ysaJA7/pekpr3EtVXQgF+2+V+t78JVgHjQw4c41CcnaJIr
	+5ND1FKGN667n2HvAvpJmH930wwK6M0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-C__fbidNO--kwlgi4wBpxQ-1; Fri, 02 May 2025 10:01:36 -0400
X-MC-Unique: C__fbidNO--kwlgi4wBpxQ-1
X-Mimecast-MFC-AGG-ID: C__fbidNO--kwlgi4wBpxQ_1746194496
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c544d2c34fso306684285a.1
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746194496; x=1746799296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QZz4S4cWzt2EIgPINY74wc3mL272EL4YYNP4eiS6Ss=;
        b=XwaJpEarWGGT0rKbjYX65IIe+vCXaxn4jnrn/uZHkWPgRdBhZ+MY0caHgFiJLYgIYV
         EnKX/14A/DMsSdvgTUsx4CjFgm9NubmNj7+TNsb91+yqdutJxUQFJFhQ0M2F1K4v3xi6
         hnfV0tGaIRNvaxgdybI1UmXJYmwsNQZPs4io1BuWqtLslYXKJdZy7fKGAZBtlS61XHwu
         ZdGuG7l85QusQ/lXyQmM+U84kxe365oun2U5JUsY5UYRsw0xo78prx5zdmEcGLXX02fY
         04qf9fJrOGvRCdFtG81iVirXnzceCGse2Pvd+kj/a3tWTDaMFXJEY5FHvLwdiLaucgry
         NcEQ==
X-Gm-Message-State: AOJu0YzNWscyovSSoKmFzGH1wLxpfHDTuqr0hup2qk1FWoppf2lzflyw
	9EbxCZca0qMPDt52W62F6J05uu/PMWSux+/f48TpbXiEEdbmqNZaNnYrv6ghbcyruB+Df/9YJUO
	BsRe/AlN5GBpZ3+9xm2kMGvILs0d5gLlmzHbFxoHN3hrfVX2ykk7G9lk=
X-Gm-Gg: ASbGncvtFNSo9cogC+zemqWm42WCq01OpS50arsnNx63aMFMvCPSc2MonldWSGnp7xg
	2A96Ws1gjsWVk52tH7lq5XKZjURp6szK86C8ZDp5Qu0dwmSXKGi0D8gy6B9XHGqwChJIsHQF/WR
	TOTuaB36JP1HVU9g+7LdWpDyLT7JX7e9hftqcXPG5X2XSx9ZB85aUBttYTi772zRuPJQTTmK+EN
	dZn5K89PYT1jh220WID70bLlgq3dDBWgflDS3/YUsGIMAzy5u+Li2SYzEKAgtRNCxNtEpZ1kjiF
	0XFSm7SWx0j44BlGw1WrmlsuWpCPTT+cEXNHs7n/xkUYykjIs3jQtNMovw==
X-Received: by 2002:a05:620a:3903:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7cad5b37f5fmr399936685a.14.1746194495619;
        Fri, 02 May 2025 07:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvvZC6v/MZkMsfWnuLwYoRrddDSebhNb7DaQhU9zKCm8hvUk3PXEZuMy15QDCTf23j4GNgWg==
X-Received: by 2002:a05:620a:3903:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7cad5b37f5fmr399932385a.14.1746194495083;
        Fri, 02 May 2025 07:01:35 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23b5c40sm185824585a.23.2025.05.02.07.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:01:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e33a6df8-bfa6-4a67-a7f1-21a91a0dd9db@redhat.com>
Date: Fri, 2 May 2025 10:01:33 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] amdgpu: add support for memcg integration
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, christian.koenig@amd.com, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, simona@ffwll.ch
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250502034046.1625896-5-airlied@gmail.com>
Content-Language: en-US
In-Reply-To: <20250502034046.1625896-5-airlied@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/25 11:36 PM, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> This adds the memcg object for any user allocated object,
> and adds account_op to necessary paths which might populate
> a tt object.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 +++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>   4 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 82df06a72ee0..1a275224b4a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -787,6 +787,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   	struct ttm_operation_ctx ctx = {
>   		.interruptible = true,
>   		.no_wait_gpu = false,
> +		.account_op = true,
>   		.resv = bo->tbo.base.resv
>   	};
>   	uint32_t domain;
> @@ -839,7 +840,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   				union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	struct ttm_operation_ctx ctx = { true, false };
> +	struct ttm_operation_ctx ctx = {
> +		.interruptible = true,
> +		.no_wait_gpu = false,
> +		.account_op = true,
> +	};
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct drm_gem_object *obj;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 69429df09477..bdad9a862ed3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -89,6 +89,7 @@ static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
>   	struct amdgpu_bo *aobj = gem_to_amdgpu_bo(gobj);
>   
>   	amdgpu_hmm_unregister(aobj);
> +	mem_cgroup_put(aobj->tbo.memcg);
>   	ttm_bo_put(&aobj->tbo);
>   }
>   
> @@ -116,6 +117,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   	bp.domain = initial_domain;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>   	bp.xcp_id_plus1 = xcp_id_plus1;
> +	bp.memcg = get_mem_cgroup_from_mm(current->mm);
>   
>   	r = amdgpu_bo_create_user(adev, &bp, &ubo);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0b9987781f76..777cf05ebac8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -632,6 +632,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	struct ttm_operation_ctx ctx = {
>   		.interruptible = (bp->type != ttm_bo_type_kernel),
>   		.no_wait_gpu = bp->no_wait_gpu,
> +		.account_op = true,
>   		/* We opt to avoid OOM on system pages allocations */
>   		.gfp_retry_mayfail = true,
>   		.allow_res_evict = bp->type != ttm_bo_type_kernel,
> @@ -657,16 +658,21 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		size = ALIGN(size, PAGE_SIZE);
>   	}
>   
> -	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
> +	if (!amdgpu_bo_validate_size(adev, size, bp->domain)) {
> +		mem_cgroup_put(bp->memcg);
You should clear bp->memcg after mem_cgroup_put() to avoid stalled 
reference as memcg can go away after that.
>   		return -ENOMEM;
> +	}
>   
>   	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
>   
>   	*bo_ptr = NULL;
>   	bo = kvzalloc(bp->bo_ptr_size, GFP_KERNEL);
> -	if (bo == NULL)
> +	if (bo == NULL) {
> +		mem_cgroup_put(bp->memcg);

Ditto.

Cheers,
Longman

>   		return -ENOMEM;
> +	}
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> +	bo->tbo.memcg = bp->memcg;
>   	bo->tbo.base.funcs = &amdgpu_gem_object_funcs;
>   	bo->vm_bo = NULL;
>   	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
> @@ -1341,7 +1347,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> -	struct ttm_operation_ctx ctx = { false, false };
> +	struct ttm_operation_ctx ctx = { .interruptible = false,
> +					 .no_wait_gpu = false,
> +					 .account_op = true };
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	int r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 375448627f7b..9a4c506cfb76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -55,6 +55,7 @@ struct amdgpu_bo_param {
>   	enum ttm_bo_type		type;
>   	bool				no_wait_gpu;
>   	struct dma_resv			*resv;
> +	struct mem_cgroup               *memcg;
>   	void				(*destroy)(struct ttm_buffer_object *bo);
>   	/* xcp partition number plus 1, 0 means any partition */
>   	int8_t				xcp_id_plus1;


