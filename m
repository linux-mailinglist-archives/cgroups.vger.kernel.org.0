Return-Path: <cgroups+bounces-6188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1250A1380A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 11:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3AF188861A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC991DDC23;
	Thu, 16 Jan 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fINGfEWb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0119539F
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023760; cv=none; b=lmmkhcGFVEiLVuV48RKZCOgeAhdPUb7G072lAqa5lsNpI7Inmo/D5nyZ0Ly29ZHOHwd3hkFaLz0qlbEkIZN6bXGUvlLH01p7HSY+khMUItpabP1JipZA49Ci5vRrXT1n0fGjq5sJlaqsx40ZUoeHxxZl5p8752e8M6otrizgDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023760; c=relaxed/simple;
	bh=KtaHAGgs72a6bb8bdzEMyMAfUbYyZfOfJtpRnXAboTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Z3pyt2y8Xz/SE67s1moA0sS8IwOlHyTqOlRyEfhN43Z63VioWjXG5te61/QJGNzsLkxeyLVcpfSY7xwois3XDAKkTJzkZkPqGQuP2ULdwi3LSnv2CUprHgBpYwZAATMXfME4ICMNHCBeHXj7fkSUNFM5prHCuqo6scWCvHiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fINGfEWb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43624b2d453so6632995e9.2
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737023756; x=1737628556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTN3/zOVfyJz5stuKBZXZjjBt5rXiuVUhKVamLYBo7s=;
        b=fINGfEWbTbIKbFs5AzmnlX3qZW0wfAkeTEDXjvUmCOJAb3unoaXEcrgYIMbW+3KKwJ
         JitZEFm+bHMcB+tgzYIypRZBk2NlKQz76Ny44ALvXSbZZ2sjUeccUESl3kDWtZvfHiLW
         7nfyyz0kW0mLAyzkl4vSLs+iToBG1Wms6JJY06dNh78xGaUfZnrSRszbVMgMdiL562ov
         Jh3dfv4FGnSc3hmM9jjXQiTHs/t9ascBhgDsJsm3Q9LRQNipmZxQ475KbL8Uc79lcwqF
         2eDO45Q4uGgfV+N8XoWkDSqeVPy8+UQPr3gmCRvL2YeajRY6HwFY9RB0eHKbwdW/9ObC
         oi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737023756; x=1737628556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTN3/zOVfyJz5stuKBZXZjjBt5rXiuVUhKVamLYBo7s=;
        b=H0pqk4YRiWx0UqFjrLUFmuGLBR33+yzqHJKH1kLSEB2kuqd8npGPImMwdRT7pTWDeC
         qIJ1Ba5RqzGRVcioTHDjmbPDqZVyMlYAzjXj/sq0mKNrBJ2pgHm78gh4/kuDIO0v3Oe6
         2wZlmRppzglTOTMZ4H7UneZzDGyh3+6sRfiE2tE1Hswf2AtXy/y1bO0NWHdeW13ImD8N
         5rIYZJzFDKEmEktiKuTdZ5yIhu+7AGtfg3KfRyyvBxLh12MMYzpRoTCB6zBodu7HCrKB
         JE13LRcLw/FGU9D6Ljf0n/0rmhjDkbQ+vD1YKKRurulV3KyJASy9ThZGuB0YtVGK/2cI
         xtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKg168KuqnD7mfz4iR3mJJm1dxGel2bApGMca4HoDtpDHoLbEp2illBTsH9hVKYkoOq+o5sjU8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fHefzxYX1uRNTjzw+eX76SB1mQ0uDk6IdoeMVKo6SUDKPAcs
	xM6hHTNsVbwMFCByew1XAz0pQXpICGIAUAfT3EYiQAaNfDOYg3kwp3DLKdBB538=
X-Gm-Gg: ASbGnctAHxZJeiWDe5IFK1LtY2VC+/DQ18areDYVUX5h4FPwDOL7SaDE4GNKUZgV080
	yt3cFNfkD1Sc1JiFOMfPT5kWTnXi5lNWpUjZpBXSmGLgxZuILUEbMLsQYH3DNvxU+GmIVAl26xQ
	iHO/V4hcQn/5SOi0f1YOX6Akv0kVKqGVXpkUegjcYPPJhJ0+Uc4P/57iVTceka9jGRRHp3hQQoj
	Y5MBskbC2C/lQCaQ3+B9KtaTyyB+AOrSpzc9djrqXSKqjySHzUy2zjxih591w4cb7hWJw==
X-Google-Smtp-Source: AGHT+IFF0qPCwHKuilPLeoH9n5OunEvKvEacwmEV2ADrPSDJ97oDK/3bKxaaGAXdKb24hUZ2f8hijQ==
X-Received: by 2002:a05:600c:6b6f:b0:436:e86e:e4ab with SMTP id 5b1f17b1804b1-436e86ee529mr313892425e9.30.1737023756462;
        Thu, 16 Jan 2025 02:35:56 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499558sm55708265e9.8.2025.01.16.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:35:56 -0800 (PST)
Date: Thu, 16 Jan 2025 11:35:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
	cgroups@vger.kernel.org
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
Message-ID: <Z4jhCpFLe_Xgxlnl@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik>
 <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
 <Z4jL_GzJ98S_VYa3@tiehlicka>
 <4b9e0d85-7a75-426a-86fe-faf6107a3692@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9e0d85-7a75-426a-86fe-faf6107a3692@oracle.com>

On Thu 16-01-25 15:34:38, Harshvardhan Jha wrote:
> Hi Michal,
> 
> On 16/01/25 2:36 PM, Michal Hocko wrote:
> > On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> >> Hello Michal
> >> On 16/01/25 1:23 PM, Michal Hocko wrote:
> >>> Hi,
> >>>
> >>> On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> >>>> Hi Harshvardhan,
> >>>>
> >>>> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> >>> It is hard to decypher the output and nail down actual failure. Could
> >>> somebody do a TL;DR summary of the failure, since when it happens, is it
> >>> really v1 specific?
> >> The test ltp_memcg_stat_rss is indeed cgroup v1 specific.
> > What does this test case aims to test?
> >
> This test specifically tests the memory cgroup(memcg) subsystem,
> focusing on the RSS accounting functionality.
> 
> The test verifies how the kernel tracks and reports memory usage within
> cgroups, specifically:
> 
> - The accuracy of RSS accounting in memory cgroups
> - How the kernel updates and maintains the RSS statistics for processes
> within memory cgroups
> - The proper reporting of memory usage through the cgroup interface
> 
> The test typically:
> 
>  1. Creates a memory cgroup
>  2. Allocates various types of memory within it
>  3. Verifies that the reported RSS statistics match the expected values
>  4. Test edge cases like shared pages and memory pressure situations
> 
> I hope I explained it right @Petr?

Thanks. Yes this does clarify the test case. Unfortunatelly this could
be quite tricky to get right, especially on short lived processes. Due
to stats accounting optimizations all the changes to counters might not be
visible right a way. So there is some tuning required and to make it
worse that tuning might just not work with future optimizations.

All that being said, it is a question whether the specific testcases
brings a sufficient value to justify likely false negatives and constant
tuning to existing kenrnel implementation.

If this local imprecision is a problem for real workloads we might need
to provide means to sync up stats (similar to what we have for
/proc/vmstat) and test cases could rely on that rather than trying to
estimate in flight cached stats.
-- 
Michal Hocko
SUSE Labs

