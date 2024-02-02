Return-Path: <cgroups+bounces-1322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B7E847C62
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591041F25EEB
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCA126F27;
	Fri,  2 Feb 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o00Pc3vh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LvzGCXdz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A85933;
	Fri,  2 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913578; cv=none; b=VJgPOowh6QO8vWmUsLrKEirbahd3K9pSWqvGueO5JKXBBik2nOWA1pDk9tfhXCiCw97EpRhyRIBA1f6TpxV657u1OAOYfSZHfTTXr50JqUkLYI/WLYmkkGfa2EPlzx0RVm/bqoHIgY/xyE2YrqxgKfpPtimKVSula4K/uLBhO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913578; c=relaxed/simple;
	bh=bCfFQwrE4UL1PKl+LeclfJETuW45xBZgfwbXOew24q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMQM4UzZcIDug9KYaZGtb8/v5ml92l5WPgsAowbyzTAMQ2lSToiqBNTGwhxQqXm3c4x5DiRkF2CL4k0grqOWS0pqNZpx9mBJHPC7jGuSr/OO2K8uZ/qT/hOFpQ5pRKg3A7/yGhwQGbZAg/CyFrgElWuUxOki+U+usGLnuU8/H4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o00Pc3vh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LvzGCXdz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9BE31F7A1;
	Fri,  2 Feb 2024 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706913572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCfFQwrE4UL1PKl+LeclfJETuW45xBZgfwbXOew24q8=;
	b=o00Pc3vhT/8ojuKDWrSL4FR8mVTZgyFICtMOAhjKvC/laJcrnSTqF/WbWFfrUQdYM60ZA5
	iCs0SjDYquSjs6tn55Gkrys8NF5yNZuxmq8wqLBuj/MI0VGGfBMIqEddWXffAV4Jg9QvRR
	CRAAEuDaj5XW016PgvnhSmuRcrIsfhk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706913571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCfFQwrE4UL1PKl+LeclfJETuW45xBZgfwbXOew24q8=;
	b=LvzGCXdznaw+pWLdKAHRAavGrwObeHlndQqMfus2+pnPxZPoYNDhF3c87fCd/xoisedgfh
	wHfQRTzglfyboLQHsqkZSje4OuPVvAEuJKGyUQbV4pAqHJ7zAUvNdOHmd2MV0DbrMpk4Xj
	Q8bqes4dlFs3/XNWDYSSILAbLslIXu0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B62CA13A58;
	Fri,  2 Feb 2024 22:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wz88KyNvvWUsEwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 02 Feb 2024 22:39:31 +0000
Date: Fri, 2 Feb 2024 23:39:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] mm: memcg: Don't periodically flush stats when
 memcg is disabled
Message-ID: <rlm36iypckvxol2edyr25jyo4imvlidtepbcjdaa2ouvwh3wjq@pqyuk3v2jesb>
References: <20240126211927.1171338-1-tjmercier@google.com>
 <ufczw2a3urgi6pi6apzkic5zgquxy2mxls6g2tjfjjkttk3tni@yowqxhlqkz56>
 <CABdmKX1b2GjrUmgTEq+tgwdYyqp_2qhs1G5AHBeKCNSfdbO8Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1b2GjrUmgTEq+tgwdYyqp_2qhs1G5AHBeKCNSfdbO8Eg@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LvzGCXdz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.75%]
X-Spam-Score: -1.07
X-Rspamd-Queue-Id: E9BE31F7A1
X-Spam-Flag: NO

On Thu, Feb 01, 2024 at 01:02:04PM -0800, "T.J. Mercier" <tjmercier@google.com> wrote:
> It does blow up, but not how I was expecting. There's a null pointer
> dereference inside find_css_set when trying to get a css pointer for
> the memory controller, I think because the allocation in
> cgroup_init_subsys is skipped:

Thanks for trying! I suspected it won't be easy. At the same time I
suspected there must be a hook for your purpose -- after looking at
cpuset, I was reminded of cgroup_subsys.bind callback.
What about triggering periodic flush in that callback? (memcg doesn't
implement it yet but cgroup_init() takes it into account.)
It would take any dwork activation out of mem_cgroup_css_online() and it
seems cleaner. (Ideally, the flush could be disabled again when memcg
root is unmounted again. (That's impossible and practically unused but
that's why consider callback approach cleaner. Of course, your original
guard serves the purpose too.))

Regards,
Michal

