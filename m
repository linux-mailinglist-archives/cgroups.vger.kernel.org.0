Return-Path: <cgroups+bounces-1725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A753085D52E
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2881F21736
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349E3D57C;
	Wed, 21 Feb 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BAbuwTrz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eznXXzg4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A13C493;
	Wed, 21 Feb 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510087; cv=none; b=o8UTyAxs9OHrlk0E8jOL+8O5yk0kGjWBoWELJdoiGFxVpG0SBEtAOp04n/NBWuWhRnzTBmDEzHb7jojOceTXZlH+BEX+4xgFGXRIcPmWYJ5+gZ8s+DhYOhtC+Kj9zh0NZ+//LMi+dyoIuPqvWL9bO8ei1lLbEHxatlQSomVsmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510087; c=relaxed/simple;
	bh=7XYolvuFmbS0LBqmUQ9KKTmR9uu6+pL4kH1WaTQzMk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNYVvwa1CUSv8OO8aFBTWkV4hubeLx+PAg5/6qc8UVcQCLqis2rqBeOzjTJEggi0hHcHpJKJX0+t95XAfJjJCtOIyRBwnowFsEcGDRu83hUvMPVHoa/Hi3nyuZGBIpvuz0LJoy7i2EVWGX81kP22X5ntpRIT/l+lLOISNaxzKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BAbuwTrz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eznXXzg4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9C9A1FB4A;
	Wed, 21 Feb 2024 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708510083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZGJ3olY1kWj1dk7MtZO1ibtEdnIoZrzoUYLjjxmvX0=;
	b=BAbuwTrzJs/DVFKRHFbDFTMrOfHETXJMisKC7tj8M6JjdNEOXo93jcYFaNdeQJjEAyfekQ
	CrWyK55GtVGUQVgEG0K6dxNYX167qbb3oWip8LFfLjTQ6Xe1gF1jehGKrTY0i0DAvPcKNH
	EDKodBHi1qarR9EShsI0U7wX2BQobl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708510082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZGJ3olY1kWj1dk7MtZO1ibtEdnIoZrzoUYLjjxmvX0=;
	b=eznXXzg4qM0A3TmtjnVpTQmOa20c6dDKPyNZj3w3j7MVgFsxv/M5WS8FbQNP/f2QOO1VnF
	nvww1JNkoDaOiWtTt/Vga4ezs7hNrjfk0TWvaU7SBvELlCYWYPJglPfWuXzv/l7B1nQyfm
	HFJxqzEV5z/gbJCCXo07IFcHySDtCEE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA4A813A69;
	Wed, 21 Feb 2024 10:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qRKQJoLL1WXHQAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 10:08:02 +0000
Date: Wed, 21 Feb 2024 11:08:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <ZdXLgjpUfpwEwAe0@tiehlicka>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <ZdW2gMajIw_cUN2-@tiehlicka>
 <5436af7a-26d4-7c04-466a-7163d5a26040@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5436af7a-26d4-7c04-466a-7163d5a26040@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eznXXzg4
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C9C9A1FB4A
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Wed 21-02-24 17:50:27, Gong Ruiqi wrote:
> 
> On 2024/02/21 16:38, Michal Hocko wrote:
> > On Wed 21-02-24 16:18:01, GONG, Ruiqi wrote:
> >> commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> > 
> > I think it would be good to mention that this is only a partial backport
> > and also explain why to do a partial rather than the full one.
> >
> 
> Okay. I think to fix this problem we should add refcnt relation between
> memcg and stock, and since higher versions have achieved this, maybe
> it's better to use the same code and align with them. So I put a "commit
> xxx upstream" here, as requested in kernel docs[1]. So yes it's a
> partial backport as we only need the stock part.

I think it is sufficient to mention that this is a partial backport to
minimize the fix to the bare minimum.

[...]
> > What does prevent from the following?
> > 
> > refill_stock(memcgC)		drain_all_stock(memcgB)
> >   drain_stock(memcgA)		  rcu_read_lock()
> >     css_put(old->css)		  memcgA = stock->cached
> >                                   mem_cgroup_is_descendant(memcgA, memcgB) UAF
> >     stock->cached = NULL
> > 
> 
> I think it's not a problem since refill_stock() has disabled irq before
> calling drain_stock():
> 
> refill_stock(memcgC)
>   local_irq_save
>   drain_stock(memcgA)
>     css_put(old->css)
>     <1>
>     stock->cached = NULL
>   local_irq_restore
>   <2>
> 
> And since css_put(old->css) is an RCU free, memcgA would not be freed at
> <1> as it's still in grace period. The actual release of memcgA could
> happen only after irq is enabled (at <2>).
> 
> And for CPU2, the access to stock->cached in drain_all_stock() is
> protected by rcu_read_lock(), so from stock->cached we get either NULL,
> or a memcgA that is still not freed.
> 
> Please correct me if I have some wrong understanding to RCU.

You are right. Thanks! IRQ disabling is there in one form or the other
since db2ba40c277d ("mm: memcontrol: make per-cpu charge cache IRQ-safe
for socket accounting") so 4.8+ is safe. Backports to older kernels
would nee to pull this one as well.

> >> Cc: stable@vger.kernel.org      # 4.19 5.4
> >> Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
> >> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs

