Return-Path: <cgroups+bounces-16948-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dGjPHb7fL2o9IQUAu9opvQ
	(envelope-from <cgroups+bounces-16948-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:19:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76399685ACA
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:19:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b="hD7/V+Rt";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16948-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16948-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 649D53004C8F
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118F3E44E1;
	Mon, 15 Jun 2026 11:19:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA533262A
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 11:19:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522360; cv=none; b=svS0ZKLKhCFyhJdsZLCQX7xpRFK9t80Hw2JeFwiclXZexJZSn4V2e0iG1LSI1kjbqCpYI9qFFCOshiH8SVCOAv0U5dj4oDqW7xJqV/eWZpy7spsKKdjtITAOX2EHiIFeeh0wsooVIX97pdvjINDbyxqmdrpJi2VWCduXfuv0bbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522360; c=relaxed/simple;
	bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiOyyA2l/VkDgmReZ9DiaZigkDT+ncXLyzmHBdgOMb0iwrl/ewbkONIUJ2RZwcUi4pacFasr6oUAJhBBvQ7Ef/U08DTQcESn2DdflTjFobgKlzqXIgkvftR0j1YXoem5dc31xPftb5hgEEYi9PCCxV4BzdnCGlfOGjW6Lu9oIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hD7/V+Rt; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9158fbaa4bbso373407585a.1
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781522358; x=1782127158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
        b=hD7/V+RtxaxFnAPfyeNeJeH4NKZBr05DQdNW5+wMsaC1zZoMojCl0QN0GXK1RrKFoW
         dmOJZ6qy76bTnJQoxgfQpbkuckSWCmKZkDHj33yyLEqF8aNkNZexsJ5+4yszJoAyVV3Y
         EjxBPeHB/nWLI0/25+cLOu/Hk5AyC1sblttE62un4ule1Ul6dBrYuGo9WQuI551DU9zX
         QOEM3SPihDp/+W0q9kgY7AxZg8x1XtI/1Vfn2REH6wv9ZeWhaO5Mto17RnnKWcLnxqUJ
         bwnhaaGykI89y9evxm6Qn42/r3qjGLYW8lLmUC0ycFSJ/eg8uwvM1wEdLOekog31FFMf
         LIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781522358; x=1782127158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
        b=W+X/V+3JXV27uxdlSeY58JroJjV8sVM8O5JmiUJ/kx6YokUKqWbC/1wTORkIQsMiNr
         LEVh1tiBFhmYAq85H0VT4L5patlhIWwGSh1bDfNtjf46KRkuCeRPi9xgP6DYVbeB0b08
         a6bDtu79VBKMwfUhnsCRBDwBRwftV5OuuTvbM29xEx2q8wfkxS2KIJZer9XgiMtpDo53
         j4K1ssaSO2+6lECJurxoe1oLgagK6sb1LBDqZ7mtQCyDDZAc9uR5VioeoZRS6n3xm8hm
         RAWXd9HbwxBAFoZJ9gNsYOaXK8vBqbDYQz7MmpFaoViWLtKqev7GYcXk3XQqyLWk+ffP
         eNdg==
X-Forwarded-Encrypted: i=1; AFNElJ+60zJlyt4tmRSQJjSai52hPd2TqG67nk1IVVrTaKx5VQb4KleUYSB/18OIp1TOmicD+HYN+n39@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzZqXx4V0w6VwRpT5L+JcBuOVsycsSjg1KI+kSBI7CNw38g2i
	hK2u7DQnc0paC4bNZVirG6s898tnD6Al64Xja5RIlEmKHfr3OvJRtMIIqylEQzddRwo=
X-Gm-Gg: Acq92OF/CdfEa62RkVQKnSzRRQItglI7ABt0EaN0Udacn9myG7qw3wpN+GrQb/wOSfs
	07Dva5GgsLqoRys6cnjMjKuPkUlja9sM5jtByJYJftTppSQEhu9t3fOPCS/Tv7+JYQdlSU0r81Q
	O5pPpL95kcYOi4iJ+vUd+B32ljppNy0TF14a+Wzhbj6xKInSHexKUVEI9ShgiiQBPumvVycHaxz
	6iO6diGQu1yolCqaa7aV1ANHHw1lKI7IruKFA/VGo8Yta/Of225Zcfi59YJqlr7f4C3iue5G/SN
	DOxF9YsekXRDC/dBihyBjToNZ0kCfJFDR08TsaLw6wBN7DuJaKasR53dtZCGdy3sM/BFIpwP+N2
	CU3Tjy3m5DCt8ySeFyn5w/XW4C/eUvDYiuR8PzFuSredITyx6SKTwX4yX6AgUeAVrAYDjE1jv1E
	baxq/FU38hTXdxLDFB84KN58btrg8NlXDpHUSfuVsu1RtOuYl/5GJ1zef/sBhIJOkrnXbgVsMoq
	YjA
X-Received: by 2002:a05:620a:448c:b0:915:db15:4e36 with SMTP id af79cd13be357-9161bd156bcmr2061939485a.42.1781522358133;
        Mon, 15 Jun 2026 04:19:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm1071791285a.1.2026.06.15.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:19:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:19:13 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Farhad Alemi <falemi@asu.edu>,
	Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ai_fsVg51_GTtzT1@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <ec4b4b70-dc01-41fc-ad58-e1c877f6a7eb@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4b4b70-dc01-41fc-ad58-e1c877f6a7eb@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16948-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:longman@redhat.com,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[berkeley.edu,linux-foundation.org,redhat.com,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gourry.net:dkim,gourry.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76399685ACA

On Mon, Jun 15, 2026 at 01:08:16PM +0200, David Hildenbrand (Arm) wrote:
> With newmems it's clear that it is guaranteed to not be empty.

I hadn't noticed he switched the patch from newmems -> effective_mems.

This needs to be changed back to newmems, otherwise we're depending on
a derivative value set somewhere else in the code being correct instead
of using what we *know* is correct *at the moment we need to use it*.

So yes, go back to using newmems.

~Gregory

