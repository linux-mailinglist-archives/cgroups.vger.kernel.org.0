Return-Path: <cgroups+bounces-5006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9005B98CDE1
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9871C21248
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4319343B;
	Wed,  2 Oct 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lzRx7vNX"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066E7F484;
	Wed,  2 Oct 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854893; cv=none; b=caEnQMX8CH/3krJHg3hBo25vbSxtsDfg+Bt+1DnS6qjMTJ+RJWVCoQKaUw4TwuAkzYSaqhwnOXtnFSTXjaVEtJ7IFievf6SxlFsViEzop7Kg+Hhl6GHXMyCHRuLZEaOBIo655S270S/lCHwcdEJbh8nTfOnMO/Fm9/+x/vInT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854893; c=relaxed/simple;
	bh=WtgIyocaDj9pLxaBHI8F8FVKwq5gEupoBcq4dz/krKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBlngat+KsVsFUm1uJJa2IkkMUa6dyqjS5uAA7nzIX2FCfFgA9PcwfpwEJ98RuKSckjQR/lRou5fBIg2rcop+z96CyXhupHTM/ElLrLC5/2fn8OICVKerRRG2TOSAEHzVdgB8zjrYQLYdND71Zlyv72eyNT9WG56tHramYsNYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lzRx7vNX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RDkEkc0w+gYwp7xSlV1KZ6Rf1mdE1Ttpc76UXPk+EK0=; b=lzRx7vNXDb9uuvdCBx97PXZQ/A
	agm1KxT936uEQFHFBu2E+I5SY6LT3G3t4TKMzOJtCHb0iwOTVQlUMIz55jSwjUaUSyMu9SNCBvqa7
	pj4cWPSkbdwY3vilUHNPEjIJkDcgABu/8/cXuApHaRC9a1U0rOS9zPGKTZRBEKk0IQ62pLf/AI0op
	CArZikmzzLX4YeNTmtr9k+uG9WQ+bFCTQRLhb6liFM88u6uyQXST9Cz82UCa+UdZ9/VHWfJ3eWNX8
	1XJwIOsNETnJTpRyAZFpdyXXPt71kszy+ZOKzFI09v9OOO4gNfsRX0RtGBiQfNHBqBP8Uthg2WAzh
	vy7a74+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svtzF-000000053Dd-2pDW;
	Wed, 02 Oct 2024 07:41:29 +0000
Date: Wed, 2 Oct 2024 00:41:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <Zvz5KfmB8J90TLmO@infradead.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 01, 2024 at 07:10:07PM +0930, Qu Wenruo wrote:
> > This looks pretty ugly.  What speaks against a version of
> > filemap_add_folio that doesn't charge the memcg?
> > 
> 
> Because there is so far only one caller has such requirement.

That is a good argument to review the reasons for an interface, but
not a killer argument.

> Furthermore I believe the folio API doesn't prefer too many different
> functions doing similar things.
> 
> E.g. the new folio interfaces only provides filemap_get_folio(),
> filemap_lock_folio(), and the more generic __filemap_get_folio().
> 
> Meanwhile there are tons of page based interfaces, find_get_page(),
> find_or_create_page(), find_lock_page() and flags version etc.

That's a totally different argument, tough.  Those functions were
trivial wrappers around a more versatile low-level function.

While this is about adding clearly defined functionality, and
more importantly not exporting totally random low-level data.

What I'd propose is something like the patch below, plus proper
documentation.  Note that this now does the uncharge on the unlocked
folio in the error case.  From a quick look that should be fine, but
someone who actually knows the code needs to confirm that.

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301c6..70da62cf32f6c3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1284,6 +1284,8 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
+int filemap_add_folio_nocharge(struct address_space *mapping,
+		struct folio *folio, pgoff_t index, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
 void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_folio(struct folio *old, struct folio *new);
diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a1e..0a1ae841e8c10f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -958,20 +958,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-int filemap_add_folio(struct address_space *mapping, struct folio *folio,
-				pgoff_t index, gfp_t gfp)
+int filemap_add_folio_nocharge(struct address_space *mapping,
+		struct folio *folio, pgoff_t index, gfp_t gfp)
 {
 	void *shadow = NULL;
 	int ret;
 
-	ret = mem_cgroup_charge(folio, NULL, gfp);
-	if (ret)
-		return ret;
-
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
 	if (unlikely(ret)) {
-		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
 	} else {
 		/*
@@ -989,6 +984,22 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(filemap_add_folio_nocharge);
+
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+		pgoff_t index, gfp_t gfp)
+{
+	int ret;
+
+	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (ret)
+		return ret;
+
+	ret = filemap_add_folio_nocharge(mapping, folio, index, gfp);
+	if (ret)
+		mem_cgroup_uncharge(folio);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA

