Return-Path: <cgroups+bounces-1728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09985D5FB
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD471F23FB9
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0C383A1;
	Wed, 21 Feb 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NURmmB4H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NURmmB4H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89C5C9C;
	Wed, 21 Feb 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512494; cv=none; b=YstlyyANzupIt2rHO6lzmRRENc1Lz2iMIc8zbnv4mcmfpeeuxgQfCuqyLoHFB4mTz9iVMaIBnHW5uUVFs31TyMJQOnqYG7+7zFEnpNjxiUhX/fOMvjM4zW7wUs4z5UGqzYLb6lIDVc2nIxa2HVzauVX+2A6CWYyNf6/CKbJ+mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512494; c=relaxed/simple;
	bh=3aQBuoY6jCgJfEtP8rOb4ip/8LXaslPUMChutDqQnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgmryk+HrRmvXHB4b00406pgnQnkkOUAMjeIKcgeBmspOmFRdH3YS8sIHaUJgvjPWUa5QE1LDkr3pOkOS5K1RN2+Wjtd2ANmEFymGP+oRJzfmGrk0R2+Y2odNqDO5RW/stsBBsKvhkWdWL9GK+8rFfmmuNtXWAReat4kiTCxXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NURmmB4H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NURmmB4H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B39B1FB4C;
	Wed, 21 Feb 2024 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708512490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RE6Ltq2vFZk9oVHrjoTTw6kf5GQSsD0ggzPHZ5wiEQ=;
	b=NURmmB4HElCBZ1jAKQSvF3s7ZW4oVjnsWXUItR76gU07w9tFK0LbFhhQDcmpxMa+YYf7S0
	HmBBRwSJ3IGJATS0tGDOYv1gizDkXOIaBv+MK3aMrXoSTHc/7k4hVkC2pMkHEVPu3OV76T
	6Ys5FVl1DFJ9H11uACQ68tcIV8go4G4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708512490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RE6Ltq2vFZk9oVHrjoTTw6kf5GQSsD0ggzPHZ5wiEQ=;
	b=NURmmB4HElCBZ1jAKQSvF3s7ZW4oVjnsWXUItR76gU07w9tFK0LbFhhQDcmpxMa+YYf7S0
	HmBBRwSJ3IGJATS0tGDOYv1gizDkXOIaBv+MK3aMrXoSTHc/7k4hVkC2pMkHEVPu3OV76T
	6Ys5FVl1DFJ9H11uACQ68tcIV8go4G4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F108139D0;
	Wed, 21 Feb 2024 10:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5hhGOrU1WUQSwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 10:48:10 +0000
Date: Wed, 21 Feb 2024 11:48:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <ZdXU6QAujPI27ita@tiehlicka>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <2024022119-bogged-action-c877@gregkh>
 <ZdW4xR-Ke227pxjG@tiehlicka>
 <2024022134-tackiness-earmuff-59ef@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022134-tackiness-earmuff-59ef@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NURmmB4H
X-Spamd-Result: default: False [-0.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
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
	 BAYES_HAM(-0.43)[78.34%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.24
X-Rspamd-Queue-Id: 8B39B1FB4C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed 21-02-24 11:33:55, Greg KH wrote:
> On Wed, Feb 21, 2024 at 09:48:05AM +0100, Michal Hocko wrote:
> > On Wed 21-02-24 09:40:29, Greg KH wrote:
> > > On Wed, Feb 21, 2024 at 04:18:01PM +0800, GONG, Ruiqi wrote:
> > > > commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> > > > 
> > > > There was a kernel panic happened on an in-house environment running
> > > > 3.10, and the same problem was reproduced on 4.19:
> > > 
> > > Now queued up, thanks!
> > 
> > Give it some more time Greg, http://lkml.kernel.org/r/ZdW2gMajIw_cUN2-@tiehlicka
> 
> Oops, now dropped, thanks!

Race conditions. The thing got resolved in the mean time. The patch is a
partial backport, and I am OK with that. Now with my questions resolved
this is good to know but a note about this being a partial backport in
the changelog would be nice.

-- 
Michal Hocko
SUSE Labs

