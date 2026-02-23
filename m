Return-Path: <cgroups+bounces-14138-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA6fJascnGkZ/wMAu9opvQ
	(envelope-from <cgroups+bounces-14138-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:23:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30980173D75
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF8673004C24
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23A34E74E;
	Mon, 23 Feb 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cvHF38rw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3421A95D
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838324; cv=none; b=B47r3cyegYLztDr6sFWpSyl/FHI8P9sk984vXQM7SBqfi2F5EQROPwpBGcL5rsUtMmEM65pQLDQIjzhebOPzU+YYeE3ziRQDVPXQ0k9S2VoDPKv2DzRzQeCOyDQlhi22erfPajWOCv2pbKvIDPSl9YzV/ngPXLtjppoVILedTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838324; c=relaxed/simple;
	bh=ZhnSteMOWX5xfIin9zqb7hGY/YD249s6BBVJ+FU/H4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS/+B3h/oiQ47rHE9vJ5+/MricSpRWuD5t5s0qrUUqgZjathuwJ9h4UZ4K+kN0MeNw56Kult3xZwkO3EuDgoPmCHznBbzhzeO3wAIAidrpevEKMMXVxpEFDje7qofwurj80fjopuC2SkBR4ahFM3oyP9N8yEYojEZWSg7fGRWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cvHF38rw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837907f535so36143785e9.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 01:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771838321; x=1772443121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH5OG2+RDDb8VrJivnQoBt0ft8/X+47GVBPq4Qe+3EI=;
        b=cvHF38rwTt5r+XXzxumZitkq74oqgoEvDIFkOvkG+cFzIIJQEq5bwDYEyFmKYV5jqI
         e6PXf3Wj96WpUwpx9qOTQiAG8R6M9BK7kI16g9y3pa0AKKcRMH8ORghwDOA28+PME54P
         6OKcLX6Ab8JUKK7BgOVIUPaRPEFodVpLnPa1dr8umYEHn+wdJErzeXsZZmgotk/3/nSL
         n6cLKjHKffp0zG2ugYfpG5glZcKAAFmJNiQNGSeYHZ4bnYXrOueUNpFCXTqzR0bTW1cM
         mldl6PWlCYEvd3QUSOt/YQGs2HIpurb/6KJnDF9jkFvPKxt7zFe4h+xuFLmjlSZSUQqy
         E+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838321; x=1772443121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH5OG2+RDDb8VrJivnQoBt0ft8/X+47GVBPq4Qe+3EI=;
        b=elFf0MBKiHbZ6c6V0R1QxwUKAjzZZmD+KtS+G+YeSaQyVlLRHvpr3Ndv0AtNkctJiW
         ex51EDNfqVz8o5jJhX8vCO381GmYpUoGt0cyOXyGBsCBQ1FJ3cEOXULDVkcoLk/QluqJ
         cTa4GTH4KHb8sYjjcjMvjg6hV3RD1OSFc/5iZ0LpjxhprAkPuJTmsh4yEhvaXf35TaO3
         2saDHUGuGL2bTquXzovfjoJdUHV3YJRomsT7eNE5Gz8S0PWEcK71+Uto3ffpHk0eBhOa
         jnlQLTxvd2w0mD1uCa+/p6fGBkxYuuzfChuHKMDlGwdm1snUq8aSbTq+rz5auvkVVCFW
         ru6w==
X-Forwarded-Encrypted: i=1; AJvYcCXsfR6PKXX4/lHUrblfOjOjJiXpV2G7NT5QZhsLvP3nydWS93v8kilP5pUEt0h1YQUedG0DHEfl@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZZBD5ve0hDaroD6PBOOACcm+iamFbC4JPUSOwDAaJ55EHp+e
	eylCeDPRGvSSpQq72Mke3Br9nFZ5/9dctShQw433PgqA74R6HcKGbOcURtR6RZ1QnKE=
X-Gm-Gg: AZuq6aLfBA5DImuep2i+7SliF37cJYtEpNTH74cchG/M0v9C35ukYjKwwF3P1EV9I+f
	EyaZYfzPhH/SdDl+zsNMDmB+n18TZ4af5oMMo7A85qEHHZXk0nqwHUpvpgpK1KA/KZHkF6Yjnay
	OupAo3YlQkPKFaqPY6bVs8KIulsXDvkSoSLPRJx/XD54LuXHhuvyDqWNbV8ke71RXXRKsKHRYUH
	4GJPWqNlTNvPk1WMJuPBW6Oa5s8tKmUTI43U2k3Lq7gy+XebNChvj0z/+pRaNO20CooHtlmemqn
	W2UdfHAFxtRei7qNah+P3djHkIDc2XmzE6NXWvD2Nl9jJ+3Mq/BWxqSHEoybd8atxdIb8qmBVZ/
	B0WD2dkVgTdyZXP5oS8GsgALo6xQa7QD7hKOzAMRJzcWR5C/5YHyv/f9VcrSziE0aDIu5OAixzD
	7/aZ5D+uMJ93URJEoGA5a4/9J/3s6Aozw=
X-Received: by 2002:a05:600c:8b71:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-483a95c63ddmr129275105e9.13.1771838321486;
        Mon, 23 Feb 2026 01:18:41 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cab38dsm160005865e9.9.2026.02.23.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:18:41 -0800 (PST)
Date: Mon, 23 Feb 2026 10:18:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <aZwbcKeO-59l0UOC@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZhv+Bw7nKKmbFdq@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhv+Bw7nKKmbFdq@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14138-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30980173D75
X-Rspamd-Action: no action

On Fri 20-02-26 11:30:16, Marcelo Tosatti wrote:
> On Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko wrote:
> > On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
[...]
> > and delayed pcp work that migh disturb such workload
> > after it has returned to the userspace. Right?
> > That is usually hauskeeping work that for, performance reasons, doesn't
> > happen in hot paths while the workload was executing in the kernel
> > space.
> > 
> > There are more ways to deal with that. You can either change the hot
> > path to not require deferred operation (tricky withtout introducing
> > regressions for most workloads) or you can define a more suitable place
> > to perform the housekeeping while still running in the kernel. 
> > 
> > Your QWP work relies on local_lock -> spin_lock transition and
> > performing the pcp work remotely so you do not need to disturb that
> > remote cpu. Correct?
> > 
> > Alternative approach is to define a moment when the housekeeping
> > operation is performed on that local cpu while still running in the
> > kernel space - e.g. when returning to the userspace. Delayed work is
> > then not necessary and userspace is not disrupted after returning to the
> > userspace.
> > 
> > Do I make more sense or does the above sound like a complete gibberish?
> 
> OK, sure, but can't see how you can do that with per-CPU caches for
> kmalloc, for example.

As we have discussed in other subthread. By flushing those pcp caches on
the return to userspace. Those flushes are not needed immediately. They
just need to happen to allow operations listed by Vlastimil to finish.
Or to avoid the problem by not using them but that is a separate
discussion.

I believe we can establish that any pcp delayed operation implemented
through WQs can be flushed on the way to the userspace, right? The
performance might be suboptimal but correctness will be preserved.
So doing this on isolated CPUs could be an alternative to making changes
to the pcp WQ handling.

I haven't checked the WQ code deeply but I believe it should be feasible
to flush all pcp WQs with pending work on the isolated cpu when the
isolated workload returns to the userspace. This way we wouldn't need to
special case each and every one of them.
-- 
Michal Hocko
SUSE Labs

