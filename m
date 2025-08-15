Return-Path: <cgroups+bounces-9213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F91B27FA0
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD352B6506B
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9399288C1A;
	Fri, 15 Aug 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="IsHcJatA"
X-Original-To: cgroups@vger.kernel.org
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC0288520
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258930; cv=none; b=HlxfqJyNkIjeFnQ+E+y2nN1WbZAs5Dx1zM8mIOVt7m3WAXLdWvWL0G0MzSE7CskJwKLGncQe9s+0u97d5HK4e917t576OC2SvwFYi/XHks/ONctMo930jgJXSE1heSXm0wssiknffebKkMVO1w8RZhdAMtHn7aFlYHkNK34aWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258930; c=relaxed/simple;
	bh=1E5k93xlQFw/a7YElgYgYEwo2eNUuSfeU5N1T/2MtNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IouRKSshA1mV+wL/c7kpviQkUOiI4fb0HIL2yzQvk6CT/bVaE7PO4Ee9ZbH/Gl7d3WSuu/vzRCguff/ndn4BWvy0VfA2Y/2izDOzatCkQkxqDx+QI2wZufleSmcCRxuYC8CPxtKA9K6IQLgm0IoYafAdXWRhmQ0e1t5xKSgNVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=IsHcJatA; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755258926;
	bh=xmootnANEIFHDGjwZhNZHyg/E94ZNp9NGGsMzPNJ63s=;
	h=From:Subject:Date:Message-ID;
	b=IsHcJatA6SLlfEpfAbTNkjhOWvGcCK+OBvFQCqET/Wi1/17slqB+bljxItc9lkXK+
	 dcX83/h8doWlPB3xnko/t3ErvE4hqMKsBx9DKmSaF4pwy3sBQ49hDhbIR7cwOmjMJA
	 0OghLOAKukfwQ839+Ro9rT5z4BicXW3Ug2lql8Ys=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 689F202800000EE7; Fri, 15 Aug 2025 19:55:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1853926685298
X-SMAIL-UIID: 7041E6AC461844F5AB537A043B959B4B-20250815-195522-1
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
Date: Fri, 15 Aug 2025 19:54:58 +0800
Message-ID: <20250815115512.4616-1-hdanton@sina.com>
In-Reply-To: <afc95938-0eb5-427b-a2dd-a7eccf54d891@huaweicloud.com>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com> <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs> <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com> <20250815024020.4579-1-hdanton@sina.com> <20250815100213.4599-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 18:28:53 +0800 Chen Ridong wrote:
> 
> To clarify, when you mentioned "cut max_active off", did you mean setting max_active of
> cgroup_destroy_wq to 1?
> 
	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 0);

