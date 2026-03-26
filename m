Return-Path: <cgroups+bounces-15064-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG1MJkFWxWkk9gQAu9opvQ
	(envelope-from <cgroups+bounces-15064-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 16:52:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9955C337E44
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 16:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 986253127DAB
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D9401A22;
	Thu, 26 Mar 2026 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bq3aJp/9"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A12DB789;
	Thu, 26 Mar 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538669; cv=none; b=o7LvxybArCY1zkZkyfAinskpWVYVzrbA7ptUA1hQkJa0ncsDvzjSrQV//Fd5pNWAwkutvKfHpNC1m2qmN440eZa9zntUWOz4+NBxzhi/AEnIKchadCcGTEGSohc7IEdk7/lz91k/P9ueU6ICYCYkcBy6Coxn1wSOSQRcLmpr5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538669; c=relaxed/simple;
	bh=gE0v9XP3sCuq/U+PbvxHojssUZV5OfNfgHOYOdAyNas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV6uAQeClPMOGxqyporp49m9zTxCwJxDQFV/h0x6vSCK3hDxZf2/yBhOQ2kXBYGHw7yMHPl/YNkAFqSdfIvTw7gT9l4hitQoONb7gnvWuyT39AFzKhzPib71kNqxYOB094xtztXpL69sDtoPSRPt+oZ+mp5WrctlOfcnnXAShzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bq3aJp/9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=79PooYTcjpn0OJy43B3sHJHXWnuNr5NqSKvPV4Iqa8A=; b=bq3aJp/9M4xmm2rRxvb+0nsZoB
	zb3VkDcA+6eMCsnPFE8TK4aAa0DZZ1Y5WI7lxGoHOFqQ9H9O4gMr4h/p7keUwcg8NZ3rf4oKyf3jO
	0j56U/ngveTU3oY9fRAHG5B7phnzQo953qCPYcnIDN00Y5IqtK+Oj2GmnZkGUyL5LcVtiYgdxNECz
	PEAovblXf89PfnJdY4bN2nPomkwbI3ZlwWAej7XqRgA8fZ+WHhCwX1OcppaD5zujQK8xuJ93AvDNQ
	aNkn0GawVdV8bwkr6WmPAanE2WHe4dIdunneJNEydnrOGNNhpbRYlvF4Uv7waKhbcbWgDUwYR2beJ
	sOPaDTsQ==;
Received: from 179-125-71-253-dinamico.pombonet.net.br ([179.125.71.253] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5mZJ-006OEU-Np; Thu, 26 Mar 2026 16:24:22 +0100
Date: Thu, 26 Mar 2026 12:24:15 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Message-ID: <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
 <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15064-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org,igalia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9955C337E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 06:40:40PM +0100, Maarten Lankhorst wrote:
> Hey,
> 
> Den 2026-03-23 kl. 18:37, skrev Thadeu Lima de Souza Cascardo:
> > On Mon, Mar 23, 2026 at 05:46:28PM +0100, Maarten Lankhorst wrote:
> >> Hey,
> >>
> >>
> >> Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
> >>> Hello,
> >>>
> >>> Generally looks okay to me. One comment on 3/3 — the naked xchg() in
> >>> set_resource_max() needs a comment explaining why it's used instead of
> >>> page_counter_set_max() and what the semantics are (unconditionally sets max
> >>> regardless of current usage to prevent further allocations, since there's no
> >>> eviction mechanism yet).
> >>>
> >>> Applied 1/3. Maarten, Michal, what do you think?
> >>
> >> Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.
> >>
> >> Kind regards,
> >> ~Maarten Lankhorst
> > 
> > Actually, this can still happen if an invalid region name is given.
> > 
> > So, one could write:
> > 
> > echo -e 'region1 max\ninvalidregion2 max\n' > dmem.max
> > 
> > And even though setting the value for region1 would be applied, the write
> > would return -EINVAL.
> 
> Makes sense. It would be good to validate in advance then. If that's not possible we
> should at least not error when we try to update 2 regions simultaneously. Likely the
> best to do so anyway if we want to handle eviction, which may be handled in a blocking
> fashion.
> 
> Kind regards,
> ~Maarten Lankhorst

I have submitted only the last patch with the additional comment for now.

If it turns out that eviction is handled, you bring up a good point that
doing it in a blocking fashion may lead to an underisable effect where
setting the max and starting eviction for one region may be delayed by the
eviction of a previous region.

Is there any reason to keep the support for handling multiple regions in a
single write?

Thanks.
Cascardo.

