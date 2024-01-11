Return-Path: <cgroups+bounces-1124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24882B491
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B7B1F2659E
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEA537F5;
	Thu, 11 Jan 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWJMMolU"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0453819
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=L6tb+LUtt/u1QE3HcsntEhQyVLjkGvUUPfsLsWn4vPM=; b=CWJMMolU8eDy4VFyjXBgukvYHp
	Zkb/jHTQcLXtgsQ7SIKZKkFlR7kIVoJX8HTVLVG2nxR1D36anjxVv0pzqCmHZsRwGxBZaRI84RWst
	SnTPgcOH6u6hlBDfqTMWyg54oRoPIbNgKFVZIJN3eSwjETyjY7LKMMG4NWEsPz2y5S5w9RuuRkouG
	RSl3Wmv6RNYwzAUfwYr8d1Ze64e5zSXMOPXscGsEEvZd0+TgOJj4aMDwJyAJrbEChUGNDW0eXyKcq
	UjiCcJnq5vDwtuvJDorqsd6bDN1QRnZZLrhkHQxacLfk1CelWZXQ8GyyNdzDB0DsuahLr3xkziLPY
	9B/qrzNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzXR-00EWqw-BP; Thu, 11 Jan 2024 18:12:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] Convert memcontrol charge moving to use folios
Date: Thu, 11 Jan 2024 18:12:15 +0000
Message-Id: <20240111181219.3462852-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No part of these patches should change behaviour; all the called functions
already convert from page to folio, so this ought to simply be a reduction
in the number of calls to compound_head().

Matthew Wilcox (Oracle) (4):
  memcg: Convert mem_cgroup_move_charge_pte_range() to use a folio
  memcg: Return the folio in union mc_target
  memcg: Use a folio in get_mctgt_type
  memcg: Use a folio in get_mctgt_type_thp

 mm/memcontrol.c | 88 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

-- 
2.43.0


