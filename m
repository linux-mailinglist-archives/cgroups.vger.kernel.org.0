Return-Path: <cgroups+bounces-9242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65578B28984
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 03:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAC9188DF14
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546D78F3A;
	Sat, 16 Aug 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YJ27kV/4"
X-Original-To: cgroups@vger.kernel.org
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6533EC
	for <cgroups@vger.kernel.org>; Sat, 16 Aug 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306005; cv=none; b=QIccDdBy9Lax+iKnYkwQANp1HAbZuzEdE8r+bZBAXXOC8B5u1/Tp5CY63xGdcAKCjJSYVQfQDFry8piUA0V0lyceyadIcsfLn+MSekk2nobiV+kn3WFvAjvXHvLSlH3OQBZS3ynTNce14mAN/sOTbOf/G5laFEhVH/wIb7QVZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306005; c=relaxed/simple;
	bh=N4iGyZ1bMWNR92uUa/ToVmrqO03ypwUeqH0dCdB3Ol4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvDoELV5w+5foSS0kG8Et2Pr9Y4O3DWNHzBgq/xmoJqrNuL1Yom0HMEnCW1TbfPiLg5+f+xbC6VWudL7yiGHTS8a5+JH1T295jrpZQRiK7+atqYzOwlyITWGgQz5P0H8IxAaldsabtdXpOo15mDfhW+W3A4fVl+WGJvw6PGgKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YJ27kV/4; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755306001;
	bh=NBeRk8adTbnZryQ/MhdKyFpznLfRabUCsyJwqKMNF9A=;
	h=From:Subject:Date:Message-ID;
	b=YJ27kV/4junbsCR2A9x+PV8rZ+nz5d75JhcMebNwTXTFPTHYTM004Q7pHGDZsGMQX
	 YT2UbDexRheIHY34WAwDBWpqTAi1ZKZmwQBwJNt7IqOo91l38PIRGeYQwlKFksWM8S
	 4ZMXlsKNHw6GDkzclPJft9+LQVWaSPFnPvSmDcpY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689FD77B00002AEE; Sat, 16 Aug 2025 08:57:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3162026292108
X-SMAIL-UIID: AA1CD258DAA343CFBC2658F574F06E89-20250816-085734-1
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
Date: Sat, 16 Aug 2025 08:57:21 +0800
Message-ID: <20250816005723.4672-1-hdanton@sina.com>
In-Reply-To: <3f6feb92-0496-416b-bf0c-4391e0d4426d@huaweicloud.com>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com> <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs> <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com> <20250815024020.4579-1-hdanton@sina.com> <20250815100213.4599-1-hdanton@sina.com> <20250815115512.4616-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 08:33:55 +0800 Chen Ridong wrote:
> On 2025/8/15 19:54, Hillf Danton wrote:
> > On Fri, 15 Aug 2025 18:28:53 +0800 Chen Ridong wrote:
> >>
> >> To clarify, when you mentioned "cut max_active off", did you mean setting max_active of
> >> cgroup_destroy_wq to 1?
> >>
> > 	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 0);
> 
> Thank you for the additional clarification.
> 
> While this modification is functional, I’m concerned it might spawn a significant number of cgroup
> destruction tasks—most of which would contend for cgroup_mutex. Could this waste system resources?
> 
No win comes from nothing, so you need to pay $.02 for example at least
for curing the task hung by erasing the root cause.

