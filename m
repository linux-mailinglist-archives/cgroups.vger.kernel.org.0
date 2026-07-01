Return-Path: <cgroups+bounces-17417-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9+OsEGvXRGqb1woAu9opvQ
	(envelope-from <cgroups+bounces-17417-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 11:01:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2046EB68B
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 11:01:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HpugBb5z;
	dkim=pass header.d=redhat.com header.s=google header.b=AcgSZHFH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17417-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17417-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91DFB3022B3F
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B234CFC6;
	Wed,  1 Jul 2026 09:00:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B303B19BA
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 09:00:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896454; cv=none; b=WU90M4h/q0yaKIheENDFRTT0kVYHDUz79SEo9ZRfqWJ6sNtxnBryYAsr37CTzrjmuKm4BGND5ZVJ6TAYqkitaNet70en68wXeP6D+QgQdCR3vgrObj2NUfxKSk4q99B1MahQGvvxjBAU5Jc1NiBL8q1i7N2nxciThLoOkqEy7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896454; c=relaxed/simple;
	bh=H2yu1v4BLA1CXFpBBWR+UOBqEFBs+Yl1kR9v6PncV2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM1r8UMekjvR1thKmR7tVWhfnaxUO2oCFPlCgUaLcI416R95AsJounG8FoyZIRDteD/5+8fWHvvZLFsPlFabLAVhTb2m7U7mLGC3h7BYslBKBiH029QdDNNl8bSfuCNR1nYaib+9OkmcaJn3kU2M7V5rjd4GOpiO9tkp4QAonE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpugBb5z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcgSZHFH; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782896452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aun8Zor665Yj5HaVE7uoEpAdyksulZLzu/u1QogbXXQ=;
	b=HpugBb5zNGCVi1tk0/oMPkJgAQBFc3LTIg0one9DcS/STwXX3M3qZXoqP49kTgtY5iytL1
	Qibs0lgTEW26YWCGc6JYJTKc7xLdfeiwqk+mn9vPaugG8H/75USw8XDVDSUIWOrBduO1CO
	fHOVeP63/fHdnSP16WesPYkZn41gMiA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-NBxchJwDP_qqOnHNtfHZ8g-1; Wed, 01 Jul 2026 05:00:50 -0400
X-MC-Unique: NBxchJwDP_qqOnHNtfHZ8g-1
X-Mimecast-MFC-AGG-ID: NBxchJwDP_qqOnHNtfHZ8g_1782896449
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47162f83c75so1108467f8f.1
        for <cgroups@vger.kernel.org>; Wed, 01 Jul 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782896449; x=1783501249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aun8Zor665Yj5HaVE7uoEpAdyksulZLzu/u1QogbXXQ=;
        b=AcgSZHFHdgV3kDomlTZHmpE9Jaz5dW8eWT837nxtoXfC7mKvbdZPQIN3nhOD/rKNJq
         rqucvzZr/ji7e3YOuGSUhzGVJUCYMh8cAPUDfBApk1IzxaNXuHTBWdQUwyeJxmF3RMmW
         o78Z9iLKl7hJLGE3Hm1vzKgPoHY2vlQ0Akc+Y7NeCGoB2L5K2dJFAmJWMkpkwYMCjNpk
         gWR7c3wxdkWij+n1LbfcKBnEYgWyjxdjZ9B/10qsD9HoTp8R1bwW/Dlc5if3pWGAxphc
         AyQPTE9A95zQRua8D11YnysjQFtrrS+mcLOPxQlY/vWlZ97RjJExa5tl3huHswRKEVDg
         sujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782896449; x=1783501249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aun8Zor665Yj5HaVE7uoEpAdyksulZLzu/u1QogbXXQ=;
        b=GGoKqInOxUDdCd5jslA0t3xsjoY6xe8mnFP0FH/WshoC0TWTJSSp0FaOqfDf5kKv6k
         KX/KW2xXxXfca9R5C0gMszOc846GRFSyh8wAG3ZqBEsjopvQYlcBXTu0Y3aXX0qVnMOO
         YtQ8ZlZ3beQjMM8Ug/A9xIatBo3CViHwF3L7mqnyCJ4XooWgvOwJXlqw77BKPf6URzLL
         ET9E2nVZed+QJpAepUUdJoh/PgMJucgazT1WCoAOsYvyVPghHiYjFO0vX7BDiVItd1rm
         IPqeb7M4c1CyY2AhCt8SnmpaN0Oyc4oXzhxO+LrDbM80VDQfnr0mB6tKsamDHTubV/rY
         tptQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDtyDH5ChnMe+XaI0QiH1GK5S/FrGmu47lUdd7fO5MQOWJ+ca4guqrIp8Nfo4YEHcYd6ZbLV+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sNar4uGW+g5LZTXiTUi+JHq+pZiZe/3Y9jKpmeP0i6AmMIvH
	GtvgNghVYeo7J3doc+eT/FXhnrWZXtmg97rdBcQwBdDVps9mLsQELSvphgH0mFiHIgn9skQpJdS
	/YsvJCvI19msFtf6pmkEmf0rNukN91dMndYjUOj78sp1IUDQ2Y9Yxa0iglTU=
X-Gm-Gg: AfdE7cmy0yRmdKAp21KTKVQL11KxFKWLjns+HXzoSwDLJByVD8nbAAn0K4SEtlZiy6q
	ZM1IdNlIUiAWs2AGmQ+PIx7TWyG57e/tN7mN8OjMiaAPQmWhzi3wduNI0QA9WITHmF70Cj7PRkZ
	T2K3EwtmkYEShNGrXu7qO9anbmh+z7vaOsOdbb1wy7PG/x9KsGEfeuhJ0rbFHlXD3bEaZ0+usLG
	a30tEy9cKu8uuRm3g3uHir+IxUjUpTQQwg7CRkykSIZbKeoKA51ZkppVCAGgB6RRJatmWpMLFRH
	vdNnb7Qy06yULB8Z8egrD8ytlol6AA4v+/V7XCObAh037W5H0lNqcKuGrJMSUy05jA0JoZdxYGf
	Fg4/koYJHnveu8A5NOhOqZvOJ//zrp0pGBlFXz4ymYQ==
X-Received: by 2002:a05:6000:2c04:b0:475:f0c2:75b3 with SMTP id ffacd0b85a97d-477469108dfmr1356077f8f.30.1782896449030;
        Wed, 01 Jul 2026 02:00:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2c04:b0:475:f0c2:75b3 with SMTP id ffacd0b85a97d-477469108dfmr1353851f8f.30.1782896433637;
        Wed, 01 Jul 2026 02:00:33 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.133.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475643ce016sm15420805f8f.16.2026.07.01.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:00:32 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:00:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>
Subject: Re: [PATCH-next v9 01/11] cgroup/cpuset: Make nr_deadline_tasks an
 atomic_t
Message-ID: <akTXLwtz_pYM79wk@jlelli-thinkpadt14gen4.remote.csb>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-2-longman@redhat.com>
 <akPMKXppWM74-m9a@jlelli-thinkpadt14gen4.remote.csb>
 <e4ab9944-4687-45be-9935-4ad29f2a923c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4ab9944-4687-45be-9935-4ad29f2a923c@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17417-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA2046EB68B

On 30/06/26 13:56, Waiman Long wrote:
> 
> On 6/30/26 10:01 AM, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > On 29/06/26 23:33, Waiman Long wrote:
> > > The nr_deadline_tasks variable in the cpuset structure was introduced by
> > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > in cpusets"). It is reported by sashiko [1] that nr_deadline_tasks
> > > can currently be modified by inc_dl_tasks_cs() under rq->lock and
> > > by cpuset_attach() under cpuset_mutex. So if both updates happen
> > > simultaneously, the nr_deadline_tasks variable can be corrupted leading
> > > to incorrect operations down the road.
> > > 
> > > Fix that by changing its type to atomic_t so that nr_deadline_tasks are
> > > always atomically updated.
> > > 
> > > [1] https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.comk
> > > 
> > > Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > Looks like Sashiko is yet not completely happy with this:
> > 
> > https://sashiko.dev/#/patchset/20260630033344.352702-1-longman%40redhat.com
> > 
> > I actually wondered the same and couldn't convince myself we don't
> > actually have that problem with the window between sched_setscheduler()
> > and cpuset_attach(). If issue is confirmed, not sure if wait_attach_
> > done_lock() could help here as well? It's kind of a big lock for the
> > scheduler, but maybe only affecting DEADLINE tasks and if migrations
> > are ongoing.
> 
> Yes, I am aware of that. This patch can only partially close the race
> window. It doesn't completely eliminate it.
> 
> My current thought is for inc_dl_tasks_cs() to check if the in_progress flag
> is set. If so, it sets another flag for cpuset_attach() to double check the
> DL data for consistency. It will be a rather complicated solution in order
> to eliminate the race window. So I am postponing it to a later time when I
> have more free time to think about it.

Ah yes of course, makes sense.

Thanks!
Juri


