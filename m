Return-Path: <cgroups+bounces-17808-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oe6+E6uzVmpzAQEAu9opvQ
	(envelope-from <cgroups+bounces-17808-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:09:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB7759257
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kgUvvaPk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17808-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17808-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A31E63010F73
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED941DE0B;
	Tue, 14 Jul 2026 22:09:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683432B108;
	Tue, 14 Jul 2026 22:09:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066978; cv=none; b=CFM+KO34MDttFpk2ogG6IbSXsNh8Tm+gZnVJr6jCMhaoWAsq91ckfdqUNQ6/QDTKZknZhg7n7HETklI25BwfTnHJaIuldD0VTM4W2aLfzrkUxeFnKslouG8dR9E9YrEAU6AyxwAOvL6bDGMnVq/Nc7UYJsaEkFuxgEddm0X82Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066978; c=relaxed/simple;
	bh=B5uyfCIszmwjjq5v8/VeVww0Aill3CuVw8R8oe2lbH4=;
	h=Date:Message-ID:To:Cc:From:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0FGGmpzq1uJPnwUoNx4hE45oDp8eoGSp70N44BfmqkPu+GL2NFdKXSb8JdiixJpRtuCavl6hTYvpH5QU1kXp5XCbhdf/O+hBxIPBQC6hNA+wFDfkz1/y9H5yoYchrN6Ehsda6EPEjkl1vzELmsYzSprm+0ISmPr91xnV95rNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgUvvaPk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2687F1F00A3A;
	Tue, 14 Jul 2026 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066977;
	bh=LFlgzQECQrDdonMFLsDXQtPgInSoiKKb4T41DNzYsQs=;
	h=Date:To:Cc:From:Subject:In-Reply-To:References;
	b=kgUvvaPk9+Cb2xz2LPxP5PBJ+qnwBudV88vGc9QCOMc3DIiwbct3wfpcGw1UDixas
	 iIN4n2OktWuTErfRBu8Oh8iRL8oWjnD3gvFVbBFeL1YY40mYX1upOZltE3ZhxHRuJV
	 8m4JKft07enHltFRWYNdrZwxcNzNIYtW0w24PtBDP7tT7Al3bgJTRis699ziipmxjO
	 I/lAOdqdcVx0J6YeOLPyz7hJEFQx+VrJvR1DZy2x8pAOccXVnEOtS6QC1MHgZxIuiG
	 /cX17EUF4qbrOgbgmoYxHxJ/yDuKFMWGldtbplm3srCYKxzhZe29DpIZ4uwl+kA/oe
	 VI4J3KbKSfDSA==
Date: Tue, 14 Jul 2026 12:09:36 -1000
Message-ID: <7e40318f1de2594c9aa53d2a2dc4324c@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: linux-mm@kvack.org,
 muchun.song@linux.dev,
 osalvador@suse.de,
 david@kernel.org,
 hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 mkoutny@suse.com,
 shuah@kernel.org,
 cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] selftests/cgroup: fix missing TAP output in test_hugetlb_memcg
In-Reply-To: <20260714021511.1063700-1-husong@kylinos.cn>
References: <20260714021511.1063700-1-husong@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:husong@kylinos.cn,m:linux-mm@kvack.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17808-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AB7759257

Hello, Song.

Applied to cgroup/for-7.3.

Thanks.

-- 
tejun

