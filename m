Return-Path: <cgroups+bounces-5424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FDB9BBF36
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FDD2810CC
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797151FA25C;
	Mon,  4 Nov 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cSOQ1Pu6"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC1FA262
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754374; cv=none; b=nSOobcoPOTGanJ3GhUlUGW+jvUKbVNQa47o23c8WLRQWlmZnj/q8d6r10jvge+ROlOI+W/Pe/+TBen0wauaOQwcMj0Yye95gP4LdMCsLe9g47NsChVgDRedmYYsuEFyy9zvWLUBsIas9Ui70x40mUeF+kCsmHQIbIyzCPeD4pdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754374; c=relaxed/simple;
	bh=bUGogHrGu2IE5RYC+uh2HwpqyDzawug5xUwgjF/YeVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKjSGDpo8c4yMqg5lX2k5KXSHCh+p0A1XWv9mR0D+a6INf3rr4bYJtHwiADaoP31N7O8HBNbe8IwpNWi9/Oi5avdR7RiVhBBFGbUce/YN8DPMxxwjRUznmLIR9RkTPkp52pGPZwwSVcRRNey8VtNV0w4PJrh8YhvN4cOIGI175g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cSOQ1Pu6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IPUXcSba4hpDc7ZFq/hxzhhDKtMBom8UcmG+num2BO0=; b=cSOQ1Pu6GnAZ3ImVSgvtG+e6SU
	rnBmGbx5pNW88okR/IXYaHGOG6KOVF2wKO9yra3Csq37veyeGMJOyuYvkLAfFDzdaWUk+/ochSu4x
	MWCYL6RoMkQyigFTGxheL1GjuHOOQpHHZf4ORw5pH0kRnjMdnoWDM95TqHKuXX5Lb/KMxIJ8nwbr0
	yJ3MyHcERJWj3TTcQPaojrgEed2gELSyomQxevh4iQdn6dE7IUKhSf6rGdGPK6JYYubAf0DXWQtai
	XFNPcpU6z+vQBvZe7aS8VRK0uu3omII1KLCe/zRcdykJavOyq6PngM0dqlJT4qjh1+sGQ5lvoEXEQ
	gJYJy4+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t84Gy-00000001ZYI-0DQB;
	Mon, 04 Nov 2024 21:06:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] Introduce acctmem
Date: Mon,  4 Nov 2024 21:05:57 +0000
Message-ID: <20241104210602.374975-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a step towards shrinking struct page, we need to remove all references
to page->memcg_data.  The model I'm working towards is described at
https://kernelnewbies.org/MatthewWilcox/Memdescs

In working on this series, I'm dissatisfied with how much I've assumed
that every page belongs to a folio.  There will need to be more changes
in order to split struct acctmem from struct folio in the future.
The first two patches take some steps in that direction, but I'm not
going to do any more than that in this series.

Matthew Wilcox (Oracle) (3):
  mm: Opencode split_page_memcg() in __split_huge_page()
  mm: Simplify split_page_memcg()
  mm: Introduce acctmem

 include/linux/memcontrol.h | 28 ++++++++++++++++++++++++++--
 include/linux/mm_types.h   |  6 +++---
 mm/huge_memory.c           | 11 +++++++++--
 mm/memcontrol.c            | 29 ++++++++++++++++-------------
 mm/page_alloc.c            |  8 ++++----
 mm/page_owner.c            |  2 +-
 mm/slab.h                  |  2 +-
 7 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.43.0


