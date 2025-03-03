Return-Path: <cgroups+bounces-6781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81DA4C7FA
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AE43AD6A1
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6EC25C71D;
	Mon,  3 Mar 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgT4uc1D"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1F25744B
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019470; cv=none; b=Nagum1L4GrZr8RolDbFCQk6UxcYYMYtRC9A1jzN1PB8FBybWofGgbB5CV+nfTJqCzZTzW1Oi6zKuTBbrp6FPWBnyr9gE/i4YrD/7VT88KvlGLXEQqF6Q0u1D51u3xnVWTi2FsBbnpWbS17Ne/IlZBJPFvm4T8e3JzdYBSx64D50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019470; c=relaxed/simple;
	bh=tLoq8V+yWL9uG7J57/fSv64hWMwnlNF56fAlUed9ZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJb76UyZBjgn+yl5NUipjbMw2oZ6kZfOA3bwZwIdJb0dIJE/Mg6rsH3CZJM3yZqISxQy/OpTaX/KF+Acbi2m69fG9sxj72Mi1LMLxyvkf3TYSvbWsgec4qyRgEbrXNEDARagNpW7UAf8G8kR9tk+teqLfeRyPJv8YE/+PVF2Dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgT4uc1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbAdVb8IlT1mHMxqkPSZKSMArZKBklKlP7kdJIBKPLI=;
	b=WgT4uc1DUmw4bzUnr3DfGO/2tR4NfsWkn5u7yWuN9zkmfOFCNlvXQ4gkggPeOHoe19Tk+L
	bKn9oDoHnKS7iMJ4Jvn3NFJS4cTDnuOqHTEziT+TFeEP9ajHI72eRl/Bnz+i8hlYeudvib
	qmgTLg6QKzh2HdBLR9bwuMeNcK5ZqG8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-rlQlqb9nPxW_eazhIhrEXA-1; Mon, 03 Mar 2025 11:30:59 -0500
X-MC-Unique: rlQlqb9nPxW_eazhIhrEXA-1
X-Mimecast-MFC-AGG-ID: rlQlqb9nPxW_eazhIhrEXA_1741019458
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso32337675e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019458; x=1741624258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbAdVb8IlT1mHMxqkPSZKSMArZKBklKlP7kdJIBKPLI=;
        b=tDk+AskXgcS+A9GlZKPzPbF2oCIPVmI9aiwNjCFnmsIzGbk/9Ng2EY40K0mddSZswJ
         j+pKoLyPgXUaBqXXMfqxx2c3l9zqBNlegpzuxrI3OZ/taJD2JRCnIJQvZFLjFFqisUbJ
         OTxK3PvSsUVwi38Xi8ysWs3sZumBcKh8PFv6qcmO78YqBh6TgifYM2XeGW30P6f8UCTL
         bJCSU6OTn88kqDdU9JhXjFsQA3G1nfgym2mcLOfj7W9zi3JEsjMDwZZisqi8RGNvI7yR
         H9eb/wHFV8FJmo8eMRTxX4cMf7KKYc4fTA0pgs4NXjJvTidAm2yxPE4KROR8dXUM1JBX
         bQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKh5d8W6ZnG7R4g8fAJhg3Rliora+Mfgp+0hGDVjOo7cPvUoWLx3HX57Gy6H5xRkACfyahPsx5@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVg+XmBOiwrN/QmgUjXKQNJSFyxCJMLphrAWIVkoBupl9CB8M
	wCliO1c78Iaph2V5Jgt065+xFVGS3+1y9isp9bPQYN/OD/jRbQmLnMQMo0xuzgBeaSIBSHnZ+2I
	Nf73aN766ag9PAcd7+F0uyYN7Wz+KX0vYOBt9POG0NHbBqHwUdvYYHcg=
X-Gm-Gg: ASbGncsySlJq7bRPTvt54bQGfQ+fbizFoBsfWBD/MHP4fjQQJd5Wm5LTVZwXlDcMwKj
	qgGtfHY3396tlD+SXL9rFBEfEbAhFcuEyXixrFPCCP9/upBrzlvmnw6Tqvf7cXbzv4CuqVGhywu
	5IpPcwygbce1XLE3wFEtTPGBBvujk9Kroquu0MXqqMlSGZG7XF1EC8kK2IM3Dw90W7qp51IBnAU
	rRYljN9MdaQAznnYbQ4Sjd3/FnSNKFrANOiYk7Gunyvq2RiUMBuW1DLxKG1rX6mLjtEoUadrV0U
	TeIa5Ean54FQdO737OjkroG4Y9Dw0oxCnI4O93wR/V/gb6vYGmWERE4iVgloBvMna7bUsu5TAWY
	s
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr10994382f8f.12.1741019457883;
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvRr8UGYMtbKKLfF4vYk+epXuFbk91XT0kZhy1XfmXmyE27quXMsv2mgA7hFUbYP+d7m+S+Q==
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr10994345f8f.12.1741019457510;
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6aabsm14858335f8f.26.2025.03.03.08.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
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
Subject: [PATCH v3 18/20] fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:11 +0100
Message-ID: <20250303163014.1128035-19-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

For calculating "mapmax", we now use the average per-page mapcount in
a large folio instead of the per-page mapcount.

For hugetlb folios and folios that are not partially mapped into MMs,
there is no change.

Likely, this change will not matter much in practice, and an alternative
might be to simple remove this stat with CONFIG_NO_PAGE_MAPCOUNT.
However, there might be value to it, so let's keep it like that and
document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 5 +++++
 fs/proc/task_mmu.c                 | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08ba..1aa190017f796 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,6 +686,11 @@ Where:
 node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
 size, in KB, that is backing the mapping up.
 
+Note that some kernel configurations do not track the precise number of times
+a page part of a larger allocation (e.g., THP) is mapped. In these
+configurations, "mapmax" might corresponds to the average number of mappings
+per page in such a larger allocation instead.
+
 1.2 Kernel data
 ---------------
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f937c2df7b3f4..5043376ebd476 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2866,7 +2866,12 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	struct folio *folio = page_folio(page);
-	int count = folio_precise_page_mapcount(folio, page);
+	int count;
+
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		count = folio_precise_page_mapcount(folio, page);
+	else
+		count = folio_average_page_mapcount(folio);
 
 	md->pages += nr_pages;
 	if (pte_dirty || folio_test_dirty(folio))
-- 
2.48.1


