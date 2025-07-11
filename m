Return-Path: <cgroups+bounces-8708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFCB01D05
	for <lists+cgroups@lfdr.de>; Fri, 11 Jul 2025 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B868A17B0B1
	for <lists+cgroups@lfdr.de>; Fri, 11 Jul 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EFB2D0C8F;
	Fri, 11 Jul 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0FSEsNa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981727EC99
	for <cgroups@vger.kernel.org>; Fri, 11 Jul 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239450; cv=none; b=fDKJp627S/78UYa1P9uQTTQhybxfN7WpCOkB2ZNtypDtzPm3WONMBs6Cj1rxhFJLt9aZfpIHzfYLiTaMo/Dy/9jdeAiZQnxsgXsf7ZW9OPHhqNBTidFrs3ivz6tVK0jRgZ5t2gdljMma+y6MpFEerxWXDF1jyy86dEHPYWKcHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239450; c=relaxed/simple;
	bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqVgdEYrobKhgmrXYfyfJ3oK7PkYzY1c73dzYnrluV6OB7KhphFvoB/beEnxxtMP0/h0YSgIGeiUqwPyvtDLenBdDDzosMZa834g0cuRd6Yt1u9j9DfE5s5jqLdM6P2ABtdNeqNVwdHSfJhs8bVvhS6m424V3mQmQzmlZyTsOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0FSEsNa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d6ade159so16037365e9.1
        for <cgroups@vger.kernel.org>; Fri, 11 Jul 2025 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752239447; x=1752844247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
        b=A0FSEsNaEy4W9xAXt+1JP6DRy3As3ecGcfCwvqU1pasFOTXXPPpGespkTCjQSwMdeo
         rhIsF8XVZZJrs7+jjcqnTZwdRYZ5lTF0fwQTLyeiUYS3HKJnJWdjmZNI+dQcy2z8XVsj
         rZncVDnnCx72vxa37jGbESghg1xElgcvAzyPjjQailpWvGGlaape2uZl4uJAvrVcCdtQ
         t6CUVi2HBRJVTXeQDpdJlxEFF2UTkgetbImQbS44CKUTp/BZzo4kNvox66YRx1EnnSIW
         Dms4sRYCAfe+9ddJP2MFJGChwQWMzxL6b+Yn1AkGvvIryTerSRtZwImpUzM00sey9U90
         0ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239447; x=1752844247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
        b=SLR0MZ8bnyiL7B7sDMlUrQb45R6P6scP1Gd5c7ydUhiYGNLoUH5JI4VvU8dyL6Ik4a
         fE3VbLKkiOJOGK8uFZWDNsSKhjJ4pkGVo/sJETZ9d7RZD4IEDU7ma7Er4Q824peX2hvP
         y33t/vja2CuzR+RbwOw/dPHUrUs84b/0zLKklTFKGw60Q+sfXI8O3zLkVdur99+EFIH9
         ErNpQpJs3kcTKcbMxcFY7FkasWSD9JTXuYDoHqHtslRJLYhr6mtXJIwYHgTwshVGJaVl
         PLgICm4iNbsinWqqFZDwkcuo6Ymc6CrdoGYucj88zqJWW4DYVHbbitz4EEIIakapjDgB
         zbUw==
X-Gm-Message-State: AOJu0YxcVHLCF40iTVatXen+pVHn/yXPmEMnO49S+x6w/qkdMgPY9WLj
	9XWcIcaguSctvhYt2yQVTN6VAGNzvFf698HJ2ANFYjKVjkwED3VyYvj2556EH6iHuHg=
X-Gm-Gg: ASbGncvochIihqJhiL2qAK/fX/tGx3rILPHJuXAp2EMIOExmaS8jHegZf+CMUUQH55X
	4so+SLRGaXYGk+dSWzNIWj3XUFjI0+bajnY4e9MEuOf8cs5yQ0AFdnNzXObVsnbesuxRQV3Toyf
	JQYVcBeUuKzbpn48iHImYzRWjLIUx/TyncE3E5NhKuYqxGbuMjjE6CJHDtgEj4BRfU/NObFfGYp
	NwtHr+eAKITp6IAUl8XLbpLaYHJrxfQtuczrpZLo44hORY9ZeqrrZcOR9beOx5wUSi3mG51jEkZ
	8vzOfa8Kmumbo1EQlj5wLri8Aj3scuCUydkzcObX1nJGsRsnpFdeL4f5aj9KpMd2dN+x1ctwCd7
	ydug52aLLP86zllyqBNlpEv1s
X-Google-Smtp-Source: AGHT+IEP8mpu0Iuuf0a1ln8zktC/M79WYzkXuE4a7OZhLTCL2N1ClTroKbqdRnpP4IMAAWbs4Tnjuw==
X-Received: by 2002:a05:600c:3b9c:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-454ec13bf6amr28698115e9.4.1752239447146;
        Fri, 11 Jul 2025 06:10:47 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd47528fsm46969975e9.13.2025.07.11.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:10:46 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:10:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Ridong <chenridong@huawei.com>, 1108294@bugs.debian.org
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>

Hello Ben.

On Wed, Jul 09, 2025 at 08:22:09PM +0200, Ben Hutchings <ben@decadent.org.uk> wrote:
> Would you consider reverting this change for the sake of compatibility?

As you write, it's not fatally broken and it may be "just" an issue of
container images that got no fresh rebuild. (And I think it should be
generally discouraged running containers with stale deps in them.)

The original patch would mainly serve legacy userspace (host) setups on
top of contemporary kernel (besides API purity reasons). Admittedly,
these should be rare and eventually extinct in contrast with your
example where it's a containerized userspace (which typically could do
no cgroup setup) that may still have some user demand.

So, I'd be more confident with the revert if such an adjustment was
carried downstream by some distro and proven its viability first. Do you
know of any in the wild?

I appreciate your report,
Michal

