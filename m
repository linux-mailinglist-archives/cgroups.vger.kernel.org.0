Return-Path: <cgroups+bounces-17545-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2s2FqAnTGodhAEAu9opvQ
	(envelope-from <cgroups+bounces-17545-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 00:09:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0D715E5D
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 00:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dd13GMsj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17545-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17545-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AB2301DBAB
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304C3F54AE;
	Mon,  6 Jul 2026 22:09:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6411BC08F;
	Mon,  6 Jul 2026 22:09:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375772; cv=none; b=DispSUbbQNFw5PRLg2sa6n/B+j/UcQOfMk5y7DSfzg1MQolysYZFi/SHLWfJ54chN+KmlM0+QTYqkYA1Eq8v6tKqGUdYwIpWUtykfKTyleEHuiRcDNwFKJ6n9YCWZ3GCWAkDkVJAI4M5/JfHTwpvCMmL5VO3LBo/ZZQVCCtXeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375772; c=relaxed/simple;
	bh=M6J8rmo74YDrXmogw0vI24lrkohvz1jMylSnzHCFxoE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Tr5hKiG1ydDcqI3EB/b+dlO44hJJbA6279UTt2/9uYMNLiRhytBptiay1phlK1TmtHq+Ba8mbPrWel9k9YCMQrI3zr4HEP6VIrjFxn48v6m56UacJJDu93sjb4pJM7eBTaMUg7zaIIAKAVP5UasXJpAnMLcSDZdy4AVXymwcpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd13GMsj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DE1F000E9;
	Mon,  6 Jul 2026 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783375771;
	bh=M6J8rmo74YDrXmogw0vI24lrkohvz1jMylSnzHCFxoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dd13GMsjz+V68AoYcFSkxKjX9vuQjKuPGTosAbHMWekrMvv5wa0NLPShtkKLLNmn8
	 GAoD8Qk0HrBF6122V2795T8BDX2P7CCCxsomh7/f9tKnyqr/N7iGrs7+oBnDQfLVs2
	 EMPy93w5CGSDBvIWxIRjzDDdPOXd80P6NlHAsIiaGfwvqoxyEddYSOAvNDlptktnyH
	 fMdQcGLtBUCsLuzeTL0XZ/XY5wGeG2MYheXIutoOfpYJzQ+qrXTpG7jKJwF6yj4tkw
	 DviJlqMuiNhqjww6jO6sBHHGhYGU4nwU97ZApTFuMJ0GXnYFwObHc34RlXURbaniMl
	 c4CesxPnQ3MQw==
Date: Mon, 06 Jul 2026 12:09:30 -1000
Message-ID: <1e27d727c3c35d11f6e19eca769478fc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Gregory Price <gourry@gourry.net>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alistair Popple <apopple@nvidia.com>, Byungchul Park <byungchul@sk.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Zi Yan <ziy@nvidia.com>, Ridong Chen <ridong.chen@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, "Michal Koutny" <mkoutny@suse.com>
Subject: Re: [PATCH v3] cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
In-Reply-To: <20260706082023.60832-1-david@kernel.org>
References: <20260706082023.60832-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17545-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:farhad.alemi@berkeley.edu,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:gourry@gourry.net,m:longman@redhat.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:joshua.hahnjy@gmail.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:linux@rasmusvillemoes.dk,m:ziy@nvidia.com,m:ridong.chen@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[berkeley.edu,vger.kernel.org,kvack.org,gourry.net,redhat.com,linux-foundation.org,nvidia.com,sk.com,linux.alibaba.com,gmail.com,intel.com,rasmusvillemoes.dk,linux.dev,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9E0D715E5D

Hello,

Applied to cgroup/for-7.2-fixes.

Thanks.

--
tejun

