Return-Path: <cgroups+bounces-10361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D13B93637
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67572A3153
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853A2F6587;
	Mon, 22 Sep 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV9zDDn4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460513128C4
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577024; cv=none; b=CJxJx9cn0CQUSF5qCn+cg8oT0b0DoKd9mv79P3fnleGHbn0zWonHySV3wL3kTXNqvaN/wN7e88DD0vOzIBKF5OeeCJmGb6P065xQFDQaFjTn21sY2W+lhDO6Ipgs+XMdsJiHhpeRGoDEvNYsqhVvAPDjz6j4lzAQ7YbawilGhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577024; c=relaxed/simple;
	bh=hSsaEQb4VAWVoscZOLW+eqrIRXRtuWgYlZ0Q2Mmdsjs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lK9VHhBAYf+GjGDQFMbCTI1gXME0f6f09gpaKrckafuoQrg1WdYt8Pvj4gN2xXQ111j4kRKVD8jEOOXNGVKBhqkCXCwozCR8NGOrcLORlFwdTIWYRoS7BtFmrZdszY2ExNSkP7DWvz+1W/9fHDL6gLqekeD15EcAAW+dFBHbxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZV9zDDn4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQg+VY8gn4Rmq+YGMtXx2+Qb8qCVcANWfi/lFd5PqbE=;
	b=ZV9zDDn4t4a+PlZWQHr5cniTXYkhXplyRC2tubhb8CFsl/WunnP93yHYWHXodsZzOLzFKg
	1P9ojLzTdoIfTnGdSPhX0SlKfq4/8W9HRlALlMgsVaKQo4D3FWysNsjaHCjTdq1cmCHLo5
	JnjoYw1h8tCtdN1vL4KEq7UL6YSaHN8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-fz_jFznrMSuFV_SPYJZbuQ-1; Mon, 22 Sep 2025 17:36:59 -0400
X-MC-Unique: fz_jFznrMSuFV_SPYJZbuQ-1
X-Mimecast-MFC-AGG-ID: fz_jFznrMSuFV_SPYJZbuQ_1758577019
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e30eaca8eso38906556d6.2
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 14:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577019; x=1759181819;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQg+VY8gn4Rmq+YGMtXx2+Qb8qCVcANWfi/lFd5PqbE=;
        b=W+RPQEWAhgkeCS982NI5/80tSycsxAGzL9TdDuMiuPSfW1tS1pHG8lo+WF9Wz60L0V
         0EHpFsFECLXJoY4i5rlda0iH9BPVsGH0rlwHJnVKq8uynwxyITVyYF381OhIHkH/T/I2
         Wc9KlPkXC3Z/5T3pomnGA+pHItOzgFdWqxxa43gHQ+UrlVgOL3Yh9Kn13R8YY/ufVDyA
         y1jru3yAtAuNsODbp5hZB67jfHq/jyJW3YIWYuDJB5Nbdl7rFNdihKNQpBQ4VPYW/5Oy
         zWrULn9d3/q/alSENxpdIumU1gR+vPn6BDn8PSZ32ZASYFVZtCAEsmaFT5zlNk456xio
         HXVw==
X-Gm-Message-State: AOJu0YwtMgypRAdfvG4Q/lahfLZwqexpwQCRka6Qk+kIoAbqyJss2toM
	L7RX7E9Ckb5RmTQQP4s4fogVyOa3CDhwwqBS6tDePoRNP0Hb6FeWGEw4avPF0LwYBOEgOZ9stjo
	MPWAMdb33sX3Fy0arnu7dEHqCb6Snjy15gy89TlsVGUkGNs9n0axBdD77CmY=
X-Gm-Gg: ASbGncv+imT9lpR5zguF1YCAaeuZFoAuUZXYelmZWxXb4D2JKuQvsfpTnupj+3eGLki
	05pwKbBTNX0sUcTDOnSQ+CnB30kuvU2ahZIfNqmcvv03k5v2mYBtWCwT3MUNc1ff8HGuB5zodOR
	J1JS9Dwa8xjdlFJBrGuDX9fZPtuzcyuYu+9Y7j7IKQb5AFfaky0/rvVpk0pxk4vQS4/ZuGKYAqm
	WlhimjVy+mh6zNyWp4x69Hp1HZW2zuBiUjvTHTcye+HUXClvVsug9mhfxPlwbWoE6R2bnl1SsdY
	P5GdHWsnmOSbiFVQjabTAKVb3RC1p/sfWaUEgt+6K79MrnO/NqHKlTlSDdNoTCNbA6cvsTLRe1Z
	bnT/7u4p5zHg=
X-Received: by 2002:a05:6214:2241:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-7e703820172mr5614446d6.23.1758577019316;
        Mon, 22 Sep 2025 14:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHomM5uVrLRgfcL17MuNwl5LJ5DpctEKMKOIq90FQWbjUTIIF5r0eVSR150tzN+X5Hj6GV5zA==
X-Received: by 2002:a05:6214:2241:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-7e703820172mr5614106d6.23.1758577018792;
        Mon, 22 Sep 2025 14:36:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793474ac8dasm78515486d6.30.2025.09.22.14.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:36:58 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3108a41d-24b2-4a0d-bc71-3e62ff97054b@redhat.com>
Date: Mon, 22 Sep 2025 17:36:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cpuset: remove redundant special case for null
 input in node mask update
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The nodelist_parse function already handles empty nodemask input
> appropriately, making it unnecessary to handle this case separately
> during the node mask update process.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 535174ed7126..20dface3c3e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2847,22 +2847,16 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   
>   	/*
>   	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
> -	 * Since nodelist_parse() fails on an empty mask, we special case
> -	 * that parsing.  The validate_change() call ensures that cpusets
> -	 * with tasks have memory.
> +	 * The validate_change() call ensures that cpusets with tasks have memory.
>   	 */
> -	if (!*buf) {
> -		nodes_clear(trialcs->mems_allowed);
> -	} else {
> -		retval = nodelist_parse(buf, trialcs->mems_allowed);
> -		if (retval < 0)
> -			goto done;
> +	retval = nodelist_parse(buf, trialcs->mems_allowed);
> +	if (retval < 0)
> +		goto done;
>   
> -		if (!nodes_subset(trialcs->mems_allowed,
> -				  top_cpuset.mems_allowed)) {
> -			retval = -EINVAL;
> -			goto done;
> -		}
> +	if (!nodes_subset(trialcs->mems_allowed,
> +			  top_cpuset.mems_allowed)) {
> +		retval = -EINVAL;
> +		goto done;
>   	}
>   
>   	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {

Right, the *buf check is no longer need with the current version fof 
nodelist_parse().

Reveiwed-by: Waiman Long <longman@redhat.com>


