Return-Path: <cgroups+bounces-1380-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58384B07D
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0093F283768
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24912D141;
	Tue,  6 Feb 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXJmadX2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXJmadX2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92812C538;
	Tue,  6 Feb 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209925; cv=none; b=VRAv1kX6jLSZT2Qp5KjVf1EXNTJLBqCdt60TaD7ZAzm5r4N6O+6Vpo+vQeKsIGTPxzVXuYkR5mGtFvthnuVTVGTL5VE4OuDd/8jPJzvSd0obwXb6bOXZIDJUw4u518lbNt/0KXfNGKfn3tQJ6Vm32O4dCX/2tlSWbxz21hUcfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209925; c=relaxed/simple;
	bh=GhZB8MN/jd5rTRHj0DErlvHSNihnZ3jPXL9QMYPstpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi7sZJZ/iogPxGe8HEfL9YhUHPubdugH7VWImBLU7GU6seo7+iRtsbk8sx61YMqA6xNVtPq8aUs3NQR3bwRiHZJb1hSyDC4WJDkkaeDPmx1n0LGZz0HnC2sUOUU1Jcm5TJk4lSNcn1mxyVD0uht1IvzrgvLlkTHwJDevdUHkuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXJmadX2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXJmadX2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A32F1FB6B;
	Tue,  6 Feb 2024 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707209921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A19HvsSlZRV6QduTgVW8TcpDaBKxWRM0Xot5i4qzE0M=;
	b=tXJmadX2byQ/sbSCUCGRX3aZkTvS2BjlHRhsfjYi1TOHpj4L+WYRv1Ptla30H5k7DdKbJG
	9J054vqsOiojUF5z3H/WAVc3ySDzUtjImRvC4/zFXI/lC7pPuoyZekO3ocsrKNSg+n2O/V
	vGTLBsJdJMtbNFGHeyCDosm+ZnqIfbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707209921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A19HvsSlZRV6QduTgVW8TcpDaBKxWRM0Xot5i4qzE0M=;
	b=tXJmadX2byQ/sbSCUCGRX3aZkTvS2BjlHRhsfjYi1TOHpj4L+WYRv1Ptla30H5k7DdKbJG
	9J054vqsOiojUF5z3H/WAVc3ySDzUtjImRvC4/zFXI/lC7pPuoyZekO3ocsrKNSg+n2O/V
	vGTLBsJdJMtbNFGHeyCDosm+ZnqIfbI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30900132DD;
	Tue,  6 Feb 2024 08:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BrHZC8H0wWWUZQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 06 Feb 2024 08:58:41 +0000
Date: Tue, 6 Feb 2024 09:58:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <ZcH0wBPvOjqayjAD@tiehlicka>
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka>
 <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka>
 <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka>
 <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
 <ZcFQMru5_oATGbuP@tiehlicka>
 <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 05-02-24 20:01:40, T.J. Mercier wrote:
> On Mon, Feb 5, 2024 at 1:16 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> > > On Mon, Feb 5, 2024 at 12:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > This of something like
> > > > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > > > where timeout acts as a stop gap if the reclaim cannot finish in
> > > > TIMEOUT.
> > >
> > > Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
> > > it is what's bothering me.
> >
> > I am not really happy about this subtlety. If we have a better way then
> > let's do it. Better in its own patch, though.
> >
> > > It's already wired up that way though, so if you want to make this
> > > change now then I can try to test for the difference using really
> > > large reclaim targets.
> >
> > Yes, please. If you want it a separate patch then no objection from me
> > of course. If you do no like the nr_to_reclaim bailout then maybe we can
> > go with a simple break out flag in scan_control.
> >
> > Thanks!
> 
> It's a bit difficult to test under the too_many_isolated check, so I
> moved the fatal_signal_pending check outside and tried with that.
> Performing full reclaim on the /uid_0 cgroup with a 250ms delay before
> SIGKILL, I got an average of 16ms better latency with
> sc->nr_to_reclaim across 20 runs ignoring one 1s outlier with
> SWAP_CLUSTER_MAX.

This will obviously scale with the number of memcgs in the hierarchy but
you are right that too_many_isolated makes the whole fatal_signal_pending
check rather inefficient. I haven't missed that. The reclaim path is
rather convoluted so this will likely be more complex than I
anticipated. I will think about that some more.

In order to not delay your patch, please repost with suggested updates
to the changelog. This needs addressing IMO but I do not think this is
critical at this stage.

-- 
Michal Hocko
SUSE Labs

