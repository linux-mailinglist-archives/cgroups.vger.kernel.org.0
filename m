Return-Path: <cgroups+bounces-15988-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHqlJtLkB2rgNgMAu9opvQ
	(envelope-from <cgroups+bounces-15988-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 05:30:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3CC55A05B
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A40B3013A9E
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569C25B08F;
	Sat, 16 May 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="Hs/hRF/A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755001C861D
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778902219; cv=none; b=eEDwNfOcEZmae9sLo7zBH+Bz6rzphSheNNIGXbH1HC8TpkotlvIZtFFcI11NiTHj5kJ5n/5pFVRuc1Fb/c3EirrxKJZQ6Ktqb0phDppC3N755qyue4OiDYIgSrU5243aQ5KBZuoVlXZRP4UNKCez8GI4WFatBQFRogmhWYh2IPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778902219; c=relaxed/simple;
	bh=oIMW+/NQlpwwtVCLP8cgNHx+Uv5lvJzNUtx6dwpdwEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK07kk63X8PDuzuFNubxQ2KXD/jvyoJNI1M8uVRXBd31vVzdupLutGfqEjOa45x250yaoSjK6JyivXdDwzolh6qzr0r8/LLbWcLumHc0jszy6S8lWBSl4pMFKy9c9+IZovNwh5zawsWf3FT/DBrOdCY5rIgPMVat6dEQ0qE+A1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=Hs/hRF/A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso3954125e9.3
        for <cgroups@vger.kernel.org>; Fri, 15 May 2026 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778902217; x=1779507017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scfhF2O+gAjy+ReqdySAnTRJrT79VsGosYkc7EIKcg4=;
        b=Hs/hRF/AoqtIE9OBZSlpcTHIH7GqhF1xXbIpX2uZQ+mkJolqJ0Rs4Y99VlTjBJQoFM
         kz7xTwaC2Io4S2rxKy4bDb3kz0bG+xt5JzwUNzfqKFKTkgI9y7jT3E2YyWPxTWSYQ1eW
         fecCeb6++vrAoVyAAmR/KWIsPktOUc3PLD76rWzN3wiJhnSvWrrr9eW2LPIvNzmidbva
         1z8QJhID+xUjPrOlA3vzbQGUsMsT+lrsuDxgP6YlegA6D/Mfl1SsDQHqmdGhtUCBMn3M
         9f0c/KltIAiPGxKe8cyIoC65VDSGXvi+Cm5B+TjeJV6ysUZXjS+i+2RefpsXVJWFEdzR
         e/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778902217; x=1779507017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scfhF2O+gAjy+ReqdySAnTRJrT79VsGosYkc7EIKcg4=;
        b=IT8GlMpUKTZHuiN7+Yam3CpIzjKiPA2/Fe3Vi3AlHmv6bD/CgmpspEq1+tqRXme6GR
         t5MNWmNFgPvtmDqQeNv536e74CPtHSxGn3ulajjBRsk9acTFvl2KVxti4CNa/cgycOv/
         JnlclA8X8VqC/EQKPiDQRUn5kOFqxwrH6TPNNoibIP7F64oRmyWiLefX0+sfEG0tOdhH
         cHDhojmELV6qt6IDDDxvkxp/RIwvCWrAQqC9CPJhROfaD02V48aDeWJT1H9giLJxklQv
         OletFKtMn1zk+saBa7uX9wFkHqwaDqtSIWy8A/O9OarfRXf9G7mdNk1AVGJHBKZXghzV
         l9eA==
X-Forwarded-Encrypted: i=1; AFNElJ+l2r21cxy2a2/in9G+TDlPafyVtgQWsJlTdsDJehbp6RrkM1uA30WG9yH2L8j7IOWXoL53Llyk@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLBnlUDxDknyGXPQDnTrNLfFDM06VzWWJMjaOBH0g5m0JMstr
	R0ql05TfDuooS5mzoj3MI8pEXDwYq49l03msDSnxpWTXxQhxtEKBuwLBzhLgmdKWYeA=
X-Gm-Gg: Acq92OHgn0NGIGhQeGDb5T6iugqr1ZzlU8y/EaaDt1l4BQaOm9J/1lvRIaZ95DOvstD
	I6ibhaOVXN8Y2CO3si/HM2h8WPY9tMJRXeVBmUinZwKcaWSo3xKNVFwz4AWXeYpHn4Ty4nOAsYJ
	eGz5pIzRmEXa41iXoKy+TP4RbrZubixrnxcZodrOES9Urzewzm5TIjKn3qCFn5MEHjJHlaC8yV+
	WmC+ryJXq6l7ulKvTEsDJkOixgjHFxdkb4Rf1rc9VpbII+UF6l84IQ1/Sg8nLvpCpuZfk5BzO2E
	YLszw0eIPG5tyt4cCHKGQpKi6kKdZTcCyV5gbt5n7779K/Pn6RqJNSQ2X5WB+J5bfNC4GmoyJDU
	7UL2aGfsZbHt5vMY/zUpsTqp9p5+fxRHEsbLN3WeGIxehVfhKUik41TdRTm1rIgE1iuD81BIx6I
	3HjIvF1jE6eyYQ1vUGXVnQa1a5ZA==
X-Received: by 2002:a05:600c:8b47:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fe63223edmr96015715e9.17.1778902216842;
        Fri, 15 May 2026 20:30:16 -0700 (PDT)
Received: from airbuntu ([149.40.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab671sm99739155e9.1.2026.05.15.20.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:30:16 -0700 (PDT)
Date: Sat, 16 May 2026 04:30:12 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <20260516033012.kaq4vouffpqw7yme@airbuntu>
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511113104.563854162@infradead.org>
X-Rspamd-Queue-Id: EB3CC55A05B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[layalina-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[layalina.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15988-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[layalina-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qyousef@layalina.io,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,layalina-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 05/11/26 13:31, Peter Zijlstra wrote:
> Hi!
> 
> So cgroup scheduling has always been a pain in the arse. The problems start
> with weight distribution and end with hierachical picks and it all sucks.

It does..

Not that it is useful info, but we talked briefly about it at OSPM, so thought
I'll report back. I gave this a go with my test case from schedqos announcement
[1] of running schbench with kernel build as BACKGROUND noise, but the fairness
imposed at group level is preserved (as expected) even if the pick is
flattened.

I do actually want a total flat system, ie: disable this whole thing :-)

The problem is to create a system where you want to introduce smart tagging
based on tasks, group scheduling becomes a big problem. If a task is set as
background or interactive, it has to be global to be enforced otherwise it
loses its meaning. And my test case stresses two long running tasks one is
interactive but the other is background and group scheduling imposes fairness
that breaks the task level tagging. Managing deadline via runtime doesn't help
here since they are both always busy tasks; and one must use nice values to
manage bandwidth. But nice values are local when autogroup/cgroups are present.

I need to find a simple way to turn this thing off at runtime and properly
flatten it ;-)

/runs away

[1] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/

