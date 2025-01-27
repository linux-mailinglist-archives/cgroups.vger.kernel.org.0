Return-Path: <cgroups+bounces-6335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E030A1D637
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C056F7A2CED
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247861FF1AC;
	Mon, 27 Jan 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZWKNdEXM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE91FDE20
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982279; cv=none; b=Qhx+WbNhBQrVHnRnOfgRJU/qFMocTmknqx1PdXDsA9fZRzuRsaXipMU/lG4v8OrULFe6Kehw6xcIcQPIFg+2xfNtg0os6Xa1tN9AovzXTB1zHfCDfoTxcThGSDgzmRrJ1KJtsMavtj0SIXBzAg2rWfleOQiiuNYcPxhU1AdsmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982279; c=relaxed/simple;
	bh=Td8hxXXomJGBUyWn3s+KkWjKdzCZMmqNMsICDl/fcQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaKRoVqUeMrPF3pZSInm0kO307GFIee2zE+ode7PWfAwYGeoR970V6+6NOf8eju44+/I+CYBANNZpGoFsS26dW6N2T8O4dbzWhDLvSaxBW1sxwr8NxDIA0mwjk63dIcNsMeO3nYyKWOqswkk9GY96gQfL0cNabOfbxnAyQJSMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZWKNdEXM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso30739735e9.2
        for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982275; x=1738587075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XC/99dq1lrou2LS2ZJ3dffAO/aKZGhjh2SSsK0BHGo=;
        b=ZWKNdEXM/QTUJ8X0rp+uWxhL2mOhR5w6RjSWRDLiRcC/PRR+OIqK8byhinhBC4TJ9z
         HAY7QzHMxAlJaCppTQWEwn90pEmlPLLcYnXLJF1EP/wALgtcu97w6kRc4w/3nq0DqAsM
         yUj2r9R8v2wjMN71HZhz6LiFXcO34rhbgd3vuHnAms7GDFL0J9613rsuyTiU3JrWtPbL
         OESoxB1bgltzwIpMj7+T1KMsBhAAK+5QXMJLj4rkFznfAG0gygC6PrjB+FrA8zGfgokO
         iYa4D98Itp+ig0wNaOychDCF/3fNRbZQsJYOynh0ksxFZNC05gmuCtaLmv/l6kvcHrfC
         KHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982275; x=1738587075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XC/99dq1lrou2LS2ZJ3dffAO/aKZGhjh2SSsK0BHGo=;
        b=TwnO8V2qU8p/IDlBjB77YYTbqNVNofskjBTaSSYaJKzT/2gzIulGVMzUZ3G1CgbeLS
         oSibBdPerADX9BAgYx3wt2z/snF1gCKO7wA2KT4xt5AbKO2G6UIHTXPEpmDif1UTkHme
         l9dYfMz13juDZLL8Vs3tIjy3/aUS0jZ7XisC7pWRY8ERteWNkGWlJcBwoEaWKnY83WLT
         Zi5CeloBYuWDeF74+ub8+05h3qK5Z5DLzMOchytp8+8dGyckaKjanlY9IXER3x5rTlpt
         OvJ9rgl3Y3VwXF9rpBy1u8s+MAZ5GFGbSvmd5MxsWlCMX317l/Ut+19ZisXvPWgOKsso
         PsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnCQQeOXQGzB07AOrsmvA70W1THDBNeLc7k7IHOxmtiR1eCCCZtWcsHqNmE4odHxnRgs+A/Ojc@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXhlgMQllXuKuz2JURlmv3nnG4C2SwOCc6W/JdqXJr7mJ2wQv
	qShyl/23TYjrjPJN24/TanwC3sE035DDlUmw9NKXuDpb/xw00oRpUM5JBf9bLs4=
X-Gm-Gg: ASbGncveCy68Rpl/npFXxZohynG2pQCcJ6/orTL7OadCdMrorcYJxaHfdwbx6S175+D
	/GAdrPy+XnhldHA3M37cCG2FqK/zM8XEj9p1aDVASl1nGKZ/im9iYAh1a5xpmXDcYkik/5yFLAj
	WoNennPEgquIb5GPJUwDjn55B7QSlAe0QljdoAhfeFs3SX+uxgLOTVGuzo+w5pq8yG9VwQNyTS1
	Jfq++Cv+LDfQpGzk+D74ZQOOSmZ7pOA1hahSAGlUHoCxLZOWYGJXNjtqrZnZDQyr0l62tLG/egG
	BUcbDO/IraQIJwE=
X-Google-Smtp-Source: AGHT+IF4Kt02Q/0kEbozaDJV0Lx8A5mxbL6EzlNqnxXWIcfSrEM3JTDfXIFJXqwKCG+uMK8hkQDu2Q==
X-Received: by 2002:a05:600c:1c93:b0:434:fbda:1f36 with SMTP id 5b1f17b1804b1-438914299bdmr350861705e9.20.1737982272299;
        Mon, 27 Jan 2025 04:51:12 -0800 (PST)
Received: from localhost (109-81-84-37.rct.o2.cz. [109.81.84.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd485695sm130149475e9.14.2025.01.27.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 04:51:12 -0800 (PST)
Date: Mon, 27 Jan 2025 13:51:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: move stray ratelimit bits to v1
Message-ID: <Z5eBP_N4k_kBad8L@tiehlicka>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
 <20250124043859.18808-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-2-hannes@cmpxchg.org>

On Thu 23-01-25 23:38:59, Johannes Weiner wrote:
> 41213dd0f816 ("memcg: move mem_cgroup_event_ratelimit to v1 code")
> left this one behind. There are no v2 references.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol-v1.c | 13 +++++++++++++
>  mm/memcontrol-v1.h | 12 ------------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 2be6b9112808..6d184fae0ad1 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -490,6 +490,19 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
>  }
>  
>  /* Cgroup1: threshold notifications & softlimit tree updates */
> +
> +/*
> + * Per memcg event counter is incremented at every pagein/pageout. With THP,
> + * it will be incremented by the number of pages. This counter is used
> + * to trigger some periodic events. This is straightforward and better
> + * than using jiffies etc. to handle periodic memcg event.
> + */
> +enum mem_cgroup_events_target {
> +	MEM_CGROUP_TARGET_THRESH,
> +	MEM_CGROUP_TARGET_SOFTLIMIT,
> +	MEM_CGROUP_NTARGETS,
> +};
> +
>  struct memcg1_events_percpu {
>  	unsigned long nr_page_events;
>  	unsigned long targets[MEM_CGROUP_NTARGETS];
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6dd7eaf96856..4c8f36430fe9 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -28,18 +28,6 @@ static inline bool do_memsw_account(void)
>  	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
>  }
>  
> -/*
> - * Per memcg event counter is incremented at every pagein/pageout. With THP,
> - * it will be incremented by the number of pages. This counter is used
> - * to trigger some periodic events. This is straightforward and better
> - * than using jiffies etc. to handle periodic memcg event.
> - */
> -enum mem_cgroup_events_target {
> -	MEM_CGROUP_TARGET_THRESH,
> -	MEM_CGROUP_TARGET_SOFTLIMIT,
> -	MEM_CGROUP_NTARGETS,
> -};
> -
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  
>  void drain_all_stock(struct mem_cgroup *root_memcg);
> -- 
> 2.48.1

-- 
Michal Hocko
SUSE Labs

