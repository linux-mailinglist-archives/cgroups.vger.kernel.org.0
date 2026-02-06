Return-Path: <cgroups+bounces-13729-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPexH8pchWmfAgQAu9opvQ
	(envelope-from <cgroups+bounces-13729-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 04:15:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C675DF99AB
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 04:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5369A300821F
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4E92FE053;
	Fri,  6 Feb 2026 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdmgRg3q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632B2C21D9;
	Fri,  6 Feb 2026 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347718; cv=none; b=aJQ1oWMQatpyKLDbiZEv2K67BA2KkG3tKbR1mbQL5UY9bFAPiAuS6V2Vki8+BBYTyrN0QO+nlcgkigee606zvn31iP52VOVgs3unDAyYrWInyqawlseRqJestfmT+KtQqi2FugyUMSpyAAhCFM8/SsbBRbEWMimgMoauw1xp06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347718; c=relaxed/simple;
	bh=uPXDqLDLtK0pqdFOgCp+rr9C19DDhLskCTGooJBdwTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH1pV2LIr8WURLEl9B3Y8XWrely62+EI6XLUZsT6FMKRPgyjszY9CBGrUxfDAFJMeDgJ6s6IpiJ77Q5PxVTZhkaEBy52typn5Xhcrg7P5jRtyhv9Am31g+gr6FiD0fNLBBRnzuDs7DCw+8S8jHuc9j1qMpoRXTo8P6ocwsZ8SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdmgRg3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F98C4CEF7;
	Fri,  6 Feb 2026 03:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770347718;
	bh=uPXDqLDLtK0pqdFOgCp+rr9C19DDhLskCTGooJBdwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdmgRg3qyn6J8aDsbqLaGp0YTTaluhiZhWbkHR3umhSBbE8aYtGUlHk/e/adSV9hW
	 VkRWFb1ddniw7FTb+jOja5JusVe1kt63cNiVsMwknLtRRCRQ6apiwHp9HbeZivqfzV
	 QHwRU4m05XBFBFW5uCuhh/x1oXdDQ2NMe9sF8BI7ax9S3W7rp944KLlnBccq4blXhZ
	 ecX2zxqDsd403YnagGtHitK2eKdvWjCspHuoe1tSeiTulxdmSgVwhYpkTimAyqlV7u
	 s+RU+pd7A4bcugMnk7Fjfk851NxzpT0KnjHdPWRO451TyVqifObRGPnCkAaxAJKjQo
	 74KzFLtsloFbQ==
From: SeongJae Park <sj@kernel.org>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	"Jiayuan Chen" <jiayuan.chen@shopee.com>,
	"Johannes Weiner" <hannes@cmpxchg.org>,
	"Michal Hocko" <mhocko@kernel.org>,
	"Roman Gushchin" <roman.gushchin@linux.dev>,
	"Shakeel Butt" <shakeel.butt@linux.dev>,
	"Muchun Song" <muchun.song@linux.dev>,
	"Yosry Ahmed" <yosry.ahmed@linux.dev>,
	"Nhat Pham" <nphamcs@gmail.com>,
	"Chengming Zhou" <chengming.zhou@linux.dev>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Nick Terrell" <terrelln@fb.com>,
	"David Sterba" <dsterba@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible pages
Date: Thu,  5 Feb 2026 19:15:09 -0800
Message-ID: <20260206031509.68313-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e155ad8af874f10baaed91f1d12fde222b82036b@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,shopee.com,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,fb.com,suse.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13729-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C675DF99AB
X-Rspamd-Action: no action

On Fri, 06 Feb 2026 02:47:58 +0000 "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote:

> February 6, 2026 at 10:21, "SeongJae Park" <sj@kernel.org mailto:sj@kernel.org?to=%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:
> 
> 
> > 
> > On Thu, 5 Feb 2026 13:30:12 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
[...]
> > >  @@ -941,7 +941,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > >  zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->length);
> > >  
> > >  /* zswap entries of length PAGE_SIZE are not compressed. */
> > >  - if (entry->length = PAGE_SIZE) {
> > >  + if (zswap_is_raw(entry->length)) {
> > >  WARN_ON_ONCE(input->length != PAGE_SIZE);
> > >  memcpy_from_sglist(kmap_local_folio(folio, 0), input, 0, PAGE_SIZE);
> > >  dlen = PAGE_SIZE;
> > > 
> > Below this part, I show 'dlen = PAGE_SIZE'. Should it also be converted to
> > use the helper function?
> > 
> 
> The dlen variable represents the decompressed (plaintext) size.
> Since we compress individual pages, the decompressed output should
> always be PAGE_SIZE in normal cases.
> 
> This check validates whether decompression produced the expected result, not whether the entry is incompressible.
> 
> Using zswap_is_incomp() here would be semantically incorrect - the helper is meant to check if an
> entry was stored without compression (i.e., compression failed to reduce size), while dlen = PAGE_SIZE
> verifies the output of decompression is valid.

You are right.  Thank you for kindly correcting me.


Thanks,
SJ

