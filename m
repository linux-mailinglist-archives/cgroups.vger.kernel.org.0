Return-Path: <cgroups+bounces-1283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA966842F3A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 22:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE72F1C244A7
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476117D3EF;
	Tue, 30 Jan 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NPOWjrkO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A314AAA
	for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651790; cv=none; b=RudP1F72Z2j0w/4WENmn2ZnPgpfl0lY9q+UnN/8RVmgSqhwrBWmisFfAcsHgDrnGi2xs5EfbZSmAy26spQ4KI5rTjBorn9Jy3uGOmlMIHtWnQoJM7e7+7G2DJW8hH9siUTwZetL6U9GkOlKonzXdwqu4t6do+2aUdXYY+5BMoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651790; c=relaxed/simple;
	bh=QFF3g8SJ4OiMza5Xx+W6HjoPtXkMrCk0w56SdKoVm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLVNaNEKsJkE9c45CBkhSYIR0dGnY8Nn7eW308vGGFA0YquqjW6dQi0bnQ4VNWn9tl2EaeRgU7Kz5l4GbXSe7ZIhb+hHpGbaYnf0FDqwOpSMZM38aCXcxiIcD+SYj20JIsURULGAXLDW45IZaNUgqGb8quy6kIi6kShH62gVOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NPOWjrkO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c53ed6c56so13100006d6.3
        for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706651786; x=1707256586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zUwitgcZ8PysFOK/IjV63sunJlwofoIw/gZSZx3mTw0=;
        b=NPOWjrkOnfgF8bI7jvihkIPTJu13w3AKmOzC6OtMmjjq0My81atY0FPGwutJpJ7cFZ
         5q+UP8E4EP68OysIHXPvvARU5NlRGWUEzCxAcwFdo2VflztzgRE3o7QDkZgPjTYIy5Pu
         Ro3whZW3ldQXFFOfmMwil4DNc+AF9RMkm5rQGgZb8uGYgEdo2NfKzXlzwmPvqFhc++hx
         1JcUgQL8ers4696kfJSPMI0D/J9IcYWYstHLNHX07A1gKIx0YHvk8sNYHijSBregHI4a
         86lt9aceAOzKlS8qza1i3F78SroqUWfOLs6zNxJ3PxSVvWfEmAyY1DAh/8NA7b70qLMe
         MREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651786; x=1707256586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUwitgcZ8PysFOK/IjV63sunJlwofoIw/gZSZx3mTw0=;
        b=UJxOfQ49RmGsIvw3NKSSheK7dHCSKkPEMAyWlZmEjbsONTIxxTAa61/6bpiaO7huqt
         AclEw62Ou+qgjKtJPZ1Z4MrXrvpBy2U3o4F1kmpLqfBkeaQ4oF9U3fu5nCs7qZfzPYjo
         TxPhEX8aqLiS39JGLMX3eLW/e3w6proycSZlRUIoTQ2X3C8YPjBZUUmo/wT+zwsS+xmD
         FARIDxvqOSZ5D7KJZyMibMCNRFBn/3yyGU55D+gb9Ct8K+EtUp8XWZHE1mOu2PQhFzwZ
         BujLI0yhFbojQhE+ZVCtgo9AYFN1x2DEj1Y+hwA+gzn9j68aQECXPJ7CNikoRTGybh1Q
         /TIw==
X-Gm-Message-State: AOJu0YyKu2jh4OqNArW3Jte9ydWxbrRN9POai5gB/UtoIBYG17t66v9/
	JfEZcuTY89ylk/bQqDiyCKIVZJrFycs2SXD3+PNH9x6BmNZKbvAAm3ZiwL66yIY=
X-Google-Smtp-Source: AGHT+IEaHZUxi5O8j8Bxm1H1MuCEcZ4girsG/PslfOcIwAPmfhwFr0mToEqN3itXQuBrFZ8Ns2nPOw==
X-Received: by 2002:ad4:5ecf:0:b0:686:309d:8915 with SMTP id jm15-20020ad45ecf000000b00686309d8915mr9823848qvb.6.1706651786531;
        Tue, 30 Jan 2024 13:56:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pj3-20020a0562144b0300b0068c68437655sm362333qvb.115.2024.01.30.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:56:26 -0800 (PST)
Date: Tue, 30 Jan 2024 16:56:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <20240130215625.GA970164@cmpxchg.org>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org>
 <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
 <20240126163401.GJ1567330@cmpxchg.org>
 <CABdmKX0pbOn+PDYQwQC=FA6gThSG0H59+ja52vAEPq80jbaWGA@mail.gmail.com>
 <CABdmKX3Jv1O-ppJAS-oi96Mcc6E3xsD-rwoeNU=jKU9wNDODVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3Jv1O-ppJAS-oi96Mcc6E3xsD-rwoeNU=jKU9wNDODVA@mail.gmail.com>

On Tue, Jan 30, 2024 at 12:58:12PM -0800, T.J. Mercier wrote:
> On Fri, Jan 26, 2024 at 8:41 AM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 8:34 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 09:46:23AM -0800, T.J. Mercier wrote:
> > > > In the meantime, instead of a revert how about changing the batch size
> > > > geometrically instead of the SWAP_CLUSTER_MAX constant:
> > > >
> > > >                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > > -                                       min(nr_to_reclaim -
> > > > nr_reclaimed, SWAP_CLUSTER_MAX),
> > > > +                                       (nr_to_reclaim - nr_reclaimed)/2,
> > > >                                         GFP_KERNEL, reclaim_options);
> > > >
> > > > I think that should address the overreclaim concern (it was mentioned
> > > > that the upper bound of overreclaim was 2 * request), and this should
> > > > also increase the reclaim rate for root reclaim with MGLRU closer to
> > > > what it was before.
> > >
> > > Hahaha. Would /4 work for you?
> > >
> > > I genuinely think the idea is worth a shot. /4 would give us a bit
> > > more margin for error, since the bailout/fairness cutoffs have changed
> > > back and forth over time. And it should still give you a reasonable
> > > convergence on MGLRU.
> > >
> > > try_to_free_reclaim_pages() already does max(nr_to_reclaim,
> > > SWAP_CLUSTER_MAX) which will avoid the painful final approach loops
> > > the integer division would produce on its own.
> > >
> > > Please add a comment mentioning the compromise between the two reclaim
> > > implementations though.
> >
> > I'll try it out and get back to you. :)
> 
> Right, so (nr_to_reclaim - nr_reclaimed)/4 looks pretty good to me:
> 
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
> 
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> 
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
> 
> So I'll put up a new patch.

That looks great, thanks for giving it a shot.

Looking forward to your patch.

