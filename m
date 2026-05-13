Return-Path: <cgroups+bounces-15912-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbPL4jWBGovPwIAu9opvQ
	(envelope-from <cgroups+bounces-15912-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:52:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53253A348
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7B31300CEAE
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FCC3B8930;
	Wed, 13 May 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+2O0Miu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E053A71A4;
	Wed, 13 May 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701956; cv=none; b=h0XOczsj2PJ+urQtXd0uRViqH0Gn2eIWZ4OTtyTR3gBsn4ay16YQDytnuu0ZIdj4b1DFNJ6SEcKN9c2U2H5wVBkXkYADMpENqivb3oyhegOvo6lGQP6zt5GutuGvji0lQQAsnbaYJXPsQuiHEhMpb0mDvGWQ3rJgXtXx1PgGrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701956; c=relaxed/simple;
	bh=1nhVEAm0QATJ9hlPPcRkEOlGpmULX3bBT6q95EuBujI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drdyR1nOF1CFreDdm1PH65RosDMNLhBJgWV0AjOzhYeD72zUHVHIYTStI6YCOo5yUUM0L3+he/wVNwRfkv2LMs5Tf7A0Ny+mSWkln3CiXJuLjRrYRxv6YC65FTfsagOocrCuV8I6vqnj97i8h2OV17JviLSyRXpmC+uzwTfgXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+2O0Miu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F14C19425;
	Wed, 13 May 2026 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701955;
	bh=1nhVEAm0QATJ9hlPPcRkEOlGpmULX3bBT6q95EuBujI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+2O0Miubiz55ml5NjvL4VWDCfUa7OcCyfdIgL+t3c/YgeyOeXRv6VJwfuX6s0n08
	 raPZdb6x/siDidNt4m8bCixhwJwwtheRd9HaMrwnBbl3NnSJOYemsVQoVcRH6wthYE
	 6hgq+vZ6IIOm7tLH6oJZHxFs+Vj6xrnUVkTA4NJJm3J0d5IErGPYby8cbPTVx17jtR
	 +cppIahNXiOd/f0oQl/yN6hOeV5TdV7kbHzok/q8VfvGmodlrtwSMP4bPaD1WeogXn
	 PdmxG03GZt2BzgwE0ckz9RmNWPMLWGumtNxMdfIzlAriN0kIOWCr2+Uy8QmHP+0inn
	 28emZxMRlOo8w==
Date: Wed, 13 May 2026 09:52:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Return only actually allocated CPUs
 during partition invalidation
Message-ID: <agTWgicYbzX9Bvqa@slm.duckdns.org>
References: <20260512090034.183133-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512090034.183133-1-sunshaojie@kylinos.cn>
X-Rspamd-Queue-Id: 6F53253A348
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15912-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Hello,

On Tue, May 12, 2026 at 05:00:34PM +0800, Sun Shaojie wrote:
> From: sunshaojie <sunshaojie@kylinos.cn>
...
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: sunshaojie <sunshaojie@kylinos.cn>

I applied as-is to cgroup/for-7.1-fixes but from next time on please
capitalize and put a space between first and last name.

Thanks.

-- 
tejun

