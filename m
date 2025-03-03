Return-Path: <cgroups+bounces-6765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A47A4C784
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D34D3A6743
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B3B23A980;
	Mon,  3 Mar 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Riz2rWRF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C33238D34
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019430; cv=none; b=HCk2aAbeYDV1zKvrZtaRDT9DdhD2V9qo6fe6zsfqIsDx2xczaLN6Ls3XPP+2abPotbL9sqXNPcE6AWBcjbunzKYh00Oue0Nv8hF9Z1/yhkHkRuX5i/gGtkKrDUmovKuLvO/InmV5Vonp+4CX2F/yvODfohxylmVmLbGosLX9DGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019430; c=relaxed/simple;
	bh=ixANMC3lPCVB+QxhgoNOds44O6e5NynuKFD7IIp9IVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICnuXtURz6ElC03/B2pWtNqyCWvwYzuNVx8XWUtH4FCUedDvvknCLZWWO59JE0PhnP6JaIxgCWNgaMo3cxwi/oX/TZ+x7BuIOT1AQtfkju74RonPJ92TqS9IqIJXoOaMWL8SAg8C13WULPObCMyq2hn5ZnTFmK5xxyZ64shkD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Riz2rWRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXsaZOoTqmrj90mJbBg0yoAKUyLdOWV9hsabR6NX2f0=;
	b=Riz2rWRFO3x5/chzOAssiXnAEfN9V+dv3CeWZ5SLSOdlzpbrzsf3MbYwe+yuEN8krCsUwh
	G+fxTiEBT/kC+KyOtkjCMjn9clsZ98euMgM4wrwatx7C2aEq2y6HrZWryxnOvoX4jS55dW
	hs6fk9SW7nlddUPBws7hBEUfulG4EqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-nAMr9M29PQekFvUkCYScrw-1; Mon, 03 Mar 2025 11:30:27 -0500
X-MC-Unique: nAMr9M29PQekFvUkCYScrw-1
X-Mimecast-MFC-AGG-ID: nAMr9M29PQekFvUkCYScrw_1741019426
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ba50406fcso27671665e9.3
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019426; x=1741624226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXsaZOoTqmrj90mJbBg0yoAKUyLdOWV9hsabR6NX2f0=;
        b=vAkaH4uV3eCIKIg7Svm3xRE2F4+XhElaPcAClUbQ2+3+tb+rOZn9HiMwX5tZeis5ic
         t08IaLqFo0QBHWeQ0jnyQjyoKKrd0oZmq1ZI19gxjgiB5K7QBOwrBZiBj5vbpVg5KlZb
         rV2ZlpfqolXdGs2BN30fy6BV4VDK+tg7hf3B3BhkGSASbhoEUyWZPnA6aKW9ztDl5iPJ
         qgvGl9jwqy29rAvHXIsH2+34EFlJ/glh7jHGJyAvTEKBQXPrnqoB/g5IR5wdgxOWHGPV
         RCnXufTnHVzmHjDlSotBrON1UTIkPg1bHdFW2oSFihoEJ5o5cSZDdisIc/xu9gbPMpIE
         00Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXPzhH1Opj7REJyf2PK+/3/r8mUNhfvHfkljMQKh3RU0Y2m/hE9wLOtmwAlHwyDUtAI1YKt+hgU@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiYDPb0/Dmnmw+gB31r74CEmwnRQC6E9oXa1OrgOrP2u2iEib
	wWjCLhLHyn8eI/w+BfGFXLCt2TVgKc9OanqQiOwqW5ZVauoOkR77FNiMkPSsQrz0NVHdjzayieb
	o4NuUaah055X3Jv6VeiXq0mcRQrqmn0jbJFwxjIInHlKsnxLGvFsd0rI=
X-Gm-Gg: ASbGnctPYej6c0pAjrx9XZa8uEBmMPQOJcREqBZQd9NxgrYqH5xNswXherixrqhj8a8
	qDcxMLSzWYlv8G4WXgZ5KrOVPiVeNkPmh2X6iLAlz67koPmmeu2LM8frSZNuBHC3HGvrhX7c+Si
	SsGkf5R0qFSOgJDosWFqE61wvh7sabNoqn0+LCwqA/kf1GzNyis57NNHJ9PdOBnUTXf8rKxb4Vb
	0vcY7MNLzg6/D3NCAi6tVcjZNtI8uyW0PMcfY7wLrQ3ANDSUGuu9JRFvSrpLQ+K4pJK0PU89Csc
	1KwQAPOzNYumED2pCHP8L+DYZCoFZtCBGFyuS1eWXX0c3vezzx0tRziWuyUa/VaoAQkoowYg5q3
	V
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f49a with SMTP id ffacd0b85a97d-39109b2f905mr4268662f8f.55.1741019425849;
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyH4J1EAqaHR0tUbY9OuS6FmG3s0lngE2eSOblLtE+C7Z78Ry//BFuo4023zOsYhDT+DJ8lw==
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f49a with SMTP id ffacd0b85a97d-39109b2f905mr4268630f8f.55.1741019425450;
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a7b88sm14820945f8f.40.2025.03.03.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
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
Subject: [PATCH v3 04/20] mm: move hugetlb specific things in folio to page[3]
Date: Mon,  3 Mar 2025 17:29:57 +0100
Message-ID: <20250303163014.1128035-5-david@redhat.com>
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

Let's just move the hugetlb specific stuff to a separate page, and stop
letting it overlay other fields for now.

This frees up some space in page[2], which we will use on 32bit to free
up some space in page[1]. While we could move these things to page[3]
instead, it's cleaner to just move the hugetlb specific things out of
the way and pack the core-folio stuff as tight as possible. ... and we
can minimize the work required in dump_folio.

We can now avoid re-initializing &folio->_deferred_list in hugetlb code.

Hopefully dynamically allocating "strut folio" in the future will further
clean this up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 27 +++++++++++++++++----------
 mm/hugetlb.c             |  1 -
 mm/page_alloc.c          |  5 +++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e81be20bbabc6..1d9c68c551d42 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,20 +405,23 @@ struct folio {
 			unsigned long _flags_2;
 			unsigned long _head_2;
 	/* public: */
-			void *_hugetlb_subpool;
-			void *_hugetlb_cgroup;
-			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
 		};
+		struct page __page_2;
+	};
+	union {
 		struct {
-			unsigned long _flags_2a;
-			unsigned long _head_2a;
+			unsigned long _flags_3;
+			unsigned long _head_3;
 	/* public: */
-			struct list_head _deferred_list;
+			void *_hugetlb_subpool;
+			void *_hugetlb_cgroup;
+			void *_hugetlb_cgroup_rsvd;
+			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
-		struct page __page_2;
+		struct page __page_3;
 	};
 };
 
@@ -455,8 +458,12 @@ FOLIO_MATCH(_refcount, _refcount_1);
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
-FOLIO_MATCH(flags, _flags_2a);
-FOLIO_MATCH(compound_head, _head_2a);
+#undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 3 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_3);
+FOLIO_MATCH(compound_head, _head_3);
 #undef FOLIO_MATCH
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70a012af4a8d2..c15723c8d5e7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1634,7 +1634,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	folio_ref_unfreeze(folio, 1);
 
-	INIT_LIST_HEAD(&folio->_deferred_list);
 	hugetlb_free_folio(folio);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ae0f2a2e87369..2fc03cb13e49d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -975,6 +975,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		break;
+	case 3:
+		/* the third tail page: hugetlb specifics overlap ->mappings */
+		if (IS_ENABLED(CONFIG_HUGETLB_PAGE))
+			break;
+		fallthrough;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
-- 
2.48.1


