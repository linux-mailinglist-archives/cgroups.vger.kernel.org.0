Return-Path: <cgroups+bounces-16786-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAN2IX42KGoLAQMAu9opvQ
	(envelope-from <cgroups+bounces-16786-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 17:51:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164E662002
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 17:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=oXa0u9YW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16786-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16786-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12CEC308180A
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4949250F;
	Tue,  9 Jun 2026 15:41:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34648B373
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 15:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019713; cv=none; b=QpZKImRtyQzwyzXpLkj/58Q2pM3p+PYVigWEkufokDQnMlzgAjAJSRv8K4EE0T4ZnEaTL18BCTTAH/fnDF61w+NByAhew6DT2X5G0Z1rGzBIWeppndwSXaQqt8Ee8+xNJKtTmI+xWKmPeMZLYleH/kIEN4FGsZ+JNkPCKGmWGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019713; c=relaxed/simple;
	bh=H3qyB2VxHjJ1KbCp9FdqtfW6+ptFB0X9en1JR/f/blI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEKRv6f2TFgkMBIXFPapSeJLxWMlILjPXSn7UQerP7rG5yuXENLYUq91MYObkWNtwTPrDpLHwBPQhrKrHWA3yg8m15ffLaFO1UFNSgzPDhDrLWHBzuSVFNk7lpgDXeckw/DNkXpJBt/yqXWZxyW7fgaymYvQJ9k9y+jl0DRCb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oXa0u9YW; arc=none smtp.client-ip=209.85.217.52
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6c4a2458683so2098062137.1
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781019710; x=1781624510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRDpcACJAnf6MqVZ/0ti617MR+GTIe/DUWU9NUIc714=;
        b=oXa0u9YWfdLBY8BDDdczkA1YU3VbhJ68Mi9gP2PiH/LZVvm8fRQypwr+VQ5MqXPLQX
         8NagqB/UO2OSGlIUiTfSMy0XJiY8H5lnO2qVSGlN0AM2cZSTLaGHZZCRzDsotcngWN2L
         42vnCYx8wSuzHvsQBsLutr/LhFnNokXJm0hgnjPfhqf4i9EQItnYQw2Akp0CbV4cdI7+
         IUVr2ORobdtR23mL7iE2f9hTMy7HpajCjS3I3HSXeXUKZcmPEP8le2mwLzxL0zJvNKK8
         JUzZeCjc8qm2VwrnA+SqFMExb+zpxHsusVOzAwO+GQbjRaKU1tBXLyLOEWpT2CvH2D0i
         UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019710; x=1781624510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRDpcACJAnf6MqVZ/0ti617MR+GTIe/DUWU9NUIc714=;
        b=VjG6dT3eGnzff+6kuZkOy49Pb40vrh0zymz5iPwviIqj0NOojuk5i/9CsP/OB3q8a6
         D4VrLjoYDGXg7Rcz2a0hlHg6doVvDK1Th7xTo239UKzq4yeSZDOHIv5XCgk/a1axJZpn
         GhSdz47SnNMOr1N/R7d7+T+5qCleyf+9fps/MjuLOdvHKJZvsFBVQU0oip5Oj61kSPTi
         2rMbUftPiaVgDPqpKx6ZpMiqNSW/Pjgi0jSE944MivcYaCncj7tVf6S+HYWgxcrTKAwv
         m8v5A33Y2YKdyNL9DVite8Wn8IMMBvZgxXFUCUGGeLQrrkApzVGJupjBMEr47yg9gk+1
         yKsA==
X-Forwarded-Encrypted: i=1; AFNElJ8qhoSfavWD3I2/yNC3OJtMw8h6yk/pYjlTVFBRT7h8CtrMReya6Lg2eiSTfuc4TNPpvbp/S0KA@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYkdcJQlJplLvEpET7ro25W423cThfjsvfwZK5Co3Ycgu+K1k
	KFcO4q9+k8a8OnQSkQw/TGdT11WN2BReT4l82yi9SXpR+alZO+m6CloaBXO1C+ZBr84=
X-Gm-Gg: Acq92OGwuWKJlOUmp+bpUi/RpIwZzfm9EzfD3yhwUYdojdnQEoaNMUWhcLPDLOMBd80
	Pfgevk1asBCdGzWBjMacj696VDV+HRsOfcO6xv0Od5l9OHrNqmLqWcn8I8eq1AE2oxbS3pb9gJ5
	/DqCLxK7TyGZtOscnO4BEMuoux81FwQmp5ws95K/XUGayS0wNgXHMPXe1WhAdGA3iZZo8wyQJBN
	jiOWnFEI9S7aBlSY6EwVeov3nMmr5hXpnnav4M4ECLoh0eXDmCt+myENAIrjUEbevfCeApLs2Fl
	FhStaX740VjBXQFpgpMyYVeq2tAKvVt+BC5eLZRHNIUBD1A+aGye1NWueFI1hkFgg01AHeSQgPi
	hYVKSTLpDl6bh1pH28TiJvzLSz9oCJGie/tXQZK9/KdFaFnGcHCH33lr/kNFbTtYScUFOEbH3/J
	yawzr2JR5H2XPXvapYHlD0VWisuUPrZdSeuPVVkIl8RAzQ3RURGjc39KBeuUmTrz8ykZGj5rtxY
	QVupPP1aHN2RI/XDA==
X-Received: by 2002:a05:6102:3749:b0:632:8eb6:7a1d with SMTP id ada2fe7eead31-6ff0567a74emr10492174137.9.1781019709463;
        Tue, 09 Jun 2026 08:41:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcc968sm218987346d6.22.2026.06.09.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:41:48 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:41:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com, longman@redhat.com,
	chenridong@huaweicloud.com, akpm@linux-foundation.org,
	david@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, rientjes@google.com, chrisl@kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
	youngjun.park@lge.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and
 alloc_context nodemask
Message-ID: <aig0OkpSaHTxTSUU@gourry-fedora-PF4VCD3F>
References: <20260609002919.3967782-1-gourry@gourry.net>
 <8C4E5377-F5CF-458E-BA49-3D962CB75477@nvidia.com>
 <aifC9s9X6hLWdKkd@lucifer>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifC9s9X6hLWdKkd@lucifer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:ziy@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-16786-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gourry-fedora-PF4VCD3F:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gourry.net:dkim,gourry.net:email,gourry.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2164E662002

On Tue, Jun 09, 2026 at 08:39:22AM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 09:44:42PM -0400, Zi Yan wrote:
> > On 8 Jun 2026, at 20:29, Gregory Price wrote:
> >
> > > The nodemasks in these structures may come from a variety of sources,
> > > including tasks and cpusets - and should never be modified by any code
> > > when being passed around inside another context.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  include/linux/cpuset.h | 4 ++--
> > >  include/linux/mm.h     | 4 ++--
> > >  include/linux/mmzone.h | 6 +++---
> > >  include/linux/oom.h    | 2 +-
> > >  include/linux/swap.h   | 2 +-
> > >  kernel/cgroup/cpuset.c | 2 +-
> > >  mm/internal.h          | 2 +-
> > >  mm/mmzone.c            | 5 +++--
> > >  mm/page_alloc.c        | 6 +++---
> > >  mm/show_mem.c          | 9 ++++++---
> > >  mm/vmscan.c            | 6 +++---
> > >  11 files changed, 26 insertions(+), 22 deletions(-)
> > >
> >
> > LGTM and it compiles. As long as Sashiko does not complain, feel free to
> > add:
> 
> I would add caveats of:
> 
> - Complains legitimately
> - And it's about this actual patch not something unrelated
> 
> :P
> 
> (Not speaking for Zi of course, but I mean just in general I feel these caveats
> should be implicit :))

Thank you for your contribution! Gourry AI review found 1 potential issue(s) to consider:
- [High] Questioning the legitimacy of AI is grounds for excommunication
--

[Severity: High]
Insolence will not be suffered, take this man away.

;]

(fwiw I'm getting used to Sashiko, it's doing better)

~Gregory

