Return-Path: <cgroups+bounces-15003-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPn2ORabwWlNUAQAu9opvQ
	(envelope-from <cgroups+bounces-15003-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 20:57:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B72FCB50
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F733052460
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CF3E0224;
	Mon, 23 Mar 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBjORxUq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A72388E7F;
	Mon, 23 Mar 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295742; cv=none; b=fDD6huhKPZQi/aOsdufLRw7Z/rnz5JUzTUReRydYmQu4ikaO0+tUKmMZgUYVJXiMt7xI2Xq7oSjZ78IV4ksFIT5vlYUQKYAqJyrBfpDe0PIIPrBE3qCy4Av/BSWDwyp7SvauQEAvyRKR1g0mckjIoAzPpWGKfgkVnePdI8Ya7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295742; c=relaxed/simple;
	bh=byZQznOIurQHP9alNvuxUOraKKFUxp+VSHGVKRf5ldY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyWCHLR1hcWg0LW15zMEnIRKE2ay/EWT0oseSSJ/0G5WJxWg6yy1cqPy7a94RnI2gNVMhSi2I0C6d+ObEXz90UQtjvpRh4jT/8ePLp2Lwv48O6fNJhVZ6S2GWLp+I8clFzas+G0jAyovoUId0LzlI0Hnl0K1q+rINMs0ZHDeNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBjORxUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC268C4CEF7;
	Mon, 23 Mar 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295741;
	bh=byZQznOIurQHP9alNvuxUOraKKFUxp+VSHGVKRf5ldY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBjORxUqs7aK2nzvWYMIcCGYpMeMYvWZdYd405nXSXNocpK7QtDAiU6aNXNVY5hbX
	 t/8eDjMKYwpN3b9YcykzFpVGsxmR3CapaF7/sO0ZMEehRkDV0C2WLw87Nntm4IQbhd
	 IgsZ1UgDPd4ISz8Ac+G/MNnIuUpkdhuoreeVOtdT1q1TnnyafSF4KEY6uzAoqSNKTm
	 WzbqQHJDOYJoXxADuY5T5Uu1CgNGrccm9Fy1sSs03wYqqsX18tvpxTdOaSFMbqyDoB
	 c33f/g/F6+Rm8D7aH44kRQN++/xsvo0uMrahCrmEEoNyST4f2wRs4N4HGaM7ddOT6b
	 1plEUWOFg3bcA==
Date: Mon, 23 Mar 2026 09:55:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] cgroup: Wait for dying tasks to leave on rmdir
Message-ID: <acGavAFVTfggKIKy@slm.duckdns.org>
References: <20260323035806.724798-1-tj@kernel.org>
 <20260323113252.xsuwQA3z@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323113252.xsuwQA3z@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15003-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 788B72FCB50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Mon, Mar 23, 2026 at 12:32:52PM +0100, Sebastian Andrzej Siewior wrote:
...
> I saw instances on PREEMPT_RT where the above cgroup_is_populated()
> reported true due to cgrp->nr_populated_csets = 1, the following
> iterator returned NULL but in that time do_cgroup_task_dead() saw no
> waiter and continued without a wake_up and then the following schedule()
> hung.

Ah, right, false->true is protected by cgroup_mutex but true->false is only
by css_set_lock. It should check populated again with css_set_lock held and
then do prepare_to_wait().

> There is no serialisation between this wait/ check and latter wake. An
> alternative would be to check and prepare_to_wait() under css_set_lock.

Yeap.

> > +	finish_wait(&cgrp->dying_populated_waitq, &wait);
> > +	mutex_lock(&cgroup_mutex);
> > +	goto retry;
> > +}
> 
> Then I added my RCU patch. This led to a problem already during boot up
> (didn't manage to get to the test suite).

Is that the patch to move cgroup_task_dead() to delayed_put_task_struct()? I
don't think we can delay populated state update till usage count reaches
zero. e.g. bpf_task_acquire() can be used by arbitrary bpf programs and will
pin the usage count indefinitely delaying populated state update. Similar to
delaying the event to free path, you can construct a deadlock scenario too.

> systemd-1 places modprobe-1044 in a cgroup, then destroys the cgroup.
> It hangs in cgroup_drain_dying() because nr_populated_csets is still 1.
> modprobe-1044 is still there in Z so the cgroup removal didn't get there
> yet. That irq_work was quicker than RCU in this case. This can be
> reproduced without RCU by

Isn't this the exact scenario? systemd is the one who should reap and drop
the usage count but it's waiting for rmdir() to finish which can't finish
due to the usage count which hasn't been reapted by systemd? We can't
interlock these two. They have to make progress independently.

> -       irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
> +       schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), HZ);
> 
> So there is always a one second delay. If I give up waiting after 10secs
> then it boots eventually and there are no zombies around. The test_core
> seems to complete…
> 
> Having the irq_work as-is, then the "cgroup_dead()" happens on the HZ
> tick. test_core then complains just with
> | not ok 7 test_cgcore_populated

The test is assuming that waitpid() success guarantees cgroup !populated
event. While before all these changes, that held, it wasn't intentional and
the test just picked up on arbitrary ordering. I'll just remove that
particular test.

Thanks.

-- 
tejun

