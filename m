Return-Path: <cgroups+bounces-13552-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NVUAW7ofGlTPQIAu9opvQ
	(envelope-from <cgroups+bounces-13552-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 18:20:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58037BCFB5
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818C8305BAAB
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824D3502AC;
	Fri, 30 Jan 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2ubaMuB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB72D46B2;
	Fri, 30 Jan 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793329; cv=none; b=F55enGW9vshVwMpLdEfVw7h1KPL1DB9lQSdOZhMJiwf2s5goBciVbQWggP9TPioXqcTgF72oTpUqB3wYbi5Mtp9qNiJMcAl2eGqCfDjXcP+qlgElgiWSU0K11cuNxmsN/HmIzPWOeZLGDuLtL4cHk47tOjoOufJDmmpVflY2pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793329; c=relaxed/simple;
	bh=jxXn6m945TBmC6BfrDwQWKtLI1+Q7FkOv1CrhidxGy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqmnwEyUijE4CmeErXCqP6AkJZywmHFgEYRp1V1nBuIA2bbpR3pImd2BM5sNYDItbQ8qAdWB0R1Z2nHxfhYvdOzulg2tiNyq/AIkI9ytaXicjur3xl80uTevJ0tuncVBfGEYCc+9D1sjLa/xKSUMay5+e61B4Ex0Qb0I5EIMdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2ubaMuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77291C116C6;
	Fri, 30 Jan 2026 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793329;
	bh=jxXn6m945TBmC6BfrDwQWKtLI1+Q7FkOv1CrhidxGy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2ubaMuBK0Dul617ENOHK6lixnYelJ+XGt8YfOvx6lZfWK184M4bTZ5ti9AaJ5WIp
	 +ZGmCRoApw+C+018u39fflu5gGkx+Zcws2tkKY0NCW27ac/KVfceSQ3oKFPGLvbR78
	 95H7rV6UAtsVdzHvz/nfrjfc5bYEmxZqGnsI2tQWcRQBVTFc3sREWy8oMa7KLuhCqm
	 CVKZRSHMlyBjzeXFqfVzU0crCqE2ZWbGDzytpm6U7TKFi5NAWc/b5AZVkVqd/R9tH7
	 YRdgOB6h9Y+Fu/k1Em4+mAkAqxA4hCJZUMQtXGeG6Jfz2IAibqotkMUIF6NIHFjXTO
	 erSrVRk67HFdA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7277AF4007E;
	Fri, 30 Jan 2026 12:15:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 12:15:27 -0500
X-ME-Sender: <xms:L-d8aRARsuZtTmmKi1ii0TEctX7RhiqLmn-KVE7S5YeFUna9kMOAEQ>
    <xme:L-d8abPx6GSsS_-EIIJBsHAUVzTE6vB4hswr6wc1zu0bch2Z80tBliUxziHnOsRik
    L5YmmWWKjyThv0N4PmmObnIF96gWzcq3Lhzc3uu9prlz3BMXtWMRAA>
X-ME-Received: <xmr:L-d8aQNZlQUpfOm4WrQYstq4VEZciw3MGQace3pCKjNPrELws2XCPN1EoAINWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopegrkh
    hpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgrnhhn
    vghssegtmhhpgigthhhgrdhorhhgpdhrtghpthhtoheprhhivghlsehsuhhrrhhivghlrd
    gtohhmpdhrtghpthhtohepshhonhhglhhiuhgsrhgrvhhinhhgsehfsgdrtghomhdprhgt
    phhtthhopehushgrmhgrrghrihhfieegvdesghhmrghilhdrtghomhdprhgtphhtthhope
    gurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtg
    homh
X-ME-Proxy: <xmx:L-d8acBmVSRCOlwcuQfSPvjfFYKwakiggQWFUBEznGJtbV2CZ0GPrQ>
    <xmx:L-d8aUSF01Z6B6EXFSb_k7ibeUEEhRaau-imA2rV2Zey6AiNJUYdmw>
    <xmx:L-d8aWZ3qUlUPWjhTsSVwC5M8UHrB0WBzUzSMuuMfyLeSsxjAVzaxg>
    <xmx:L-d8aZ8RBuDHu266bpPPm4Dd-kk-BRud7vllJQPwlWtowIVpH7fIBA>
    <xmx:L-d8aSJp20pzHqnSsR-cm_24rfcC76Gxcle0pOP8xK8PUiyLiNEHoRwr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:15:25 -0500 (EST)
Date: Fri, 30 Jan 2026 17:15:20 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>, 
	Song Liu <songliubraving@fb.com>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
Message-ID: <aXzmgp84VD0Vt3KC@thinkstation>
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130042925.2797946-1-shakeel.butt@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13552-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,surriel.com,fb.com,gmail.com,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58037BCFB5
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:29:25PM -0800, Shakeel Butt wrote:
> In META's fleet, we observed high-level cgroups showing zero file memcg
> stats while their descendants had non-zero values. Investigation using
> drgn revealed that these parent cgroups actually had negative file stats,
> aggregated from their children.
> 
> This issue became more frequent after deploying thp-always more widely,
> pointing to a correlation with THP file collapsing. The root cause is
> that collapse_file() assumes old folios and the new THP belong to the
> same node and memcg. When this assumption breaks, stats become skewed.
> The bug affects not just memcg stats but also per-numa stats, and not
> just NR_FILE_PAGES but also NR_SHMEM.
> 
> The assumption breaks in scenarios such as:
> 
> 1. Small folios allocated on one node while the THP gets allocated on a
>    different node.
> 
> 2. A package downloader running in one cgroup populates the page cache,
>    while a job in a different cgroup executes the downloaded binary.
> 
> 3. A file shared between processes in different cgroups, where one
>    process faults in the pages and khugepaged (or madvise(COLLAPSE))
>    collapses them on behalf of the other.
> 
> Fix the accounting by explicitly incrementing stats for the new THP and
> decrementing stats for the old folios being replaced.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")

My bug survived for almost 10 years!

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

