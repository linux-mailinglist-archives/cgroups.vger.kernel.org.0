Return-Path: <cgroups+bounces-6776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA9A4C79E
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F79216E78C
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F02512EA;
	Mon,  3 Mar 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxczAa00"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B24EF8C
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019457; cv=none; b=tfbbG49op6ZSxV/OG7UMjJl6YQjBrbok1DpqRLduo0cdHC5LdvPGXh+9FTBzFcYOTqm0boUyR9Zyu26uUmgpJmMtm1TwfgYFVy0CRGGAp5QEWs68vgs4xyxeSRdrS/jIvcGHEH0p0oho/3jZ0gHUuAJqOQw768ZOdNFhWzYRt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019457; c=relaxed/simple;
	bh=zwBWJQNiZElGf+tnFTiOyJan5xAOzuwmBeeeOxUUAKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbIE0EkA2S6Mz1SxhwC4anxoqDd+18Q70a2zKv3MR3wYm3nCYNl92RIDElZNN3QUKzUVxVxxHYgXhnoxwLA96IeQtJn1xZbBYxEIyUtylLCLw1bRq+AJar6CDQ0PXTwdJG439B0g8nA0ACGn6TAUNaQuSINENLsNt8WV/zAimU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxczAa00; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
	b=OxczAa00ggXMGxv4XdxxHmvRUxJwq3Cy3yvp+dqlC8r4sPeR10Bn7Y+OpvJ20/BX5pswpp
	UlgScbvQvdn62V2oihYbqP6rObGAnPrll8PkD7Z6ZGYZj105R6HvgMwfAsGP3bqo0LRQ8n
	wVzXvxzWvyrBOMP2jAVCB1SkmDFe/oY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-FMeomtK6PV-KBepaqN6e8g-1; Mon, 03 Mar 2025 11:30:53 -0500
X-MC-Unique: FMeomtK6PV-KBepaqN6e8g-1
X-Mimecast-MFC-AGG-ID: FMeomtK6PV-KBepaqN6e8g_1741019452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390df5962e1so2268863f8f.0
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019452; x=1741624252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
        b=eFLPagUNaTKClCT5uDpoj7M5+dTG04m06M2qsI/C9RRTtyWO431ITv50pxj2yJ2DJ9
         Sx7qkHSfeWDLNiUFvCd11ytFYIGFxg5jms7mXSfLND8Sv9VvsxF3BrXuz+/6DCcmM3wG
         GNXFfOuT0EWpudMW3GO60vK4s3OntrbqLsa66zrBKUmGRvWIQsW/lkXUBunD695A+nbn
         65H+0LqBng3ax7w+w6nJ6q7reiEWcIXhFhiLti70HVlew/j95ORumNM2uuZRAZy/agdz
         V3KwHQiEqMCRcBu+JqiPMBPR3KzV3WhT0VNs6c4iomtu4uKI6EyGjUXhHPr3NfRsvcsU
         xCCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfKqrjyJQ5kV0xRhoUvlQrZvDS5ccUUXAb/Iixxfy6GMitXzTJbbXQDVzZkAPwR1rtZVFZlAIX@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZ2M/QwOhQQPw7M3QQusnkHkcmz9lKGUVSUeXZ4+Bz6FB1Xt7
	2Y6kfC+NXExcpxkM3kgkIn8L2YMazX7FQ3WyBM5CPXI1TNsIFsaYrqRGr5sr+KxFvjjPWI5H8VF
	l8yORWzYe+KNfxNFX3ceQ7AVD1Big8iw2u7RNkDQi3TTJV/nwJdzUG8+zAeQi25c4gg==
X-Gm-Gg: ASbGncv8EyF62BmH5QDFxT4ox+1SaMfRYPxeV7v0tkRLE19DF1CK8D1Z8gY9qxYGe0l
	G8AXziMiPXCnSI+fxznQlzs1/4nim8je23qNwVNVzrYypDQS6PssW06E3DZNxzG4+rmlDiRprJE
	sCZEvRvPZ7RAIcwF+oKIzmuGIjYbSwUQK1EqJsjAItF8U9VBskMp/6t3fRPjkrkyQb7Rl+loKIi
	RS6iw0tC59RneJWHtb4pMNAvKC8QDdhwaAQMtBCutYs8YB6bjbjS23YeHtfjt2XR35woKfQXOLG
	F+tMPrz3GOZJEf+ckuo7vUuch4y1o4lyGQswb+jlJKm5Sx9oRiGdl8CQ4VKX/rxfqB7g0Or84KL
	m
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358465e9.1.1741019451747;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzQb6PWhSpsnKcZbPTy2ai+36EkVbTPhZ8phSQIWx5xoPi2ki+HFSKpKKxfbHb4k7pKztumg==
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358005e9.1.1741019451351;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b736f74e8sm172202265e9.7.2025.03.03.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:50 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 15/20] mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page mapcounts in large folios
Date: Mon,  3 Mar 2025 17:30:08 +0100
Message-ID: <20250303163014.1128035-16-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're close to the finishing line: let's introduce a new
CONFIG_NO_PAGE_MAPCOUNT config option where we will incrementally remove
any dependencies on per-page mapcounts in large folios. Once that's
done, we'll stop maintaining the per-page mapcounts with this
config option enabled.

CONFIG_NO_PAGE_MAPCOUNT will be EXPERIMENTAL for now, as we'll have to
learn about some of the real world impact of some of the implications.

As writing "!CONFIG_NO_PAGE_MAPCOUNT" is really nasty, let's introduce
a helper config option "CONFIG_PAGE_MAPCOUNT" that expresses the
negation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4034a0441f650..e4bdcf11d1b86 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -881,8 +881,25 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config NO_PAGE_MAPCOUNT
+	bool "No per-page mapcount (EXPERIMENTAL)"
+	help
+	  Do not maintain per-page mapcounts for pages part of larger
+	  allocations, such as transparent huge pages.
+
+	  When this config option is enabled, some interfaces that relied on
+	  this information will rely on less-precise per-allocation information
+	  instead: for example, using the average per-page mapcount in such
+	  a large allocation instead of the per-page mapcount.
+
+	  EXPERIMENTAL because the impact of some changes is still unclear.
+
 endif # TRANSPARENT_HUGEPAGE
 
+# simple helper to make the code a bit easier to read
+config PAGE_MAPCOUNT
+	def_bool !NO_PAGE_MAPCOUNT
+
 #
 # The architecture supports pgtable leaves that is larger than PAGE_SIZE
 #
-- 
2.48.1


