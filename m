Return-Path: <cgroups+bounces-8576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A2ADE002
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 02:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33ED23B0B20
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9C2746A;
	Wed, 18 Jun 2025 00:32:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE402F5313
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206774; cv=none; b=C8hGsgEkb71pkuj2KU7/PINEqsiPZ5DmTBAIxOHVQ31LSxA6MdY+x9y1QsVRjbYbD/uXkYiFez/guQcI9NdvOFwbf7JLypCPpob6uI6+5m8lteeD9VYI/mvdo5JJEmxNnaJhyD9EgycT0uoU1j/AO+eWrF40QQQuA9NJfG2Yo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206774; c=relaxed/simple;
	bh=15c8zD8d9fkx1SJoe4Az2NzfbKQnWUbGfWki/cR33K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1fO8dk56z+aClDWUsyXYzygiHfV0kMi4FgPZj8b80YWNWAU0amp5aFjYcm+1L231229aLM/wGYkEP8NzD+qOBOko2GXcnEOI+uFkkQPyha7uiaRWddpFIslPZiD2cdihA2/NcGVDmZM+U4lUmDNvr12fNZr9sea5+Jp1CfB+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 18 Jun 2025 09:32:33 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 18 Jun 2025 09:32:13 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	muchun.song@linux.dev, iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>

On Tue, Jun 17, 2025 at 02:23:07PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Thu, Jun 12, 2025 at 07:37:43PM +0900, youngjun.park@lge.com wrote:
> > Example:
> > cat memory.swap.priority
> > Inactive
> > /dev/sdb	unique:1	 prio:10
> > /dev/sdc	unique:2	 prio:5
> > 
> > - Creation
> > echo  "unique id of swapdev 1: priority, unique id of swapdev 2: priority ..."
> > > memory.swap.priority
> > 
> > - Destruction
> > Reset through the memory.swap.priority interface.
> > Example: echo "" > memory.swap.priority
> > 
> > And also be destroyed when the mem_cgroup is removed.
> > 
> > 3. Priority Mechanism
> > 
> > - Follows the original concept of swap priority.
> > (This includes automatic binding of swap devices to NUMA nodes.)
> 
> How is this supposed to work
> cg1     /dev/sda	prio:10
>         /dev/sdb	prio:5
> ` cg3     /dev/sda	  prio:5
>    	  /dev/sdb	  prio:10
> cg2     /dev/sda	prio:5
>         /dev/sdb	prio:10
> ` cg4     /dev/sda	  prio:10
>    	  /dev/sdb	  prio:5
> 
> when there are competitors from cg3 and cg4? Which device should be
> preferred by each cgroup?

Hello Michal.

What issue is the question assuming the existence of competitors in two
cgroups trying to address? Could you explain it a bit more specifically?

To answer your question for now,
Each cgroup just prefers devices according to their priority values.
until swap device is exhausted.

cg1 prefer /dev/sda than /dev/sdb.
cg2 prefer /dev/sdb than /dev/sda.
cg3 prefer /dev/sdb than /dev/sda.
cg4 prefer /dev/sda than /dev/sdb.

> Interface note -- try to make it "Nested keyed" or "Flat keyed" as
> described in Documentation/admin-guide/cgroup-v2.rst (like io.max or
> io.weight), so that it is consistent with other cgroup v2 APIs.

Yes, it looks like the API format should be adjusted as you suggested.
Thanks for the review.

Regards,
Youngjun Park

