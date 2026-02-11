Return-Path: <cgroups+bounces-13862-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IlOIMOwjGkDsQAAu9opvQ
	(envelope-from <cgroups+bounces-13862-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 17:39:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49212638F
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 17:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC108301F9A7
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA9343D72;
	Wed, 11 Feb 2026 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gv/EfUgY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06171341ADD
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827932; cv=none; b=uM2SVrsPeh6JPqsFOFCrezv+OnEFgYerlDKDY+jGTuqMWkejkpeRl43Lv4fyKb2VT1nO8xEoczaV8UNKG2+xUwWXvUcV46LshKbzTyrB37zJE7YHYK1CXCvdErJLQ9y1bWV3WfaqMeGBhqxmmT8IMzpnGT83JT7KcGABt7H+k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827932; c=relaxed/simple;
	bh=wKPgU70r+RXsB8BUm9KzRnLKjcz/48fhcjMA7YFyamE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjbVBjICr35LRU54kns8uSZU3dKHw3zU8V2G1hBiBJUtVAe3myUJFuqPF60BF0eMAnkp2tYFDuCir0uOSIJRoJZrZKC2rc7UAbcYybdQKUHLB/b4ZECJICSwHQVljlE4YfRBLon1yGYvXoq5VYL7oT61k3mGSLzzFPOMxW5HKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gv/EfUgY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48327b8350dso48956335e9.1
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770827929; x=1771432729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0jBOVRTgFoZvFipnRn5zFhtmX70ZXn6LNFpcY6w9QM=;
        b=gv/EfUgYUTgj3ovl3WMbMKwbqSGn4IXJJkE/o8E6KhjEIL1THFHG0JMAGc1Dr0VLt/
         3CCuf9fVi8owxy4MLMckWITWWk/HsHsY1CcM0spEj3LNMbacJKAqqnnJ8JQbUd3uLhSN
         8NbKQNItI+F2spdqDqT71oHwOgzh4NzQDVplu6MrhUYdjlVITDT9zBsf0TQPxnmaWhsh
         NjUuUaGHvbLjeSD83H9Cox8AFEmrjjTs3EEuEVKTieUXywDFwgKZDx9Tqg+/7DCNAypd
         8QcCZP6NaT+Er3ljrJZzQlaUgWlp3VTLlJlb1gOiYSrKPhAeB6PM4b3E4u2e1rbO1aHy
         jA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827929; x=1771432729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0jBOVRTgFoZvFipnRn5zFhtmX70ZXn6LNFpcY6w9QM=;
        b=i6mwF30rMIs7N6ifJFAB59w8a1ThGPljYt9RrPVPMP8dZNH8XjHKEaYhBm02sJSFM+
         GrecPd0mucsP+ZIHX1tJTcnR3ibibkcFAYIFBZ59eXd5+ySfUm/4cbvb/OveZDvYSKRk
         PhWLtJg6aGt/VS/wiI1532ilC5g9oskrcyBKSJtaxQ82P9FfMcep6YKSTHBZ544x9j4S
         KmfG/IrZRb5CujD/+tzUMKWQ2I5LpFVYlfSgAQwlJ32Kn24QsulamdjMGWvserXDlCbi
         ktGFIZNnBoXncX3FCzcVHAS4pAanNsFY8RFBKkd2JlYi9eCoS44b5DLGantsEw2E+a6Q
         Ys3A==
X-Forwarded-Encrypted: i=1; AJvYcCWi0EXOKbxOkrKzOR2oHy0K7MFzPe3IS0FBKXN6UtDuB94Trm8XaAOEy6vDbgnVgwp3OZjfTpXh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WhM0eoN1oHgQ5I6Vt+RrV5jz0QjiOQKzaiUVgd5AMkYFuZ5y
	+9gbzWkOsPx7GlKsrCcGGYlxJbUWzAR54BOUVTreEI/SnPkSwv8NBsOuP8kKDj/wG/c=
X-Gm-Gg: AZuq6aKW64Jpo+fwV/U2nx7k7ftb9sXfU3I13ob6UMb+vBc8GXaBhfa07w4j0nnPnRy
	0AyLIwJtrq06Hv7nAz1kscAS6aZGSjwgC1VQR9unrYBT869ZkjkjsTBc1lggHZrdC1N5IAv+dNL
	Ddx4SPQuOLWPzXgEDc1tRrmrJlm0njFN+WLXOBXzu3tgUuvn342jQReJQjMrQw7cHYLztvyoOyw
	nBYIgYh9VZPvh+ACZrzRV3i9JkEIPDKudH5iUf3TRhxi8G7k58mkRiZB9OPwg670lBbjAzxcL2K
	DJTZSq539SKhXK59qDum/rNWHSbZWkTSB63OE2o6KI19+XldM3R993WXPNHpTH6xEUXc+ldHlR1
	TaDHUoYGlo9eF7ZzanxW44/thzkOXCFO78hCHGMacAem/D1WoYBYdj9YHM/NASOo9bQmu6zfTqo
	ArPxTJOx+x8O9ICa2AldeGjWTrkV0EV2c7ddsi
X-Received: by 2002:a05:600c:a4f:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-4835b947ce1mr36415155e9.33.1770827929279;
        Wed, 11 Feb 2026 08:38:49 -0800 (PST)
Received: from localhost (109-81-83-241.rct.o2.cz. [109.81.83.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a5bf1efsm47887645e9.0.2026.02.11.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:38:48 -0800 (PST)
Date: Wed, 11 Feb 2026 17:38:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aYywl1hdBQP2_slo@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxviLoWsrLqDU7o@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13862-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: DA49212638F
X-Rspamd-Action: no action

On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
[...]
> > What about !PREEMPT_RT? We have people running isolated workloads and
> > these sorts of pcp disruptions are really unwelcome as well. They do not
> > have requirements as strong as RT workloads but the underlying
> > fundamental problem is the same. Frederic (now CCed) is working on
> > moving those pcp book keeping activities to be executed to the return to
> > the userspace which should be taking care of both RT and non-RT
> > configurations AFAICS.
> 
> Michal,
> 
> For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> boot option qpw=y/n, which controls whether the behaviour will be
> similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).

My bad. I've misread the config space of this.

> If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> (and remote work via work_queue) is used.
> 
> What "pcp book keeping activities" you refer to ? I don't see how
> moving certain activities that happen under SLUB or LRU spinlocks
> to happen before return to userspace changes things related 
> to avoidance of CPU interruption ?

Essentially delayed operations like pcp state flushing happens on return
to the userspace on isolated CPUs. No locking changes are required as
the work is still per-cpu.

In other words the approach Frederic is working on is to not change the
locking of pcp delayed work but instead move that work into well defined
place - i.e. return to the userspace.

Btw. have you measure the impact of preempt_disbale -> spinlock on hot
paths like SLUB sheeves?
-- 
Michal Hocko
SUSE Labs

