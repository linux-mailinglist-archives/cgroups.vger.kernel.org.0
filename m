Return-Path: <cgroups+bounces-17404-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cSbwFlbNQ2pQigoAu9opvQ
	(envelope-from <cgroups+bounces-17404-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 16:06:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56526E5364
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 16:06:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=F+g8bPpx;
	dkim=pass header.d=redhat.com header.s=google header.b=pPZD5fGJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17404-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17404-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6413066263
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD32236FD;
	Tue, 30 Jun 2026 14:01:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4911CAF
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 14:01:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828084; cv=none; b=ao/zLstEU4Ej+R+Xt4SI+rk8eZK1lqVACcwqvAG+0vQDuzflJ9jqQs4OCF+AHxEk6kJGYtZQg0ZcC+5nIi2Sw7CMaQ4QilPzJCOJknkiyK9jV8cpqvxwscR/2+Ct3N1GB153hzrGIUyXLKmISq9lXISdlj4lCcJPAYhlCrJcfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828084; c=relaxed/simple;
	bh=QF5ZIU+eSuGBSWH3Y7w253rOOR0PTkKglaTKtKLVVAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxt5JicOnJgpKwirsGki8mAJXfAxhJMDuO1r+TR5IJhMK3NR+LXG1f/TLyJ4gvo0kNY14yd7Z50Tf07pHBjpvOSHTD4MeR5kRqkm0AQ17hBGM3truo0ncq7ajsa1sEFJjqjqVksRKuVVA4BcqEaO/pqnwx1LhzF7U4TGUBoGcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+g8bPpx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pPZD5fGJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782828081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vL1cQBm4V9bkdhZZPfpOnFBHfOM80jV2SOxmu4s9TC8=;
	b=F+g8bPpxESz6AKjxLzosGUcj5Ys0FPPhOhv9JzjMwHl7BtjcywfnOLJHJDB6g6e3YAUop3
	OXSYH8/hRx2SnZseVzIf0/02qU+sxX7C003fdO2YagV2ss45ETnFSL/qfVHgWMOwz1r4mo
	8JxmekMvR4ITbjHxFI1DSZ6K6Y+ArN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-kyi0Vl0iNVWR_hDzF-CrGw-1; Tue, 30 Jun 2026 10:01:19 -0400
X-MC-Unique: kyi0Vl0iNVWR_hDzF-CrGw-1
X-Mimecast-MFC-AGG-ID: kyi0Vl0iNVWR_hDzF-CrGw_1782828079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a060eb84so34068145e9.0
        for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782828078; x=1783432878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vL1cQBm4V9bkdhZZPfpOnFBHfOM80jV2SOxmu4s9TC8=;
        b=pPZD5fGJhKrb+98lyFVkxTrcjbfZvmFB7XFcZQn74ZyUSRkLgcLOYI8qqG0aA/JgY6
         RnujmuvVNiIzcrU+BtBKVg5wHABn7E2cMRQYEXA1kBmeKuo1s5GPeOazkcGxgsR6u0MG
         TfoiVdlbq4wdZwjYTN3xRCjCXoJYlMsyCYdZ2USyah+NiTu/fkPWSzRZEunKDifBFRZ/
         uDJJ0L9qDI7N82snwcmHJ2yFWY42kmezrNKwWNIQhVMC2oBkb2XAZqWid96L/WMTRgGG
         xDpXKCE/CbHRGCs2/pIDNwu5GLtatsZsUp1w3ClSxzkXAfOV63/9czncR+flFbWIbgM5
         r/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828078; x=1783432878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vL1cQBm4V9bkdhZZPfpOnFBHfOM80jV2SOxmu4s9TC8=;
        b=IxBA07Qjuxw8n3BkiM/J5ZYod9HcrNKDRiPNNYsohvwED7B5QL+4RIIIRNMu4T0haS
         npxfWfASgttAe3z4nHwSo089Orllzx+bHAHxcFLEpJsSq3RlIN9u0KiPtuPHU8SBm1vP
         OULc7V8K5JSoGB/mXlM84hsbRtZaxM1TBzci1dUvySoDAcEqR+zOMhzkRJ/PBBcYvqkK
         W2yIviaFKGxorUzR5nbCgR19JjuFLQu4t5udM4XxkzVHxt9MweFmtz9Hhrt986CdWcrE
         HbCfZrbDN2WBj1dcc59R1ixlxNx1v9OTi4tFfGaaR3BZTuoDeqIjoG/wIpjM/cbstYwq
         gigQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wyDHkmlY1rLzMlk5A7xuat39K7rzoG37YZPSFHNXNHcqoqLnp89UX8PNWtCAsgfA0uFxf8GBp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04oRUN5v098ga/LdG4b35YJ4TvLgLFIzhyiOTsB4S0Pb8u/j+
	nWUTFdKl353oU2PwN8EBkkbY7lPjTRZlNhqG1LpIyS8daYPqKls/G07xw1wqIy/JlgQ/eeiiOep
	T/kA2Uf3hJ7XEfZha7SgTF1TOSfKa7bbBFnJp2/WB0V88jF3eUP5CokP/quk=
X-Gm-Gg: AfdE7cmh1wXFjNrkx5QQhl5ypTSAWgem/gkn9dTWF+qppfviJy2SBrU99IHBpCUxKqc
	VE6cQlHLzO3amBHJKv+YxUEdh+qygXczCygdvo+he/+jD09tY42w7Fm0irAkoEk0VErCUIx1pCL
	LLTFOjT+crDliVMEO33n+iaqmAH1UMlNWk8UnV8BYzSfHURYL8C6YJWSpxX+JPfKLQ2CL6l2EZ0
	W0UWqQ1fGNhOFyVa5fjZpa/yon7Tl3T63DjLmzks5kCeVFF/C/8wNXmPXzyCVH/PPIacF/RiZJV
	0xO9RJcSjnCgnzh4um6WlJQclPCazDhZO7NRlM/y7moPhyzoFGa2Kklc2ZmkB5MmmhS7XdkjiuK
	wQJYRbg2kVYCLUBrlX+Yxe1KULGG64Yqmld7bHtFmWw==
X-Received: by 2002:a05:600c:a317:b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-493b82b63c2mr55410715e9.27.1782828078383;
        Tue, 30 Jun 2026 07:01:18 -0700 (PDT)
X-Received: by 2002:a05:600c:a317:b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-493b82b63c2mr55407775e9.27.1782828076370;
        Tue, 30 Jun 2026 07:01:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.133.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0afacsm79749845e9.12.2026.06.30.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:01:15 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:01:13 +0200
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
Message-ID: <akPMKXppWM74-m9a@jlelli-thinkpadt14gen4.remote.csb>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630033344.352702-2-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17404-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,jlelli-thinkpadt14gen4.remote.csb:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A56526E5364

Hi Waiman,

On 29/06/26 23:33, Waiman Long wrote:
> The nr_deadline_tasks variable in the cpuset structure was introduced by
> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> in cpusets"). It is reported by sashiko [1] that nr_deadline_tasks
> can currently be modified by inc_dl_tasks_cs() under rq->lock and
> by cpuset_attach() under cpuset_mutex. So if both updates happen
> simultaneously, the nr_deadline_tasks variable can be corrupted leading
> to incorrect operations down the road.
> 
> Fix that by changing its type to atomic_t so that nr_deadline_tasks are
> always atomically updated.
> 
> [1] https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.comk
> 
> Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Looks like Sashiko is yet not completely happy with this:

https://sashiko.dev/#/patchset/20260630033344.352702-1-longman%40redhat.com

I actually wondered the same and couldn't convince myself we don't
actually have that problem with the window between sched_setscheduler()
and cpuset_attach(). If issue is confirmed, not sure if wait_attach_
done_lock() could help here as well? It's kind of a big lock for the
scheduler, but maybe only affecting DEADLINE tasks and if migrations
are ongoing.

Thanks,
Juri


