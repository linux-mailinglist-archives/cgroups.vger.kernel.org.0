Return-Path: <cgroups+bounces-17419-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJ6DFhUnRWqe7woAu9opvQ
	(envelope-from <cgroups+bounces-17419-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 16:41:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2456EEE1E
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 16:41:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=egd6NTNW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17419-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17419-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE55D31B90EB
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D7348C66;
	Wed,  1 Jul 2026 14:22:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D322348452;
	Wed,  1 Jul 2026 14:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915727; cv=none; b=JHPCB+0lEMZRXsY75jGkkBukO0w9e9j0APdA6IZA++ZBO/PnSKzUkHWs1IQEEXOE+skWkZ/BOKAoWCNsX9RC/HmqyIq2dsU3HXS5dcNgrHqnjcej5qY2mpxCOxg02/5wHagv9np1R/fdKsGkhlfM2M2/EtzQidrfrPEfDmoeOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915727; c=relaxed/simple;
	bh=lYdYxddkKaXAYI0lbyyxE+u0FDMuUS4iSrMobIVPzQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBnPKI7hxJx38SnLku6dwz36UrNFa8crq1XOarA98X/JZYpGD7mnA4xePRoevBMtV7QznhZv1zEaQWHcCrCHcAxB4tzUDzlbPVJG3flT5G2e5AlH1P3VSVLD1q6a1rH3yKbh3paFgCFBzQqe3cVWVeoBsOM19pGxE7Pz2LPN5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egd6NTNW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772701F000E9;
	Wed,  1 Jul 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782915726;
	bh=cRI1PA2pu5QJH1eE87wRBUVd69isoG9HzWJnAWKnqi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=egd6NTNWj1Yi7DNk5o8DxgqPi0HYnbPxqm7HSrOPIMRXyaq3SN3MRooPKfOIiAdy4
	 REkuC7QUuV2JHHPautTWgyUwuMzN9s6EgMeap73xmXSg1q1dgOOrQLy/N8f83hEFQX
	 ZKRXI/5tXDZe5DryqtErLYy7dlntgUAPb93QB2yv5nQEcNqFQmnTpzCPsv4Ze0toqI
	 9sFRjtIuCyL7hzROawj1nA3rK/gvABbNzCsAXk0bP+zHFKBxwt2eCOXUZbET2VkxVV
	 dBC2yG4ker1FHpl17/zglyfehsahujb/Nj0LStnrw5sL8hWyznOUBepglYrviAaF5l
	 1OdPnYqs7QAtg==
Date: Wed, 1 Jul 2026 16:22:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
Message-ID: <akUii2CyEi7SRid7@localhost.localdomain>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260624063404.2106807-1-realwujing@gmail.com>
 <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17419-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,chinatelecom.cn];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,localhost.localdomain:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB2456EEE1E

Le Thu, Jun 25, 2026 at 01:27:54AM -0400, Waiman Long a écrit :
> On 6/24/26 2:34 AM, Jing Wu wrote:
> >    3. Are there specific patches in your series where you would welcome
> >       our contribution directly?
> 
> I have broken down the shutdown callback into separate portions as suggested
> by Thomas. The other major change that I am working on is to try to shutdown
> to only CPUHP_AP_OFFLINE state instead of all the way down to CPUHP_OFFLINE.

What was the reason for that already? Can we perhaps ask the user to offline
the target CPUs before toggling isolation on them?

> That will require some adjustments to the nohz_full related hotplug
> functions. I have some ideas of what needs to be done. However, I haven't
> looked into RCU yet. I know RCU support changing the nocb mask for fully
> offline CPUs, I will need to find out if it possible to do that for
> partially offline CPUs.

No because callbacks can still be enqueued at this stage. But we could
manage to make it work with CPUHP_AP_IDLE_DEAD.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

