Return-Path: <cgroups+bounces-15913-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKFfKcneBGpDQAIAu9opvQ
	(envelope-from <cgroups+bounces-15913-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:27:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CCA53A733
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5D83015CAD
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA553B5837;
	Wed, 13 May 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeawrKH8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B87399CF5
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704070; cv=none; b=Adf3nP1F4h4N+u52kHoMqDtX22oE3c6Ht1VWCUCIf04OUrNwrZ8QFSAqtBIZqJjU5GSEK8jdh29ufWQJh5eJVUydOREJ3wse4uGXvChXMfa1c4ZNBa25ba9PmplMuxHDz7tswYEDHpG6ePrFjaeqyUnBzqqL1wsZefoh49vvS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704070; c=relaxed/simple;
	bh=qml4WAJKRZDVRX/sLvD4hDBx+iIWzg9Thdnj8lVCfYw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sjXi72H6efVB65vjM8vIlp/76QvURct8c9kI4GTGiCfla3Nph/jArlrdh5BbU+G3rv5uiYJUEajtazjlxRtn57EYF+PYy1IMPSc7O922kNheZ9tvE+G+qtyLyu1Kb8R5Pb474i6bB7GmQcWxAs+Ksy2EPIdlAJCo1t3Rbq1qDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeawrKH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BA3C19425;
	Wed, 13 May 2026 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704069;
	bh=qml4WAJKRZDVRX/sLvD4hDBx+iIWzg9Thdnj8lVCfYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeawrKH8MVIec0IwQo/f+PtgNh1qikmgsL6OLd22GI2WGsCzDnNiC+HppKPAj2GEY
	 vuUNV0VYsJvV3GvFFmoPu6JMj6/kpKVk8QcwuFN813TgfJzsBFk8P+VG0QdWFDgttY
	 g1kZWhGCczDqj7VZjyRuVeBFaDXdIMP7ZZNH30foyTNgFh/WHgIK/FNizS6D74SFtg
	 7a7ynRGYup3dma7m3uKOofsV9WJJ0yjJToNa7cSex+g7Vo5fJeKDQgBOk2s6GpOPwX
	 MFWZhAd6CmpT490p34voIekv66hlCG+omqPF8sJ5gujW1lfNh4KvfTnO4XnLQHnBlo
	 SD8cpyj7CGt8w==
Date: Wed, 13 May 2026 10:27:49 -1000
Message-ID: <f30b301f9a7dee1fc458f1c7964f731a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
In-Reply-To: <20260513104956.373216-1-cuitao@kylinos.cn>
References: <20260513104956.373216-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: F1CCA53A733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15913-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rdma.events:url]
X-Rspamd-Action: no action

Hello,

v1 points are fully addressed.  A few more on v2:

* In rdmacg_resource_set_max(), the new "rpool has peak/events" check
  uses `goto dev_err` to skip free_cg_rpool_locked().  It works
  because ret is still 0 at that point, but dev_err is the error
  label and this isn't an error path.  Restructure so the free is
  guarded by an if, or rename the label.

* By the end of patch 3, the rpool-keep predicate is five lines
  duplicated in uncharge_cg_locked() and rdmacg_resource_set_max().
  Worth extracting into a rpool_has_persistent_state() helper — a
  sixth counter later then changes one site, not two.

* Switching rdmacg_event_locked() from get_ to find_ avoids the
  spurious-rpool problem I raised in v1, but it also means
  ancestors of over_cg without a prior rpool for this device
  silently drop the hierarchical event.  Now that the rpool-keep
  check covers event counters, get_ + keep-alive would give full
  hierarchical coverage without the issue from v1 (rpools getting
  freed on the next uncharge).  The struct is small and rpool
  presence isn't user-observable.  Worth reconsidering — or, if you
  keep find_, note the caveat in the rdma.events documentation.

* Patch 3 also extends rdma.events with hierarchical alloc_fail
  but the commit message only describes rdma.events.local.  Mention
  the rdma.events change.

* In rdmacg_events_show() / rdmacg_events_local_show(), the
  `(s64)READ_ONCE(u64) ... %lld` pattern can drop the cast and use
  %llu.

Thanks.

--
tejun

