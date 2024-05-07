Return-Path: <cgroups+bounces-2817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202F8BDFD5
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A294F1C21263
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510F14E2DA;
	Tue,  7 May 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b="eGRKrAns"
X-Original-To: cgroups@vger.kernel.org
Received: from phoenix.uberspace.de (phoenix.uberspace.de [95.143.172.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A14F8A3
	for <cgroups@vger.kernel.org>; Tue,  7 May 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078299; cv=none; b=Wh1P96vPD8h0sD4b5gNtFdIK/MWVuvVcfA0IOWuDdotWWb8qftr23Bg1DTNT2W9GIqL0G4bN/3qsdVpIb6MGHyN/46kgBFltoi3CqpOo88me+yk0sEXa5iiEds76eYckG0kkWNXs6qoQIUCTRL9fZ5qHOy0SmhsL6M+x06H5a+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078299; c=relaxed/simple;
	bh=C5Q8d7JYtURFJbkMrFTwRw8yPtwQ4hTSCRGnP6zKl9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czlLQwTD9WSSyek23RKwtHua7FW8evkOZ+hLFZtEqoMU+SBnfClmSIw9mnbkCikuXTaTqkA9rxZUtaUDh1Y9qXCsj5vnXiEBHoyk/XJKnGw0bkeHu+Slk6OuXH9CXCDE8dQ0oppZouNaDI0g6ddbCYltimexWgEsupW3x/hY4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com; spf=pass smtp.mailfrom=yshyn.com; dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b=eGRKrAns; arc=none smtp.client-ip=95.143.172.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yshyn.com
Received: (qmail 4617 invoked by uid 988); 7 May 2024 10:31:34 -0000
Authentication-Results: phoenix.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by phoenix.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 07 May 2024 12:31:34 +0200
From: Illia Ostapyshyn <illia@yshyn.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Illia Ostapyshyn <illia@yshyn.com>
Subject: [PATCH] docs: cgroup-v1: Update page cache removal functions
Date: Tue,  7 May 2024 12:30:39 +0200
Message-Id: <20240507103038.541462-1-illia@yshyn.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.001507) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 2.898492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=yshyn.com; s=uberspace;
	h=from:to:cc:subject:date;
	bh=C5Q8d7JYtURFJbkMrFTwRw8yPtwQ4hTSCRGnP6zKl9s=;
	b=eGRKrAnszQmFTpMjqn/A5h3sOPnvpexXMqr5mH+Xbxr5GGA7mBEXY0jQfTjle+2TsalgBkZh0M
	XPmoMloDmmeavn24pdfuXuQ/ZOX1Hk73CgbRQOSmEzoTw/XzbHWxWDMuZFYMcezmFEHotwHOf1Z/
	2Pa0npQL2oCKEgBmLjI4BIJwEySseZu2ngdSlsVXEtYJ0U2Ja4+O4hEOgtfwfHrp/gvIz/8jGF2g
	vwtjuqvIrRx1WCYXyjp6FHPWPmaO3vgO2Vtpu3THdw5qrpBbDSz+nnqmN/Rl4fE55aGdrZ0KjjZ+
	uRc+tZ1PD9QO2CEkKpaHZ2WilYbTLk0cvt7QbpAQ==

Commit 452e9e6992fe ("filemap: Add filemap_remove_folio and
__filemap_remove_folio") reimplemented __delete_from_page_cache() as
__filemap_remove_folio() and delete_from_page_cache() as
filemap_remove_folio().  The compatibility wrappers were finally removed
in ece62684dcfb ("hugetlbfs: convert hugetlb_delete_from_page_cache() to
use folios") and 6ffcd825e7d0 ("mm: Remove __delete_from_page_cache()").

Update the remaining references to dead functions in the memcg
implementation memo.

Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>
---
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 1f128458ddea..4386362f2ed8 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -102,7 +102,7 @@ Under below explanation, we assume CONFIG_SWAP=y.
 	The logic is very clear. (About migration, see below)
 
 	Note:
-	  __remove_from_page_cache() is called by remove_from_page_cache()
+	  __filemap_remove_folio() is called by filemap_free_folio()
 	  and __remove_mapping().
 
 6. Shmem(tmpfs) Page Cache
-- 
2.39.2


