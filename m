Return-Path: <cgroups+bounces-13581-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IkNO6OEf2mxsgIAu9opvQ
	(envelope-from <cgroups+bounces-13581-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:51:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33FC68ED
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C5E33001027
	for <lists+cgroups@lfdr.de>; Sun,  1 Feb 2026 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901125A659;
	Sun,  1 Feb 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMAJJQC2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C11B532F;
	Sun,  1 Feb 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964705; cv=none; b=K4zpU1Dd6DnlQZR4RbGVgvJhXEzy2Xg/IMxVdw5RVQ6FOVp2pwnQ4WQsSnn9CTFl/67BL8ZoIlh2q0/y9wXal2pPXxxq2DZ5F26syAX7pqiaBDm54C1xRjuHLc2H9OztHZwZcZNCiThJ7rQgOh6mrSJlhOIEl7ZoZbnnQKsEHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964705; c=relaxed/simple;
	bh=AvgjU4pq3tQBOXYv2Cm4Oz/DnPNOIpwzLhpGB43kziI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GBoxoKRgzx+ffK5UkDo4X2zqePQgpanFyiuaJLZWSRHbdzf56ZXu8NfVF0RnXvj2xdRCuU8rwL2HHNYambvJClw/f8NDMJ9d0knRR5tKQZTgjHn5aVrORApPy3YAps2oWbMPooskpJjNM1O9fOxGi3uyHpY4ePtckACVv1zwQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMAJJQC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49552C4CEF7;
	Sun,  1 Feb 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769964705;
	bh=AvgjU4pq3tQBOXYv2Cm4Oz/DnPNOIpwzLhpGB43kziI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XMAJJQC2+X6ri3NaXv8SjeQyf6YNMLSeModHRRA+Vri8PJvX5ReQvBXDt1pP2jnoc
	 HH7vA5/ZW6PoiLWcFQDfDYIog1YUzPHd3vxag88LnCF12gwtY9iV3YjZiyNvCqrY85
	 jUyfRg4dDbVutiootcM40Zged27EClZqYKGyQ93b+9H04PO2nIlrv41BRueUW1oR85
	 j4tKcC1rUjekZY5epBIUjnNcGjZGlevK0SbMxoIx852hDNNFXiBm5vC6gY3POQ2mNy
	 pGXuxVT3oBz5ClTIcBfNQGzGacE0RzgoeLXUmsGZvB3NmyJ+e55EaNMM06OcsK5C3w
	 VECxQY7NsUMbQ==
Date: Sun, 01 Feb 2026 06:51:44 -1000
Message-ID: <ac04dfbecb4d9f0d4b2ddbbaab0a014d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 inwardvessel@gmail.com, longman@redhat.com, shakeel.butt@linux.dev,
 chenridong@huawei.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next v2] cgroup: increase maximum subsystem count from
 16 to 32
In-Reply-To: <20260131030509.317315-1-chenridong@huaweicloud.com>
References: <20260131030509.317315-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,goodmis.org,kernel.org,efficios.com,gmail.com,redhat.com,linux.dev,huawei.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13581-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA33FC68ED
X-Rspamd-Action: no action

Applied to cgroup/for-6.20.

Thanks.

-- 
tejun

