Return-Path: <cgroups+bounces-14934-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPZ7JWq0vGn32AIAu9opvQ
	(envelope-from <cgroups+bounces-14934-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 03:43:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E12D5366
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B90302836B
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D52DAFA5;
	Fri, 20 Mar 2026 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hgkr4hg7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9D2C027C;
	Fri, 20 Mar 2026 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974630; cv=none; b=hrCiTkpPuTr9qSsuQwPkGtu96ziKTJo4gZv06yETx3ZYF8ahAQshDUOkV8Je8Af0cWa83AZJZrWmEz7Ft9tB9B0Eknk16pgva09l4MdfpMRrVhBtKNF/HCoFzdHm03INk3aH5zkT0ABiF32Fctnq/4D7/YZa5oVGPy91KT64lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974630; c=relaxed/simple;
	bh=IM7odbRo5JmXvV35WSNt2mLDPESwML5Li6T+qlytX5s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nQPA8YiT56h4P4rezfmazWnp7t5ZufgUcHPC71tCH2uedKtOxrDiPOF48lyo/A/jL8kjFVPPdr1oP+njC9DtnEZ4md6gqaZ5AZLigh6yeP9IdtkXfG8tTJ57du4SY2Q/gfcwZ5JK/po2eKHzKUJ1sz7zvL3J0fqmgG8kzJLJcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hgkr4hg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D87C19424;
	Fri, 20 Mar 2026 02:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773974628;
	bh=IM7odbRo5JmXvV35WSNt2mLDPESwML5Li6T+qlytX5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hgkr4hg7zQXTt/YOkRxPkZIHUtK1zTNcywzH1MTqkkREzmi+9td5X05r118VG/gIv
	 EUhIpque6aM/JP1B3c6Vr0hPdX5qI+jqzi3lt2YguscLplbGdsloC37l/N6PfVU0CG
	 3BB+Li1V5rF2Lm7aIiOKKHmYDkcoC8MS2OnOO6CE=
Date: Thu, 19 Mar 2026 19:43:47 -0700
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
Subject: Re: [PATCH 0/7] selftests: memcg: Fix test_memcontrol test failures
 with large page sizes
Message-Id: <20260319194347.1048fc8d737b6e8f9d82663d@linux-foundation.org>
In-Reply-To: <20260319173752.1472864-1-longman@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14934-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux-foundation.org:dkim,linux-foundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 341E12D5366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 13:37:45 -0400 Waiman Long <longman@redhat.com> wrote:

> There are a number of test failures with the running of the
> test_memcontrol selftest on a 128-core arm64 system on kernels with
> 4k/16k/64k page sizes. This patch series makes some minor changes to
> the kernel and the test_memcontrol selftest to address these failures.
> 
> The first kernel patch scales the memcg vmstats flush threshold
> logarithmetically instead of linearly with the total number of CPUs. The
> second kernel patch scale down MEMCG_CHARGE_BATCH with increases in page
> size. These 2 patches help to reduce the discrepancies between the
> reported usage data with the real ones.
> 
> The next 5 test_memcontrol selftest patches adjust the testing code to
> greatly reduce the chance that it will report failure, though some
> occasional failures is still possible.
> 
> To verify the changes, the test_memcontrol selftest was run 100
> times each on a 128-core arm64 system on kernels with 4k/16k/64k
> page sizes.  No failure was observed other than some failures of the
> test_memcg_reclaim test when running on a 16k page size kernel. The
> reclaim_until() call failed because of the unexpected over-reclaim of
> memory. This will need a further look but it happens with the 16k page
> size kernel only and I don't have a production ready kernel config file
> to use in buildinig this 16k page size kernel. The new test_memcontrol
> selftest and kernel were also run on a 96-core x86 system to make sure
> there was no regression.

AI reviewbot asks questions:
	https://sashiko.dev/#/patchset/20260319173752.1472864-1-longman%40redhat.com

