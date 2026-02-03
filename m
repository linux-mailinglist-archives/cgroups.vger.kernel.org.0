Return-Path: <cgroups+bounces-13641-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mq3JRgCgmmYNgMAu9opvQ
	(envelope-from <cgroups+bounces-13641-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:11:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00446DA628
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B30D30CC2B1
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA63A63F5;
	Tue,  3 Feb 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJbCqeA5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B303A63F9
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127709; cv=none; b=Q3pQAE9o1iq8X7/tklPqon+qUqwLkBYv4I9lgn9F+ij4F8hg38dPHRjgZKthAsHy3F5zlVJ7Vw4WQi+4GRIquOKRukbBWivjxfXgw1xjOWQc+LurRM8jp+sfm3qUo1OhzVcm0aybxMmdqbVoeqHUm1hZh3/xsU8XxsUEUT9ufdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127709; c=relaxed/simple;
	bh=eFlFuS35sO+2MxnOmBZjU/WCcv1Q3blX+r1MsIMzRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHXG9csYd6gEPWRa4y0Dg1C1UVDWjf3gVfjuDEv5Pvv0osb2VXVhlm0tUKH37SIyHtqg1UYNNffyGSltChBeCSLmTdhX7KjcPGO7A0/0xMU8GlibT0H/GqVVgh7MrrZl/Kk1r4fQooE1GiZJ/LxY92iXgGAsgXexNBU/8eNZhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJbCqeA5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770127706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbTsR4y5gPUMx2z7X8415ZTujJFmeurjHL+sbGjeZX0=;
	b=VJbCqeA5qLl4vzgWILidY59ezGFHWmp7p7SBeFfgq4OOy0EmTzq/WEchHeUcS9puSlOcnK
	P2VCserDPOTqBv9hnP/5OwegZQVkFxWFw6tT9gAfMEra25FKtrV4KahDC6JF/vgMXRngn0
	Zl7q365SCwosQSGbB3xA7h0gUMAcmWM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-3EKy4Sm3MyCrGXA0dtIWHw-1; Tue,
 03 Feb 2026 09:08:23 -0500
X-MC-Unique: 3EKy4Sm3MyCrGXA0dtIWHw-1
X-Mimecast-MFC-AGG-ID: 3EKy4Sm3MyCrGXA0dtIWHw_1770127701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E424D1954B0B;
	Tue,  3 Feb 2026 14:08:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7504C1956053;
	Tue,  3 Feb 2026 14:08:12 +0000 (UTC)
Date: Tue, 3 Feb 2026 22:08:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <aYIBR6eeudRUQ9q8@fedora>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
 <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,kernel.org,toxicpanda.com,kernel.dk,vger.kernel.org,fnnas.com];
	TAGGED_FROM(0.00)[bounces-13641-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00446DA628
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:53:40PM +0100, Michal Koutný wrote:
> On Tue, Feb 03, 2026 at 07:11:11PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > RCU supports this way, here is just 2-stage RCU chain, and everything
> > is deterministic.
> 
> The time when RCU callback runs is noisy, moreover when chained after
> each other.
> (I don't mean it doesn't work but it's debugging/testing nuisance. And
> it also looks awkward.)

IMO it is one correct & simple fix for this complicated race.

> 
> > I thought about this way, but ->lqueued is lockless, and in theory the `blkg_iostat_set`
> > can be added again after WRITE_ONCE(bisc->lqueued, false) happens, so this way looks
> > fragile.
> 
> Right, I brushed up on the cycles from the commit 20cb1c2fb7568
> ("blk-cgroup: Flush stats before releasing blkcg_gq") and it'd be a step
> back.
> 
> Does anything prevent doing the each-cpu flush in blkg_release() (before
> __blkg_release())?

I can't parse your question, here blkg_release() simply needs to flush
all stats. Why do you talk about preventing new flush? why is it related
with this UAF?


Thanks, 
Ming


