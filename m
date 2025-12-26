Return-Path: <cgroups+bounces-12755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CECDEF03
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 20:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F352130062DE
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C419D081;
	Fri, 26 Dec 2025 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkSIdv8p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1DPIBYP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3B1397
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766777551; cv=none; b=GNlEDjRbAOy9AHvE99ygji/IJuctgcI/RjkwRvXg3ldM31GkmfowmNGiVH5p2/0PW/YhvescX4klCsE1gbu626BB88mGgD4GBEiw/ScKrDudWt/rZRqZDKZ/IGQeTWaGc6YRgDnLZdtWiDOF+5ytP940Zdrf4yYg1fu9Rpaa2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766777551; c=relaxed/simple;
	bh=jS4EkTImd1IJh3YoXH3P2OAG4BDSYQtaA20XlD+QvDo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ldJojRUVQ4UwxlbpDSmabjNPPmTU2aQvb0jJDzS/OHR894d7DkRsRopuQqWiFcSvOuiIt1McnHSz4vEbp/Fr8IvfGfP79LRTyfSu2x+I0OA4XfcKQSabFaqitS6lWQiiZXNsTYo8T4fNaTbwlUxSNn/fClOKtqb+A2itHzjGTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkSIdv8p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1DPIBYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766777549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exrylgbBHUfG9Ezs8wURYm14g4G1+zNQOsDbopt4dSY=;
	b=HkSIdv8psDYeOrf0yHah85u2hYYs07OCBaRHFptsiNfTjzQprqtrF+0mD6+zgiIFjyXhbG
	FScD8I7m973kDXQHq4AmmrHilDFyXibVHobwDzNdCfBW3JZRNR/SGI8BGsMLlnE0fFM7oC
	Y/jkCBxoAeLH92w0x/CNOEoWpnVSaII=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-y6fbcj-rMZ-Nr-C4h9b9hw-1; Fri, 26 Dec 2025 14:32:27 -0500
X-MC-Unique: y6fbcj-rMZ-Nr-C4h9b9hw-1
X-Mimecast-MFC-AGG-ID: y6fbcj-rMZ-Nr-C4h9b9hw_1766777547
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed82af96faso153052451cf.1
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 11:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766777547; x=1767382347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exrylgbBHUfG9Ezs8wURYm14g4G1+zNQOsDbopt4dSY=;
        b=c1DPIBYPTo0xLvU2D5DMcG5fZcZycUTltveAPHEkRAbsRoZ2TWQDw+r7T8UbLlxmmw
         tvN05FBf/hRzV4GKgGMAnCV5ubNCddM8fF2eGqsbdGtU40xNuJjoBVhzgPJA744Uc5o9
         8vEJNvnUAi4DlEdRXn8RtCRO9vInH3BCmWyNcRBQUKmlb7F/VQff1B0ZnadqFcAkOexZ
         IWBW/7eIY1ZL3S+zfAWf3t/x11dUfsgA3xUn+n4gwn1Z+ncasvNe8ao4qmLDvlbcT7d7
         PWK40yM/E223Cn1WOmeenVCjGvjcEzvrSgv5cPPPLsIzdDg35VStmASTVoq1chJQbk76
         iuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766777547; x=1767382347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exrylgbBHUfG9Ezs8wURYm14g4G1+zNQOsDbopt4dSY=;
        b=LmDDxxiABsdAewJKBgUGnmcu9dVLfNK4AbbSMbRJ4XJQCW+GsDJmHvnkfzuzDTSO/m
         yhXKQ3XLKB9tYIl5FByZHNb5HeXEEpvKCSInIhGPB0IgHIE4wx/MxNVyJCQrZjF59jLB
         99C+zoMO5AXwvsnhIqYe1vD+4yI5cUvOAKrU+3JHf6LRP4YRP+jSzPuXZjv070IL8kkA
         HE6e2vJaXdnbwv8NqYy9VVWt7YnyihEVX5mM0h1dHEsi7VF2K0L4kZDMkle589UTEfri
         O0IpzcrfxKovtPlYx5FMfBlvTnOXH2JypDunqv23pOIi4o6EEd0Q5CQpfZhtTliyrlEU
         YemQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjEgf5+UF0sfmHaueiWWu6L9QX4a5YjqtqUSm1U6JBW/rEOh/BZytZfKX00M1kJb8Z3F2ttqF0@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBq3LjvwCjeI3R5r81/Y5pFZIvXB+bttd+6diiCuIIzRow53C
	RRJPSGqBcsfhSdol793kdtwyBx5R190l/ntiLJREjvcUtzp1GOYjSO/G7DtfhrkyCgnLyX9fjfU
	kvG6ZuMgw0dbmPK9cbDQ7m8Ujd/qqjrdoUUTLruwFHcsBgiX9egxgbhHB/3Y=
