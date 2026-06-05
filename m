Return-Path: <cgroups+bounces-16676-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gMFoJuLwImoYfgEAu9opvQ
	(envelope-from <cgroups+bounces-16676-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:53:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45999649800
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:53:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dNxqloee;
	dkim=pass header.d=redhat.com header.s=google header.b=Q+HEcTwM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16676-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16676-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 645D730407C6
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADA3B8958;
	Fri,  5 Jun 2026 15:42:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB113B7AE
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:42:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674153; cv=none; b=hFCxUAEFIzEKtj8K5cXS+O8CDd9Pt2vAWMcek4nysROvoUZWkXbeAJ0i2JI7QIPUrN8DW8HWM8uX5jthL273Wg7zk1ixEnJOSZzDX6JtQj5CHU6CnZrSk9J9BM1DCAakRTlhup1tLDva7Q+878RLdx38HZqGwol2vgAtkWYGUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674153; c=relaxed/simple;
	bh=hNXMOCusmTiv9t8jBH97402lT0OFK1tPV6LcYWEcI0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhosVBOCRMO3HsdIb9VPJNOGPd4+M+gflCr1XWXmZgXwSXpSx8v0p8qoLUEwmSPXf8YPs+Yd8ovGUEh7TRcDKEgd53ms4ojrE/lDpzXuyD0Bq2R8QHALPA304i76HmVCZR7wuohF3wbLrDyIlxhKHuSkstoGoVjbUG11U+vu38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNxqloee; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+HEcTwM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780674149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykStheHWzMecvQlC8/orrpWH+CEGzXq9KPPg3CU9BFw=;
	b=dNxqloeek2jOdHxXMtB4u0Ij9oD662ickFNoMs74YXVK1ZWdr9qlE3V6VZq6mcuPo3ccAt
	l8RXivRVHfB0hknD86Gk4fkCxtNKcqkM5ZzfaEOEMnqcJxCsZTTew/z33e00RsdIr70wfg
	f9nw7il+Kws5OMSSc7U5tMqGUXb8gD0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-HcR9kLtYMYikITlNBKjX0Q-1; Fri, 05 Jun 2026 11:42:28 -0400
X-MC-Unique: HcR9kLtYMYikITlNBKjX0Q-1
X-Mimecast-MFC-AGG-ID: HcR9kLtYMYikITlNBKjX0Q_1780674147
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cea4854fe3so28264416d6.1
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780674147; x=1781278947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykStheHWzMecvQlC8/orrpWH+CEGzXq9KPPg3CU9BFw=;
        b=Q+HEcTwMSZGwipJDNevrJmq+OjbpOrsA78SyPVjkkw0DSCG8VzY1cUwbluO/8cwhj4
         lHmCtWuNpbTMFUW0OUS6joQeefT8aUj+cBM1QyhcZOOtvDMLJ5EpJniqwvWDRxEYmeUP
         +/0mwUgzndc08H3FeNvMAySqcrNSdbKksb7Th9cf9raFl8AxZpsrgkmSM2kKhB4BsN8j
         hvMLNGFlWACS7hIR3NKbec8/3HeLFKEnBShmJhsenkIMP/Elb/dvnH6mqQzIDnIeMCj/
         lldKC4ABYi2Nr6hlaQl2Ffle1J0JuGLUmQcEdsvpW1GhaY9Sp1gzDtx3FbmUPlX8ldLp
         JJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674147; x=1781278947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykStheHWzMecvQlC8/orrpWH+CEGzXq9KPPg3CU9BFw=;
        b=XpQ2/QLedLp8CCe99reOCxhmaC+T6lOUcJf45AxkQ5oJJwsvrE2ey1WK3UT1GQbCmj
         MVz6t12vfU/jpE/7URD60FTRaksMRh3T73eMXAsh3Dhr+3LQ4+0TGvPvAayz4OfYJnXc
         e3HYp7BLki9Kc8Dt4Bqr5v0b2D5ylNdcSM7whGJJfY6omC9sC+vR+CWlREYl5Dw8g7Di
         AoP9vCe79vttAzYae1d1rGlB9LfLxenkryO5l/oJeOh6jCJ7PR+0b6dYpmHyFBgSty7z
         v+EIRNCzOiLSH1M2iPIL67GiiDNb3//HB2Ey71pcTV2kg8sn8tuEaz6h7YEjMLmIKYB5
         dG/w==
X-Forwarded-Encrypted: i=1; AFNElJ+l1z94GqQZnhTidHLIzRvlgSb0fFocNeIKfmkY3Mo59xngbNkS3Lc3VIj49hL6ORvU+WDOt74+@vger.kernel.org
X-Gm-Message-State: AOJu0YyUc0Yjm2eFilK5l6QhViF9uZnpUT36xY4qjtRW72+wgAvC4kKw
	WbrdmRTR8rEpQs6IuGkmMtPwyBTux+IL+7Hx3EAho/Ppj8XErBtYykac2qWUz4J0pDwtdle1d2l
	4Bpy/ntmg2fZy99H1jRWiX+OXF0vKw2g3y03yaP1ryyo1e3gYqbzudNZoy4E=
X-Gm-Gg: Acq92OGxWqtHZv+CKn3ciTzWbZV/yz/UPdtmUiLag0x4jDY6dN4dPgNPQvk/4cai7CG
	JklqnMzu8dat3mubtNnApNMCr9g5BoeH6cUS1d4drutSBTUeE4s2aU9y4ADnwAxrB2ICBtP4tUG
	fBoxbDJUtPhDNer+bzoNmOcMTxJyQ88BCMGZ776lW4Ws4ygCsBeDfnIQuMPTzlR9Xytl7XGEyuE
	4bc2N7ZTKYH2B74479hg4cqAG0CnXpjdgW0BBiUCM36L4vIbXhF9HfxMa3bE1aeVF6bubGl6Bws
	+E6eukZHVRore2b6q9CTkgt/GtqlMXzficJdhHlJ3Vq4oLZTrypoHLKAwUTlVaTbjC3xC/yTIxm
	zJh8o2HdZBJ1nHN81HAJ6gl8umTDv/StpMZgxp8+yQX6JW5eKbWt2Xv2ohQztHK55QnhdLiNwXx
	l2
X-Received: by 2002:a05:620a:f11:b0:915:8f08:5f9d with SMTP id af79cd13be357-915a9dd4bd8mr792214585a.56.1780674147341;
        Fri, 05 Jun 2026 08:42:27 -0700 (PDT)
X-Received: by 2002:a05:620a:f11:b0:915:8f08:5f9d with SMTP id af79cd13be357-915a9dd4bd8mr792205585a.56.1780674146859;
        Fri, 05 Jun 2026 08:42:26 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d2384sm921805785a.39.2026.06.05.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:42:26 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:42:25 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <aiLVbQPxK1qI1h4p@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain>
 <ahXKFYBdCMDBvc_N@x1nano>
 <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16676-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:tjmercier@google.com,m:christian.koenig@amd.com,m:mripard@redhat.com,m:aesteve@redhat.com,m:airlied@gmail.com,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[suse.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45999649800

On Fri, Jun 05, 2026 at 01:27:09PM +0200, Maarten Lankhorst wrote:
> Hey,
> 
> On 5/26/26 18:59, Eric Chanudet wrote:
> > On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
> >> Hello Eric.
> >>
> >> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> >>> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> >>> configure whether allocations in a dmem region should also be charged to
> >>> the memory controller.
> >>
> >> This kinda makes sense as it is not unlike io.cost.* device
> >> configurators.
> >>
> >> Just for my better understanding -- will there be a space for userspace
> >> to switch this? (No charged dmem allocations happen before responsible
> >> userspace runs, so that the attribute remains unlocked.)
> >>
> >> (I'm rather indifferent about the actual double charging/non-charging
> >> matter.)
> > 
> > Yes, this is intended to be configured before the user space stack that
> > would start allocating things is started. Once it has started (and tried
> > to charge something), the configuration is locked
> > 
> >>
> >>>
> >>> To handle inheritance, dmem adds a depends_on the memory controller,
> >>> unless MEMCG isn't configured in.
> >>>
> >>> Double-charging is disabled by default. Once a charge is attempted, the
> >>> setting is locked to prevent inconsistent accounting by a small 4-state
> >>> machine (off, on, locked off, locked on).
> >>>
> >>> The memcg to charge is derived from the pool's cgroup, since the pool
> >>> holds a reference to the dmem cgroup state that keeps the cgroup alive
> >>> until it gets uncharged.
> >>>
> >>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> >>> ---
> >>>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
> >>>  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
> >>>  2 files changed, 178 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> >>> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
> >>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>> @@ -2828,6 +2828,29 @@ DMEM Interface Files
> >>>  	  drm/0000:03:00.0/vram0 12550144
> >>>  	  drm/0000:03:00.0/stolen 8650752
> >>>  
> >>> +  dmem.memcg
> >>> +	A readwrite nested-keyed file that exists only on the root
> >>> +	cgroup.
> >>
> >> Strictly speaking this is not nested-keyed but flat keyed [1],
> > 
> > Indeed,
> > 
> >> which leads me to realization that this is the first instance of a boolean.
> >> All in call, such a composition comes to my mind (latter is RO):
> >>
> >> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
> >>
> > 
> > So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
> > and match the documentation, thanks!
> > 
> >>
> >>
> >>> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
> >>> +				       size_t nbytes, loff_t off)
> >>> +{
> >>> +	while (buf) {
> >>> +		struct dmem_cgroup_region *region;
> >>> +		char *options, *name;
> >>> +		bool flag;
> >>> +
> >>> +		options = buf;
> >>> +		buf = strchr(buf, '\n');
> >>> +		if (buf)
> >>> +			*buf++ = '\0';
> >>
> >> I recall there was a discussion about accepting only a single device per
> >> write(2) (at the same time I see this idiom is still present in other
> >> dmem.* files, so this is nothing to change in _this_ patch).
> > 
> > I would second that. When setting say dmem.max for 2 regions, with a
> > typo on the second, the first one is set, but write still get EINVAL.
> > 
> > Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
> > not found (this patch returns ENODEV).
> > 
> >>
> >> Thanks,
> >> Michal
> >>
> >> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format
> > 
> > 
> > 
> 
> Perhaps a bit late, but before we start adding this UAPI we should enforce a
> single region per write?

I can send that separately, although that is a UAPI change. Is there any
user that would be affected?

This series is hung on charging memcg using memory objects from the
context of dmem, when at that level of abstraction it doesn't have
access to the underlying pieces that were allocated.

Best,

> 
> Kind regards,
> ~Maarten Lankhorst
> 

-- 
Eric Chanudet


