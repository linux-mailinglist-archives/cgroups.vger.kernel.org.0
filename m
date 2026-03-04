Return-Path: <cgroups+bounces-14602-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bg3IZU4qGkTqgAAu9opvQ
	(envelope-from <cgroups+bounces-14602-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:50:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C88200B5D
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8A5430848B3
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3F3A6EEF;
	Wed,  4 Mar 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QHEnG8/K"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC639FCBC;
	Wed,  4 Mar 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632143; cv=none; b=RdRwwCEcHOQkfqsoNes5u3AwHhEI1/VaCfsUkkb6F5WrItoGbtfznTPhMfvD5W8/LuJBh8p0qhfu5zWFJqwqyj6PQoTJ8wlkSWvlKyDx41Qz54yS6PIywnF5AWnJobpjz/5SEbq1zb+jTXQVTsylEH0cscAVciEvAiY+4pOwapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632143; c=relaxed/simple;
	bh=qOc2VmidsMlzi9mWf/yfs4Ql8Hq0zsQO1aGzkGYtWCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Uq/bv3d2rS8B4RXeAa88L0FSEZNmke1MVITf97UogstelOl3mOy9XVI+yDkd1sM+/Ba/2pNDVasdK83LZuUD4qPw7J2HUsrnFHqdN+xyOHkQrNsvWAJwL7pBIxHOdWN3EcRaP3m+6TB8L8K+ncEIcqE63qhMl6VfxnajNzm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QHEnG8/K; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=qOc2VmidsMlzi9mWf/yfs4Ql8Hq0zsQO1aGzkGYtWCA=; b=QHEnG8/K4CkkGOo2R0wxB0IQvd
	7hDWzybVnBQBVOlXKZi7R2k5bIvfxmK2ISb3LeGtv78AueHd+vlyjWiyUGI62AEuBeTiH4Nw3Qu93
	C4FMc2GwDNEL3gCdF4dWzsyz/qp7Qk3cmoNIopmzvIb0QzSNo9TQGJ6IEYV0CJPi/6NJoG95LDkvJ
	cx5QU/U4VyiLfiIE9KJQDTVLKyM9hVa0vgAqULC0MDDqYyjuwUQnPnERnH6XjYp9jxnK6Z1lpY9SG
	tCCtjUa8fh4fHfHhtVAfGdTqFNtPLC4Wy405vAVBdaH2aqJPVg7CFNnfVvIjkFx4OoIupJ0Ds3bQ9
	m785yV+g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxmav-00Fzzj-Ar; Wed, 04 Mar 2026 13:48:57 +0000
Date: Wed, 4 Mar 2026 05:48:52 -0800
From: Breno Leitao <leitao@debian.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aag30EagagRlie0A@gmail.com>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
 <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 09C88200B5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-14602-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Michal,

On Wed, Mar 04, 2026 at 02:28:03PM +0100, Michal Koutný wrote:
>
> On Wed, Mar 04, 2026 at 01:56:43AM -0800, Breno Leitao <leitao@debian.org> wrote:
> > My goal is to ship a kernel that exposes these detailed io stats by
> > default, without requiring any runtime configuration. The stats should
> > simply be available out of the box.
>
> Does it mean the information is useful to you since early boot and
> adjusting the param with a userspace tool in boot sequence is too late?

Not exactly. The goal is to have a kernel binary that, regardless of
where it is deployed and how it is configured, I know know it provides
full io.stat details without requiring any tunable to be changed.

