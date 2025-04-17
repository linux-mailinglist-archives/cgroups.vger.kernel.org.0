Return-Path: <cgroups+bounces-7613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73EA9202C
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109185A15E4
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0D2528E8;
	Thu, 17 Apr 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="qWI2p/4d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEB2517A4
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901323; cv=none; b=Z39gyRCyKFUriAH6RlnrBuwkLU1FEipEFc0dixeEUHY8R77go1iVtnV0Atm+P5yma6n8fd3Q9dUA/iaIitwE9EC7/4+w4HDE97OkcvxOp8N+9upcVhXN9nWjqqHlhEGrYD/agBBkFNPaLk5YtXPsjfzLQ6NlmRYrDUPmbmi8sps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901323; c=relaxed/simple;
	bh=pNcBMs7ZlrUB8XX3Hza9aW8YwzWbd47vRBseMGVQzkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STKDDxnSKKG9IrGfxBr9+wHoNtSDnFdfseZeYT2dZNMgkKaKJSl4yp1PZKNIIfCYzys8G/ci1cGtmqIYEeb8nOwdNcBPsNHm9yxuKA2EC4zpYJeXhf/YaL4Zs4mQN0+wnyH/HCB6Vdm/HqgGf8T0hZAeOFCvpeMPjkrFcSp4XVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=qWI2p/4d; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fce04655so7990716d6.3
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901320; x=1745506120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72y1EmznVSmoY7TT1dLdPEUbLZhpUALLN+CNBenUUDE=;
        b=qWI2p/4dGO9N7gJ60X+1Qzens5N5nqExaoZZ95ERHV6OzaE4DUfZKD5bsU0l0+FIWT
         PIaJIOOcuCj3uF8cMFxMb9L1Ylnl81Me7BjNAf1lO62pFZ9dXtf0locwGrNUZKmeQgic
         DtYDIg+2VZQk1IztLVQprAadY7ZoOZDGfhXKiD7utogtUApKZfQjCgDkTlfYdOb0zhKg
         +PyBjXEQLdladYfD0MuayctK39isfBv8/NT+2NgA7HEKs6rkpvJbATEYUl09QzGY7keJ
         MRFkTKzaj0jKUv50wA7FWjX9rNq1PZnkggqcKzJunIbDCEBVjoNwlM5dZfvdmD/zbRsk
         5bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901320; x=1745506120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72y1EmznVSmoY7TT1dLdPEUbLZhpUALLN+CNBenUUDE=;
        b=JlEDkUZqDy3hAcNkw+mAKBJ8uv51W7b0QvFirmEkhy0wpedcjov54Y4rnxj+XSIwQL
         Geuq/WRbSv6k91TNkkyMKaKXfPA7blmp9hOlFv5eFf7dP1sP4eLwW9Zw2XHW1J+wnJN5
         ur27VdIM2OsIWNFK+neeZtOd/kWiXbr3KPPx17qYcjyQfZofOeN5ebcy5CI+bG70cxt8
         gAJVR4/XHlhLG2OnfVAMd3F/uQfATk3eQXdIQIuQ1wnKNc41MBIZo4kkEx4Ru8gmdZEu
         9F96rgpIn45QLPHLBo1o+Q/8/v0DRXI4oAf/Va/2wE/nRx4GrJr5HWf6vEko/4ZLGeCK
         G4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4IQhFLA3+RLIftLTHIYItSswrhw24za2veV452zafu7+SnK8DnHqvYU6fHlFEe5wKgig+zluN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3cdBnOZU4TW1u0vry3iTNrZvaIbLNyqiGN8fQlEjVqgSK6Ak
	Ot0mD6dYBRTUl3/jyBWF+JbccO/F2DvVLrFF6Vr2/gGJ4u/HbgqTL9zlYS1oTHg=
X-Gm-Gg: ASbGnctEKaS/uLS0zddERGbMWwJj2TvyJ0I/W7hjzOI4Wcr+u7/4M/ZzIvE4KS9f5Db
	JcGTLXZmxjX4bOc8vtkrEqMXqUpWW3XpCAM5BLq5jNi/auF3aCfDAzSYDZ7W7FbGljAIWe8njEj
	bldJglBv4v0YpCj2WGiPg3sycquVRceM0qTxN3lfmyq6TIGJtVXpM+9hCipTefJYn1Jan5PnV32
	v20o/xkCqq1IY0+MaqZdHenG2QLjCSHiTVRTmBxFOuVcjUVXGNhEHtJI7/2h0Q4vd4E3Bq7xpXc
	8P1xaOnZtAIcF4CkzZlTgpMFBT1nCLXjZKOYa6M=
X-Google-Smtp-Source: AGHT+IGDYG8scGbGiGtdjWD5Tl+oF+abCIBc/cfLvyS8vBIxcfDBykRawx8ajQXIXSc3ZbLJsuLZ1g==
X-Received: by 2002:a0c:c589:0:b0:6f2:c181:19db with SMTP id 6a1803df08f44-6f2c1811d13mr8653966d6.43.1744901319739;
        Thu, 17 Apr 2025 07:48:39 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2a4b60a2fsm38477396d6.120.2025.04.17.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:48:39 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:48:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 02/28] mm: memcontrol: use folio_memcg_charged() to
 avoid potential rcu lock holding
Message-ID: <20250417144835.GE780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-3-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-3-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:06AM +0800, Muchun Song wrote:
> If a folio isn't charged to the memory cgroup, holding an rcu read lock
> is needless. Users only want to know its charge status, so use
> folio_memcg_charged() here.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 61488e45cab2..0fc76d50bc23 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -797,20 +797,17 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
>  			     int val)
>  {
> -	struct mem_cgroup *memcg;
>  	pg_data_t *pgdat = folio_pgdat(folio);
>  	struct lruvec *lruvec;
>  
> -	rcu_read_lock();
> -	memcg = folio_memcg(folio);
> -	/* Untracked pages have no memcg, no lruvec. Update only the node */
> -	if (!memcg) {
> -		rcu_read_unlock();
> +	if (!folio_memcg_charged(folio)) {
> +		/* Untracked pages have no memcg, no lruvec. Update only the node */
>  		__mod_node_page_state(pgdat, idx, val);
>  		return;
>  	}
>  
> -	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_lruvec(folio_memcg(folio), pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
>  	rcu_read_unlock();

Hm, but untracked pages are the rare exception. It would seem better
for that case to take the rcu_read_lock() unnecessarily, than it is to
look up folio->memcg_data twice in the fast path?

