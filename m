Return-Path: <cgroups+bounces-14453-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPHaNS7koGmunwQAu9opvQ
	(envelope-from <cgroups+bounces-14453-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 01:24:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938B1B135D
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 01:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A255B301461B
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD723AE9B;
	Fri, 27 Feb 2026 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhpl98Fu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982D6BB5B;
	Fri, 27 Feb 2026 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151849; cv=none; b=AhC+HMd9/AQg5CuiHTdtGhC/NTxgkxbQTkxAEKurcXEG73tMugBt3GsjAf0jNrNNBttrWMm6qlaQAbNdVzplyaSFhlg4ww6ycWw07Y51Va/uNCNgJHDM3HMj17Nn3I3YZ3zHR2rgt1FlIxrAxdUI2ygkooxGKdqpEmGeMoaxYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151849; c=relaxed/simple;
	bh=fYwp4H6MZZvXqT9nHx4ALyOysK8KQnhb3bxCGINCOsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeEFdJnmAAJQsoOVJkfH9Cm0Qo9cZUhehd8pJSv2aYt8FgX6MfFqORzJ2ExiHGpJfcaXngNq18Fi+lnQy92DqXeUBvG12sOWHWNqJdFOn6sC+Rj5RkAM+jq+9LDR1NtW831U0XeTDbwFWbTV1uOe7FQCqzdDzt29BZQ1EzpCDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhpl98Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B5C116C6;
	Fri, 27 Feb 2026 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151849;
	bh=fYwp4H6MZZvXqT9nHx4ALyOysK8KQnhb3bxCGINCOsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhpl98FuaQh0duTTyS/EnSNt8MlCHzX41pBZJpwol1vQ97QQM0uCzFB2kB6p6+0+U
	 XaDuUYdqPbHIV5i2gJIh4Z8lmjK62h/i1h6qLtSpFCNLGF2ZPwAHyEz15dV/gn23oS
	 /QA1Xy1SYBL6PnwjeWoy3jyVKeneg9oiZzkqh3CxgBxd18qPvhtxRe8eM/VBtTklA0
	 lJyR7pL/Rsl2agMYVphHfUHsewgZv+cZ2j+RG2SLwyysL+ZftIATDnUiZb5H2EJeUT
	 uFgrQC3ilKn7iZVGI4fE2ztLXoYi6AVlFlRJfYRI5Kjy4D6L8RNZ1GcK5AZCLrR2Wi
	 YMG79qMk8rCQg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 00/32] Eliminate Dying Memory Cgroup
Date: Thu, 26 Feb 2026 16:24:05 -0800
Message-ID: <20260227002406.82611-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225135706.28a93fd5817e0939387275b6@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,cmpxchg.org,google.com,suse.com,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14453-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 7938B1B135D
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 13:57:06 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 25 Feb 2026 15:48:33 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> > This patchset is intended to transfer the LRU pages to the object cgroup
> > without holding a reference to the original memory cgroup in order to
> > address the issue of the dying memory cgroup. A consensus has already been
> > reached regarding this approach recently [1].
> 
> Thanks, I've added this to mm.git's mm-new branch.

Great.  I found the commit message on mm-new lacks the conventional "This patch
(of X):" line, though.  Andrew, could you please add that line?


Thanks,
SJ

[...]

