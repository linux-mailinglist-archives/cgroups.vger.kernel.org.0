Return-Path: <cgroups+bounces-3028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400218D2736
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95DA2887BA
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9A817BB19;
	Tue, 28 May 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pZrBqKdL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pZrBqKdL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256E6F06E;
	Tue, 28 May 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932544; cv=none; b=aBQ2d2f2q4IHnrdtEqPirOxU36QWoU/bp2w1WrBxdI/cCNqFC7tkBOjIdQzlMKSIayK31tbc3DiYheYZamhqmyNdqEjrBkxUMwAo0aaE7JUggccI4j6YaoiIiRNQi1fwRB1eWCCB2edGvlnsjILew2RkkfYObGCtXmQlXyV4r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932544; c=relaxed/simple;
	bh=M/jOs5D9CCgKcL0wiVUa68UgjVFEE9AtxSDsnpVWCbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/ull7pc+Ugvgn4UuNbJ4V2liLEI2hIAksNmvq+m/rPCb/qu6Fl7hr5AnCoQAg7++YCILxfW6FLssrw0J3dMuUDaedbE1LaQ9gfflZfWaMpdftYh2ZsAG5pTs0rVwcgHJO8RTjrf3YGRAlDQhFgL/jQ5M3FmShK/SMJOY81d/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pZrBqKdL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pZrBqKdL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0498C2045D;
	Tue, 28 May 2024 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716932539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/jOs5D9CCgKcL0wiVUa68UgjVFEE9AtxSDsnpVWCbM=;
	b=pZrBqKdLobnlLzXt1Ue17In4Bo+OxK2WS2QYe0EY3eKlLeuBIK0IewAbb5KoSkqfpnvwc9
	TfvW4obzlw1X2I3QES6V9M+Hq26eQpki46AyYcXxTRC3t2q9Fnh0qkYkAKzpCS2SE1yaDr
	3PCb3GYYAkNITEPB9ag8YZOjgk0Ibhc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pZrBqKdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716932539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/jOs5D9CCgKcL0wiVUa68UgjVFEE9AtxSDsnpVWCbM=;
	b=pZrBqKdLobnlLzXt1Ue17In4Bo+OxK2WS2QYe0EY3eKlLeuBIK0IewAbb5KoSkqfpnvwc9
	TfvW4obzlw1X2I3QES6V9M+Hq26eQpki46AyYcXxTRC3t2q9Fnh0qkYkAKzpCS2SE1yaDr
	3PCb3GYYAkNITEPB9ag8YZOjgk0Ibhc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D793113A5D;
	Tue, 28 May 2024 21:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KZDtM7pPVmYBfgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 28 May 2024 21:42:18 +0000
Date: Tue, 28 May 2024 23:42:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
Message-ID: <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlYzzFYd0KgUnlso@slm.duckdns.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.91 / 50.00];
	BAYES_HAM(-2.90)[99.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0498C2045D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.91

On Tue, May 28, 2024 at 09:43:08AM GMT, Tejun Heo <tj@kernel.org> wrote:
> I agree that this can be a useful metric but am not sure /proc/cgroups is
> the right place to put it. Its use of v1 controller names, listing of
> controllers that don't exist in v2 and the unnecessary column are rather
> ugly and unnecessary.

At the same time, the info provided currently is incorrect or at least
misleading (when only v2 hierarchy is mounted, it mixes the counts) --
that's what T.J.'s patch attempts to rectify in my understanding.

> In v2, cgroup.controllers and cgroup.subtree_control govern which
> controllers are available and enabled in the subtree.

Yes, users could sum up cgroup.controllers contents for true v2
fingerprint.

> I think it would make sense to introduce something in a similar
> fashion. Can't think of a good name off the top of my head but add a
> cgroup. file which lists the controllers in the subtree along with the
> number of css's.

BTW, there is the 'debug' subsys that has (almost) exactly that:
'debug.csses' -- it's in v1 fashion though so it won't show hierarchical
sums.

Michal

