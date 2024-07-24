Return-Path: <cgroups+bounces-3887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105993B915
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E68CB2208D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9413A24D;
	Wed, 24 Jul 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHadiCjB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86518AED
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859329; cv=none; b=JAsjL2G4uIKJ+B3iRWEQr6RWXpOhf+beKdqjf20VhHnE98UccJq92+MO4F0LR0wR+7vjcv07lK9ORgGUm6Rv/C5yW832IfKsRLqVkg4vmWBU0NYrYiBtfMbMg+B4YV/0oE5GJQF6vsNOEeDeGGwj+uLBjVJmcxJXrzgzdSIWmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859329; c=relaxed/simple;
	bh=u2np71yq+1G9WizZLsp1n4+ydiTLdn5jwfWYGD3WPzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edGrfq4vknQ7xIP4eLj/V1+k2Wy+S/rl6GV1e8pcvI9QCiiod6KYA3hrKQBo1IrH6sSx7PIDYc+z/VUp99+DhGI4HEbZgskmiPSru3d9cyR/q4qoLeBgB/spDH1Qrq5RDIo7HsGIeryhMaSV2LASHF02mYvbrMe+H97djKeLAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHadiCjB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 22:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721859325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j36qx1vlc4eJgLuKEjO4bAeumQszgxwbVfIt3GwMYuI=;
	b=eHadiCjBCn9ve/g3AQ/i0M34skHrCjioV9AVLBHBpo7TeMxGy0AN6Ey81EO3ElF2Wujwvu
	kS3zVPOA1RmKaCZvCuLuG64jP2WIk7YB3jJLZC9JnqL1UdScEM9FnTtvtkNpDI62/8TdqI
	tKIQpcxkwBJoUN3C2gPF7W6r/wvDK6Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Tang, Feng" <feng.tang@intel.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linux-next:master] [mm]  :  aim7.jobs-per-min -29.4% regression
Message-ID: <ZqF89Z4uIwnSbpAe@google.com>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
 <Zp8mqTnJN7VJZ/C/@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp8mqTnJN7VJZ/C/@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 23, 2024 at 11:42:33AM +0800, Oliver Sang wrote:
> hi, Roman,
> 
> On Sat, Jul 20, 2024 at 01:14:16AM +0800, Roman Gushchin wrote:
> > On Tue, Jul 16, 2024 at 03:53:25PM +0800, Oliver Sang wrote:
> > > hi, Roman,
> > > 
> > > On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> > > > On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > > > > hi, Roman Gushchin,
> > > > > 
> > > > > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > > > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > > > > 
> > > > > > > 
> > > > > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > thank you for the report!
> > > > > > 
> > > > > > I'd expect that the regression should be fixed by the commit
> > > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > > > > 
> > > > > > Can you, please, confirm that it's not the case?
> > > > > > 
> > > > > > Thank you!
> > > > > 
> > > > > in our this aim7 test, we found the performance partially recovered by
> > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> > > > 
> > > > Thank you for providing the detailed information!
> > > > 
> > > > Can you, please, check if the following patch resolves the regression entirely?
> > > 
> > > no. in our tests, the following patch has little impact.
> > > I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
> > > let me know, thanks)
> > 
> > Hm, interesting. And thank you for the confirmation, you did everything correct.
> > Because the only thing the original patch did was a removal of few fields from
> > the mem_cgroup_per_node struct, there are not many options left here.
> > Would you mind to try the following patch?
> > 
> > Thank you and really appreciate your help!
> 
> you are welcome!
> 
> though we saw there are further discussions, we still share our test results to
> you.
> 
> in our tests, by your new version patch, the regression is entirely resoloved.

Hi Oliver,

perfect!

A patch with a fix landed to the mm tree (you're cc'ed).

Once again thank you for the report and for the collaboration on testing fixes!

Roman

