Return-Path: <cgroups+bounces-6881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E4A56307
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4983A54E7
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F781DF990;
	Fri,  7 Mar 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xgx7NzoE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1811AAE08
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337746; cv=none; b=aUZYe9sEhV+r65BaW5l4zTGDrNAwKolJmAX3bQbu5KMTb2Yc7WYJonlkzXDOkARPj3zv6mHV94747xTi6rjothTs8Kg7cHb0+4OET+5OfBerRxDV9Qs39oUKWn5lQLdp93l2ZoQTHlHyU0lOJ/dbNNrjskX3nCO9u+366WCex4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337746; c=relaxed/simple;
	bh=2CWoKZ+Dk6UUm88Dli/o0sfnoDA1GxgsKa0rzI8+CaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohunLQV5udzFiY7Cwq4JklSWcBlcIBjhRUtHRfIY8nUqhAuT80TKOAgrpTaNo4xNhPgEdC9Bg3NUf69ADxTPPHvzTs59VPENW2X4TSKWq8vNas2VzV+yA4/dEaZUpdUvaRA4wZqPGKK/rcs0MaNlZgQI/cy2ssv6+DCkrBItA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xgx7NzoE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741337743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QIM+wyv0gROGtwfPUwZvYBsQhvwoC9PYEBEonKSvsg=;
	b=Xgx7NzoEZWGB3iIvMDR9arYGAjB8w745EsoBlxZYQfUhDN6MWQMdMVGWVA85ddpl9PBel1
	dBEfYWRy8QP5DVgKUZJY9x1ALGWYTBlvIKt/KPvYvTuJBvEVoo8RMAjI1HvXq1vBDmQz3b
	+hAvHtyGzpMs57TQeP5p5RCDWR9i0xw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ESy5OaCZO2OkiGtQ47Jq0g-1; Fri, 07 Mar 2025 03:55:40 -0500
X-MC-Unique: ESy5OaCZO2OkiGtQ47Jq0g-1
X-Mimecast-MFC-AGG-ID: ESy5OaCZO2OkiGtQ47Jq0g_1741337739
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b3cd4cbcso196790485a.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 00:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337739; x=1741942539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QIM+wyv0gROGtwfPUwZvYBsQhvwoC9PYEBEonKSvsg=;
        b=l2/8umxRxCd58Rr6koEvYTC1fElthkGtLm5BKJCr6Fj3koef84N1jZvHe7EITFdnS5
         gLQPFXP89EoW2gbmRFQlB3NATRaPI9jshlHmHmVxVq6gsxLyNuS+cdXFisKpECSvprGO
         IJQFxe0lGFROGrjoLdMoFly2C7oCXHBPmmRqRLvYEYQY/52kO9lAKs71PzwrG5lYdFFM
         vqhnTA6RA6k34iTkDGSLWWB041lHp6CAljyJJss7nfz04ngSOlW9GjefSm+KAhw6u2nQ
         nV2ACv/F6z/6/mwKBkdT1zu+STEJjCoowX6pxBRiigUFgbWbjKCWcvvlD3dGHcjJiRVq
         lKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGKRFnnt8uNxK0gsAQBfe0FnYmGunt1gIfuyIlW8nOtC/qxXuueclduq9gV8Nynzvw6v9wIB0A@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxGI6pOC9222mIhYJC/iZo1nsI0X4s4W8Txm5lpHy1vvUyH/g
	2gZc/KmNEus6Urp3GCb+iO83OYZ7Bs1AZGdTgom/ut1LuyIRC3VRLVf1+cHnRgks6+F8vcxSRXd
	E/NMq26C4Yy0l8YUljYonV+q+vR0M3lhsL8CgOWEuxioC1ZfwTIIwjGc=
X-Gm-Gg: ASbGncubyP+Lubv8Ou5zSzU4uwfbknJGGjkYq7pKmR7VL+9NSLdwbCOP66/1JbugGSF
	DlBcwEHuWDJ+xLU9ow54hBEaHnaj2THHRwk5nCorJDhSKZzFHus7BmqXUbFlDmf+Nl8euKxM/70
	yXRX3dhB7D3yi+s5PtOc3BpjaSx4Wljk9qc+mf7u3GSSPav7N3X7eQZ55bhrQFj20bPY7ImKCb1
	PkALqh0keYX7+oA0kourry32vSvzVpj7asG8GiEH69S1x+w2lCTld2qhR4HlVYk88htC+kBbDkg
	cYGopi1Azqh1xjLwgIQQfF7WNXaUauVrs+tzLNBVUB+GnF0XdOHcLq+9FTgNvj6inQ+4aJlvyPu
	jryDl
X-Received: by 2002:a05:620a:4c8a:b0:7c5:2d2b:cb86 with SMTP id af79cd13be357-7c52d2bcbb2mr205475085a.0.1741337739608;
        Fri, 07 Mar 2025 00:55:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHww7UXZ1RBcCgbdg2KQFtdXnpLpXG2tZZKDTBX8GjXkK8AKIaubLCurkep0FAft3+Ybt0qfw==
X-Received: by 2002:a05:620a:4c8a:b0:7c5:2d2b:cb86 with SMTP id af79cd13be357-7c52d2bcbb2mr205472285a.0.1741337739354;
        Fri, 07 Mar 2025 00:55:39 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a4485sm17385426d6.53.2025.03.07.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:55:38 -0800 (PST)
Date: Fri, 7 Mar 2025 08:55:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] sched/deadline: Generalize unique visiting of
 root domains
Message-ID: <Z8q0hQAHLlYxuHBY@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-4-juri.lelli@redhat.com>
 <885de7ad-f168-4826-b96d-bb136ee30333@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885de7ad-f168-4826-b96d-bb136ee30333@linux.ibm.com>

On 07/03/25 11:06, Shrikanth Hegde wrote:
> 
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Bandwidth checks and updates that work on root domains currently employ
> > a cookie mechanism for efficiency. This mechanism is very much tied to
> > when root domains are first created and initialized.
> > 
> > Generalize the cookie mechanism so that it can be used also later at
> > runtime while updating root domains. Also, additionally guard it with
> > sched_domains_mutex, since domains need to be stable while updating them
> > (and it will be required for further dynamic changes).
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

...

> > @@ -3192,7 +3195,7 @@ int sched_dl_global_validate(void)
> >   	for_each_possible_cpu(cpu) {
> 
> This has been changed in 14672f059d83f591afb2ee1fff56858efe055e5a to online
> CPUs. So patch didn't apply cleanly to me.
> 

I based the set on Linus' tree (base commit in the cover letter) as it
is modifying both sched and cgroup bits. Your fix hasn't yet be merged
into Linus' I believe.

Thanks,
Juri


