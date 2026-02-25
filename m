Return-Path: <cgroups+bounces-14384-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMvjFLFin2lRagQAu9opvQ
	(envelope-from <cgroups+bounces-14384-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:59:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3419D827
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 772F4307319B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D732FD685;
	Wed, 25 Feb 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OzRZeBqt"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA9292936
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053082; cv=none; b=XaPPgTX5GRMA6itm5mYndx4LIsyOmHe7iXaGzEvPfTWb9QKQq+dnfnlPnJazHl9uLPJzSnIg8BK5FaEgafEre+0YDSukghajEICarjDJMjwinE8RtcSKV8gRYak4fyFjlkIOLwW8H4bjFqiW9dFYfi9Tnzjjl1nNvK3rN16x3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053082; c=relaxed/simple;
	bh=7wyChE+IKBVm6kaY+nDhj1hTfQvzusPmhc2cWITPXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFQQlodvYLafjY06EfFerS3MYASnGkQD+hNpXsllJafRVsdrYJOVN5zNWTSeaikgHlY9ityKFLmc/Whbcte+mK3QT7z6rryHeLiav5KGVIDbdf8/KAvQSFfDD8Wn8ck4cb2Kq+1KMva7pksMyMhvmF4g3w3ow7a+rjYwQYtqDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OzRZeBqt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4bQL2DktOVXOKwssA689TwMNm5YeFPHFhQxFj3pF8/8=; b=OzRZeBqt0nq2TdNWknkKFl5FLt
	gqOdqltp7xjaUYmlrjYFlUKzNOZ6fHyH7u2A7xNKzf668CgjHfc8mfRT4NQxDFLmQTpdb3jtTv0o2
	5fue3M+n0zKbyed5SFNHSdOCGEXQ65BK7daaAa1Ys5h6/inH2GQ+P1BNlnRhBNyRDcjxeivCHAEqp
	evQOO19NdgRWOxfiE4kV5Ry8T/7qneeut2VcCtCHE5oWaPjEe+1dBNvuPuipSJiaushd6XPLqXzpU
	wQbQA8VIiEGQaxucab9o0GFbFEygU8BjXVYRZnkvyVsRGbLa8CeTDiG6KO4hZo3a8h2y+ovvzpGfW
	9IrR29Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLxF-00000001e1C-2dOQ;
	Wed, 25 Feb 2026 20:57:57 +0000
Date: Wed, 25 Feb 2026 20:57:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
Message-ID: <aZ9iVaWueDjbeVB-@casper.infradead.org>
References: <20260225162319.315281-1-willy@infradead.org>
 <20260225162319.315281-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225162319.315281-4-willy@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[casper.infradead.org:server fail,sto.lore.kernel.org:server fail,infradead.org:server fail];
	TAGGED_FROM(0.00)[bounces-14384-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5F3419D827
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:22:17PM +0000, Matthew Wilcox (Oracle) wrote:
>  static inline void __pagetable_ctor(struct ptdesc *ptdesc)
>  {
>  	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
> +	struct mem_cgroup *memcg = pagetable_memcg(ptdesc);
>  
>  	__SetPageTable(ptdesc_page(ptdesc));
> -	mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
> +	memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
>  }

It occurs to me that we're not holding the rcu_read_lock() here
(whereas we do for the other two callers).  I'm not quite clear
on what the rcu read lock is protecting here -- can it be that the
memcg is rcu-freed while a page table belongs to it?  Or does the task
existing prevent the memcg from being freed?

(is there documentation on this that I've been unable to find?)


