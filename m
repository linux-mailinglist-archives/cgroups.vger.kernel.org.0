Return-Path: <cgroups+bounces-13579-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DmpGlGXfmn+bAIAu9opvQ
	(envelope-from <cgroups+bounces-13579-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:59:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40EC46A7
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F1D3017FA6
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 23:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949538B9B9;
	Sat, 31 Jan 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGawk60f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29636AB6F
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903946; cv=none; b=bXryt+iwdMqQxGkDAPFuJMJzn0pKibOyH9eXNeDglvkqi3Vo9QthGKAPeMXMuJZxnbEywQbLJfVcnDTSPzoyrCk4XG2GugwEJyecFs6gaDscT6fwwxQvAG/Wt4gopHrRXfNlxH3mDOY7JsANoW/dpju+LrWCdkrmaeV4n6WAJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903946; c=relaxed/simple;
	bh=6eBJ6TImiTKj76ywie74xPnLw98jDK7LvXzNwK0KWIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V39d/Yk6mwPADgkeBLHl3Gcw6v9JI+8xIYYCj3ooz9C1qgjPveIWlVPCCGnPP2/egCzxKdEspePUmS+Mu8z0rIECoJL254DYKdNcaBSWc1OidvIiIATxqL8+J8acQFjnHu6aeWLNNidU5f7zRQa+sDd9YtbhCcCb5UWgULRoE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGawk60f; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so60285ad.1
        for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 15:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769903945; x=1770508745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtBPPhj1ayBDt09op5lwhUL/PZ+SFYgWzXzV09l+lfI=;
        b=zGawk60fBITUuy7VxylzO49SIkBPtddJ5ZqF/wGe94ovS3wM4+KNCBCp+DfGyAX7tS
         pql6GxBW/e8WR+9njAbYoOq3E56TwwJtfJ8VQEoXS9rbOIlGRKuS1maKLJcNKVfJNHss
         i4zXZrl9iZ1pAasb2uir27C27PDL0usKJlBclUJzMfjo6hagX12mW6vlNwwy9B0E9/r0
         I5vhExN0NPxpDj6QcD428OhDBA/dOzytaD/p6FZ5lcr+Qlhln+5RUUwlKIXNWHPcM1NX
         b0gHOuqDur16NMCa3F0/X5JwTVR/aoRqdfllBfqk2IV4MRwjk83bcTZvtIK1uhd8gJbz
         5dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769903945; x=1770508745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtBPPhj1ayBDt09op5lwhUL/PZ+SFYgWzXzV09l+lfI=;
        b=FlPjIOxL1D2sqk36DEScHJuYjxAlH4mjMhrUABkKj8lDXYK6a4JhXASmpfsk0Mfo+9
         G9J8ZgE0sqAYu7fBjPRlr63M65jeYb+wBPvygM104YzI5+SLp3J85CBSg8jm/JJLur7r
         OmrPnEJcivuc/Q8yXxT8kY6z7QNiCA0B9YXnlr/eiXMUoWLn6z5dSp6ItpENkRHOMdvG
         /zEmJp9gz7VWmCVPFn2sjyqlmSbd2dJWZp3Hqa8qN3n1y+LNJ0kYuI9BXxyJQRqH3c1n
         4Q4TazjRsYdhrKEjb/vd9iQhB2gxsM3fwNKA9UZQab1l1p913noHs+7JZkz22N2CT3O5
         Pa2w==
X-Forwarded-Encrypted: i=1; AJvYcCU/OEOdrN2LFwg/1xMyfiaPPOBPgoDSYBaxbMiSw7ctLWFkEI5PXxjhXmnQZHwEKyBj+upnY/Lt@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxTkiYSCPrfJPj+QUv0oMsAg66kawR1W5D266oW/xnRl16rTc
	+HTz/P+0gYGUi9gQee6Fh2dtSgk5Td+iGt//simTuEWp8ZaTj/bkeCeOmRtBATT49g==
X-Gm-Gg: AZuq6aKPDleaBsMSK93bJZ/bhGSbkPSccfsgZEd5lXIiwHuPGwAzFgz+XXzcfq11Gf/
	0U/uX1O21WuC6dnjPP2+CaaqCCB5PQaL5Yai3P+nlzgVGzdoQTK4ety4hnvHomLV9TtBi31ZQli
	3rp4OYUxXLB8A8mtHKnOBBY85Jo09dEHlvr1DorqzxD0Vx6gQY57HhSKyf+UDR86OCLDl7Tl2gx
	o7n7PPk37KPImq1D4PNwTRoCtAM27o63kbQKeuDE/V7l1Fn+8i541tQSbxunGf9DprBpWRcZKek
	YRc+ScxR6ksCh2IJai+lwJvhuBRlZ5yUP72E4zDGWnZ0QkNbdCDAEfqOgou/9OsaJ9JIGwp/tXZ
	lmIrr+JuYi7aHUHH6/ni0ub6vItPQAU1KQzMlc5OFpJUxypUja+jpQZKm2ctGRQEbE0sx0STI3X
	ak0wUMWJDkyNOCF1fvftvIedJpjms4xB7cOPZHgoWR1C9gLqOzWQ==
X-Received: by 2002:a17:903:110e:b0:2a0:867c:60e2 with SMTP id d9443c01a7336-2a8f50d2ee6mr1807895ad.19.1769903944481;
        Sat, 31 Jan 2026 15:59:04 -0800 (PST)
Received: from google.com (130.15.125.34.bc.googleusercontent.com. [34.125.15.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6427da8441sm10057645a12.9.2026.01.31.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 15:59:03 -0800 (PST)
Date: Sat, 31 Jan 2026 23:58:58 +0000
From: Bing Jiao <bingjiao@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev,
	roman.gushchin@linux.dev, tj@kernel.org, longman@redhat.com,
	chenridong@huaweicloud.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 0/2] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aX6XQmBncndLdu1X@google.com>
References: <20260114070053.2446770-1-bingjiao@google.com>
 <20260114205305.2869796-1-bingjiao@google.com>
 <aXlY04m0FuX-9LRE@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXlY04m0FuX-9LRE@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,bytedance.com,gourry.net,gmail.com,linux.dev,redhat.com,huaweicloud.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13579-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD40EC46A7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 03:35:26PM -0800, Shakeel Butt wrote:
> Hi Bing,
>
> Please don't reply (i.e. use In-Reply-To) to older revision of your
> series. Send each revision independently.
>
> On Wed, Jan 14, 2026 at 08:53:01PM +0000, Bing Jiao wrote:
> > This patch series addresses two issues in demote_folio_list(),
> > can_demote(), and next_demotion_node() in reclaim/demotion.
> >
> > 1. demote_folio_list() and can_demote() do not correctly check demotion
> >    target against cpuset.mems_effective, which will cause (a) pages are
> >    demoted
>
> pages to be demoted
>
> > to not-allowed nodes and (b) pages are failed to demote
>
> page fail to demote
>
> > even
> >    if the system still have allowed demotion nodes.
> >
> >    Patch 1 fixes this bug by update
>
> updating
>
> > cpuset_node_allowed() and
> >    mem_cgroup_node_allowed() to return effective_mems, allowing directly
> >    logic-and operation against demotion targets.
> >
> > 2. next_demotion_node() returns a preferred demotion target, but it does
>
> does or does not?
>
> >    check the node against allowed nodes.
> >
> >    Patch 2 ensures that next_demotion_node() filters against the allowed
> >    node mask and selects the closest demotion target to the source node.


Hi Shakeel,

Thank you for taking the time to review this patch series and for the
helpful corrections. I also appreciate the reminder about the patch
replying rule and will make sure to send future revisions independently.

Have a great weekend!

Best,
Bing


