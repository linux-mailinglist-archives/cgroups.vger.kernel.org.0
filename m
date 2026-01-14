Return-Path: <cgroups+bounces-13216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF636D20B08
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886EC3012BDC
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12ED32D7DE;
	Wed, 14 Jan 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nvRj6brp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390321FD4
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413429; cv=none; b=fRDYVkFZUF7BKxVkAgwYvnTwqp0KCTV/3xXTz8z+CdMyvD0SSN+zHzZf3TM8yMsd3sKBoZQxSQ5TFc4Vk0cScF5Z5Goc1FwoYUPa6ZJd041q+zSPkmmmDgcpHQrDu/IoF2uX7J0ae3bJ+dksfKEQ3DJ8lGdSwzx6aE3A+2mWYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413429; c=relaxed/simple;
	bh=bjd1DUxcQklTfNGtlesbWDnQFIa0ZVZlHa3RlKGWDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8TJX8kwI9KskXT71o/Yr51a9oA0XCUKTyJ3PKqqtRc4o2OdGs2NtOlrIvGE2BSahX6T9a89hCF4vrko8rgFH452F/8pkq51C5/Vvvzb0zDrgKlTNbJcjep26hJqNBYzcIgiZ2gP5HGBkwuNk1FH9hJG1Ssqrh0868O/BfRyQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nvRj6brp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a32bf0248so255876d6.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 09:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768413427; x=1769018227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1LfBQtSvV6SLM6qNtJr3uIJMakO8hJc3sz5OkZetqw=;
        b=nvRj6brpYyyaUXXWI3dr9oIMAOmOIqpFp/nzhwGd+CBtmgUa/UtXLaQ8j87vCHZV6b
         1I2vcdOd+LQhAUUHURxQj2VsCVR9D5psGFcjedHwdaDG8txA/87qtJiuCGpjJni56r6F
         bJQZmbbqku2YjPqBamqfDgdwx5Wdbgo7eVXfx62Pbh5grp5wJy6LHNhjLPn1buvoLqUP
         bxhrpg+MbiFpAWnagH2qU0UVjVhQ0Vb0AXGXSLYkWKGrQJBaZFhs3GcPlSHIAIE43kuQ
         PZxebz1ELYEMpYhbfawlNeLi42LVjS/53L8s6rG2p54otvHShuNnKOdcPobzd2IsNiUo
         n7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413427; x=1769018227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1LfBQtSvV6SLM6qNtJr3uIJMakO8hJc3sz5OkZetqw=;
        b=YZjmiySKOmXk55NWcRr7qTb2TOmfRRSZmEN5Xwk+wHzcymdwa+BxzCWmDX5RSV+Rm+
         cXg89cMUzywsiu6WKKAcrhNitd1RXRBVh75ZWVoePFhI1hn6nmJnUl7om+ESvbNo3UXI
         s3cnrEIj2FwbioN/o5Em3ZGCj0RCkm9bVuAVPN8wBDXk1i/736k27DFbarcvIfWdbAgW
         fOmMPCQ4TD8z61HxMWAXzaeAWg7SKUkPzZV+V059P76yeIDu20eF/T534ArKzwTP8AaA
         HtswILeTric+vOz3QEXby+YaFcyaeqHl2DabBazkqan2G5Y2TMc6cqQuplI6XdpivTEi
         fQhw==
X-Forwarded-Encrypted: i=1; AJvYcCXXP7OTbULpUbLIEFjCF1jG05Uu/b96JLV3Dh6demm79v+ORc3qvv8EYqa5dXaXf0SdFBfN9QOL@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+UJbz0wYjLeACwi7Nj0L2uK1JaUtIr2aVSjX0qoGpzHcCx/1
	zr4HtSqH9Zy6CQvWSFUaP2m+ssmxS2Mvd0tmDRVY4biaI3OZV7dsvMqdmpVSQILVpGE=
X-Gm-Gg: AY/fxX6vQB7V7cvgYdH90RziXc//Bb5qj8BOjq3p6ijLmS3Pw51CmAWRuPUEqoYg+8+
	LMbi0mBHFYF0IcQRmOQ8tjSDpga66Ouf2I1vR3pv+ld5jQ1l/tddrnUUKwH59CNl4UTjIX9znHP
	8iFviIVHln9eCxTWsC5LGdRHhklmRVxhZt2nZ1Jk+eAuq5Ca7wRpSKidK6r9qxuSRiDXWg5+UQp
	adoJIztlMKo+NZ31Rfk07Q4Df73e+sZCb4EjyfrcbpoMZlgvSJmvUpDXtjzlRag7WLaNvCOFAAe
	T+C1+IIEvU/OQBVZKNRdc+iuq7P+pfnZVCxSxoREILzVG30machE9qdB3vJNs0kGiPI5lffDWSj
	wTrTyQSeiiVMbnLusHLDC4SXa2pJGjPKJTMv3E3tvT1+p+s7EERip/Bl6OIdF6YN61OlIt6RPHM
	G26Ik6BiOOGQHVRcMovB2lfcc3WVXhqEFRmXjMMG2oEqAsKl2X2J/H3ulgU94Um/gxyicXBQ==
X-Received: by 2002:a05:6214:485:b0:890:808f:c26a with SMTP id 6a1803df08f44-89274371674mr44821006d6.30.1768413426930;
        Wed, 14 Jan 2026 09:57:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530a73499sm206213985a.3.2026.01.14.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:57:06 -0800 (PST)
Date: Wed, 14 Jan 2026 12:56:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nodemask: propagate boolean for nodes_and{,not}
Message-ID: <aWfY0T6Crf9lb5Yv@gourry-fedora-PF4VCD3F>
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114172217.861204-2-ynorov@nvidia.com>

On Wed, Jan 14, 2026 at 12:22:13PM -0500, Yury Norov wrote:
> Bitmap functions bitmap_and{,not} return boolean depending on emptiness
> of the result bitmap. The corresponding nodemask helpers ignore the
> returned value.
> 
> Propagate the underlying bitmaps result to nodemasks users, as it
> simplifies user code.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


