Return-Path: <cgroups+bounces-843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6F806612
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 05:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4086B2123E
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677AEAFD;
	Wed,  6 Dec 2023 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DpW4toAF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2961BC
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 20:18:30 -0800 (PST)
Message-ID: <9c8e728f-059c-4aea-baa5-3335269b573c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701836308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y13f+T7BhwTHa77Avk48M9OCWe3TRld06mMkzVjBDnE=;
	b=DpW4toAFt3/2iWYCAYGFLyK+CpGvvPFp2fkdwZYC1Afj1g65hUqvzN34KhsgIcs0I+udOI
	X7NJKqhIMhtg63ZM06CxIkahXRpfNB5KCPd2cnJvqwOpTE6syLWNRAkhCh2vwJEvF0qQGt
	jVhl+20NtjTtYxXIBRBwFBsBN9/sWCw=
Date: Tue, 5 Dec 2023 20:18:23 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/3] selftests/bpf: Add a new cgroup helper
 open_classid()
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, tj@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org
References: <20231205143725.4224-1-laoar.shao@gmail.com>
 <20231205143725.4224-3-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231205143725.4224-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 9:37 AM, Yafang Shao wrote:
> This new helper allows us to obtain the fd of a net_cls cgroup, which will
> be utilized in the subsequent patch.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


