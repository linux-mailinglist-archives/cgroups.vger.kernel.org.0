Return-Path: <cgroups+bounces-14690-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CZ/JblZq2mmcQEAu9opvQ
	(envelope-from <cgroups+bounces-14690-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 23:48:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B05228621
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 23:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34665302E0F6
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDE2F361F;
	Fri,  6 Mar 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyZ3aRE/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C383502BA;
	Fri,  6 Mar 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837300; cv=none; b=HYymTBXhNklSbbYL43y7c28smTOOXuLgURZ+WSWwihKka+9yYo0EXjqUApTVoMk0Nk3qXB8sIT0VOXqiKNbVm0uljOdHwWL+YSz3qkomeMuWyD2AD14bcXpmcA5Yj9W2mECvoIlFM92YPwfS1SSNLjtS7FrXSJjq5wxV+vTtZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837300; c=relaxed/simple;
	bh=izRaMOOe9JYV+HyxNgh8xIBq9SoerJw5ZWQCKg89Q9M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Oj8QDHFymPOSR5RHHEBwCiM5Mok2rmIZ4XTITHN/oJreBYp/E4pYg15fUn/9o9NG3HnyM+Smu/tIW28WeZWwyUyyEwodbmGWXsGI/Me0B21p9N8VsP609j3GXsLjUR8y/J+73Kp7a29b8QGRX3mZ6iS/O63fVNFvyR8/GbGjkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyZ3aRE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAABC4CEF7;
	Fri,  6 Mar 2026 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772837299;
	bh=izRaMOOe9JYV+HyxNgh8xIBq9SoerJw5ZWQCKg89Q9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NyZ3aRE/NNQexOPSXkS9MxNa1zN0Wed11ah7s2GgLXCM161K3+kfRnTkjv/0gzP5C
	 0IMbWyzODDyuCqxc+W6OAA+t735BAv4ObCiIyMYjf/xRH88bXTKmGZXPcQZHO9o+Ez
	 NcDfXP3DJEdMjZUmqPpuLM78vltZAe/deAtjgmOCHtEywPuzOspoqI/Xn4rnDvLqkb
	 3LrkDnRUim5GxnSEUQNnpP6mNmiRH9P6UzO+lMTnbkpfpwJsjCKfR3tzXQSnIHplse
	 2ILDdFW47nimoXmzN3YmkYEZI/5wAOOJMWbrGzsHfbpAmd13DSUNqjzpWcjyvTVSco
	 060/JSaszLS9Q==
Date: Fri, 06 Mar 2026 12:48:18 -1000
Message-ID: <3b3a143326fcff2d21a7e7d801bc3aa8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-devel@lists.linux.dev,
 cgroups@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v2] cgroup: Don't expose dead tasks in cgroup
In-Reply-To: <20260306192235.DY60tMnM@linutronix.de>
References: <20260306192235.DY60tMnM@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 44B05228621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	TAGGED_FROM(0.00)[bounces-14690-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Applied to cgroup/for-7.0-fixes with the following fixes.

- s/removed the cgroup/removed from the cgroup/
- s/constrains/constraints/
- Fixes tag SHA trimmed to 12 chars
- s/exitting/exiting/ and s/task which are/tasks that are/ in comment
- Added Cc: stable

Thanks.

--
tejun

