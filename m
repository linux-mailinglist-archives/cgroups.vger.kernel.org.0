Return-Path: <cgroups+bounces-13009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD89D07706
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 07:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404B8300C6D1
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047A2E7637;
	Fri,  9 Jan 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="aLSP4NjB"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-37.ptr.blmpb.com (sg-1-37.ptr.blmpb.com [118.26.132.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862332E7635
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941156; cv=none; b=GaUTMPyc44tZgrTrfRstAnp2kb2BUBk6dpmx5fntKrVvSVrm2RgsR2SmTyuHgBiNmNBQFWJWi2j3bv21YESNO8JIbSe2zQu6ebW36hrovbj7cWs8lhO6mq9s84rWNle1K9qf1zWLwO8jHFYfjHyPqwY++cp79EZVBKleB2AQtzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941156; c=relaxed/simple;
	bh=7yD81IKz2KSAMr2J5SfeADQ2pPoLJgprowgK1sfNxqw=;
	h=References:Cc:To:Subject:Message-Id:Content-Type:From:Date:
	 Mime-Version:In-Reply-To; b=JqR6ZuMAvXzThcEGA7FtJHhswcK3MVK7auPfJ+0L6WwMsSwZZY+44Sns8V1No6vh3LDv+HJPOMANsjyTbVgiQT1gZhrOykmvEUgmd7A/Mm1nS2sj8WzHPYng1O/yE0RdWqOKqKBfTqYc524DmVO7q4VROdVWQJ6//aT7rtLg82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=aLSP4NjB; arc=none smtp.client-ip=118.26.132.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767941024;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=7yD81IKz2KSAMr2J5SfeADQ2pPoLJgprowgK1sfNxqw=;
 b=aLSP4NjBx4JzeOad4c+e+hep2ugo4u1Ye6dGeSZ1vK85XJQi1Ff1yAfGampmJ8XgrZjfXS
 kCPeXrfgtnDXZZoK3BFynemTkmCoKxg8dQ/W1wZOsTshU2xVDEOeODEZNh3SxfQG6v7Zl+
 IfnIuvDpx4M+XxRkBWJCzyl3lLQ03BAqfM2VWm/Skm87Le3Ch0nDKWZgbAFa7IKwqPqMUR
 2IbgXw1aPj0F8/CvUkKgQpiYUK/jE2qmHlmdGql9xr6ugvirhfXGX7RDTZrQUtM3tj5OF5
 0jOHsb+J4Pgf7CqsL0H2X98DQsQXmSu7bMbQPNNRWc0VhHU3Ig1pQ24njHoxww==
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com> <20260108014416.3656493-3-zhengqixing@huaweicloud.com> <72dc0ed6-1ba9-46b8-a43f-d11c32e2f341@fnnas.com> <5fdbd368-6d00-4453-8f03-23d17c8c1338@huaweicloud.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Cc: <hch@infradead.org>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>, 
	<tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>, 
	<zhengqixing@huawei.com>, <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 14:43:41 +0800
Content-Language: en-US
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>
Subject: Re: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy() racing with blkg_free_workfn()
Message-Id: <22046287-0a36-45ac-bc17-b41636076552@fnnas.com>
X-Lms-Return-Path: <lba+26960a39e+0193d7+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 9 Jan 2026 14:43:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <5fdbd368-6d00-4453-8f03-23d17c8c1338@huaweicloud.com>

Hi,

=E5=9C=A8 2026/1/9 14:22, Zheng Qixing =E5=86=99=E9=81=93:
> I tried adding blkcg_mutex protection in blkcg_activate_policy() and=20
> blkg_destroy_all() as suggested.
>
> Unfortunately, the UAF still occurs even with proper mutex protection.
>
> The mutex successfully protects the list structure during traversal=20
> won't be added/removed from
>
> q->blkg_list while we hold the lock. However, this doesn't prevent the=20
> same blkg from being released
>
> twice.

I don't understand, what I suggested should actually include your changes i=
n this patch. Can you
show your changes and make sure blkcg_policy_teardown_pds() inside blkcg_ac=
tivate_policy() is
also protected.

--=20
Thansk,
Kuai

