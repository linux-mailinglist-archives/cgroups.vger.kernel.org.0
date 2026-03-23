Return-Path: <cgroups+bounces-14988-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAvPOOf1wGkwPAQAu9opvQ
	(envelope-from <cgroups+bounces-14988-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:12:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D52EE22D
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6E1530022EA
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E4372661;
	Mon, 23 Mar 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="jQIkYBBB"
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD537105A
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253512; cv=none; b=eGbEwb+OVhLEU8xtnVrOkbytwLESd7to5sFPpzXs01c1vFszKiUiFQQqdioA6UqDR/+BpbnwNhUE+XJy87cG4jpMmK+P9nrSKGdplEwEsO1Z3VnILq4RQLxpXG7IOvWoMMC8zv3uCa6CMVuxy8k/tmlTBcN9HSo4zckMpYg8+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253512; c=relaxed/simple;
	bh=WJiVxrw7J9AlqnRF3oWWQ3s/ds3zTzrClkvFlyz/h6c=;
	h=Cc:From:Content-Type:References:To:In-Reply-To:Date:Mime-Version:
	 Subject:Message-Id; b=A4oCxVOEhcStsfxyvssYtKoslZkfbBulRxZcFiZaYj74YjLZIG+YOJxHSwh7SoHUD8EDRmFRRoXc6khIAv+Lymy+zTZqQNXBdX47WjIAu7HE4ryz9Ru3gfLHsPcxsnM2KIvarOrXszUI5kgGKXTMVojo+8dY18iQ/qzYYJEloKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=jQIkYBBB; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1774253501;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HCCZC00dYiT6r4BTrpR5alHQE+2j6PSOfCJd6bWebMw=;
 b=jQIkYBBBNwF8KqUYC9CyDQZGBohK7nljoBxISj0jG6Q79UGx/mZnHKbaQxhi1Va8oa0E6a
 +ECLlmkt5jWrwh/wDZCFF9Q6J0KZy8plaaxhJPE686/TR8epoWCsB9+ye0Eh1Bkm2aNNMX
 M6uBTa08xqLZBEvk/oPjlX4iZGZI1hSu19wQJmpzfqOTEEtFy5MQ1f7tHnZAZrbvEcWMbX
 x3iULrE1TKA8Kn/YP+DgjO3C9k4SxsbCtk6/iSgT7mSHaXGVUZLx2Zv0DVs9VTPtmqfiOq
 NvR3Alt6vQ6uQrxGspNND8QD+qwdKr3JY+F/8Q1BS2uAyMei948IMHYG7tW5bQ==
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Ming Lei" <ming.lei@redhat.com>, "Nilay Shroff" <nilay@linux.ibm.com>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269c0f5bb+af1db4+vger.kernel.org+yukuai@fnnas.com>
References: <20260304073809.3438679-1-yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.158]) by smtp.feishu.cn with ESMTPS; Mon, 23 Mar 2026 16:11:38 +0800
To: "Tejun Heo" <tj@kernel.org>, "Josef Bacik" <josef@toxicpanda.com>, 
	"Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260304073809.3438679-1-yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2026 16:11:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Subject: Re: [PATCH v3 0/7] blk-cgroup: fix races related to blkg_list iteration
Message-Id: <7075ae6a-0483-4fb6-9e87-e6614a475f13@fnnas.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14988-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: 5B3D52EE22D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Friendly ping ...

Hope we can consider this for 7.1-rc1 merge window.

=E5=9C=A8 2026/3/4 15:38, Yu Kuai =E5=86=99=E9=81=93:
> This series fixes several race conditions related to q->blkg_list iterati=
on
> and improves the locking around blkcg policy activation/deactivation.
>
> Patch 1-2: Protect q->blkg_list iteration with blkcg_mutex in blkg_destro=
y_all()
> and bfq_end_wr_async() to prevent races with blkg_free_workfn().
>
> Patch 3-4: Fix use-after-free and memory leak issues in blkcg_activate_po=
licy()
> by extending blkcg_mutex coverage and skipping dying blkgs.
>
> Patch 5: Refactor policy pd teardown into a helper function.
>
> Patch 6: Restructure blkcg_activate_policy() to allocate pds before freez=
ing
> the queue, avoiding potential deadlocks from percpu allocation. Also fix
> locking order in blkcg_deactivate_policy() to be consistent with
> blkcg_activate_policy() (mutex -> freeze).
>
> Patch 7: Move rq_qos_mutex handling inside rq_qos_add()/rq_qos_del() to
> simplify the locking and eliminate potential deadlocks.
>
> Note: queue_lock is still used in many places to protect queue blkg.
> Future work is to convert it to blkcg_mutex entirely.
>
> Changes v2 -> v3:
> - Patch 2: Wrap mutex_lock/unlock with #ifdef CONFIG_BFQ_GROUP_IOSCHED to
>    fix compile error when CONFIG_BLK_CGROUP is disabled.
> - Patch 6: Fix locking order in blkcg_deactivate_policy() to match
>    blkcg_activate_policy() (mutex -> freeze instead of freeze -> mutex).
> - Patch 7: Remove stale lockdep_assert_held() in iolatency_set_limit().
>
> Changes v1 -> v2:
> - Link: https://lore.kernel.org/all/20260108014416.3656493-1-zhengqixing@=
huaweicloud.com/
>
> Yu Kuai (4):
>    blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
>      blkcg_mutex
>    bfq: protect q->blkg_list iteration in bfq_end_wr_async() with
>      blkcg_mutex
>    blk-cgroup: allocate pds before freezing queue in
>      blkcg_activate_policy()
>    blk-rq-qos: move rq_qos_mutex acquisition inside rq_qos_add/del
>
> Zheng Qixing (3):
>    blk-cgroup: fix race between policy activation and blkg destruction
>    blk-cgroup: skip dying blkg in blkcg_activate_policy()
>    blk-cgroup: factor policy pd teardown loop into helper
>
>   block/bfq-cgroup.c    |   3 +-
>   block/bfq-iosched.c   |   6 ++
>   block/blk-cgroup.c    | 205 ++++++++++++++----------------------------
>   block/blk-cgroup.h    |   2 -
>   block/blk-iocost.c    |  11 +--
>   block/blk-iolatency.c |   5 --
>   block/blk-rq-qos.c    |  31 ++++---
>   block/blk-wbt.c       |   2 -
>   8 files changed, 97 insertions(+), 168 deletions(-)
>
--=20
Thansk,
Kuai

