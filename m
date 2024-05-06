Return-Path: <cgroups+bounces-2793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700E8BD1FB
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BC61F244FD
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C615574E;
	Mon,  6 May 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvgj9ZeQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F14D58E;
	Mon,  6 May 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011176; cv=none; b=I3xndBdxSvFVAXmkFQC/TRCzVWSkv3w2kyBLDvccvxtXWqqldpjghS3o1393Uebde2Dja/nZWqrA5f1GsyGTam0MHcVCdpWGRpmDeLuC1TIzYKD4ax1S5cyGKNwtqzZ4l316Qt+CgMaMDQJj4vlWL2/oYnjiAqEd2WwldwE3M+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011176; c=relaxed/simple;
	bh=UByW2CAtWEILp5/xCX2e/HdbtwVRTqwJsNHbz0uMWqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu9NagHKEPQGfr2JZ+L2T9ohpowtPxj66mRoK4BkofI96oyW00ph6lhDZbuR9EyJgJwr5XFhnnE/EGbqvzVVX+y/LnkY3z7sL1Ukmom4bErFBKkcwNEBQPcJswtBbgPwr+OhKBO+BBo4yHRGDGBCVzbUACmLp8MTAoDOJNBNfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xvgj9ZeQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 May 2024 08:59:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715011171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVBomsU1pkgWorTEFN1CEWB9RNQxy/wjf+w+O+s+tl4=;
	b=xvgj9ZeQkBGhC/+eTdpiuva+nypC87VBuujlemMoy4g8WBbc4t1XzK3S3YJRIOmfGmnRBf
	+hp2kIdPt9gjjQqmpVt63At7DdCgoHegyRzATUqfjgXg1FDLI2Q+kmbjyBh+2aXQuY06nN
	ToPt5JrYCo43mZMyEOroieswc9uk8oE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, yuzhao@google.com
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
Message-ID: <gbsy4rpt3fbcspuepstk6tzzwd3mrosuba7ufm7phopwor4pyb@ucxrvdw6nly3>
References: <0000000000007545d00615188a03@google.com>
 <0000000000001b9d500617c8b23c@google.com>
 <ZjjlLcjHuQoV-7gh@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjjlLcjHuQoV-7gh@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 06, 2024 at 02:11:57PM +0000, Yosry Ahmed wrote:
> On Mon, May 06, 2024 at 06:03:29AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    2b84edefcad1 Add linux-next specific files for 20240506
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1164931f180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d5d1f180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16527450980000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14/disk-2b84edef.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vmlinux-2b84edef.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a662/bzImage-2b84edef.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > __mod_memcg_lruvec_state: missing stat item 25
> > WARNING: CPU: 0 PID: 5091 at mm/memcontrol.c:999 __mod_memcg_lruvec_state+0x18c/0x430 mm/memcontrol.c:999
> 
> This doesn't seem to be the same issue as the original one syzbot
> reported. It's the same function but a different warning. I am not sure
> how to tell syzbot that.
> 
> Anyway, this warning is the one newly introduced by Shakeel. It is
> firing because NR_SHMEM_PMDMAPPED and/or NR_FILE_PMDMAPPED are being
> updated using __lruvec_stat_mod_folio(), which also updates the memcg
> stats. However, these stats are not exported per-memcg.
> 
> I think the following should fix it.
> 

Hey Yosry, can you please post your patch with the signoff? The patch
looks good and you can put my ack on it.

> #syz test
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12be4241474ab..d3a26ea4dbae2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1441,7 +1441,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>  
>  	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
>  	if (nr_pmdmapped)
> -		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
> +		__mod_node_page_state(folio, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>  	if (nr)
>  		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> 

