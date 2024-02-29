Return-Path: <cgroups+bounces-1921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CD86CFE6
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F781C22910
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639E86CBF7;
	Thu, 29 Feb 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvb1sr0+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA640878
	for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225676; cv=none; b=WXSRD9ye7aX3OllUPkLuX+skQek+XDL674mNcI1f7QrhiOzWbhlaSEl0eJdmVKwjLlgpJ3DPgL+PRoDIYnpTwXqQ3F0zDdNj66E0zRbMJvSAbHf9nxmnF9TO1dh3YJmLygkPaK7Ji/9dJO4W1+jNJv4nUJ+ruJKuhyf60SMtAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225676; c=relaxed/simple;
	bh=e6vmTGem8oV8nJ/WvMjpV0MJ4Xq6I1PYHVShbuzpde4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HzYbXCfSpZUaPsm1ftPIQHUeqS7EWhrBMhPx/vnoJkiOycTXrE9GIlJhBranNupalVaaiXt6RNdcwQkDggApTuKGkM1BFgqO0+TZVB1uzVQC/lEXAadv92wNK2DiE8My3ymyFSX9dRU3yrdX5Hl3tDCuBBvd4iYWgl75CRxUK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xvb1sr0+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <639b5125-f597-83a7-01dd-d92b5fc53061@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709225672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f8YXqcEgWL1IE93kMEJy4Tz/CTAqPh4sqws3O+ADWu8=;
	b=xvb1sr0+oVb5sFfomf5Js49Ox7RYYU2kscDCU90u/BeBwTYFxm1lWpgm2w4NR+a9U4QllT
	zxCtmtfZROwmqMU0m5R7NlpMyealUcEL6uqnASDN8JV6TkshvFbfenSAwuOe8jFgfsJfiL
	dGpPlWiaHyDpc36BgVXUT4iuM66pj/Q=
Date: Fri, 1 Mar 2024 00:54:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
Subject: Missing S: in the "CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)"
 entry?
To: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Running

# ./scripts/get_maintainer.pl -f block/blk-cgroup.c
Tejun Heo <tj@kernel.org> (unknown:CONTROL GROUP - BLOCK IO CONTROLLER 
(BLKIO))
Josef Bacik <josef@toxicpanda.com> (unknown:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
Jens Axboe <axboe@kernel.dk> (unknown:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
cgroups@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO CONTROLLER 
(BLKIO))
linux-block@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
linux-kernel@vger.kernel.org (open list)

shows "unknown" instead of "maintainer" or "supporter".  Is it
intentional?

