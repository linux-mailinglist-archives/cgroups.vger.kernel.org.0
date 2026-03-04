Return-Path: <cgroups+bounces-14596-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBGmMfEBqGkpnQAAu9opvQ
	(envelope-from <cgroups+bounces-14596-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 10:57:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E21FDF7B
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 10:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A51C53018F00
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA739F181;
	Wed,  4 Mar 2026 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gcK92lHh"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56439EF32;
	Wed,  4 Mar 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618217; cv=none; b=O3zemgbeMyjhNqS1fKlG+0dXmvzhKQeZOjkKJCpbbc13V49BUZqFZSybi/pWSmGcCJ2lecjSiGdB2IhGXHyAcEqtabpG6gc3XJVXt/BNCDNfFuTTtDOYQ2neBZb60aloBBupe2DRcWVGS864sFYDaatzoJe4rcQkagkiLMlNDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618217; c=relaxed/simple;
	bh=PeW5Y5/TplyanUbfLPcUrfoUI9pBebkTvkpqYew2Dl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdmd9j3RD6t2whCAgbZmjjN6MMCkMh42PFz6QYMbTOk5gjN0GaQzxYL2t60lul4L2yYHEjwjrEMEg0Ekkr1uDTeeTc4guntlS5i3zudNmdXfFv5iZElyXJuAVRizujBrcNXq86j1B+HAGor3ZRw0PbU5rz+j1dpq8Bjz6S9AT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gcK92lHh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1VNnNCWRfI0pPH/pClHiGfRJm2fLXPerTPHVskmyYhc=; b=gcK92lHhnrq+b+nR/PJi3NGi1V
	O8nYXDvd0VtpbKoizP5dcL5AaDqM3gemEUCVb0L76wajprFWNL3tXEeFzInmrkmNMXI5ifXNEcbp+
	g3Zzc8HrdOuIATQHmqhsFAdaN3efVuV696IJgbRw6ch53EQfrkmP/eHGH7az9Hd7mtK7zaVJKvfIw
	lRBXz3l3V81xe3k5IASCIKBYihSnl51zKDKDits3cgZUXH3c7MFqfbVdUdsaOwIoHhuFMjDrnMqMg
	LSzRT+Z/pjum+VbUZf3IJw+vfLIvgoWiVpSOnM+29hImDIJ998+gh8ku3Gk5A+N+91vrxlp0Lk+/V
	olFGPAig==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxiyG-00FsAC-DE; Wed, 04 Mar 2026 09:56:48 +0000
Date: Wed, 4 Mar 2026 01:56:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	thevlad@meta.com, kernel-team@meta.com, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aaf98kejfRuMvIu3@gmail.com>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacehv3rpO9irhEG@slm.duckdns.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 6F1E21FDF7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-14596-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Tejun,

On Tue, Mar 03, 2026 at 07:46:46AM -1000, Tejun Heo wrote:
> On Tue, Mar 03, 2026 at 06:11:15AM -0800, Breno Leitao wrote:

> > Before (without blkcg_debug_stats enabled):
> >   253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0
> >
> > After:
> >   253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0 cost.wait=0 cost.indebt=0 cost.indelay=0
>
> Given that they haven't changed for a long time, maybe it's okay to expose
> them by default, but why? This is something which can be toggled on easily
> at any time.

My goal is to ship a kernel that exposes these detailed io stats by
default, without requiring any runtime configuration. The stats should
simply be available out of the box.

> What's the benefit of exposing these extra numbers which
> probably don't mean much for most people?

My original plan was to introduce a Kconfig option for this. In v1 (about a
month ago), Michal suggested removing the toggle entirely and always exposing
the stats, which seemed reasonable to me and received no objections, so I
went ahead with that approach.

To be clear: is your position that we should not support building a kernel
that always exposes the detailed stats in io.stat?

Thanks for your review,
--breno

