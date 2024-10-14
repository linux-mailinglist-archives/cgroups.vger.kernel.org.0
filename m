Return-Path: <cgroups+bounces-5114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9C99CAE0
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455F21C21B90
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BC1A76C4;
	Mon, 14 Oct 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UusVW0Jm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58616190B
	for <cgroups@vger.kernel.org>; Mon, 14 Oct 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910841; cv=none; b=sW1RutUZNZ6w3a+G9mVdPxqe3ieq60tONaZGM8tOjA3OQGgf5w+6G8Eu++h/1twr1xsr9A99szN3oY5Pp1IY0KRDCUaSITn0q1f2LcUuLH1fTdkBBZTU6ylNqYVKDRhY+vzfRtbl9mft0mJwTcb8d+H9e7rUWobwKp9g741i9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910841; c=relaxed/simple;
	bh=FF2RSxljEXLgy/Y1MMjK+7zYN3e31dBSTEd2m9uLVpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biyxqJDb3yhJ/rNnraisK3kboXnpzNY3/jfqXQWxBhk9ZO0fC6B6Mt2jdpDnYVBo2nmA4ixP+HenOzngg6C+YGkUmRke00QbEl5m/AxenXw0yBx1IcZqqND8w8HIm0ozwK9Id+Sm4+W/nirzPsga7xpYjpaOMS9Ps0i64VOClu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UusVW0Jm; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5c00c5889so2147891b6e.0
        for <cgroups@vger.kernel.org>; Mon, 14 Oct 2024 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728910839; x=1729515639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcEOyQjDS7a6A9bsQE6vr5VWzjSUJouS2AgRnzgA9wE=;
        b=UusVW0Jm8w8pAtRe7mUvpta5wzFShyjlJTge8LgISUrKDcO9maCkbrCgBRDnGQToV7
         DkK0Y9bvc9aoAD1tqKigE3MSPUQNjGuXYNjfobMJ+2HMF/CzGPDUanBtWdakzgUvKSyC
         6kIK1rrmCvnj9vW4eqIJe9NO3yX4PWhKv+U59eJvp1uAA3L+zdsJvDysNZDG3zYe7T0l
         gFQn1z7TyhJSBfI6UFm/PQMMQ37N/g+sDaZsOgk5BwhvvgEeOMi/oRTy5sUB+QwZYTuE
         pNaZ67rGXgN13dUtm3n1It5D8keh99Dub2kZ1FRCmvJ/U/1XUKpu/L7ih3WWFd0rOkIG
         jFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910839; x=1729515639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcEOyQjDS7a6A9bsQE6vr5VWzjSUJouS2AgRnzgA9wE=;
        b=Q9HAGvtOdrCIdwYFTUTdslPKbpjjqn4/lQzi4sa4HcLbL5SgYawnZaCVIw88WXQ8WU
         v9+850QXfwHDPdhQXlDJ3FcdqFo+XckzSdZok4HCYZgU8lSf5dkj7Ohjkj3wOWQrXDhP
         uqCXa+13GRCkViMPvZv8ZMzWp5vuw+P7cRNmi6Bqc9t5x7mi0pcBL06f7u2jDyUaLRyg
         +IOcFHgKO7+y1IkMmX32tebMvQWEZt5SOwsIVYORLjazEOYXHC0Xwb7ChteoMZoIq2WK
         KT91SD7/+HVXFXUUG4mC/F6By5zRTJ+Zy0kRFp/asEkNIw2pdMWiC/lt3oVBMk0lhZg1
         fMZA==
X-Forwarded-Encrypted: i=1; AJvYcCXqyieOj3eSIJ8Fn6zZcal7JyVMCkapHUJRNx6kq3XyglnKMXs8EnS2e1TcVdYP4rjTRE5l9GnC@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp9XtUODW/PpXFnqgVBRKgxtj+wNecClOKw1RcnA1li7Fo8Lo
	Z3G4Ij1JYWnUx6ZI+iMLjChxYuWg7tMrbnc9EShJfQEBbohMJNX9cmqlvLjmre9WVxnqsPAe4fe
	B
X-Google-Smtp-Source: AGHT+IGls0KX1bRa/5udb60IOUG7S3+RObbDPF9EP/nc4moCuctIsvmDxZp8/MHeexJO2YJQ3fajDQ==
X-Received: by 2002:a05:6214:300a:b0:6cb:55e4:54d5 with SMTP id 6a1803df08f44-6cbe5239cc6mr302364356d6.10.1728910819640;
        Mon, 14 Oct 2024 06:00:19 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d49sm44835096d6.29.2024.10.14.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:00:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:00:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Michal Hocko <mhocko@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <20241014130017.GA1021@cmpxchg.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-3-ryan.roberts@arm.com>

On Mon, Oct 14, 2024 at 11:58:10AM +0100, Ryan Roberts wrote:
> Previously the seq_buf used for accumulating the memory.stat output was
> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> If 4K is enough on a 4K page system, then it should also be enough on a
> 64K page system, so we can save 60K om the static buffer used in
> mem_cgroup_print_oom_meminfo(). Let's make it so.
> 
> This also has the beneficial side effect of removing a place in the code
> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> quest towards supporting boot-time page size selection.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

