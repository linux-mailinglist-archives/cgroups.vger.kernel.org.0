Return-Path: <cgroups+bounces-11890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB89C545EB
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 21:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 390B13450F6
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39FA299A8F;
	Wed, 12 Nov 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCBIQfeP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKuh6Up+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7D27E040
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978165; cv=none; b=pq3LxtZaTz+/Bhpl9A/D6DTH8atZQkL587q4tBEAMUaQNbyjVXstSLkhnsyj3oO3z6jsBlyA+WfZmWb0+j0Z6f2Hg8f1yMb8cI5j+vVMfwueq8wENjgG6ceHQppE/vUFJ8Og8PD10wOPbCNdDvlVVzdAFuFnhbNC9L9iPaKDHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978165; c=relaxed/simple;
	bh=Q7jKv1JlKhmirpqCatrnUEr8E5+mAGjOY7Wywiyo+Sg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hGAZHrjeR5Vnql72HNr/0iimDi/KLPBDItEH5iB7bWXAQYI6sZeA8z1Mor3G7PWbHT6irC94s+7v1DziR3sNx3wgYYVduIhqQ/NltdeIgVpk3hImQKEzKinDXNi4v3p7knv7XsBqN+Q5i/OZ90SleGJOVQJihfhCIdjidbgEl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCBIQfeP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKuh6Up+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762978162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
	b=OCBIQfePoC9OcUhtc6DukvZcNTmrULylBn2JyPGN9nPyf2rzAZx0907ykeoJi8nfAi0PdA
	em+wY+WSH9ciVWXJh23u0A24PgKlk0Cm0n1zajUiHIw0ANvxzFenDxmKH80lnCgH6IwR2C
	C+gt9sOgOeRl75kmdsFjR3Vdy2QwQhw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-hS3XCH4WPCOhJCKkUGZgRQ-1; Wed, 12 Nov 2025 15:09:21 -0500
X-MC-Unique: hS3XCH4WPCOhJCKkUGZgRQ-1
X-Mimecast-MFC-AGG-ID: hS3XCH4WPCOhJCKkUGZgRQ_1762978160
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6ceab125so850891cf.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762978160; x=1763582960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
        b=PKuh6Up+4JUfWIEmgE2vTDO0jw+9xBDnw9DilXXoDtKk9u2b7JP5gR2o+vIoYG8CTB
         4BxjaJFvV5H6FGTuGIIr9yQbdm0IkdV2kWyR39CTDgAVmTn7HKHm9EtE2HfBjYApU2ef
         QSuLgXTK8Un0Kkpom9DGXLn05Gpwf8zDrPrMB/thhlXC0v7dmSOUr7IIg0pjEW7G9B+v
         YOsF2lDltZ0BvYu5lHPa3Ach9UE3GZyyrbNia/iYFpKEs6quM3WAZNoDZo3nE2iScvz5
         by8IakZC3oR73oEvgRB4RTecTLQVgJ35IsNwGofgxNzeovIFx/d3PZe3sXm5lDqBq6zP
         EJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978160; x=1763582960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
        b=F6v+RigjpXd0RTBLTFb83uTS3W4Tx3qh/RhRXwIrCxk9O+LAUc3TrxSrj0k2yV9GkV
         jWmov+wPBVRJMz8kiR+UW4vjQ7mPPDo1guM8ocs1bsdPktsmmqopVoA/zGGzB8OGGwdE
         4Pym08g08J9KbWmek+6h+fWZ4YbzvryiIgVIWb8quovMiqGkOlXb7ggqccjEO1E7E4NI
         21VNt9zujnBA/LVVvvo1ZCn0gGGQ2tAm4MrSW5BbS10+FeZ+nidT5535dNm5KjWBtdxm
         oSbkmn9vygjj4kROzUhjBUEKdkq3ARR4C05M08dDoFimtzFnRX+Qoi18yzdjHw+Ss7Y1
         RXxA==
X-Gm-Message-State: AOJu0YzTmqAl0Z+AUZAnQgEqiEa71BGX7X40LkigoYG/z+x0bhBBMW4G
	p9NC9snTyx3TbTmh4Q8TFaXAkaBXRCkpQknJh03ztao69IHgUH3R74Nvu6/MEunhaPut+CDOjuR
	Qx/BIvOJWxSgV2kC7nUqETqCQgYFBAtxQj37H9gBynK8imeLWVrSROmimtjQ=
X-Gm-Gg: ASbGncu1mXVJQ10okIrpKftmjEuQziKTbBiehb88M/prEbDXkLtMQwPuwy3ayRghWXW
	OlPaa8RUlyxF+AmGwCFdIkR3rESKy/jm8XPuWDflWciHxwU7puTQXxARJpIz4pJB3DsA5dpUPh5
	SA4vtTDHk1wbF1rmXj8rsP+YbRyDQFM8f9erXixff/LH71oC5sJrAVuoal1lpn3ZKFCQMgQveNz
	ufQYUAYpnUUUyPfXxxSCrZ12433QCvK3IuAi/ozqAi+BrbEDZPR07VMigtEPLmpn41XbFRTPdLW
	mSTxXD5rmP2FOvipqzoKKkrSx9Kqd0w2Fi/6VrQLwx+xf7YMrMPPEa8au6CZTYFmAJVfS2FsKWM
	3XVG9v8AUyc8RWwCt0Zos++Jrp3MR/GVNA3xdgtY6GR6RBQ==
X-Received: by 2002:ac8:57d0:0:b0:4ed:635c:17dc with SMTP id d75a77b69052e-4eddbccc00amr49732851cf.8.1762978159816;
        Wed, 12 Nov 2025 12:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrHRtoWUnalhKkU81sz2ukv2YLjrxVdyeykwnN+OFwK5SIwxIrrc30MD3x4HLaRYsG8yBL2A==
X-Received: by 2002:ac8:57d0:0:b0:4ed:635c:17dc with SMTP id d75a77b69052e-4eddbccc00amr49732511cf.8.1762978159467;
        Wed, 12 Nov 2025 12:09:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba8561sm97073816d6.61.2025.11.12.12.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:09:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <28109443-4bee-4ec8-b7d1-599ce1464da6@redhat.com>
Date: Wed, 12 Nov 2025 15:09:17 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/22] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A bug was detected with the following steps:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 9 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated
>    # cat test/cpuset.cpus
>    9
>    # echo root > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus
>    9
>    # cat test/cpuset.cpus.partition
>    root
>
> CPU 9 was initially listed in the "isolcpus" boot command line parameter.
> When the partition type is changed from isolated to root, CPU 9 remains
> in what becomes a valid root partition. This violates the rule that
> isolcpus can only be assigned to isolated partitions.
>
> Fix this by adding a housekeeping conflict check during transitions
> between root and isolated partitions.
>
> Fixes: 4a74e418881f ("cgroup/cpuset: Check partition conflict with housekeeping setup")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 96104710a649..6af4d80b53c4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2995,6 +2995,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it

This patch has been merged in somewhat different form.

Cheers,
Longman


