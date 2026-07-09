Return-Path: <cgroups+bounces-17595-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89wTMHg8T2p2cgIAu9opvQ
	(envelope-from <cgroups+bounces-17595-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:15:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BACB72D065
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17595-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17595-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9871304DFF3
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A873AFD0B;
	Thu,  9 Jul 2026 06:12:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AA3AFAE0;
	Thu,  9 Jul 2026 06:12:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577532; cv=none; b=ckF3gjHsH+6EF9g0e1wWixCC6pA7d8A0RrnnMpKWlqjY/8yoWHx/CvCTgd2IUSp/AujW71ejbG6N91gMmpNfbjF7coW0DsLx2DNs6KdWanjmhu8Y1JizlP0dE6sCcRyl+eBFJxjtMPMJFJO9OCN0WvMd74hJ8CRSAx3KtTxSfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577532; c=relaxed/simple;
	bh=4wKB2FReSHOYxifI0c50K522ehsaXrCCoiB0NObCy9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7uXocKPjOYd9P+Vya+Qia96jQbtgWlcr7qT3R//YisknCCsv0PjgxYcpCqSnA91IVpK2h9CmX+TvFMHdqpnLhcutVd4XoCZPrVipt6mA+P0Q4aI4/EZl30bMRni6lmtX1JJZkHnROgQQIQuLsQrG0hBY+S82C1KtbgSILs1VTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id D915468CFE; Thu,  9 Jul 2026 08:12:07 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:12:07 +0200
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
	dm-devel@lists.linux.dev,
	"linux-bcache@vger.kernel.org Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic
 bio users
Message-ID: <20260709061207.GC16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-6-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-6-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:joseph.qi@linux.alibaba.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17595-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,fygo.io:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BACB72D065

On Sun, Jul 05, 2026 at 03:51:12AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
> default bio set but cannot safely pass a bdev during allocation. The
> helper returns an unattached bio, leaving callers to set bi_bdev and
> attach blkcg state explicitly before submission.
> 
> Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
> Both allocate bios from atomic paths and must avoid creating missing blkgs
> once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones the
> parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blkg.

Let's kill off the concept of atomic bio allocations instead.
Joseph already has an outstanding patch for nd_virtio that needs a little
bit more work, and ocfs2 should be easy enough as well.


