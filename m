Return-Path: <cgroups+bounces-9200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE20B27646
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 04:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5F720AA9
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 02:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119B25EFBF;
	Fri, 15 Aug 2025 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="l6LdfeQd"
X-Original-To: cgroups@vger.kernel.org
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55662222CC
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225643; cv=none; b=pTqAh5KummSx+OM+V1w98rTa0MIoTOU9aOed571W96li2FvP2xyXBPOvaWQ4vd2lCedILx+bHa7+tYVTchYG8/pshTTj0XJjbJjXRSwQVZksWZLgsqWUCobv8DKxdsy7xs/8z+JtTBdlc7whoWExcK2Ba+oN/kOjrPUu7n1D5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225643; c=relaxed/simple;
	bh=z1IRg+WLhKJGBRy356mvKTAJlP+WrGpSPP4QB3G8mOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bn8Wp6QBWaL1xRRwR4UXwI6xq9vgnvCPkICZpgqtC0p2OTqNNrZ4QNhbaVMPybsq5TK3pJGLcxJnpcqjZx27QrUhO/KUmkr8JK+Fa9MLRMK27rp/Gi19UCygTte1iDCei8I/Jsot218PcLfxacTkr5KECsBBr2zBK7LU4jtJ4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=l6LdfeQd; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755225639;
	bh=ezsNwu0E2vbhV3eEgDb3rzCyMJNyDOFsU0N5GXqGHoU=;
	h=From:Subject:Date:Message-ID;
	b=l6LdfeQdzrlh5gubJzzfgQOuMmrRfKNkmm0U8Vbgy3rXc9RUQX1mKrDbzb7SZtwLG
	 p6ZDVGObtwes781SJvd1doFUbwIxUVCtMqW5v6bYw/V9WGud0f+GOq9C4BPKr/nyV/
	 zsKmLIxAZ+dRxHbCKB9J4Shwseanf2/YyHFah2bo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 689E9E1C0000525C; Fri, 15 Aug 2025 10:40:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5642376685181
X-SMAIL-UIID: 76075C7646BB40678C19FE2770DE0E95-20250815-104030-1
From: Hillf Danton <hdanton@sina.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root destruction to avoid hung_tasks
Date: Fri, 15 Aug 2025 10:40:18 +0800
Message-ID: <20250815024020.4579-1-hdanton@sina.com>
In-Reply-To: <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com> <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs> <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> > On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
> >> CPU0                            CPU1
> >> mount perf_event                umount net_prio
> >> cgroup1_get_tree                cgroup_kill_sb
> >> rebind_subsystems               // root destruction enqueues
> >> 				// cgroup_destroy_wq
> >> // kill all perf_event css
> >>                                 // one perf_event css A is dying
> >>                                 // css A offline enqueues cgroup_destroy_wq
> >>                                 // root destruction will be executed first
> >>                                 css_free_rwork_fn
> >>                                 cgroup_destroy_root
> >>                                 cgroup_lock_and_drain_offline
> >>                                 // some perf descendants are dying
> >>                                 // cgroup_destroy_wq max_active = 1
> >>                                 // waiting for css A to die
> >>
> >> Problem scenario:
> >> 1. CPU0 mounts perf_event (rebind_subsystems)
> >> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
> >> 3. A dying perf_event CSS gets queued for offline after root destruction
> >> 4. Root destruction waits for offline completion, but offline work is
> >>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> > 
> > What's concerning me is why umount of net_prio hierarhy waits for
> > draining of the default hierachy? (Where you then run into conflict with
> > perf_event that's implicit_on_dfl.)
> > 
/*
 * cgroup destruction makes heavy use of work items and there can be a lot
 * of concurrent destructions.  Use a separate workqueue so that cgroup
 * destruction work items don't end up filling up max_active of system_wq
 * which may lead to deadlock.
 */

If task hung could be reliably reproduced, it is right time to cut
max_active off for cgroup_destroy_wq according to its comment.

