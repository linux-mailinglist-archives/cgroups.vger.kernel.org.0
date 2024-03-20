Return-Path: <cgroups+bounces-2077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37488163B
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF02B22E07
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1399069E0A;
	Wed, 20 Mar 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fFVnI46b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fFVnI46b"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178769DEE;
	Wed, 20 Mar 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954778; cv=none; b=Wcc8Cx8qRVLPQD84EmjCDthC48DLrAsleBE2vMsafaA54E3iuCf/gV7H8sotIW9ySl0T92nb2FK5TdynechBTG3yDEfQowfCGvf1WVyL3Mxox4CiiNoSsWE9BNJe8vpbxEBVGINDWcsUsz23qI4IAI1f30I97rjqWM1Nfjh4G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954778; c=relaxed/simple;
	bh=RJrXqMW+w+hi9QE80+m6W2e3jA+FozIDfWRkYXdcaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv6Em4xHl7hH8BqVlGHAX6l4JhxS1cmQImL1XzckT72TUxYbt3UepvnngjySGyUjl/vldOO99JwzbNEReH8Yp+np2DRvHaCV/JLVkU5S66YwfOWMuiJiBY96fCrY0Q0aHYeD2k6kBTVxWbkPxc5JPGxrZxERmY9fBG2D1EVw9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fFVnI46b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fFVnI46b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C2593487A;
	Wed, 20 Mar 2024 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710954775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKC29gVMHa68RPkUNE5y3QIPIaFgwQ0ogCdZiW99o4Y=;
	b=fFVnI46bwaaJqWv9CMJQomIukyzK4/LpqBmE6tCL2mr0RDqiBRrsbwr5XgtFnOPPbgo/BF
	DX107ymc805OPGH8HqiTwV9YLNmmHa/+WlPe08AvOKHbTtVgeGOQ61Mc5JJv/hyC2dBNBv
	VTF6dnQmp2Wjia5UD4c0u5AtXOZtIAw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710954775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKC29gVMHa68RPkUNE5y3QIPIaFgwQ0ogCdZiW99o4Y=;
	b=fFVnI46bwaaJqWv9CMJQomIukyzK4/LpqBmE6tCL2mr0RDqiBRrsbwr5XgtFnOPPbgo/BF
	DX107ymc805OPGH8HqiTwV9YLNmmHa/+WlPe08AvOKHbTtVgeGOQ61Mc5JJv/hyC2dBNBv
	VTF6dnQmp2Wjia5UD4c0u5AtXOZtIAw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B45A136CD;
	Wed, 20 Mar 2024 17:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EghGBBcZ+2VLdwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 17:12:55 +0000
Date: Wed, 20 Mar 2024 18:12:50 +0100
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
Message-ID: <ZfsZElNXNf6bOKSt@tiehlicka>
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.64
X-Spamd-Result: default: False [0.64 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.06)[61.08%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[virtuozzo.com,cmpxchg.org,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,openvz.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed 20-03-24 13:09:07, Waiman Long wrote:
> 
> On 3/20/24 06:03, Pavel Tikhomirov wrote:
> > In memory_max_write() we first set memcg->memory.max and only then
> > try to enforce it in loop. What if while we are in loop someone else
> > have changed memcg->memory.max but we are still trying to enforce
> > the old value? I believe this can lead to nasty consequence like getting
> > an oom on perfectly fine cgroup within it's limits or excess reclaim.
> 
> Concurrent write to the same cgroup control file is not possible as the
> underlying kernfs_open_file structure has a mutex that serialize access to
> the file.

This is good to know and I was not aware of that. Thanks!
-- 
Michal Hocko
SUSE Labs

