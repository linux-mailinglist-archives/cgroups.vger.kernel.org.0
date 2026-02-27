Return-Path: <cgroups+bounces-14479-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPecHEf2oWkwxgQAu9opvQ
	(envelope-from <cgroups+bounces-14479-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:53:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01CE1BD1FA
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BDEF301CDBB
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1446AEE4;
	Fri, 27 Feb 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfA4x46C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD68466B75;
	Fri, 27 Feb 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221901; cv=none; b=V9mfj10Rcl/nVVrBv0lSPK8fPJ/QTg5hqcAqyjagZ0MKdIpTDLZtSwduJWMLRKjZL6hA8s5ysA632xuDRSPp8/lomVBC3xOAsnT0rOXsRcGG5Wpodk18Az37V+1gJxy1Y3InD0kFaCDl/eMkcQicYJDQ5r+F/7zwpgSipq0O+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221901; c=relaxed/simple;
	bh=H9t4oVPCtn/Tas9C8HMkqiYEEpOkr8l8V3fRwzfjY1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgirD3JxCTlhzT06CCRdEq73Qn9xTzknPVA9auvqqS7PYtc+EGd1+StmOtsUZUPStsNBN88ORwL0Cx+fr7KCVbu8NJcxD+vGDQtvMc5c/3e3Ciwv5ZhVLpKq/KN65coJ2i3puACLSZofIj5Abne7Chf3iChYzQVEJnppZoOovFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfA4x46C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8304DC116C6;
	Fri, 27 Feb 2026 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772221900;
	bh=H9t4oVPCtn/Tas9C8HMkqiYEEpOkr8l8V3fRwzfjY1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfA4x46CwwrWp2clyHpugUeX4xCFq0iHicmVaY316qRKcm9oPSVvbOjt3PzHNtNOc
	 WaBCBnieG+H4WHQjes3nlmrMFp18p31v+sLEBr9wyv7AnYXD6uNtbUDAX6AVNOsL4y
	 e+c7O6vUKZQBqFThbbhru02ezH/fJIURQYuDmpe1G5Y9jUp7O+wpMJJMrW4buvAUzT
	 JG8PD/ruAGR6wLXxSMbfsdYG7RPfWokp534JntiXxLXbFm28zjQEHcA3/xUZXKqEjr
	 e0A4xzheDBPy48YK5AEYB2uXH6LbAQoCmGI9UDY5aiaKOpdjOKUtZP52y15ogwiYFt
	 0L5O8AfLFjUXg==
Date: Fri, 27 Feb 2026 09:51:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/34] sched_ext: Introduce cgroup sub-sched support
Message-ID: <aaH1y7ZXepwjL58X@slm.duckdns.org>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-8-tj@kernel.org>
 <aaBsRu4_4OXv4d7-@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBsRu4_4OXv4d7-@gpd4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14479-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: E01CE1BD1FA
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:52:38PM +0100, Andrea Righi wrote:
> On Tue, Feb 24, 2026 at 07:00:42PM -1000, Tejun Heo wrote:
> ...
> > +/**
> > + * scx_is_descendant - Test whether sched is a descendant
> > + * @sch: sched to test
> > + * @ancestor: ancestor sched to test against
> > + *
> > + * Test whether @sch is a descendant of @ancestor.
> > + */
> > +static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
> > +{
> > +	if (sch->level < ancestor->level)
> > +		return false;
> > +	return sch->ancestors[ancestor->level] == ancestor;
> > +}
> 
> This seems to be used only later (patch 31/34), so it's an unused function
> for now and may break git bisect. Maybe we should introduce this later?

It's kinda nice to introduce the basic organizational things together but
yeah the warnings are annoying. I'll move it to the first user.

Thanks.

-- 
tejun

