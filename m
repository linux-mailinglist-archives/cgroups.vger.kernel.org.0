Return-Path: <cgroups+bounces-17622-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3xIFMClT2qulgIAu9opvQ
	(envelope-from <cgroups+bounces-17622-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 15:44:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8A5731B68
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 15:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CwGpaaI9;
	dkim=pass header.d=redhat.com header.s=google header.b=TpKdJo+M;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17622-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17622-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC01B3098125
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDA27B34E;
	Thu,  9 Jul 2026 13:31:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AD1632E7
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 13:31:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603891; cv=none; b=sBQXkV8xDBqYWDVU9OfSaTC9nLHLfVFBd0n/x/6BOj6ak+OUZxI6qiQ09E+rAzI7LVfHFLTsMuaMVjXKx24aw3Xk35bTiNU5VfnZz91VLHdEDegy7B1yfFQMYaTDTVZ+MABOfFTPhPnJnr7powEueWnkM5XMDl1Kt65ZdkXoOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603891; c=relaxed/simple;
	bh=Ut8bhtlffnJ9/ELCph4aBFL8HoBapcjMEL1zurQQoj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSBeieifbMirWCNr5jxLXLmYQRJtdwuOGYCQaE9WiGQknVbjVuV7FBZVDi0yvMD4t/phX5GMPy7ZoZ6RmQNejLAm+jpWkHVSXwFkoaSfz5ly+48f0yNSXFcxPmv6Bb6RKcZutBMmnS4hyp3EeSS2flgfJADPs8kKRWAssKCuQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwGpaaI9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpKdJo+M; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783603889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzK7Wx/CjJVGVlD6RLMcxNO3zdlDorGZi/W+knFvfoc=;
	b=CwGpaaI9bq7tUhYLco/8JA26C0Oo2Imo9ckpibmrtQZhmEAq7tZKJBoXRFRvhp63LPRjHw
	HZNPy937BtbJ0aQL8TJoXjpy5SV0CqfZ4Ay6jiVgJiI/VJ+uT4frMaL2ZioCodmqMJzezj
	tpWQE3L3jz5h/5D4JWVbi2KkI5mbd9Q=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-7cNUpyg9PF611qbmHRcfAA-1; Thu, 09 Jul 2026 09:31:27 -0400
X-MC-Unique: 7cNUpyg9PF611qbmHRcfAA-1
X-Mimecast-MFC-AGG-ID: 7cNUpyg9PF611qbmHRcfAA_1783603887
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9692aed16feso1504330241.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783603887; x=1784208687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kzK7Wx/CjJVGVlD6RLMcxNO3zdlDorGZi/W+knFvfoc=;
        b=TpKdJo+Mww8TckRkloqDYI0lVVO6rZGh5+gjJbBvLYnZpTc7D+5r6mUeTsNouOMJ3j
         rVOiM3k3cpvMMIMo3VzTjQX1mRJ36YGHDBmsPypI7pesrafqhdlVJ6/ukwgL6APk5hKY
         frQqXkfuj9ate41NrMElUAv3kuAoDDnK0IEfTzS/5m0EpZYn8JIacsCG72ADYaDePgPw
         2sndtj0E6XpiGU0nFxFrP4GqKL9lg9JV8RcRRZw0r2bhmpN4VnkIPsJfxxJN5P9d40Qj
         gsmaopQ3uXLgiv20eu8vwSbdTCyybDw0FK8sZ2d88RnSQ6Mf1IaZiHgp00unTadh+BHx
         dr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603887; x=1784208687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kzK7Wx/CjJVGVlD6RLMcxNO3zdlDorGZi/W+knFvfoc=;
        b=NEJD2Fen3kpo5Yx8dYcibPhv6+2tJD+uu+qn5M/YvaYNgTjt4lY8pvx9ordlc6ksUR
         mAblT5/EbjyXy/N1tG+MHZYY049equDE5i76FNXiotBmx/0EdkSyXTOM0TmyXJI4O67b
         U2A4Vk+Rl6ckxdvXxiSVgn0/TiCrmnKqd+H55bmt3V4Kh0i4yIh/zjmG4raHPag/KhbR
         XRGlqxg1GNWSaCXPXMGXEFvxZQbPYbSrgAaZLOOepDi4fy2Z6BTTnuE7Fe7keJp82cH4
         1tVl8132AcsKhNXTkix2g+8WYj14bOpPUmsAZdQHiAedcvy9/AW49W7Jt4oU9sQnAsf4
         VBag==
X-Forwarded-Encrypted: i=1; AHgh+RoHlh65uhCZj9msiNKtDvJDAZ2XT9fj21PnR32i6oxYLXZttkr67gV1civPtA7WL6QIoqiDm4pq@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuc2+JoD5ffiJhZVoQsdPNjHty80qlJj0dRuDYxSvw2NUa6Q8
	DIMhGDgaGDOelwuQQeTcQhkQfWoPbs6542Yh04xgirpKxP0nD7Kqpa/2JSOhUqkkzyDKybRfu2K
	L98ddAYeY+4Rxlw33KZpHX37lhqBieJqJReNv1Xfur7Ucwep/cBP/cb84oUc=
X-Gm-Gg: AfdE7cmQIc8elFn2tNh7JzMBNqe/Zol+qW3WHosQ4emc3Z76Z0hs63HRS8AeiafL+Tn
	WEX7q0fOEicOdvcBc9astee0sF774MS68xrsKQ/RFYMMukg/kS6gLmTiC8Vc1S/jIY0Pm+FIIsS
	4BYJ8K8c9SX0La6NFAwnty69MdROBAe/LEBXKLvvhyClJGeqWWcET4WUkNu7rpQ3IhluI/qOEJm
	E0CBxRWmzaCwUNfGSh/RPSgPU9xjRDj5hRFgP0wrLH+aysfvsYdeRy8/v+Gip7+MSu62yNFflgV
	hXB/1D5GukRO1CUrdToX9v5xOp8ZT1gjG+1f+bBq74lARG9v5PBtBDFURP2Ym+s519hhi8MByf4
	ZrF6o+hnGH0pdLRH+Y8OEg6211ey09mCFzjbo2fwmkrnDooIP2i9JAW0=
X-Received: by 2002:a05:6102:688b:b0:631:ff40:22b5 with SMTP id ada2fe7eead31-744e0333f94mr4210919137.21.1783603886760;
        Thu, 09 Jul 2026 06:31:26 -0700 (PDT)
X-Received: by 2002:a05:6102:688b:b0:631:ff40:22b5 with SMTP id ada2fe7eead31-744e0333f94mr4210626137.21.1783603884528;
        Thu, 09 Jul 2026 06:31:24 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net. [100.17.17.231])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a3eb8esm3409363137.3.2026.07.09.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:31:23 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:31:22 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/4] selftests: cgroup: Add dmem selftest coverage
