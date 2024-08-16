Return-Path: <cgroups+bounces-4323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C629543C9
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284C31C21FBB
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191B12D74F;
	Fri, 16 Aug 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ni852PVs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3184E1E
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796338; cv=none; b=fabwKTw7GlhQG8nBLgXz4Oz7yq7+tZResWDDLPkSx7Pv/f64jThfAvMPWN+cpxVJ/1hQa2IIBxGVbd+9cwBDaIYwt+MSFG0QKHXRfmM2GkcwsrbngLknqTRYPWroKVjhkJSpm0PA0m0tqOnH5ybW0yqDL3cJCdmQgbW3wyyaDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796338; c=relaxed/simple;
	bh=/FSCZwMWDBvL2pdVUDCcXybfvMINgHHjI88FNgz9Ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qip3Q4w/xztlLr0nj8wrNiTZnDdcUGQhuuY8Y9EDoJOBUMLp2+xFAyqDBgs/65HElTeJJpXFIfRc0JtuOxC0dkwKvWsqa/Q3lFk5gqW5YOs13sv+WWCbCh89jBBopdBFnur5cnMhQ/kNYk3aO0PcoNbjLVnn2UXrFi7ZRnFG8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ni852PVs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371936541caso429002f8f.0
        for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723796334; x=1724401134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHLNBtu3gOxyQPcoDoB7/UuHac6loGYyqpNQ9W8K+0Q=;
        b=Ni852PVsDn4amVV2eHoEnsKLAWMmBATbjIrthiqIxTXB3L3sAong9loqMu8FR0WDQf
         EiHRsWrG7fk8lNn87YVF1ySB0QGWPov4RoebLzQZgTEnGEbhLwW1CTdaMik3L+r8pxv5
         lPDLPMjX1MBYX0VvGr8+dmyBBQVxfcieqWnA4MVFWLj4CBAFOMkcAOyQUQf1saaizXMf
         zhG2LZ3o3y+ah1SMwg4x9hpXAMZZ2RgobNLL8sISOZjjxuPOK4NtuC3V11HDwLfke7+K
         fOfZq4XRwWLVtMzAsOKPwXiUoRBdoyQN7xW8r+qNC3wMN1kmXH7sTCuASbwYwSdAStnQ
         0ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796334; x=1724401134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHLNBtu3gOxyQPcoDoB7/UuHac6loGYyqpNQ9W8K+0Q=;
        b=Q39cTNmypZbu1CNWNcnBVkI/ygD5PsDQAJg3CMHvhejTrUcc+YdhT7LY2MBIdoPy2b
         iTVMVbOSV9lbrw0TGIMOtlmP5MGLeRQ9CWwEPkSGfZhbQw9/w1nyLj8cn/ztYehzLbjQ
         wQSwepFFd4DRkgiMIg0szOY6TOB/iuEO5GVRCrskF09KZeRygsDLgPY6ltewS6nrMTsz
         7RMW2lVlbJWS7YM5rlDJCNmwmOVSjSQ+pnDpf3YmDO0fQ2cR+MpoUqsiZm3MZoUzeRwu
         Lrtp0vq1e7M2U8x2llWXDKDIOz756dhfnFStLn8xeIy7B3cHPRu4D7gKbE0VaKnFE9fh
         fVqA==
X-Forwarded-Encrypted: i=1; AJvYcCVOHES8KD8TRVMWLeHj/81bt7Cpr8zozcPD6zG5IIOdbkt+IErdX5LIiKBvevd1Q6IwbMQj0TjtX23RbRI7OgdmCSXX3MgIIw==
X-Gm-Message-State: AOJu0Yw6X4LYdLCW+er7z1DZhCqxOvk4dopXywe0dxTqJTe5K9zZqJ+q
	/0K/gins+SPPNaMtvxjA0nYSn/YPAWifZOo8YfgVyXdLlHcGXBLFK/5kwjQyjmk=
X-Google-Smtp-Source: AGHT+IFdBske6NMqguLo6M58gZVPz/3hhle42cAyCb4RiH4ciuwNcbDyYr/kztrq34Zlbgm0uutPxA==
X-Received: by 2002:adf:ed04:0:b0:371:8c09:dd9a with SMTP id ffacd0b85a97d-371946cba59mr1501747f8f.62.1723796334388;
        Fri, 16 Aug 2024 01:18:54 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896d74sm3086190f8f.68.2024.08.16.01.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:18:54 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:18:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-ID: <Zr8LbVe8IGd1JSQo@tiehlicka>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
 <Zr5Xn45wEJytFTl8@google.com>
 <Zr5wK7oUcUoB44OF@casper.infradead.org>
 <Zr79nrBAkfSdI4e5@tiehlicka>
 <20240816004334.41ce3acf52ba082399a76d88@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816004334.41ce3acf52ba082399a76d88@linux-foundation.org>

On Fri 16-08-24 00:43:34, Andrew Morton wrote:
> On Fri, 16 Aug 2024 09:19:58 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 15-08-24 22:16:27, Matthew Wilcox wrote:
> > > On Thu, Aug 15, 2024 at 07:31:43PM +0000, Roman Gushchin wrote:
> > > > There is another subtle change here: xa_alloc() returns -EBUSY in the case
> > > > of the address space exhaustion, while the old code returned -ENOSPC.
> > > > It's unlikely a big practical problem.
> > > 
> > > I decided that EBUSY was the right errno for this situation;
> > > 
> > > #define EBUSY           16      /* Device or resource busy */
> > > #define ENOSPC          28      /* No space left on device */
> > > 
> > > ENOSPC seemed wrong; the device isn't out of space.
> > 
> > The thing is that this is observable by userspace - mkdir would return a
> > different and potentially unexpected errno. We can try and see whether
> > anybody complains or just translate the error.
> 
> The mkdir(2) manpage doesn't list EBUSY.  Maybe ENOMEM is close enough.

it used to report ENOSPC with xarray.

-- 
Michal Hocko
SUSE Labs

