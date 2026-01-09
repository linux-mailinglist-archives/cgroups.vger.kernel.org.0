Return-Path: <cgroups+bounces-13018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B0D0B87E
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D9B30F4377
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F953659F9;
	Fri,  9 Jan 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ceboVegt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A625364EB6
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978233; cv=none; b=WS7R31kIBDoDSCRuORmxucGZUBlOUqJQJkh2RgBJIK2wRqIkIplxRMfMaj4Q0yWqYRPLRV78bOVQdU+PWXIlbxMGrSoHv8bdOLqnvoEhp5CvRd9CYXC+SIBcV7rCLRHbXrxBQTCKnLKCqAVXc1FTFLSQztF1LxhvKnws6cFQMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978233; c=relaxed/simple;
	bh=aXxH8KsFvCOcvxGrWrHWB8GtMC6vSUV/Y2dfp44NGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyNNr1vyTxI3zmJsT+l8eig3CdBoyMX1KYVzqFK/PaTtwLaYZ9SQifVBxeD8+ItFBy6/0rTkVttmS02Y297S7rk9U8YtE+LSmqq6ucHX1rRaEa3IzCXIgru0+EWXOz2yFcGogSWJJxaVASa8h2eBg4ILPv0CQSqQLH33VEx8Qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ceboVegt; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-790992528f6so42007097b3.1
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767978230; x=1768583030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=ceboVegtXCbOvmnNp2QmNW0oW6yOL+fOvMlu7QSUb5OKOXsY4gmoTlqnOdcyGyFOh3
         ljn1LyUtiDHlU3YI87wJgJxraydAh3esLo6vpHOxwYpSYVZ59YcaeAAivzmoGdCcAe/H
         SWqg6sHST3ebJsJblSLiodDIwpcJpflVJLh3gSPSYqqN5y0bYx6WJKiRCWe3F3vxkZi0
         yJeoThQxo+ls5W5NZtwM+I/2nurnTsH+UzRVh7fV9fFvxbBuvFmhu6eWvQNmi8ShWRBJ
         UEW5EHDLVmLx/QXv1eP1ru87TF7xf2jfQJzsUb9jNt/sbJvG1ZS3TcGr5XEHlqieR56t
         C9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978230; x=1768583030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=Snod+DZ4R/cFoH7BCBxlpTXRjnEnk0+V1FJpASu837amaGiG9hh0JF3AREZ3MMBVpH
         zM1oq04p9WIOlpsHmjNtlIEMgnpxHxQu0Nm5wfpeoMq06i4dhUSo1C1aRQC6O3WAlvsF
         ak8bXWXRUN/OecHaPSiiUkpsMKyHvBWmdlWj/T6zG10g4T1Mw+YxYcix8ug0fH1nBE+z
         vBQiYrM4IquoHmRqbHvlAt54l3vIM5mhD3TmLNnS8jeIhNI0Js4V3L+LT1buVifaGmrk
         7rr95+3Pk+CGID0Eoxjry5O+aUWcCKycBvOXSHzO6FTlPRhKhkEjXxiKxd37YwHEPrTi
         PVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCx3MSfXX1tJ8YLDx2+ac5+Kx6sn1wrp4QCnwNsn7cR8SCn+3TNZFfUFXpbTXRnmjBVqTGzZ6h@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOb6AhApvir70Tq4WWw5YSUPqd78xQ3LvoQMT0+8G3ttIylmA
	T+1JZRtyHbXt1iOg7WW5eZj1ncs+n5E4HjQemf9WtWx5oCdlkA6oBZaVaH2sqdeRKcA=
X-Gm-Gg: AY/fxX6s4mq0laJEpSb8szV9RdO8XwNQHBvVccxAK3Evj9j3ZwiDw52AbH8WVjCdM5f
	lleT4wD4AO/IT5alVJ34PFCLUvNio3AQyFDuM3tHadGL5ciBhpJK6zQ1H/Wmj7gaUn7Tn2MoXbn
	vBZXCJCsP9pwMZQt5s7RhiKS24NinioRP50of5iDYn+FWhLYiEzOU2L/qiTHJmIHDVGjcGV2AcY
	rd7LX1jRe4r3CrYDIZiIbfihDSn1OKj/hm/AZI5Tk3j9C7HkOt8motCkorS/UgGNF1Psdp9eBqu
	A35gRaP++urD5f21kBSq8e9UIcJvpiFTvvPiwiNDbRD5iYaU42Kz2JkWw4jHkHV3QX7ob1DNgtv
	k7AGQcT3W9pmJvGTIInUwUtXDedRbL4IK7nWhiqwcO3L6R1UDcsO+NJ/B/Dk0dolSsqkuWHBfpf
	/jcWlderrzm3x3DZeKkJHmPr8OHa38HOl4Uj/sfq6ZHquEHQSGKLqWntQN7WdWHkTjfycGMw==
X-Google-Smtp-Source: AGHT+IG5ur4wn6WRv+wDPnOobb9XgNDN4tAmFs6v5FHNYg3NZYd4D74cNfEP3p2oKp1wSQ0Qs+dvkA==
X-Received: by 2002:a05:690e:4106:b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-64716ba363dmr7881450d50.36.1767978229938;
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907710632asm77625366d6.24.2026.01.09.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Date: Fri, 9 Jan 2026 12:03:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWE00tFHjyXnNmtD@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>

On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > If a private zswap-node is available, skip the entire software
> > compression process and memcpy directly to a compressed memory
> > folio, and store the newly allocated compressed memory page as
> > the zswap entry->handle.
> > 
> > On decompress we do the opposite: copy directly from the stored
> > page to the destination, and free the compressed memory page.
> > 
> > The driver callback is responsible for preventing run-away
> > compression ratio failures by checking that the allocated page is
> > safe to use (i.e. a compression ratio limit hasn't been crossed).
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Hi Gregory,
> 
> Thanks for sending this, I have a lot of questions/comments below, but
> from a high-level I am trying to understand the benefit of using a
> compressed node for zswap rather than as a second tier.
>

Don't think to hard about it - this is a stepping stone until we figure
out the cram.c usage pattern.

unrestricted write access to compress-ram a reliability issue, so:
  - zswap restricts both read and write.
  - a cram.c service would restrict write but leave pages mapped read

Have to step away, will come back to the rest of feedback a bit latter,
thank you for the review.

~Gregory

