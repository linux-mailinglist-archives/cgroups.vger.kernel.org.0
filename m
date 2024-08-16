Return-Path: <cgroups+bounces-4321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790A1954297
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A85F28F6CC
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A212CD96;
	Fri, 16 Aug 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RgJlKmQ5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BB7DA96
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792804; cv=none; b=cG/8lajhVe59t/YXAs2dUX+tTKGzHOX3EnD8qK3d8uDXO2ubiPBXlnmcpnyxTN+TxtRcN2m+Xvn41NWRUrMLdYV36C8cUXp/WmAlGLS7xbsuycf0GJ4gF7rvXkxpOCND0IzbF7iQCsBL++M+jEBAjKtlNRF5P84p345i9B8pGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792804; c=relaxed/simple;
	bh=VEqTAJPgsNARp2Du6ejO+UCli3M4KHViVW7AcfPGMCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG6oF/6ny3SL8u0+gov42NjHn0FmjAvrrVIYeNUq7PrGtmBHnDadHgVQfGY8o4fj1x2820Lr7XIM3QLlLqyAnOLuNovtA0KWk8vbW9CnAC+Zk6xAw+qY5ICBgl8Ro2zumAi5BfKDQ9E0JDmtUwXqt/h3kAxz0tV+b7A4nb50Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RgJlKmQ5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42812945633so12990205e9.0
        for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723792800; x=1724397600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qwLWNfklFp9yOWm7oGFyBx/KIEHr2G+mY1Na9aaN9U=;
        b=RgJlKmQ5uR3R04amZbLqw9OXAmmEwdgXDQKvmR1RMnKSH0+abeZnMa1KCRQ615YWBh
         Njlml3hVVBMdFvRLSAlRJUA64ahVPwmgJxT9LK/Qgn/e6Pmr6wnqxWfK8yvCVAcb0KSX
         GrLsaayNr4sx3oLnnTnWZNjd8KnagQ8RuXE6UZomgdyiutM70hLI7ZOuEgq6QBaRo2TY
         gi9PKzPw5ABJx2hnxKSFq/fzr90jYSJJwd5TI6B0hB8tyVTy/KXS3iEOa6F2hl21z8mD
         v+GAQ+DuRZTaXZMSD9ld+N04CIa4KuAJHMUk67LhYDezw+uRV7ZftDPeyrofUAcSwfTo
         cPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792800; x=1724397600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qwLWNfklFp9yOWm7oGFyBx/KIEHr2G+mY1Na9aaN9U=;
        b=FRi+2o+VORod2p7Ucu6tX9h+T6XVI1n9ahPrHiiBd8hqCZUqZZAH+ty35hhgRtrZQM
         LxWk1KnsnBzag7Z8DR8DOOV/gMFHXaPn9Fz9EdXzY80jUCRmMCbTQvfmG3zHY4eQ3rnt
         2AeKbaMKFnOd2+2ywbwVG/TzaGo7Imp+NhNKO6913Z1xRadf50MLLpvGHUUCgBzXpXon
         qb+ZicA7MXQXvM7crDt+j+jxDWudN4rlr27MdulUQl1U4WRYi/ZAS6GvJ8js8LfINPd0
         DBl1wtLpI286jFtBzWVoXC47WsYJpUeyIMttMSzgDwnmJw5vdVC7Ums6DLnMYAO0B67d
         Y+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP6w/GIlk7veAc9NOWO/klNX6FEH1Q49SJsJa0L9WeqJATQhwPRq+zcPHeEHutPQ6iA8DM4Vlg2FMCd2ZD2nZskQgemNGzRw==
X-Gm-Message-State: AOJu0YxcSMve3G/gveH+DFKK9hwkLo8douePoS7icABsnwiShl5N2+QY
	e/KQzOVjznGHH3EZX/9GOdhmmKQxxA9kLLyjo7mffx9eg/eR+IvvIdwDMSTbJjU=
X-Google-Smtp-Source: AGHT+IGSGKGz2LWvosgQ2pPQmkG+F/+eo0+mfnvEknWQwEK+nvehSTgdu/Y1V/NAFngK0xSmE4eguQ==
X-Received: by 2002:adf:ec83:0:b0:371:8cc1:2024 with SMTP id ffacd0b85a97d-371942a060cmr1420459f8f.0.1723792799996;
        Fri, 16 Aug 2024 00:19:59 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849cdbsm3025635f8f.28.2024.08.16.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:19:59 -0700 (PDT)
Date: Fri, 16 Aug 2024 09:19:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-ID: <Zr79nrBAkfSdI4e5@tiehlicka>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
 <Zr5Xn45wEJytFTl8@google.com>
 <Zr5wK7oUcUoB44OF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr5wK7oUcUoB44OF@casper.infradead.org>

On Thu 15-08-24 22:16:27, Matthew Wilcox wrote:
> On Thu, Aug 15, 2024 at 07:31:43PM +0000, Roman Gushchin wrote:
> > There is another subtle change here: xa_alloc() returns -EBUSY in the case
> > of the address space exhaustion, while the old code returned -ENOSPC.
> > It's unlikely a big practical problem.
> 
> I decided that EBUSY was the right errno for this situation;
> 
> #define EBUSY           16      /* Device or resource busy */
> #define ENOSPC          28      /* No space left on device */
> 
> ENOSPC seemed wrong; the device isn't out of space.

The thing is that this is observable by userspace - mkdir would return a
different and potentially unexpected errno. We can try and see whether
anybody complains or just translate the error.

-- 
Michal Hocko
SUSE Labs

