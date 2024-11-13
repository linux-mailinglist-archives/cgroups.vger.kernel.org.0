Return-Path: <cgroups+bounces-5538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD799C78BC
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B311F230BD
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA81632DA;
	Wed, 13 Nov 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnsttQ18"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801616088F
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514996; cv=none; b=WyaUSPbW62XK/4xmZzl9omb4d0TUHjP85dv1TKGkENAhxJF2nyLmuMJFMYys1b8FjjIbwG3vmydnXiSfOClZ8pWrij5jIovLOZBYgXoAnLTPWq18kECX8IkLRPhMGSzjlhE+C4c+/Y5rvP5zt7SU3WsAGLdJalRgfS4dzGOk6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514996; c=relaxed/simple;
	bh=ILvq6iNvezbN5hyeS4cFP9EsIKXnczJpSfJnBlbgllw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcZr8KOgwS7RWzJ15Fhap1MLRtsqfYqln/4dhRVwozFTSEiIRCKH9AFI13YTF4l6UUi1sg4Vs+NokWBWH/wI3kuWXvZBp6ltHuaSi8gPG8IJPAL2ERv8Sk2cdukQ/7Fhg/7ozj2oyVOXdiZZRhV6XVMKQACoaEnUR1XBGo8PJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnsttQ18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731514993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0i5JZQNBT2nQgVVIZnUtd5qJVO8cAjUL1gi6Yy6QyBs=;
	b=EnsttQ18rabho3h6gv83Qjt1uz/RDZdL0ofN4r3v8aYwbgUdSj8LAipZzbklD+EQK1mSLe
	0HEVqny1WhciSygEAsoD422q74WxakZ6jYUeWhxM9DSPBVhjvIKrFDUv6jdgc4bZfwEuTh
	oIOfG2pLOR+DHB/7Sl2qQ26X4kCqTUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-KTtZl-DqPlyTr_Md41KiCg-1; Wed,
 13 Nov 2024 11:23:09 -0500
X-MC-Unique: KTtZl-DqPlyTr_Md41KiCg-1
X-Mimecast-MFC-AGG-ID: KTtZl-DqPlyTr_Md41KiCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56E431953948;
	Wed, 13 Nov 2024 16:23:04 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B176230001A2;
	Wed, 13 Nov 2024 16:22:58 +0000 (UTC)
Date: Wed, 13 Nov 2024 11:22:44 -0500
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <20241113162244.GC402105@pauld.westford.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <20241113134908.GB402105@pauld.westford.csb>
 <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 13, 2024 at 02:58:37PM +0000 Juri Lelli wrote:
> Hi Phil,
> 
> On 13/11/24 08:49, Phil Auld wrote:
> > 
> > Hi Juri,
> > 
> > On Wed, Nov 13, 2024 at 12:57:23PM +0000 Juri Lelli wrote:
> > > For hotplug operations, DEADLINE needs to check that there is still enough
> > > bandwidth left after removing the CPU that is going offline. We however
> > > fail to do so currently.
> > > 
> > > Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> > > that overflow conditions (not enough bandwidth left) are properly
> > > checked. Also account for dl_server bandwidth, i.e. discount such
> > > bandwidht in the calculation since NORMAL tasks will be anyway moved
> > 
> > "bandwidth"  :)
> 
> Grrrr. :)
>

Yeah, those are just minor nits.   Maybe Peter can fix them on the
way by...


Cheers,
Phil

> > 
> > 
> > > away from the CPU as a result of the hotplug operation.
> > >
> > 
> > LGTM.
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> 
> Thanks!
> Juri
> 

-- 


