Return-Path: <cgroups+bounces-7032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF12A5ECD1
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 08:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B64179755
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191D1FC7FD;
	Thu, 13 Mar 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqJo5nOP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619881FC0F0
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850450; cv=none; b=Dc4rH5zTwAUK2jjY1SDLra1ll0pclUNwbt3VBy5h/jGevTHVBAqjQtZfkk6bRv4fR/m3+qywuLjssLdfmGK/bLak1uR6t8e/AerN9dXiz1EbwY2M0UX+dyOzlrFgDFdEyq41Bv9AIkjK+ltsqmQNFxgrhPhyHuou2mecm4H8OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850450; c=relaxed/simple;
	bh=KtmKrH0Gsv0sBFL6B7nZq6RHI/4HDfiECApPAP1vOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5u0mf9+UjW/PraN2+rj+K9Lr6qRs3OTiZIUbVxBcbukCtq9zejBUh9IDIPROuBSSw58EWDTbZeoflSjGdOIzkWAlfCTZZscJAjjw685JGzhAV4slS8k7CGiZt1W/rLy6L46u2geoW3wgw7O9P+ZYNyQJMX+xVGMTTP0Jk36Djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqJo5nOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741850447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
	b=FqJo5nOPWDZvXMnUaMq8yz7DAur3XgvRRlldH1KzVjncJ0fRNlVzjqNZFuXxvAjubh5CLt
	5jKxjXawWTfdH8AWnvBzqXRPxrEq0ySpYNjo+t4cSIWfVKj7VHmk6qIelpyJAHuOg2rHkT
	6r9zYLj7QvIxHGSArTietsOR7zVC46A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-tkETjyI0PL6QMNGVX7VZhg-1; Thu, 13 Mar 2025 03:20:45 -0400
X-MC-Unique: tkETjyI0PL6QMNGVX7VZhg-1
X-Mimecast-MFC-AGG-ID: tkETjyI0PL6QMNGVX7VZhg_1741850444
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d08915f61so2681785e9.2
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 00:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850444; x=1742455244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
        b=NlIZx2iin9WkyLOau+1Xqkig92706ZyhZiKcHLzdLlsJGsSGa014QcKxh8BKOxVA5z
         G0fCTrQzzRe151XqHZ3SZ26h3iQukS/sWbNr0H2AhOS3HnfW5im6OvTwnd+Gd+UNqvdy
         JEoLdGhrfNqaSnNF8MTdG8Cwkeq7g6+IT96yzdFVCuIWHFCUZgoq1aF9W7sODmnGw3QV
         auSqucfpeoj1ElY8vJVhgF93QInWnyIw50S8PBkrcWtEVwzEE853xyDDBgJm/7IMbUWs
         2W4uhaCe+KThlVNr1wwnB3K2wDxGOOFHsd027TO5n97KVlgOoYNf2evwkX8ZxMmtmb3o
         lVJA==
X-Forwarded-Encrypted: i=1; AJvYcCWhPARRxkHKfTYG9SuOlE3mtE3jDhx4EEUukirrblSId1mcin5ZJG6qhAiOsEXT7RmgI6ruJrzY@vger.kernel.org
X-Gm-Message-State: AOJu0YwDI+wnPHx9F+svPF7gEGjUstoX+K/dg/S/fz78+JAuS6ih6ul8
	5ZUgwo4DajRvqt5pP7wLPuPhGU6CRR4qWT+6hMn3LPg5OhW6PXlur+rE/067z4QFGxvsf7yg3wX
	cRiBhVUeoTXZkNYBqY4Zqm+rX4CuLiYOBFa6G8pB6eVrC1SPT6jD8Ob0=
X-Gm-Gg: ASbGncuJyogKky1aabGV45hFAqK/60zhDsDQ17/xKyRtm+7i7M12uMEIRHYAynnNgfQ
	6OspTLodoUNbVRig/DO+aTIYPr300H/CetYvY8F/r8T3ohEjCT02zPoIeJBAV4+jzd7nJnauWm7
	zYxsXhy7YIhNdT6JWUQgy5q7PVVg4xImzi1jfz8qbF/LyyZLM/wk9abCK9HEwCWislWm6Z6bLPA
	jC+Q+MEJxr6kGaeNpgBcr3ZptWNlu52xdkjMOXbfIUE29g0GFxt870BPywC0SaRBq1KZuQjap6m
	FqLXKPg9Yw==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228439f8f.54.1741850444451;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSno6hSKVsk5d06B4EsgagrhEFS5vVdfXL2wu7cQUeZCwJ3oOQpqMw11c+iVNeKk+NLYSpA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228411f8f.54.1741850444109;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2af42sm10316185e9.32.2025.03.13.00.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:20:43 -0700 (PDT)
Date: Thu, 13 Mar 2025 03:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Message-ID: <20250313032001-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>

On Wed, Mar 12, 2025 at 11:19:06PM +0100, David Hildenbrand wrote:
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> > expose it through /proc/meminfo and other memory reporting interfaces.
> 
> In balloon_page_enqueue_one(), we perform a
> 
> __count_vm_event(BALLOON_INFLATE)
> 
> and in balloon_page_list_dequeue
> 
> __count_vm_event(BALLOON_DEFLATE);
> 
> 
> Should we maybe simply do the per-node accounting similarly there?


BTW should virtio mem be tied into this too, in some way? or is it too
different?

> -- 
> Cheers,
> 
> David / dhildenb


