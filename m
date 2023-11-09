Return-Path: <cgroups+bounces-297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEB7E748C
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D14328174D
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44830CE4;
	Thu,  9 Nov 2023 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="cZ/ibDnC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EsAaX7IC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58A1DFD2;
	Thu,  9 Nov 2023 22:48:58 +0000 (UTC)
Received: from a11-78.smtp-out.amazonses.com (a11-78.smtp-out.amazonses.com [54.240.11.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B100270B;
	Thu,  9 Nov 2023 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1699570137;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=DNowovoqUNyWgLnq9TXYc0zwtLagxb8oRoqdHwSh+pY=;
	b=cZ/ibDnCX+StsikroCheBC1n/eOgWRIHC8pXdYkfbcWrzTKF53R+KZ1uw2V73wl/
	G3j1vuSo/F/6pMAMmk0G0zHWC7A77uvQsFGWP6UxjtJURH63VhAxWU5dM0aeg2voSrg
	h4KRNw3rAAceh6usv5KUGW1Qhc3Negqe3SPz8Jgg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1699570137;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=DNowovoqUNyWgLnq9TXYc0zwtLagxb8oRoqdHwSh+pY=;
	b=EsAaX7ICLKVu1kM4o2uHclVGJcN15o4scv9IbAIJP+9WfAJPpfmemlOC0AaLxvVp
	Xm2oDFqiIwNnoJZpNTjP+UZspdlQp/IE6lcd/krk9bbd5poMiGfHiIdMsIP9Pv06s/e
	jZ1LxHgubNUELcTFpDl18lIsmmJwUmP9KP0HZaSw=
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Gregory_Price?= <gourry.memverge@gmail.com>
Cc: 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2E?= =?UTF-8?Q?org?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-mm=40kvack=2E?= =?UTF-8?Q?org?= <linux-mm@kvack.org>, 
	=?UTF-8?Q?cgroups=40vger=2Ekernel=2E?= =?UTF-8?Q?org?= <cgroups@vger.kernel.org>, 
	=?UTF-8?Q?linux-doc=40vger=2Ek?= =?UTF-8?Q?ernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?ying=2Ehuang=40intel=2Ecom?= <ying.huang@intel.com>, 
	=?UTF-8?Q?akpm=40linux-foundation=2Eorg?= <akpm@linux-foundation.org>, 
	=?UTF-8?Q?mhocko=40kernel=2Eorg?= <mhocko@kernel.org>, 
	=?UTF-8?Q?tj=40kernel=2Eorg?= <tj@kernel.org>, 
	=?UTF-8?Q?lizefan=2Ex=40by?= =?UTF-8?Q?tedance=2Ecom?= <lizefan.x@bytedance.com>, 
	=?UTF-8?Q?hannes=40cmpxchg=2Eorg?= <hannes@cmpxchg.org>, 
	=?UTF-8?Q?corbet=40lwn=2Enet?= <corbet@lwn.net>, 
	=?UTF-8?Q?roman=2Egushch?= =?UTF-8?Q?in=40linux=2Edev?= <roman.gushchin@linux.dev>, 
	=?UTF-8?Q?shakeelb=40google=2Ecom?= <shakeelb@google.com>, 
	=?UTF-8?Q?muchun=2Esong=40linux=2Edev?= <muchun.song@linux.dev>, 
	=?UTF-8?Q?Gregory_Price?= <gregory.price@memverge.com>, 
	=?UTF-8?Q?jgroves=40micron=2Ecom?= <jgroves@micron.com>
Date: Thu, 9 Nov 2023 22:48:56 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com> 
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaEqNA+ibc3vlFQhCfYQcHLvgUcQAu6sWO
Thread-Topic: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
X-Wm-Sent-Timestamp: 1699570135
Message-ID: <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.11.09-54.240.11.78

On 23/11/08 07:25PM, Gregory Price wrote:
> This patchset implements weighted interleave and adds a new cgroup
> sysfs entry: cgroup/memory.interleave_weights (excluded from root).
 
<snip>

We at Micron think this capability is really important, and moving it into
cgroups introduces important flexibility that was missing from prior versions
of the patchset.

To me this mainly represents the antidote to having system bios programming
the memory map to be heterogeneously interleaved - which I expect will be
an option, and some customers seem to want it. But that approach will affect
all apps (and also the kernel), and will hide at least the interleaved
numa nodes from Linux' view of the topology. There is a lot not to like
about that approach...

This approach checks all the important boxes: it only applies to apps where
it's enabled, the weighting can vary from one app to another, the
kernel is not affected, and the numa topology is not buried.

I see Michal's comment about cpuset vs. memory, and have no opinion there.

Thumbs up!
John Groves at Micron


