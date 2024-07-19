Return-Path: <cgroups+bounces-3820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67019937B8E
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD01F228B4
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DF1465B7;
	Fri, 19 Jul 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPGxgh4W"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BC2BB0D
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409918; cv=none; b=OtGd53nznQ3sDdwTqCzNqcHn+qVFr76yTblUNHVNOgABXZonZh9emQTqC6vxwqJ8Kgw3/ARoj8RVx/BPhyE2mBSWIDsUkMuyRvHFiWOePo51T/PdLNZ1tXvYnYdDUJXlgejYQjSdb35rn5bAWkLMxUSj66HBgi5eyH0jHhhk+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409918; c=relaxed/simple;
	bh=UvlBE0//T873lE7ymYCFQ60QVNwdI+r7MaJb5Sbvo6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToriNg5xdrQI8PF/rSd5DfH9qxF4QmzxuhBk0FgKaiQeK/OToiwd+AtVGxuqGOyNAVe+HS+ljJcRSaenJzyBIaUT1ZJ4vZnMkBe28fbjHqpeDo6zqIW9hUWGfleHulm6yxK7SL8Q+U71CuVxvlUZZ4ASmCJzMJN7D0UCuUFcQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HPGxgh4W; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hannes@cmpxchg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721409914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pkR6DEf3Lxs0SOZWGvsdocjpD6jlthCnw0cI5XnXA8=;
	b=HPGxgh4WXhi970lJv9mLD2zgsEXk5Br5M5Qr9SoH6cgR9mEKImc7D2lKOL8uraoncWomzR
	c139mioxVqtRDBcZPqYznQD/OPMe9WnPzrOlNdfN533MXRmyrz/b91oqqSKg4Lu3RvvZrz
	7XM8U+HqDkJdrORbI/OuKNDy7gQmgts=
X-Envelope-To: wqu@suse.com
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: vbabka@kernel.org
Date: Fri, 19 Jul 2024 17:25:09 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <ZpqhddM6-DnbfC7T@google.com>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
 <20240719170206.GA3242034@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719170206.GA3242034@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 01:02:06PM -0400, Johannes Weiner wrote:
> On Fri, Jul 19, 2024 at 07:58:40PM +0930, Qu Wenruo wrote:
> > [BACKGROUND]
> > The function filemap_add_folio() charges the memory cgroup,
> > as we assume all page caches are accessible by user space progresses
> > thus needs the cgroup accounting.
> > 
> > However btrfs is a special case, it has a very large metadata thanks to
> > its support of data csum (by default it's 4 bytes per 4K data, and can
> > be as large as 32 bytes per 4K data).
> > This means btrfs has to go page cache for its metadata pages, to take
> > advantage of both cache and reclaim ability of filemap.
> > 
> > This has a tiny problem, that all btrfs metadata pages have to go through
> > the memcgroup charge, even all those metadata pages are not
> > accessible by the user space, and doing the charging can introduce some
> > latency if there is a memory limits set.
> > 
> > Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
> > charge situation so that metadata pages won't really be limited by
> > memcgroup.
> > 
> > [ENHANCEMENT]
> > Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> > memory cgroup to attach metadata pages.
> > 
> > With root memory cgroup, we directly skip the charging part, and only
> > rely on __GFP_NOFAIL for the real memory allocation part.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index aa7f8148cd0d..cfeed7673009 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> >  
> >  	struct btrfs_fs_info *fs_info = eb->fs_info;
> >  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> > +	struct mem_cgroup *old_memcg;
> >  	const unsigned long index = eb->start >> PAGE_SHIFT;
> >  	struct folio *existing_folio = NULL;
> >  	int ret;
> > @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> >  	ASSERT(eb->folios[i]);
> >  
> >  retry:
> > +	/*
> > +	 * Btree inode is a btrfs internal inode, and not exposed to any
> > +	 * user.
> > +	 * Furthermore we do not want any cgroup limits on this inode.
> > +	 * So we always use root_mem_cgroup as our active memcg when attaching
> > +	 * the folios.
> > +	 */
> > +	old_memcg = set_active_memcg(root_mem_cgroup);
> >  	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
> >  				GFP_NOFS | __GFP_NOFAIL);
> > +	set_active_memcg(old_memcg);
> 
> It looks correct. But it's going through all dance to set up
> current->active_memcg, then have the charge path look that up,
> css_get(), call try_charge() only to bail immediately, css_put(), then
> update current->active_memcg again. All those branches are necessary
> when we want to charge to a "real" other cgroup. But in this case, we
> always know we're not charging, so it seems uncalled for.
> 
> Wouldn't it be a lot simpler (and cheaper) to have a
> filemap_add_folio_nocharge()?

Time to restore GFP_NOACCOUNT? I think it might be useful for allocating objects
which are shared across the entire system and/or unlikely will go away under
the memory pressure.

