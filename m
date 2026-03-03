Return-Path: <cgroups+bounces-14561-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOifOZzppmnjZgAAu9opvQ
	(envelope-from <cgroups+bounces-14561-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:01:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9061F0EEA
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50FC2303E76C
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2FF35F601;
	Tue,  3 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O4vH8Htb"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C5325714;
	Tue,  3 Mar 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546386; cv=none; b=aGEkTPcwGfYUkdOteDl5UVgivyQVGugQtjed2LyJgESPFEGClU00gDAWa3U9kTDR4hhwSpS1aJABRG3zr//iB5S75R8JxQzcABlmk0QLg3Idxm147PI4AtOQBw4UNVS368/hdPG3SVE0joaodQnvDfW5Mt5oVJJ0Se+ZE30Ka+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546386; c=relaxed/simple;
	bh=jKaus7JILQepyWCXwKnvhBQxb+z701P4h/Do5wnO/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu98RTElnaIvlPSGDnGzYDC71tni7zYQJXPXJg1B64vYfkraYK+1JfDi/vQC9aUylIl/mjfkeDMdiwPMHm1ZJAbu7L8xcrCCL0SCQQHdXGOllQhUzdQ4nVts9VQRq+JlA3DanmIALnDeqFQiOLgE5v2DdACnmvCZPCsvrF2SLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O4vH8Htb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=ySs4CGpikBsJKutl/8s682ix5maGPGGOdKHXq1NQ/FY=; b=O4vH8HtbMvu9hyCi4MYtaIDLRT
	4sZXEW12ZY4FGrG5H+rZJZITXbipiu7XwcRhQzFykr6QPh8+YPXhJ9AT8CInC3ryEZxZwd7OdoY7g
	q87PeNe/2CKNQDF8IqS5JRMsLjKHbSHuGsrhe8l4N6bB5/ZJjRHD8x+Y0fuD13YP9dC0ytqorCPMO
	/y9UUHs37fQUj17csz3YnLzMG04ro+UNWAc6BNh99tga3I7yijTAGk+DaRZZKgZap7LVp65gYZ400
	5njipZW4Ow081sjxIV5ZfImxLnFcFp+G/MrKz5cYUMiGdY8Xplh0RLD5IDIPpGNiAbwr/iup34lLw
	3Qz8BQWA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxQHj-00FEMf-5D; Tue, 03 Mar 2026 13:59:39 +0000
Date: Tue, 3 Mar 2026 05:59:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
Message-ID: <aabo8xm1S0Zxw3gD@gmail.com>
References: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>
 <jf2bkbvk3h5j3mqfldu66egbvbeq62mzdenuimpgn7d4tfkrpx@b2s6zzdgmgyh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jf2bkbvk3h5j3mqfldu66egbvbeq62mzdenuimpgn7d4tfkrpx@b2s6zzdgmgyh>
X-Debian-User: leitao
X-Rspamd-Queue-Id: AC9061F0EEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-14561-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

hello Michal,

First of all, sorry for being late here, I had some days off.

On Thu, Feb 12, 2026 at 11:26:29AM +0100, Michal Koutný wrote:
> On Wed, Feb 04, 2026 at 08:15:12AM -0800, Breno Leitao <leitao@debian.org> wrote:
> > Add a Kconfig option to enable blkcg_debug_stats by default at compile
> > time. When CONFIG_BLK_CGROUP_DEBUG_STATS is enabled, additional debugging
> > information is shown in the cgroup io.stat file, including cost.wait,
> > cost.indebt, and cost.indelay for iocost, as well as latency statistics
> > for iolatency.
> 
> This seems to be toggleable quite easily anytime at runtime (not sysctl
> but modprobe config), not a boot cmdline where CONFIG_ default could
> step in.
> 
> This only guards printing of already collected stats (sometimes even
> without kernel consumers), not sure if it's that useful.
> 
> blk-cgroup isn't modularized since 32e380aedc3de ("blkcg: make
> CONFIG_BLK_CGROUP bool") v3.5-rc1~42^2~92 exposing it like a module
> parameter is historical artifact.
> 
> So I'd dare to propose removing it altogether and print those stats
> everytime. Readers of the nested-keys format should survive that.
> (I don't even see the param documented.)
> 
> And if there were eager readers that'd be affected performance-wise,
> more conventional would be to make this only boot cmdline parameter that
> could static-branch also the stat collection spots (for some more
> benefit). And then would also a CONFIG_urable default make sense.
> 
> WDYT?

That seems to make sense and it also simplify kernel management. I am sending a
V2 with it, let's see if there is any other concern.

