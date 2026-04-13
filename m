Return-Path: <cgroups+bounces-15278-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCxLOgNv3WnweAkAu9opvQ
	(envelope-from <cgroups+bounces-15278-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 00:32:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 449603F3E33
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 00:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2873830480CE
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01E39B4A3;
	Mon, 13 Apr 2026 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Acn3ot68"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BB3909A2
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119350; cv=none; b=mJC9JGvIsbH5o5/WXx/6oDW0pdmzI6LWjO9WUeSOoR6nf/X5tW7D8iWMF/fbG6VFN2YezDk1pflfoy9nBjSZR8Zdp4nNSEpOh8hi5V9DAX7WezMZHMG1oSxohmyq09ShuYeK1BeFDeURbgqgnwgar52CF00i+c5nkXmHKBIFzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119350; c=relaxed/simple;
	bh=Zu9t9xMwSwTdbUO8QXwwxTD/AJlEofFg31G2lARa+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbR3+zjvD9TJgcT7NW90rdHcrknK7sYhLhH6qDTC/PD2AnA4Eef85eMGR2StX69hzYVkBsF0wiTvvF2Uu/jqaBcZdtHerG78hQxRBPM6oSLl7oPlmU8keo57fhpoWO5jQlCk89qXRHkG5Lxs6QsMCSElbAsMeDPySdqIescfOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Acn3ot68; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Apr 2026 15:28:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776119337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0C0oTbgMZYbhrAvkMy0ApjkIhijnhBgwg9sMmLsR0w=;
	b=Acn3ot68zMGKTsDYvK5Aa4s1RXOMEuYQGZqR09u3VG6a016vJp8EKZeK2gFbESKUvWoT0Q
	0SarXFhI/s/uQHW9HYZOEIS6bKHCakE8/CMF4YrhNIlAFdkEoKqBkFrIOdowTV4y4HWI3M
	mOVL5DjirDprGIsRuX9t3ZRr2Rhp5gk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: syzbot <syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com, 
	yosry@kernel.org
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING: bad unlock balance in
 lruvec_stat_mod_folio
Message-ID: <ad1tV5WpFhxbQ86N@linux.dev>
References: <69d54494.050a0220.3030df.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d54494.050a0220.3030df.0002.GAE@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15278-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 449603F3E33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+Qi & Yosry

On Tue, Apr 07, 2026 at 10:53:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cc13002a9f98 Add linux-next specific files for 20260402
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d8946a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3353a77896e73a8f53
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Let's wait for the reproducer. I can only think of cgroup_subsys_on_dfl() check
returning different value in get_non_dying_memcg_start() and
get_non_dying_memcg_end() to cause this uneven rcu unlock. However I can't think
why and how that can happen.


