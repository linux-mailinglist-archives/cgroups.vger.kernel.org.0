Return-Path: <cgroups+bounces-5151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C19A221E
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 14:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AC11C24771
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727431DD0E0;
	Thu, 17 Oct 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfuWY1fx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8881DCB3F
	for <cgroups@vger.kernel.org>; Thu, 17 Oct 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167692; cv=none; b=NoPGbgH7WA/+zL3rSeTfwrnRAAceL9KaXFAic+XnEp54lTRu32ZLpO43wn2G+VheexYiWl7UH0loNwDuUW4haXaB1sCYfH26Y/buC6epI+sMyI4Fb3JjeVdN2vgFB1A2bxnlBBiHNni0RaJmL4OQrfslioLAOOBaj+mXbzFkdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167692; c=relaxed/simple;
	bh=dZiXlD5sbB2j6jzh26ifCQe+UHqF9fZSmuz2zam6EZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzvCTXAMY98bTm/J46oKQvpR8BCRD4WvKOoNwL1Vn/HhA9LGlxMKf7TUBY1UPU9COJSi9mVpaHsRdtwbxwVQ/NQQJgrLJpJXb2OoU37jlc3wKFOo73U0kRi+F2LPclI6H/PBwZqR2IkrRuEVZ7Dq3s8gTgH9SRr93unIf6v1V7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfuWY1fx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso1030937a12.3
        for <cgroups@vger.kernel.org>; Thu, 17 Oct 2024 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729167686; x=1729772486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upV9IxmbyLh24y5KvmoZk8IuzsVT/v4PISDDNTLkG6M=;
        b=OfuWY1fxb7KBr/PsajSOdYJSb2WYTVh4Bk+hg+/Dw70NMkYlSZ81jCaC/SoVhumcQ4
         cSe/kOkWUkBbgf61Q/LAbRQeLzBJ1Z8fr5uyoUG5oKqBaDza6UVDR4EMKrDQimGG1wOE
         a7prgsmTAy3wua8BQ8HlQfMBH4nSPayaEXt3hgfoRcqAtjcWtiKvu3rOGWmDTgk3RkTx
         0405CPDrKuOyuNd+zKvKEMykc3K5F3LlFp1Tf5uwwngNFxEqBioPVR0f8T0gauH7sOx+
         2nfzOs9U/SiBR1UFTofM3XDZ5CXx7H74fN5RkwR0Rjo+CuPWvEiEc6SlGkZ7KVTV+oPZ
         D+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729167686; x=1729772486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upV9IxmbyLh24y5KvmoZk8IuzsVT/v4PISDDNTLkG6M=;
        b=GmMsj7pcubohlKUAT9VgeGxQXPWlvJS97oPcOgO6odKXunYBYUYWdxXecy5DtenN3S
         CN9DFzjY6llJ6tSejR7u1uscq5uIDb1g5ji+claHPXy5iAXw4BrWsnPfylaytOR2O4dQ
         zaP6bExvtj+W9deMK5v4o1D5ViAJmXfBw1wYudq278DqQtGD4tXE5wOcdH0xTKakGurR
         aryNuNDENMryy/RGETXDGVDqh5OdbqTfLxdY2nZ6n+5QfKCFRxMBh8ioEvJzCJdc1jPV
         bjsKOAZE+1WGUpOeRoGT6Fqop+4Lv7jdfibDztuyRL5IFy7/xI0cDnatRRGFr9Tt3QG+
         7Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCUIEQ26E+6f8+hCR4tW3Aci8JLc9Ts4EoABAVq8r3Bv8IhNXD8uIJezAbO1n4qEABea5m6Eqs1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Q0p0aq4T1F50l8zCmPx7McTfrticbO0MvcFIkLn52cH/A0/b
	DoHk2Nw+DRvg5TLlzqy6CVPANKuFLr8Uq8h41ODW4ZOZKjClfWHOljkjwqB3aCY=
X-Google-Smtp-Source: AGHT+IGq5ucbFHU1tVBUcI+q8DDYTzRsfdUSa7DEcY8Ig4Lc722w45PjwM12vp8ybtkKQFy10/mN6g==
X-Received: by 2002:a05:6402:13cd:b0:5c9:3fe:c7b9 with SMTP id 4fb4d7f45d1cf-5c994e6dfd2mr5839341a12.0.1729167686207;
        Thu, 17 Oct 2024 05:21:26 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d5077e6sm2733482a12.48.2024.10.17.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:21:25 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:21:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <ZxEBRd0jEtVEGWki@tiehlicka>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
 <ghebtxz4xazx57nnujk6dw2qmskyc5fffaxuqk2oip7k2w2wuf@grnsquoevact>
 <315d4258-ea96-4008-8781-9205f41cec6c@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315d4258-ea96-4008-8781-9205f41cec6c@arm.com>

On Tue 15-10-24 11:55:26, Ryan Roberts wrote:
> On 14/10/2024 20:59, Shakeel Butt wrote:
> > On Mon, Oct 14, 2024 at 11:58:10AM GMT, Ryan Roberts wrote:
> >> Previously the seq_buf used for accumulating the memory.stat output was
> >> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> >> If 4K is enough on a 4K page system, then it should also be enough on a
> >> 64K page system, so we can save 60K om the static buffer used in
> >> mem_cgroup_print_oom_meminfo(). Let's make it so.
> >>
> >> This also has the beneficial side effect of removing a place in the code
> >> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> >> quest towards supporting boot-time page size selection.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > 
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks Shakeel and Johannes, for the acks. Given this patch is totally
> independent, I'll plan to resubmit it on its own and hopefully we can get it in
> independently of the rest of the series.

Yes, this makes sense independent on the whole series. 

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs

