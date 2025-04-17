Return-Path: <cgroups+bounces-7624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF218A92B77
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7326F19E4C64
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C41FC7D2;
	Thu, 17 Apr 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPYpoH3/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3111DEFEC
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916705; cv=none; b=bNVUukVAY1VtcG5ySsL3OKePU4jXUDSqGre+ClOPvF8IyjQ4Bdsy6qQyXwOl4h4dYB6foo7auO7ZSs4O5zxVPtoSkPRHEln5vjM0wL8NMOxoFH4JNOTqVpeV7AX9ArHwGziyvpwtpiZWoVE1OCU/TzLY1grRHnjusj57rNVCBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916705; c=relaxed/simple;
	bh=PLx01V7cdk1u+Lc4a0xFbV9oBklfwH8Pp/PXwqEnMGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHYBUQcEiQxB3dVVaZnz1fT+GJS83XcyY3VOXQsaC+GvWqiIhDsPkxzHm7ynsvCIQE8J4GBLlKmbYyFo9o+M+7OebtBQ5YU99Y/bendoBjEwXLBoHdo8GosMpKcF0OwRYXQgOwRFThFIUomzCe8+8B1GclLEqgonhJju5pvhI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPYpoH3/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301302a328bso1217159a91.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744916703; x=1745521503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DA4O88gvqwg6x6i/qwnGjRzTebRQv2bSlpav2YCVo3o=;
        b=ZPYpoH3/Hwy0dsOxV2+6hpwBuefwh2MkEXFGhlDNti+/qhuhPKo36voIEVUglWFUfH
         nI2pAvpVGPhuL5aiEE9Qi1CxpLPnH/cfinPp8kzwKEay6JQ2gcHPoEptsKDIv4jDfm4a
         Sw5cfq9k/lJb5Wi6aYJzLpGhJUzKTlmkyI2jU4jDUQWFX91BO4l+tM8ptxszAEeIgkQc
         sycVxKc8LiJuoTlh9fXj86CIAje2NVbzsM8RHRqSa7gf1O4ZcrPjwn9jNr+nV3VshRnS
         VLdsTgrLVT7N1WHpAu0Yp7jfC7xaU/xHqmLI5Hwb5q6/jhm+xYG8T03scJYtLa4FjvS1
         xF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744916703; x=1745521503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA4O88gvqwg6x6i/qwnGjRzTebRQv2bSlpav2YCVo3o=;
        b=W49pyuS1ESPAiNhgEa/vLlLsRD0SjWAaz79qnIxSNfo6U/NKvf9oaE/UPnOlFoHSYR
         9z6NVdnKyGtplI+CcVocg3jO6J/JwpDgCMUEQvk+Yqf5QY4hmZXx2ZN0kn72YlQmBk/T
         Bsk3gZAvtqK6La//Ur0UwljHrYHBt1MMA4YXCi7zW6y46MnAKnf9ng0pG9bcg36afpNd
         xxmDpTHbEuDdgF+dcmETIqQr9AkAXzJX5lH7ofOVcDjctOShPaVdCcjDdXZzCXx3veG5
         GzxUcNKWBKYQeTpGrMmjpLu+H9+yH+IyT4eQOhFWu1c8/DPcjpGSMr2o30GSHCtZVqYn
         X/7w==
X-Forwarded-Encrypted: i=1; AJvYcCVM9EY2iRczx6U4/jKaBp7DSI79enn+w9i40F5gPsViZxAjUMcUHQmJHXwongyhD9WoWERDQix6@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOggHHiDa+3AhVZPrfFbnHHtnQUmBHcIv005527BVok+EcGTW
	/rbx8kZ5EGLDoNm4P7M0KRF+0EN4dg88j68uQt9jtU9XfZa33aVSQN12Nw==
X-Gm-Gg: ASbGnct3FI5fAdlPQ9wwVCaiDe6yb3tQr6NqXgxIEKtho3ZsmEkwkhqt3CDwONIXTyQ
	N01mk6agRKe/aRUlSAf6oMM+lhznEBwwk88+fVTqLk4weZ+wviS8T1stj6SSkXMtxlRofScf93Y
	uem2uNYVdA7nUCAfHVNoxZpPlBoSfho7HUHcGbZeXeQUV4bFIIJImHmwJBCDcFPPkO1HgiecCFd
	82SKUlxDhPDw7Vw/zZ9OA+IlAprKPvq3r81wwHLyz7QI7PHcIEf864T/5jj6FljOFMlWxNTpbgD
	T3THjJHhZOgLhTF/tz3rQDUAGM50jK+7VSzAf6b+4iohFFyd0Q5Tp5cOquaflhq23hLefgt3
X-Google-Smtp-Source: AGHT+IEYKvS32hcqXc+yL7MrHtAEph4uwjGO0CdSUkAfheqVjU7oxpfaMsuXouztqKjWovGheaw3Xw==
X-Received: by 2002:a17:90b:2703:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-3087bb53257mr194474a91.14.1744916703293;
        Thu, 17 Apr 2025 12:05:03 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6f0c:5f5a:e370:874b? ([2620:10d:c090:500::5:a81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaab922sm211321b3a.133.2025.04.17.12.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 12:05:02 -0700 (PDT)
Message-ID: <337ce68f-5309-4bb2-83ae-cb43268f447d@gmail.com>
Date: Thu, 17 Apr 2025 12:05:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
 <88f07e01-ef0e-4e7d-933a-906c308f6ab4@gmail.com>
 <oi3hgft2kh44ibwa2ep7qn2bzouzldpqd4kfwo55gn37sdvce4@xets5otregme>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <oi3hgft2kh44ibwa2ep7qn2bzouzldpqd4kfwo55gn37sdvce4@xets5otregme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/25 2:26 AM, Michal Koutný wrote:
> On Wed, Apr 16, 2025 at 02:43:57PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
>> Hmmm I checked my initial assumptions. I'm still finding that css's from
>> any subsystem regardless of rstat usage can reach this call to exit.
>> Without the guard there will be undefined behavior.
> 
> At which place is the UB? (I saw that all funnels to css_rstat_flush()
> that does the check but I may have overlooked something in the diffs.)

It would occur on access to the per-cpu rstat pointer during the tree
building in the sequence below.

css_rstat_exit(css)
	css_rstat_flush(css)
		css_rstat_updated_list(css, cpu)
			rstatc = css_rstat_cpu(css, cpu)
				per_cpu_ptr(css->rstat_cpu, cpu)

Since I'm doing the early checks in css_rstat_flush() in the next rev
though, I was thinking of this:

void css_rstat_flush(css)
{
	bool is_cgroup = css_is_cgroup(css);
	
	if (!is_cgroup && !css->ss->css_rstat_flush)
		return;

	...

	for (...) {
		if (is_cgroup)
			/* flush base stats and bpf */
		else
			/* flush via css_rstat_flush */
	}
}

Then we could remove the two conditional guards in css_release_work_fn()
and css_free_rwork_fn(). Thoughts?

Note that I was also thinking of doing the same early check in
css_rstat_updated() since it is exposed as a kfunc and someone could
pass in a non-rstat css other than cgroup::self.

