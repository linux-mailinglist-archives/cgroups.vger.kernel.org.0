Return-Path: <cgroups+bounces-15251-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FFMFAKa3GkxUAkAu9opvQ
	(envelope-from <cgroups+bounces-15251-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:23:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A47553E82B5
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87A7730068CB
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9C3921E0;
	Mon, 13 Apr 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="axhB9mbw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143838947C
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065023; cv=none; b=jmwZvImjiFqUO+yktNzlg7cCzZRH+kIyl+DDypmvd7LRF/dkaXP2utwNVyTQrMMCYBeCp3I19344dP5TCwMGqgeOK4nMNQd2rr35ok+yGnL++fF1CREqvLyt0HlDxmtqfLHCF2sZAqN+D/UmOv7qsRgG6GF3tUYxp3p/GwSl0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065023; c=relaxed/simple;
	bh=x3SDL32StMHQJXTyvvaxQCfLIBFSGgUUXwjjJZ0WEQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvd814XgRcAum+mpWJVueliInEhGK5Hrlr3mtY/u4a89dxjTeb664GLiOrJHd4LAPHAfmB2lyH7s99G+JV2uplwLuMz6mOuAkfpBkiysFaX6yacm2kVai6quCCsoku859W2nzdTg0p/Kxm5nGDAuWt0z+bb09PD0G6k+t7uNI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axhB9mbw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso37833515e9.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776065020; x=1776669820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nzuZ3kIIyE/QcfErtqwJVEa14xLXdZqRnEwseWxDOo=;
        b=axhB9mbw9wC0Q0r8zPkxhQegXkjtDlIpg1WPwB7XpDiLxzM6cqCLYlIZaCnIVklZzz
         FO9mgwGl4KPKZG/4LZ9Uz6bVwRDwLG18dBRZsvvAIErNu1278Dk+tC6eBXFcPBAq2Go0
         1CibuuTkLZ/rd5Mw9fb1KGaBRCgn4cHMHfFnFbYwQc1kFu7AHgvQcnC0+osXiHO0Mmlu
         r8zTvOfS3suxmUf+83y7Gm7N6CauIlatidhduJz3SY9bclHJ6mrsh3F17CGmyfAAi8YO
         qijJhmwt5qVxV4l//8i4ZgSkVdHpK7BfSeDc5FQEorPqY7aKoETyM2tF6iJNrIt9u3U9
         Y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065020; x=1776669820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nzuZ3kIIyE/QcfErtqwJVEa14xLXdZqRnEwseWxDOo=;
        b=aIGUHleUd6ot/TEQpwtVwpfON1eQkaZNMiI3txaujfisVGtSTXWoa+G4W5P3w3IzUr
         WtpqigDhNJ6r7qbEz7lxcOABEYlKPAiAAtNaQC1J9JDhjnZFbiAnVBL2F9sGTrss2M1N
         58jXcdfUb+ZPVTxYVBNnoUkdmZsUUDMIhFPflx1wS7SVu8B9nK4qKKw4kiFlDpThEfPm
         Xdu42MESUgZZdVkvIH3+aveZUUQ1sdTHT7t7bBXoiOGOve8v46LgUNI005CdcSUU1/Dm
         dnZVhOjaj6Bb5/7Cg56/6pMiR36D/qkmvyYSGPudWmIGAqtM7t9GB5Ym7fQFh6SQMtau
         r2Kw==
X-Forwarded-Encrypted: i=1; AFNElJ+F8sNRuZRs0eDNziMrDVD2tS2KDHXtZtUXpkkVpa+vg20xvJ9yhtpZRq0ktOcfWuyWuM4L6VPd@vger.kernel.org
X-Gm-Message-State: AOJu0YwRA208Fvg1uxe1dVWnnMe2MgvQeS46Y3wYoyNpgdcj8TvLnAbV
	xTa+bzbqwkenMFylwE+O/ifjLStzFh5n87N0rYtpMxo4h/VX6JSbaZqT3fxGSQD/ccE=
X-Gm-Gg: AeBDieuyS0NaoMPBHPcaracQ1t8Myl+nXKMgKWjNLtm1RkHlEG4hXnWXL8Dyni3yc2G
	/WbOslhMf9CBtrEE6K/zonX59+qj7QiWaot4zSzYVkTrpYZikv6I3uL1N/HdVYXtLMCQ7MmDsUS
	oD82kqZ4tUQiulCSe6N9QGEYkHfHa9SKWh+UxWwJbDuAReMc0pXTw8CKGDI/JvRV0G0PLzw4aFS
	lg0tgpgBB+abUCJpinVrB77rxiQkpseb66Bn5Z4UTbW7kbwSuYjvqM9ibO8RCD+xlm9IPR8F54G
	n/YF8UzqVdEhmf9Ea4hLxrPOPpHAF4G3J1QXJxQTFWzY0ir64IZTEohvceK4ib3RpOklvoBfQ/b
	/J1T+LyL3j9U76tOIJ8UTV89NfDYZVo5w8hFmBpqftR/99TdJWd8qBaYuQSCpPDGIp4qXlDmW3E
	9uUrLdQ+bKuzuc85MdkSQ2D57Qo4mO87zXDQBAKE9mL34/
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-488d67fa48emr170788255e9.9.1776065020262;
        Mon, 13 Apr 2026 00:23:40 -0700 (PDT)
Received: from localhost (109-81-29-22.rct.o2.cz. [109.81.29.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5dc7070sm89322685e9.10.2026.04.13.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:23:39 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:23:38 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/8 RFC] mm/memcontrol, page_counter: move stock from
 mem_cgroup to page_counter
Message-ID: <adyZ-t4fiKFv_X5p@tiehlicka>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15251-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,nr_leaf_cgroups:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A47553E82B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri 10-04-26 14:06:54, Joshua Hahn wrote:
> Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> allocations, allowing small allocations and frees to avoid walking the
> expensive mem_cgroup hierarchy traversal on each charge. This design
> introduces a fastpath to charge/uncharge, but has several limitations:
> 
> 1. Each CPU can track up to 7 (NR_MEMCG_STOCK) mem_cgroups. When more
>    than 7 mem_cgroups are actively charging on a single CPU, a random
>    victim is evicted, and its associated stock is drained, which
>    triggers unnecessary hierarchy walks.
> 
>    Note that previously there used to be a 1-1 mapping between CPU and
>    memcg stock; it was bumped up to 7 in f735eebe55f8f ("multi-memcg
>    percpu charge cache") because it was observed that stock would
>    frequently get flushed and refilled.

All true but it is quite important to note that this all is bounded to
nr_online_cpus*NR_MEMCG_STOCK*MEMCG_CHARGE_BATCH. You are proposing to
increase this to s@NR_MEMCG_STOCK@nr_leaf_cgroups@. In invornments with
many cpus and and directly charged cgroups this can be considerable
hidden overcharge. Have you considered that and evaluated potential
impact?

> 2. Stock management is tightly coupled to struct mem_cgroup, which
>    makes it difficult to add a new page_counter to struct mem_cgroup
>    and do its own stock management, since each operation has to be
>    duplicated.

Could you expand why this is a problem we need to address?

> 3. Each stock slot requires a css reference, as well as a traversal
>    overhead on every stock operation to check which cpu-memcg we are
>    trying to consume stock for.

Why is this a problem?
 
Please also be more explicit what kind of workloads are going to benefit
from this change. The existing caching scheme is simple and ineffective
but is it worth improving (likely your points 2 and 3 could clarify that)?

All that being said, I like the resulting code which is much easier to
follow. The caching is nicely transparent in the charging path which is
a plus. My main worry is that caching has caused some confusion in the
past and this change will amplify that by the scaling the amount of
cached charge. This needs to be really carefully evaluated.
-- 
Michal Hocko
SUSE Labs

