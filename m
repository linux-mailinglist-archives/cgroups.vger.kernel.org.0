Return-Path: <cgroups+bounces-6571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA61A38DF8
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 22:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2573C3A48C3
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672E23958D;
	Mon, 17 Feb 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvbpEmQ8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB45239068
	for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827741; cv=none; b=f6QH9Ohs6HBnfpxOJH052KolJj3d2tPzbOTHavhjw0ypfjV2f1IsGhRKsMCN4gQ7Uxrgn0VqR03STceaLyEko5Q/w2JMDB7gO6Ai3yMM1RNBpyBWna4xYCbStw2gGsYUYQBUOtWKo6Ewg5nfLtfHxC9pm61ZvTkQYknkiK3RrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827741; c=relaxed/simple;
	bh=QtKyl08g8BnbaK9peAQyWqZuLQDnDswA9FYAXJMqPrk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u8NSV1wgH88C9mAUguzGWJ+dR5KeBapIuekJKEXAVRYrZYqusvnhOMUIpoO+KFYC193X7LNYN1JNeBJ4AOsX6v1Cd9vj95M0zsZNWpd6zc7p+bsmywiRXUdx5m+K4XDgVw+6sdZ7/2DEzJuCU1qgBmUFvG9ZzdVjfRhga9SYVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvbpEmQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739827738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRPNL2JvEqbDKfhkAqEwBHvR/TzRoQvQNFnzm4XpF+I=;
	b=bvbpEmQ8CABsEtQ4ZP3/p9N9SWAiu3ynLVyXxruupRg2FrrUhxafeRxk9s/9lpXbOkjApl
	2jpNsfhF+SmB73V4kt4YiSuYhG37SsqbBgpH6B6LPC5mL/SuF93XmuU17G8MhujujKfSh6
	LhxYegVSQaGk0h6kDMxYgGNl1wKVNPI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-4M7OMcyRNFygdbv3N0Dsbg-1; Mon, 17 Feb 2025 16:28:56 -0500
X-MC-Unique: 4M7OMcyRNFygdbv3N0Dsbg-1
X-Mimecast-MFC-AGG-ID: 4M7OMcyRNFygdbv3N0Dsbg_1739827736
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c096d86f44so248292485a.0
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 13:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827736; x=1740432536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRPNL2JvEqbDKfhkAqEwBHvR/TzRoQvQNFnzm4XpF+I=;
        b=sZjpzQfgjBsf0oO20l96RjQJ8fUdYQlrTwAU1PaseaeVR6eW6CNRDJ7Fyi69AvGcTH
         X6HPhmAtHd8rVh1uAZqOXb0TSOOIgiraO883k5KWF8g8MtmdxtlluB++NHQst2+T3lsY
         mYolee8tp8r9rEPaiixo0SNWjoc/QFlEsdqBIzDBb0BshExQaxoz31ByBicuYxF4syhu
         gQ+9wPk/Ozu1292oNv1asm2vxAXOZBEcg9dFzsVmE8mtFfij7NNC0V6XWJmGT6EDffFb
         4GdeF7qyP5Jr2kyPPgwxpRTktaunlaT3WStTowzgWjJ7zmtMY8WC9b93dYOg+FvdqnPo
         cNPA==
X-Forwarded-Encrypted: i=1; AJvYcCWJrK42+hbAP94lWqJgVNbxhJFHiIxpnnFcLN5VBDcGeqiFPa0dwX0y2NGKlOfdPo8N1BLW5LfS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45KZBUmjG7zdvaliA7T/BMSA7QO9b9IOQN0FvPpfJkpGQ3aNP
	gY8ue2kvCazqSHyo6zKjoinXy2db5wjN3ad4gkrieGkS3OCxIYDpLEC1NBOSADYu1rIUTsPJX5I
	XR3pfvwvYj1Upmu5aY2HY5houC57Llw1V6I6rWenulreY/+8tq3Vjy10=
X-Gm-Gg: ASbGnctUYsJubQx+olYkQePws2oXJgVGI6cz/s5IOqm1mwsf8qVq57qL8XNHM4FoDLA
	ftNlqneBSEw/Hqj6mbYk2Dh8qX26EkKKj5/JeNLm8lgbdIVuSdxbbDlkO93RAaF2KZpkxCFg68q
	oVRZLhlB3n9lGOizRg0JmQ9gGQyC5zeMgeuhmZ17MEQdh+Q+FIH6kwGQL6dZXWiKeqB7OgbGTMc
	tUI9shbGy4M8k/G80m6JRsav8I19fRlbLEJXgN93V/y3Shg2ZvJCTE+1On6MPKXacHC1NgHpnAT
	4ZuARmbvNuKDLHHD6gP8MhYSkOlB/dGYKSkdV7lca2f931Ne
X-Received: by 2002:a05:620a:4410:b0:7c0:7fe2:876f with SMTP id af79cd13be357-7c08a890278mr1362195285a.0.1739827735904;
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi/jts7+uZJ/1+kCDGDpjV3iqqy1fQ1AX0PcIJtSBYvw+d9gZ58RWXBqgfZ4eZmxAKm/RIPw==
X-Received: by 2002:a05:620a:4410:b0:7c0:7fe2:876f with SMTP id af79cd13be357-7c08a890278mr1362193585a.0.1739827735627;
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f36d2sm579580985a.14.2025.02.17.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3722eb57-1108-46e5-908b-66dd7ac0126b@redhat.com>
Date: Mon, 17 Feb 2025 16:28:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250217071500.1947773-1-guojie.jin@gmail.com>
Content-Language: en-US
In-Reply-To: <20250217071500.1947773-1-guojie.jin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/25 2:15 AM, Jin Guojie wrote:
> When running LTP's cpuset_memory_pressure program, an error can be
> reproduced by the following steps:
>
> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> then set cpuset_memory_pressure to 1
> (2) In this cgroup, create a process to allocate a large amount of
> memory and generate pressure counts
> (3) Set cpuset_memory_pressure to 0
> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> kernel returns a value of 1, so LTP determines it as FAIL
>
> In the current kernel, the variable cpuset_memory_pressure_enabled is
> not actually used。

That statement is not true. cpuset_memory_pressure_enabled is used to 
determine if __cpuset_memory_pressure_bump() should be called in 
cpuset_memory_pressure_bump().

>
> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>

What Michal suggested is the approach you used in v2, but it has problem 
as I mentioned previously.

Other than that,

Acked-by: Waiman Long <longman@redhat.com>

> Suggested-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..14564e91e2b3 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>   	fmeter_update(fmp);
>   	val = fmp->val;
>   	spin_unlock(&fmp->lock);
> -	return val;
> +	return cpuset_memory_pressure_enabled ? val : 0;
>   }
>   
>   /*


