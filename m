Return-Path: <cgroups+bounces-14474-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMwWElzGoWkVwQQAu9opvQ
	(envelope-from <cgroups+bounces-14474-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 17:29:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3D1BACC8
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 17:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9772630B929C
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03044CF20;
	Fri, 27 Feb 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KKzzvY48"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECC44CAEE;
	Fri, 27 Feb 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209537; cv=none; b=LTQZLTmll4BzvW5RFpjJus63WMhyy0gziqb/Od+cDn9hfpAk8LwhGHieQhP9Agjd7V3WwrHzDsOcLqRsun6us0ueIU2E2gKvUSscg7tf5wwrZjNbkex2vhAugR3OkO9tEptj1jYWWCh1m5gAsxXWWADDEO0FbVsJvbKQT5i9To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209537; c=relaxed/simple;
	bh=7xEINRTAimo9zk78jI743F6BvgPfrdmSZbFfWT+92dU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=coIuof3iko4gH4OBMoY3JO5Nabj+nUzSKHAPeYNBWDK+1AdK4Upf8Cu2eqLlZmlBA34vVf4Se1rj9JzkJk8HpIkL5NGWiku7aeGjcTDyYXP8F0pt0iB3vBieTl3vIaTGGy2/ebqZ5uM86+mu94Ru1BzTaiwR6+VY1ZN0Miv5Btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KKzzvY48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1F3C116C6;
	Fri, 27 Feb 2026 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772209536;
	bh=7xEINRTAimo9zk78jI743F6BvgPfrdmSZbFfWT+92dU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKzzvY48u5koshSFJjWshX08j71sHv+Vp0qJfkQtv5h4cGlYXTjGhtqg1zesBcPS2
	 OBkwaHxVe+49hGHff2PSxCY5Kbx5mkkvVgHMwGxsJIuqmPT+fV5Uaqw90dYTPBteVt
	 BdwhuU26H2QObnp6KVYR1ZQNS6hP+9afhKGinmyE=
Date: Fri, 27 Feb 2026 08:25:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, vbabka@suse.cz, harry.yoo@oracle.com,
 muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock()
 trylock path
Message-Id: <20260227082535.9c83176e7ab9f92f6b80aee6@linux-foundation.org>
In-Reply-To: <twvbu57mdw7ekw26spzzy5e6quq7k7hko3hvxttv6yjlhyuhpb@iolbg2iwsowx>
References: <20260226115145.62903-1-hao.li@linux.dev>
	<aaBM0fN8fqER7Avf@linux.dev>
	<e759dd9b-0857-4155-b570-cd002155f123@suse.com>
	<siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
	<25f6a18c-0600-4a21-977e-19b8b4b203b2@suse.com>
	<twvbu57mdw7ekw26spzzy5e6quq7k7hko3hvxttv6yjlhyuhpb@iolbg2iwsowx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14474-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux-foundation.org:mid,linux-foundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2B3D1BACC8
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 16:37:16 +0800 Hao Li <hao.li@linux.dev> wrote:

> > Thanks, I'm sure Andrew will amend the changelog with those useful details.
> 
> Got it. Thanks.

I made that edit, thanks.

