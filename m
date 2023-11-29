Return-Path: <cgroups+bounces-670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8D7FDAB7
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD8BB21108
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35BF37154;
	Wed, 29 Nov 2023 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lR2QXSey"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDCC9
	for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:03:03 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-423e8145018so4380341cf.1
        for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701270182; x=1701874982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2wsVpYCu/TCERAyV7xfQRsKsQF4XxordQuNYbkUm7A=;
        b=lR2QXSeyGT5u4GTVYZfZxg2iG6AejM9Ph6SIbN/jgglTsbTqFyyEj1A0wmuT2klFiR
         9WGsBbaEgsq1RMpCBN0deZVdSn1zXmq4NIkJyPpPIy83+v9jBdHsOhyNC0vUO/NQt4JR
         gZRz3CgBFmFF+ZVACuabXxTKJk5y4NIRql82g3V+gBPp/G8M6J57TJ89CTKampvTyjzK
         FtLBzxIk5yeeAVpq9cpM6sxhftbHuMKc/oASLG11grxJ/WtyHlFunaX9g6EVBCdT7M7F
         osOWCloTiMT4LUxi1FN2U6nJ+6fvwjnU91AGzp/o7k7GKaKg9p0JCdd6ROwPGeLyV4l7
         7B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270182; x=1701874982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2wsVpYCu/TCERAyV7xfQRsKsQF4XxordQuNYbkUm7A=;
        b=ltvcqloBvPHJbCrpl7aWaqt7IVTPSJgigS1JyahXWrP4gHY0W/SwjyBoxR3i4du2NO
         5DwX86hHldBrjmDjiWk4bmICMbP8JizRf4A1IxhAhqLHkK0bQcIoX+lsOjX+arI9KwCq
         jR6HC/PcM1KQCH5GDxBQT/G+ljJmyQejsd1EK+3uZYVD9b7jazmH361OdtCrccj1MiuO
         iESp3uGU8eZhe4HZL4hNIPnix7vbs0KhnXXaEmCsYCFmusk5ugcTTeHtQ3djnnZqIGMi
         4FQ+w4VIx/HXx/v5QNa6WQkHwGW4qJnSpFbQnawq7VNxFfhUplesDPZBUqpJ0w7QMPpP
         8bXA==
X-Gm-Message-State: AOJu0YwjQP3iSFI9L31NK+PF8E7+kWyF/NBHaFsV9SwwXMzhjLzT8zD2
	ENBWcV84it8naL1mmMVtAzESzQ==
X-Google-Smtp-Source: AGHT+IFhbxa568oWRmeUGcBeIbWIWKZfp+eJgBPEkoaJAKk9/smfQhel6cgM7NgfceIz+TM9Gd82+g==
X-Received: by 2002:a05:622a:a14:b0:423:f0aa:a82c with SMTP id bv20-20020a05622a0a1400b00423f0aaa82cmr1468250qtb.32.1701270182230;
        Wed, 29 Nov 2023 07:03:02 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id fx10-20020a05622a4aca00b00423de58d3d8sm1366432qtb.40.2023.11.29.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:03:01 -0800 (PST)
Date: Wed, 29 Nov 2023 10:02:59 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
	vitaly.wool@konsulko.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Message-ID: <20231129150259.GA135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-2-nphamcs@gmail.com>

On Mon, Nov 27, 2023 at 03:45:55PM -0800, Nhat Pham wrote:
> The interface of list_lru is based on the assumption that the list node
> and the data it represents belong to the same allocated on the correct
> node/memcg. While this assumption is valid for existing slab objects LRU
> such as dentries and inodes, it is undocumented, and rather inflexible
> for certain potential list_lru users (such as the upcoming zswap
> shrinker and the THP shrinker). It has caused us a lot of issues during
> our development.
> 
> This patch changes list_lru interface so that the caller must explicitly
> specify numa node and memcg when adding and removing objects. The old
> list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> list_lru_del_obj(), respectively.
> 
> It also extends the list_lru API with a new function, list_lru_putback,
> which undoes a previous list_lru_isolate call. Unlike list_lru_add, it
> does not increment the LRU node count (as list_lru_isolate does not
> decrement the node count). list_lru_putback also allows for explicit
> memcg and NUMA node selection.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

