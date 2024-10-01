Return-Path: <cgroups+bounces-5000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3498B828
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 11:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F64282FF9
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634219D887;
	Tue,  1 Oct 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCHM/L5b"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FC19CC36;
	Tue,  1 Oct 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774373; cv=none; b=n3w0Ou2Low3CSOHOot/N9O7Lq/V6/hd8cap2sJVMqw7DIJoL/m7JwVq17YlLRi4yweiq9HH/AUSd36dinGBOEi9AlVFyaDdatBOMIG1bnWC7n9wF8vkjBfefZ7QQsHiAbH90BOlI6jjDl0bgkH9TTOSFoIGwKAbUOHRpny5Ja1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774373; c=relaxed/simple;
	bh=WwRctsRhl/y8+7NsQYrD+0vPTWZHJ/b4JRXktRlbz8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM7pVqVSW+aI+XRl/edeJGqrjS4RgNcqoMjaPKpgUowh4wCTkH7EKctL8wT07mYbHay5dotxQMCTADzKbe5Fu9bQwyG+O1m47+wdsr74BcGCFMkfez1hTS2uzUK9U2oOT7FdWmgKNNkcxSyFIbfXkcztsiWepTnDvGmtKZF8gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uCHM/L5b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gILVLabc79RpkPeQ4dmYMKT20MxsXgyRp081PCwlXDo=; b=uCHM/L5byeVzJQCvKuaxwIT9IW
	/nzpC/KiwJZU950wIWWPKb9BsCOSY76YALAuEHgMgFyU4Qy/5NuIBS8/Xps4E/5CjXeuZbp8rAaej
	xvZyNkwRW+1eey6XkHE8p+x4drYKzULQSgYjwVVAqqBrgIFRIB4CWF8zCd8k1EMPB1aE6+JllfrK9
	ctdFGU8IELogcAJb2eieRd3gF/nxCbngeZFyqSZdjBySlUU/k1kdxSH0wpEiUKLAwLxrAf6sGBl01
	edGNEdLJHMOgrf3aw3DYHziagB+r5QQM61fLZ2W6FcoY8mwK5l1y7pNO7EoWpR/TNc2aUYzMu1Sh0
	gJdJrNWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svZ2V-00000002Cst-3cT4;
	Tue, 01 Oct 2024 09:19:27 +0000
Date: Tue, 1 Oct 2024 02:19:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <Zvu-n6NFL8wo4cOA@infradead.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 28, 2024 at 02:15:56PM +0930, Qu Wenruo wrote:
> [BACKGROUND]
> The function filemap_add_folio() charges the memory cgroup,
> as we assume all page caches are accessible by user space progresses
> thus needs the cgroup accounting.
> 
> However btrfs is a special case, it has a very large metadata thanks to
> its support of data csum (by default it's 4 bytes per 4K data, and can
> be as large as 32 bytes per 4K data).
> This means btrfs has to go page cache for its metadata pages, to take
> advantage of both cache and reclaim ability of filemap.

FYI, in general reclaims for metadata work much better with a shrinker
than through the pagecache, because it can be object based and
prioritized.

> [ENHANCEMENT]
> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> memory cgroup to attach metadata pages.
> 
> Although this needs to export the symbol mem_root_cgroup for
> CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.
> 
> With root memory cgroup, we directly skip the charging part, and only
> rely on __GFP_NOFAIL for the real memory allocation part.

This looks pretty ugly.  What speaks against a version of
filemap_add_folio that doesn't charge the memcg?


