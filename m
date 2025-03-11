Return-Path: <cgroups+bounces-6988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51751A5CC28
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8048189E87A
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E2262800;
	Tue, 11 Mar 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HxoaFUfb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C52620D9
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714194; cv=none; b=IFvkHl1HU37xZRa9kIxiE63KavrcclPs7VpEjCCnVTAnW3VuNajqDU43iHK4T9j31AhntAnmLXgqGgBkBhx/oVuYqzy66HVGr2K5KR3+l1VQA+raKEZSSioMl+q0YmtVPfClv3V7W+JAFc71dAUnpzZPY6Kgywf3mZIl30CsZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714194; c=relaxed/simple;
	bh=bz4i3vwBWiRTM/4WsD2Sgt4Gf4wuWjf4iqMscKzae8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYySPNoGPv018yEXdo3SwFW2tGa2Wm3+4rlqiQbknfLqfxDYql2GQrBg1C+xvJZKVqw0tMk8SVwqF060FyJtbzEPaUOuoAvIzVan+A0VLRX0+oh2lq9A+RXmOC88eTEZ2FYuf4sfjL6qb2xbN1rRRRAdFnjVqXKYYU2h+GKHB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HxoaFUfb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3c4ff7d31so663916985a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741714190; x=1742318990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=HxoaFUfbrZUrQq+54bTOc/oqToROTePvuagj1D5v+cyKComqRU14NdCmShFRTPdOVp
         a7TMb4e+swXMqAAEVmHtr+8YEBCgExulU+c/qiHzRvUIeoY4+nO6pFWTJVaLcpijsr2a
         afm0tuR4i1wOTqEuHpOqny5/WpHoMS2D/FEuVBD5kcES6caqdXfQWEvRKn1KtG3TZfzf
         DbNjEEmvJWJgfYzgPNzAVZ4b5cQ9KKi4Jx80+3mgNJSPH3yFR08oP6JJezc0H1THqYNV
         t+RMxhNa4bhz8rGiFo4e75wXaZFJknNFMIzBr3jMt1HeOfXXIUBu8jl1WubAjWU1afbn
         aFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714190; x=1742318990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=T5mcKSGWpTe4SsFbF8LveDYJgmPd3OK73SmUXgtY5OH9h1yLDx+9AxWKel7zORESuI
         PRIgH/mRkJGsvypQQUWBAzUsjfsFTRjPNojwxcZvLIHUoxI2M7BGBKYe6PrjveN1DdYK
         QHF/fKcS8ni+kKJM85ThWTY4JOTXn4NGP2sr7gFHol9ubbc5uB14OO2l9c649p12lIEg
         lPjeyKJPs/viefa6ZtMe4SkmyAg4Jlona8kmjOu1Eo0SmbFioJUC3NsCptPgjY6BK/3l
         BIbQ5KHm1J26Hm9QfBN2t24tl9mm8/ftv/sd5RVj/NQRN7jwLoW18uAhfFaLJCa9Gwdm
         xF9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZdxFE32ITDwvUWXMFzLqJjNj4uLlBUk6TkZEXavIVr7GX5AXq9SHsIm/W+4Vj5V7z4DUpti78@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3opTpkZ2ciIyL/3LMXN4BfZlWqaeBUaigX46o54+QFW0HbRX
	JTh2madgYSmt87nJD5k1S8Z+o437SrRwmA2LwH/qRq5eTZ5uE17mzNiwgt9rYVc=
X-Gm-Gg: ASbGncswAzl+rjvT1y+zohwAOHUixoLAcNr0+zyzWZYKQEDbMJuOZiG65RBq8u9Ijy9
	c0lXKChS5jU5WQ3K5QjJsRbQhU9gcDPfvLt/EGKI2vdy5hYTNsZodmwW4SAg4XmDrKZvtVR2jP5
	C6092DOeBaOOdqRFXI4PpDJj8fu6i+i5n7GuGe1108MpfmMaYoVbolkRDwYlUSAYLh4rvhTfozk
	hP5mzkSzMGH9whX4BcNCWg//2AkU3eG0Da7xIYTLHXJaWJwh56bBDh3pSx9o4evoVSgptzHTv7g
	Od4/urxsTs2KFQDTgOSlxXrwVKD73rlotnHRvJrEAf8=
X-Google-Smtp-Source: AGHT+IHsp6QUFpMLzg6RFZfT24l93gao05k4Ok3I8RY1SmxsMToyPGVIKqWah9c5Rc1/JLuYkzCUNA==
X-Received: by 2002:a05:620a:26a3:b0:7c5:5585:6c83 with SMTP id af79cd13be357-7c5558573cdmr1464793185a.54.1741714188560;
        Tue, 11 Mar 2025 10:29:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f715b718sm74299356d6.91.2025.03.11.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:29:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:29:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <20250311172947.GC1211411@cmpxchg.org>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
 <20250311153032.GB1211411@cmpxchg.org>
 <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>

On Tue, Mar 11, 2025 at 08:57:54AM -0700, Shakeel Butt wrote:
> On Tue, Mar 11, 2025 at 11:30:32AM -0400, Johannes Weiner wrote:
> > On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> > > Currently on cpu hotplug teardown, only memcg stock is drained but we
> > > need to drain the obj stock as well otherwise we will miss the stats
> > > accumulated on the target cpu as well as the nr_bytes cached. The stats
> > > include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> > > addition we are leaking reference to struct obj_cgroup object.
> > > 
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: <stable@vger.kernel.org>
> > 
> > Wow, that's old. Good catch.
> > 
> > > ---
> > >  mm/memcontrol.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4de6acb9b8ec..59dcaf6a3519 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > >  {
> > >  	struct memcg_stock_pcp *stock;
> > > +	struct obj_cgroup *old;
> > > +	unsigned long flags;
> > >  
> > >  	stock = &per_cpu(memcg_stock, cpu);
> > > +
> > > +	/* drain_obj_stock requires stock_lock */
> > > +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +	old = drain_obj_stock(stock);
> > > +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > > +
> > >  	drain_stock(stock);
> > > +	obj_cgroup_put(old);
> > 
> > It might be better to call drain_local_stock() directly instead. That
> > would prevent a bug of this type to reoccur in the future.
> 
> The issue is drain_local_stock() works on the local cpu stock while here
> we are working on a remote cpu cpu which is dead (memcg_hotplug_cpu_dead
> is in PREPARE section of hotplug teardown which runs after the cpu is
> dead).
> 
> We can safely call drain_stock() on remote cpu stock here but
> drain_obj_stock() is a bit tricky as it can __refill_stock() to local cpu
> stock and can call __mod_objcg_mlstate to flush stats. Both of these
> requires irq disable for NON-RT kernels and thus I added the local_lock
> here.
> 
> Anyways I wanted a simple fix for the backports and in parallel I am
> working on cleaning up all the stock functions as I plan to add multi
> memcg support.

True, it can be refactored separately.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

