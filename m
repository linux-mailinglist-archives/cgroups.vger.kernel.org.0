Return-Path: <cgroups+bounces-15056-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /JAbBYR3xGkWzgQAu9opvQ
	(envelope-from <cgroups+bounces-15056-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 01:02:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B532D82D
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 01:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31BB302EEA6
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF17381C4;
	Thu, 26 Mar 2026 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9/Wx+mV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE640DFBA;
	Thu, 26 Mar 2026 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483327; cv=none; b=lTffMlxdPEpbjxOCXyI5JflhZzBVvJuKvwAAFSe1QOhemv98wAyFX/XjIQZa1fqMuhgolOuipU7Adl/sx6zJzCOwpM4OQx7ulJN4gYwSh8rz6OXjBFI9Xcea2nVXr4IqHr11CreiR1Epz9FeeYOgJWKTNgHDeHOEaswsVrE3Bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483327; c=relaxed/simple;
	bh=3xxVnXVbNEeoSMgDa1a5nGKHxLS0wuYpyW49atelE5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toOk47++x8FLXQh4RtYv/9oz5xrzbJqjC/LcseVvLFCuLnqR2fM/W26FvfIqa26Q2Q2w2lkYl9CmWMW0zdijVcYgyQOBygyl7f82FI0e7txNYZlG5+C7z4h9PAyreTdua/G8mCMK1Oz1JdchYS6gL+OdQEtn6Alwmoys4Bbl0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9/Wx+mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9089C4CEF7;
	Thu, 26 Mar 2026 00:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774483327;
	bh=3xxVnXVbNEeoSMgDa1a5nGKHxLS0wuYpyW49atelE5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9/Wx+mVa3jpWBeu/9tRolQBqtBSNjqUWUAtqfoe98tHKrABo3ph3Cjel449fAouR
	 IqckYRAlH6kmWC6DxlxE6oy4FNcIEtqQhmmhM02zryQkOJ9BgIiS5Wq4CvXbcMSy5D
	 2cIncXlLKakoTSfQliSq15QRLgbjlg+1K9ykKvDFxXEdn+MujmIpHeBZcLf5jtPkT4
	 JDTAqZxZOtfpU5Ytv8m93cjt7UhjCT+Z4qOvsJeQ2eVU5kd5Nu3U7rRcXTeYUdRyRo
	 eVYVWdC3j7KyWuJJ/iLBwBHP2pASvKSJwF+fru2ARXvBScwyHzfFP2ZTy8wQeaI7Vi
	 vojSt75pa/wTg==
Date: Wed, 25 Mar 2026 14:02:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix cgroup_drain_dying()
 testing the wrong condition
Message-ID: <acR3fYVD_blwD93_@slm.duckdns.org>
References: <68d8881fd985a410c0f619f009334c28@kernel.org>
 <20260325180623.EcyNsp2L@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325180623.EcyNsp2L@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15056-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 668B532D82D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 07:06:23PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-25 07:23:48 [-1000], Tejun Heo wrote:
> > cgroup_drain_dying() was using cgroup_is_populated() to test whether there are
> > dying tasks to wait for. cgroup_is_populated() tests nr_populated_csets,
> > nr_populated_domain_children and nr_populated_threaded_children, but
> > cgroup_drain_dying() only needs to care about this cgroup's own tasks - whether
> > there are children is cgroup_destroy_locked()'s concern.
> …
> 
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The only issue I see is if I delay the irq_work callback by a second.
> Other than that, I don't see any problems.

What issue do you see when delaying it by a second? Just things being slowed
down?

Thanks.

-- 
tejun

