Return-Path: <cgroups+bounces-15668-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPt2GZUL/WnsWwAAu9opvQ
	(envelope-from <cgroups+bounces-15668-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 00:00:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A754EF875
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86588300C3AB
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1E338910;
	Thu,  7 May 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXMSQ9Wf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD42F8E8E;
	Thu,  7 May 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191246; cv=none; b=TTdcWYvm4YiR+Az7IJJKAERXXbYuB/1auV/lhN6v0559vKUtGNDDzuQ9dNBln96FCNMJGeI1NC3d0M/LA9JthxqGiCH7sUSwaoJkFxpfbN+ISEGy0ZOgKDksrD8VhqiP7ADCK8t/ShUyHYUX0iIuMNSUHY9sLoQY/WPQ5qwONt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191246; c=relaxed/simple;
	bh=pMl28sdRCMQnjGQqt5rTxOraIUiwS/tyBfCt/K/2+mQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qPRLe9gy8/GYBRlSRspaix6QX77ZfQDdlijaxoCPZc/O6Qvp2/k6tNZJI6w9TsovrUPwaW7cfBzalNsw6ZocF4jZUHQ05zB2v+bHOB+om9IiIqkak8+WHWFBkAjg+czgdKgjQMFjCerRVIUSJRUbjfxMIRycNJqDLTNRelbTrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXMSQ9Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A887C2BCB2;
	Thu,  7 May 2026 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191245;
	bh=pMl28sdRCMQnjGQqt5rTxOraIUiwS/tyBfCt/K/2+mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EXMSQ9WfIB8epeqBqR4CD++wGV2qdHWopT5wmB5kPH0E+eDwBlf7n8Z1JMDz0e0zX
	 cVTacx0HPWo5MukZ4eqheEyfd55bbl7P+wdDWbFvpasuS0sr3stIvNLGw0paDLUF5z
	 R+3JEMq9UUVkL2NAgX6OC0cr/CZSsWeraSGjRx0s76s0f+OVu1uPxqh5tTOnarEOgZ
	 nWGkHYECzwsfXqmYOKhVikgBwxbdmAEGxxqcXzBSSvSD4gelJOmPw2etUvLaUsi9bb
	 GmNeIkCF0hnc4ATjueR0KPyDhbxgYhAwpL0vGNDYNHvYDJlyRrsxKkomJGrmqQyGiF
	 05rObWbE1lT6g==
Date: Thu, 07 May 2026 12:00:44 -1000
Message-ID: <7178c16c401992a7fd82989d8a6cda80@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>, Chen Wandun <chenwandun@lixiang.com>
Cc: longman@redhat.com, chenridong@huaweicloud.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
	__GFP_HARDWALL in cpuset_current_node_allowed()
In-Reply-To: <20260507105434.3266234-1-chenwandun@lixiang.com>
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B7A754EF875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15668-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lixiang.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hello,

> Chen Wandun (1):
>   cgroup/cpuset: move PF_EXITING check before __GFP_HARDWALL in cpuset_current_node_allowed()

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

