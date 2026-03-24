Return-Path: <cgroups+bounces-15019-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNuDI+5UwmnNbgQAu9opvQ
	(envelope-from <cgroups+bounces-15019-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:10:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE83054FC
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11BCC3060A30
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA33DA7EA;
	Tue, 24 Mar 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+rUDsll";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHoQCy8t"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953A3DA5B2;
	Tue, 24 Mar 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343078; cv=none; b=kqNLNGYu23lrsacNHJZT6kQ98AjN+pZqSrDQniTfHNiePM2I0ksjczW59dk2aCjoYg3vHVSIBN/rBVWyI4yC2LPUJb+fMVgkMVcn644OFXpvsso3Xfow4fXjSr3As5UsXj33+c5R0wFzd95ptS5sIfGLmygbxzeGdoRk4RpYdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343078; c=relaxed/simple;
	bh=QroivoNHSMkCKzx+wsI1sdIIG3jsgnWx8Sx0q3MxzMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlmffSmRnYf/S9s7G8LwPgCMyq1DGCVp6HRDSrDuROI3xnqaZg5g+IXzJXPrGFaZBKqTK0ANxVaw/okwxqPHleaAWc4/CdIbQPp36e5Ww+pgnBP4qXHwGvvTcJMev4zbH+aYuTgPebbr6YOvygb/2IWVjEYTfSSTvKgE12Mb8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+rUDsll; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHoQCy8t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Mar 2026 10:04:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774343070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVz1A9gFVQq6+gKGrjFPgGOO82useKGz1PRe8dPzoi4=;
	b=J+rUDslluhsZt7QATaEhN5mZaE3dsDTabPcg6Hp3eTbvo6BJNrcmwaQVGWYH242tFtKHWj
	wPiszCYQzO4sC+1J1XuWVVEb/lE0Q/6WwVYlzbMVhgjv5fVhqevw/cMW+Ki6lfR+REr5+k
	lCM3v1XybMqQL3lofWL/n1AL78iX/OvRVt9rT2kjgoF0EcYWuxR8LPeg6glTokfdYci1Tu
	T8SuomE6JfFfkwkeNk9GYKIJ0iHIJ/1Jfg4U8V1qDxqeq0hfpH0HnTN+npJCjs7mugsdH2
	u/s3Dp6DkKUZs5Bmp5tZZO+yyNyMCr0lz6VO1Ih7t09c/ZZh9WkSMpkUeOQBWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774343070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVz1A9gFVQq6+gKGrjFPgGOO82useKGz1PRe8dPzoi4=;
	b=kHoQCy8t8a57gsszuCpab6p7/vGlKpDKZkKwT6fkfto8AnhELhyH8flUsO9xER5SRlbdqB
	lZK5zl9mUBBAJWDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH cgroup/for-7.0-fixes] selftests/cgroup: Don't test
 populated synchrony against task exit
Message-ID: <20260324090429.navrA_5v@linutronix.de>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-15019-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6DCE83054FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 10:28:29 [-1000], Tejun Heo wrote:
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

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

