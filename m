Return-Path: <cgroups+bounces-15497-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HTwNT5x62nCMwAAu9opvQ
	(envelope-from <cgroups+bounces-15497-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 15:33:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE445F1A9
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DE030209E8
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAEB3D6CC7;
	Fri, 24 Apr 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WLbnbmRI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FA3D3CEE;
	Fri, 24 Apr 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037470; cv=none; b=bu8xiz/3UsoNUkqrDs53oX50NjMqPzYxlEmQWZPo2Y1+vReA9/5pHeOhEYLOhYvhQPyxBVUHt/ns/8W7OjQ1EnigraJzX5PvrJAHFLBGtWISzRcvMZX3vQ6iFwNd+k9I+ROCksjMm+VodaMkDzT/EYxDdha4wA6Dw4obWzcb9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037470; c=relaxed/simple;
	bh=bp+ACcwezPuzPs1ltjFyz9x481JAiCF8UZHITo7dJiI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MlRuBkLb18DJ/OREF5U9Q0jNCpns0CHA6gsDTS7JwsfHcfR6NbHDseFY0Ai/V2+19jD+OXIZV1bE2PFiB/NglmAKKom8q42IWh4oCUJ/QLGhXRTXSbXAhhfzQRTC1rkfSUM99RtwGNIHJZYsjd6u/6zAynlm766r4b9tXLJ+Pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WLbnbmRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE7FC2BCB5;
	Fri, 24 Apr 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777037470;
	bh=bp+ACcwezPuzPs1ltjFyz9x481JAiCF8UZHITo7dJiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLbnbmRIznNTjt5hg14jP0khfMtV0UhdvBTF3BjQLCjPyw1V2RKy7rNJx1LzsxhCo
	 PbV8vvqOPEUqo490ke59HqAgYalxRjTecEehhxaAMt02IoPnqubgiVQQ4n9z+TTO3F
	 plM3p077xPSYrmlvjag4jSowTE3I7OY6c7C2qYxM=
Date: Fri, 24 Apr 2026 06:31:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <li.wang@linux.dev>
Cc: tj@kernel.org, longman@redhat.com, roman.gushchin@linux.dev,
 hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev,
 nphamcs@gmail.com, chengming.zhou@linux.dev, mkoutny@suse.com,
 shuah@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] selftests/cgroup: improve zswap tests robustness
 and support large page sizes
Message-Id: <20260424063109.6fab94d833e82f87e4309006@linux-foundation.org>
In-Reply-To: <20260424040059.12940-1-li.wang@linux.dev>
References: <20260424040059.12940-1-li.wang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AEAE445F1A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15497-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,suse.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:dkim,linux-foundation.org:mid]

On Fri, 24 Apr 2026 12:00:51 +0800 Li Wang <li.wang@linux.dev> wrote:

> This patchset aims to fix various spurious failures and improve the overall
> robustness of the cgroup zswap selftests.

AI review:
	https://sashiko.dev/#/patchset/20260424040059.12940-1-li.wang@linux.dev

