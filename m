Return-Path: <cgroups+bounces-14381-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGOKKABMn2l+ZwQAu9opvQ
	(envelope-from <cgroups+bounces-14381-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:22:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 083CA19CB10
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D057303FDCE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0703BFE40;
	Wed, 25 Feb 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jmkbEzEK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA012D7DE1
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047357; cv=none; b=VjjE6XvBrAw4kif1PJ3huSPs9QaXChuWlA75chgfH3EIcrwwio0dGBb8WlFIaTf7sS33cOsxAsnm9a88npTM4/XUGKUZgJqz7QpO0wGmmB6r/3Ny4/TZHZj4F8pHxepbwVen7z51loc6XG7obNpO6DRiQLxZmtOPvN/u7az6leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047357; c=relaxed/simple;
	bh=+Z2T39qnjbk6NX4BACvcTRH65Y+ld+SufE7IHslStG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRVhSaiIaHFY4d3pDfLD07OkrjC84JVBBNmvcz0Q2CwX8SP80Fj8x8gpHOpjztwiq5LeyUdqWXDJeiWPkmQc9ER2JA6PwZ9Lidd7TiFqdQn/pNQEO5eDcjwzEvsCvbqIgRWf2UcG1O1QDvRQioSwhWojUsNofjZNFmjzO9oOU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jmkbEzEK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899b2cd5a83so10694766d6.1
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772047354; x=1772652154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZE3SCr1J71Zf7ijSjOgv70RQ5IlZZe/EDYwe69yiQk=;
        b=jmkbEzEKpn26wUgV2vcGimgXFK1Qif5uPr7njDIweWvy8hWPYWD6puAaM3//MUYjRv
         2YthGWmcesbH4zrOPARW2P9Fbp2OU9t7NNXgfGD1fNYPWnqQiMGFde+ICTLW0rdNxjYq
         5BxCWHWh/uS+JUoSSwtED893KnXmlLrJrGeW1p0z9/7DPUC2gBg2/0o1ZyViKWLf6ycc
         tWSU/7VMZV+ZK9ZXtNHsfn5VC/D/GG4jn0gPEzYWBr7ry5KH4BEYa8zzpZjqddGbfjl0
         nQ//8oSAr8Ow2C6Amv82eW47w9aaDPhx+Hnj4LLewPosQZa1wCBfKDiheYDqiNDoVuow
         XWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772047354; x=1772652154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZE3SCr1J71Zf7ijSjOgv70RQ5IlZZe/EDYwe69yiQk=;
        b=J1XyZHypRpyTB1LtgPmvsNp3h2BJq1B4b4rQQ8kRq0sQt+G+brP6meL+y0tAQhVN3c
         NcvVHuju5I9TqzC7JfUrSMEywyum8WA86SKNbePhr4s+B2R3A5dnu+9l8gAbQkhyxUmY
         wY6HouXsMzCvSlw7QjuxEi+rsMZvBliySu0ucI5oHp03ogWvxYk2Ump3NCYO6c2e5BQL
         JDS9zGkuua7my29iIY4VulhW59fw1B+Z4PkUK3Cxd4LJGXYmuTC3ZGIvo1B0zC86pXbp
         xDiWC3yUkWynEr8DNZ5fO/vurONtI5ysG3sk59f1kn2VhH18CtospN+05RiUpc1KSxhN
         KF6w==
X-Forwarded-Encrypted: i=1; AJvYcCW2KV/ZsVrS76sciiPAwAIy0+u4fPLRbUNrFyKA3lL2z9DL5O9v/89WEkBRVrJQ7Uk8pwIjV526@vger.kernel.org
X-Gm-Message-State: AOJu0YzZl6t9kb1BemJChEkCt7Nc5hr4+JgaqkdnXeH8xz9XLQUZaUpH
	EClvSTkRJprbZj1ObjOWtZHlQdfEP1NOhwPnG8P+XnbzFmLsma43t1z7pToJACWZjmyzuVEtFxO
	9ROkT
X-Gm-Gg: ATEYQzzRGuLskMnQYxBJboFXzuCBXxticVGIjvLp3lrMCEhIp2F159opF1zPta57997
	/JugY1XwabH/sNVf1+th1VpG2Mq7Fx0PouAcHx9ueBjwif4ygDW9FN30BjRtjk6nq9DnaTnqxgS
	Wj0iqzrF1mWcHdlqx8TrVojb+MNMnxBEcGawQ+gTLsqC9Z4VbdaxD2KuwYz5t1PceZpSVVwoJIE
	fhwpqbnEvscESsdCFjpYrXEQeph+xj8DF7D0yQfCVKpabTsxDFb84ZoemT462GRm3/kfqAMEbwb
	jnewac7ShsH6pY3NiCCEwcFSpvfEoCpQQUXO5tKl5yiatx38XeCbTX78z3O1lfybQ/uvCvLb93z
	qbaOZFXTueZmFUsK1wV/saebQmDMiSvZPagS3QLr5/Z+POSPQR8aBvmX3hAMZaFRhcRu0XtnJNC
	36nzz6XpEkboYFaMZjNaefpw==
X-Received: by 2002:a05:6214:c29:b0:896:af07:a50b with SMTP id 6a1803df08f44-899c6817de8mr2664606d6.25.1772047354016;
        Wed, 25 Feb 2026 11:22:34 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b3fecb32sm33790086d6.5.2026.02.25.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:22:33 -0800 (PST)
Date: Wed, 25 Feb 2026 14:22:29 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] memcg: Add memcg_stat_mod()
Message-ID: <aZ9L9Qty5Mr6440Y@cmpxchg.org>
References: <20260225162319.315281-1-willy@infradead.org>
 <20260225162319.315281-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225162319.315281-2-willy@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14381-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 083CA19CB10
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:22:15PM +0000, Matthew Wilcox (Oracle) wrote:
> This function lets the caller find the memcg somewhere other than
> page->memcg_data.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -787,24 +787,27 @@ void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  		mod_memcg_lruvec_state(lruvec, idx, val);
>  }
>  
> +void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
> +		enum node_stat_item idx, long val)
> +{
> +	/* Untracked pages have no memcg, no lruvec. Update only the node */
> +	if (!memcg) {
> +		mod_node_page_state(pgdat, idx, val);
> +	} else {
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +		mod_lruvec_state(lruvec, idx, val);
> +	}
> +}

The refactor (and the one in the next patch) looks good to me.

But we already have a mod_memcg_state(), which genuinely just updates
the memcg counters, and memcg_stat_mod() makes it a bit non-obvious
that this is a "core" stat accounting function (that happens to do
memcg when compiled in).

Can we go with this instead?

	void mod_node_memcg_state(pg_data_t *, struct mem_cgroup *, ...)

