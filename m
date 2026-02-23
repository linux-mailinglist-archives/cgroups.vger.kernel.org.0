Return-Path: <cgroups+bounces-14166-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGP+NVO2nGkNKAQAu9opvQ
	(envelope-from <cgroups+bounces-14166-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:19:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03117CCF9
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C14930293F2
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4737649A;
	Mon, 23 Feb 2026 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Q5WP4o9x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DF3382DE
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877968; cv=none; b=SZ7cNc/sA77V90oEwv+8ZzzaVsNRBA+MbAuXeI1QvZjRZQuMqlxpP+JL3fZaNn/s1Wcae4VwDdrKk3Hut0Q0xiAnxUagg7keajVZo5dRNXXvt4VjinkDcN0oJKB4So2gjHkt2beRNFrfWx0sabS3ekYyK7qmO+ATatTv55NKFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877968; c=relaxed/simple;
	bh=RglV209+uxMRZHJF1BYwI/8OXRDEcHt50sSeY+NaMNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbZQkU0LWDWdIMteyaHMeQKfCbcfh8lzSxELu8iRyVdPXVys3rKbz7C8mQUK2t5pNpJgZgERqkY3fBxnYjbFKa9hcN27cRNvkjecDNirqCxolxFyJTusbGBpKmp3MgIl4sth3MnQ/Xg0pwocqQpGHj55OtWEpCEapv/pG7rs5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Q5WP4o9x; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-502a789834fso42147211cf.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771877965; x=1772482765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xI8/Up3XNsFX7BWIlObCd4llqnACUqRWzNuLSnRU3aU=;
        b=Q5WP4o9xx+d/Q2K/1RY4/k9xjdeIVh8RiZYC0p3m8gSXo2Cq37BfRuwB/bNKzjrfrm
         AXkynxF+o54a8i+qghpb//87QeBQueNok/xJcITscKFo9HaEwIx9CCO/9yy/Vz3XcFqk
         ZWGnkr6tLNUgrQ2UuqF123fVeiP95C/jmzBpMJY6b5p3WR2hIWUE7HKGZ4KmBmAo4kKw
         CpEH3ADF3J2D+vd5AiyW7Rm8WyHoXbwpJfDzBG8+fybPdFn75qo7Wd1X9l/8flZS26rQ
         o4w6giXuovmJvtPIMgA1VkiepnVMmdCoY7DJPseBUdsnegenn7f6ccdmeCbMfE/HnE1l
         LF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877965; x=1772482765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI8/Up3XNsFX7BWIlObCd4llqnACUqRWzNuLSnRU3aU=;
        b=ZKyupXF/kYS9mLmBa0OhYkJ7aw4xMdP+zuLibWqpMbOhQ3oaGjfKqtU0W8NHP7Fv6D
         NzsX6wEVNeMs3n+ea8iMFtgi9zL/wTr6janTjPuknbuw9pBcAgFEmEwIpX1KzkPtY1Tq
         tkPaBqJhowSo2PCpFuHaCMwxMaeViW6IB9qN47rZBQG1FYGKyzMpFf6FZNW0BVjP5Kj5
         QcxovFmnIS0T6DbLzem2SrAv1GB7kjeuxrhlPEvxuo5PVQNR8QlPNlyjeWCsbBujtoEB
         GaFvNwEknah7xIlMv+pxsehPNJrraiDMbSAZk6Q5YgWwlrJapvhTVk7OA4Mv5R9EkaI5
         1ZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDfYmU3RpBwOzcUw6Kp6tbynujFktkKHp8ZHOPmTWjNjviHyI7FusXjX2xJ76vtQHyRn1uXYnF@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPLsLQf8RgWgS5u0lb1Fl8bH5Kr4L7Fk2UpSOa8YBXDX8q7ED
	xGMvq/ShUC3vV5bgVFfvREQ7LaPy+UqpIz7z4rR4qbIvuWkui9LtZR3NhdQj1KfcOs4=
X-Gm-Gg: AZuq6aK04DHweLURs5MIkRJaV73RBaal00jd1jD6YpTdqJhrvfILgec7538miu+S/fv
	k+n5yZTXVuh19ScqB8FcueV4T3vQ2GiCcumCfBvl7PI4VgZWtZ1ywvrGtGrcgv/y6Kfk31MSC2i
	dbEt+EMPdU9UgodrBD5gg7dIE8bMhpKJ3eHmHehh0fR/aLSezTrN2TlY6FXqLtcEHPBKV24nFQQ
	n8iqISihuaihnsarUrtKq0bim76zCJsEaLeiPUxVV0UkN+lJOaxwLqqd5rnpHAgMB0qPGqcS6Jk
	M5pdRCafZL2GPJskMrvFXKwR9YCznP/a1qOJexGECSklI4rHY8Pm/WtC9fBJdTfpB5qTib3AGIc
	lSDpu6NOjOAX9EnXDbQ+JRGyGcipaDN0Uc3YGaCyHCDAeNtRRfyY3F4vz5HdTTj7/mynQzm7Ajt
	1KjxK9U7AUHrdhsPwV5k3ywQ==
X-Received: by 2002:ac8:7dc2:0:b0:502:a241:1eec with SMTP id d75a77b69052e-5070bba6b70mr144568591cf.3.1771877964441;
        Mon, 23 Feb 2026 12:19:24 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e6341c4sm76857036d6.35.2026.02.23.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:19:23 -0800 (PST)
Date: Mon, 23 Feb 2026 15:19:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZy2SHbXi6qdGS0a@cmpxchg.org>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
 <aZxymBwx67pMn1ZP@pc636>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxymBwx67pMn1ZP@pc636>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14166-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:mid,cmpxchg.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B03117CCF9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:30:32PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 20, 2026 at 02:10:34PM -0500, Johannes Weiner wrote:
> > @@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  			continue;
> >  		}
> >  
> > +		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
> > +
> >  		split_page(page, large_order);
> >  		for (i = 0; i < (1U << large_order); i++)
> >  			pages[nr_allocated + i] = page + i;
> > @@ -3675,6 +3671,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  	if (!order) {
> >  		while (nr_allocated < nr_pages) {
> >  			unsigned int nr, nr_pages_request;
> > +			int i;
> >  
> >  			/*
> >  			 * A maximum allowed request is hard-coded and is 100
> > @@ -3698,6 +3695,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  							nr_pages_request,
> >  							pages + nr_allocated);
> >  
> > +			for (i = nr_allocated; i < nr_allocated + nr; i++)
> > +				inc_node_page_state(pages[i], NR_VMALLOC);
> > +
> >  			nr_allocated += nr;
> >  
> >  			/*
> > @@ -3722,6 +3722,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  		if (unlikely(!page))
> >  			break;
> >  
> > +		mod_node_page_state(page, NR_VMALLOC, 1 << order);
> > +
> >  		/*
> Can we move *_node_page_stat() to the end of the vm_area_alloc_pages()?
> 
> Or mod_node_page_state in first place should be invoked on high-order
> page before split(to avoid of looping over small pages afterword)?
> 
> I mean it would be good to place to the one solid place. If it is possible
> of course.

Note that the top one in the fast path IS called before the
split. We're accounting in the same step size as the page allocator
can give us.

In the fallback paths (bulk allocator, and one-by-one loop), the issue
is that the individual pages could be coming from different nodes, so
they need to bump different counters. One possible solution would be
to remember the last node and accumulate until it differs, then flush:

fallback_loop() {
	page = alloc_pages();
	nid = page_to_nid(page);
	if (nid != last_nid) {
		if (node_count) {
			mod_node_page_state(...);
			node_count = 0;
		}
		last_nid = nid;
	}
}

if (node_count)
	mod_node_page_state(...);

But it IS the slow path, and these are fairly cheap per-cpu
counters. Especially compared to the cost of calling into the
allocator. So I'm not sure it's worth it... What do you think?

