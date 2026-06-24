Return-Path: <cgroups+bounces-17262-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0PwyKHNIPGqNmAgAu9opvQ
	(envelope-from <cgroups+bounces-17262-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:13:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6586C1613
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hpzzEt9e;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17262-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17262-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2D8630078B3
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06713E1230;
	Wed, 24 Jun 2026 21:13:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13E332601;
	Wed, 24 Jun 2026 21:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335599; cv=none; b=erzDG/etjQot6PSTlk67JUFt5boTF+3I+SFDrFEpYMiwl2TUYT0XLcoM6mBx8faXgbTKcm4cGzv9K4t6LVINT7FYvjeQ9tws2ukUGqHq5HI0iJ7oN6rNgCtqAU6n2DyXLtElcyjRvaSgkZ/s/ajq+nEdYEXjG788X1LZA5xvsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335599; c=relaxed/simple;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ecdZfdjgg/sDtS/ICxJkam3pubTMUtmTGy0tYfTGIMnmJjDK16MzUZ+PHz7MuXI2KZhtlMcj2wRkHN7GAzo9TkwLbVLDUnOet7/9sZMG/GKzDw+kYldq9w2Fq2YF9/gDtDrxF1nYhETie8h/qBAJmn+IyhiUccDs9zTJ1tmuO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpzzEt9e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB07D1F000E9;
	Wed, 24 Jun 2026 21:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782335598;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hpzzEt9edeDrlb7Mk8cyLl1l6MhjfKjiybrLe2+TuN0uxIv+OYYcMxIJQjtup8H3P
	 Wet5axQ42CRxu9hhnOKO7qzp1PFxxH78i110/dhpdUHjtO/a5UfKzhLHQfuS5W6duT
	 caYCoAh7gbUCaZrUKS0i0MGBfcY2aMPK/B53jjeimk5Ksq7ussfSa9Cny3cETdtsEz
	 HTVuEkuEaYg4OPBbtCqbmPWNCHDyrU4A2rGYDUn1ji/BGBB6d4Zsamtt9p4Wq/+JWd
	 ZemW5f1dUd5RWGcDIFlzyI28aPsb2+HLC/CV5p0MkU/p1vKKbcgYPZ1sv1olGEPvTl
	 n1udYq6ux4vGA==
Date: Wed, 24 Jun 2026 11:13:17 -1000
Message-ID: <b9eb3068c2d01bca8b19927351395ba9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix a typo of the function name in comment
In-Reply-To: <20260622110708.15593-1-zenghui.yu@linux.dev>
References: <20260622110708.15593-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17262-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zenghui.yu@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E6586C1613

Hello,

Applied to cgroup/for-7.3.

Thanks.

--
tejun

