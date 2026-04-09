Return-Path: <cgroups+bounces-15202-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKLDII+b12kUQQgAu9opvQ
	(envelope-from <cgroups+bounces-15202-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 14:29:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C13CA69F
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51110300E3C5
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2026 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C23C5DCE;
	Thu,  9 Apr 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf+2dWZ/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60438E124;
	Thu,  9 Apr 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737736; cv=none; b=hr96Z3sBbbL26NS5KhfI1yOb4n8MvfRoKrjiFjwDKhPl1Vew7DtYcyX2QDWklFv1ZFieept2X+nnOsfISJEx4FjsOPN9jHV7O4yKcQAgnOIL8uwyX+5yQzs89SA/0727BMADUxsaOjCqxG3Jq0ppDDPLWpwruUAENqQ2seATqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737736; c=relaxed/simple;
	bh=poFyMGo63glTH1EOk1zjTv3TeTeGbJgJ2107WbU5brA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsvYjYJvFIuTjvj8wE0XjKkKvbPR0dYwLyfuJynMWz0VvH6pP2RvGvGIA9GrOU7KhpSEfvhVPymlyBGrk1e/PrFG0qhqYA03EuWn5bJSUonZjE6LUiUJ0E9OAo2iSXzLMoAWhGtzWAvHFO14Z6oZNrhSGr56NY7aE2011A7Itzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf+2dWZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9590C4CEF7;
	Thu,  9 Apr 2026 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775737735;
	bh=poFyMGo63glTH1EOk1zjTv3TeTeGbJgJ2107WbU5brA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uf+2dWZ/soHkgYOgxmTde/ijjsQS1O8DP90fjnG9JAyp/Au5FI2z0NkfwRwXXCin+
	 b+keKtDjXz+KwENf+l03YkTB7YjVFBuqQKZS0Ok48OOcgP9N3z8t0Hm38SuRA91Zmq
	 i1p9jkKyWIPKUS9tbp8k1S7UDYoLYzHjm5spcho61sk4Hbi5DGDf2+Aqwn9FO0XJV0
	 qeNimGTiN4xpUrB3knaWyrD/3AmHSim4/mL+AN2BCVg0Tdq3TQTLCgBY4NmP+DWHjL
	 SREFa45sHGGWdDW4MAR3BGpoR99KJ3l8ii/R3jUp2L2lZAaIZucDiDymXcLdRqw/aT
	 KIVGqv/Weqd1Q==
Date: Thu, 9 Apr 2026 14:28:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, cgroups@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com, tj@kernel.org, 
	hannes@cmpxchg.org, tom.hromatka@oracle.com, kamalesh.babulal@oracle.com
Subject: Re: [RFC PATCH 0/1] netlink: Netlink process event for cgroup
 migration
Message-ID: <20260409-unvorbereitet-pizzen-c479b7bc6f85@brauner>
References: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
 <pd3vkzvgr233tkuocyvpgxc4kttsi5nlggcxuskvwi3mocoqkm@cfefi6hh74s6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pd3vkzvgr233tkuocyvpgxc4kttsi5nlggcxuskvwi3mocoqkm@cfefi6hh74s6>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15202-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 441C13CA69F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:54:17PM +0200, Michal Koutný wrote:
> Hi Prakash.
> 
> On Tue, Apr 07, 2026 at 05:23:38PM +0000, Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
> > With cgroup based resource management, it becomes useful for
> > userspace to be notified when a task changes cgroup membership.
> > Unexpected migrations can lead to incorrect resource accounting
> > and enforcement resulting in undesirable behavior or failures.
> > Applications/userspace have to poll /proc to detect changes to 
> > cgroup membership, which is inefficient when dealing with a large
> > number of tasks.
> 
> You may want to check [1] (and followup discussion).
> 
> > Add a new netlink proc connector event that gets generated when
> > a task migrates between cgroups. This allows applications/tools
> > to monitor cgroup membership changes without periodic polling. 
> 
> This CN_IDX_PROC netlink API haunts me at night.

Yeah, let's not go down that route...

