Return-Path: <cgroups+bounces-14009-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKYBEmoulmm5bwIAu9opvQ
	(envelope-from <cgroups+bounces-14009-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 22:26:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73D15A0DE
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 22:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5235A30041C7
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D04330322;
	Wed, 18 Feb 2026 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1x2hzsx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1D2FFDF7
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449959; cv=none; b=EtTjVifCW7KQouMjg8GVYa0XucsVVJiP3JqsNkOqNUJ2aWa7ml7y88b1ZP3YoIYDFVtFzBe3ixBFDOUufeGJl3k1g+ieAavYdRhRWaWuITi1r30Yfb7YZt+6ZxqUdwqMjlvVlZCIw7SgAq/fLuLZ2mD/Ke3HGMvKgcQhe6csXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449959; c=relaxed/simple;
	bh=TSEiRfMtoPLZ8CTZelBiCt+Z45NKL8wNlq9NjpF03LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1LqIc5TWhBbGjdNcTtwJ/SJF5/OjFmqMysqb0sShIavskod9kgolHkqrBCTQOwIKQHZ3xgiqgy8WOQb+ebIIkN/iulr4XHxXA9vowKhk6cV1BQaWvPTg2D3NQ18t9y0g7OB6r74LiP4jivU/NyLk5p5roqlfaRiJJAn1LxmXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1x2hzsx; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Feb 2026 13:25:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771449955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wo6vv3zwAb49jabaYEhJvfqzD+EG3AeCMF5nyF6m1Uo=;
	b=n1x2hzsxevl2KlW0/u2V4Vyr/ZSO5Xh+P9TXfWKLEIalUF12vlcIdJ8A5qhfR4EXzkOPNc
	tA8qejHL3g3QvA2gIMr6KY/kDgpRKkTCAAG7m+6aiqlp3hyLgb8cRmYYEXY3+leRbLTv7i
	xA43Ain+4HSrKFlMxM5ocAXx9hoOfKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Carlos Maiolino <cem@kernel.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com, Muchun Song <muchun.song@linux.dev>, 
	Cgroups <cgroups@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock()
 (RCU free path)
Message-ID: <aZYuJiEvMR9wC66k@linux.dev>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
 <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14009-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DD73D15A0DE
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:36:06PM +0100, Vlastimil Babka wrote:
> On 2/17/26 13:40, Carlos Maiolino wrote:
> > On Tue, Feb 17, 2026 at 04:59:12PM +0530, Venkat Rao Bagalkote wrote:
> >> Greetings!!!
> >> 
> >> I am observing below OOPs, while running xfstests generic/428 test case. But
> >> I am not able to reproduce this consistently.
> >> 
> >> 
> >> Platform: IBM Power11 (pSeries LPAR), Radix MMU, LE, 64K pages
> >> Kernel: 6.19.0-next-20260216
> >> Tests: generic/428
> >> 
> >> local.config >>>
> >> [xfs_4k]
> >> export RECREATE_TEST_DEV=true
> >> export TEST_DEV=/dev/loop0
> >> export TEST_DIR=/mnt/test
> >> export SCRATCH_DEV=/dev/loop1
> >> export SCRATCH_MNT=/mnt/scratch
> >> export MKFS_OPTIONS="-b size=4096"
> >> export FSTYP=xfs
> >> export MOUNT_OPTIONS=""-
> >> 
> >> 
> >> 
> >> Attached is .config file used.
> >> 
> >> 
> >> Traces:
> >> 
> > 
> > /me fixing trace's indentation
> 
> CCing memcg and slab folks.
> Would be nice to figure out where in drain_obj_stock things got wrong. Any
> change for e.g. ./scripts/faddr2line ?
> 
> I wonder if we have either some bogus objext pointer, or maybe the
> rcu_free_sheaf() context is new (or previously rare) for memcg and we have
> some locking issues being exposed in refill/drain.
> 

Yes output of ./scripts/faddr2line would be really helpful. I can't think of
anything that might go wrong in refill/drain.


