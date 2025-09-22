Return-Path: <cgroups+bounces-10362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C1EB93643
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EC93B482D
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530A30C10E;
	Mon, 22 Sep 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsRxGS4N"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56362F6587
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577043; cv=none; b=QVzOGWTc/Y6RpO5S3QYtbJJqwUbgHBVlrmwVUETcmKHEtTCDFxF13Og1n9m7vm9SfH3AI87g9mr5wQiLW0DR6U5KBXRA8rkId5byGwo+7KoZ0+X06GB98zk+sAQ8NgaxqGbpQ5tJgjo8kQ5FtR4t4RzB2wrYAnRWtC1cMa7Xm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577043; c=relaxed/simple;
	bh=uSLiGVlIIoM7NyajIMOQr8NBUWho6EVv8VLHM6IJx6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S7Fc3vmjJHQ+IAfL4bxJmXiEENkwzjdxOm8KnPB4owEUBTWhsEpZDhyIoHlmJ7LLQ8PnyaojEaaXlyiTvSGkzLS6TYqLZG4HTWjVxLTl9m+ox9RbZ56XS2FP3YzmDRPYUzihDs2RthpLb9oUJD+fCwrbvZYjSGud1OuZIJW1/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsRxGS4N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD26UGWYp2I8NuboASBVlnAzd6CeC9jo2ngEN55ArA8=;
	b=IsRxGS4NIPsaTzO93DqnEthTX7+BTVOddPMxWnrQCxLQJz7Qp3aLfGh91Kq0uRzzBJH+8t
	JXDhSh348fGv0lKOLyi3ApUfdI7/tzJskPtrBt+Oqi/2KSlsfnhHsKLVAt6HK7mw7M13Ri
	zQCMoPAXZHPcoA12YmNkwwDm/qXiw+A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-GrVZSAIwOVaasCONq74cow-1; Mon, 22 Sep 2025 17:37:19 -0400
X-MC-Unique: GrVZSAIwOVaasCONq74cow-1
X-Mimecast-MFC-AGG-ID: GrVZSAIwOVaasCONq74cow_1758577039
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b78fb75a97so58354811cf.1
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 14:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577039; x=1759181839;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD26UGWYp2I8NuboASBVlnAzd6CeC9jo2ngEN55ArA8=;
        b=eRfDbHw3C8vGZ6m9riEN5Khh8xCm4z5y+OwxPuPUIlLrYXVqtx4vWNOqcSxlQaZy/T
         CO/ofYmUU4F79PvytiW96pdVtz3aapDtRT1bPx1D/+Xjn4EumPVvX77JzitSUdeFyeN2
         iFTKpnnVfLE96osg0nmFiBHSTuvghCvdZ7HsSVgi1IUAG9L7p+FltD4r/9g4RY0P/fFt
         qEfpA4X2My+SH602FAgdMpXcSGtqsTkqkVHRaM0cvjbpoX39qBgPzBuxb3n4W3nsgBgi
         H3YrLUwBbmEldnYBoRTHg9tGF0FeixCwyr7azPswQdYwvYseELhmQql1zu8GObsb/31F
         QlLA==
X-Gm-Message-State: AOJu0YyjH6YdcjPnMmYXJjJj5JyOmgFNVNXeAbSYra/imtx6qa15Q4hZ
	1rQobn3pmefL9u3e0279yGwlaLSCow/gxjAjauGkA/o4nX3W2J5CNgVDE6x7/hvDYT8Q4CiyDpC
	x4UqknBwygaujLyqLupk3qVgPXMVqQGwdx+W5POmriSrj2Zd9Ww0lIJ4v03Q=
X-Gm-Gg: ASbGncv6sw+dM9oQnEbwSk/ET+7QoYVYhq8TOvzlaerXrrGQFSMObJKx2zHgTUg1WSq
	UNGj22nRJgMDzhwNAUzR9+dBRQOkk97lzxgI4Zxluzm5B+C7UvrKps+fbCWwVWQ3G691VIJy6jx
	ZRtrQu54WqY6wq34RUU8yRbaFK88SN38Vov/rk+7lYQH9cAAc5AiUUeE4UKBSeCdSf1jspsIUcM
	tByHc9myVzydVBeG3fQ7hOD2hSrYxahlaQBh5RuFAp7/S9pAA9DXepnQ6qT4AT85+hvP+B8HLfv
	N3t9utfub4RFbLhSyvLHiay8z1XiyL3G+bkRljOsy4ytvR0H+xAr93F5BlVsu2GmvIbcnf3wVMg
	DgIsBqzjZ+NE=
X-Received: by 2002:a05:622a:1106:b0:4b5:e6eb:a24b with SMTP id d75a77b69052e-4d368b7661cmr4386301cf.34.1758577038853;
        Mon, 22 Sep 2025 14:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU56HEEnLu53dBShyrwugDcXuwnFtK6t3b/o7o9H27urog2Z0nV0RGNeximfHc2tylrXNVAA==
X-Received: by 2002:a05:622a:1106:b0:4b5:e6eb:a24b with SMTP id d75a77b69052e-4d368b7661cmr4386121cf.34.1758577038542;
        Mon, 22 Sep 2025 14:37:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d1046b5dd2sm9810341cf.49.2025.09.22.14.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:37:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fddfeb3a-2a1e-42be-b2ad-8b6fa5f24f9b@redhat.com>
Date: Mon, 22 Sep 2025 17:37:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] cpuset: remove impossible warning in
 update_parent_effective_cpumask
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> If the parent is not a valid partition, an error will be returned before
> any partition update command is processed. This means the
> WARN_ON_ONCE(!is_partition_valid(parent)) can never be triggered, so
> it is safe to remove.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 20dface3c3e0..196645b38b24 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1923,7 +1923,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		 * A partition error happens when parent has tasks and all
>   		 * its effective CPUs will have to be distributed out.
>   		 */
> -		WARN_ON_ONCE(!is_partition_valid(parent));
>   		if (nocpu) {
>   			part_error = PERR_NOCPUS;
>   			if (is_partition_valid(cs))
Acked-by: Waiman Long <longman@redhat.com>


