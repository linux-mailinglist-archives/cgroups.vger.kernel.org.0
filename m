Return-Path: <cgroups+bounces-15312-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHgqAxJx32lWTAAAu9opvQ
	(envelope-from <cgroups+bounces-15312-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 13:05:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C283403962
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12606306EF49
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37E3659F6;
	Wed, 15 Apr 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N4M95Yhv"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D331A9F85;
	Wed, 15 Apr 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251122; cv=none; b=BLCJrnCG5Q9D1Ea1ppCGGlNiupE33BJg7K2KXGUUHitDx1Nb/Yxc4aL0LlHChPAT+7Qvq0Hn4kYT9QP8xwfhb8LyYMtFs/g4npHjdieeIT5+lM7pqPfTOSNbplJGR8CE6b1MI/+7RUMxTOVcsNovvJ64zXKKAqNeCczN8ZDV5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251122; c=relaxed/simple;
	bh=OEARKQBxnn04zkvEzfKGe1qNS9yfLYWPkusw3SDlgrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYStUKTC5yBDmZBplDdmzSV6IHX/POwkMdz3+2E47t+I5P7fke2YnllsVZtBoXb+PMMZ4BvpO12rslf0hoFFYhBkJPMQMvWqIbAa8Ga1LGsujwElcC1xxdeFGdBNz4DmJkvZnUcSgkIJb4NpVxSK3XZHct3i3Ohr/Q76KDLlGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N4M95Yhv; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OE
	ARKQBxnn04zkvEzfKGe1qNS9yfLYWPkusw3SDlgrg=; b=N4M95YhvcQrIaB9dFR
	eyqy1LTaxZB7QB0uFegoouZGDAkKXDT9EM9HMxO793x0vkEdMIkddGaiGO47WKQR
	DMlYpLmsI5OBoalvTV9Awnky5OSjCE/N07pcDmZYoiohcdTe0yqV8OGhCwr+7axj
	iGG6KRB+3g+tbrglMrY6ugYRc=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA39QGdcN9pD65+AA--.81S2;
	Wed, 15 Apr 2026 19:04:01 +0800 (CST)
From: ranxiaokai627@163.com
To: mkoutny@suse.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	shuah@kernel.org,
	tj@kernel.org
Subject: Re: [PATCH 1/2] kselftests: cgroup: update kmem test tolerance for multi-memcg stock
Date: Wed, 15 Apr 2026 11:03:56 +0000
Message-ID: <20260415110356.3546-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <vjhou23d62pvtdqsan2nrlldkwf27qchpfmzf4yoetqn2gdhbj@cfiuqzzotbxf>
References: <vjhou23d62pvtdqsan2nrlldkwf27qchpfmzf4yoetqn2gdhbj@cfiuqzzotbxf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA39QGdcN9pD65+AA--.81S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWUurWDJF4fJr43GrWUCFg_yoWkuFX_uF
	Wjyr1DKw4UKFyxuFZ0yFs3XF12vrWUArn7Xa95tF4xta4Dta1kJrZ5Wryjkw4rGay3GryS
	9ws0q34Yq3ZIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM8n5JUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxQGW4mnfcKGkwgAA3x
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,cmpxchg.org,google.com,kernel.org,kvack.org,linux.dev,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15312-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C283403962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Hello Xiaokai.
>
>On Tue, Apr 14, 2026 at 11:05:23AM +0000, ranxiaokai627@163.com wrote:
>> Fixes: f735eebe55f8 ("memcg: multi-memcg percpu charge cache")
>
>An interesting catch.
>
>> -#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
>> +#define NR_MEMCG_STOCK 7
>> +#define MAX_VMSTAT_ERROR (4096 * 64 * NR_MEMCG_STOCK * get_nprocs())
>
>When you touch this, I think this could be factored into it too:
>
>+#define MAX_VMSTAT_ERROR (sysconf(_SC_PAGESIZE) * 64 * NR_MEMCG_STOCK * get_nprocs())

Thanks for the review, yes, this will improve the test' portability
across architectures with different page sizes.

>And given how much the selftest depends in this implementation
>detail(?), I see that there are other selftests that include directly
>from the tree, I'd suggest also
>#include "../../../../include/linux/memcontrol.h"
>
>and use the constant from there (i.e. move NR_MEMCG_STOCK to there too).
>
>That should make the selftest more flexible, resilient to future changes
>and it'd document ramification of these constants too.

Agreed. Including memcontrol.h ensures the test stays in sync with
kernel changes.

>Thanks,
>Michal


