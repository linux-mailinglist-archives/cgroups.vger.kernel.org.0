Return-Path: <cgroups+bounces-11936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD5C59B63
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 20:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF343BDA5F
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6063164D5;
	Thu, 13 Nov 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="QzWo9b2F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A73126AD
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061402; cv=none; b=qum7SJMBnNL2b4twWB/o8Ibk1/rtj1vQ2WMRXOqU1jE3FEETfDVK8pwUoD5lnsc53y7RheDYoLl7Ki0boIVaANxw7OVXO4TTq4aTejNrxBSYkOz+GAP32YH2q0ip3K0/sn2Omqv8j0E8DnMcOU5ZzxYbHveWevoFECYn+ta5fhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061402; c=relaxed/simple;
	bh=lEHj73cyoONhyEvPx7Z5h/JZVHxOuRVrVXLl5x8q0SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKcv+RGY0NVPlcsDqOzBq8YqCNkwJSErWV7+z/IXWz25h4w7jqv/aSY/g1MgOP45uH/gZ38X/X9RDqg5ybkzuUNQcCjI4BO8K4l+vFpIjXRe01O4VvQgT1PtgLzlF6ZAlmuDGE+K7HUPcrBzPuynNSRs2rARzKIamVks+369TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=QzWo9b2F; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b1bfd4b3deso100126285a.2
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1763061399; x=1763666199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxjShYqK0SmvQj3uToI7bKSMFU1VR+C+fw1226ulLGs=;
        b=QzWo9b2FEnDvpKo9WnRoNvciUh9IEMQHaYIYITd0tEXtgbWIAaiSib8bKgG2vPmzbI
         S5PTRLNJzdvnQ2/GaFamYrN14+8vAX2phDBBaCYZwTy5BFHsAyrilQcHg1fOAeAcwaBX
         lJSZfxAJrIOZ3pfYXDi9fEZFISiImwQ6tmORMU4GBWo9mAHEFqvzNTyY7QoeJDr4ZXMl
         hU59tElAGKk+pnXyi9SsY8dvVwQp9b4KI4gGpDRpBsmbOVyzAjQuBxkQCCSx3prFN2PH
         sz/jfLf4MBEdjal6mQifZ3kvw81Pbr7o7iPf6Wbm1EgsILyqXwbYyC3iyyOXUvDvPlU7
         L+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061399; x=1763666199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxjShYqK0SmvQj3uToI7bKSMFU1VR+C+fw1226ulLGs=;
        b=gP6l2rhJ4DfW4FF3qF4HVFXTLOTD0ler7IB0XSdxJg9gG4h8TOcpNGvaTuaOy4nOHi
         qllnSCfx76/lGlo6CJV7c26jRQrRnIAkqAbc08BAu9juULdcYxhcwp6Gvf/eJ9GHkVh/
         V6UJXxtd17DGdJYZcdamwYIZUIkfthSqi4RGoS2vXG1bVYJmg0h22xJ9U9b6ojOZXgDt
         5mTw/Mk/q686sB57j4ml027KHJXpBDJTgDCD/jEv0QOon1OzJ7v5OhZEkoTkPs08FZ92
         9YIpyLf5A1gmcgJAdw4ecxuT6hYXhDrzHBQbt0cv4yvloOh0TiP3/ewzZu7A2j3rTEQE
         XE2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwQljuxNqaLsuXSQia9QdlPY6Ydkx2k0MEs9vbzR6Uhol6buPTQVgPX//ug2NsFEpQcA14Qn26@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeebnFyIdPh6GFmHaMlvof2spHwkS5LktCUMIyvALOIxJ+tuQ
	IZORwWKOwvxjCpKjiZkOdPLjzxnNOPHPWJV9UEKt6YZZSLO3AKmS9E3XFOYJd1HKCXs=
X-Gm-Gg: ASbGncvsFiXAiBhjJnJrD1zzfodnBH/GJnHt4wqsINEe0vSlXQyQHwczx4mxuQ7dGqV
	+QtQ/TQ2o9+on8FS6YTFKZOphpIg8Afm7geMAtsGeY2KgW4fhosoTQ3+5feW6G4HZmLyynqvUDp
	6VFNgvmyTrD6Dl07c2skYaZW3C32jcYROhgJHeE08KanqPYVVby8NnKcuDCb8ex6uMqltTwgvZn
	L7o/7eH2LjtBl7LvDoTtHwknLSj+qsaEQuRSM6AS1D0rr+6vJxuhofFwheMWxWByVaRkso6J9dM
	Oof85K2b7rTQn7sGi4f2Ns8wh3S1y2tqIDxF5d3rpLum66ljlLFpMvdcgMCCDnwakIx1mvDdEnP
	q0E6W5vuDMXsRoT2GkzmTFR9tJE2Gw2uic7ML7NYhNKDhbuWsSRFKHRdzXklM6dvx5ROuBr/wZG
	I=
X-Google-Smtp-Source: AGHT+IGpEDPemMbTY/tSqdrsw5hKYs/c+DFsc+7Rz7Y9vOLYTYETjGT8tc6BrkQHX26180I021LtWg==
X-Received: by 2002:a05:620a:404e:b0:8b2:eb2:54e2 with SMTP id af79cd13be357-8b2c31b0e9dmr75851885a.47.1763061399043;
        Thu, 13 Nov 2025 11:16:39 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af042c9csm185548485a.46.2025.11.13.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:16:38 -0800 (PST)
Date: Thu, 13 Nov 2025 14:16:37 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <20251113191637.GA1240@cmpxchg.org>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
 <20251113161424.GB3465062@cmpxchg.org>
 <aRYJzbZpd-UP3jh9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYJzbZpd-UP3jh9@casper.infradead.org>

On Thu, Nov 13, 2025 at 04:39:41PM +0000, Matthew Wilcox wrote:
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2599,9 +2599,6 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
>  	struct slabobj_ext *obj_exts;
>  	unsigned int off;
>  
> -	if (!slab)
> -		return NULL;
> -
>  	obj_exts = slab_obj_exts(slab);
>  	if (!obj_exts)
>  		return NULL;
> @@ -2624,10 +2621,15 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
>   */
>  struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
>  {
> +	struct slab *slab;
> +
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> -	return mem_cgroup_from_obj_slab(virt_to_slab(p), p);
> +	slab = virt_to_slab(p);
> +	if (slab)
> +		return mem_cgroup_from_obj_slab(slab, p);
> +	return folio_memcg_check(virt_to_folio(p));

Looks good to me, thanks!

With that folded in, for the combined patch:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

