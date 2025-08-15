Return-Path: <cgroups+bounces-9210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F653B27DEB
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C07A02C62
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE62FF15F;
	Fri, 15 Aug 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YHpNbwYz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1B2FE077
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252160; cv=none; b=iFM+iI+7c8NwRCXCd/bDvsFyuskPRrYKYOKXPc0MAJNd6rWkD8rUyo9hVmz5CGHaCMjr2xywx33XE9YDBu3V0Cii1PxqM9CN/Fv+wq95VKhaXgRDbtoYuhNFqObimyb/tOsv1cqgPRmdDmFoccWz1j3uxHWRiYOLjErIeqaFGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252160; c=relaxed/simple;
	bh=VoXVs13GDRd4xdBtQd4TpGiWCAwaVymoNAOqTKN1NcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4AdzsEfBR3ufT0767qIGD2P6p7nFh/cRJS9fLI8huIpeCkurZ09lufxHRLJxAUmHQOQbCSguBZ7GA5h0Iqecw5GTeWMU7lWk4zZaOPDOMNUKuY/bttf5WOo+Ux1gut7UyQjxcr79tBMbr34mlx6jiVYxoMgnoIrWBwAtzMNsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YHpNbwYz; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755252153;
	bh=+iYfE5eplM8rdft956VQZNIhMkMTmyg2e+/I5gVDuNk=;
	h=From:Subject:Date:Message-ID;
	b=YHpNbwYzqxDBNRFuzE3egnMgHNsRlaYCYMKikbSaImiGl9ZmrnUElI23xjsOoBAyC
	 J03c6piLiOxbxjE39Ah7BlOMBehTwWDvlS4bORFSlH4Q+/5AcW4ixZLWAJxsiJi0gR
	 FLW61S0U1JRo8D1yIYPC40zVoT1Y1pWUYOSXAK+A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689F05AE00001724; Fri, 15 Aug 2025 18:02:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6588226292026
X-SMAIL-UIID: 1A812D2436984CDEA8928075789959B3-20250815-180224-1
From: Hillf Danton <hdanton@sina.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal Koutny <mkoutny@suse.com>,
	tj@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root destruction to avoid hung_tasks
Date: Fri, 15 Aug 2025 18:02:07 +0800
Message-ID: <20250815100213.4599-1-hdanton@sina.com>
In-Reply-To: <dd1418f9-93d0-45c9-bcc2-d67f48d050f6@huaweicloud.com>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com> <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs> <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com> <20250815024020.4579-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 15:29:56 +0800 Chen Ridong wrote:
>On 2025/8/15 10:40, Hillf Danton wrote:
>> On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>> CPU0                            CPU1
>>>>> mount perf_event                umount net_prio
>>>>> cgroup1_get_tree                cgroup_kill_sb
>>>>> rebind_subsystems               // root destruction enqueues
>>>>> 				// cgroup_destroy_wq
>>>>> // kill all perf_event css
>>>>>                                 // one perf_event css A is dying
>>>>>                                 // css A offline enqueues cgroup_destroy_wq
>>>>>                                 // root destruction will be executed first
>>>>>                                 css_free_rwork_fn
>>>>>                                 cgroup_destroy_root
>>>>>                                 cgroup_lock_and_drain_offline
>>>>>                                 // some perf descendants are dying
>>>>>                                 // cgroup_destroy_wq max_active = 1
>>>>>                                 // waiting for css A to die
>>>>>
>>>>> Problem scenario:
>>>>> 1. CPU0 mounts perf_event (rebind_subsystems)
>>>>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>>>>> 3. A dying perf_event CSS gets queued for offline after root destruction
>>>>> 4. Root destruction waits for offline completion, but offline work is
>>>>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
>>>>
>>>> What's concerning me is why umount of net_prio hierarhy waits for
>>>> draining of the default hierachy? (Where you then run into conflict with
>>>> perf_event that's implicit_on_dfl.)
>>>>
>> /*
>>  * cgroup destruction makes heavy use of work items and there can be a lot
>>  * of concurrent destructions.  Use a separate workqueue so that cgroup
>>  * destruction work items don't end up filling up max_active of system_wq
>>  * which may lead to deadlock.
>>  */
>> 
>> If task hung could be reliably reproduced, it is right time to cut
>> max_active off for cgroup_destroy_wq according to its comment.
>
>Hi Danton,
>
>Thank you for your feedback.
>
>While modifying max_active could be a viable solution, I’m unsure whether it might introduce other
>side effects. Instead, I’ve proposed an alternative approach in v3 of the patch, which I believe
>addresses the issue more comprehensively.
>
Given your reproducer [1], it is simple to test with max_active cut.

I do not think v3 is a correct fix frankly because it leaves the root cause
intact. Nor is it cgroup specific even given high concurrency in destruction.

[1] https://lore.kernel.org/lkml/39e05402-40c7-4631-a87b-8e3747ceddc6@huaweicloud.com/

