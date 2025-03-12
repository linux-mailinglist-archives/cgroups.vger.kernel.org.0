Return-Path: <cgroups+bounces-7004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A32A5D6AB
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 07:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23318189C549
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BB1E7C08;
	Wed, 12 Mar 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfdx6bEW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D011E5B6F
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762556; cv=none; b=ao3K0ngRogOexHYqZVvFhF69Ui0R8nHsLiYXrm7ILj19jdJO2TM/L8tk1LX1PDf28G5EEW0dGsbchJniggG2YcDJUDlRS1Mlu76jHOi0MD0/r5RD1ZXYLmvYNoF0ZxQXPVmrEDRfoPZik1F6N2HzsAcyKWawxEnNenCHPQCVsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762556; c=relaxed/simple;
	bh=mmZWO8rrKBhcxVobJcb1/dMSVYN+sIlK9Rb8Ecs/XBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3qr4Su+j3jZudVxEq4H6/Iu51fTxH2K+1mnObu0Ljvbs9awR95CN95vj1wMVguk36TG6X0cbbKsG6Gqku8Yao+7BfC9Bwr8XYTQvoBUf3PIcZn1t2se129E6bS4DZR522hUrruprX7arX+5SfGuVUHdjs3cutdmPcRxj89qaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfdx6bEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
	b=cfdx6bEWMVEBpVOc4NpurOqLnfNg7n19bwbGRKkrpjDH3074vULp6OLn9vhJvRZTdQF7fl
	mO7/bMTDhImiG0F/D1FmhnuqKs9xOQfh/Ahzlzz4mZrcABORLGW3ZOdNYhAPreSWijm4Ye
	mMia4Ypnq01hUkZw4t1tMk3xE5cCZWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-liyhu-PKMoe6rKfIwIZluQ-1; Wed, 12 Mar 2025 02:55:52 -0400
X-MC-Unique: liyhu-PKMoe6rKfIwIZluQ-1
X-Mimecast-MFC-AGG-ID: liyhu-PKMoe6rKfIwIZluQ_1741762551
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so26230965e9.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 23:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762551; x=1742367351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
        b=UwnLc7AAu8A4JDDv8DC3uTzDGKJlV3oYlgHuMmjRLP7HFBSMZkbK2EmWisT9CZ14NX
         sBHOxsBtwxo5OU00iOVXojDtvAzniMFY68MHvPti6YqRDeEb1AEs65Bqh8VGZxic56Ym
         r0HeW5LY9nNSezR3CM77p4ppjWtqSEtDcb0WnfDL+o6GoGITHFEygTQhe1C2iDI/cydk
         qPsUWomNJiz0kDgtdXq4SorraRLXUTMFYuXHE+y73KpULCYuRHJRLy5TAuYCRD61h30/
         HuVOPyvhx1YbU3ND/YOj6igoT0Eza8I+GGEahsKvVBY7lKDtL5kv38zan8Yt81jUXqoX
         XDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE5xvEjbEs+n0hIiTGn00FRbl5YhuoaevgfR/WHFOZAiKMHYaYyd5b8hb2NT28qNshlFMtTiOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxNK9WFuJEbDP8H0ffkTUr+IdPF8F6UOPLXrkHj/3+HXH0Rh04K
	UgiO6ZmvqzmU3XR6yGpiPt22nJci1B3HtCOEIqeuElAegvA+ywpGwntwh6DqscEmEiGqhHAFSmG
	O59V/pUCpR/uuemtGH6fyfwIuiwhcnk/y+Rw1Z2lQ2zhygYnWBFf8byI=
X-Gm-Gg: ASbGncswY8/3N1SxQQb3f48kDDGVzTuFK3hYWSkV/MXtjed4e9TB5b7dGgdSuY3uG/Q
	uzajTTOYlP965nJMfvlBN17D8ExSpEdUgjQ1qsslhKSqFy9UmVTLcNRw5b7r9LQr+vzJ4Q6DAn/
	GOZnQYHvicia6eiJJ4AqsBCZG9p62i9sTJDoBNwwtdyjwAIeV+jqxLGI2L9LLKYMhh8AtoI96Oe
	2rLCZk14QvNHEsoDovHPY8pkZaGXgaIr7n6ax0S9lttVTW1MMWuW3MWb/t/Nv4dpTXDtTi+VM0E
	s4VMV6eHyw==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005815f8f.5.1741762551545;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDerobH2f/muGrjnyAjilHqba0+0kowFg3s8AIPcyJb001SG0K4ObuoiA+X/VxHvC5d0rDfQ==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005774f8f.5.1741762551189;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394a8a5a304sm565705f8f.40.2025.03.11.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:55:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 2/5] virtio_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025331-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-3-npache@redhat.com>

On Tue, Mar 11, 2025 at 06:06:57PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the virtio balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 89da052f4f68..406414dbb477 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -274,6 +274,8 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			VIRTIO_BALLOON_PAGES_PER_PAGE);
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, -1);


This means the counter is in virtio balloon page units, which
runs counter to the declared goal of making the interface
hypervisor-agnostic.


> @@ -324,6 +326,8 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-VIRTIO_BALLOON_PAGES_PER_PAGE);


Same.

Thanks,

>  	}
>  
>  	num_freed_pages = vb->num_pfns;
> -- 
> 2.48.1


