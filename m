Return-Path: <cgroups+bounces-13219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B8D20B71
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D76305657C
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6F32B9B7;
	Wed, 14 Jan 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T7jfpHM2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41D32BF4C
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413706; cv=none; b=XxGDt/nMEbJ/4qS6C2tMvuVv87pn3diWex4yj/8QUWrknag+9v1PPLi0EN3wZhdjqpiKjTeoXPOUGhnMKMIzVqxnPRWNzT51GyXD81loS3ZKJOqpXYth7/jICXpeX0Cxj4MYuNFjKFGfYx3aoi8BxpW73gp1aCzMuTbsUXVZYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413706; c=relaxed/simple;
	bh=hXNG5pEpVTqHvscPxrJuWlQy8dg7/Iu1hqaBop3+A4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifC8aE612uMYG8FmLyYE4lxodt5gQr9p/6idsGudR82ItgCPnK083F8p2RjFaptYGOG2sDsgvqEokArcBqgg382hBz5QVZSjWlqpYh78MRT4wKz1vk1V54d7Yhk5f5hgbqoCJbWxVzZugvZefNo40T0DHxiN3FrXE+uB5LMAtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T7jfpHM2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501488a12cbso474261cf.3
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768413698; x=1769018498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkRPPvylgU3RO/ngpB1r7zD9/9eUo/J0Roj0tc+hknk=;
        b=T7jfpHM2reMwYX9l0DBfCwlbzcMB25kkyvd1/XZDuinrPWcVbnVFJhSLMAhOAqS3bm
         yaX81j3lEnN7PYjh8Qh5tca7bTfNxOWmvqDKn1S3CWU7uuOVtP6e1eVOtcRuSFdEGI7d
         muO6KJ0s61hIKvJAmfbDK+r/K0hFyaffk3oXYncd+EdxJPbRSVV6iJfglsArDJsvVIXr
         Lga4Pz8uhb/V2iNKwiGLGfDcweEv8Y+gZPMRKE5hOFMI5KMMuIG/PlqqO4XKMkrt8YWV
         bX/zFm6aVFSjR0XViURLcpA5I0thpgT/KhVRRb1mkzG9vKHlvCZYTKONSQiktGiytX6M
         qaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413698; x=1769018498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkRPPvylgU3RO/ngpB1r7zD9/9eUo/J0Roj0tc+hknk=;
        b=kpbWJ78yDT2gfUZJPK7Su3lj7S9VsJii4OowF+yv4bkPM/LLxErUYIC3rZu+61l0Rh
         MFxPa0es0120bKckZD9z5K7qTmjWCSNoOdnnQjTPS3cAdLxgajsJTzgBVAvKNKFmikmJ
         WpwWzvKhz5KOQ6QxvUUYODSzfz16nCrRfCGuQLW36s0dZo7huWD3S3CJIC9Dha0AgMSG
         D/Usf6Do7SvZAQRxGO6mxLXY1e5EFoKTvftQc1jceeXPZoVCnO+iUFV+ZrFv8/E/r262
         ZCNkstT8eZataoPB70hSjZKZ+f1hy8tqFmwsNZfN7N6ncY3faFMIe3mcaMeZlbQBMNz9
         uI5g==
X-Forwarded-Encrypted: i=1; AJvYcCW+D7UcZxeD0OAxXjiWTozxg8uFgy0T38lGLG2sQNVOc5e5Wes18oIseD+ZyOneT/jAGhL83wYW@vger.kernel.org
X-Gm-Message-State: AOJu0YypGqvXCUoPbrHOlSumuUsh9csGtOk3ddKrx1CGb5Q1jk38Cdkc
	oWtmsB19wfj8WbLvIu3s+INHGr3yl7QLuLZFugtMjIODf+JlDSMJSeo549GwaZNMElk=
X-Gm-Gg: AY/fxX7IkATbMtiZFJykClxi97GZxRZQWfT5LMA3baeKEPB7ebV6QVjYac+PCg26fzn
	rr6AcfP98OLsvHzhGfg/NmU1VuVrgxkbcwDcsMPCVsuMGHk1Vla3pNJnmbJT1JNAms9HOEghZeU
	f1GBSA234RiCgir+DqlWl+UrBATv2Bvn24CI64T5uAFrYPKgw92mzYQFm8F6nKn1jKTpk27RqJG
	WS2UpNUYNR4eIu0CBJh+fUMF1b1SrdvOSSFQ9zQnc8Zj6GP9q2XHPtpMiTao0HWyL1mnwBe1FtX
	k51y089hM0iZ4Te+IMmUT1vxBRFVGSCvgUf43U7rL2+fXpanv/3WPgOI9alKwRUcSA4gvNvlKuR
	MNuj8ume4emNXTlKzzzrNH0aSg5lpmzLOokBHlzrWM6AfcFFrQHo/KQV+X5nuOmzATvuvTSXjpR
	etAbXDq8re8xrCS2q78lpd+/N6ojCIwmmSCGQw89YVvFKQ1Sj3H/dMJzvk4BTo8egh79Id37+VK
	78s02cg
X-Received: by 2002:ac8:5884:0:b0:4ff:b2cb:a44c with SMTP id d75a77b69052e-501484b57ecmr48602601cf.83.1768413696746;
        Wed, 14 Jan 2026 10:01:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc0e4sm17336781cf.23.2026.01.14.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:01:35 -0800 (PST)
Date: Wed, 14 Jan 2026 13:00:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cgroup: use nodes_and() output where appropriate
Message-ID: <aWfZ2lkPQWF-gihd@gourry-fedora-PF4VCD3F>
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-4-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114172217.861204-4-ynorov@nvidia.com>

On Wed, Jan 14, 2026 at 12:22:15PM -0500, Yury Norov wrote:
> Now that nodes_and() returns true if the result nodemask is not empty,
> drop useless nodes_intersects() in guarantee_online_mems() and
> nodes_empty() in update_nodemasks_hier(), which both are O(N).
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

This is a nice simplification, thank you!

Reviewed-by: Gregory Price <gourry@gourry.net>


