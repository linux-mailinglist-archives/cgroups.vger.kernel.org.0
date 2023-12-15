Return-Path: <cgroups+bounces-965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A48143F5
	for <lists+cgroups@lfdr.de>; Fri, 15 Dec 2023 09:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2261E284978
	for <lists+cgroups@lfdr.de>; Fri, 15 Dec 2023 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC215AC2;
	Fri, 15 Dec 2023 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LRSPraK2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LRSPraK2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08E171BB;
	Fri, 15 Dec 2023 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E7351F824;
	Fri, 15 Dec 2023 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702630211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McsMtbDm05lM4zhgzbK/C+1NH2Bzs0Vl9JYrVkxmnLk=;
	b=LRSPraK2OCLpToxyONL0SdyNenyouJL/gdv9/0WXVjh7HrNmlhXPF8omNwwwpCJehIuisr
	rekj1bECE8d8eVUP/i3BQeFxgNNqEP8yd75CAV9nv6IPwobQzNNjhAL/CEkGv8vjhDKFEd
	3rCEOdzSkZCDfbgr8oVcw4UC5ZAJxIE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702630211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McsMtbDm05lM4zhgzbK/C+1NH2Bzs0Vl9JYrVkxmnLk=;
	b=LRSPraK2OCLpToxyONL0SdyNenyouJL/gdv9/0WXVjh7HrNmlhXPF8omNwwwpCJehIuisr
	rekj1bECE8d8eVUP/i3BQeFxgNNqEP8yd75CAV9nv6IPwobQzNNjhAL/CEkGv8vjhDKFEd
	3rCEOdzSkZCDfbgr8oVcw4UC5ZAJxIE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC382137D4;
	Fri, 15 Dec 2023 08:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bANZM0ITfGWCQwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 15 Dec 2023 08:50:10 +0000
Date: Fri, 15 Dec 2023 09:50:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXwTPAUn27ShARMG@tiehlicka>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com>
 <ZXq_H4St_NSEFkcD@tiehlicka>
 <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
X-Spam-Score: 0.36
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.57 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.33)[75.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLhyf994aoi9gdt4d63rk4ux49)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,kernel.org,bytedance.com,lwn.net,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.57
Authentication-Results: smtp-out2.suse.de;
	none

On Thu 14-12-23 13:22:29, Dan Schatzberg wrote:
> On Thu, Dec 14, 2023 at 09:38:55AM +0100, Michal Hocko wrote:
[...]
> > While the review can point those out it is quite easy to break and you
> > will only learn about that very indirectly. I think it would be easier
> > to review and maintain if you go with a pointer that would fallback to
> > mem_cgroup_swappiness() if NULL which will be the case for every
> > existing reclaimer except memory.reclaim with swappiness value.
> 
> I agree. My initial implementation used a pointer for this
> reason. I'll switch this back. Just to be clear - I still need to
> initialize scan_control.swappiness in all these other places right?

No. They will just get initialized to 0. All you need to make sure is
that the swappiness is used consistently. I would propose something like
scan_control_swappiness() (or sc_swappiness) which would actually do

	if (sc->swappiness)
		return sc->swappiness;
	return mem_cgroup_swappiness(sc->target_mem_cgroup);

and then make sure that mem_cgroup_swappiness is never used directly.

-- 
Michal Hocko
SUSE Labs

