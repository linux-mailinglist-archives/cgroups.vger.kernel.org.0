Return-Path: <cgroups+bounces-7615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9AA92049
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04AA1726E9
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49042528F1;
	Thu, 17 Apr 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OLALmFWq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E6347B4
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901616; cv=none; b=Z74ymvilWUOE+7jGU15bQwuxzhot2sVaFnXumKG/EFRuRPVVycywU2v+s9EvVuNAXSPx01P2f/xvDjz4px4xcKjbAAt7QlYU9Axm+urS2YhJXEkzIjz87dageN/EAZ/KtR40prrACyhPYf9XIP7J/tR1LTl5VFT/rWcRCd2ykX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901616; c=relaxed/simple;
	bh=y61pJ7AcSZBNFmdsM2+NqASr6TeC1Dcv0/mqRc2L9Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O18d9f/fGqheGrW+p/G75wHyrKQ4nTJ12oahtX5Q0xKsjeaQQrDjDVl2irBP5RQ+tWEslMT3NQWskawpaCpWihBEcVBGkwgwkc638c0gdfvj1gQ20SdX+9PJY7GAdA48BlGG2iAjeuf8ynLYukDOaJvDIyN+04GAF+0+R60U/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OLALmFWq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5b2472969so82247385a.1
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901613; x=1745506413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orQzpRsQIpG3P6OtKhgbz4MoOFHOwC//U7SqiKMoiFw=;
        b=OLALmFWqozm7G3tij/pG6mT2tipUZe4ccO4aPssh2Uz2nE464yEuKAaDIE3gn6Ycfp
         jmwpd/1s9ToTxKl6LpMO2SxqMlsj/1WWtWdFLY1Oqq+k02IDsV87P+XUue25TspxSZAM
         Ki3yfmmRnVi5rhY+Elh+g0yMdvnfV1XVKy13GcnHwuIs9y+QfP7kx9BpFPro1fbnbWxB
         h0j5HjCpEP/OskYNTL6Ijoa+LScoGHVnSU0CHQ51pa0vJxJU7alKz+eDDd+NYkBPsted
         4xbTC9OTA8+Avo9kbL2to2fM77/MPUI9bkKe9cBZKuxfEUqicSjqhEnItXWGtwmX7/Va
         Vz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901613; x=1745506413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orQzpRsQIpG3P6OtKhgbz4MoOFHOwC//U7SqiKMoiFw=;
        b=sJ2lAnb2SKnfOcs+5bwM7312FXErF1MmyavHhoLHwYp1J/e3QWU+c5zG8KmnIWcD2O
         qHWfjepv4qkQJ0JpZ4fo0WXrRWB+VjdXNid6u97p0Ly7TwHARB6QrohrB/JaFahWiTSM
         8GSAKqFQ6w/M/ebEuJhrlbvtedq4/fNFswfhOv68wfjDI87ILE24PEia+/B4PGQ4+Xc8
         Z5wq7j2ibDZ3ix74cUjN/76dCl27F5QPfazTVO4enH/xbPD6KVltQjcbeh2DGByr3ir4
         XvV8K2fAr5O8Fk+0WD3WoadQ95TH1/AF1LqlX/TZGlyzoO9vdgSWadc9eLSm2ABztnnh
         wOaw==
X-Forwarded-Encrypted: i=1; AJvYcCUIc/sCdwr5T9OIXu1LyGdCdqlV3njRX4Y3jxOE5gexdsxn0S2MKqkJOhQWoB45b6sAyaW8XFr2@vger.kernel.org
X-Gm-Message-State: AOJu0YxugggCyXGOfQt6E8ImUG8RasoiuSmnPUF/KUgCJMOqo+yehnLd
	J4bg7fasR/1bYn2A/F6ru1y+EZ2ZDIUuKV3e8p92h65uSAPORMMLD2woEwacBG0=
X-Gm-Gg: ASbGncsshg24K+HOIjInfACNRiqX3kL0JhKN+7s8/mTQZ4pS1oXE9iRUgv8WPdVVM1M
	aU4ygpLB2PotS4BS9tw3n2qJYz/raPkyuba4zvpdkYF+ifLLOPqhLeIeJzSUZUxDrUcd90wXEFj
	Bsu6awXKNe16itmDSSCBwc3iUWQS3SdsJlPLiPB+r8VSahP38FDDlUfYy9VXO0Kh65CZCutsYv7
	MmQeBJXyHJIzhA4f0XD6ZXanf4u0eeVeZzJg7vMfLKZovZSxqqOiWg+wpZfoZPn59nQiSvBx5HH
	GWZXEbVTzC+h4I7N7zoaUgLYcXK+3oxICly9gYA=
X-Google-Smtp-Source: AGHT+IEqK9fyjzJURoJ5YbmmoiOfm3vVGT7Kw5UjLLbl7399FqDUAYutZyQtGhwh0u3F71MjRojMPA==
X-Received: by 2002:a05:620a:44d3:b0:7c7:747f:89d0 with SMTP id af79cd13be357-7c918febeabmr911311385a.18.1744901612837;
        Thu, 17 Apr 2025 07:53:32 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a0dd06sm1184307985a.95.2025.04.17.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:53:32 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:53:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 04/28] mm: rename unlock_page_lruvec_irq and its
 variants
Message-ID: <20250417145331.GG780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-5-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-5-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:08AM +0800, Muchun Song wrote:
> It is inappropriate to use folio_lruvec_lock() variants in conjunction with
> unlock_page_lruvec() variants, as this involves the inconsistent operation of
> locking a folio while unlocking a page. To rectify this, the functions
> unlock_page_lruvec{_irq, _irqrestore} are renamed to lruvec_unlock{_irq,
> _irqrestore}.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

