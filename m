Return-Path: <cgroups+bounces-14309-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHndIwuGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14309-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:18:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F161D191EB7
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A4CE305A412
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E52D481F;
	Wed, 25 Feb 2026 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgZbbhrX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BCA26A1B9;
	Wed, 25 Feb 2026 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996500; cv=none; b=THOPun+no+0fgy3ekq5ayFCNzWpnrS8eZJwACIouyS+odys6zg3Up6DKq6lvHxoBk+e6ai0vbpbvdoX9OWasnohbQP3NqAaoEGvumnwDAG41iDlPPF0dwBasTqofqljouSObupDwAHQMOZbZ8HU7JATDiMtYnIBzLVZTsz+e66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996500; c=relaxed/simple;
	bh=6mt4HeESVUyMt1GSw4ih6qH3A1OaTtNDz8ITK5f9vGo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ib0b89Fz7Wh1blM2bLqSOyRIXn4AuVE1uA3EsiLA5kl+jfq7YG9C4XZOGmCr/EfVnTgkDMQkaen8EDICdQQdS+4aHlhuNebpJicmiUjzOHJgLBc8qZ0qQImeorZiX7fiSvS+A0mRr73QDkwyTpbYOdT0iGborV3ogdCJliRtaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgZbbhrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E842AC116D0;
	Wed, 25 Feb 2026 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771996500;
	bh=6mt4HeESVUyMt1GSw4ih6qH3A1OaTtNDz8ITK5f9vGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FgZbbhrXQOvVoo87tK9c1EkD3Pi2e8YMT2xV8JH7Jlshiplm0hKLniekNILBQoJ6B
	 /ugAh681ug5mn3PIsMQ7aA+343ojBGGYhbTxUG18WugY7V2lqR+yC/7a7Y68BQScie
	 sfP1+hj+m59Pc5PDKYAYGJd2yxaodCioAKaJxTghIHbpN7TpuOEWpD/Lkb+GacewQX
	 yQLi2Gz1ZDTLLW/P5G98Hov1754mh2gtMdbtWI6+3bP06ioYdLWRGwFLGoTDF1KuEO
	 ubyYugeuWRsSnBP7xP1SrFr6X7nsxtAzMtP0Cv8KFnUQlHVBUuetH+1nZ9vBErdLXb
	 zOJFXb4syZvyg==
Date: Tue, 24 Feb 2026 19:14:59 -1000
Message-ID: <29c88610558875bf17f9a2f796f4ed29@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.1] sched_ext: Implement cgroup
 sub-scheduler support
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-14309-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F161D191EB7
X-Rspamd-Action: no action

Correctly noting the changes from v1 which I forgot to include in the
cover letter.

v2: Rebased to sched_ext/for-7.1. This patchset depends on the following
    fix which is being sent separately targeting sched_ext/for-7.0-fixes:

      http://lkml.kernel.org/r/20260225050055.1069822-1-tj@kernel.org
      sched_ext: Disable preemption between scx_claim_exit() and kicking
      helper work

    - #6 updated to preserve preempt guard in the rewritten scx_disable().

    - #9: Fixed BTF_ID_FLAGS for scx_bpf_locked_rq - comma between
      KF_IMPLICIT_ARGS and KF_RET_NULL should be bitwise OR.

    - #15: Added NULL check for sch in scx_bypass() to fix NULL deref when
      PM notifier calls scx_bypass() with no scheduler loaded.

    - #29: Fixed scx_fail_parent() call to pass sch instead of parent,
      avoiding NULL deref when disabling a level-1 sub-sched.

v1: http://lkml.kernel.org/r/20260121231140.832332-1-tj@kernel.org

Thanks.

--
tejun

