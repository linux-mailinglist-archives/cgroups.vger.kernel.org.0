Return-Path: <cgroups+bounces-7818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE4A9BC56
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FCE1887691
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81004C7C;
	Fri, 25 Apr 2025 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qV95+FlY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7127442
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544681; cv=none; b=pbTsGL2d1eS+6bTAjgkYRidISZOZFSaq+dCZHZrRM7Sq1VTbjT+Vcmy4OAqGP+F1mGioiH0jUik7WhKQY7pmT8SSeWk6mqFqu42Cgv298aOhB0BICeKkiR83dRUyn7bVAxkNE2zKAPbKgQXDVMG4gzP9Iih6NQ3nm7sIZ+fokRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544681; c=relaxed/simple;
	bh=tz5SdGKpYOIvmjfQRmgReq9sC+3LzQlHRrj1BcbI4bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1dn6vP0rP6njNzkSSSSvS7+S25sGo3vaIcOBeR18muD5BQpwnpDhmLn91XcTYgHNZWh4fFUWbHpDUpFcO8Zmf7B4q94CxeXtguaUs0ydoC6FZ2oG+JTgL0PwVWza0vxcQiq+Yz1VnyrVxDUSK7KxP+8XBpM8rQVFhvYMIDJanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qV95+FlY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 18:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745544663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IB9vcqcWEcdWM+TiwthXAvk5swmCTNCTycnWuqUskI=;
	b=qV95+FlYn8SobZ5BuSXOCJzTrDGmBOkAgnTti0qDzmaIKe2DANG0lZaBqd6a3Kf5XhV2Os
	5p5HwcOeqyiwHRCE9cwrjRNyvZAP4q2w0OAtVGyPndXjEeIMuSjzB/lrQBKcuvFtio8TLp
	xcHtHCMXdYHd+lxm4jTH3QMBCzCHEuc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Francesco Valla <francesco@valla.it>, 
	Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
Message-ID: <xp52maa4uvkgfurxpfbu2bxcajqvlmu4xk7bj7qpiipjtx7sha@vqc6r7lzmley>
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
 <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
 <1166b629-92a0-47d5-8cba-01aafd928e25@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1166b629-92a0-47d5-8cba-01aafd928e25@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 09:11:01AM +0800, Huan Yang wrote:
> Hi Shakeel
> 
> 在 2025/4/25 07:00, Shakeel Butt 写道:
> > On Thu, Apr 24, 2025 at 09:00:01AM -0700, Shakeel Butt wrote:
> > > On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
> > > > When cgroup_init() creates root_mem_cgroup through css_online callback,
> > > > some critical resources might not be fully initialized, forcing later
> > > > operations to perform conditional checks for resource availability.
> > > > 
> > > > This patch introduces mem_cgroup_early_init() to address the init order,
> > > > it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
> > > > by initcall, mem_cgroup_early_init can use to prepare some key resources
> > > > before root_mem_cgroup alloc.
> > > > 
> > > > Signed-off-by: Huan Yang <link@vivo.com>
> > > > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Please move this patch as the first patch of the series and also remove
> > > the "early" from the function name as it has a different meaning in the
> > > context of cgroup init. Something like either memcg_init() or
> > > memcg_kmem_caches_init().
> > BTW I think just putting this kmem cache creation in mem_cgroup_init()
> > and explicitly calling it before cgroup_init() would be fine. In that
> > case there would be a single memcg init function.
> 
> Maybe someone also need init something after cgroup init done?
> 
> Currently no, but for furture may need?

If that is needed in future then that can be done in future. I would say
simply call mem_cgroup_init() before cgroup_init() for now.

