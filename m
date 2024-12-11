Return-Path: <cgroups+bounces-5806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0549ECFC5
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B6528226B
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4B1D5CF1;
	Wed, 11 Dec 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="kSXdqclo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028421A725C
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931142; cv=none; b=Li4/Xzw48ULHb9jnNCIML3cS+Tkdf2UTQxYvWvt6hl4QRdH6cbZATtVz8K1Kzx06MUZxktcAVZw5FgRGotz7mJmDzWK2GEKlbQoZ+nOkGtwlMGhRKVOAyKcTHj0YXoSiCOhN4KDt9UU3IunNLQPFwc+dKr0MpoG84wuw2h67Tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931142; c=relaxed/simple;
	bh=xJJAdLG2MnL2RoVNzzNJI1Bb5jWfSVXky7a4pA4KYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epEAyv3MNGVAfkxmnjipgggQ2We5li6xpbvS0U7o12cJvSnk9rZf3/fYyvjLIwGKzhLDP5Q7M7CErKYr8PPc3aKiy85sYMQUn6OKW06mf/698cf9xzMfav5RsOWy2dPNh7ijx42cHD5v9LXmCENeSId7FY6DfbWPG4yYSDivAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=kSXdqclo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b678da9310so616812785a.2
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733931139; x=1734535939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awqg9NyNSHCYANmgf+Mn+5u0b6mI5gQklzYKZzm0vmc=;
        b=kSXdqcloGV5sVFDTGyEgz/qvzMXIb3o4S2fOGMxyA9rTtPB7ItxoQsRH3wQe8nfbaJ
         qYx/5F+GzIFBtZCR1yp9BJako/ADiFifAZjo0R6T3WTH70dNxxL4P6D2bu6jFQugy07U
         H8eGA1AoN9CsZ/aAE3qG/FSba0ssJBRrqqp9hUb+nZlXfm2hSeY2waz7HkoYkv7POyg+
         CvtVOt3JMHdOxiiErft2Y5WMClfHvrHEtANzZb/DYvQ76EiOpmUkcDgADVvmyg0fB75O
         m2lDM7ketWKRVqBqRF9hiLHyIiJY0lSTqtqiJbaY5gSmE/QmCYS2P84OM9BBICbhx/Qt
         O42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931139; x=1734535939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awqg9NyNSHCYANmgf+Mn+5u0b6mI5gQklzYKZzm0vmc=;
        b=SpzVEJltmjQ8UPBv+cKlJj2TpuQf9DO6nLIo6Qmy5YN8sR1hmRZ+aZIQFgLg/KDdFS
         A+ItmyLAA4Wc4VtbR6vafC2Ruya3fP4yvcbWhB4sM6tsfb4TeZFJiAKDSB51RuoxhfzD
         MgXpoqzYMPr7XLGr0MSiWE6RnMsXlgaHYcBZgmLgNBX+xwq3V+wcKf/9SxQXea6me3r1
         YJXxCkjoNsV5hNfn2GVDZG8M6HHjjT9kAPIjmnqFMr3VIVU/LSLZqJ9nRNax2hvjJUvk
         1PfuRX/jiCgVuLX1z5aXUGpNo1Lau9W4ydfNDr/n3jSizkTGCa6veSkRAwALPUtMpx1z
         nt0w==
X-Forwarded-Encrypted: i=1; AJvYcCVqTxNGhKo55bHGovxVsQXIP/vERQ2DrQsyt4kyCPGFT0iAgWUUwJQ24Yu4282J5ZfiBS5yunbk@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYRfHwMqf2p/Po6FqYck8nq8KhNTCkESvjJ5C51YrYBOz/TmL
	shR7Ngg8YUA00xqRCxTrAgTeaUI1IX0WRQ+ggl2EGN985Yi9xYLg+2EXffo8epc=
X-Gm-Gg: ASbGncu3Xw3+6N0+m4EzXnaD6GaGQ/knNpFAC5fMdZ2bm9DEILIOKGGEYaJ/porD07x
	nQQSOgf0Jk7074mtGkfZUouWt9CwOZ3pMRlTAHRRnPSmiH3G3UXh7QLSHizUrK/3uTbkMGeoun6
	oGMeLTrkul0RMER/I98Edfyd3oqidzJ47I0EzbORRtGNm3uBfGf+GgMMra5Jm63irw0s7mGy/g8
	+nGVNt9JQgcRLt+3gM6YZx2hD+yS9Bqgezi9c9bZg133C3A9szE
X-Google-Smtp-Source: AGHT+IFOj5lGUuf6afp3JD+tDypMseeTH5+Ku4Z+VnrYYRy/zTpgcZlsC0+8gorvfeDMXfHHS/mZ0g==
X-Received: by 2002:a05:620a:4050:b0:7b6:6d5a:d51b with SMTP id af79cd13be357-7b6eb53b012mr449355685a.52.1733931138674;
        Wed, 11 Dec 2024 07:32:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d020783esm360340185a.96.2024.12.11.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:32:17 -0800 (PST)
Date: Wed, 11 Dec 2024 10:32:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] vmalloc: Fix accounting of VmallocUsed with i915
Message-ID: <20241211153212.GA3136251@cmpxchg.org>
References: <20241211043252.3295947-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-1-willy@infradead.org>

On Wed, Dec 11, 2024 at 04:32:49AM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages in vfree() without ever
> incrementing it.  Check the flag before decrementing the counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

