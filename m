Return-Path: <cgroups+bounces-7358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FDA7BAF7
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE11B60E16
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDF1B3950;
	Fri,  4 Apr 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMGYUaVP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B791A5BB7;
	Fri,  4 Apr 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762880; cv=none; b=pwJ1jxzBKBuBss0lKuvBF0Sn5Du5koEIjQLh+HWrr1h6FBv1yMas+A0db+S0QM58Y8ElRGle0vmRV/wS4ZYGtxFufg2xab4gxp3ZsIZTVKtTTeQt0diuz7MVTF3HILfFJ6pWYJSZfG2haGiVxVquVYoGiaBdLdg4ar66RwiDmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762880; c=relaxed/simple;
	bh=wFi3lLYLcRI0b3/fXY38uucbbcsbvjzH3LbACbufMVI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgUNi4SyyPsF6aIWE4cFRHko5dW04pVZ8mDwIjdYrwLzUFY7gCCCYkq1ILCt6VG7+hBkem1V8zx/fEQLDP8R56c8/JXRVxnKPboeKwbHyKhD5DCWcCwXTdOFLVx8UoDhE5EcNpqyReWx94bU6cuXjT98HYh9KzRfBtq6Wk2C5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMGYUaVP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54ac9d57173so3172529e87.0;
        Fri, 04 Apr 2025 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743762877; x=1744367677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt221mzGtOox30Nq01Kai+HNVKfxDjjfDWXsZ2VepEM=;
        b=dMGYUaVP2TNfw18JSfghf1ZRPtua8fye/F8Lz5398mWPnbNA0KppTy20pHFJ34Va7Z
         IqhHxYE4rQN2P+Tvnt5ygviktvTQZNh2Jfg+s7x2UuXZnMboSESI/1ZoiZ/m72SYNeM8
         K8LdOoh4FMLq8BbHtBwLT8/4pyhVp5Kdng2W0+bFtdnyZuWjwvVwfE9WvoRZB9k7cm5O
         VGH9GpvGndgdXrL3XG+kyXvMQt+xWTu1maSxWD3vSJL8gEAKgrQlZaRtua8MYmqFG6Qb
         MYFBvNjnI+obism+oHq5ZOa/kOZx2SYevpvPgTBanVhIonf3GE6SltmSC1o8PQu68s+j
         j1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762877; x=1744367677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt221mzGtOox30Nq01Kai+HNVKfxDjjfDWXsZ2VepEM=;
        b=PdlMhWXCYZ7SypZtcOv1ZBIN+ZlEDwUEqWC/VEQAAOnms8Ag9pWkRCCeMq/wFJJTsC
         QhwYTgm/pEHel6jZX26j/TDLah+0eVdh6zgBYdqa5TEdLZNMSEFZyJUOsb8qnwfvUWOp
         Hc4iEG3I0hxSg2r0Ayg9iemgV8VY088UbllDrg8PfUcHlwiFnBptz+EJMWgEmqPQro7w
         u65mKqBk2rOazCQLPgvX7iNzBGxdIFTwNFAzxkSjg7VcA1iAuouRGb957O4xq9pEbFAR
         qWuO580GJToFDOLjeB+1rJzSFxurcHze+JDY4sMEFOgw4wDtG5AAoQXo6upP0L4MWCRN
         XZoA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/INmzrjfxXqrOYmSpUadnrDK1hnR8oWc0mrV0Z14/MOHZd+2aw4kWT0mKZkY3yIAQIpzJ7pWPGQJt7zz@vger.kernel.org, AJvYcCW2S6REr/+bLKiXfbMBZa19tgB1z1nyq0TWfA2ZRVXiYYfV30Ke9JhIysQdpyVAL/qsKi4MzHMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxaM9csIAeRrdz/KyD8CfYfiv/tR+ZMpqknZIC3IwOFnMafRV
	pzuFKGw5KNrW0fHz4lC/0Vr2MoH/Vxv+ST1utcD2EE79oF/adv1IEAXK3g==
X-Gm-Gg: ASbGncvzP0rUvb8hu/Wc2NQAtP2EKB73f5p8izIHT24CYqun8xHeSoD/1Nba2W5kND/
	Pw8I2blgK8w/ersArP5T0jYU44/i0B+/ECzoBp50UYOmWJ+owsalm3CYM6k/M6s8mj5GPCUujPq
	fpf1U5IZRv7Il560xzPlGkYVkzhEQr7gop+M2EzlkCcRUEEOvCGsPpEMYclJ3S9OJVjwi1bzOSd
	9486r+0M0DSsNSdGodmStcCy++VJnH/dFrlj5N7v2uYfcVPCWYc8lekYPxFcRupiKIQdrW5odb2
	KlSnMcmGZPxhO45UnW3K18Jz83nuZvFYLP5luEYPV/Ip5qYoRF4a9Xv5SCCZMMNPC39C2kV2BkV
	Wys04/YvXJA==
X-Google-Smtp-Source: AGHT+IHkxdg9HqOSSCYbSCu9EIn4P0zU3YpcTu2bk8+M0P0Qh8RZG8dVhjJae0tHGZwPrdmTL1dt2g==
X-Received: by 2002:ac2:4f14:0:b0:54a:fa5c:5a0a with SMTP id 2adb3069b0e04-54c22619273mr943569e87.21.1743762876449;
        Fri, 04 Apr 2025 03:34:36 -0700 (PDT)
Received: from pc636 (host-90-233-203-182.mobileonline.telia.com. [90.233.203.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c25bdcc18sm85427e87.72.2025.04.04.03.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 03:34:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 4 Apr 2025 12:34:33 +0200
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <Z--1uXnfqfQthYvh@pc636>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
 <Z-5uQlaPjZtB61C4@pc636>
 <gl5u2fkxaqe4todqwzsfktvnlghb7vnan2n3bpxum7ibwaznpd@xomzodg47qwe>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gl5u2fkxaqe4todqwzsfktvnlghb7vnan2n3bpxum7ibwaznpd@xomzodg47qwe>

On Thu, Apr 03, 2025 at 11:20:18AM -0700, Shakeel Butt wrote:
> On Thu, Apr 03, 2025 at 01:17:22PM +0200, Uladzislau Rezki wrote:
> > On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> > > The vmalloc region can either be charged to a single memcg or none. At
> > > the moment kernel traverses all the pages backing the vmalloc region to
> > > update the MEMCG_VMALLOC stat. However there is no need to look at all
> > > the pages as all those pages will be charged to a single memcg or none.
> > > Simplify the MEMCG_VMALLOC update by just looking at the first page of
> > > the vmalloc region.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  mm/vmalloc.c | 13 +++++--------
> > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 3ed720a787ec..cdae76994488 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
> > >  
> > >  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
> > >  		vm_reset_perms(vm);
> > > +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> > > +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
> > >
> > Could you please add a comment stating that the first page should be
> > modified?
> > 
> 
> Sorry, what do you mean by first page should be modified?
> mod_memcg_page_state() will not modify the page but extract memcg from
> it and modify its vmalloc stat.
> 
I meant what you wrote in the commit message. A mod_memcg_page_state() can
be invoked only on a first page within a mapped range, because the rest is
anyway is associated with the same mem_cgroup struct.

Just add a comment that we do not need to check all pages. Can you add it?

--
Uladzislau Rezki

