Return-Path: <cgroups+bounces-2976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2F8CB1DB
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221FBB22AAC
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB211B966;
	Tue, 21 May 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJvYEzXj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJvYEzXj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40717BB5
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307435; cv=none; b=J79D+rsYeoZE+wMUDxzBlRkOeYL+HVitGiPjlBWrnxP3//o1zJXliRRne/10lajYe2YHXDM0ggHnovFg+Zr9uL7Ja4WX25qIYx0jdmM1FPRmBGryaQjCqHHO5/upVY+B4KuJHqA7lmmZipbESmVX6EI1ZCezEIeQii+xQbGEfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307435; c=relaxed/simple;
	bh=hDHrQ/d00J5HbIDBqAicthLTutc0tItVwSHIRkHTJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCeQfMHm2FmUdGUnfE3aNjuIXqyvcApmiDqFd1BpJXUYx0KzutVOSrFpkZgQgN94fDjMPvmeigNUDjt2pqwaSBKXz9KPUDZ3xQSYO/1REcaM98HBte3p2i/MPwPoF0yZkP4Ne/2n2ati6tA29MYC/x+1rlVwPqHauw8+mWXedd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJvYEzXj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJvYEzXj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A21EF34850;
	Tue, 21 May 2024 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716307431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xNgyl+2IoOjYGw//Y70hdG7G3C0dBJQyHPBEOEcFK8=;
	b=bJvYEzXjz4m666AkTXA36SaU0UA2YQtttseafJhAcNhoPNVipM8Vr0D6dgtMKSHII26ehz
	1PvyB96VjO3C8NjggOqS/98RulKsT1YigHNM4mLXNZGrBn7Mjl2S7szOonfYISPonRwd1V
	tL0SNaWTK5ydko0vdiCxGkwf5guCXLg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bJvYEzXj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716307431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xNgyl+2IoOjYGw//Y70hdG7G3C0dBJQyHPBEOEcFK8=;
	b=bJvYEzXjz4m666AkTXA36SaU0UA2YQtttseafJhAcNhoPNVipM8Vr0D6dgtMKSHII26ehz
	1PvyB96VjO3C8NjggOqS/98RulKsT1YigHNM4mLXNZGrBn7Mjl2S7szOonfYISPonRwd1V
	tL0SNaWTK5ydko0vdiCxGkwf5guCXLg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8926713A1E;
	Tue, 21 May 2024 16:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yUypHufFTGaaJQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 16:03:51 +0000
Date: Tue, 21 May 2024 18:03:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <ZkzF4f7lvPRQyszy@tiehlicka>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkyzRVe31WLaepSt@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A21EF34850
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,linux-foundation.org,cmpxchg.org,linux.dev,kvack.org,vger.kernel.org,gmail.com,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]

On Tue 21-05-24 15:44:21, Matthew Wilcox wrote:
> On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
> > The page_memcg() only called by mod_memcg_page_state(), so squash it to
> > cleanup page_memcg().
> 
> This isn't wrong, except that the entire usage of memcg is wrong in the
> only two callers of mod_memcg_page_state():
> 
> $ git grep mod_memcg_page_state
> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
> mm/vmalloc.c:           mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> mm/vmalloc.c:                   mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
> 
> The memcg should not be attached to the individual pages that make up a
> vmalloc allocation.  Rather, it should be managed by the vmalloc
> allocation itself.  I don't have the knowledge to poke around inside
> vmalloc right now, but maybe somebody else could take that on.

This would make sense as a follow up.

-- 
Michal Hocko
SUSE Labs

