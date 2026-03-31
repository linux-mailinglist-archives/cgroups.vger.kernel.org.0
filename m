Return-Path: <cgroups+bounces-15134-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN46CSzoy2myMQYAu9opvQ
	(envelope-from <cgroups+bounces-15134-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:28:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85B36BAA8
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F7330DDDA6
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836D4035B7;
	Tue, 31 Mar 2026 15:22:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4E4035BB;
	Tue, 31 Mar 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970542; cv=none; b=FAJAe9rQveAGQTJ7TU36kMFOHABuHW/ql5qbbJxXQEWFlpr9npmRjhli4oCsTPKU++IVwDgF2jX/TLw6Y3SJd9+9c1OC8++9Q4IRPc049UA0T0s6PYUyHXf+Yxw/2XLh4g3v0VLhr5+aqMA2DptzXx5dXTVSw28vNJfOlAMjrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970542; c=relaxed/simple;
	bh=Q3HWBeZ7zGj03IMzjy2FlWgXs4sy18IVtFZPvkMCobI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHMRYGCdAA1aKy2g8epBJfxqwNkh66uW+CwxuGhA5fxGaaBMO4ekrxpOO4C/oP3NCoYtA0b46A5E1c4w/YBMyjLKI/bbhk9y4noRHQ3X+mpxJHZ2WKLufk6uyW+eop48J0Y3TsczG5A6Oncku+VDcdd8HdHbcj9yP71qf2gZhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F1CA68AFE; Tue, 31 Mar 2026 17:22:17 +0200 (CEST)
Date: Tue, 31 Mar 2026 17:22:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jackie Liu <liu.yun@linux.dev>
Cc: tj@kernel.org, hch@lst.de, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: fix disk reference leak in
 blkcg_maybe_throttle_current()
Message-ID: <20260331152217.GA8074@lst.de>
References: <20260331085054.46857-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331085054.46857-1-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.970];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15134-lists,cgroups=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: AF85B36BAA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:50:54PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Add the missing put_disk() on the error path in
> blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
> blkg_tryget() fails, the function jumps to the out label which only
> calls rcu_read_unlock() but does not release the disk reference acquired
> by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
> is already set to NULL before the lookup, blkcg_exit() cannot release
> this reference either, causing the disk to never be freed.
> 
> Restore the reference release that was present as blk_put_queue() in the
> original code but was inadvertently dropped during the conversion from
> request_queue to gendisk.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


