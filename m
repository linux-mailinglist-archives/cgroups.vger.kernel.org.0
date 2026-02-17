Return-Path: <cgroups+bounces-13974-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCi2DglhlGk6DQIAu9opvQ
	(envelope-from <cgroups+bounces-13974-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 13:37:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291014C045
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AE53024141
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518C3542D2;
	Tue, 17 Feb 2026 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPmnRoXf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8B33438F
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331842; cv=none; b=dJ7eHIWaGno5OlOkrb63mzfolJ0jOnNLPrYXOFSuEowZrLnwU66bZC2/Zw/ZZrDYltZK+HzmG/phOJN9gZk6fav24hO7LfooN8VyI+IKuRmjOmoR0MwzGfcx2cJKVywLJT4ol44HbiBo/xPWuxgL9qJQF2oJTNewjzDHgn4WK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331842; c=relaxed/simple;
	bh=0eZcbYVy/RVOWycTRLFEvzMgS8G1c7V8/TBl4IUI77o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXK/bHBUmCY5MvpQfBoWe0I7JzFK8qlhSvO1N+TISAlQV65CxWBpX2/nuPQlJqf/F7PnL5P3a9S9tI/sYLmoOFNCfZ1J4hDzPS+hajTapILJODQgx0LQvRASb+fMJ5A2aSOY8/mxwLzWk86EQCN5Q/tLoTKi+7gJMKAvX50REng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPmnRoXf; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43590777e22so2542547f8f.3
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771331839; x=1771936639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msDEC8P3Y7O3dfS3sdhcpXjWKe2JYJmxrwEcOrENtGw=;
        b=UPmnRoXfFk9cE4gD39+4ArCyoUnhwncW35T8OB1KLfRw8woZF13OC4IUD79+9kLZ7r
         uPuP3wTXC9vKREKrtr2lTibkAkrGIBFjcnU56EchLojk+X562vVsid8xozZnbeZGqH/V
         Ugm7UyvT+TfbRv/O3Q4kqfVUb+44z+bHW9wfSb9fIgMhbBfipKASusr5RpFcnzEuGtZc
         h981KQEkMeOgUHH4MYCLibNYv9KUNUiqBPakBZ1sqf8bsTudCdmmXMibpkGEF7ZdczRy
         /g4WTlKoOgA+Iyj9fd9GdRlOCNOuQBSEOy/lMZbEt1M5MNutmM1tsBjehmoFOIwv85MJ
         j7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331839; x=1771936639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msDEC8P3Y7O3dfS3sdhcpXjWKe2JYJmxrwEcOrENtGw=;
        b=t4mQJlzF7NjK0dSaTeIt75ZVtoX+L/WBVgLTrrBzqM/vaD9L5ie9rn0TjnCYHQLiUl
         rkTdDFNEdMeLLsWoTCgeYigD/n0TkvHKa7NMayLNK17c2yt2fRisu0+eHxSfOcjELjoK
         x1tagqQqV1OfkLVDmqO/LPoSVP8QFJBiaZtcZX5/5zMt+f4IO4Hb2z4IBfeh7g4GpbB8
         /Rg08AGrigGjtoRpCvZKci0E0on+34QKgE4qzCXeB9wR+xtBkOY2EijqARXT6ks0wTyA
         dk577tMUoOd8Co+LI/e04/3OibKCtFv6tsE7LuMBTAT4y8BwR81jHdsnqyQ3RyuD0Dww
         SNKw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ygOQkP31JweMvJ3nqijnzYUQsWtRJL7UQ5Yy9PKiN+ixTB0BWmrfCKCBndhxGljE2hwpIEGr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbNqbQyVBs6zvWAUj1fZDXpnAImdpLwibcY2KIPlD27aPHqWv
	3fRC2pQUUTV0wIsXqk0zSCWcZVG7j7zJr1Neqm+kinbh/alcU+XH9ieF+9Uh5029ytU=
X-Gm-Gg: AZuq6aJRvlLz3g2179XXLpkVC7PnAj9GMGJutCy327X+y5GT7u/xZ8kNPr4CaAvJVMu
	PzIVni65fMQND5eTz+B00M8yi46flLwxHqQF/xrP1j10bF6X5/m29USv2TgAVdfMZWCAlW9EoE7
	IlX2Y8EZQ3R43r71WeRPyHAMu1no/ocmUAv4aHrWO4GZ4ACeethXIeFE40F6afG1PQ4B96G5KuR
	24uvDF+Cm9XPmzwOpfrFLywxUYWxLhRZtJgorj2bwFX429Y8qUmHv2VbsRDSQj6yGa0zWn/Qevx
	8Z7o/N12AntmLXHpr5lQMYbulXG8xq4jvKqCtJ1I9i1u2NoPhPC1sd+hZvRk3+cfM5GH2i5YmxO
	VZ1ltMxbMitJSWx1A4i0WVlMCWxOjzyd8AaCZR69bnefOMhbfOJGB37h09UusWIWufJZ7PK3921
	pUYZbwR2JOeIbNyfKnN8DJFgPNFEEKnqjsemFS
X-Received: by 2002:a05:600c:6308:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-48379bc887fmr174214075e9.15.1771331839406;
        Tue, 17 Feb 2026 04:37:19 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm557596855e9.3.2026.02.17.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:37:19 -0800 (PST)
Date: Tue, 17 Feb 2026 13:37:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aZRg_ZSDkbGWv7Vq@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
 <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
 <aZOHIQj3pJ-9dW_0@tiehlicka>
 <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13974-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 8291014C045
X-Rspamd-Action: no action

On Mon 16-02-26 23:48:42, JP Kobryn (Meta) wrote:
> On 2/16/26 1:07 PM, Michal Hocko wrote:
[...]
> > [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
> > target node even when the allocation is from a remote node from the
> > "local" POV.
> 
> It's a good point. The accounting as a result of fallback cases
> shouldn't detract from an investigation though. We're interested in the
> node(s) under pressure so the relatively few fallback allocations would
> land on nodes that are not under pressure and could be viewed as
> acceptable noise.

This is really confusing. You simply have no means to tell the
difference between the requested node and the real node used so you
cannot really say whether the memory pressure is because of fallbacks or
your mempolicy configurations. That means that you cannot tell the
difference between the source of the pressure and victim of that
pressure. 

I am not saying these scheme doesn't work in your particular setup but I
do not see this is long term maintainable thing. It is just too easy to
get misleading numbers. If we want/need to track mempolicy allocations
better than what existing numa_* counters offer then this needs to be
thought through I believe.

I do not think we should add these counters in this form. 
-- 
Michal Hocko
SUSE Labs

