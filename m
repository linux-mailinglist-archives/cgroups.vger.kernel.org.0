Return-Path: <cgroups+bounces-2078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC68816A8
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5891C2300B
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720326A8AB;
	Wed, 20 Mar 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X3VdWnQl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p1JLIAXc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324476A341;
	Wed, 20 Mar 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956325; cv=none; b=HMXt5bu71H3VxkGjfWcPsVn1Ttutex25Bq4DeXP/DDL9DEzBRKEjK32WfQYyyglaK6pxPmOeSySBv+Ug2AcO1RmW82vqHnpUCcde9YQGVLjswUl5ppy3SGIMJjOgOgM8KzXUnN6JJtr4ehY5DbLDFO2lLp5mjfql/r59vZykrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956325; c=relaxed/simple;
	bh=xwp4eRRwCGaPiDsjgiJ3KwoPvozYMQ2RaLp7XX1ULPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn3Yp8t26mEAE/4cu2nNIbnT1JkU2T2dfUT7mTJmZFemyHY9fjBJmZ7Miw0bKm+hbP0MgPRm4e0fOCFha4dy2oMKcvnP20fI6eB3McXPNmXpndLp1FxUt6NVK/TWjzhXAe+BEUBsSax4L2Gz3ID3NwNU3/R3BL0sipVEDtveLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X3VdWnQl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p1JLIAXc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCFB15C076;
	Wed, 20 Mar 2024 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710956321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqLtQwQxhbXwBUY4R9Zu7ftNuAQlfnwIHtSjEpmlHsg=;
	b=X3VdWnQlS/g6pWFhuVbT/AUDemD4JAAc4icdTTLYm8HSFLEB4CY8TylpT9RlButKQrQQyQ
	mgJ4Wzzv3xRXX/ai0LyLOcbN8IlMjpibSs9GMlLHoh/vVpse0Q300vhFuKf5JPd/qksVoy
	fMCGUY9aKwr/TMoSrR+TyVEA3fWdAH4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710956320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqLtQwQxhbXwBUY4R9Zu7ftNuAQlfnwIHtSjEpmlHsg=;
	b=p1JLIAXc7klbNEa+aPwcd4sdocYrjpEL2KLbnLX6Q2Dxu9wwk9YwK+fcSnsxp000H7ojla
	0H6nKtybZrOGOh0e0fFYObJbLAa8xqtpLH6YmImLsfCiCt7pDk9HfIbGHDmvOoCpR0YEI+
	SoL6CBaYZqFqR19V+ddbkEECSvsY5+s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE782136CD;
	Wed, 20 Mar 2024 17:38:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oStwJyAf+2V5fwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 17:38:40 +0000
Date: Wed, 20 Mar 2024 18:38:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Message-ID: <ZfsfFyo4fRKX4h9Z@tiehlicka>
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
 <ZfsZElNXNf6bOKSt@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfsZElNXNf6bOKSt@tiehlicka>
X-Spam-Score: 0.44
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=p1JLIAXc
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-0.05)[59.50%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 FREEMAIL_CC(0.00)[virtuozzo.com,cmpxchg.org,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,openvz.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CCFB15C076

On Wed 20-03-24 18:12:50, Michal Hocko wrote:
> On Wed 20-03-24 13:09:07, Waiman Long wrote:
> > 
> > On 3/20/24 06:03, Pavel Tikhomirov wrote:
> > > In memory_max_write() we first set memcg->memory.max and only then
> > > try to enforce it in loop. What if while we are in loop someone else
> > > have changed memcg->memory.max but we are still trying to enforce
> > > the old value? I believe this can lead to nasty consequence like getting
> > > an oom on perfectly fine cgroup within it's limits or excess reclaim.
> > 
> > Concurrent write to the same cgroup control file is not possible as the
> > underlying kernfs_open_file structure has a mutex that serialize access to
> > the file.
> 
> This is good to know and I was not aware of that. Thanks!

Btw. even if the interface itself is serialized then uncoordinated
userspace is still timing dependent so fundamentally racy.
-- 
Michal Hocko
SUSE Labs

