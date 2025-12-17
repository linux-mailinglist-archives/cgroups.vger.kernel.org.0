Return-Path: <cgroups+bounces-12458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A9CC9B70
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DCE2300D020
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291A313292;
	Wed, 17 Dec 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Xegrnsra"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C993128DC
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010661; cv=none; b=JgR2+JhDvcpYKvlAgcSx5myuzxQObd8q8XYrDSUSB6fMZZ36QtB96jQeeBpbsq0UBZ6OfV4ucgINt7I4lkgCkBlRw/naEZYX5cGxbwngiHHzIY09wrc8hYpoBziOal2GReOwByQPPPzzGqjEhzwq5c57Hs+J+W47cyhZmlHsFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010661; c=relaxed/simple;
	bh=bEAIDLIFBMAsViOKX/fAZKIXIXjPLidUeI/NDp3Vpew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgsdH4STJJChCVO+dRkegemFxEM/NkRXYG4ETY9VSX2vKqP4GxsC6hJubxVJ6uRaD4DxPyWRjGi3140qa3fj5WUmU4nRD+0Um5Dp6/z5zYmhzdqwjo4Yxb+cSKFgcW5ePiPtksCNtzM0feDTlcaqEX/8NJwiiGyMXxH/00Lfjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Xegrnsra; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a32bf0248so172766d6.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010658; x=1766615458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jN/djI7PKvnyyAXbKKGr0jMJdVuI4zAsGj0vnDi1JaA=;
        b=XegrnsraHTxH7g05OwVuBLeJFS4wIrFb/hYOCchUmr39uochWF9cesAkFdorr+xnoO
         VJCl6NrdC7fq7/apahpZOpfn/pWbovTMq8KO0ebq4UUzB0sCjoJ1WSfANOvV8Kk81Va6
         lGYaGS4pKRg6Y38kIm/3ougzdLFGuEgAONB5HR5ZSomJ5185g5xXt2XKJgTY8dPf4Lz1
         zBAYmkVUzVYP9o1laKnEKlA4o7Y3i3WYti2ThEHcR6jnWI3Y9FipAGcU9D0cFn0QkVSn
         6EIR0ybkoKAaMK5UGpyrfxGWxqCJvQXbaO/i3r6yyHyzTX6eQUiyhV28dkOeauCzlMNm
         BXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010658; x=1766615458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN/djI7PKvnyyAXbKKGr0jMJdVuI4zAsGj0vnDi1JaA=;
        b=VCzNggE/VjZkQEHQxrF35fF3dvsuq8fygmIK3Hey3PbYcVy8W2dxf2dxbCm2+mh33i
         JXCM4JGmI4X12LMZ1Xb2YhKy3eaK//EPoCzv0DSquB3SMZUCvv/hLcAxAhx0bAJheC3Y
         S/OFK+bAO2dZrmKIXxupvgdbpiU08JdVNbwGy5Bt1rKatZ4ce/P+bFVCm+aXNaXPVEAd
         1K6eurR2BtdEtq51UVB5gR1gNdr0lVobTmnfJ9Q4bOoK1dMHZGgW0ItK40KEv2QL/LMK
         QZMVIebgKKK9KLE2YU7eJNEUYXGaO4c+9QqqQ+Q63YxlppAi3RfE2pcjqOTWTf7VDXYb
         bwsA==
X-Forwarded-Encrypted: i=1; AJvYcCUTA7IvBdXOMBHzXxOpOYK7SH6AIIkCOt0Xy4vzl+0bzkZI8UY93VLIHIirKZf9xagxRP6k3tpO@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcu7WSVib8XNfA3g2KZZPaE2vQd0O9P0zV8K68Hxx7JNMtz8p
	BkoC/lDPZkrUDm6UyHiWI3i6vxK81sNvq4a8bi0KQafdUB4IcZSkXzLhC9dA1enNge8=
X-Gm-Gg: AY/fxX6b5JvdGIZ/7DNl8J0BLrUvHBaRkN4mNS4gBlbxYkt2mqz6Emug7Wq1WZ+epse
	pLjDUES7FDK3en7CyVhkOViHu3cwzO4Mqn1wfXTIf9jNWIzGWoa0/oomB1eSkYzzVJPPcYCbi8O
	bofrWOXDZ3wQuxOmce4/4ujUSO6xoOejgHPHYfGDO/5CknQh0RCo0hy2An5dHIuiOfyPb5sFYqM
	pCuN508gy16Ej4r9MWqassPePtv1gK5Tch9CSAoL6uW6Vh7MPvQ3REL6uAVO0kWbOMmc+LPOxhD
	zIrp6ny1v16vSta1a+yL0+OQSE1sGccyDQMDteXnR0z5wtAjnapxX5klzSrW0qr0mcS2TUJWq7w
	HZmuSByPoDYGW4nuHsE1DL1obvScrhPRPW2jBOHfr5Qw7O7XkzDgTKRjab0gEkv1gg0BR8tglow
	nXZ1Adxqj9sngzt5Rz6pvi
X-Google-Smtp-Source: AGHT+IEM1wpyl7hzMfn/vufMseel5JojAcvDcHhdXICuQpH+dbIyJ3X9YcY+bavocYvdz16v3ln15w==
X-Received: by 2002:a05:6214:568e:b0:880:5851:3c5a with SMTP id 6a1803df08f44-8887e44e9d4mr292735096d6.31.1766010657686;
        Wed, 17 Dec 2025 14:30:57 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5db7ab76sm4653466d6.7.2025.12.17.14.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:30:57 -0800 (PST)
Date: Wed, 17 Dec 2025 17:30:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 19/28] mm: workingset: prevent lruvec release in
 workingset_refault()
Message-ID: <aUMvIDRJegSVSicB@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1b6ad26b5199b8134de37506b669ad4e3c0b6356.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6ad26b5199b8134de37506b669ad4e3c0b6356.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:43PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in workingset_refault().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/workingset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 445fc634196d8..427ca1a5625e8 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -560,11 +560,12 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	 * locked to guarantee folio_memcg() stability throughout.
>  	 */
>  	nr = folio_nr_pages(folio);
> +	rcu_read_lock();
>  	lruvec = folio_lruvec(folio);
>  	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>  
>  	if (!workingset_test_recent(shadow, file, &workingset, true))

This might sleep. You have to get a reference here and unlock RCU.

