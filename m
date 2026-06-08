Return-Path: <cgroups+bounces-16731-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oZwEAw/EJmrnkAIAu9opvQ
	(envelope-from <cgroups+bounces-16731-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:30:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE785656A8B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=axjHM9oG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16731-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16731-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68C64300F7A1
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001937268F;
	Mon,  8 Jun 2026 13:29:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397D37BE86
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 13:29:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925354; cv=none; b=pZPVn3A5z8Hz7fK1+sdQ+64U184Xnqjq8rcyioUARBz9jjHwMvftnIuI7z/6iE1Xq5IH/UybnUgGnQRKPW+5MD5ggBV//jVA2U1yKui/jWCgAtgs4913ht2F52aFQE3lFYB9U0kvHe3n0t2TDctgo5v0pkq7W9v1PeY0rxGmukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925354; c=relaxed/simple;
	bh=nmN8PzhMKNJXXYdxjVLFwSj0y0NfPJfo3m4hpeqI/Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxEsaZbBDFyb3S6KC0NTn8cN3+HbU4RdcbeeSkmiuN9U6Mup1TRF+fC5Um8uu0x3b1Cl6mOt1qX5sgcrzxao9dtPVAUyP5oNRs+LvR4eEZG7cF8wCTEM1rrzUTYXmHqKJMQRYiu8G/iap2BYWxL8L8rdqsyiEt9z8oDjJ7KAi6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axjHM9oG; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490afc47455so21594255e9.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780925348; x=1781530148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIOQhdcIWAF1YfBlwwhBIJIz3OtmjYbgnjZxpRy9+yY=;
        b=axjHM9oGoWaisME4HXDXmFP3gHP/3d4tjQ8gBxUhfzkrlUPgP69CF5g+8Kl8w7Twz8
         TpXg+aosocwthH4zXZ0G770W2ZdYy7oM6nKXEinLxTZ+m3jiQw9oayipJnVj5hGRGjSO
         uIDdeYsJjP/sXA3sXezg2iCsWhGDlBPy7MK5C0puzi3Qs6QfWIkYkq6ZrzvUxsf+t07W
         aYVC3CntRYDPwYUsZx+TNKu8XLwEFgZNzpufYKRGlVuVB+CZapQ44rk7BEbxiSeMJZv/
         PieX1abKzJUllJy1o1zjFiDbdEsv/1oZpTtrj2Wi2W1p+nlTrSBfMnboFmgaeFgaQzOc
         Lunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925348; x=1781530148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIOQhdcIWAF1YfBlwwhBIJIz3OtmjYbgnjZxpRy9+yY=;
        b=Kt+/eil3N2klltzCAZfr4rwkF0axK+1+p+334wzGGaWgQkGcc7F17xBn6cXKFszszV
         vSmymW37iSmfZhSeNnz1pAfzrYyYv1Hwq5LQNN4G/tA44fp3P7muj59YE5y4fxPRdw+y
         3VlksVFX6dGZjzN78nNADbvY7yVqT8LqW6VJaPBVEouz7AYQ8yvu5xp1T6jIdZkcuT7u
         HvfzHlpNIMgBnYA9WArfRR3yZIHoGLhIl2PFQecgBdCCXMafqYnlA7OL2OnrwGMwdAZF
         aa7oELmL1N7bXfgWjhdo2uW20NFyD3qhjT1qX3Gm8QhaNKzVZgPyeOEJCPJD/pJGw/8w
         nZfA==
X-Forwarded-Encrypted: i=1; AFNElJ9036hKJehaEe2KbFnL8AM5IUmzIR8C/xmXDVpap6tFxRairNAY40FlCxLiARf2uavedV6dLgYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zOnV3GixAvSqKWuYiSRoDDSnQCYXfAqdAA8+OH3xbbG31ZqZ
	houf5WEZLwmRL2vu/Q1Ph67a+I1K2QMR2FeHbloKde91uPDTosjrT0sYEdPA8DwiWKU=
X-Gm-Gg: Acq92OHemHZvD8cQ8FdWTl+BNzVvSHVROWiPZDnK4pRZkSS0N3zSUMwF22rV9ZlfLrz
	QsiA1JXQt2Xyr/J/uM/AC5nvev9PHD4RW+gAokuXCEgj2mHiPH759Mgx1HgdXQbyOGT/pKxz1uB
	nq9n49Bo3ZuM2SDar7SIFsgEV6dEIlZciatQGGSTPeFKN4LHkBA8LgfyuAf40Y0C7yKhybA26qM
	QqcQEVTsZ9rutWRgzQ8SLyIUN51VbnQnZSvZu88qEc+mo7usy4F/K63NJ3AkRJpOLUp4zNC/Bc0
	hMCys3Zogt3D1Gtlh4U5gWkHVEt4au8LTrqXN/B1hXjdTR3UorUCaVrpUcT0R4x1BbBEgYdqYBB
	rDSuPvaO2FN5USnVH2hGHug/0uXsB0BA2rkYftV09lAFdvv+3oblEHs3aMF7I6/e3zrs+JC+/EA
	mPqagnwgkLNAm8tsvOYamQMJZ8owJuQKbVp10WZxxY0ZuOI+A=
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490c26056a4mr274307955e9.21.1780925348589;
        Mon, 08 Jun 2026 06:29:08 -0700 (PDT)
Received: from localhost (109-81-90-161.rct.o2.cz. [109.81.90.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm337684075e9.1.2026.06.08.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:29:08 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:29:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol-v1: use nofail allocations for soft limit
 trees
Message-ID: <aibDo_pYN8FaGSgU@tiehlicka>
References: <20260608063644.39-1-ruoyuw560@gmail.com>
 <aiZ3EZZV6LqsTxQM@tiehlicka>
 <CAK_7xqyyDqNW1+puMSp2LzxmOKxFUx-UO9uGiDKoL7ZTJ8+3ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK_7xqyyDqNW1+puMSp2LzxmOKxFUx-UO9uGiDKoL7ZTJ8+3ZQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16731-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,tiehlicka:mid,suse.com:dkim,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE785656A8B

On Mon 08-06-26 16:34:48, Ruoyu Wang wrote:
> No, I have not observed this allocation failing in practice.
> 
> This was found by static analysis and then checked by reading the code:
> memcg1_init() dereferences rtpn unconditionally after kzalloc_node(). I
> treated the soft-limit tree as mandatory memcg v1 init state and used
> __GFP_NOFAIL because continuing without it would not be useful.

This should have been part of the changelog because it provides an
insight into how have you reached your conclusion.

> I agree this is early boot init code, and I do not have a
> runtime failure report or fault-injection reproduction for it. If such
> allocations are considered not worth handling in this path, feel
> free to drop the patch.

Yes, there is simply no point in handling these failures because early
allocation failure like this one would very likely lead to massive
failure before userspace is brought up anyway so there is no practical
way to trigger the NULL ptr.

-- 
Michal Hocko
SUSE Labs