X-Gm-Gg: AY/fxX60ee+H9WVyrTiRFKR4cAMDBjfp4F0ZI65EQZRX8fcH1Yr5k7O23rNuZM5xCvC
	yrXuyJUq+C9eXGTQxVgjCCjm5/hWOFzLZI5ZB0FHMbgUJr6Vin03kKyXPY+d2JGqe0FTEhkbRCq
	Q2CoC3H3RowiuIh6dSJWfIa0il/Nw3FIiqWYg3akUw+t8PvFMX74EC1N2xTFy1gxI8g/tEQq7s3
	k8ZYKZ09pXauoytQsN0S8rixIiohOgEpHfQZNMXFBAhKvWSSq/bS3WKarxI23I4RqpV6Gc4nQkg
	IB1IAE1uixm3SrAHed+msFaWVxN5M2tvXXv5+R93nB8odCjtf6fg+wnoz1q6PLmNS78te9bYPg3
	rDd+iKn7elXXhQth6R7fihr4MmNZp7DuD+4QrtGZkC2CoJ2CNzUWdpDyg
X-Received: by 2002:ac8:7f92:0:b0:4ee:24e8:c9ae with SMTP id d75a77b69052e-4f4abd80862mr370555411cf.53.1766777547183;
        Fri, 26 Dec 2025 11:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrrgKjEllT+0HCpBK+Top+NtVALAkZu7cvx+lq0ZkwXiENCiRd2VvX3Yv+fGt1maICEZ/q4g==
X-Received: by 2002:ac8:7f92:0:b0:4ee:24e8:c9ae with SMTP id d75a77b69052e-4f4abd80862mr370555061cf.53.1766777546776;
        Fri, 26 Dec 2025 11:32:26 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeff4sm186021866d6.29.2025.12.26.11.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 11:32:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <24a480ec-c7b3-4e0d-9895-f9c2ad88dc47@redhat.com>
Date: Fri, 26 Dec 2025 14:32:23 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gourry@gourry.net, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, chenridong@huaweicloud.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
Content-Language: en-US
In-Reply-To: <20251223212032.665731-1-bingjiao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/23/25 4:19 PM, Bing Jiao wrote:
> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.
>
> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote(). However:
>
>    1. It does not apply this check in demote_folio_list(), which leads
>       to situations where pages are demoted to nodes that are
>       explicitly excluded from the task's cpuset.mems.
>
>    2. It checks only the nodes in the immediate next demotion hierarchy
>       and does not check all allowed demotion targets in can_demote().
>       This can cause pages to never be demoted if the nodes in the next
>       demotion hierarchy are not set in mems_effective.
>
> These bugs break resource isolation provided by cpuset.mems.
> This is visible from userspace because pages can either fail to be
> demoted entirely or are demoted to nodes that are not allowed
> in multi-tier memory systems.
>
> To address these bugs, update cpuset_node_allowed() and
> mem_cgroup_node_allowed() to return effective_mems, allowing directly
> logic-and operation against demotion targets. Also update can_demote()
> and demote_folio_list() accordingly.
>
> Reproduct Bug 1:

"Reproduct" is not an English word. Use either "Reproduce" or 
"Reproduction".

Cheers,
Longman


