Return-Path: <cgroups+bounces-16348-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HHvFuX1FmrUywcAu9opvQ
	(envelope-from <cgroups+bounces-16348-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:47:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4A5E54D5
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CAF305C568
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40355410D06;
	Wed, 27 May 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BrZjRvoI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342C40F8E6
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888844; cv=none; b=eshgCn4kAUdDvZynVNqDcEDyOaXsgFz7Vkw+UWyE9EdqzzDw+Vc7k/NZub8cfXj6LRMOxvqJ2gzDW7EH9i3jailxGLYK0mPK2O7oEkiz56+bCt9IhnWC8MhxaJ4BoAAub8EQuoY6+hybPmld3yA2dD7iTq2vwSrVc+i5/+UitTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888844; c=relaxed/simple;
	bh=SX/btaHg8hisQE4HPjWH8PXnsnxSqCDOj4S+rvTli/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIObmsGO943Sa9jN+GP3wJ9ULCbW2wvd97fsA2a65Hg0RP5QkowlrZGRSmxW0xpV8Xxqag4VzQUyrfHXMinHgW2B/pdhaD/Xy6DE+aLJAE/HlNBDl2yOjca8raz3TlX+H47TndtgAXS8tH0NOfaO1ZaptGyi7BaAqJeEiK7I+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BrZjRvoI; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-95fb6411e01so5122744241.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779888841; x=1780493641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+e2bIG+i9gyjJiiA+ouh3//Pf3aD7RE7geFrfA4l6SY=;
        b=BrZjRvoITH5BXAfXA2jkpD1rp5AioNGjGttSCb4XDYtDBBBfFXe318dOvCGO4dNmWO
         5s2W0PRQx0CtOGTYAilzdJSxxiJ01MQzqQcNV6wofvLUK6n2kpbaRjBXO1C+18SUBFAJ
         yUJ37dLVPqQMiAX0lA5//nOC8p9837wal7BH+2iiUKdYeVX329hot3zOkQ+VVSxemS29
         pDWLtFKFeK56ECkBag0jTJh7mwPsNvF/0XiSR4o5Sy9sJwsL5g5lb5yufCeZ6TZf7sJl
         jP7DwqjWpqtOEa9fLfqvBN09ynhi3Z47M7kedXQSEpFdommyA62wK8YXKSXUL9EZa0mR
         neJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888841; x=1780493641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+e2bIG+i9gyjJiiA+ouh3//Pf3aD7RE7geFrfA4l6SY=;
        b=QLM5Zimnx6deY9xcagdQqC0GmEOfZb7/QlR4zKxzM66p9Eks60CXPFO50MPU9ild54
         QyMOL28jwIvrKqLVQGmrZC4Rb8WOQ2KJ4L64gltkyKYCzMbDI3NzuqXjKJoz6VvCOu4X
         c3+4BmG/Yq4iE1Oailf76qifEdRlAMGNEZxHFFiyZZR5ekiKf+UcpBfNskzbWW0k6t1X
         8ppNgE8OBf7ujc2xCRL29L/L6oCJV6+mjqEXnsABv6GdpdVqDNGVvnJUP2ohUmD0ooq1
         HyGJrAFGyreOxw9/2BWpcI4xfl9OhlW4hE4/r0wPNBnRuyptm0QwBZcbqief537ljx5e
         ql6g==
X-Forwarded-Encrypted: i=1; AFNElJ9uDw7ecNQ+C6B7FzuJQsRRclNwBCyA6sSFrR+zrCMTMpcmp6550Y3KihiojKU8JmgvJaiM7May@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGaINu4TIi5NzuCWDzbdV071yJqff9FZoSjVwm2iFT4Jjr1ck
	wYMxDw2U9sJCh/V7C8CGQAyd9L1vM40aWU+Xftz2nqoxNH/Ew7iCp73cMndD5XI0tvY=
X-Gm-Gg: Acq92OFxSN2zcCjafTcWCfkfM90MEP7L/XSyb7brp1ysDQWTa5YTPhHwG8TxYstabgD
	plkEjT0JyjldDKeAYjAYaLAPIfgS80Mxe18znap44Y0txR0wztNgZK2syJHy94Iyzhb+7aLXaOc
	JRFxtHp1cKzAOSuS0cLojbuxpg/zSZ3f/rt8+8iPq+ZCmhzYOFh7H+z4/na7KsrEp21a536pLrC
	t55g7eU7zC3K7tuLqC2fVvSchGXHkUxmRDJSbXGDYWJ52r6k5+TEwaXJRuZGELPYMhsUupP2kK1
	j333112EQ6QGn0xFttRd1N9/vTQrqS3G6P9JCIuOiDkQ+KggYb9YtZGGRRwgFBUD5tVUxSJEEUk
	oeXSgrd5z9k7fSM+DG4sgP1/Yz5L7x0reITlSmrSLB+pkTpuQaEB+HngMbUunnCgis9PP5naD7o
	dP4SaM7+RwAGQv2EL2V9m0TasjF2BO/tU4KVZ+zXOPfzKCzqIvZg2tbbS6fcDqgPQE+hT5HNR3y
	qiXegYsKOYzVhfe
X-Received: by 2002:a05:6102:688f:b0:631:81d6:e158 with SMTP id ada2fe7eead31-67c8fcbdbdfmr12092231137.27.1779888841412;
        Wed, 27 May 2026 06:34:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87034a2sm476927185a.16.2026.05.27.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:34:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSEOW-0000000EPtJ-0OFT;
	Wed, 27 May 2026 10:34:00 -0300
Date: Wed, 27 May 2026 10:34:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource
 accounting for QP, MR and MR memory
Message-ID: <20260527133400.GM2487554@ziepe.ca>
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
 <20260525134314.GI7702@ziepe.ca>
 <b8269d9b-bd14-4ba1-be60-a210a9a1d093@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8269d9b-bd14-4ba1-be60-a210a9a1d093@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16348-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 7FB4A5E54D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:28:59PM +0800, Tao Cui wrote:
> Hi,Jason
> 
> Thanks for the review.
> 
> 在 2026/5/25 21:43, Jason Gunthorpe 写道:
> > 
> > I would agree to mr_mem as a reasonable extension, but not splitting
> > out objects to finer grains. There are endless objects we don't want a
> > 100 different cgroup knobs, it is not usable.
> > 
> 
> Understood.  Our initial motivation was
> multi-tenant isolation: a tenant could consume disproportionate
> resources by creating many objects of a single type.  In hindsight,
> though, the real bottleneck is pinned memory, not object counts —
> modern hardware has large object pools, and the scarce resource is
> how much physical memory gets registered through MRs.  mr_mem
> addresses that directly, while hca_object remains sufficient for
> coarse object accounting.

This was the same motivation that lead us to a single object
limit. Inside a modern NIC the objects tend to pool from the same memory
pool so it doesn't matter if you have 100 QPs or 100 SRQs or whatever
they sort of cost the same.

memory pin accounting should ideally be limited by the cgroup directly
but we argued about that for a while and could never get an agreement
of an acceptable implementation. There are many nasty corner cases
around cgroups and fork and other cases IIRC

So I'm not sure if making it rdma specific can easially solve these
problems

Jason

