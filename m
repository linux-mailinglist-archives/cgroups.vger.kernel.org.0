Return-Path: <cgroups+bounces-17145-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +fFYGFVVOWr8qgcAu9opvQ
	(envelope-from <cgroups+bounces-17145-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:31:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A635B6B0BEF
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:31:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=igalia.com header.s=20170329 header.b=ToA3PaPb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17145-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17145-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=igalia.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE44303010E
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F055376A17;
	Mon, 22 Jun 2026 15:27:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15F375F87;
	Mon, 22 Jun 2026 15:27:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142039; cv=none; b=XQ1XUWSntcSWG6XRxTcEG/26eQjhH/T3jVnKpdUV0wwUrNGIUx0hkVAgOm9E6dNk0iIwXHLkpa83y9YSrrsPZz0915lGU1e3POa3t2SfjahDUlynXb17uixO80isZZ82L074kmC0PuRfvPMSVMQfe6buEwlPqgaBnx1pK8JOLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142039; c=relaxed/simple;
	bh=YKqcE4eMhIkP1iQW7SP7TbVcdSm7U/l/ik71O3oFPdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9lLO4s/IBw3rF33Lldjp3X1zeD8KQaNNCg0QWzm5MnMSA6tcw11sSlcgYQE7HroBI/mysOD+bPAx5OzdNv6bE0A84RtP+lZmq01xLczQCRCIrUnWwubJBudq8SPFVCmmiL1QyK1RxJ4bZhNespWSN32bsMT7rMGmFb7Os8HVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ToA3PaPb; arc=none smtp.client-ip=213.97.179.56
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PQvYmdv7l/ESIGmByUEb2vrNIzMYdcuiCUtVuj30ZX4=; b=ToA3PaPbYJbNs2g90uuncz9Dw4
	2ZbWq0EWGQzrURDbsgz57RWBkFx6e0lQQPO+i6jdclcsL/GRhethVLN7qLtrb+E9/u27a9da9OOxB
	0Xtm+MER55DGbLpaUk1Ly+TnBsSVdpcCVcsw78CJWNb1wWWKYbqec6dtnqvMl59VkJ9oB5PYCKk00
	bY/EpdRn1lzhZQsR5F1iYDRFsxLL1VoNQ51Msn9wuZRw7ZvvoFsjJR9GpK8c3bg3l2ZN3XG9OAh+u
	bMRnJvfy5qykiZw/5DpKixYTPdUGNu1BHMCykDnrDpI7W4WoTXOhOOm9fTx58PvxteyhmtjtCGE7/
	r2L1xIeA==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wbgYB-003nTK-5L; Mon, 22 Jun 2026 17:27:03 +0200
Date: Mon, 22 Jun 2026 12:26:54 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
 <ajBLAsNoKesXmFcs@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBLAsNoKesXmFcs@slm.duckdns.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:thomas.hellstrom@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17145-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,lists.freedesktop.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,amd.com,intel.com,kernel.org,suse.de,ffwll.ch,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,igalia.com:from_mime,quatroqueijos.cascardo.eti.br:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A635B6B0BEF

On Mon, Jun 15, 2026 at 08:57:06AM -1000, Tejun Heo wrote:
> On Mon, Jun 15, 2026 at 08:49:55AM -1000, Tejun Heo wrote:
> > The canonical behavior for cgroup2 would be not failing the write at all
> > even when the usage can't be brought down below the new max. Updating the
> > target configuration and tracking the current usage are separate operations.
> > The former should just set max and trigger reclaim and a writer should not
> > assume that a successful write indicates that the usage is below the written
> > max value.
> 
> Sent too early. One of the reasons is that cgroup is hierarchical and there
> can be multiple delegation layers and if you tie application of configuration
> to immediate enforcement, some hierarchical control actions become racy and
> awkward.
> 
> Here's an example: Imagine a system agent trying to lower usage in a subtree
> which contains multiple delegated containers. If max can be set below what
> reclaim can achieve immediately, it can just set the max and if the usage is
> still too high, can go around and e.g. kill some of the containers. If max
> write fails, it'd have to kill and then try again and inbetween someone else
> might push up the usage.
> 
> Thanks.
> 
> -- 
> tejun

Hi, Tejun.

As far as I understood the patchset, it doesn't fail the write if it fails
to reclaim. It sets the new max, then, if the write is blocking, starts
reclaim and eventually returns after multiple attempts. But it still
returns success.

So I believe this is behaving as you would expect.

Regards.
Cascardo.

