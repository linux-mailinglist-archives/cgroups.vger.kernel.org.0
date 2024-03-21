Return-Path: <cgroups+bounces-2091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A1885DE0
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 17:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA4D1C21DB1
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6F134435;
	Thu, 21 Mar 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4FHCXL7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF42133998
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039044; cv=none; b=Mwsi9ZhfTfHKANNC0lc4ukmMt90wvRRQTq92nuqq08/FjLLKzBEuG/fg60Y+5P3A+kLoZbp6kbwlWywoN1MeKlbX21ofkOA5zOAyvxAZTW8kJ1Z3jTtli5aBSOH88wtEubuddfyUveQ3JdnPNPYDcbF73OgRzQOcTWyiUXoIxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039044; c=relaxed/simple;
	bh=nBNRzF0Iut6QyhQOmkq9JBSnSgGXOLqouFUVdOAZ0nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+ExiVRADV66tUR84oqTuLiRjADDNbyv880jSvTB82lusGTDLz1f8+ucZ9LcQNYpp+9W9bmR8RRMNzY8tNbTZ/81l+ucnKZcGE5UnK+iMpB2e2mQRyjQW2opEeV0upChcdLv+Uq+QjyFUkiVgrIzis9oS0eRyIrOzp381J85vPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4FHCXL7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2068710276.0
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039041; x=1711643841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDSqL7VR8RZR1D2YCsFy3ymp62hocq5f4M4VfhBDRaA=;
        b=o4FHCXL7S1XHVpQeOSbpxUdy4YHwNEpft+EDbDIoPSWXtf/r/lOzMIv9MiqSZsubPp
         B7BMfZ37Tkr83ngidLd9d+yDPAB2EC2xHg/3kbzNBCzgaavx0VLaIbfJWyA2CEFlpCqX
         guXwBJpagmhzdDQwyYNVo48OsDSgIpE/cVwyq/LyVR0RftfLYSLjYSbOa7oimju7809f
         NxieKkMoVisF8cEuSJKRgC4dK3N1KTq9XfHBEJsZh3bSVyCNX605LIuGblPOuAabh3v0
         6zryspl0ofJtkD7kyXHzmqRLPsHg56xr40T2IR07tHgOHw7HMOZTB9v/Qf138HX0qxKX
         sTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039041; x=1711643841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDSqL7VR8RZR1D2YCsFy3ymp62hocq5f4M4VfhBDRaA=;
        b=cTwwd/6Q7A6+cZMLAIsEaA5ae/M/y3qLym4pdlv6Un8LCW/2f1CghkJJTNgwd/ts/1
         7dyxi54eMUCBIcfbmgcOiPn+qophRIKaw1YhLPJ8r78qcSqnzv+F0Kek08X6PzBw5tGT
         c0uch85DOUrBzNjK70XdCQ/oHAhDrsVSVu1kSiTdY1773iTwlk7NtaxcTISiIiFB/Uv5
         cT8j4qDwsToHOJQ+8vtvJl+gKFnpVDmchiGXwS5UueO9NuHxgOk2tXXJJ2oxtStvIIpU
         sbKW/soNW1gQmRYNbEqSHDWNw5takLnJOkO7pq9TIXaV+6YYgqKWtkl6vkrHJeHkZvQ3
         ey2g==
X-Forwarded-Encrypted: i=1; AJvYcCW8WZpUYPxKgWijW/fNpVMGJm+yUvY0FZcCO6noKSWPbqLklgn9R0YqqcyYv7i+Bbn+q+puxfxOlNZUt2v90vSY/zL7sl0wlw==
X-Gm-Message-State: AOJu0Yy0Tyqve0Q91tR9n5KMGMzDxX1ZHeTcjxRh7/oClnlaaxHkWqzU
	501MoYAfuyKbLzR6FMa/GV8a2hxuqFXzDcgpK9a8ghgqfAEvbNC4E77q0LFAlcqMCEVyJBzlSzh
	pvw==
X-Google-Smtp-Source: AGHT+IGraxwr8LJ1oKM13+l6GlQVbxX2plMlllQyHlZ1hTZW8w83otTqaTPIW9YmGt7R4YAvcGIgF556yuY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:703:b0:dc2:550b:a4f4 with SMTP id
 k3-20020a056902070300b00dc2550ba4f4mr5784120ybt.1.1711039040945; Thu, 21 Mar
 2024 09:37:20 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:27 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-6-surenb@google.com>
Subject: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..034f0c918eea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3083,11 +3083,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.44.0.291.gc1ea87d7ee-goog


