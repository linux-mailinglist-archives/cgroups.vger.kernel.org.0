Return-Path: <cgroups+bounces-15985-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPAaAg1YB2oozgIAu9opvQ
	(envelope-from <cgroups+bounces-15985-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:29:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F05551CA
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6D7F3006136
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4223DB645;
	Fri, 15 May 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG/R2fOF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7239EF39;
	Fri, 15 May 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866103; cv=none; b=rApIJvqpyF5/3PFVbmms+uN7uOwEYg5CAbb/eQ6RrSXD73re/KS0DThsvggnJQocRd8fiSWYiqTucBi+y9ZhJ0TT+IBbKEZMa7hoEEtBLp7wiVPD6GlwGsB33KPjxbkRBEvxlUmK/cZpjKY2/Fw+Ts9F1LrJyBR1ScFKKE5JulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866103; c=relaxed/simple;
	bh=6PM2EdsIruh7Ccx4isroRPr7w+RkDOSLCYpfXBKVMIU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ox1hlF9Up4NfQVvsK9ieDQzRhZkkCT9BsDhDpSVHQDynguT7mMmL46kXt1H9v0ldoFXeoHgySe+MFeXXjhhbRhQ9zTYxTatxJRZE37cECOfeKS8imKKzC4jvYpUIvOa0j8Bzyhx8CYuLbjPYuNTwByBEo/q0Rdl/tde2WBea34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG/R2fOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333AEC2BCC7;
	Fri, 15 May 2026 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778866103;
	bh=6PM2EdsIruh7Ccx4isroRPr7w+RkDOSLCYpfXBKVMIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fG/R2fOFsjoWc9RIDzRh0/Q7N6+o3qSh8Gh7L91OCOiBTYNldt6eM7bs3P73v3lOW
	 5Li93O875E2rN/nEB3gr9Ad6W5mC33UtFzvtRgTJTcdlgz9f3khd87THBh1+xMObSG
	 CmNkBzPpMFqXMDfL2jigL1xn5dzuYm18fph3VojomZFqQlJM19yBJj7qRamqLEiU6n
	 +q+9W37YKvNgpSoIIgXPdPAzTbMj2ImHd1LI70kdpA7YZz0XyRm3zdAdv39+zd69tY
	 EtRxvT7GOKXZvRxDy6L20D3NMuFXvUU7+gTXljTdB79uXHMx7xRXH/inMfXdyov16y
	 77Oza40Oy7oXw==
Date: Fri, 15 May 2026 07:28:22 -1000
Message-ID: <cd7551971d0425e4d57ce29043c773c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET cgroup/for-7.2] cgroup: Per-css kill_css_finish deferral
In-Reply-To: <20260505005121.1230198-1-tj@kernel.org>
References: <20260505005121.1230198-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A43F05551CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	TO_NEEDS_ENCODING(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15985-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

> Tejun Heo (5):
>   cgroup: Inline cgroup_has_tasks() in cgroup.h
>   cgroup: Annotate unlocked nr_populated_* accesses with READ_ONCE/WRITE_ONCE
>   cgroup: Move populated counters to cgroup_subsys_state
>   cgroup: Add per-subsys-css kill_css_finish deferral
>   cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()

Applied 1-5 to cgroup/for-7.2.

Thanks.

--
tejun

