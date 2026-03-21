Return-Path: <cgroups+bounces-14975-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OAoJVnxvWlkEAMAu9opvQ
	(envelope-from <cgroups+bounces-14975-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 02:16:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B842E2C1A
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 02:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A153302299C
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61D25D53B;
	Sat, 21 Mar 2026 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zP5Pl6mI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6931632E7;
	Sat, 21 Mar 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055766; cv=none; b=iz65zjwGhWp7t3fxuTmpJoN01qRMz7N43Tnz29U6z4cAof4Au0FprJXR66CuLUo+YI59tzwGfKgYjjsj84x7KFrqY0sK2H2WAc6lCVQFgDl837bxKxUFF2oauzqXHktRH43LTdtiz8DvsmbL8caGs5ONFEzMRoriihuAzFtUvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055766; c=relaxed/simple;
	bh=CjNrAlHfSI/kjoViNVqQpDkjW1bNshpQDZf8Glk2/PQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tn9P29u5LlxZPKx6AZ02PCHPKVfBhspjzv5mUEdzDRPN5z67oDDY+3z6nYzOyM3wgMrfUkcc8meuA0gL3CNuLlRboOgqwkNTxAmv/kzyYk4IWSH88fQ/i96BD/zDtCSkJFEeNh30qU9040LT9h/x/r7/MuetoSOMSNWE/w2AuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zP5Pl6mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A722CC4CEF7;
	Sat, 21 Mar 2026 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774055766;
	bh=CjNrAlHfSI/kjoViNVqQpDkjW1bNshpQDZf8Glk2/PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zP5Pl6mIQtnUFVdxCSnS62RGX/oVqA081EVfgKz33z6aMaUO3qa7SHUZ9Uw++glBL
	 IvuVsVl55hD486VsU/shY7mEFWYXXGmUJ3dVBCZpwouLr1CDX5HvAsO2cg28Vw9uvG
	 PhGvz77Gobd/bpfu3lkArjYxXuWmB4pkswP1eRDA=
Date: Fri, 20 Mar 2026 18:16:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Tejun Heo
 <tj@kernel.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Shuah
 Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>, Sebastian Chlad
 <sebastianchlad@gmail.com>, Guopeng Zhang <zhangguopeng@kylinos.cn>, Li
 Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 0/7] selftests: memcg: Fix test_memcontrol test
 failures with large page sizes
Message-Id: <20260320181605.206f5453d2bdac49ff6b4742@linux-foundation.org>
In-Reply-To: <20260320204241.1613861-1-longman@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14975-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: 06B842E2C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 16:42:34 -0400 Waiman Long <longman@redhat.com> wrote:

> There are a number of test failures with the running of the
> test_memcontrol selftest on a 128-core arm64 system on kernels with
> 4k/16k/64k page sizes. This patch series makes some minor changes to
> the kernel and the test_memcontrol selftest to address these failures.
> 
> The first kernel patch scales the memcg vmstats flush threshold
> with int_sqrt() instead of linearly with the total number of CPUs. The
> second kernel patch scale down MEMCG_CHARGE_BATCH with increases in page
> size. These 2 patches help to reduce the discrepancies between the
> reported usage data with the real ones.
> 
> The next 5 test_memcontrol selftest patches adjust the testing code to
> greatly reduce the chance that it will report failure, though some
> occasional failures is still possible.

The AI review is up: https://sashiko.dev/#/patchset/20260320204241.1613861-1-longman@redhat.com

