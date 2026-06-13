Return-Path: <cgroups+bounces-16915-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jTgwGE/HLGodWQQAu9opvQ
	(envelope-from <cgroups+bounces-16915-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 13 Jun 2026 04:58:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F467D920
	for <lists+cgroups@lfdr.de>; Sat, 13 Jun 2026 04:58:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ekpD2eY1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16915-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16915-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65C663018882
	for <lists+cgroups@lfdr.de>; Sat, 13 Jun 2026 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8F37F8C3;
	Sat, 13 Jun 2026 02:58:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2E1A4F2F
	for <cgroups@vger.kernel.org>; Sat, 13 Jun 2026 02:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319497; cv=none; b=PXcJEeeD6fAW8rzvZdh8TnCkzI/a5nJz1OzQC8pXrSTmkxcDio7R2WyZnIL1SwdoJdajyyu85l1GWeuMnOI7Qa7oCJLOq8aIQuanFsBFKQ8xAEpiVDkO6NlLBH+tWQc57RqkO6DRt3NzMwfSyjg+eqQs+ttCUrYvePi+dI9/kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319497; c=relaxed/simple;
	bh=NDuftcaCA5+d1ffjZN7R4jPvjJeb/33ZTBBnPHQ5OM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq08kZRAsVoftVHVaitttfhggXnFyuwZyeY7yCGXBT8J4ZzpQyJuueqmHCkW6LMHUzR99wBAZoLKJ13DYf7ibIZlbkFRkCjn2tN1FWjEuCKdWrAae9gZSBBGmt9tkVbUCHpd696KQhKAKIXt7Uhnq1MOe7RA/s4QtYoMgAA7Ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekpD2eY1; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6930f7e83b1so3322204a12.0
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781319494; x=1781924294; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAwjbx7OhsFF8Ofl6FEk1ESuaIwcoPlh2QD/QcmNLDg=;
        b=ekpD2eY1zp1W2y0grAhShzDSd2WuYnHqY0xQOQKToA+rM5zjUj9NV/7M2IUHX8wmRB
         JxUeEK3+R0v59t5TYpJSqW0mq5o4rFxFrRGqsXqCtdGx3HdhOIxIFaSiDLBx0+GXnL2q
         9lntrxbSU3wqBdEOVNb9e/GYlGRtY2Q+veN49axivLSXbMzoian+aYZq4sIXImfM6MPj
         D5sS6Bpi9nxR72pNnig9vZMg1hvnfKqR3hu0DfInWb5Kr5cbCr1P5fxlj3xB8VGL8x92
         RlH1GV6GGjXihYDX3L2B3qQUgIqhU2NhMbFtopVptPKDV01sEgMC1Etl953erlNQbMKN
         PM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781319494; x=1781924294;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAwjbx7OhsFF8Ofl6FEk1ESuaIwcoPlh2QD/QcmNLDg=;
        b=q1CpW99dqVSFSbxud/Z+BUUjgcH3HvqL8GeeBX0qpV8OUWku1YpD3Dd2XxU4kx3/cX
         8zUskSvNCcsi/B/TVC8qjppTyJZyc2Ern7M46aWHYU5sQveJVZZtTQFDLpcFZzC9Cq9E
         lKg5Vj/xyKEKhLhwBLyokwhtS2K4ej8/5GFjVy43ecQ4p68T1uGDdgGve/gNKmbOZkeF
         rLLIJ/vxn9bH9OUkHDhy6Y/fuoYfFkXfBSj7ADHb1O3ooWRdvrRblTgiF3Kqd4y+1OZm
         sGfYQ4s8x+ZYev5/1IxKRBoS7cjgHqZmaNLWjSFPExCjnLJDNI7nZ/r7RUIYR/J40WBy
         oTHA==
X-Forwarded-Encrypted: i=1; AFNElJ8SKCnIN8eTstWFbu4DpSGizXorGT7YSAXwz0goh/U7gNuAzrdtwdNd5gl4BbMk1fiDVeBX1SqB@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKVT0Knot7zsGglHB9K/d6I4klzhnXGYCTOVTOC/CtmpoMWFi
	7WY1SEa2sDCeEAks9dJoJHN/jyAxZtV2xEFmP/ri5+qdPn03WXFpvm26
X-Gm-Gg: Acq92OHvBbpbtsdEDCt2oP5udX+pajdSa31WeCRWdx8b41Tdf9wACl0gUxb3rhS4JpE
	zBDHT5sU7Hi2HWAsqcQ/vs1BJ8XTtqPN9MM74QCoyXuO80On0zRX0I+PA1sLZHRkPveRUm1Jatw
	qAvdkO1RoxvJrviU7u8DtbOh8aEq2Ik2LRhhFyS1c9wySYL+0osOgekos4DwPdFAAmtZR+nCV9N
	aOjzfSWUnGhmKQOWiLf1gmLbTSKFMnvE2G3ZkZugqx1GkGvnf0oiN79LaFjSgiQWgFD2uPo7ma9
	kA8hblCskjHn2rgapYTD9uqwceKwclt9xnixz0Mh+Ajzgkft4W8K4hpvivmuHe42SwwoNrPZPwq
	hrgopGjCtYOnCSbJKSJHpjFIXHvPjKnvxGWJgIzH60hlvxJk5DQtdRWjKAVjM79u6zDh7hcapsk
	LaoLoJrjUHHB7dmVaoMGLb9w==
X-Received: by 2002:a17:907:7f94:b0:beb:d461:7b09 with SMTP id a640c23a62f3a-bfe29927242mr210429066b.11.1781319494163;
        Fri, 12 Jun 2026 19:58:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44208f8sm179835166b.10.2026.06.12.19.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2026 19:58:12 -0700 (PDT)
Date: Sat, 13 Jun 2026 02:58:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	shakeel.butt@linux.dev, mhocko@kernel.org, david@fromorbit.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, qi.zheng@linux.dev,
	yosry.ahmed@linux.dev, ziy@nvidia.com, liam@infradead.org,
	usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org,
	ryncsn@gmail.com, zaslonko@linux.ibm.com, gor@linux.ibm.com,
	wangkefeng.wang@huawei.com, baolin.wang@linux.alibaba.com,
	baohua@kernel.org, dev.jain@arm.com, npache@redhat.com,
	ryan.roberts@arm.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when
 queues drain
Message-ID: <20260613025811.z6xfm2xg7r6bgdea@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260602043453.67597-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602043453.67597-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16915-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:wangkefeng.wang@huawei.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,master:mid,linux.dev:email,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F09F467D920

On Tue, Jun 02, 2026 at 12:34:53PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>deferred_split_count() returns the raw list_lru count. When the per-memcg,
>per-node list is empty, that count is 0.
>
>That skips scanning, but it does not tell memcg reclaim that the shrinker
>is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
>count callback reports SHRINK_EMPTY.
>
>Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
>cleared once the queue has drained.
>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>---
> mm/huge_memory.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 72f6caf0fec6..62d598290c3b 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
> static unsigned long deferred_split_count(struct shrinker *shrink,
> 		struct shrink_control *sc)
> {
>-	return list_lru_shrink_count(&deferred_split_lru, sc);
>+	unsigned long count;
>+
>+	count = list_lru_shrink_count(&deferred_split_lru, sc);
>+	return count ?: SHRINK_EMPTY;
> }

Looks you are right, thanks.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

> 
> static bool thp_underused(struct folio *folio)
>-- 
>2.49.0
>

-- 
Wei Yang
Help you, Help me

