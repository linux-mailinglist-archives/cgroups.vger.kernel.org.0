Return-Path: <cgroups+bounces-17183-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qxDuASddOmqx7AcAu9opvQ
	(envelope-from <cgroups+bounces-17183-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 12:17:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584F6B62CC
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 12:17:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Yn0LwSxI;
	dkim=pass header.d=redhat.com header.s=google header.b=m4L6lrjb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17183-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17183-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FDEE30AEDB0
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF753769ED;
	Tue, 23 Jun 2026 10:15:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481F372EE6
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 10:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209719; cv=none; b=kG/4hUeqBSRJyoT8y6OCEdC/mA5kfFHy8ZzhSOGWERxRxVxvI4pQBas4otLoMswTCeal73qgWZemuLZJkdNz7POGtzia+I18VwLDcpyYxMJIr7Vkt3E1ZuG4AKUWdLZ+1U+Udkpvqs5qt4btqxfwT8Hcq6YH0S1GbReprrKdBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209719; c=relaxed/simple;
	bh=JhNZfEv7I9RQRMdqT1oCgbFcCZ4KIhLmoBgIJJYst1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygg1vp0/DPpzA0l1We1WkoHazO4ZLrYmwO4lDrtkfoRKcXxeHnw7f5SHIscTjF8co2urY7NbrGBfPwNqdXAprFeaGJow2SurqD6b+hz8KPHr+Qo+p1rTdTJc+55l0jeLMj9XHJ8jCUvbpnpkVgpufgdQCv1EHZtSmPA8vwjvLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yn0LwSxI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4L6lrjb; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782209716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5lySzCS3c3hJQ/Zsh36ztJ14IpR9Of7jKjOv+WA4eg=;
	b=Yn0LwSxI5YIXRe1lc8pJYMnNAGJrBw3q1beMI2bGCEG3rs02bH1u+zmYgPhlCdE8HoLmUY
	oYF23aK+cC7fhlrhbE5dFmpfxhED3pNY1JoC4Zq8Z5Si8RUQPDmLcxfd1n7fcboet2G1Ry
	kiuM+Jc0iGjDUZc6N0shxdSmRcvWQIY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-tjpxGEFRNgWOI6gCBsCisQ-1; Tue, 23 Jun 2026 06:15:15 -0400
X-MC-Unique: tjpxGEFRNgWOI6gCBsCisQ-1
X-Mimecast-MFC-AGG-ID: tjpxGEFRNgWOI6gCBsCisQ_1782209713
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef4931de5so558583f8f.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782209713; x=1782814513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5lySzCS3c3hJQ/Zsh36ztJ14IpR9Of7jKjOv+WA4eg=;
        b=m4L6lrjbP8XAoWiKk6Rrjp8Qvmsf+vkkc9j6Ul2IGow4hX1ZlTjlVafEB/FdQSc3jk
         5KgwNQAcPbpNM81LFw7LT9Oy/oixoFROxmCI5U/rD5+XmdDhu3C1FxlGfbkQ1XBNNndM
         PtmsqESoeN3WXsiX7gIY9Ve2pgyqDevoL2vcUgWGmCHSwO4hCTfmx7CJswkt/BSg3t1y
         Z+NDisT4PczEkJ6W8NenoxbaMomnXgPcEwRhPxhvpXEvLIBODibJJX+Z2kg8l3L1jbVS
         5Su2sQruTiGbVgXim1WzfVhxAdOvFpA0c4I1R7uTyIVtH4cMLAo+Xc2GiTUqq9zkVDgf
         DgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209713; x=1782814513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5lySzCS3c3hJQ/Zsh36ztJ14IpR9Of7jKjOv+WA4eg=;
        b=egyBV3h7WGrYnoPCkZc99Bx6KqyTt0/6jizFcuE5R/D0uF5yNX095/a3YSenHaMfHh
         0g2+RxKBCmoGg9eJtOq5H5uZupBpXnXLdwNt1B3QysiXJf/Vn0LEnNHImjZjSWZJ5GyP
         vRgSd2rJxjPtyXuFKZcTaJHF7nwT3AX/lWySU3DgZR4PHoApATKXShMaaAqNenjZXrbb
         xdfr5f3+DJ8FgLtE3JjoS2KDKXz3uWkB6m4Db3NhvzOd8ep65ZyJ74h4r8MXKST2LbkM
         dpOknHBIyFhsrGU8Q1CZhongBIBVZvcsQsfvpjZNaQ+U/pISf7vdgfu+C0wviqe0YQIj
         3ZcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gqls9t9HX5GLfAsjv1mDhOVuURDhKySrXi6IpYV4SBPTCqvqpXjklvBrMmQMMOGYfN7eCG7aA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97zlf+MitB8jgR7O0TGJ+I0Ho33crYYx6cWwQ6rB6dpkiuthX
	Nht62gxh3XBqdeKfatnR2O7gBb7aR/QYFQTUWEfVPiOyGQA6r8mgbyOGLELB6ZESA0j1g2KV8Kf
	O+SlKD4cl/UZ56brkF3KaF7eqeDxt0s081D/LFurrkX+Y0uH05ic8FK0aFf/v2Kjby5s=
X-Gm-Gg: AfdE7cnjMmemXfBHgxCDxC7XLDazFZTh7rTwuTcUANHy9vAxqObm8nVHd5i3KmJ9um0
	4gN8c+W5+Lu7XzUnqApmZcx53swmx09E+eihxC+VD1ZrKTVikfbCNnzs50tdUt9mHvmh6F0V571
	p/G7g6HaU4UMQTZuWtHqI6/3liJJrKQ2Qa0/Y/AN7Skn38EOtGHpesFm0VTH9ucm51INQnzy9Wi
	Ar/xRQbvth5qZyChc4oR1K2hm+hHtEXFVBoQcuG0CJUldRPhSr/S7DGbSU33ENLzRXurKR/VRn6
	FGcFCLED35Mwv4dT6UGvx+PZIbWffLQel69URQ44vnBHiSNqhE/iLhSE5l9/Zn+i0gxpI3IyOr3
	JWjHoQ9nfgEakBEdX9BKh5VWtdQMJ4ANQ5UAmEoAfvA==
X-Received: by 2002:a05:600c:4e8f:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-4925a0c4ec8mr42644255e9.14.1782209712902;
        Tue, 23 Jun 2026 03:15:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8f:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-4925a0c4ec8mr42643925e9.14.1782209712466;
        Tue, 23 Jun 2026 03:15:12 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.133.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240eef2basm385461965e9.2.2026.06.23.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:15:10 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:15:08 +0200
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
Message-ID: <ajpcrDn2g2G9mGKp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17183-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lwn.net:url,asciinema.org:url,sssup.it:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3584F6B62CC

Hi Yuri,

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

I've been working on a simple demo and benchmark suite for HCBS to
explore real-world like use cases and characterize the feature's
behavior. Different angle wrt your unit test suite (I believe).

The demo is available at:

  https://github.com/jlelli/hcbs-demo

The demo models three scenarios — Industrial PLC Convergence, Robotics
Compute Platform, and Precision Motion Control — each with multiple
cooperating SCHED_FIFO tasks at different priorities sharing a cgroup,
which is the key differentiator vs. plain SCHED_DEADLINE. An aggressor
subsystem overloads the system while HCBS contains it to its budget.

A side-by-side compare mode runs baseline and HCBS simultaneously on
separate cpuset partitions, with a live terminal dashboard showing the
contrast in real time.

Key findings from testing on an Intel Xeon Gold 6433N (4 isolated CPUs
via cpuset partition):

 - At 10ms task periods, HCBS provides perfect temporal isolation: zero
   victim deadline misses across all scenarios, while aggressors are
   correctly throttled to their budget.

 - At 1ms task periods, the dl-server period is the critical tuning
   parameter, less the bandwidth. A 10ms dl-server with 60% bandwidth
   caused ~10% miss rates because the worst-case throttle gap (4ms)
   spanned multiple 1ms deadlines. Switching to a 2ms dl-server period
   at just 30% bandwidth eliminated all misses.

 - A simple Rule of thumb might be to set the dl-server period to at
   most 2x the shortest task period in the cgroup (e.g., 2ms dl-server
   for 1ms tasks, 10ms for 10ms tasks). Would you (and Luca?) agree or
   would you suggest something different?

 - dl-server overhead itself appears negligible: a parameter sweep
   confirmed zero misses for a single task at all bandwidth/period
   combinations tested.

 - The current v6 has been quite stable throughout my testing — no
   warnings, no crashes, and the bandwidth isolation works as expected
   across all the scenarios and workload combinations I've tried.

The demo supports three workload backends:
 - rt-app (default): synthetic periodic tasks with configurable periods
 - RT-Bench TACLeBench (--rtbench): real algorithms (susan, dijkstra,
   FFT, mpeg2, etc.) matching each scenario's computation profile
 - stress-ng (--stress): mixed CPU/IO/cache/memory aggressors for
   realistic interference patterns

Recorded demos (asciinema):
  Industrial: https://asciinema.org/a/5e4BMdWxS7hmm4hI
  Robotics:   https://asciinema.org/a/Msj48XnJGgcCev7M
  Precision:  https://asciinema.org/a/56WC3bu7yrcQe9nz

Thanks for the great work on this patchset. Happy to hear if this demo
is of any interest, discuss any of the findings and/or understand if/how
this can be further expanded.

Best,
Juri


