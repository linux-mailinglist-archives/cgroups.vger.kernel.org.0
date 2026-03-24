Return-Path: <cgroups+bounces-15016-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFA5LlpCwmmCagQAu9opvQ
	(envelope-from <cgroups+bounces-15016-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 08:50:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64C30428D
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10D8E301628C
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351143590AE;
	Tue, 24 Mar 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8VLevzQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9F358389;
	Tue, 24 Mar 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338640; cv=none; b=UjGnbiLy3hXBIkFjHNCcNcDHg5zRdlcBG/yGdHChA+oLXPloVWRDTYlZ72aYIyx3EeDVu06PzR40xWCk0h41xlc6wzSisDJ/KhiWQQ76QS1C2nypIvPxiuuUq+fxIHhSWBu7APf1M9YwicAVO7nbOfn30ZLzb3eI1H2CJvW1jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338640; c=relaxed/simple;
	bh=Yri2ClEjU2+0SMqF8PImVQJCXMkFkh+FbB0c9K/U5b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPvIH39S4VgHEEc4PmQN9ijsAt068NPwgmT0p2+pYtdSBOPrqQbNsc6v++Bf89fx3uaoWfGf1G7drM7sRa+t/b8KhVQhmvF8NCVL3iP+yhpsXdlRqPWH6zfIWrUviSot485OMgPZ0CLiK0gbpqUPN/I0XWO0k0QRZA6LTbRzBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8VLevzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19A5C19424;
	Tue, 24 Mar 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338639;
	bh=Yri2ClEjU2+0SMqF8PImVQJCXMkFkh+FbB0c9K/U5b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8VLevzQrNUHLXXVnh/6kWUA+VU1HtY3P7aVBYwGJdoz3yEaltCNAhStneLZTg262
	 kVcPKZibPSDv7ZmCik/iBks5/W68+xxUMOzEhgWmUJpGVvage0Kd6X12aVw8aKx0Ik
	 7go3GjOwIy5Q58vaBAUUxIj17TfMHT7sogmJ711xlmi8pVwarjVnNAtH2x6WrUGB8V
	 9c1LaJQl8S2hiJL+UQi9549ARka4dtV++ULvV4qeRJocHQwAoUFfr338mXqdK1uyC5
	 2I4eDMOeLzNqsPqjstPy/Mi/SFIPmehVMIR+UebapesQ4aWcMB3jPpEVXXxUN+/fof
	 OJ9pDp7iyGjzQ==
Date: Tue, 24 Mar 2026 08:50:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Koutny <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH cgroup/for-7.0-fixes] selftests/cgroup: Don't test
 populated synchrony against task exit
Message-ID: <20260324-deshalb-gemolken-5e28f48cdc9c@brauner>
References: <49dca9aa15c6c46de60f1ba4ef2b25d0@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49dca9aa15c6c46de60f1ba4ef2b25d0@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15016-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B64C30428D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 10:28:29AM -1000, Tejun Heo wrote:
> test_cgcore_populated (test_core) and test_cgkill_{simple,tree,forkbomb}
> (test_kill) check cgroup.events "populated 0" immediately after reaping
> child tasks with waitpid(). This used to work because cgroup_task_exit() in
> do_exit() unlinked tasks from css_sets before exit_notify() woke up
> waitpid().
> 
> d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done
> switching out") moved the unlink to cgroup_task_dead() in
> finish_task_switch(), which runs after exit_notify(). The populated counter
> is now decremented after the parent's waitpid() can return, so there is no
> longer a synchronous ordering guarantee. On PREEMPT_RT, where
> cgroup_task_dead() is further deferred through lazy irq_work, the race
> window is even larger.
> 
> The synchronous populated transition was never part of the cgroup interface
> contract - it was an implementation artifact. Use cg_read_strcmp_wait() which
> retries for up to 1 second, matching what these tests actually need to
> verify: that the cgroup eventually becomes unpopulated after all tasks exit.
> 
> Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: cgroups@vger.kernel.org
> ---

Seems fine to me.

