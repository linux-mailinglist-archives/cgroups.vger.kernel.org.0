Return-Path: <cgroups+bounces-10514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA695BB28FE
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 07:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AB24A1AC1
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96521323C;
	Thu,  2 Oct 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcpAY8JH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+meClwa"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85461C862F
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384150; cv=none; b=NJ69mTSopeaMyfnnZcYIA4o3yeK3J6YWWshgme+yq8CR8Dmp45qpqTfz2HUf3IMz1WF+HSqN4Te2lVlMycQgaAYma3CUUB1ZmLC/fjnPePSSZgOb1XoRZuDE/ZYZA81bqxnjwqN+7NWErmvy77DaDGAntZNY469pIcDa4G2azRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384150; c=relaxed/simple;
	bh=AQNh8cl+UP6HP61SWL0KP/oGum5WucbUdW7ZyughBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgcuhsZaP0FYP0Bk+5E+D6Zi/pUnxha4LSz/CxYOjDM4IaAj908gvPHOeXj+bnmTclmWhfJCSlGu/kHPJ2f4w4SHUqi0U/TRBfyRVN+jMSE2kXWnl/xN7o5Z7cN7PN6FYuJSatEY4fQ4O/FF9Y6AeoaE2+GnlukVNGZVqlT8baI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcpAY8JH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+meClwa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Oct 2025 07:49:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759384144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Apy472Q5lq+nvgjNXR3cJzIlxGGISyrJR6P8kOYm75c=;
	b=tcpAY8JHSt9mbrTZ/obJhPEGIf2beBd1A06NbUI7Oea1aUFzRqKt5wgqOKdI5QCTRIeYbR
	hs365pHH4k4JzfQNUfFbnLi+qyUo8VpQXO3dJwd2DkP+OmRbxALBTM8JG5KTGWMv1/W7TR
	eaiKDXGyr9K3mm+7ZtHrE6X/zFCImI9GizbQJ84It1L68IYkgrm7qHiVnQw42XL2mPZ21Q
	FuFPmXuRok5CPSbPyMGal1l3xH6SHealP/Z4wJUJcJlFm9tS7x636mWEbetSG5wo/By/kY
	q9j1ApdxdWhnMa7xcrauj6mARqwC57WuKbbLRIAcIy3E9m+ZpaMOPQ6Ngwx4Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759384144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Apy472Q5lq+nvgjNXR3cJzIlxGGISyrJR6P8kOYm75c=;
	b=r+meClwaSKfKlU2B+io9towu8KpVPixcx7Jo71rM4IIjjXkrJCdUmasKt1PInYY3ejZ9cP
	qr+v8Oq56KVzFuDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <20251002054903.kzlPcvnz@linutronix.de>
References: <20251002052215.1433055-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com>

On 2025-10-02 05:22:07 [+0000], Kuniyuki Iwashima wrote:
> syzbot reported the splat below. [0]
> 
> Commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced cgrp->freezer.freeze_seq.
> 
> The writer side is under spin_lock_irq(), but the section is still
> preemptible with CONFIG_PREEMPT_RT=y.
> 
> Let's wrap the section with preempt_{disable,enable}_nested().

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

