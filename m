Return-Path: <cgroups+bounces-6228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41AA15511
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB13D169B09
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294F819DF4B;
	Fri, 17 Jan 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AVpQGIkS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7519C54E
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133041; cv=none; b=JSV7h535r6Xl+sE22u5RdtL+I3+Zd3eWp8BzPWzv+jYC4XciUmwVwNGlvu8oo4BdoV47RMQii9ExLgdna8mcBFo+7WeYRWUBkvQmiSw51qifJCKpmo3L668IDI2cTW9dQkL+OXut7Kpg5eSme85OabKwGcncyScaBdJK94G+PuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133041; c=relaxed/simple;
	bh=6ow3zCdAZ7HxDhWDO2oG9aKSe9LSbw6iohSvIxenrV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQziFmhi+vX9bLifhrOa3UggYV6LZ8UT8GXRolGbp7S7/UFGBsgRljbOkqqOBii7rHCukKStoO4hyTE47AO1dXsysYnIzFc1d9MWV5VONbBKHJzNBwP66f4xcA+qBg7hbJvw4yQ7D6PwaQmgQGDj8nixPSBOaX8xBG7C52wvWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AVpQGIkS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b700c13edaso119258785a.3
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737133039; x=1737737839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3+FOZl9G0CmS+l4AgTiYZxyDmYtH5WqjmYohOoxqVA=;
        b=AVpQGIkSIJJEdIJU4KSNtbAl+A0H8hWavDXZR/bIsKKN5/9XLjotrJ+Gq3a7jys6NV
         8LPzqUNwXbkcxZNOu5dGqywlvrC9tFpCq8WAZBhuIs2EjK1EQIT05O4iLx7w9QKV/77g
         ke+IIGeY6Cknmt5MT5uoC8zGavHOhdwoYznIz+RJ+RLSZktLH8+v4QgmPp0FkvlkjBPm
         ceKH3wZrsK3l8ZVO3MRMyQZP5Ra9OX2y1dJ4uN8+wogXNWRgK78puqp3KRIIFDbK6Wv2
         xgTBJdqIWE/9VlIGv826+/F5IYsW8QZPQ1BIWa5vh4e8yt28ulsDl8o3bVKD5ABaTlAe
         i2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133039; x=1737737839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+FOZl9G0CmS+l4AgTiYZxyDmYtH5WqjmYohOoxqVA=;
        b=etDdYPC/DLVVf9ENZ3YFll1KRwjSglz6NccHEybtaKGM73rWVhcf1vMsaz86dHsEdS
         bRB1Or13zJsh9KqYLJ/DfBE7kIIYZf+jzdr1xp/vR2UWrsqxvdrZb+FRnwBCn7b+EAPc
         kAttU5P5f0LyBbFqdcH/r8kK5tGx55wxgMaaHMxFDGAE9blT5+iqAzZKY6C/NJM6zkJs
         ACAnrArs8x4Ctyho0BZqrdjwr4yBiJGdxc05uQPaQtnFmsrzR4n+6ckAc65GRqZZ070J
         7koxip8xJuA3NTrU76msXdM3djJWgaVtLdQsbh4Y+t5J1OESMOwjcty3FtyYHlyo2xMv
         4rOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7rpaQs0WUgZPihAy3zVXH4gJmLYkIf3YjAzQquk1FtmcXg5vyvYlNZI1wYYs4Iake+TJG5nC0@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4QBT8XZzlWfLAuIQqt0Lwf1xbwRIXtwv79MAcPDAzHiL16L6
	nUbEdkvsR7+vlYlt4ewQLlmgM4fR8hPYTAZ2HbKqdZ5v8HwFQMZHafH6D7Lx8tw=
X-Gm-Gg: ASbGnct43PPApNBsDBbcqOg2VqalE6DsaD8ba94UAaOsjIGlUN7j7XmPQJpxhVTub51
	tRH8W/+S/rQdPsQdfdxsuAWugV4OEE80BE0EDD8dBwxcA1lDwmlAFz5YIZEuD8f5b2p4o1Qak8x
	G2pup0ni1j9ZS8pS9sBojxZduxkSnOfvr9R1kjzsurNWAh4zffL3e+7+5BwTt0hUScLdktSIEFp
	Nz8STIPJHhSEd0JcPYQnyBoej0BVbMb6eNWwkbfgSa21FHe7v28OXs=
X-Google-Smtp-Source: AGHT+IEXRz29FmQ7/DeWr+qbLVpSrbszPsxs9nr3ZLeyzTMwlO5/BUjKEPnQYg9GbkTNysXjXKLj2w==
X-Received: by 2002:a05:620a:1916:b0:7b6:e98e:ad15 with SMTP id af79cd13be357-7be6320d09cmr474429785a.34.1737133039335;
        Fri, 17 Jan 2025 08:57:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7be61484065sm130301685a.49.2025.01.17.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:57:18 -0800 (PST)
Date: Fri, 17 Jan 2025 11:57:17 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 5/5] memcg: move the 'local' functions to
 memcontrol-v1.c
Message-ID: <20250117165717.GG182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-6-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117014645.1673127-6-chenridong@huaweicloud.com>

On Fri, Jan 17, 2025 at 01:46:45AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Move the 'local' functions, which are only used in memcg v1, to the
> memcontrol-v1.c.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

This makes sense. Without the refactoring from the preceding patch:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

