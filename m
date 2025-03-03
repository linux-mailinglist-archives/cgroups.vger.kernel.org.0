Return-Path: <cgroups+bounces-6778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F0A4C809
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5683C7AE299
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0625178B;
	Mon,  3 Mar 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6DaKqBF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C2250C06
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019459; cv=none; b=Z8E55Lp8OhKP0KvTyWQOI9Oxpkh41X8jp3Enm0rDRFTmhFHxywa95EcULLW+pfGxzLC7NNt+TrMLGJsF5mrar7x7M3UsRnhUp33L4Pl3UtuMjeEP02x6qEoiunzmZ0AIevEpDsnAjniqFvVescT/Ex7hTl+XTGuDcpOSC+QMVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019459; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy05AqilqdhRpYaGQt/Yish45xNVYkPQJTE48ShO/gUpQy5R2DOQcmZO3Mf/1waGGLd4zPBG0+mz/DmtbKATnIShtWJvJvY/ZR8k7Jz2MYEwW7UmXPKvo6VBnWMoUEhvj76cXhJFMsSEGOAxaTv5II/sFNuGOhLdKSDY5rftnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6DaKqBF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=J6DaKqBFdYLjHuKIdk9lQu5cmv8JAGGt8CiaC3+cI1wPnRxUBUJUGa+gFE7gxwaEr941/k
	ap81YFMVcI7L8iw6DNJGHsJfWT//w2rE630KaP6NpQzFEZDtOY8clyq3hs/Vxd6pJhGU09
	NtMR8LrcTF/zM/IITj+LSw+nSddchDA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-WDfgNm5_N66mWGY_cYKKzg-1; Mon, 03 Mar 2025 11:30:42 -0500
X-MC-Unique: WDfgNm5_N66mWGY_cYKKzg-1
X-Mimecast-MFC-AGG-ID: WDfgNm5_N66mWGY_cYKKzg_1741019441
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so22758125e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019441; x=1741624241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=bYbJ5ZqlgioP3V+7m8JBFD8sx0mM7vnEF+iCNjJYY/m5j/WiVzzix9Tv9chwDBfyNz
         TWCLzHRN+VaFHaVWzKg/vuGy7pBF2nmASGhz7weu31QOLVDSG88Ym5cRWslBGxYfc4ie
         0JP/+YRoSG7sxn74mr9HZH5Oinx8eFQ+m3/HFlBgBVNtVJxZWpfRskjjdtHxdT4Cg/Rv
         68coVlAd5McHwU3k6++csnLj/l8t9TduViiT6ep2GqT5FibutikruacvOHlfUAC0YAt4
         1wyseMRZP/wdwCdRjEUECe5BezY7ZqZJoH5lHDuLi4CsqEbo5ev968Y99nPcAzpvwjsh
         xSdg==
X-Forwarded-Encrypted: i=1; AJvYcCU+X5qjz6cVY61fRsuj+sPw7AEcmhtMWLZO4bx84SdXvWS9eSZuCyG/xc7GX5C5IW+b78qEZv3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYquIV89l2VC4RCloURknf+0uN2Etmg7vftyq53tvW7yUcGWq
	0BxelcRHn20IdXk7JNPUAPbTu1ncoSX5W/3cxxRT89zzSInCVIcMbyPIb+wHTzjZE2A/AQhYWSc
	SxsgixTUHdpyV1r+EsoBPdWxr6TYUMPqD2NspepNdbdWFf9mt25bufY0=
X-Gm-Gg: ASbGncupaGoTLIw9NaGhZvnLj0dJS05Zlsi2UH5BCxqVEeWsw6GmEPGOpo7pRV7gQdo
	n3Yt/y0njBTPInWuYCJs/6L5wPl53UgvdTpdq4bCaNcvA7nepxWDPTiu+N16wfzDxid7wyjXqC6
	N3cBPSg6HG4cLWMqHGzKKEF0KsG6PFqOXTxskyOYNFSsrJ1DH4KlXtUuHOC91bylvJew5XFzxCO
	Opd/QewEBndSQ1eq89LQcArAW2CkqJBxPVQotakrJO5Oo26PZP3iHbZmLW4LenzWtkr4P8inVos
	wmvhU3QPYaZyvMgy+75VHj1LSY3WtS0dUn0WIyRKUs8CtdQCELsZSLJpXXC3d9XebVAfhYLgGHH
	s
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417485e9.5.1741019441214;
        Mon, 03 Mar 2025 08:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6XV9dtRCnC9UYnKtk79gh146334CB5ZefECKJp7wi6xxTybGeqstnFZTU3vfWQysm8+TPqw==
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417035e9.5.1741019440886;
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc1b5db02sm42954325e9.19.2025.03.03.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
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
Subject: [PATCH v3 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon,  3 Mar 2025 17:30:03 +0100
Message-ID: <20250303163014.1128035-11-david@redhat.com>
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

The compiler might decide that it is a smart idea to not inline
bit_spin_lock(), primarily when a couple of functions in the same file end
up calling it. Especially when used in RMAP map/unmap code next, the
compiler sometimes decides to not inline, which is then observable in
some micro-benchmarks.

Let's simply flag all lock/unlock functions as __always_inline;
arch_test_and_set_bit_lock() and friends are already tagged like that
(but not test_and_set_bit_lock() for some reason).

If ever a problem, we could split it into a fast and a slow path, and
only force the fast path to be inlined. But there is nothing
particularly "big" here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bit_spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505c..c0989b5b0407f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -13,7 +13,7 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -38,7 +38,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static __always_inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -54,7 +54,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -71,7 +71,7 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
-- 
2.48.1


