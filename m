Return-Path: <cgroups+bounces-14779-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qhzkN07vsWkRHQAAu9opvQ
	(envelope-from <cgroups+bounces-14779-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:40:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4926AF24
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18E03058BB9
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227F394492;
	Wed, 11 Mar 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBHjXVF0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A7299943;
	Wed, 11 Mar 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268811; cv=none; b=Y3NXMwwy6JcHcFJ00pg2Oh4Kc/QEPL5JjkSGHeERlm3ZtYFrZiK/MPjI1nBtOIJ+5J6Kn+jJS0C8Oq6PbMqyqcfseMWVKi8FMJNb454dpVtMV0Rvo9dBJEO7wguxNwyBDQga/8EDeuOOW7htSbEq7DxKz26G1uDe0MOjr3q3/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268811; c=relaxed/simple;
	bh=Hzj4XO+EDDZJAujPfqINkXo13HUIvjVZASzAWmY/sR8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YwYUYU8iVlwYLKOzDa6P+j0Wa7V33rwOL88zWFsEnRijV8/g6UwuTd3+UDYZWxwARoiGX/ELvUidGIt0mwFnFBmh5R7OP0sFHIRqHScBLkTVfIFr0qnhnw1MXTMbdUlRAy790QE16o1kJu4C7OsbHXNmNbx4JAmBtT6MOebs84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBHjXVF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D3AC4CEF7;
	Wed, 11 Mar 2026 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773268811;
	bh=Hzj4XO+EDDZJAujPfqINkXo13HUIvjVZASzAWmY/sR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eBHjXVF0ClnedaHFjwvVh1ppNXeD6Ot3tDiVSKI54Ka4gJKz+opKNKBVo/r8HJGvb
	 PIXjIt3gC/IkdZ2Pm9s+abfRVQtoRZitZRSBsze2NoGkRrLPx0W30mXPjsy/NOAdwA
	 QWYaedpOPkxVYueVd4qhsQ+bQtBS9vxOdTfPYrd/W+oYY+Dje2JkLE+E4tfrWhV56z
	 qspdcPr9/+uw+AbFik4B22aSBQtOqwS8j9PYlKD8zkc7EqKQ/6o+Fr/ZOL/fYrSrdn
	 dKuP4+fubcgBvQH18SF0L7zY/reeaEcmohSOy8MR2yhCVHePqy+XnPqSUB+ALOgzGc
	 V91N8Sxgs+wGQ==
Date: Wed, 11 Mar 2026 12:40:10 -1000
Message-ID: <aa924f6d8d13eec9e21bc54a05177978@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 0/3] cgroup: improve cgroup_file_notify()
 scalability
In-Reply-To: <20260311010101.3306366-1-shakeel.butt@linux.dev>
References: <20260311010101.3306366-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14779-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68E4926AF24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Shakeel Butt (3):
>   cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
>   cgroup: add lockless fast-path checks to cgroup_file_notify()
>   cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock

Applied 1-3 to cgroup/for-7.1.

Thanks.

--
tejun

