Return-Path: <cgroups+bounces-4094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D6947FC9
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8681C20E91
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508415CD79;
	Mon,  5 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Kx8OYBrv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B42C684
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877182; cv=none; b=eOwy+5zwwmxrZWrAdY31aTB7fB/nrEltKkPNVtGmMowoD4lA7wFAvinbW5MmHrZpEbDNXGpx2Sy6NKGljkJSrFWh5b+VK913kC6IRhO8zye+GgLmHfGT+IEzi3zYNJ20YYDAFJluUSC8IjmMJQmDelWUF+rEKEvcvyySLIriKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877182; c=relaxed/simple;
	bh=jzSHPWgtcFGK0Tt/clWdJLEFG4a0MsPE8k3d/lXoqFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdKTOYG5bdpdDxFbyUs9CrUBITLsbz0XYH4dl2WunMCUlk254buk4CKQhbFv3ms0RGxkxsbxiAcMlvo24ySDLF4UxNnHqRgmKTaCmJmgdnk4CaS87FlEmZVyGMohWFRafhb2JpfCBg39XOL81WyaP0dldJhIX9czXyQcevtalX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Kx8OYBrv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70945a007f0so5644896a34.2
        for <cgroups@vger.kernel.org>; Mon, 05 Aug 2024 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722877178; x=1723481978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sY3wVahkeTjr7y3XzuhW2Q3UgOPrPRQ13FjqmX75pg=;
        b=Kx8OYBrvBRcbBGJmfITCv0zwdFpgbtXOKn6ebMB/QEIIU2c7XZ8bXjN8lDwqkZTZsa
         15sJAavygR0IE0T+h/ge7QOtTElAizY9W7w/KtVm7Axw3YyAxUjVQtJUu2neME2nsrrN
         JVIGfOLeLnyPYBSjWCnBEGK9vNyqY10RmPlxiUlNiDGKVZu+PUxIb8F5k2HgeMNqwK6A
         kdBgfkqQ19WldppM7rvPgdJQU/YiVrYoy0tgsi5rmnnSd92HIXj82KyJnpYKGEoUUMfz
         1a8fKoWs1rpno1EzMXSQY11O8p2G/iPm7KlDOliCDewGPUVCUoLhNxg5SuMH4Cb/Iwph
         F+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877178; x=1723481978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sY3wVahkeTjr7y3XzuhW2Q3UgOPrPRQ13FjqmX75pg=;
        b=vGTpfS4mPQz373VKIJbWMFPAkOoGkR4u6M20FD8g8A1NFjnby+pyAJoPeYJjMq5pjs
         Ko/+kS1sdoJ17561EM+Pz3WQS6juj7pJuCGG8oCqGpehDq7gxHdCChjMeSmj/Wgw4qVP
         lmLy5e+8p2ec6UKRYAnfFOfknTCFV+2fuvCRdoFLfgapk5OoqVEDTIPfOk5p3uzBgxnH
         2eHW8DjKZb1EhO8tWzvm4LDvEpa9MJaodng3WhyfzUfS8MGbbeQaMspj2wt3VGB+RD8l
         nJ5pOLuBotRofXA39HCwNZWs5iZhtNIA+sH0t7mw42NT+Ot0X3t2k6nW+QWMGF/DplK2
         h/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCvFuq1ECPixqpQazJIxvJCOZI6nfFMcY0a92h/4BMDszlu3+0D+UWpQxZIZeWcB47Ng0RTYx+fo1zB4EoYCv9lg9+hMpU/g==
X-Gm-Message-State: AOJu0YxdTw50fsognZZsayPnV9nzm4XWH08hmkJWKionZJr1gqABTEZd
	w96kbxkgpFsyBsCL8xKSHR5W9VFR/rauelHUkyQMagOSd+coKt/Rddj2MBD76XE=
X-Google-Smtp-Source: AGHT+IFMxRsrpmwDYJ+JtzAr+Cs0xEeI2ll7tUvkgy3WI1DpJ38nhDEPZEy+gLiEAOohp95KGIz6Gg==
X-Received: by 2002:a05:6830:b85:b0:709:4c6a:b98a with SMTP id 46e09a7af769-709b996d713mr14582748a34.30.1722877178571;
        Mon, 05 Aug 2024 09:59:38 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f78b7a5sm368699085a.122.2024.08.05.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:59:38 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:59:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <20240805165937.GA322282@cmpxchg.org>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802235822.1830976-1-shakeel.butt@linux.dev>

On Fri, Aug 02, 2024 at 04:58:22PM -0700, Shakeel Butt wrote:
> The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
> after many small jobs") decoupled the memcg IDs from the CSS ID space to
> fix the cgroup creation failures. It introduced IDR to maintain the
> memcg ID space. The IDR depends on external synchronization mechanisms
> for modifications. For the mem_cgroup_idr, the idr_alloc() and
> idr_replace() happen within css callback and thus are protected through
> cgroup_mutex from concurrent modifications. However idr_remove() for
> mem_cgroup_idr was not protected against concurrency and can be run
> concurrently for different memcgs when they hit their refcnt to zero.
> Fix that.
> 
> We have been seeing list_lru based kernel crashes at a low frequency in
> our fleet for a long time. These crashes were in different part of
> list_lru code including list_lru_add(), list_lru_del() and reparenting
> code. Upon further inspection, it looked like for a given object (dentry
> and inode), the super_block's list_lru didn't have list_lru_one for the
> memcg of that object. The initial suspicions were either the object is
> not allocated through kmem_cache_alloc_lru() or somehow
> memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
> returned success. No evidence were found for these cases.
> 
> Looking more deeper, we started seeing situations where valid memcg's id
> is not present in mem_cgroup_idr and in some cases multiple valid memcgs
> have same id and mem_cgroup_idr is pointing to one of them. So, the most
> reasonable explanation is that these situations can happen due to race
> between multiple idr_remove() calls or race between
> idr_alloc()/idr_replace() and idr_remove(). These races are causing
> multiple memcgs to acquire the same ID and then offlining of one of them
> would cleanup list_lrus on the system for all of them. Later access from
> other memcgs to the list_lru cause crashes due to missing list_lru_one.
> 
> Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Great catch. This has been busted for ages, but the race is so
unlikely that it stayed low profile.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It probably should be Cc: stable as well.

