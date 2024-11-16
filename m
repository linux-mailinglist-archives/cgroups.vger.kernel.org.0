Return-Path: <cgroups+bounces-5594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923C9D002F
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B2C1F21ADB
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1F199EA8;
	Sat, 16 Nov 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="uxU1GykK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B41946AA
	for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779971; cv=none; b=FFPk8Uo8YMvCBviFmQ32UF2MudcRWL6DT3iu0fi8frl0zOpih1X07rrAWqo+PajTs0lIv2cCVb+XZgnSxqHiSE8epRwii2VYIA+o2QYusiYnJcTA6mwUEkyvTSaGOQYvSMtSIY1a823KYMHx67WMgIze+fH7r5gN2verb76ab+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779971; c=relaxed/simple;
	bh=bIwDxueUJud+n2/mIeUPWBecNLHhmDU7Xn2mmiUGf6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/NczYSdpCS3z5haIzbeCn629jx6i/XvaN7XGlZ5Os19wFCCqcRQTWcJ7OOe0Paxl5rFMOVjOFdiwNG7HTSnL8bfthM+Z5AVjQr7cDPNSFPSb8RlMWtTAOuXV03mB05Ewyu1pE2N2OQzFyH+wPHdbkeKqh9QMypOrWx7UJfelYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=uxU1GykK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d3f52bb704so14417126d6.1
        for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779969; x=1732384769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NgfUO+bQWj6bU8BgCVOh0fIa47vMCexDt60Dq7gXNk=;
        b=uxU1GykKNMZCbWxpjzqobztisCh9k6Tx6uWhHxXDuyD+rXG48SF4MUVGkr0KkfMDwl
         qzZAop8JzhtNcpREH+mcVL92W0+hSfPBkUt9iju8Izy1dJuI4okjTgyNs0qcAr7zhC31
         sjwoOKFCcMxj6cMFpEVKHFLZjkjOGRoPc2BolRWiSUO3bmVVB+WUoS7NoHUwUgenHoRA
         5mt8Kb4SKK1Vb1U1G+5J45gy1L+cDlPB/6ye2wugK5PnYUHmh2FydpbweLslJ0E6yeWH
         aq89LNXrEaARk499i9WTH3nLaxZFM9q+DCSTgqtLH8fYzKiP1Y02rsYespE1knE3ux0z
         0jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779969; x=1732384769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NgfUO+bQWj6bU8BgCVOh0fIa47vMCexDt60Dq7gXNk=;
        b=Q39moorpukeYiimBg8ObVUHtoU5EL+cE1/Jv8c7B8Gfr1/MDM3n+FGhNy/C7EPnTfU
         MdYWTEnF67PP0J/Jb3l8CACpYYWwSgL1g1XL0zEdsxxtl63gUwmmK29lmo1vKMQpQSK5
         dZ/63OjgthgsCaxCxziv47MvQvqeKBzyD48NyvWLqAvjGLBfSAhns2dGETu9klMGwndf
         0VMMTV+Z6U+nma2QyFTvrOMgCMXQH+hpGjKtFHITeESQgCnYXOqiCPR3XkVi/jbnhrW4
         bjj7AqcRYLWRY3nBrOkd4iXHkCuCvZ2dgt5GHNN3aW33RYToHfqcDBqXpgHb+lrW043T
         EbCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlWcEHJL5967qD3Dh7XHZ8E3zEj/7vIjYZQbDxGIwjOCLQbptfcg3HgHWHYpAqKyVoAo1AAvb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bF2GXVI3hnHqZ14yMn0DbHmCtgo0pyIbkCRvamwn3DP8m3ua
	LgrUmXMt21YfOleWtVhwPvaVmgVoqymMW8GrlztVL7JfTa5MAoV0OV2Rq8ppUt4=
X-Google-Smtp-Source: AGHT+IEMOLNEsp5sqgIkt52tiSL0kf4hziLkF3l6oWPXAHVLzfNvt2ajo6yR1l9MnxJe6dgs1UWO0g==
X-Received: by 2002:a05:6214:5d0a:b0:6cb:e6b2:4a84 with SMTP id 6a1803df08f44-6d3fb7cc924mr77641716d6.14.1731779968837;
        Sat, 16 Nov 2024 09:59:28 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:28 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page table
Date: Sat, 16 Nov 2024 17:59:18 +0000
Message-ID: <20241116175922.3265872-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Detective will use it to walk the kernel page table. Make this
function accessible from modules, and also while here make
walk_page_range() accessible from modules, so Page Detective could
use it to walk user page tables.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/pagewalk.h |  2 ++
 mm/pagewalk.c            | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f5eb5a32aeed..ff25374470f0 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -124,6 +124,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
+int walk_page_range_kernel(unsigned long start, unsigned long end,
+			   const struct mm_walk_ops *ops, void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5f9f01532e67..050790aeb15f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -478,6 +478,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	} while (start = next, start < end);
 	return err;
 }
+EXPORT_SYMBOL_GPL(walk_page_range);
 
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
@@ -541,6 +542,37 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return walk_pgd_range(start, end, &walk);
 }
 
+/**
+ * walk_page_range_kernel - walk a range of pagetables of kernel/init_mm
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * Similar to walk_page_range_novma() but specifically walks init_mm.pgd table.
+ *
+ * Note: This function takes two looks: get_online_mems(), and mmap_read, this
+ * is to prevent kernel page tables from being freed while walking.
+ */
+int walk_page_range_kernel(unsigned long start, unsigned long end,
+			   const struct mm_walk_ops *ops, void *private)
+{
+		get_online_mems();
+		if (mmap_read_lock_killable(&init_mm)) {
+			put_online_mems();
+			return -EAGAIN;
+		}
+
+		walk_page_range_novma(&init_mm, start, end, ops,
+				      init_mm.pgd, private);
+
+		mmap_read_unlock(&init_mm);
+		put_online_mems();
+
+		return 0;
+}
+EXPORT_SYMBOL_GPL(walk_page_range_kernel);
+
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private)
-- 
2.47.0.338.g60cca15819-goog


