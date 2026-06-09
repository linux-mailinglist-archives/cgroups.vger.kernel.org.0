Return-Path: <cgroups+bounces-16788-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ewpFAd03KGpxAQMAu9opvQ
	(envelope-from <cgroups+bounces-16788-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 17:57:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D56620FC
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 17:57:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Vu2RYFPj;
	dkim=pass header.d=redhat.com header.s=google header.b=tY13qfqf;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16788-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16788-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 641213057FBD
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35984963B1;
	Tue,  9 Jun 2026 15:46:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBB4949F1
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 15:46:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020013; cv=none; b=kJc/H8YA9VezMYB+647m9jaYZjWltQLTwfjL8wR1Wzp1SBMY1eCbVv7Mo+os2KtrbAW6cu9brLXdhyzXvWalVMv9kBZ6a8Sv2P694TT+2pERtjGb8kfZMvhJWB0EBWSBuHSPRXFxHo1GhYH5i+WieyT7z4fXl/LX3L9oUPASaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020013; c=relaxed/simple;
	bh=+10onJO+W5BOSXLmXSI1bLQs3ISBGVQreNFwTxRYx7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4f1PMU31xKlxMG1YVkAuSTsRSeXom72nDxl2V6hi2tBKPakYle5+oVlXCO/ttenSdLAgM5CNiRAZk8Unk+ArYYdhWzIToStB21WhaF/5z6SU+qiNhiisqa5NEk6Ex3EROk+nVvVa8RVfuqefa8OyRj8hQNx8oDLhRC0HdLc4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vu2RYFPj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tY13qfqf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781020011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wA//FI/2V4/dhiJOqrsJhgwbCCnYt4JC9cGle24iCFY=;
	b=Vu2RYFPj2/JytsEEvN0Dl7QlqnNbFOn31CTJ7pqdueYj0uupM+u7EyopFsSIdGjO4WUM4b
	Y42PvRWNkK6KsAJgVO/HZ7bJBLODQmtU9q05oOuExjqmTLykcH4bX0eMgAcO7AAhoO3cBD
	Ahwlzu0BGUnNty0ZmvWRgdwdsKc+P1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-a-6_y9YjPXGPjE1j5H6ylQ-1; Tue, 09 Jun 2026 11:46:49 -0400
X-MC-Unique: a-6_y9YjPXGPjE1j5H6ylQ-1
X-Mimecast-MFC-AGG-ID: a-6_y9YjPXGPjE1j5H6ylQ_1781020008
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso26514905e9.1
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781020008; x=1781624808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA//FI/2V4/dhiJOqrsJhgwbCCnYt4JC9cGle24iCFY=;
        b=tY13qfqfUUGy0jDTnuFIpDwV/4miJc6gcpoMCs/Q92bS19nCXhBuht49alnOJGFI05
         6ThDD9oE096JETGnszlehtPcpEE20e7cdri36jy8MJFaI48JsK5fnNHSmjv2nUFeHiJ+
         pUy266dRgJflZOl2UpCZkucVcofrqTAL6IJRhb2dpAIWPq8Crc036f10vc8e2v08OlBj
         eNCKoyaGo05Infr5ymr9mTsJjoc5l99Gml+Aiar5JjPkzfxfH5Iep/k5TgdfGzDD4jAi
         S2X7SksIpX7j08fpLmbeLPf9bVUahvvBYDEu0twny2n4WYyG1SLYEtPwPQEHkT1IgPuc
         bCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020008; x=1781624808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA//FI/2V4/dhiJOqrsJhgwbCCnYt4JC9cGle24iCFY=;
        b=nOdA3JEXPnB+iqA0510EMsr7aUFSXdJqzHwwFdzqbukCp1HsmOXfLKbfPlQlaS2dUR
         ygB9IW84C7/0XostBWfCCz/T9OfC1CTh/oXF+SAutMR60YpsMGi3BpbrCkO8X1bd7Q7q
         E+P5wo1BEjnFmHmEoA0oRVISmjnCSTtupap/m2l0FsOry0SFNq7NcjZ9AAnts8RztuDJ
         u2eQ/pulH8AEw4OsYfZOfmA5TOD7/h8HjOIb/KT/ni2I09Cfneap1IrgmKsXRHrJtlkg
         gZL7oD4S9maxitbFizIptDvhfT4t7ZzqOwcUnNkSEFHf82PGqBA1JeMtcAXtYTOm0wM+
         wDRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aIKxcn9Au3LKEZLO9ZhhMrvZ4/X4AfeuGRbkzvuK4Xxt43dHHganS8X38LmY2PyjwIDChO0R8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Fy3yd/cHsjQaov7Fjnut9ycE+2JS5KfrMTz2rae1S1TMEOor
	A4hDGbKarc6tJdtDAL3MFfmx7yTCXwgVTlS/GIz0rzRNSN0sO6YN78ZM6Q4ggUB6NYsW+PtoOVB
	nY36dD5ONWjGHopo4GStXh3uNujm5y8TjCEcn7XSMRDNkdT23ZSPxEISykbk=
X-Gm-Gg: Acq92OF9a/Vwts9x2UdOpWyx0CMkCp8WiKOmGDpTF/TDmJMAYerSrMoHRthpXLuB+0o
	4f40+n8WJzDPFkC2l4BysvY4Voxi8wr4NqO5KCUAPh7TbPAQ1y5ST24Xugzvgqj5D0bKTjdLxvr
	RQvO8OLpR2+0b/ZoDTmr3HmBA6LYhl8jDrZfGOdVbDcY+CGQdCW9VWBp9nNlj1xPX9+3qfcxeEZ
	B3co27LXsTb0Di2HPB8k39gs/k/4A/wcZan/Rp7QW6kt2kXjcLuaND/xCb8PmgLpKg2zY/0FJ1c
	N6hm///YxkLcIFyFjByVWvXxUPhQT2k6NCj/GEv7KSXhiL3CCSS40tP2g152s/Q7rtWFtKEwzDO
	xfuPm6HxI2KCPQvqU4Tx3vWAc8jCxgRO8W3gNzTq/CW4tcbV5VA+NhnBP24ApgiM=
X-Received: by 2002:a05:600c:870f:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490c2624a03mr331518455e9.30.1781020007801;
        Tue, 09 Jun 2026 08:46:47 -0700 (PDT)
X-Received: by 2002:a05:600c:870f:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490c2624a03mr331517885e9.30.1781020007355;
        Tue, 09 Jun 2026 08:46:47 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.95.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm522410715e9.12.2026.06.09.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:46:46 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:46:44 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Message-ID: <aig1ZGEq0Vr0qLzl@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16788-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lwn.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 935D56620FC

Hi Yuri,

Thanks for sending this out.

On 08/06/26 14:15, Yuri Andriaccio wrote:
> Hello,
> 
> This is the v6 for Hierarchical Constant Bandwidth Server, aiming at replacing
> the current RT_GROUP_SCHED mechanism with something more robust and
> theoretically sound. The patchset has been presented at OSPM25 and OSPM26
> (https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
> be found at https://lwn.net/Articles/1021332/ . You can find the previous
> versions of this patchset at the bottom of the page, in particular version 1
> which talks in more detail what this patchset is all about and how it is
> implemented.
> 
> This v6 version works on the comments by the reviewers and introduces the
> following meaningful changes:
> - Update to kernel version 7.1.
> - Refactorings and general cleanups.
> - Removal of substantial duplicated code.
> - Express more locking constraints in code.
> - New cpu.rt.max interface.
> - Refactoring of migration code to reduce code duplication.
>   The new migration code now reuses the existing push/pull and similar functions
>   and specializes where needed, substantially reducing the footprint of group
>   migration code from previous versions.
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> New cgroup-v2 interface:
> After extensive discussions with the kernel's maintainers, we have built a new
> interface to support HCBS scheduling. Since this will be a cgroup-v2 only
> feature (the fate of cgroup-v1 old RT_GROUP_SCHED has yet to be decided), it was
> possible to drop the original v1 interface entirely and create a completely new
> one that is similar to those that are already existing.
> 
> Every cgroup has now two new files:
> - cpu.rt.max (similar to the cpu.max file)
> - cpu.rt.internal (read-only, not available in the root cgroup, it may be
>                    removed if deemed unnecessary, see later for details)
> 
> In this new interface, HCBS cgroups may either be set to use deadline servers,
> and thus reserving a specified amount of bandwidth, very similarly to the
> previous system, or can delegate their FIFO/RR tasks' scheduling to the nearest
> ancestor that it is configured (default on group creation). If the nearest
> configured ancestor is the root cgroup, tasks will be effectively run on the
> root runqueue even if their cgroup is not the root task group.
> 
> This means that subtrees are allowed to retain the original non-RT_GROUP_SCHED
> behaviour, scheduling on root, while the feature is nonetheless active. In the
> meantime other subtrees may use HCBS, and the whole hierarchy can coexist
> without issues.
> 
> This behaviour is specified in the cpu.rt.max file, which accepts the string
> "<runtime | 'max'> <period>". A zero runtime disables FIFO/RR scheduling for
> tasks in that group, a non-zero runtime creates a reservation and uses HCBS, a
> runtime of 'max' instead tells the scheduler to use the nearest configured
> ancestor for the FIFO/RR task scheduling.
> 
> The admission test now does not only check the immediate children of a cgroup
> for schedulability (recall that a group's bandwidth must be always greater than
> or equal to its children total bandwidth), but it has to check its whole
> subtree: if a child delegates its tasks to its parents (runtime = 'max'), then
> this child's own children (the grandchildrens) are effectively viewed as
> immediate children that compete for the same bandwidth of their grandparent, and
> so on down the hierarchy.
> 
> To support both threaded and domain cgroups, the original test that allowed only
> to run tasks in leaf cgroups has been removed: this is already enforced for
> domain cgroups by existing code, while this must not be the case for threaded
> cgroups.
> 
> Since groups in the middle of the hierarchy can now also run tasks, their
> dl_servers must be configured properly: a parent cgroup dl_servers can only use
> their assigned bandwidth minus the total of their children. The cpu.rt.internal
> file reads exactly what is this "remainder" bandwidth. Since dl_servers must
> have a runtime and period values assigned, the period is taken from the user
> configured cpu.rt.max file and the runtime is computed from the remainder bw.
> This runtime and the period are the values shown by cpu.rt.internal.
> 
> Supporting both threaded and domain cgroups also dropped all the extra code
> related to active and 'live' cgroups as mentioned in previous RFCs.
> 

I started playing with the new interface and ended up with the following

bash-5.3# cat cpu.rt.max  (root)
10000 100000
bash-5.3# cat g1/cpu.rt.max
10000 100000
bash-5.3# cat g1/cpu.rt.internal
9999 100000

which looks odd to me, as nothing is running on g1 yet and no children
groups either. Maybe a rounding error of some kind?

Thanks,
Juri


