Return-Path: <cgroups+bounces-14171-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDNDIPzNnGnjKQQAu9opvQ
	(envelope-from <cgroups+bounces-14171-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:00:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61217DE6B
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 140EA3086002
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021F379966;
	Mon, 23 Feb 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiAryGDr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB9371056;
	Mon, 23 Feb 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883778; cv=none; b=Tdx/NZW/sMD3y5eNNw1X69BmMc2t4o114Bs6JDovKsn533id01q4kbOkXI2Rd7XlORZzYQc2G9mRb7h1q+LGdbH1fjNTRBwrXzBADTGIyPET9+dHvk3MMxH3uzCZXUvQmIfPn7tjv3zFRZ5zn/6MPLvU/phkWvMFjOm/TrLxxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883778; c=relaxed/simple;
	bh=fQIHqy1M3EnBsPkSeluvFe+CzPVvJ3xbr05GGxDh4vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z89UsaEMIIJTvEP0O8gVGqXvOZU/aP8L05CxLIeT6jh6IeoYL2MHwS2y5aSlMqjE19TRwNmwE11IkX2HXAuk0YY1UTq6iE82Pwl0j15ARgIzi0o5g56NkDd4GF5Qw5v6s7Ydnaw4V7t9EVUVt3Ur9rREoyFcgcYJtIWx5nRs62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiAryGDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A9C116C6;
	Mon, 23 Feb 2026 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883778;
	bh=fQIHqy1M3EnBsPkSeluvFe+CzPVvJ3xbr05GGxDh4vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiAryGDrkCovEn2j4uohrVDXWPiJmV5sCYkegexSkKYuWS7Yab9U+c2yQqqySi1JH
	 2NH6LIJtP4os/QTlmf6YFUQh54Spl58Pu3l46yBCu06ZnvYyJ0YrZKh+QRk8lzd5xz
	 VsdkZXiJJ6JE8Qot2esjDx2JlBqtXQLNg1DzTZBwR1SVM7ATEbSFyFr83t+gaYcfA9
	 QcHHQNoEWnnCN//JfpsBuAlpojl35ab99z4OTP6BCVNEXqL+3LEgRix9DdCf+cldgC
	 sN9lkIDZYIAEqs5csxHzG5yfxJukTaUYLnpjn8Ss+xHvjKtgaE5uflauArFrZecsvD
	 HZIjIX4/x7wlg==
Date: Mon, 23 Feb 2026 22:56:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aZzM_44L1vKzcOCy@pavilion.home>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZdk19MqYhWK90Do@tiehlicka>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14171-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pavilion.home:mid]
X-Rspamd-Queue-Id: EA61217DE6B
X-Rspamd-Action: no action

Le Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko a écrit :
> On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> > Michal,
> > 
> > Again, i don't see how moving operations to happen at return to 
> > kernel would help (assuming you are talking about 
> > "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> 
> Nope, I am not talking about IPIs, although those are an example of pcp
> state as well. I am sorry I do not have a link handy, I am pretty sure
> Frederic will have that. Another example, though, was vmstat flushes
> that need to be pcp. There are many other examples.

Here it is:

https://lore.kernel.org/all/20250410152327.24504-1-frederic@kernel.org/

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

