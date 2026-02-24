Return-Path: <cgroups+bounces-14225-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APXOBH7qnWm3SgQAu9opvQ
	(envelope-from <cgroups+bounces-14225-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:14:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E454218B1AB
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57D39312D740
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA83A9DA5;
	Tue, 24 Feb 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDRze4GL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8904C81
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956220; cv=none; b=lAHLrkgvua7b8/vnHLA1ydOA/X69rDy5x9sHyCV9aPDtJAVX+pP2PN8CpYXWBi2A4QRd4VYQHcVRAvydoJdQHLS1DfdHH8DyUZ45XuWh5lxVtUYeqiueBJNwH2n4Rs85Zs56Fp/2nIZuvCtCTFPRPaQ7AwRyYugipmudlBOlCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956220; c=relaxed/simple;
	bh=jf5IZQq3cAlA1i+ZX03AhkGPmE/XhSdStfkzshA61pY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRsUQm0G+wrUx1dsJH9X49cMCy92xNaZ4fcihdc6CaAZ1fJo1bRncvulo1jsoUeD0l8zCtkjoxIVK/K/5bqb98VqyfjEkeNNA2PWQ0GM9BZMUqClRraxXWkqfOVG76rLUGzrNXegA7weyVSJ9ymIEYZ97YAcHVB4+OpnjIEtRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDRze4GL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e62a3ee29so6210314e87.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956215; x=1772561015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4oIsYGmK/xdzzCq4Y4y/7a2RiK61m8snUa5jjavVTo=;
        b=bDRze4GLD4jgA4AOyNX5b9kR+HYueAf2E6e3dEwPU/NpOfZfAsm1YhUxtVT3BvYLXl
         1GbuBt9W4fYXwlwF4TviF5NWERQMry1Xt75IsIHcXNvWv6XmOiDb1TFrn3sUWcISobTu
         6ARpULk+TRxytgL04rLR052Ct3q42ufTnJjINgr1L2Vgs/YhaaRbxqSEYZta/pJaBlOp
         xFuoWzQJXf6U2W/9+5evpde4Ypz6M8djX5c6iJXS+n5JGoj+RWz8Bs07kPTDnBRMCy1D
         WHicFqpUXfUvfKBkGueWmuJB4/83D/iKAaZ7/HdEM2kVq16VbRFyWNHt7hFAFoIzyFMs
         V/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956215; x=1772561015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4oIsYGmK/xdzzCq4Y4y/7a2RiK61m8snUa5jjavVTo=;
        b=Mrn9j++k7lCi0isWHsIPGy3Lu1DAGd6dWwOd7+9eAmr4e9xeJXlkNSDuqbBzu7SH1F
         RiYS+tqUgJgKEycaFUGDJhkStPcg/9TXFUNsi6WB6ntkxzvTLmmiQ210SEPy4KrEE/2r
         uzO3jc3Ew/N9VNRxMIYSJaRJNM05R+gPjpQg0uUiOEHYwxVzkVjdG5qVwRjBjA53sZT/
         abhLlsEr959j77/gyPrGwmFNcKQQrYnIpr/GtYQZescs02R46kCmN+kgfgGS2SdvG/FF
         0QXI7ZtioHUthuxnHDa2anWNQY6JS12FpElYQEpUXZuLyb5l3n5xxWLbrVG7yz/wjv7J
         RYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXwDPPgyiiCLCZsj0cwDW8k781oWQ2fvNrL36GvvBSBe9S1OBjpRLG6umrm3woNHiaBUk9s+zkn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxv1RZh2Rm4Cqwpzf+Vq5czlJ0yd7bbYGLyj1UKT3ytV32Dd8b
	+hShMbPd4XJZC/iFGHk8zH+mbJoqRIz86Rij+GbEMC2GU2khVKen6v1/
X-Gm-Gg: ATEYQzwnimr+FO7coLS1op9M68aWA9HxA7rESFtO0EGebaZ2rWaEIBxzLJHi8evOXbj
	bnbTVpbNTgt/mGZ8nYu0jD+rFxfrPrPqfBf9rMzXPm3COaXQ/2gRMS8wW8eoscSRnYfcQQ1q7Rz
	OLphpbzoZns0i9X1v9XZczfKqkEcO4dFbbT3awd3Qdptmnh4iJjSpb9PpJxdhPtzbOA9K6hmSLs
	s4dnECUaP13UKrMBovu/PAuSbHtdW1zkYogWmTSaN9ima4/9/vnPiw1v7uq5b6jk/WeBD4zrAO1
	S3xzzS8hp1M5wHJpr8uyeTkwzLSCgGG+BFRYWI4xLt7U3nHxtMP+J6QiavQ3iNhn6K2G2E83W9U
	0lLalEjAwNeAHs8hAHLR8mR0QBrYU2hFHoBFSDNnQQbGTH4fhXJEAGrzr9cbLvQaWpCYGRQZchc
	1+9FTyswkc9OCrF8qSFhwIZ6a4d+usVlWNUTy2guarN/inG8JtI507
X-Received: by 2002:a05:6512:4016:b0:59d:f71b:3608 with SMTP id 2adb3069b0e04-5a0ed99bdc8mr3767938e87.31.1771956215059;
        Tue, 24 Feb 2026 10:03:35 -0800 (PST)
Received: from pc636 (host-90-233-215-147.mobileonline.telia.com. [90.233.215.147])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb0b8b0sm2329602e87.15.2026.02.24.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:03:34 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 24 Feb 2026 19:03:32 +0100
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZ3n9IL7P7jyxtLd@pc636>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
 <aZxymBwx67pMn1ZP@pc636>
 <aZy2SHbXi6qdGS0a@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZy2SHbXi6qdGS0a@cmpxchg.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14225-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,suse.com,linux.dev,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E454218B1AB
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:19:20PM -0500, Johannes Weiner wrote:
> On Mon, Feb 23, 2026 at 04:30:32PM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 20, 2026 at 02:10:34PM -0500, Johannes Weiner wrote:
> > > @@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  			continue;
> > >  		}
> > >  
> > > +		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
> > > +
> > >  		split_page(page, large_order);
> > >  		for (i = 0; i < (1U << large_order); i++)
> > >  			pages[nr_allocated + i] = page + i;
> > > @@ -3675,6 +3671,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  	if (!order) {
> > >  		while (nr_allocated < nr_pages) {
> > >  			unsigned int nr, nr_pages_request;
> > > +			int i;
> > >  
> > >  			/*
> > >  			 * A maximum allowed request is hard-coded and is 100
> > > @@ -3698,6 +3695,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  							nr_pages_request,
> > >  							pages + nr_allocated);
> > >  
> > > +			for (i = nr_allocated; i < nr_allocated + nr; i++)
> > > +				inc_node_page_state(pages[i], NR_VMALLOC);
> > > +
> > >  			nr_allocated += nr;
> > >  
> > >  			/*
> > > @@ -3722,6 +3722,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  		if (unlikely(!page))
> > >  			break;
> > >  
> > > +		mod_node_page_state(page, NR_VMALLOC, 1 << order);
> > > +
> > >  		/*
> > Can we move *_node_page_stat() to the end of the vm_area_alloc_pages()?
> > 
> > Or mod_node_page_state in first place should be invoked on high-order
> > page before split(to avoid of looping over small pages afterword)?
> > 
> > I mean it would be good to place to the one solid place. If it is possible
> > of course.
> 
> Note that the top one in the fast path IS called before the
> split. We're accounting in the same step size as the page allocator
> can give us.
> 
> In the fallback paths (bulk allocator, and one-by-one loop), the issue
> is that the individual pages could be coming from different nodes, so
> they need to bump different counters. One possible solution would be
> to remember the last node and accumulate until it differs, then flush:
> 
> fallback_loop() {
> 	page = alloc_pages();
> 	nid = page_to_nid(page);
> 	if (nid != last_nid) {
> 		if (node_count) {
> 			mod_node_page_state(...);
> 			node_count = 0;
> 		}
> 		last_nid = nid;
> 	}
> }
> 
> if (node_count)
> 	mod_node_page_state(...);
> 
> But it IS the slow path, and these are fairly cheap per-cpu
> counters. Especially compared to the cost of calling into the
> allocator. So I'm not sure it's worth it... What do you think?
>
I see. I agree it is easier to keep original solution. I see that
Andrew took it, but just in case:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

