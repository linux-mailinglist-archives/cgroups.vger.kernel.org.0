Return-Path: <cgroups+bounces-7325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6486A7A1C2
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D946B1894F03
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE702417F8;
	Thu,  3 Apr 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ZZax8e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37B242901;
	Thu,  3 Apr 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679048; cv=none; b=l37vSVG1H/XWt0wYRJTMRRiB6inmtpEReUrYrMgZouBAwHDn/gwh1o3IUJ9b6p+PvPr8F5tlBPfee9Izy8Pq6nRPFxH0zykI/3kRYN4xO7EHnpp6nTwa/hnyXlHX3fNtmGnQ8dU5d7FTP2rvDIWPZq82ROsZwi0DyUjuRksvx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679048; c=relaxed/simple;
	bh=aRd1CbZN3L8wo+fthavp7HaP6EmzD4pkd+7LkSl58Qk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2AAphiaJcLj1ffHJz951qzAa35hgnhFU4qJPSf5oo5opqBVvMs3bQiuWjwTk8QcuuXySHd90CfbJ4k9MDyjd99LP9mDBCuW+qfjV3TFxUif2s887a7jnBQFAQMNozMZwc/BihtyFjMMWlXhUayxFdqa5cvu7M2XAO4wjXUmX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ZZax8e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b10594812so874627e87.1;
        Thu, 03 Apr 2025 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743679045; x=1744283845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B6yGiKNwNdzmfscTDQkaW1QIyxljiYzQv2I/D7Krjs=;
        b=T5ZZax8eP0PxJ/VbLU3AsNW9lJ4G4QrRAlrsNwm6I59CgkCAQXrZDV18RdD5k11akS
         0hLLPJ2RG5B95C+xZUV9rPd0NphD9/De2jOQBtLvc0iR9KXJRwO7ST27nc4dozp+HZjm
         yQ+BAp3RIY+A6us55VEEwJJRcvbI50RCzppahVMc4jGYISV74e7Nl5WTe+krotnWnLon
         r4h8T7VftIvhXhW3aUPbAS78d/BjbeBWp59vBK/IAdgjkA3PAzCYT3OHCWwYzyorWsI3
         VPhnkiKAh1V//8SSR72jkfVdSFV0evrf7zOW3x8pN+c2nsC76FbswNPw2F5+tAZAMR55
         zEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743679045; x=1744283845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B6yGiKNwNdzmfscTDQkaW1QIyxljiYzQv2I/D7Krjs=;
        b=GMDhffS54vuU8lupinRcS7AUzAgNSNDWOzbQfwc5UWU+L7tbyd4VgrJOhNkHmSpPfu
         tEJCPB+fOHdaJfK+TYazHJjGVS8Mgb9wkqaTBtlaMjs8ASsLnKYq7N0tRCtT9zM7fmAI
         7jZhWF7yuI/Bb5WYhlNkO2R+1llvDzl/8LX0ZUbFxYCbU8si3cUaGYxAcbODNoQshQYI
         uRLV4QeA2xYJ6UqZsDjcxovJ/6p1kaBnO2rbfxwzGiYbYBCBjxjslFl/KJjhtz3vX+PL
         k9LeNi+OIXbd+XFx/phminztsTkux/3yEM6cyALMTgi5etbk/4rwFBL/yxu4MY6wYbnW
         CXkg==
X-Forwarded-Encrypted: i=1; AJvYcCUPqnA6mP0Y9aKNROFKT6jQBHOjfKcb0z4o1qaBhZwo6CgEA2+RG6UwJouWdoa78j3QTON8Gk9z@vger.kernel.org, AJvYcCWcIRkX5jn5m+GiRTP5COJkin0JOMLCfiN+ZTTbfDAZpS63RDPflrdJ0Agm6/X90fOZxj6vYRC0lESFRY8y@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBgfhbLW3LzTTyAw176F8NOthwSGqQosxDiIXDRtyeZf2y04h
	9v0iUfsX1y6iUGdjxWtz6UAyq6q67txc3v+OWDVBtvKbsjwMONnhEqvqcA==
X-Gm-Gg: ASbGncubtlYmN8LR/Kz5LwR6Rp/2mOJwBeyYG7woBGJwhQtNEH7j14gY1AZbMuu83F+
	9vbngixi/vAKRsEeEcVBG+KF5qZh8guCKiUMXAQGCwWADTeo+z+vMZiKW1anj3Z4afUCEQDeRCe
	mo1+9kLJoq08SIrESNPjaZNZ2Dtrw/TD9vyvxtp9AuEGIJ/XKWZPCNIZwI4KGix7qHXT70cvjuQ
	fgilKZHtF73FmunGJJoISofcNyPOJ4W2n6ANcYDUwcjjXMmUIOifaVwV0/09GfyjoVvMyw4n9iH
	1uBWh80TcJZZEAAqJnU4f7oeiLcSWRJfnQReA66AEp3SQoS2UM3EGjWZCjrEFLRGSdliKotXRX4
	=
X-Google-Smtp-Source: AGHT+IHZUpWn98mMs6DpAc2coIrgcsTFuvOSeRMOYSdkF01E5/yPiCCmRA+Nar7c6MZGly5Oz5h8gg==
X-Received: by 2002:a05:6512:1253:b0:54b:1055:f4c3 with SMTP id 2adb3069b0e04-54b10db969amr6977015e87.11.1743679044928;
        Thu, 03 Apr 2025 04:17:24 -0700 (PDT)
Received: from pc636 (host-90-233-203-182.mobileonline.telia.com. [90.233.203.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c188bsm125274e87.64.2025.04.03.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 04:17:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 3 Apr 2025 13:17:22 +0200
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <Z-5uQlaPjZtB61C4@pc636>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403053326.26860-1-shakeel.butt@linux.dev>

On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> The vmalloc region can either be charged to a single memcg or none. At
> the moment kernel traverses all the pages backing the vmalloc region to
> update the MEMCG_VMALLOC stat. However there is no need to look at all
> the pages as all those pages will be charged to a single memcg or none.
> Simplify the MEMCG_VMALLOC update by just looking at the first page of
> the vmalloc region.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/vmalloc.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3ed720a787ec..cdae76994488 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
>  
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
>
Could you please add a comment stating that the first page should be
modified?

Yes, the comment is clear, but git blame/log takes time.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

