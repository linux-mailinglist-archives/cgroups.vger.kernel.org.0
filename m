Return-Path: <cgroups+bounces-1323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA0847C6B
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7055B259C9
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2A8595D;
	Fri,  2 Feb 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KWtg7Ex0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616D83A14
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913687; cv=none; b=Xy1TYW4yK6evBumQrYYmJgUAIo7HcpALvzX35h8mIH/skWNZ7Tk9XD5LPbIX0F2gNGtr1Wu0WVfWkNk5+8Hhu141YodGvOS3sGO9uW/f4GBTg//f/e3ERgsjCTt7YjfbjOVUtzOaOIda8ynCS5tDtGF/r06lvV/DlkND0cGGbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913687; c=relaxed/simple;
	bh=IEZ+Nc8EucSRu9Eu3hl0AOl89SOH+36zLs8bdUcKiKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMvF2LLl+pzmnHtkwPfFMMN+yE60ahb+MUOcOiBAJ5vQIpuVaaTQvQAQZ+MT8PyYThaUDsyQi2mP34Nkrk5TEvoOU17YVE7J2pg+cu3YYUalUwC5qgTnpPZs+WOl/ry6DrER3N3azoj+MPKpsSPqUGYXrEvk2hbPLbNfGOr14SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KWtg7Ex0; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-680b1335af6so32356676d6.1
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706913683; x=1707518483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TN/MFntii2sGtHOWJtEU34VYQvygXApI1VfgAn1sM3I=;
        b=KWtg7Ex0KNWBMTATm4G/Bd3AV4lTTI2ZoTA09vyMhEhPvRBjTOSjiETZO7AfDgmead
         GLud/GxGXX7vlLnz2iGxmaTaSpyoW8nVPPqYC1kmr0Nxq3oygamZPr8a2BAKKFZRigHh
         uTF82ITept6/XWybPs99vFj0s3wz+8adazM5xze9wb3B07BKG1EuempT5q0/RRBcLAHT
         Wa1Wgu0mx+asd1qOP/EkKFMo3FmUQ16N2hC+h1mVmziATXGPe5+0WmSGfVUYCzrZBW8k
         lavxZGZlZAAQBkAVLPyaWgPlZpgmrdMgVwl0Jf+PvX8jnG9aXuBa6JEmAt53G5epNGjP
         tDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913683; x=1707518483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TN/MFntii2sGtHOWJtEU34VYQvygXApI1VfgAn1sM3I=;
        b=ZpI7RGlXBxWjXeckm9d/wZHmTsFfERRaqlpJ1uhnwItAhMk8flYmamYekEitvew9Pi
         Zcir4Zlg47Q9J+fAeW6lpCDLe5PgBFXrkdN5vwjwPGeaSKkdIxzI/TdjFnCQQZQhLUYe
         kXl57Sy+k1scVQRlDwa1vZCotjmRH/9Wo+tjR+5vPY5Io5CZ2FWEU1sqNoiXz2Nl7YjQ
         Sl9+DWxZJFjKuiB5dNm+df2+SvVKM4HdWh2/0sihEs9sna4rjL/veppSDAKPUQQzk5FJ
         8xdQZkJACWtvarylGShwxIN4KwymhGXBpzYMB1VCHUF8e5XiuzTyrVCTpG94wv+sxkdT
         We7A==
X-Gm-Message-State: AOJu0YzBtF9zzDb7RlAtqwj5y/yTzbFJRK3ZjqricRhsow1SNllIvq3L
	fdsHAOGB65CFf6SKUHuIE3QOx5iTDnA1f6flU9Y8g8MvC7sJE3BZz6hpYj3hfIw=
X-Google-Smtp-Source: AGHT+IFLtRQYT2Z/5m6+iLpanPS2x7zIBRaj9Bd9wy7efYS0sCiA8TlEtuF7MnxBC+vxylljcXB5wA==
X-Received: by 2002:a05:6214:7f0:b0:68c:8266:32e6 with SMTP id bp16-20020a05621407f000b0068c826632e6mr36083qvb.22.1706913682992;
        Fri, 02 Feb 2024 14:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4bWvYAwUQZC6rHbZggqmXwNlF8A8uqOOd7ksYY2NMdBx0z09rVQSuT2l9M1pmbaeyFfYGVf3rG81eK51QwwlptZAV59nVNqYjWn5Vab9Eu7phEt3j5kkc5EhwoJ0zJ3YUUxb0iK4141MzksdO3SdDx31lCIy/Z7weoTBOhLzujWgKuvLBmzG1VOUYm0avgbZblW9FgN5Qg0qgtZVCgpSOEuKzWEKxPnTrSR0+iRjZnMIGzVt4co+4pH9IRVc6P6GHtwTb7CB+hLi5ZRCx3vfikIgF1FryOMXH7bRjBl8rlaP5pLNi24AkCOKoJNuMcOSJWU+Z+ceA1RSJAsUio19r/UwAkf1xlE09OGkAsHHPjLRVJbBFCDHK89PVIgf/K1FjHz0zfthh3M9jtoYqIz9mj5r8yCFBbJlq8g+i3HuJdslKhg==
Received: from localhost ([2600:380:8c43:7b07:78d7:9d13:1945:dc14])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068c67e305edsm1207270qvb.49.2024.02.02.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:41:22 -0800 (PST)
Date: Fri, 2 Feb 2024 17:41:17 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <20240202224117.GA341862@cmpxchg.org>
References: <20240202221026.1055122-1-tjmercier@google.com>
 <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:13:20PM -0800, Yosry Ahmed wrote:
> On Fri, Feb 2, 2024 at 2:10 PM T.J. Mercier <tjmercier@google.com> wrote:
> > @@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> >         while (nr_reclaimed < nr_to_reclaim) {
> >                 unsigned long reclaimed;
> >
> > +               /* Will converge on zero, but reclaim enforces a minimum */
> > +               unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
> > +
> >                 if (signal_pending(current))
> >                         return -EINTR;
> >
> > @@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> >                         lru_add_drain_all();
> >
> >                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > -                                       min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > +                                       batch_size,
> >                                         GFP_KERNEL, reclaim_options);
> 
> I think the above two lines should now fit into one.

Yeah might as well compact that again. The newline in the declarations
is a bit unusual for this codebase as well, and puts the comment sort
of away from the "reclaim" it refers to. This?

		/* Will converge on zero, but reclaim enforces a minimum */
		batch_size = (nr_to_reclaim - nr_reclaimed) / 4;

		reclaimed = try_to_free_mem_cgroup_pages(memcg, batch_size,
					GFP_KERNEL, reclaim_options);

But agreed, it's all just nitpickety nickpicking. :)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

