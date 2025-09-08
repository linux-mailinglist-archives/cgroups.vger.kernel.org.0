Return-Path: <cgroups+bounces-9779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15628B487D3
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE2D1B22574
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399F2EFD96;
	Mon,  8 Sep 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgOXjDJw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF02AE97
	for <cgroups@vger.kernel.org>; Mon,  8 Sep 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322508; cv=none; b=tNCAvUy81EdTIaekGz1W+DRSYJs2E2jyjOMSbL8Zj3i5YulBGbHEPELpoVENpRMqzGYN6elHAsOOonH9YV53qONpp3UysjM5cC9IXFetm5T0LXVYFg7zXDPspeEiktTrKTJQCN3nsYeiwvnktzwj+/gXizoBF4uUwNUeqpD3/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322508; c=relaxed/simple;
	bh=p3axqcSjIgpt/G/0E6xuXsP7YLEdi6L+lrwMOhDGpls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKDDi/UPOqmBRfnpWEzdTWPwOP5NYwCnktoWBaRrQi4PN+REIrXS42gprrO50/HQ7TvCNrGwhEd9ls5qu4IprV54TeTO1ZTIcS5WoopgN22HLdFpuUGueFi3FJDjWztuOK6FtxIED2Y4dKpvTbkCyyZ/hguI17hFWXXkZtypr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HgOXjDJw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de6415102so6664805e9.1
        for <cgroups@vger.kernel.org>; Mon, 08 Sep 2025 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757322504; x=1757927304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXAkEc+0hbVrwg0zBjiBl7uCpRmywegXjmBSprSMPqA=;
        b=HgOXjDJwmTc0jGXmEcPxlfACKwwcKHGqBNKQcdISagRZLy/X/SjzHwNekqKKT5puOb
         JEQ+bqGQgdECfbckkg5ZAmX623kd5u8dGbH9wcRa92e17O+OSXS6WjAgJxjxaY0TpmSc
         4ateAliliTpTZdV2QjiB+Mh2AvXVpMOVgTx1AE7V0dCIeSwGUww4cwro/EXOLD00s9C0
         D04EsAq97/z9L7C+KA3v9ZnhzAWg2K3D0CSCZOhLsJguABWVEBhyBSP+zoNAH3tVvmXn
         3HUguXB1XL2IVqJ81BDuYLXdr4/Da7UkCyRFOI5UWHHDA+IzzFGxlA1YOobSHItVTjWl
         XXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322504; x=1757927304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXAkEc+0hbVrwg0zBjiBl7uCpRmywegXjmBSprSMPqA=;
        b=Fy+kYKZL1rFAyOgV49REUUqhjs+KVmp9cBS+UxO1UF3lSffJcepJ4txSElibjUsgVV
         SvgkuD/C6bKwdDylBiHBAVAxeWIrEce8SAWwDDQ/cVOHCfNnXgE159NPG9bHKGVY7crm
         w/NTGvnwnazXAElRDPYm9k2960G6+OUC56rSwv/jn2FkNeTDcsEnZjE0RDMLqriSdwFA
         /FTfNDMV/V4WkVfoy+++LqAmzfCi1jvjBrA7+irBuqlMN4PiVoE372EsoSs/9aeOFCCE
         p2UdjX1Mb+DdxoRypfrzSwqIfqJ5JSTDQiSnr0iFQh9qSv17EfKsy3zIHAW96kF7f8KA
         G6lA==
X-Forwarded-Encrypted: i=1; AJvYcCVbjWno9Tp/8DwuQne5I124A7ErLbAMQYPK0kSJLKBOhvjaentPsDN6p1gscphEYnXRig4m0GbO@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrw/R/8IFNFZQVHWmZYz46WPkkdU0IR72BKRgMp3ycGg2hfCJ
	pqvMw86dCk7hIJ97GfvUDS57mx/GcVI1ADSw3Aw8YSE3HXEuUE24nxGvPM2gmz9uFIY=
X-Gm-Gg: ASbGncvFChHI+MikgO/JSc5Yo/76z24f84l8q/qn7MkvYNDLmi4DXnsdQXNG6z7avJ2
	4/KARHKA5gOsl7G6GMS3OktIzVs4doEPU+o7udaDoSpXIitAlzUDaYXqqLiE+ffsZqS/zVv4Jtp
	Bq/h2TJ5iXMIyskVjYqr9kqhwC1EhDGvCnn43fS5kXKpsHfkY/rKlevvPfaV1xc1H6iDJHPxYet
	PTzZpSoDTCwIDhUM9yRkdxekGFGGysYFy+fz3/wq6XzFEFdyAQyVrAAO3D2TCEvpd4dMjPv+bZ8
	erHjBAxLcZJUlKm4zPaDyMqC28tSAs9QDyL3Pi8lTDPDOa0SqsuOTiD92opy5kMmAyhC+PYRl5o
	V+YoehZKSiQQiIw1umkiSu3upweKhmw==
X-Google-Smtp-Source: AGHT+IGjCdAP8Med5Uz3zM88YDI+0dw+kFhTAhqv2XIHSPraXCW8PtiZpKcSe5HEkCIs8k4Yh+M7Rg==
X-Received: by 2002:a05:600c:3586:b0:45d:d13f:6061 with SMTP id 5b1f17b1804b1-45dddec89e6mr70135545e9.30.1757322504380;
        Mon, 08 Sep 2025 02:08:24 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b8f2d3c88sm300994075e9.19.2025.09.08.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:08:23 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:08:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Peilin Ye <yepeilin@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL6dBivokIeBApj8@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtMrlSDP7M5GZ27@google.com>

On Fri 05-09-25 20:48:46, Peilin Ye wrote:
> On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Tested-by: Peilin Ye <yepeilin@google.com>
> 
> The repro described in [1] no longer triggers locking issues after
> applying this patch and making __bpf_async_init() use __GFP_HIGH
> instead of GFP_ATOMIC:
> 
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>         }
> 
>         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> -       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> +       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);

Why do you need to consume memory reserves? Shouldn't kmalloc_nolock be
used instead here?

>         if (!cb) {
>                 ret = -ENOMEM;
>                 goto out;
> 
> [1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t
> 
> Thanks,
> Peilin Ye

-- 
Michal Hocko
SUSE Labs

