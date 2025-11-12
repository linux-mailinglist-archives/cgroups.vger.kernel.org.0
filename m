Return-Path: <cgroups+bounces-11859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE7C513B9
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3AA54EC510
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EF1E492A;
	Wed, 12 Nov 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0XI7kQwN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYc+Xf07"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F72EE5FE;
	Wed, 12 Nov 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937648; cv=none; b=VHxOeL86MZ7LcoW8/wrgSQi2hI3kXVDymORT7CZSvC2c8zh/MKv6zSidaIm6sig4r1grP9maepUETKeND03g/yiBInWqMEz2Z1sayvy3nMpj9D67wa5wkTW5UeipVp0alCEwGREFubfsUHO2SiupA0Nx3fe994YceAMAj07Y5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937648; c=relaxed/simple;
	bh=tSeDYSdTakR0Jp4OF2Jm0a9M8Zm7izlqpSwMYkUzRVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiuM6m0qkeuv/yD+wrqxmBIpA3be+X+T67A/J9hVsOHE3B3CM4ZJyb/sk5iNHPiqxylsxg+ODEnmEZb8VxTuOYKnpiYSHIUTFBBr7IXYlk+LBKAYQ/hjMoc4ukPxLOYVh4xgXI3pi8PAbVpwF91KDkdTJBIROLVnbikMhlY/RSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0XI7kQwN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYc+Xf07; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 09:54:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762937644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+V65kbZ9DU351geqXdbjAKHkaUI37Nqr4MUCHI9acFg=;
	b=0XI7kQwNRmOiy++ujh+bSWLTTxUj12k6FNh+VqQ0qP0Aa7jEBI+SRJfSv9sa68oMiPh+TS
	YmlnV5Y0dnwWZ7pgENZpBHPa96fz2hEpI18ydhmq4M50UrKPDFYoyWvJzofOH6Hd1I/Dd+
	il03UZHcMCtjIq7tGI9eE4Q599rnWD1utwrvMLz2XFstp190lCfO4+YqpRECS4UcJAhFIm
	VHZrN5t1iY1HFmSaQdLVy55GaJ/lJO5z9vOR2WXcqMpMjRNHuQVre3eeHTn0J6SWsL9m8M
	+1mIPodxkf3F4OTU4YE/IC8SByzgY+L+rGaOamuOkCfBQfRE7+vyOUxsm2uncQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762937644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+V65kbZ9DU351geqXdbjAKHkaUI37Nqr4MUCHI9acFg=;
	b=iYc+Xf072ZiHDDTNwwAtlbIIW6UxlrZjsGBEUM25STRuau127eoPUU3ZFohjg511KAUkGS
	qrweraEEcSKJeiBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <20251112085403.DDv0RU5k@linutronix.de>
References: <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <aRKqm24Lrg-JnCoh@hyeyoo>
 <20251111084900.babaOj0w@linutronix.de>
 <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
 <20251112074930.mKu1J__U@linutronix.de>
 <aRRJe3PzN3cmgvcB@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRRJe3PzN3cmgvcB@hyeyoo>

On 2025-11-12 17:46:51 [+0900], Harry Yoo wrote:
> > > Is PREEMPT_RT fine with this?
> > 
> > Yes.
> > The local_irq_save() is not strictly needed but I am fine with it to
> > keep it simple. The inner part is just counting.
> 
> Yeah I was wondering about this... and thanks for confirming!
The preempt_disable_nested() and no in-IRQ user makes it okay. Not the
counting, that was meant as "it is a small section". That might have
been too short of an explanation.

Sebastian

