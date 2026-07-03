Return-Path: <cgroups+bounces-17473-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SBSIum2R2rOdwAAu9opvQ
	(envelope-from <cgroups+bounces-17473-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:19:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74B702C71
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:19:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QOE+X9Tc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17473-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17473-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B2513026AEB
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090703D6484;
	Fri,  3 Jul 2026 13:19:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF553D45C1;
	Fri,  3 Jul 2026 13:19:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084773; cv=none; b=hW6dqwlNeqOvlrGboRFIhNFtlpIzP/YZedNEBXkUbNx1eflRTpQ3p5O6UZAj49SNIeG0XGnLu5JjwwfX/sG+o0lNW7vv5Be77Z37kf8XxE14FtOXA6Ab+ohZU+/5RNX+gvg8ak8Co28OitpDBXZw9rBC/xlem5p8nyZrbNQuSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084773; c=relaxed/simple;
	bh=SybsfnBwWh6wNYO6K17YybWLHNe2wFkmCwK5CiUpNw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqKv/Q/JW7yWA/IBNdU5YL0Aiw+GJMJS/fXgcyo7Qv/VDGQXSka55y0BLQ+iLCxImH9r5Z6BNoqGdNLc5LPP220vxAKVm9CYw0o18voLss+N1JCRPrvSlZKS3AZb2x6PYzt2ScivcXeH0bXohXD+wEw/6PfqqCVPGNZEOY6qCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOE+X9Tc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C41F000E9;
	Fri,  3 Jul 2026 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084772;
	bh=nQj/hR3UQosCLZxgAly99fHbBbLd46rIDcrsPC7zt0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QOE+X9Tc6w7Al+6bRdD2DCLmRFcVP3+Apmw+i8eugOlGjisfMQa7KfblbyOmJ1bgS
	 hwibJ4dstELm2Q++c9s1rXuAx5KlK8klqEc5gYTFi45Ow3239Cl843wnhFoQOAIj2+
	 E2moHoWghnK4DR2XdCbqrF2H09E1E/8UYuCAoaCKS4iSasC0Jq5Rpv6voChRUH0h7k
	 wXywDHjK+YiIIr/u1pRtDZ1HcUekQqxYMHKpjCWsAZV4h0yg9LBK9T6YXNBrMekQNl
	 Q7HpGNGpyvLwtGYpR9rxY+OQWlbcrz68J/3lyyMecJu4tIg43kYWthZ6d4McEmnZ5Q
	 aF7C+y7vWCbEQ==
Date: Fri, 3 Jul 2026 15:19:29 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
Message-ID: <ake24SbeTjPo7zXT@localhost.localdomain>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260624063404.2106807-1-realwujing@gmail.com>
 <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
 <akUii2CyEi7SRid7@localhost.localdomain>
 <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17473-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E74B702C71

Le Wed, Jul 01, 2026 at 02:56:34PM -0400, Waiman Long a écrit :
> On 7/1/26 10:22 AM, Frederic Weisbecker wrote:
> > Le Thu, Jun 25, 2026 at 01:27:54AM -0400, Waiman Long a écrit :
> > > On 6/24/26 2:34 AM, Jing Wu wrote:
> > > >     3. Are there specific patches in your series where you would welcome
> > > >        our contribution directly?
> > > I have broken down the shutdown callback into separate portions as suggested
> > > by Thomas. The other major change that I am working on is to try to shutdown
> > > to only CPUHP_AP_OFFLINE state instead of all the way down to CPUHP_OFFLINE.
> > What was the reason for that already? Can we perhaps ask the user to offline
> > the target CPUs before toggling isolation on them?
> The major problem about fully offlining the CPU is the CPU hotplug stop
> machine mechanism which put all the CPUs except the CPU to be offlined in a
> waiting loop within the IPI handler when the offline CPU is transitioning
> from CPUHP_TEARDOWN_CPU to  CPUHP_AP_IDLE_DEAD. If there is another active
> isolated partition running DPDK, for instance, it will break the low latency
> guarantee for a short duration.

Looks like a long standing problem that does not only concern nohz_full
but also RT in general.

I made a proposal a while ago to solve this:

https://lore.kernel.org/lkml/aQuNdOEmPYkI03my@localhost.localdomain/

To summarize, we could remove that stop machine thing and have this on the
outgoing CPU at CPUHP_TEARDOWN_CPU:

    set_cpu_online(cpu, 0)
    synchronize_rcu()
    migrate things // call CPUHP_TEARDOWN_CPU -> CPUHP_AP_IDLE_DEAD

And on other CPUs the usual should work:

    preempt_disable() // could now be replaced with rcu_read_lock()
    if (cpu_online(target))
        // do things
    preempt_enable()

There are a few dragons on the way in the update side but nothing unsolvable
as far as I checked. Of course we must check all those callbacks one by one.

Also on the read side we must be careful because:

    rcu_read_lock()
    A = cpu_online(target))
    B = cpu_online(target))
    rcu_read_unlock()

We can now have A && !B but I doubt many callsites do that.

> > > That will require some adjustments to the nohz_full related hotplug
> > > functions. I have some ideas of what needs to be done. However, I haven't
> > > looked into RCU yet. I know RCU support changing the nocb mask for fully
> > > offline CPUs, I will need to find out if it possible to do that for
> > > partially offline CPUs.
> > No because callbacks can still be enqueued at this stage. But we could
> > manage to make it work with CPUHP_AP_IDLE_DEAD.
> 
> If we can only go as high as CPUHP_AP_IDLE_DEAD, we may as well go down all
> the way to CPUHP_OFFLINE as stop machine should be done at
> CPUHP_AP_IDLE_DEAD. In that case, we may have to break RCU out from
> HK_TYPE_KERNEL_NOISE and add a cpuset control switch for the system
> administrators to decide if they are willing to suffer a brief latency spike
> for an existing isolated partition or keep the RCU housekeeping mask
> unchanged to avoid that when creating a new or destroying an old isolated
> partition.

Halfway nohz_full doesn't sound good...

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

