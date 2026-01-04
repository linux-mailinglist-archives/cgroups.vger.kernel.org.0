Return-Path: <cgroups+bounces-12889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D595CF0C6D
	for <lists+cgroups@lfdr.de>; Sun, 04 Jan 2026 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3590C3009F07
	for <lists+cgroups@lfdr.de>; Sun,  4 Jan 2026 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CFD248F47;
	Sun,  4 Jan 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phjW9tbY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F434C98
	for <cgroups@vger.kernel.org>; Sun,  4 Jan 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767517465; cv=none; b=Tb2H2tqiU/Ylm2p83oB7q4R5YS6l1MqVPtV327esrs7rbzZEuAALMdviThOWbX5F2dtq+9ABEcIU/PTm+cY08F7soAF6s9SepIqvAP8Oewph0bt45dRZtNIa0TOuAj0wFRNcKBrU/wrBl4mZLfBARKfrZc/P9UVbZVuFaRcat7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767517465; c=relaxed/simple;
	bh=QSOiATV59Jt7zF0mcNusY/T1zTDz582l3BXZAoUYnUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljW7nNx0wgkjoXxuHQu+zw8o83eoJU37fB5SeZthgkJ1E+16LYHQimewBEMu1FFYxO6WYZM3jm2SFvbAPnlUWx9FIiqcznP/jZast1YDsaZaPuE6xTW/zLZD+DdBk0A59/pwxo0m+wrcr8Lp4srKzE24rPU4K+KtjVh2TgGSdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phjW9tbY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a35ae38bdfso91235ad.1
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767517463; x=1768122263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSOiATV59Jt7zF0mcNusY/T1zTDz582l3BXZAoUYnUk=;
        b=phjW9tbYadSKf1Lzs4m08kwD+zVofwZCBt8+dMH8BBXm0OpSMCJ4eCKfBbodS+M62w
         0IblGitRNFhqPcDy5Fa7ULOttD11JUa69k5haDBPjt1fjk9Afh3F4MIoye5D5wD3+Q1G
         flyK6RiGJ8bUwMxQoUIOHyCNeW/Qafo/KFvhD/v61OCUnUqgDbdHrbWxFC7nLT2SL2J0
         vIaDo4Ixm6fBEeO7xJSoCSFOUAavFMsADC/eUr4fUgPguRjGOQXXRIKzGlcgOi/MnDHG
         8G4TnJLlPxnOM/TB6ygSTZjDEsxHvt799qbTS+EiXTVaemAoRF6xvd2E8ivtTvYEFW4e
         2L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767517463; x=1768122263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSOiATV59Jt7zF0mcNusY/T1zTDz582l3BXZAoUYnUk=;
        b=A0ENgfWNFgwxISSaoaubdA3drjJlP1Ibtwy7tiRRlCZ+CqcPJKcQe75kwfOLEv+nbM
         bke+oKfPReYnOZQVK0FTDg5fati8H5Fy47F7Ieha9YV+oPBAJa8F92UV47UjAMHJS2g4
         bqYt7TffXs1VZqSNUWcHiVkd05TdJP1kBC4Io3GyVbNEcKHYAwiRik+c7J5F+2fKD/J/
         /hYdWshqm9DIgkXcUdiHsfbazP5bjSLTF5i3CUkLsBJd0jeuqOnGI5Ure1z5TwC29nD+
         iw/w8d3KSqT3+QFYIQm1z+Xi6rXH16fYLDF9YfwZI1USwTF02jGow1xYLK5jXSpiMfG4
         LVvg==
X-Forwarded-Encrypted: i=1; AJvYcCWFnk4Wh98jhWO2qRnV5Z2UPxGPqt4zO4iyXJ/bReE8D7iC+uXporNYps0vFpe20xqi2f9Hu4Xx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpcd3DvguCRxyhL86f0ZBc++DsdDlEXlwVvfpgUDL/dxUQgDWn
	4wODY4ftWsCb1b8IZgxf7qQQYEMy8n0VUqe/PrxIY3Zts3OJkHsOC2HRUJY82KLCpw==
X-Gm-Gg: AY/fxX437LpzmHLSgu+V0LZOLOWeBO4T3rLFj5RvcsHkIb6HrPnehqUMKNLo2+X5b2v
	LRrydQMe0u0Ofm6uQsLx1c/FuxZcvn7/07BQ9/PfnA8p5AXdDlhZnpZ9uK+LvHmkNijVBG9smk4
	09zqeMvWWDaBqfCbKrs12p68C9rc/p76NcrhNIDm6z7zHOy6yUNAJrZSFhjZicxlvXWHppixyNh
	Kj6DEXzzBch+wn1rwGzAjreXx3O2swxUeHDewplgxdezZk1g3JCKEWTFFr05U4TD/pa+rzIYa7c
	o1dYRdkS3q/Yb1+jSUhbR1EnD0TGovmJgjg0zNhZR8FQn9ugmf6D0LAdG0kM0c293BXApGnHWK5
	yCLRhUN5Q1Pp/LRDsnB0oBE+lkuCkr17cK4Gn0Txak7etV73LaNb3WjjZAT/jnGhnWwWxIoU5Ts
	qZSJkitZJyKKqrvZgoKFUonWCr9ZwQI7ep+m0WtCOIlEzmSsHJsG1Ln4Av34TLLDc=
X-Google-Smtp-Source: AGHT+IF2f+qqRGbSWLY+axONWjGzW67AvjyMri7/vyDsrV41RpaLChtAfH7ihOiJuNWMSfi+MREU5Q==
X-Received: by 2002:a17:902:ebc4:b0:295:1351:f63e with SMTP id d9443c01a7336-2a3c1c1615dmr1696435ad.10.1767517462607;
        Sun, 04 Jan 2026 01:04:22 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5dea1sm411421835ad.81.2026.01.04.01.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 01:04:22 -0800 (PST)
Date: Sun, 4 Jan 2026 09:04:16 +0000
From: Bing Jiao <bingjiao@google.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, gourry@gourry.net, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVotEFFHwTPF_K1h@google.com>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
 <84ed9b5d-41d5-44a1-a1ad-2b3de8b50a50@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ed9b5d-41d5-44a1-a1ad-2b3de8b50a50@redhat.com>

On Fri, Dec 26, 2025 at 03:24:29PM -0500, Waiman Long wrote:
> The nodemask_t type can be large depending on the setting of
> CONFIG_NODES_SHIFT. Passing a large data structure on stack may not be a
> good idea. You can return a pointer to nodemask_t instead. In that case, you
> will have a add a "const" qualifier to the return type to make sure that the
> node mask won't get accidentally modified. Alternatively, you can pass a
> nodemask_t pointer as an output parameter and copy out the nodemask_t data.
>
> The name "cpuset_node_get_allowed" doesn't fit the cpuset naming convention.
> There is a "cpuset_mems_allowed(struct task_struct *)" to return
> "mems_allowed" of a task. This new helper is for returning the mems_allowed
> defined in the cpuset. Perhaps we could just use
> "cpuset_nodes_allowed(struct cgroup *)".
>
> Cheers,
> Longman

Thank you for the explanation and suggestion.

I have updated v4, which updates the functions to filter out nodes
rather than returning mems_allowed. In v3, the caller need to declare
a temp nodemask_t to store mems_allowed and then intersect with
lower-tier nodemask, which is unnecessarily increase the stack size.

The function name is updated as "cpuset_nodes_filter_allowed".
Do you think it is still better to use "cpuset_nodes_allowed"
when doing the filtering thing?

Thanks,
Bing


