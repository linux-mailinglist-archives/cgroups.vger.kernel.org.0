Return-Path: <cgroups+bounces-14375-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HrvNVwjn2mPZAQAu9opvQ
	(envelope-from <cgroups+bounces-14375-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:29:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CDA19AA4C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FF230B7146
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F5324707;
	Wed, 25 Feb 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrMI/oge"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7423ABB9
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036615; cv=none; b=hJRRrN4qMDj3C7K5p2an+3W9KbdTQIk9EeDVsjWDqFubpWgev97umKu/9oO8Umd7E4GRVFkffOMKHnwirX1Y+nZ1cmnhvpWa2slatFzkFrUWPyWXRrCAnTsrQyQ0JBsa8FhRO7X72LjC7yGI9RB7LsT4Ln0WuUrhycIgNLxFWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036615; c=relaxed/simple;
	bh=Weuq9NOr4EE8HFSVzkX9AfjgTaI9mVdLfkc0Epf387M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRkWLaCXuyk67A3PiP4mVeXH8YOp5R5lSmJjoeh1k3gH2IaVbKQVdD0YVc+244MvqkdSWlkjXXlkP4VRT32xXTvz4cyJbZ8rVQULtbKa9BNLuhyqBe89o7kYZiq1KKgbCzk6Xz+AF4yr4OUeBtyUPHMV0/Lky/k95jVmwVwhVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JrMI/oge; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Fxhu6JylkiDzMEjDuKttQE1tDuQQiQGKZbk6dmKVauI=; b=JrMI/ogeMG5ARWoH7nHxTdwz1c
	1WigUWPSDL/tBc6/MJCvGPEsYLso4MDLWEQ67hdA9u6mxgKSfEZck3k0WZpk5nP+XTLv3e4euQ9Rc
	fBhqQppdIDwa8rLrvOx3oqqfp0mFjlpUXwtBa/Rt5TEiE8fhekPjOMYGdm5lZZNShw3QAiNGaoqCx
	KY7VvhUCR/rpICJMpLn+Ge/NN8wawNIhBOfgMY8aq1Hwv71R1U3szl7eankJB9q+tkXgkoeEjXN8v
	RJt6NQU5eOzDbWKskkRx9IIz/tJLs+/KLyMShzZoXtmfMOmbr2uSZCk2hhVovwxujRt+800kJ8VK9
	MOuFv+Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHfV-00000001K4m-1vwH;
	Wed, 25 Feb 2026 16:23:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/3] Make memcg location more flexible
Date: Wed, 25 Feb 2026 16:22:14 +0000
Message-ID: <20260225162319.315281-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14375-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 50CDA19AA4C
X-Rspamd-Action: no action

Different memdescs should have the flexibility to place their memcg
wherever they need to.  That means that instead of indirecting through
lruvec_stat_mod_folio() and extracting the memcg from the folio,
we need an interface which takes the memcg as a parameter.  It turns
out we already need to do that for slabs, and this memcg_stat_mod()
interface also works for that use case.

Matthew Wilcox (Oracle) (3):
  memcg: Add memcg_stat_mod()
  memcg: Simplify mod_lruvec_kmem_state()
  ptdesc: Account page tables to memcgs again

 include/linux/mm.h       | 15 +++++++++++++--
 include/linux/mm_types.h |  6 +++---
 include/linux/vmstat.h   |  9 ++++++++-
 mm/memcontrol.c          | 40 ++++++++++++++--------------------------
 4 files changed, 38 insertions(+), 32 deletions(-)

-- 
2.47.3


