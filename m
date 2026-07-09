Return-Path: <cgroups+bounces-17598-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8R7uG0g9T2q4cgIAu9opvQ
	(envelope-from <cgroups+bounces-17598-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:18:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011BF72D0D2
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:18:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17598-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17598-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F4D5300F448
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF73B14B3;
	Thu,  9 Jul 2026 06:18:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169B33F5BA;
	Thu,  9 Jul 2026 06:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577922; cv=none; b=DN48T/imd5FSbw1hkC1Bul7CJiDKcGQsoSS9/6+7PFIalAA/AxWU3pzsmmfw2FmvSD3mC6Vzt7KC15Dkeh1nTEe/R/mSd3ge4aqDQGuGKVCf5dbbAx67zBV7DIXQeanDMralCkXIafNtz8eFRsxhVEhZq7lE+BlzldfMql9iACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577922; c=relaxed/simple;
	bh=V5Wb+Qi9rgMh8qejn5k1CJF1acbyGHbJi/MwTPkPgb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZkCeq5kl8bPVB9vYsz2EN6M3Natd/ixSySlPoPORc2YIeAH+59b0WFCbJmVq01T2NtY6CvrmLKArX/Uy391EGjF/IYZmLoAXti9w3yiMHzZ/RiR3Es8VCAqxVR/4DtUOiqklY94K5qVo0u9mOv/JE5Oqn10REti+Y7ki2bkY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id A266168BFE; Thu,  9 Jul 2026 08:18:37 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:18:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/17] blk-cgroup: remove blkg radix tree
 preloading
Message-ID: <20260709061837.GF16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-16-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-16-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17598-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fygo.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 011BF72D0D2

On Sun, Jul 05, 2026 at 03:51:22AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> blkg creation is now serialized by q->blkcg_mutex and no longer runs
> under q->queue_lock.  The radix tree is initialized with GFP_NOWAIT, so
> radix_tree_insert() cannot sleep while blkcg->lock is held and the old
> preload dance is no longer needed.
> 
> Remove the preload calls and the associated unwind path.

Isn't the GFP_NOWAIT a bit of a problem because it can fail way too
easy?

What about converting both the radix tree and list to an xarray
using the internal xarray to deal with sleeping allocations?


