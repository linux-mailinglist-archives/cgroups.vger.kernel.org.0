Return-Path: <cgroups+bounces-17162-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XoUyO+vQOWpyxwcAu9opvQ
	(envelope-from <cgroups+bounces-17162-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:18:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCD6B2F2B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lzkxjb8g;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17162-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17162-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209E73033536
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316511DD0EF;
	Tue, 23 Jun 2026 00:18:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE23B1BD;
	Tue, 23 Jun 2026 00:18:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173928; cv=none; b=NCB0H0oSKK00nRM/D89r2OfC9JJhXO4Qxti69V8GdbWH+v5am5WuFNzvRwrFI02P+B4rduDf23r2wYsj+GiW24tpnJugxSXSiFx502ifdzcr5/ugwi+oAUSEG2J9EjSzKC7XgVCUv0leBrACaAhXMzyTHlJJtZbEY7pRCF8XFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173928; c=relaxed/simple;
	bh=kUqoMk1e/PZiyxAV0DR0ptpAZKUfCRVcRqdeRrBxntQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arIN02Zc+SD444Ax7Pd5Fv1veOEHialh1lnmDQnJAcFGNp3deSpVqEW7hA4V1d4IiQyJP1Cqz3FUGfTuTpoi4mD7cZitVaqZzHg4LlQhouPiL0fStzPZ2hlKuw8zj8XtjY5ImZewzR5L9dXHSGKLpztHJnOtZKuDnVDDl7UF0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzkxjb8g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C191F000E9;
	Tue, 23 Jun 2026 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782173926;
	bh=Bqkm7vO1HQAEaTJZatZzByS6cW5Og9eP4FfT+b0aJMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lzkxjb8gTAUFi+dkHf+UzFnYTQdioFDW6caG+yF1SKfcdd3MPgXa6Afpy2xI/Faxp
	 +rmXkMJ4DOQJ8Kzqo4xU1Z9VxEmT8RVu568mcMtKDB5zFDwThCtAUZusKtLucv2Kzc
	 3LT7ANwqB/vTXnm6ONxdchyCFfi5pDnP4jYyyomO6c2mT8uBulnFCvKm0t5ENXD+K4
	 +LAw9TFTfJzopdu9aVb8Fw918A9g6Qqfde3u2yU//HrtbR6yBjDMGZJgRBcgn3NOWJ
	 I4rdU+QPO5xGbKcuA41ClXt2Q+HlD4Mq78jXjqkYbfwgS52kzCbRL4hG2anltdRrAW
	 fzweHkBaG+yfw==
Date: Tue, 23 Jun 2026 00:18:44 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, youngjun.park@lge.com, 
	chengming.zhou@linux.dev, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, qi.zheng@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/7] mm, swap: support zswap and zeroswap as vswap
 backends
Message-ID: <ajnQxMY0W3VGyAUE@google.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
 <20260612193738.2183968-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612193738.2183968-3-nphamcs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17162-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EFCD6B2F2B

[..]  
> @@ -1623,16 +1642,14 @@ int zswap_load(struct folio *folio)
>  	if (entry->objcg)
>  		count_objcg_events(entry->objcg, ZSWPIN, 1);
>  
> -	/*
> -	 * We are reading into the swapcache, invalidate zswap entry.
> -	 * The swapcache is the authoritative owner of the page and
> -	 * its mappings, and the pressure that results from having two
> -	 * in-memory copies outweighs any benefits of caching the
> -	 * compression work.
> -	 */

Forgot to ask, is dropping this comment intentional?

>  	folio_mark_dirty(folio);
> -	xa_erase(tree, offset);
> -	zswap_entry_free(entry);
> +
> +	if (swap_is_vswap(si)) {
> +		folio_release_vswap_backing(folio);
> +	} else {
> +		xa_erase(swap_zswap_tree(swp), swp_offset(swp));
> +		zswap_entry_free(entry);
> +	}
>  
>  	folio_unlock(folio);
>  	return 0;
> -- 
> 2.53.0-Meta
> 

