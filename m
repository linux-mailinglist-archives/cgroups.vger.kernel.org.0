Return-Path: <cgroups+bounces-12986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDBD0443C
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 734713035BD9
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3224DFF9;
	Thu,  8 Jan 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="0oMxbA/e"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C12218E91
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888758; cv=none; b=qxArskMmA97rhdMC3hY5MCre87TtaXIujClcS968BUfrAsPG54C/d527Nxszm5SyOxdenNBJWuV9vUqDxKEVcCfKk/xQH4qRPPDzHd9rkC7f3+GA7EJqFjd6GA3tT72RZFStEkpjqw2sjZKU5DjYuDyGwrtjx767nWUX7PaJgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888758; c=relaxed/simple;
	bh=SohaF2/SMnoHVjrTkmr4uq3Mx3bR62uwbaZmAhynnI8=;
	h=To:Date:Message-Id:In-Reply-To:From:Subject:Content-Type:Cc:
	 Mime-Version:References; b=dP6HXZyF+9L3wFWv1oPoU+uy6wCV6yNwo+hePOLnQNtYsmAJ4onJADDXc6P5YH7IqkBezCezws6cfkMnrIUKdPkr3TUnTPxNI2iaEjJlCDA8mslTG8PF3Bu/rVAP8HLKrs8wZ1yfDFa3XAJR0Mc5WHJZmiNDh+rO+7Umc2r5MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=0oMxbA/e; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767888750;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bkP5A+DWSl0+EX6qB6tFi7CpTKd+rQhuRBEv+xFcGek=;
 b=0oMxbA/eKMCuKhF6uUOF9n6uJkQRE2Wcu1/h65OCgzsQV1aCSA/NxE2vR+SKQXAAUksUYN
 frXnY6I6t2kT8QnlvMTBu/bfOBDtHqbm/WMc4yrW1GfFP1GBmhLyGpi10KK9hljB1J7toh
 NiAho8eAor6howwr+0lb838OGq2ijtdpLoG8rah2fyRbFFP6+ouaf+ktfrOlbp1X7qujG7
 W2ApHSarhRQU7VKRzFxPB5i24ODJB3Sabnd5sgoEb649xf5Ekfrb10PGO1mIDNntBSGE4I
 grHr2EUaYDvlHX8N//Vt3yX/8Zyx76JDZPC2kvsJdzkJY+H9jOBy9C5VvYEcWA==
Content-Language: en-US
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
Date: Fri, 9 Jan 2026 00:12:26 +0800
Message-Id: <a81a5d38-4ad8-4b46-98dd-0bca721516ce@fnnas.com>
In-Reply-To: <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into helper
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 00:12:28 +0800
X-Lms-Return-Path: <lba+2695fd76d+e5927c+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, 
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <zhengqixing@huawei.com>, 
	<yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com> <20260108014416.3656493-2-zhengqixing@huaweicloud.com>

=E5=9C=A8 2026/1/8 9:44, Zheng Qixing =E5=86=99=E9=81=93:

> From: Zheng Qixing<zhengqixing@huawei.com>
>
> Move the teardown sequence which offlines and frees per-policy
> blkg_policy_data (pd) into a helper for readability.
>
> No functional change intended.
>
> Signed-off-by: Zheng Qixing<zhengqixing@huawei.com>
> ---
>   block/blk-cgroup.c | 58 +++++++++++++++++++++-------------------------
>   1 file changed, 27 insertions(+), 31 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thansk,
Kuai

