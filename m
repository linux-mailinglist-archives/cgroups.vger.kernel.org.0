Return-Path: <cgroups+bounces-14939-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BxRGCoxvWmI7QIAu9opvQ
	(envelope-from <cgroups+bounces-14939-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 12:36:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8182D9AE1
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 12:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12A25302D696
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17A3AA1B3;
	Fri, 20 Mar 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzHRPiw9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qZd2R/Qp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5E3A7846
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006498; cv=none; b=RAM9xlHhPw3+z+JGYI6++rOeBmejf8jKIYVw1J82cThz/KhpNrItu3Ja3n/MnO/Ylekp2v3G2qOZgcSlkQ51Hm3oAOwXJCtu/PMp5UcyqH/U9w0cityPq31Lgezztcbywi9iZu9TO2pT25hHWEqNS+i0mJo2rQop6aWwQ1xEOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006498; c=relaxed/simple;
	bh=XNytlImA8FiqJPbGYO8Rr1KbGrdsMdMRsDBUv/IiWw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERAr0nk70rzCLg+btjQ9IBT3vg/hS9X1TZ29xzEZUh98YxOBHH9UVn7ulNx9zMRDyUrPjIjtY4LSmuoeb0ecGxAik5GdCOGNT0Hsgw+xZEvLMd1UCcBJKY9K/qq1ivFqYOBlqecqvHEw9TrYzPMovK8wotM0/EY0Fhzab/dUVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzHRPiw9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qZd2R/Qp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774006495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XAFuMj8200/2Yl3T2tu1n7OQ463xMtcQ3l4BrZLY4E=;
	b=WzHRPiw9aYpmnAygR9i+tNakZH4HZcnrDMITW4IqSbdeceWbefpgnIasgG4tTBQ2H2j3Oy
	nWnIL/INI5Mqhiv9RpWBvTUSONdnBgOX00pjBUUTj6qZh5V1w5WcqY4WAJoQGORiXS9llY
	mvjOKTr4uRqgbXcOyic1hX6PpZW0ZRU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-JBKPxk_4Pbi2gzTy5HrB6A-1; Fri, 20 Mar 2026 07:34:52 -0400
X-MC-Unique: JBKPxk_4Pbi2gzTy5HrB6A-1
X-Mimecast-MFC-AGG-ID: JBKPxk_4Pbi2gzTy5HrB6A_1774006491
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aec8d85199so25134095ad.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774006491; x=1774611291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XAFuMj8200/2Yl3T2tu1n7OQ463xMtcQ3l4BrZLY4E=;
        b=qZd2R/QppXgvzsjeSwXMnFCJKiDMXqVHWZUuU0kzaP8uo44u4XSU5lJIU6o8nLQuVS
         li84ftjS3fLEfQTHqXATa3xjLbfJnL2NpCbBMyx2EbUtvAOo2mnqNii56sKilAzdlxjr
         4mcrM6OQvLm6AWXcsGLbaDL91itBNTik6yYA3sg5FQeWpVfB00fncAqPLLGFZK06RO1n
         BfNgObTLAM/AZQ7/tO9qKCruwdu6RF+0413qUmML6NAc8zmDBH3U8Gf1XMKlQBSdYjd1
         XW4jqq+IeVyoGXpdTMecWPkmWLDAaOqUDF+1pEeJlT1r0obX3cRoSBnfZEuPHdHpTVyY
         sl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006491; x=1774611291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XAFuMj8200/2Yl3T2tu1n7OQ463xMtcQ3l4BrZLY4E=;
        b=IfNYSuNcqksMgiI3n69NnXgZ1sievHKYjpw9Ax0B6WDp+CDxm0ziYX5kdO3gho+uVL
         dE5lgk8g6wAOq7rCxO4befdLsg2c47pSxyfTdcj9xhPATnmjhRxS5z9fwUK/u6g0T7Zt
         1685eVx4xXvSi3KXlpBSdfrxRzPiTNMHOOvpaLGhOfycwcCXU+p4C7WLQaDEbOBKmDLe
         fsdnTCLkrk2/0p3W8jFX0fv+ESxXlppuvaoiNhpdMTlxH/38Tu3JTXAEsq9BDlbsui83
         TqBEzP7uyuLH5EyQr0cJOwtMIS7pQdmcbc9sneFPG6ystimus8HpKHm1n1/hNNswxHRc
         rqwA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvVz7rWJz6515kUV/JAeIFleEyGxukD/Sdn5/zmWJPYjMgbh0Fv02hfcZw4yFnm2rRMXKnI0l@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyv6hvZ7heEQYRtlsrjwUMJbhiGTg/UkYD3sRZsm0OqpGHhm4
	7lWTV32+qTYg/p+uryz+TkROTLIQhbxCYoseYP8X8xYm16ybYqKIar7XL7kTss21oiT9RaHRopj
	59m9UdxRxZkoMv1s/Fel/GpVI0vYcmJ2t3IeqtI6Za01yMvRwhSH6BCP/5FY=
X-Gm-Gg: ATEYQzwjtrkQj8w646GQptOzI1lkoMheAjYTDqC50YQGTsPlfOKwQQ65PVDezr0FVKB
	nCkypnaxVVIgBsjCMfAG2jKmwceOiPFcjdAdNNEmUfPg7blzhGpa80IE1Nst4fODAhPmfnW6epc
	xUJ+2YZfBakGOpzRVPKs8vKVlQfC6wKlOaNNfvbNPEWwPeVmcffI3V1wkcTvQXFe1lIhd0NQIku
	2FDy3f5TM+bxGxLVTm6APZBwvM0boIiBCdCTVtOAuF5JgWsKhQiU7U2FsoX7afNYNFz1wSkLf85
	zJXR8Pmvk68J3VwLzNOY75s7WgMhtsQHA38tCqcbuYitxttO7zyr/ZVeuk9VFr2sV73Xqwg0rI+
	0/SNLey432ctTLKhE1A==
X-Received: by 2002:a17:902:c40f:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2b0827564dfmr22400265ad.9.1774006491329;
        Fri, 20 Mar 2026 04:34:51 -0700 (PDT)
X-Received: by 2002:a17:902:c40f:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2b0827564dfmr22400125ad.9.1774006490957;
        Fri, 20 Mar 2026 04:34:50 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3066sm19628795ad.75.2026.03.20.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:34:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 19:34:48 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH 3/7] selftests: memcg: Iterate pages based on the actual
 page size
Message-ID: <ab0w2PCcYBEKxm2B@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319173752.1472864-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319173752.1472864-4-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14939-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6C8182D9AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 01:37:48PM -0400, Waiman Long wrote:
> The current test_memcontrol test fault in memory by write a value
> to the start of a page based on the default value of 4k page size.
> Micro-optimize it by using the actual system page size to do the
> iteration.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


