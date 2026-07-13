Return-Path: <cgroups+bounces-17712-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 717tBS/PVGqIfAAAu9opvQ
	(envelope-from <cgroups+bounces-17712-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:42:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4774A780
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:42:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=kkquYt9k;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17712-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17712-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB87D300F460
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0753EA976;
	Mon, 13 Jul 2026 11:42:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C13E866B
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 11:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942956; cv=none; b=JYsOqVLYzCzWLvU4qzvo5Y7C4RRMlUh6Y8NCyEWxKX5luIWBL5poXUIQmwutoWs6BLM3qjFoyOGIwX9a6xt3ix+Aoa59fiU3KVJOkG2HUMZbePcsg7cUB0yWZjg1IFlp4yMSwxwtdQJfzV6YxDp2A6eLXDOsPGkWZ+eV8pW8+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942956; c=relaxed/simple;
	bh=hjXhgQD4IXmOoKl0Clv4ZIFutaZz0CXGdXZC2RxEmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2yIs+Z9LPRfKYR5pN8vueXMMFLSWH7P7z5YkpAFL7rvq9LkA+jmqFksJpl6RkL4azhMs4w8jZ2q88NIH1aip/o4/UYlZ02ZIPF+WV3bMsbaW1gzRf7hJvOoeIa+ZGIvhNBedzZbpdSESZphMtwQyWYFm8W9AU+NfRrw1E6QcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=kkquYt9k; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso22460985e9.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942953; x=1784547753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OeXxht4zO4qJTxPARll6C6hUG6HETDvT4L4AW5UaiKw=;
        b=kkquYt9k0u4I1ea95APQ1U092/1J/sK7TozyEhecJjPASmXCZ3DFC9VQsxSKZGj579
         vklQzFiSjiQI9HAt2uRQqzq6myKUdxf2aphc5IjWPFqwknMak6aqVMtWKWq6VCDXWDS5
         lmibGDduZIbFRpaKCMt0IPgUc44FrTWXzftDCzGhXNqYroBAYtY4Am8vlTwizad4u1ms
         vg6aceI2b6axMvV0AgQe8FfO8E0OaruqYrnH8XkM+HNGzCYH/896U2STRv2F+xNWZOFw
         a2gziEYHdVMM8jgvhzbKHmeMa64JFZ7LlbjfAyuW6hu028V/UqkcTPEugfBbmXHy4Emw
         SjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942953; x=1784547753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OeXxht4zO4qJTxPARll6C6hUG6HETDvT4L4AW5UaiKw=;
        b=Q0dtdz/BWq7bM+bfssPYc4tPHA34QDYeI+Hgx5W36KCr0E6OPwFL2FW4WfF4qoA4v+
         +S4vZSqQ3/TABLdLOyPD3KP9puyZYsXH0vXdHpEobY8ZrqaVSsPwJD0TWkDiHItwxOCR
         T8STBcfbO0S26W7RZu63+zOfj1Z6+MEGROiGQN5ksSrEg+TYDP0St4SKAPAFRw2do0iq
         2Bsb70dw4iI+Npb1Drsjtpa+eD/9e1GIOcTS+8t5QTxEqaExVGcBrVqlPF6JkjW+QbZh
         +pJYLSfsFMLlcXnotbEj88ndvFeAX7I3xzX0+Z5o3inAnbbr4mxUyCXIhBy+BeJAy1K8
         EO+g==
X-Forwarded-Encrypted: i=1; AHgh+Rqc+tR67Kycz4yjBiXFFwwHkHCR9/q7daxR8YNAdsJwcmOdbwRkeQSn36Gh8ybk+D5ORKoKuj07@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2sdRKPNdUsgogT4obligRPjWafwRNoJ0jnPqzgr7bKEQepe8
	hvx7SI749eujUJ6mlNctPJa4LzTMgYlrZz6BbWd0xoLWblwiVxxDdOXq/6whBrkIiBI=
X-Gm-Gg: AfdE7ck4mP5ATL9LPGKQrcEXJNN/KSP9qLp3dQZMJYu3xZ2RVWFwu0iqIaIAQ3cu6xU
	eU44oGbQE/WQrKyRtMUlHY8iKpWj+gIxlHZcGFqsAKzTMvwPjaQFNJrjeR6d4+pGC5SCc3bJoUZ
	G9BdHq/mcD6Sh8bbh5J+jxfwZ1NiPhwgpNyS1uh8jOQOsWeiPRhcacCW5OWt6b7kO8PAXQZ/iKI
	kWmUu7yTc5TjN+d+iMmUQaqg61xEnUQVVank6a39z2ybtES4hUdar9LsVcqidsJEzXaFpeF5lIM
	R4rbCASNUMVXKXM6GBfo4PiBNVyyIqZ7CQPxMOoEK6my4lY5mOpPYjGNIaMw3g2s2qN3l6KeLhK
	8/SM0mIdPr/vCy0kp3+hPwUSxKTdsO37stvCXO/TOFt/laNyKrDa90e7j4vQIBNg55fZDD6/BdQ
	LIPkCdgyYc1g==
X-Received: by 2002:a05:600c:6989:b0:494:ca0e:5da0 with SMTP id 5b1f17b1804b1-494ca0e5dfamr3772485e9.15.1783942953461;
        Mon, 13 Jul 2026 04:42:33 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm551259615e9.10.2026.07.13.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:42:32 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:42:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: factor out memcg kmem uncharge sequence
Message-ID: <20260713114231.GK276793@cmpxchg.org>
References: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17712-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93C4774A780

On Mon, Jul 13, 2026 at 05:03:04PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> The kmem-uncharge sequence (mod_memcg_state(MEMCG_KMEM) +
> memcg1_account_kmem + conditional memcg_uncharge) is duplicated verbatim
> in obj_cgroup_release() and drain_obj_stock_slot(). Factor it into a
> small memcg_uncharge_kmem() helper. The reference get/put stays at the
> call sites, as they differ.
> 
> No functional change.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

