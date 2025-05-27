Return-Path: <cgroups+bounces-8359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06DAC5848
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B564A1441
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFC627CCF0;
	Tue, 27 May 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5tVtZVC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5A42A9B
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367775; cv=none; b=h2AEB9tbgWyYnD6f/nHzC2hVVYo8LL0otNa3sovju6+0EDK3Kxy60y3IbEaxB9+5rLvGIpmsiIGdQvBzmY1o8Intjb01uMJw3xe/bqzimsTi0SLDydUKmjhJZLMNjpBJYdFMoOXzWfnFUhUDAPtaSYnJHfFgXqLtl+MTOBOdFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367775; c=relaxed/simple;
	bh=rSUmK6PvljT86o4KrKERVWT2kGyd3UxU1gg63ZGbtLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQzdjwSpLjKLD0rCNdzAmQZQ/vfqpMhzWhw/Zp3YGGVN8AnXmIlTsrfuwBaMBxtH6jRwCS+F8PvM+4C5o/k3eZH01NAqAJgkJJiSdtKF1Vu10JSWifKxpB4XW1x5mD3Lo80+ixOlb81nMpcJmjcbc3zVBFL9qtukcQ19u47x6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5tVtZVC; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 10:42:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748367760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgFCUnj+eNo5iwuZeQQfKX2DgvuAt+lMF54AtNJcgY8=;
	b=M5tVtZVCwqb9HLLle5o9rQMtrkFsyQ+bHQqFxt+gHb2sug1Ft4r39gBnFdd7/sHXT6Z/TK
	L3KyWRk45HRyf79JuJzm1GDsPcuuwLeXU5/QKDzladLYDqOfe6enUXSDBXm1zx72xM2Z8D
	Ht/eGLH6hNwupY/KPkU+XzPjZib5xtc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: syzbot <syzbot+5dd4e428fa723938e6fd@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [cgroups?] general protection fault in
 refill_obj_stock
Message-ID: <loiano2kji2pin44d7btrufm5ovdi5rm4fdmajhlvarsbfrbru@olcbsrrrdrh3>
References: <6835c01c.a70a0220.253bc2.00b7.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6835c01c.a70a0220.253bc2.00b7.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 27, 2025 at 06:37:32AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    914873bc7df9 Merge tag 'x86-build-2025-05-25' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12dcf882580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=231a962e5fdb804b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5dd4e428fa723938e6fd
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ecae640d0786/disk-914873bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d451e50efeae/vmlinux-914873bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8f7363263e49/bzImage-914873bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5dd4e428fa723938e6fd@syzkaller.appspotmail.com

#syz dup: [syzbot] [cgroups?] [mm?] BUG: unable to handle kernel paging request in percpu_ref_get_many (2)