Message-ID: <ak-eNHFodrNxMP0w@x1nano>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
 <20260706-kunit_cgroups-v5-2-6c42c8753468@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-kunit_cgroups-v5-2-6c42c8753468@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17622-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aesteve@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,x1nano:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA8A5731B68

On Mon, Jul 06, 2026 at 02:06:41PM +0200, Albert Esteve wrote:
> Currently, tools/testing/selftests/cgroup/ does not include
> a dmem-specific test binary. This leaves dmem charge and
> limit behavior largely unvalidated in kselftest coverage.
> 
> Add test_dmem and wire it into the cgroup selftests Makefile.
> The new test exercises dmem controller behavior through the
> dmem_selftest debugfs interface for the dmem_selftest region.
> 
> The test adds three complementary checks:
> - test_dmem_max creates a nested hierarchy with per-leaf
>   dmem.max values and verifies that over-limit charges
>   fail while in-limit charges succeed in dmem.current.
> - test_dmem_min and test_dmem_low verify that charging
>   from a cgroup with the corresponding protection knob
>   set updates dmem.current as expected.
> - test_dmem_charge_byte_granularity validates accounting
>   bounds for non-page-aligned charge sizes and
>   uncharge-to-zero behavior.
> 
> This provides deterministic userspace coverage for dmem
> accounting and hard-limit enforcement using a test helper
> module, without requiring subsystem-specific production
> drivers.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Reviewed-by: Eric Chanudet <echanude@redhat.com>

-- 
Eric Chanudet


