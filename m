Return-Path: <cgroups+bounces-11453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F42C23D4D
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 09:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DD79348E0D
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5542D6612;
	Fri, 31 Oct 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CcNSXCN8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA36244694
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899670; cv=none; b=i0A6xxr4RyyJYgcObbUmfsUS4e72/6KvjluIFrRjFONLX+g11xM8CZduyrYiZfmcrieoSsIKmy80Z/oPprfqePSlH84sxHNJz/boWSEMZeCVpDrec4qLY9lIdJs7EMs53w6MVX30jnZiq6n0FD+Xa3BkT0CRmGzx4CLh2gTALsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899670; c=relaxed/simple;
	bh=JQVFkql8pWeK7mXHaJQC6Gx6KXjAssW26okHU8bcIA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNYAKc99ubrpFB9XzwyjaaXquO6UyqNM5OzUqXvtCFhg+1hM98xpMa6InUbklIfCmYOuc53KoA10Uxia95kmX5zlRw9NJxsDHzNdj6q85shpYXDDUeMct5pa0y4vuoLXrv5ANCVLR5sDenNBBu9taZg41C2FZLpnD48Z6BtaeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CcNSXCN8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so20034165e9.0
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899667; x=1762504467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Brce2942SeTVJJTNYHk2AtyCkePvDy1yHUmXXiPEbXA=;
        b=CcNSXCN8WDDng70OdVvWRSucR6peMiB+orO6aX3K3eviSeNCIrRkQLHtz4RSn7OYQ9
         rtjwdOAWKsx4/jkLbhh8f3Z1d8Rey9454hMhCsqKisgPtKn5YMBguXDtbcM3qr+8cuWw
         4Gt+cwJi2dwb408jjCcuCHA5XDagHWbvfLNCXoHBu3dEtQB4bZRaF2GOP6HV1ozRysT2
         zMhcxOcq534VG6DI4dNzP9jYEdRLTWkI39K5jwVLh2iVJKZRcVjXa2pMEEdRsFQDgtO9
         jnT0pfY4655UvndmSOkz0H/aNTt4EOOqvp061i0dojQDcSw7DtUfEdd6+fMfJGJ5RqkR
         AAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899667; x=1762504467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brce2942SeTVJJTNYHk2AtyCkePvDy1yHUmXXiPEbXA=;
        b=d3ed73ozM4rozPL6DEDFilcX+1yhtxVL1KnjPGk5U/2U9iuzQtFeSR5CCZ20tcYqBM
         ruG3UA28d4FeTMH6s23L54LZtQ3ORkuiY2FCDjTuRv++JVSDsRt+2/OX/np7LrGw0Vq0
         Vg8uKI655FpvMr5ZVxiaeqdZe56+q3umQENi3290NiwO0tsA5yQOV0Tr/WEH0/a1s+s3
         cNi/xT/9fjzyfM2EgRxcBen1fGRIkJEu296mlDX4jZ/utyt4KFMenjZlEkxySra9B4ZS
         WiEJwcTf+qPBezZUbXusaPQE2AWgmYon0e3NRY0eD6h2re4R2H/z97xSEtJ718jjOQ8X
         qJrw==
X-Forwarded-Encrypted: i=1; AJvYcCUugjsSeQIGkSEaYXHua0mqMfdkMOgHv2WxTZMfrWixtIUbs7keAp00IogjybkFV86T3kgXfXki@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdJ3GIISDkOh4/5mUBwGwtBPIzpgB3NpvfTsh6Ujj9/QC+yUq
	Ps8UqjYGSnovDh4e5uneNuMfZSFOdoWlqp6JUE3GgiEwzfVvD97742yF/zeMdz9N/0Q=
X-Gm-Gg: ASbGncsdhzA3qIots26MhZTlbW7Oh6KGspFnsycgEqjIdgEp/THvQLBgzajUtnPy7el
	Ly6bxwz+CWHNZbZV50GaP3y1WjqDq4j8k4SWnDzkdBOFSpdADuBLFSQUp56w9BN+ZCbjsA+sSDY
	Odm0Hmn3VtYO/t2s4+B6BZbWdx0AzCkh4VD4xJQ3VxyGxsnj/rHnf6dZFsnvLnvpIeP8eJ/Izt2
	krTIR18Z7WL7PWTzztcdqpBlZqSQaJBQ2dY3rxyCFPQcHbXp4rJjLx2pgR5xNDUJs/ep5OldNfi
	KFYJvGCTC1QLEZ/UIe8HxDjLAl5o+A+pQPgkect5lmxO+Z/1J0lxRRMD8G25FcDdYxzYN58YqKC
	5si1DfSAFnqDZZs9Sd8/GJcI+2jUBJhk6kkjH5zUXzU44BDI45Oa7Y9Unrdg5TJ7EysQYDhkQUQ
	hw37C69q9PjczF2g==
X-Google-Smtp-Source: AGHT+IEqeWzc1dYod8DDM80O+3DfRoIrCHAb+32/10VgcqcE8gyD3g3E2A+vxz5v6zZlDzTIz39ZaQ==
X-Received: by 2002:a05:600c:34d0:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-47730872dcamr20908505e9.21.1761899666777;
        Fri, 31 Oct 2025 01:34:26 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf6c05sm17137655e9.4.2025.10.31.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:34:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:34:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 05/23] mm: declare memcg_page_state_output() in
 memcontrol.h
Message-ID: <aQR0kf_g2e59JCmz@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-6-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:08, Roman Gushchin wrote:
> To use memcg_page_state_output() in bpf_memcontrol.c move the
> declaration from v1-specific memcontrol-v1.h to memcontrol.h.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 1 +
>  mm/memcontrol-v1.h         | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9af9ae28afe7..50d851ff3f27 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -949,6 +949,7 @@ static inline void mod_memcg_page_state(struct page *page,
>  }
>  
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> +unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  				      enum node_stat_item idx);
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..a304ad418cdf 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -27,7 +27,6 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  void drain_all_stock(struct mem_cgroup *root_memcg);
>  
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> -unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
>  void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs

