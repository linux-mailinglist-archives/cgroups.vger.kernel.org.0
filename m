Return-Path: <cgroups+bounces-14576-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKNCEixEp2kNgAAAu9opvQ
	(envelope-from <cgroups+bounces-14576-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 21:27:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74D1F6C59
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 21:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79CB3109688
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4C3845B2;
	Tue,  3 Mar 2026 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoOKEe+x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E2305057;
	Tue,  3 Mar 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569359; cv=none; b=n95C8SpUmWKl90pbD9gM+Nf47to63xU2hY8SCoCE+RsXhnddP+TRBZN2TV9E/rBHt6xqJT7VaN66D55qbApqTtFvFNtFj7dwF2FKKtvCnfVMcDhgOiSFt7+Pd0Pui11ui8niVF5w0/vwIXtjp4lUikQeAkbJkeWJe9EwEDInTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569359; c=relaxed/simple;
	bh=g9+P2D6emdPgTvmDXJSMGwMP3ifJiedIGBA0cnA8sNk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FlLJ3sIQp/WUefTwodzcI9OfdhhXNSxnivaAZZa66hEUYzcVYpQfr/VqAWS/megpqdQDKivXNK7+Ah953cQcPa7cbt+dFKwEG3fYIs1IsqN7UDyWcQplTy02b0kAtpnBGCra+ZgIs2dDZdJDntGAH3HTwd58uVYzZZuD8wCrcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoOKEe+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DA0C116C6;
	Tue,  3 Mar 2026 20:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772569359;
	bh=g9+P2D6emdPgTvmDXJSMGwMP3ifJiedIGBA0cnA8sNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BoOKEe+xcJN5cneXM/Q+BmyuAws5k5pp4JJ81WYNsSl8uSi+rPhJG4VOWO21gzi4A
	 +4Owomihm09XseU9BVr0D6kGBm1yiNxQxAimG14SZH3Opd/3+aTst9eCkc7eC1NKJ+
	 bWDGqXGx92PC+R0BzJquCG8TD1xZQuyswvqJ2VDZePq6iCA6tKA0sneJDQ0uY6vAtC
	 4m1H8kt04rv4LirKQkpaAL9m832U/anHclt6zvsjgQYNriBDgE5BsnIyMq8ML0xo0S
	 cfM1VOwSqgKoQveTWY1s9CUzANLyqEbfwyXLRK14iOWxRWYJTHWo8bFglxQG/sMiKc
	 kMwzuXJaBozeg==
Date: Tue, 03 Mar 2026 10:22:38 -1000
Message-ID: <e3897a34013dcc785e93f503512574c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] cgroup: Don't expose dead tasks in cgroup
In-Reply-To: <aachZbIFl6HCFSxD@slm.duckdns.org>
References: <20260302120738.6KkDipsR@linutronix.de>
 <20260303131301.ieSSCM4n@linutronix.de>
 <aachZbIFl6HCFSxD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BC74D1F6C59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	TAGGED_FROM(0.00)[bounces-14576-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

So, I think we can fix this in the iterator without moving the unlink.
css_task_iter_advance() already skips dying leaders w/ no live threads
but only on the dying_tasks list, which gets populated too late. We can
extend it to catch PF_EXITING tasks on the regular tasks list too:

  if ((task->flags & PF_EXITING) &&
      !atomic_read(&task->signal->live))
          goto repeat;

PF_EXITING is set in exit_signals() which is before exit_notify(), so
by the time the parent wakes up, the flag is already set. The
signal->live check keeps zombie leaders with live threads visible. I
can't see anything that would break by this being checked earlier than
cgroup_task_exit() - everything between PF_EXITING and
cgroup_task_exit() is just teardown (mm, files, etc.) and it should
close the race window.

Haven't tested this yet. What do you think?

Thanks.

--
tejun

