Return-Path: <cgroups+bounces-15683-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KATjHZwU/mnZmgAAu9opvQ
	(envelope-from <cgroups+bounces-15683-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 18:51:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 424834F997D
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADFE3028B02
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9633F660E;
	Fri,  8 May 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMPJWU0j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D32FFDD6;
	Fri,  8 May 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259069; cv=none; b=m2gTSPP5OZvK14HemyiQBG50jweHjATtaXh1YUV+OzSwKkVerb6YcggU1x+9P+D+ZTTzu5vWd519kvsO56gsDD5LTnwALDaB6mOOHHMvs30T6YyU6yoI6oMVsLogTRWeAjTCpkW5TV5IlqukHXhQcfShKsYA3+dEcQxfCFlr3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259069; c=relaxed/simple;
	bh=wfZHdxbphDCILLF5DQY94IvC3KOyp75rgVsh1kDweds=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fyKZ/5Zg5bEXZpsBCVq2VBJVY+oJLEEFRehKptYC4W0vKSwyEbuKvyzknjzjvvEcd8nIt3FrY3iv5LC+8S9Yenmoosd/zGu9MpUH0TIs3phdG03uvjRXRRn06ath4riMxw8fmnxfVfbefCNLr4lpWbnPWmkVOrD8CSgGlbUo920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMPJWU0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9EFC2BCB0;
	Fri,  8 May 2026 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259068;
	bh=wfZHdxbphDCILLF5DQY94IvC3KOyp75rgVsh1kDweds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cMPJWU0jCW0z3TZ++dW6lonz13wMO8tor1O4VQq+lb4pNPP1epcErZvCKsBpeHwqm
	 VD2TSDTCBxHX7qOhroJOAXLMHYysCXKeQvL2HJiBhrTmLEAp2JM6yelsZNZHavhYpd
	 KaRhr63yFCB3JDvqlzg2QZoCCi6YQJNreJEh5QbeclNr6qPDNDchHOtg5r4sGdYzHl
	 TRGP+y6LV8u/KnGbXBtr1uXu8AziJyPXv9K2FzTCf0wp4RcE3iKg8U/SgQ3wxnQLC0
	 dog/SJFzxUeY6h/lnjtkx8lf+76ft76TXPYXuoTCOIZYoTDlHbGtLzwd4YvFIIIOAm
	 ejKvww3twkVAw==
Date: Fri, 08 May 2026 06:51:07 -1000
Message-ID: <a127e36e4fa970ddabe36a654088c7a1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: longman@redhat.com,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: Fix incorrect variable check in online_cpus()
In-Reply-To: <20260508033453.1425026-1-lihongfu@kylinos.cn>
References: <20260508033453.1425026-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 424834F997D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15683-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

> Hongfu Li (1):
>   selftests/cgroup: Fix incorrect variable check in online_cpus()

Applied to cgroup/for-7.2.

Thanks.

--
tejun

