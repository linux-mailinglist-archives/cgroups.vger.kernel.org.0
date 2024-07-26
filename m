Return-Path: <cgroups+bounces-3922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B593D9EF
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5891F21789
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C1149C63;
	Fri, 26 Jul 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvPDvB1r"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DD18641
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026531; cv=none; b=fzYmOovafalSoViCpLlDoacSIGfVw1r1HGgU2aT+4IPGDNq6x7Wj287V3z8y1eYboBrQ6iJN21AR2mcRHoIjKMTOxGNwLyPadSe65k8QYPXbj6Kfs7egbVe0kk1vQjgL1SoQIGGQYlQ8b5RvJAipvnli2VSeI63ClRupzuARn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026531; c=relaxed/simple;
	bh=Ixh/rrNw+eIsGYs+MlTokU2g7imt0hB5b7yTeSZe7lE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fip/0mRCEvRyIfu8+co4MrlmiaXcl10BZAOPAuKivDGnBB0UvsgVLOzJy52zsurF7VuDeoBB6W0w6KLVXFqwZm2SoYS3N21m9n+NbVLOh12pWLaTqDxJb5/PMBBEQlV1v4NK36Vs/AitPUGiw0DvlA4ENqyUFEfiQnubV0PdIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvPDvB1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722026528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLKC/7/2tyP1lT4igGBGFQ3t2QncXC+EiBn/shUDgEA=;
	b=JvPDvB1rwcHfuICr6vjt0+af9z+kPkMJW24272KZQ6IEcNe6q6H62bgOlvmWJlueqib4wb
	Ibt8KjTNK22NrKSCrLPNV60P5OUHQ+4qyaukq+Ed+firsY70hbOExapItwpEEt4Fz+7sZJ
	DwFlnzzOCXEx/jZUqqlkMYwRz220sH4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-EESk8H9aOfqYizW_Yp7RuA-1; Fri,
 26 Jul 2024 16:42:07 -0400
X-MC-Unique: EESk8H9aOfqYizW_Yp7RuA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1948F1944B2F;
	Fri, 26 Jul 2024 20:42:05 +0000 (UTC)
Received: from [10.2.16.80] (unknown [10.2.16.80])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCF531955D42;
	Fri, 26 Jul 2024 20:42:01 +0000 (UTC)
Message-ID: <1a4963c0-9c90-4488-b13b-92019494741d@redhat.com>
Date: Fri, 26 Jul 2024 16:42:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
From: Waiman Long <longman@redhat.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kamalesh Babulal
 <kamalesh.babulal@oracle.com>, Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711025153.2356213-1-longman@redhat.com>
 <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
 <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>
 <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>
 <79fcaba1-552b-4969-84fc-70c5151508a5@redhat.com>
Content-Language: en-US
In-Reply-To: <79fcaba1-552b-4969-84fc-70c5151508a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/26/24 16:40, Waiman Long wrote:
>
>
> On 7/26/24 04:19, Michal Koutný wrote:
>>>>> +	for_each_css(css, ssid, cgroup) {
>>>>> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
>>>>> +		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
>>>>> +			continue;
>>>> Is this taken? (Given cgroup.stat is only on the default hierarchy.)
>>> I am not sure what you are asking here. Since cgroup.stat is a cgroup v2
>>> only control file, it won't show subsystems that are bound to cgroup v1.
>> So, is the if (...) ever true? (The file won't exist on v1.)
>
> A mixed cgroup v1/v2 environment is allowed, though not encouraged. We 
> can have some cgroup controllers bound to cgroup v2 and the rests to 
> cgroup v1. It is in this case that cgroup.stat will only show those 
> that are with cgroup v2.
>
> Regards,
> Longman
>


